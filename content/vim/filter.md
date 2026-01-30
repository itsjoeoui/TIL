---
title: Filter
date: 2025-12-23
---

Sorting attributes or imports

```vim
:'<,'>!sort
```

Removing duplicate lines

```vim
:'<,'>!sort -u
```

`jq` on the entire JSON file

```vim
:%!jq .
```
