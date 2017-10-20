# Git usage guidelines

If you are not familiar with git usage, see below for instuctions. When in doubt,
contact Kevin Bonham at kbonham@broadinstitute.org

## Summary

- Only track documentation files (eg README files)
- When making changes from the iamc server, be certain you are on the `iamc-server` branch
- When making changes on your local system, make them on a separate branch and push to the server. Only merge to `master` if you know what you're doing.
- The `master` branch is the source of truth.

## Git Instructions

Git is a distributed version control system (dvcs) that enables transparant
version tracking and enables easy* management of edit conflicts. [See here][1]
for a description of git if you've never used it before.

There are many online tutorials for using git effectively, this document will
describe the bare minimum required for using git in the context of the iamc
datastore. In this repository, **we are only keeping track of documentation files**
(eg README files). Data and analysis files are not tracked or version controlled.

### Git vocabulary

- **Repository (repo)**: a git-enabled folder containing all all version history information.
    - NOTE: sometimes, "repo" refers to a single project and all clones of it, while other times it refers to a single copy.
- **Branch**: a named alternate version of a repo. Using branches allows mutliple parallel version of a repo to exist and be tracked at the same time
- **Merge**: a process to unify two branches. At the end of this process, both branches will be identical (but can then diverge again)
- **Commit**: a saved snapshot of all tracked files in the repo

### SOP for making changes

1) If you don't already have a local version of the repo, clone it from the iamc server

```sh
$ git clone <username>@iamc.kennedy.ox.ac.uk:/iamc/.git
```

If you already have the repo, pull the most recent version from the server.

```sh
$ git pull
```

2) If you are on the master branch (you can check with `git status`), switch to (or create) a new branch

```sh
$ git checkout <branch-name> # for existing branch
# OR
$ git checkout -b <branch-name> # to create a branch
```

3) Make changes, then commit. It is ok to add commits for every small change, or to make many changes in one commit.

If you want to commit one file at a time, or if you've created a new file, use
`git add <file_name>`, then `git commit`. If you want to commit multiple files
that have been previously tracked, use `git commit -a`.

Enter a descriptive commit message.

4) Push the changes to a branch on the server

```sh
$ git push # if you've already pushed this branch in the past
# OR
$ git push --set-upstream origin <branch-name> # if this is a new branch
```

5) When changes are finalized, merge with master branch on the server.

If you don't know how to do this, contact Kevin Bonham (kbonham@broadinstitute.org)
and he will take care of it. At this point, your changes are saved and tracked,
so it's ok if they're not merged immediately. Merging is the step where it is
most common to run into problems, so don't do it unless you're confident.



[1]: https://blog.red-badger.com/blog/2016/11/29/gitgithub-in-plain-english
