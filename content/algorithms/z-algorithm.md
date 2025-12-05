---
title: Z Algorithm
date: 2025-12-04
---

![Z Algorithm](https://www.youtube.com/watch?v=CpZh4eF8QBw)

This video is probably the best explanation you can find on the internet.

This algo is an efficient string matching algo to find all occurrences of a given pattern within a larger text string.

The idea is to build the z-array based on the string `f"{pattern}${text}"`, then in the z array, any index that has its value set to the length of the pattern means there is an instance of the pattern in the text.

The solution below does not exactly do string matching, but it shows you how a z-array is built.

```python
class Solution:
    def sumScores(self, s: str) -> int:
        length = len(s)
        # let's create our z-values array
        # the value `v` at index `i` means that s[:v] == s[i:i+v]
        z = [0] * length

        z[0] = length  # hard code it for index 0, not necessary

        # this represents the window, inclusive
        left = 0
        right = 0

        for cp in range(1, length):
            if cp > right:
                # this is the case where we cannot use any of the
                # previously computed value. We need to start from scratch,
                # just perform the most naive comparison algo
                left = cp
                right = cp
                while right < length and s[right - left] == s[right]:
                    right += 1

                z[cp] = right - left
                right -= 1  # need to subtract one because the right is inclusive
            else:
                # in this case we fall within the [left, right] window (inclusive)
                # therefore, we can reuse the previously computed z-values
                pzp = cp - left  # pzp stands for previous z-value pointer

                if z[pzp] + cp < right + 1:
                    # we need to make sure it is not out of bound first
                    z[cp] = z[pzp]
                else:
                    # we are out of bound, let's shrink our window by bumping
                    # the left pointer and restart the naive comparison algo
                    left = cp
                    while right < length and s[right - left] == s[right]:
                        right += 1

                    z[cp] = right - left
                    right -= 1

        return sum(z)
```

## Example Problems

[2223. Sum of Scores of Built Strings](https://leetcode.com/problems/sum-of-scores-of-built-strings/)
