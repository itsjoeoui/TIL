---
title: Skip List
date: 2025-11-12
---

Skip list is a special type of linked list, it addresses a big shortcoming of linked list, which is random access is not supported. Even though the elements are sorted, you are not able to perform binary search on it. So you need $O(n)$ to search through the list.

A great video explaining on skip list:
![2-3: Skip List](https://www.youtube.com/watch?v=UGaOXaXAM5M)

```python
import random
from typing import override


class Node:
    __slots__: tuple[str, ...] = ("value", "next")

    def __init__(self, value: int, level: int):
        self.value: int = value
        # We store the next node for each level
        # For example, in level n, the next node of the current node is self.next[n]
        self.next: list[Node | None] = [None] * level


class Skiplist:

    def __init__(self, bias: float = 0.5):
        # The probability that the level will go higher
        self.bias: float = bias
        self.max_capacity: int = 16

        self.level_size: int = 1

        self.head: Node = Node(-1, self.max_capacity)

        self.size: int = 0

    def _generate_level(self) -> int:
        level = 1
        r = random.getrandbits(self.max_capacity)
        while r & 1 and level < self.max_capacity:
            level += 1
            r >>= 1
        return level

    def _iter(self, target: int):
        cur = self.head
        for level in range(self.level_size - 1, -1, -1):
            while cur and (next_node := cur.next[level]) and next_node.value < target:
                cur = next_node
            yield cur, level

    def search(self, target: int) -> bool:
        node = None
        for node, level in self._iter(target):
            if node and (next_node := node.next[level]) and next_node.value == target:
                return True

        return False

    def add(self, num: int) -> None:
        add_level = self._generate_level()
        self.level_size = max(self.level_size, add_level)

        add_node = Node(num, add_level)

        updates = [self.head for _ in range(add_level)]
        for node, level in self._iter(num):
            if level < add_level:
                updates[level] = node

        for level, node in enumerate(updates):
            add_node.next[level] = node.next[level]
            node.next[level] = add_node

        self.size += 1

    def erase(self, num: int) -> bool:
        updates: list[Node | None] = [None for _ in range(self.level_size)]

        for node, level in self._iter(num):
            updates[level] = node

        if not updates[0] or not updates[0].next[0] or updates[0].next[0].value != num:
            return False

        delete_node = updates[0].next[0]

        for level, node in enumerate(updates):
            if not node or level >= len(delete_node.next):
                continue
            node.next[level] = delete_node.next[level]

        delete_level = len(delete_node.next)
        del delete_node

        if delete_level == self.level_size:
            while self.level_size > 1 and self.head.next[self.level_size - 1] is None:
                self.level_size -= 1

        self.size -= 1
        return True

    def __len__(self):
        return self.size

    def __iter__(self):
        cur = self.head.next[0]
        while cur:
            yield cur.value
            cur = cur.next[0]

    @override
    def __repr__(self):
        return f"Skiplist({list(self)})"
```
