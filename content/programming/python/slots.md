---
title: Slots
date: 2025-11-08
---

Normally, Python objects store their attributes in a per-instance `__dict__` (has hash table overhead), which is flexible but memory-heavy and a bit slower.

**If you define `__slots__` in a class:**

- Python creates a **descriptor** (a special object that manages attribute access) for each slot at the class level
- Each instance stores **pointers to the actual values** in a fixed-size array
  - The array size is determined by the number of slots (e.g., 2 slots = 2 pointers)
  - The actual objects (numbers, strings, etc.) live elsewhere in memory
- Attribute access becomes **direct array indexing** (`instance[0]` for `x`) instead of hash table lookup

**Memory savings come from:**

- **No `__dict__` per instance** - a dict has overhead for the hash table structure, even when nearly empty
- **No attribute name strings per instance** - with `__dict__`, each instance conceptually stores `{'x': value, 'y': value}`. With slots, the names `'x'` and `'y'` only exist once at the class level
- **Fixed-size allocation** - the instance is exactly `header + (N × pointer_size)`, no over-allocation for future growth

```python
class SlottedPoint:
  __slots__ = ('x', 'y')

  def __init__(self, x, y):
    self.x = x
    self.y = y
```

**Why use it:**

- Saves memory when you have many instances (especially in large data models).
- Slightly faster attribute access and creation.
- Prevent typos: trying to assign or access an undefined attribute raises an `AttributeError` immediately.
  - You can argue that your LSP should have caught that for you, but your LSP cannot catch things like `setattr` :(

**Why not:**

- You can’t add new attributes not listed in `__slots__`.
- You lose some flexibility (no `__dict__`, no weakrefs unless explicitly added).
- Makes inheritance trickier.

Use it when you have lots of small, fixed-structure objects and care about performance, skip it when flexibility matters more.
