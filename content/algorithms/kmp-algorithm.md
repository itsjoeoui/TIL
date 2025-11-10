---
title: KMP Algorithm
date: 2025-11-07
---

Used for string matching. For example, given a pattern and a string, find all the occurrences of this pattern in the string.

The time complexity is $O(n+m)$ where $n$ is the length of the string and $m$ is the length of the pattern.

Why is the KMP algorithm so efficient? Because as we iterate over the text, we never need to move the pointer backward! This is thanks to the [[lps-array|LPS Array]].

I think of the [[lps-array|LPS Array]] as a "reset list". Let's see the following example:

Imagine the pattern is "ababc" and the string is "abababc".

Our [[lps-array|LPS Array]] will be `[0, 0, 1, 2, 0]`

We will initialize 2 pointers, `np = 0` and `mp = 0`. We use `np` to iterate over the string and `mp` to iterate over the pattern.

For the first index, `a = a`, we bump both `np` and `mp`, we will keep doing that for the second, third and forth index since they are all the same. We will end up with `np = mp = 4`.

Here comes the interesting part. At index 4, they do not match anymore. Therefore, we will have to reset our patten pointer.

There are 2 ways to reset our pattern pointer. The naive way is to set `mp` back to 0, note that this also requires us to move back the `np` as well since otherwise we might miss a pattern.

The KMP algorithm shows us that we do not need to do that. With the help of the [[lps-array|LPS Array]], we can reset as little as possible every time and we no longer to move `np` backward.

The reset logic is, you take the value at index `mp - 1`, and that becomes your new `mp`, in this case, it will become $2$. With `np = 4` and `mp = 2`, and turns out `n[np] = m[mp] = 'a'`, great, we can keep going again! If sometimes they are not equal, we will set `mp` to the value of index `mp - 1` and keep going until it reaches 0, which means we had to reset the pattern matcher entirely. I think of the [[lps-array|LPS Array]] as the "reset list" because it tells us the optimal position to reset our match pointer!

The rest is simple, we just keep matching until we hit one that matches all characters in the pattern, then we can record the index!

```c++
// Taken from: https://www.geeksforgeeks.org/dsa/kmp-algorithm-for-pattern-searching/
vector<int> search(string &pat, string &txt) {
    int n = txt.length();
    int m = pat.length();

    vector<int> lps(m);
    vector<int> res;

    constructLps(pat, lps);

    // Pointers i and j, for traversing
    // the text and pattern
    int i = 0;
    int j = 0;

    while (i < n) {

        // If characters match, move both pointers forward
        if (txt[i] == pat[j]) {
            i++;
            j++;

            // If the entire pattern is matched
            // store the start index in result
            if (j == m) {
                res.push_back(i - j);

                // Use LPS of previous index to
                // skip unnecessary comparisons
                j = lps[j - 1];
            }
        }

        // If there is a mismatch
        else {

            // Use lps value of previous index
            // to avoid redundant comparisons
            if (j != 0)
                j = lps[j - 1];
            else
                i++;
        }
    }
    return res;
}
```
