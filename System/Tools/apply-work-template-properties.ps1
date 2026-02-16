$ErrorActionPreference = "Stop"

function Get-Newline {
  param([string]$Text)
  if ($Text -match "\r\n") { return "`r`n" }
  return "`n"
}

function Split-Lines {
  param([string]$Text)
  # Splits on CRLF or LF, preserving content without line terminators.
  return [regex]::Split($Text, "\r\n|\n", [System.Text.RegularExpressions.RegexOptions]::None)
}

function Join-Lines {
  param(
    [string[]]$Lines,
    [string]$Newline
  )
  return ($Lines -join $Newline)
}

function Find-FrontmatterEndIndex {
  param([string[]]$Lines)
  if ($Lines.Length -lt 2) { return -1 }
  if ($Lines[0].Trim() -ne "---") { return -1 }
  for ($i = 1; $i -lt $Lines.Length; $i++) {
    if ($Lines[$i].Trim() -eq "---") { return $i }
  }
  return -1
}

function Parse-FrontmatterKeyIndices {
  param([string[]]$FrontmatterLines)
  $indices = @{}
  for ($i = 0; $i -lt $FrontmatterLines.Length; $i++) {
    $line = $FrontmatterLines[$i]
    if ($line -match "^\s*([A-Za-z0-9_ -]+):") {
      $key = $Matches[1].Trim()
      if (-not $indices.ContainsKey($key)) {
        $indices[$key] = $i
      }
    }
  }
  return $indices
}

function Get-ListBlock {
  param(
    [string[]]$Lines,
    [int]$KeyLineIndex
  )

  $items = New-Object System.Collections.Generic.List[string]
  $start = $KeyLineIndex + 1
  $end = $start - 1

  for ($i = $start; $i -lt $Lines.Length; $i++) {
    $l = $Lines[$i]
    if ($l -match "^\s*-\s+") {
      $items.Add(($l -replace "^\s*-\s+", ""))
      $end = $i
      continue
    }
    # stop when we hit a non-list line (including next key)
    break
  }

  return [pscustomobject]@{
    Items = $items
    StartIndex = $start
    EndIndex = $end
  }
}

function Normalize-QuotedWikiLink {
  param([string]$Value)
  $v = $Value.Trim()
  if ($v -match '^"(.*)"$') { $v = $Matches[1] }
  if ($v -match "^\[\[.*\]\]$") {
    return '"' + $v + '"'
  }
  return $Value
}

function Dedupe-PreserveOrder {
  param([string[]]$Items)
  $seen = New-Object "System.Collections.Generic.HashSet[string]"
  $out = New-Object System.Collections.Generic.List[string]
  if ($null -eq $Items) { return $out }
  foreach ($item in $Items) {
    $k = $item.Trim()
    if ($seen.Add($k)) { $out.Add($item) }
  }
  return $out
}

