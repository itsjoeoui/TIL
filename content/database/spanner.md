---
date: 2025-11-27
title: Spanner
---

## TrueTime

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

## Multiversion Concurrency Control (MVCC)

Spanner uses MVCC: writes don't modify records in place. Instead, each write creates a new versioned copy tagged with its commit timestamp. This allows Spanner to maintain multiple versions of the same data, enabling snapshot reads at any historical timestamp without blocking writers.

## Paxos & 2PC

Spanner uses **Paxos for replication within groups** and **2PC for coordination across groups**.

Data is split into tablets, each replicated across a small Paxos group (3-7 nodes):

```
Transaction touches 2 accounts in different tablets:

Paxos Group 1              Paxos Group 2
(Account A's tablet)       (Account B's tablet)
┌─────────────────┐       ┌─────────────────┐
│ Replica 1 (L)   │       │ Replica 1 (L)   │
│ Replica 2       │       │ Replica 2       │
│ Replica 3       │       │ Replica 3       │
└─────────────────┘       └─────────────────┘
     ↕ Paxos                   ↕ Paxos
  (replication)             (replication)

         ↔──────── 2PC ────────↔
        (coordinates both groups)
```

| Protocol  | Purpose                                             | Scope                               |
| --------- | --------------------------------------------------- | ----------------------------------- |
| **Paxos** | Replicate writes within a group for fault tolerance | Single tablet's replicas (vertical) |
| **2PC**   | Coordinate atomic commits across multiple tablets   | Multiple Paxos groups (horizontal)  |
