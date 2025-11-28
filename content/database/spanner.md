---
date: 2025-11-27
title: Spanner
---

Today I learned how Google Spanner uses TrueTime to achieve external consistency in distributed transactions.

When a transaction commits:

1. **Get timestamp**: Spanner queries TrueTime, which returns an uncertainty interval `[earliest, latest]`
2. **Assign commit time**: The transaction's commit timestamp is set to `TT.now().latest` (the end of the interval)
3. **Commit wait**: Spanner waits until `TT.now().earliest > commit_timestamp` before acknowledging the commit to the client
4. **Return success**: Only after the wait can Spanner guarantee the timestamp is definitively in the past

This "commit wait" ensures external consistency: if transaction T1 commits before T2 starts, then T1's timestamp < T2's timestamp. This property allows Spanner to provide linearizability across a globally distributed database.

**How long is the wait?**

The commit wait duration is `latest - earliest`. Here's the reasoning:

- When the commit timestamp is assigned as `latest`, the true time could be anywhere in `[earliest, latest]`
- In the worst case, true time is actually at `earliest` right now
- So Spanner must wait until even that worst case has progressed past `latest`
- Worst-case wait = `latest - earliest`

In practice, the average wait is about half that duration (2-4ms in Google datacenters) since true time is typically near the middle of the interval. The interval width comes from clock uncertainty, TrueTime accounts for potential clock drift by providing a range around the true time. Google synchronizes TrueTime servers with GPS and atomic clocks approximately every 30 seconds, keeping the uncertainty bound small and thus minimizing commit latency.
