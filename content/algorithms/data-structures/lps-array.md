---
title: LPS Array
---
Longest Prefix Suffix Array

$$
\begin{aligned}
\text{Pattern: } &= [a,a,b,a,a,a,c]\\ 

\text{LPS Array: } &= [0,1,0,1,2,2,0]
\end{aligned}
$$

$O(n)$ algorithm to build the LPS array.
```c++
// Taken from: https://www.geeksforgeeks.org/dsa/kmp-algorithm-for-pattern-searching/
vector<int> computeLPSArray(string &pattern) {
    int n = pattern.size();
    vector<int> lps(n, 0);
        
    // length of the previous longest prefix suffix
    int len = 0;  
    int i = 1;

    while (i < n) {
        if (pattern[i] == pattern[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) { 
                // fall back in the pattern
                len = lps[len - 1];  
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    return lps;
}
```