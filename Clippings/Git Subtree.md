---
title: Git Subtree
categories:
  - "[[Resources]]"
source: https://www.geeksforgeeks.org/git/git-subtree/
author:
  - "[[GeeksforGeeks]]"
published: 2022-02-27
created: 2026-02-13
description: "GitSubtree: Including one Git repository as a subdirectory within another repository."
tags:
  - git
  - developer
---
Last Updated: 10 Oct, 2025

Git Subtree is a strategy for including one Git repository as a subdirectory within another repository.

- Keep another project’s code inside your repository.
- Pull in updates from the external project easily.
- Push changes back to the external project when needed.

Unlike submodules, subtree repositories are fully contained-meaning all their files and commit history can exist inside the main repository itself.

![git subtree](https://media.geeksforgeeks.org/wp-content/uploads/20220214114738/gitSubTrees.jpg "Click to enlarge")

## Adding a Subtree to Parent Repository

To bring a new subtree to a parent repository, you first remotely add it, then use the subtree add command, which looks like this:

```
$ git remote add remote-name <URL to Git repo>
$ git subtree add --prefix=folder/ remote-name <URL to Git repo> subtree-branchname
```

The commit log of the entire child project gets merged into the main repository.

### Pushing and pulling changes to and from the subtree

```
$ git subtree push-all
```

or the below command performs the same as follows:

```
$ git subtree pull-all
```

Git submodules have a lesser repository size than Git subtrees since they are only pointers to a specific commit in the child project, whereas Git subtrees hold the complete child project and its history. Submodules in Git must be accessible from a server, while subtrees are not. Component-based development makes use of Git submodules, whereas system-based development makes use of Git subtrees.

A Git subtree is not the same thing as a Git submodule. There are several limitations on where each can be used. If you own an external repository to which you will likely push code, use Git submodule because it is easier to push. Use Git subtree if there is a third-party code that you are doubtful to push to because it is easier to pull. You can add another repository into this repository like this:

- Specify you want to add a subtree.
- Indicate that you want to add a subtree.
- Specify the prefix local directory where you wish the subtree to be pulled.
- Specify the URL of the remote repository \[for the subtree being dragged in\].
- The remote branch \[of the subtree being pulled in\] must be specified.
- Specify that you wish to squash all \[the subtree's\] logs from the remote repository.

> git subtree add --prefix {local directory being pulled into} {remote repo URL} {remote branch} --squash

****Example:**** Peek out

> git subtree add --prefix subtreeDirectory https://github.com/microsoft/hermes-windows master --squash

This will duplicate https://github.com/microsoft/hermes-windows into the directory subtreeDirectory.

****Replace add with pull:**** if we wish to pull in every new contribution to the subtree from the main.

> git subtree pull —prefix subtreeDirectory https://github.com/microsoft/hermes-windows master —squash

## Benefits of Using Git Subtree

- ****Integration:**** Seamlessly integrates external repositories into your main project.
- ****Simplicity:**** Simplifies the workflow compared to Git Submodules by avoiding additional metadata and simplifying commands.
- ****Autonomy:**** Each subtree can be managed independently, making it easier to track changes and updates.
- ****Flexibility:**** Allows for merging and splitting subtrees without affecting the main repository.

## Advantages of Subtrees

1. Supported by Git's previous version. It supports versions older than 1.5 as well.
2. Workflow management is simple.
3. After the super-project is completed, there will be an available sub-project code.
4. You don't need newer Git knowledge.
5. Content modification without the need for a different repo of the dependence.

## Disadvantages of Subtrees

1. It's not immediately obvious that a subtree is used to build the main repo.
2. Your project's subtrees are difficult to list.
3. You can't, at least not simply, list the subtrees' remote repositories.
4. When you change the main repository with subtree commits, then submit the subtree to its main server, and then pull the subtree, the logs can be a little misleading.

## Git Subtree Vs Git Submodule

| ****Git Subtree**** | ****Git Submodule**** |
| --- | --- |
| Repository is stored as a subdirectory inside the main project. | Repository is stored as a separate linked repository. |
| Simple no extra commands after cloning. | Requires `git submodule init` and `git submodule update`. |
| Clones everything in one go. | Needs an additional step to fetch submodules. |
| Fully integrated — subtree files are part of main repo history. | Submodule files are not part of main repo history. |
| Works completely offline. | May need internet access to update submodules. |
| Subtree commits are merged into main repo commits. | Submodule stores only a reference (commit ID) of the external repo. |
| Easier to understand and manage. | More complex to maintain and sync. |
| Team members don’t need special setup. | Every collaborator must initialize submodules manually. |
| Best when simplicity and integration are priorities. | Best when keeping repositories strictly separate is important |
