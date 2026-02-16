param(
  [Parameter(Mandatory = $false)]
  [string]$Root = "Notes",

  [Parameter(Mandatory = $false)]
  [switch]$Apply,

  [Parameter(Mandatory = $false)]
  [string]$ReportPath = "Tools/ensure-created.report.jsonl"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-Newline {
  param(
    [Parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string]$Text
  )
  if ($Text.Contains("`r`n")) { return "`r`n" }
  return "`n"
}

function Format-DateOnly {
  param([Parameter(Mandatory = $true)][datetime]$Date)
  return $Date.ToString("yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
}

function Try-ParseCreatedValue {
  param(
    [Parameter(Mandatory = $true)][string]$Value,
    [ref]$Parsed
  )

  $v = $Value.Trim()
  if ($v.StartsWith('"') -and $v.EndsWith('"') -and $v.Length -ge 2) { $v = $v.Substring(1, $v.Length - 2).Trim() }
  if ($v.StartsWith("'") -and $v.EndsWith("'") -and $v.Length -ge 2) { $v = $v.Substring(1, $v.Length - 2).Trim() }
  if ([string]::IsNullOrWhiteSpace($v)) { return $false }

  $styles = [System.Globalization.DateTimeStyles]::AssumeLocal
  $inv = [System.Globalization.CultureInfo]::InvariantCulture

  foreach ($fmt in @(
    "yyyy-MM-dd",
    "yyyy-MM-ddTHH:mm",
    "yyyy-MM-ddTHH:mm:ss",
    "yyyy-MM-dd HH:mm",
    "yyyy-MM-dd HH:mm:ss",
    "yyyy/MM/dd",
    "dd/MM/yyyy",
    "d/M/yyyy",
    "MM/dd/yyyy",
    "M/d/yyyy"
  )) {
    $dto = [datetimeoffset]::MinValue
    if ([datetimeoffset]::TryParseExact($v, $fmt, $inv, $styles, [ref]$dto)) {
      $Parsed.Value = $dto
      return $true
    }
  }

  $dto2 = [datetimeoffset]::MinValue
  if ([datetimeoffset]::TryParse($v, $inv, $styles, [ref]$dto2)) {
    $Parsed.Value = $dto2
    return $true
  }

  return $false
}

function Split-TopLevelYamlSegments {
  param(
    [Parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string]$FrontmatterText
  )

  $nl = Get-Newline -Text $FrontmatterText
  $lines = $FrontmatterText -split "\r?\n", -1

  $order = New-Object System.Collections.Generic.List[string]
  $segments = @{}

  $currentKey = $null
  $currentLines = New-Object System.Collections.Generic.List[string]

  $flush = {
    if ($null -ne $currentKey) {
      $segments[$currentKey] = ($currentLines -join $nl).TrimEnd("`r","`n")
    }
  }

  foreach ($line in $lines) {
    if ($line -match '^(?<key>[A-Za-z0-9_.-]+):(?:\s|$)') {
      & $flush
      $currentKey = $Matches["key"]
      if (-not $segments.ContainsKey($currentKey)) { $order.Add($currentKey) }
      $currentLines = New-Object System.Collections.Generic.List[string]
      $currentLines.Add($line)
      continue
    }
    if ($null -eq $currentKey) {
      continue
    }
    $currentLines.Add($line)
  }

  & $flush
  return [pscustomobject]@{ Order = $order; Segments = $segments; Newline = $nl }
}

function Merge-Frontmatters {
  param(
    [Parameter(Mandatory = $true)][string]$Fm1,
    [Parameter(Mandatory = $true)][string]$Fm2
  )

  $a = Split-TopLevelYamlSegments -FrontmatterText $Fm1
  $b = Split-TopLevelYamlSegments -FrontmatterText $Fm2
  $nl = $a.Newline

  $finalOrder = New-Object System.Collections.Generic.List[string]
  $finalSegments = @{}

  foreach ($k in $a.Order) {
    if (-not $b.Segments.ContainsKey($k)) {
      $finalOrder.Add($k)
      $finalSegments[$k] = $a.Segments[$k]
    }
  }

  foreach ($k in $b.Order) {
    $finalOrder.Add($k)
    $finalSegments[$k] = $b.Segments[$k]
  }

  $parts = New-Object System.Collections.Generic.List[string]
  foreach ($k in $finalOrder) {
    $parts.Add($finalSegments[$k])
  }

  return ($parts -join $nl).TrimEnd("`r","`n")
}

function Extract-StrictFrontmatter {
  param(
    [Parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string]$Text
  )

  $bom = ""
  $t = $Text
  if ($t.Length -gt 0 -and $t[0] -eq [char]0xFEFF) {
    $bom = [string][char]0xFEFF
    $t = $t.Substring(1)
  }

  $m = [regex]::Match($t, "\A---\s*(\r?\n)(?<fm>.*?)(\r?\n)---\s*(\r?\n)?", "Singleline")
  if (-not $m.Success) {
    return [pscustomobject]@{ HasFrontmatter = $false; Bom = $bom; Frontmatter = ""; Rest = $Text }
  }

  $endIndex = $m.Index + $m.Length
  $fm = $m.Groups["fm"].Value.TrimEnd("`r","`n")
  $rest = $t.Substring($endIndex)

  return [pscustomobject]@{ HasFrontmatter = $true; Bom = $bom; Frontmatter = $fm; Rest = $rest }
}

function Extract-LooseFrontmatterAtStart {
  param(
    [Parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string]$TextAfterStrictFrontmatter
  )

  $m = [regex]::Match(
    $TextAfterStrictFrontmatter,
    "\A\s*[^\r\n]*---\s*(\r?\n)(?<fm>.*?)(\r?\n)---\s*(\r?\n)?",
    "Singleline"
  )
  if (-not $m.Success) { return $null }

  $fm = $m.Groups["fm"].Value.TrimEnd("`r","`n")
  $rest = $TextAfterStrictFrontmatter.Substring($m.Index + $m.Length)

  # Heuristic: treat as frontmatter only if it looks like YAML (has at least one top-level key)
  if (-not ($fm -match '(?m)^[A-Za-z0-9_.-]+:\s*')) { return $null }

  return [pscustomobject]@{ Frontmatter = $fm; Rest = $rest; MatchedText = $m.Value }
}

function Ensure-CreatedInFrontmatter {
  param(
    [Parameter(Mandatory = $true)][string]$Frontmatter,
    [Parameter(Mandatory = $true)][datetime]$FallbackDate,
    [Parameter(Mandatory = $true)][datetime]$Now
  )

  $nl = Get-Newline -Text $Frontmatter
  $segmentsObj = Split-TopLevelYamlSegments -FrontmatterText $Frontmatter
  $order = $segmentsObj.Order
  $segments = $segmentsObj.Segments

  $fallbackValue = Format-DateOnly -Date $FallbackDate
  $changed = $false
  $reason = $null

  if (-not $segments.ContainsKey("created")) {
    $insertIndex = $order.Count
    for ($i = 0; $i -lt $order.Count; $i++) {
      if ($order[$i] -eq "tags") { $insertIndex = $i; break }
    }
    $order.Insert($insertIndex, "created")
    $segments["created"] = "created: $fallbackValue"
    $changed = $true
    $reason = "missing"
  }
  else {
    $createdLine = ($segments["created"] -split "\r?\n", -1 | Select-Object -First 1)
    $value = ($createdLine -replace '^created:\s*', '').Trim()

    $parsed = [datetimeoffset]::MinValue
    $ok = Try-ParseCreatedValue -Value $value -Parsed ([ref]$parsed)
    $isFuture = $false
    if ($ok) {
      $d = $parsed.DateTime
      if ($d -gt $Now.AddDays(1)) { $isFuture = $true }
      if ($d.Year -lt 1990 -or $d.Year -gt 2100) { $ok = $false }
    }

    if (-not $ok -or $isFuture) {
      $segments["created"] = "created: $fallbackValue"
      $changed = $true
      if ($isFuture) { $reason = "future" } else { $reason = "invalid" }
    }
  }

  $parts = New-Object System.Collections.Generic.List[string]
  foreach ($k in $order) {
    $parts.Add($segments[$k])
  }

  return [pscustomobject]@{
    Frontmatter = ($parts -join $nl).TrimEnd("`r","`n")
    Changed = $changed
    Reason = $reason
  }
}

function Write-Utf8NoBom {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Text
  )
  $enc = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Text, $enc)
}

