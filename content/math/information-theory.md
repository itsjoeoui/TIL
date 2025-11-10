---
title: Information Theory
date: 2025-11-08
---

Information theory quantifies how much uncertainty is reduced when you learn something.

For example, if you start with 16 equally likely options, your total uncertainty is $\log_2 16 = 4$ bits.

Each bit of information halves the number of remaining possibilities.

- After learning something that narrows 16 → 8 options, you gain $\log_2(16/8) = 1$ bit.
- Another clue that shrinks 8 → 4 gives another $\log_2(8/4) = 1$ bit.

Information adds up: total gained is equal to $1 + 1 = 2$ bits, leaving $4 - 2 = 2$ bits of uncertainty.

**Formula:**

$$
\text{Information gained} = \log_2\frac{N_\text{before}}{N_\text{after}}
$$

Each bit = one “yes/no” question that halves the search space.

