---
title: Filter
---

Suppose you want to review Neovim's recent development activity and see who's been contributing lately. Simple enough, right? Just grab the last 20 commits from GitHub's API and find the unique committers.

Starting in the terminal:

```bash
curl https://api.github.com/repos/neovim/neovim/commits?per_page=20
```

This spews a giant JSON blob. Now what? Save it to a file, parse it with `jq`, copy the output, deduplicate... Too many steps.

But wait: **Vim can run shell commands.**

## Demo

1. Create a new file like `example.json` and open it up in Neovim
2. Grab the data (Run this command in Neovim directly)
   ```vim
   .!curl -s 'https://api.github.com/repos/neovim/neovim/commits?per_page=20'
   ```
   This will dump the data directly in your buffer.
3. Extract the names
   ```vim
   %!jq -r '.[].commit.committer.name'
   ```
4. Deduplicate
   ```vim
   %!sort -u
   ```
   Done. A clean list of unique contributors, all without leaving the editor.

Quick note:

- `.!` means filter the current line (`.` is the range for current line)
- `%!` means filter the entire file (`%` is the range for entire file)