$now = Get-Date

if (Test-Path -LiteralPath $ReportPath) {
  Set-Content -LiteralPath $ReportPath -Value "" -NoNewline
}

$files = Get-ChildItem -Recurse -File -Path $Root -Filter *.md

$stats = [ordered]@{
  total = 0
  updated = 0
  added_created = 0
  fixed_created = 0
  merged_frontmatter = 0
  added_frontmatter = 0
}

foreach ($f in $files) {
  $stats.total++

  $text = [System.IO.File]::ReadAllText($f.FullName)
  $nl = Get-Newline -Text $text
  $original = $text

  $action = New-Object System.Collections.Generic.List[string]

  $creationDate = (Get-Item -LiteralPath $f.FullName).CreationTime

  $strict = Extract-StrictFrontmatter -Text $text
  $bom = $strict.Bom

  if (-not $strict.HasFrontmatter) {
    $fm = "created: $(Format-DateOnly -Date $creationDate)"
    $text = "${bom}---$nl$fm$nl---$nl$nl$($strict.Rest.TrimStart("`r","`n"))"
    $action.Add("add_frontmatter")
    $action.Add("add_created")
    $stats.added_frontmatter++
    $stats.added_created++
  }
  else {
    $fm = $strict.Frontmatter
    $rest = $strict.Rest
    $needsRewrite = $false

    $loose = Extract-LooseFrontmatterAtStart -TextAfterStrictFrontmatter $rest
    if ($null -ne $loose) {
      $fm = Merge-Frontmatters -Fm1 $fm -Fm2 $loose.Frontmatter
      $rest = $loose.Rest
      $action.Add("merge_frontmatter")
      $stats.merged_frontmatter++
      $needsRewrite = $true
    }

    $ensured = Ensure-CreatedInFrontmatter -Frontmatter $fm -FallbackDate $creationDate -Now $now
    if ($ensured.Changed) {
      if ($ensured.Reason -eq "missing") { $stats.added_created++; $action.Add("add_created") }
      else { $stats.fixed_created++; $action.Add("fix_created_$($ensured.Reason)") }
      $fm = $ensured.Frontmatter
      $needsRewrite = $true
    }

    if ($needsRewrite) {
      $text = "${bom}---$nl$fm$nl---$nl$rest"
    }
    else {
      $text = $original
    }
  }

  if ($text -ne $original) {
    $stats.updated++
    $reportObj = @{
      path = $f.FullName
      actions = $action
    } | ConvertTo-Json -Compress
    Add-Content -LiteralPath $ReportPath -Value $reportObj

    if ($Apply) {
      Write-Utf8NoBom -Path $f.FullName -Text $text
    }
  }
}

Write-Host ("Total: {0}" -f $stats.total)
Write-Host ("Updated: {0}" -f $stats.updated)
Write-Host ("Added frontmatter: {0}" -f $stats.added_frontmatter)
Write-Host ("Merged frontmatter: {0}" -f $stats.merged_frontmatter)
Write-Host ("Added created: {0}" -f $stats.added_created)
Write-Host ("Fixed created: {0}" -f $stats.fixed_created)

if (-not $Apply) {
  Write-Host "Dry-run only (no files written). Re-run with -Apply to write changes."
}