function Ensure-WorkTemplateProps {
  param(
    [string]$Path,
    [string]$Text
  )

  $newline = Get-Newline -Text $Text
  $lines = Split-Lines -Text $Text

  $endIndex = Find-FrontmatterEndIndex -Lines $lines
  $changed = $false

  if ($endIndex -lt 0) {
    $created = (Get-Item -LiteralPath $Path).LastWriteTime.ToString("yyyy-MM-ddTHH:mm")
    $newFrontmatter = @(
      "---",
      "categories:",
      '  - "[[Work]]"',
      "created: $created",
      "product:",
      "component:",
      "tags: []",
      "---",
      ""
    )
    $lines = $newFrontmatter + $lines
    $changed = $true
    return [pscustomobject]@{ Changed = $changed; Text = (Join-Lines -Lines $lines -Newline $newline) }
  }

  $frontmatter = @()
  if ($endIndex -gt 1) { $frontmatter = $lines[1..($endIndex - 1)] }

  $body = @()
  if ($endIndex + 1 -le $lines.Length - 1) { $body = $lines[($endIndex + 1)..($lines.Length - 1)] }

  $managedKeys = @("categories", "created", "product", "component", "tags")

  # Extract first occurrence blocks of managed keys, and keep all other lines as-is.
  $blocks = @{}
  $other = New-Object System.Collections.Generic.List[string]
  $hadDuplicateManagedKey = $false

  for ($i = 0; $i -lt $frontmatter.Length; $i++) {
    $line = $frontmatter[$i]
    $m = [regex]::Match($line, '^\s*([A-Za-z0-9_ -]+):')
    if ($m.Success) {
      $key = $m.Groups[1].Value.Trim()
      if ($managedKeys -contains $key) {
        if (-not $blocks.ContainsKey($key)) {
          $block = New-Object System.Collections.Generic.List[string]
          $block.Add($line)
          while (($i + 1) -lt $frontmatter.Length -and ($frontmatter[$i + 1] -match '^\s')) {
            $i++
            $block.Add($frontmatter[$i])
          }
          $blocks[$key] = $block
        } else {
          $hadDuplicateManagedKey = $true
          # Skip duplicate block (consume its indented continuation lines too).
          while (($i + 1) -lt $frontmatter.Length -and ($frontmatter[$i + 1] -match '^\s')) { $i++ }
        }
        continue
      }
    }
    $other.Add($line)
  }
  if ($hadDuplicateManagedKey) { $changed = $true }

  # categories
  $catItems = New-Object System.Collections.Generic.List[string]
  if ($blocks.ContainsKey("categories")) {
    foreach ($l in $blocks["categories"] | Select-Object -Skip 1) {
      if ($l -match '^\s*-\s*(.+)\s*$') {
        $catItems.Add((Normalize-QuotedWikiLink -Value $Matches[1]).Trim())
      }
    }
  }
  $work = '"[[Work]]"'
  if (-not ($catItems | Where-Object { $_.Trim() -eq $work })) {
    $catItems.Add($work)
    $changed = $true
  }
  $catDeduped = Dedupe-PreserveOrder -Items ($catItems.ToArray())
  $catLines = New-Object System.Collections.Generic.List[string]
  $catLines.Add("categories:")
  foreach ($c in $catDeduped) { $catLines.Add("  - $c") }
  if (-not $blocks.ContainsKey("categories")) { $changed = $true }

  # created
  $createdLine = $null
  if ($blocks.ContainsKey("created")) {
    $createdLine = $blocks["created"][0]
  }
  if ([string]::IsNullOrWhiteSpace($createdLine)) {
    $createdValue = (Get-Item -LiteralPath $Path).LastWriteTime.ToString("yyyy-MM-ddTHH:mm")
    $createdLine = "created: $createdValue"
    $changed = $true
  }

  # product/component: keep existing block if present, else add blank scalar key
  $productLines = New-Object System.Collections.Generic.List[string]
  if ($blocks.ContainsKey("product")) { foreach ($l in $blocks["product"]) { $productLines.Add($l) } }
  else { $productLines.Add("product:"); $changed = $true }

  $componentLines = New-Object System.Collections.Generic.List[string]
  if ($blocks.ContainsKey("component")) { foreach ($l in $blocks["component"]) { $componentLines.Add($l) } }
  else { $componentLines.Add("component:"); $changed = $true }

  # tags
  $tagsLines = New-Object System.Collections.Generic.List[string]
  if ($blocks.ContainsKey("tags")) {
    $first = $blocks["tags"][0]
    if ($first -match "^\s*tags:\s*\\[\\s*\\]\s*$") {
      $tagsLines.Add("tags: []")
    } else {
      $tagItems = New-Object System.Collections.Generic.List[string]
      foreach ($l in $blocks["tags"] | Select-Object -Skip 1) {
        if ($l -match '^\s*-\s*(.+)\s*$') { $tagItems.Add($Matches[1].Trim()) }
      }
      $tagDeduped = Dedupe-PreserveOrder -Items ($tagItems.ToArray())
      if ($tagDeduped.Count -eq 0) {
        $tagsLines.Add("tags: []")
        if (-not ($first -match "^\s*tags:\s*\\[\\s*\\]\s*$")) { $changed = $true }
      } else {
        $tagsLines.Add("tags:")
        foreach ($t in $tagDeduped) { $tagsLines.Add("  - $t") }
        # Detect dedupe changes
        $originalTagLines = @($blocks["tags"] | Select-Object -Skip 1)
        $newTagLines = @($tagsLines | Select-Object -Skip 1)
        if ($originalTagLines.Length -ne $newTagLines.Length) { $changed = $true }
        elseif ((@($originalTagLines) -join "`n") -ne (@($newTagLines) -join "`n")) { $changed = $true }
      }
    }
  } else {
    $tagsLines.Add("tags: []")
    $changed = $true
  }

  # Detect category normalization changes
  if ($blocks.ContainsKey("categories")) {
    $originalCatLines = @($blocks["categories"] | Select-Object -Skip 1)
    $newCatLines = @($catLines | Select-Object -Skip 1)
    if ($originalCatLines.Length -ne $newCatLines.Length) { $changed = $true }
    elseif ((@($originalCatLines) -join "`n") -ne (@($newCatLines) -join "`n")) { $changed = $true }
  }

  if (-not $changed) {
    return [pscustomobject]@{ Changed = $false; Text = $Text }
  }

  $newFrontmatter = @()
  $newFrontmatter += $catLines.ToArray()
  $newFrontmatter += @($createdLine)
  $newFrontmatter += $productLines.ToArray()
  $newFrontmatter += $componentLines.ToArray()
  $newFrontmatter += $tagsLines.ToArray()
  if ($other.Count -gt 0) { $newFrontmatter += $other.ToArray() }

  $newText = Join-Lines -Lines (@("---") + @($newFrontmatter) + @("---") + @($body)) -Newline $newline
  return [pscustomobject]@{ Changed = $true; Text = $newText }
}

$roots = @(
  "Notes/Auth",
  "Notes/Engineer",
  "Notes/Intelligen"
)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$stats = [ordered]@{
  scanned = 0
  changed = 0
  skipped = 0
  no_frontmatter_added = 0
}

foreach ($root in $roots) {
  if (-not (Test-Path -LiteralPath $root)) { continue }
  Get-ChildItem -Path $root -Recurse -File -Filter *.md | ForEach-Object {
    $stats.scanned++
    $path = $_.FullName
    try {
      $text = [System.IO.File]::ReadAllText($path)
      $hadFrontmatter = ($text -match "^(?s)---\\s*\\r?\\n.*?\\r?\\n---\\s*\\r?\\n")
      $res = Ensure-WorkTemplateProps -Path $path -Text $text
      if ($res.Changed) {
        [System.IO.File]::WriteAllText($path, $res.Text, $utf8NoBom)
        $stats.changed++
        if (-not $hadFrontmatter) { $stats.no_frontmatter_added++ }
      }
    } catch {
      $stats.skipped++
      if ($stats.skipped -le 8) {
        "SKIP: $path :: $($_.Exception.Message)"
      }
    }
  }
}

$stats.GetEnumerator() | ForEach-Object { "{0}={1}" -f $_.Key, $_.Value }
