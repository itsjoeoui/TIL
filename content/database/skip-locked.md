---
title: SKIP LOCKED
date: 2025-11-30
---

When is `SKIP LOCKED` useful? Consider the following case.

Let's say you are designing a URL shortener or lengthener, doesn't matter which one, one approach you might want to take is to pre-populate a set of short URL keys in your database. There are many benefits to this, for example, it greatly simplifies the key generation logic, instead of generate and check (not trivial in a distributed system), you just pick an empty slot in the DB.

This is a sample SQL query that does the job:

```sql
WITH selected_mapping AS (
  SELECT mapping_id, short_key
  FROM url_mappings
  WHERE expired_at = < NOW()
  LIMIT 1
  FOR UPDATE SKIP LOCKED -- HERE!
)
UPDATE url_mappings
SET expired_at = NOW() + ?, long_url = ?
WHERE mapping_id = (SELECT mapping_id FROM selected_mapping)
RETURNING mapping_id, short_key;
```

To understand how this is useful, we need to think about a case where we do not use `SKIP LOCKED`.

Imagine we have 2 transactions both want to grab a `short_key`, as the number of concurrent select increases, the odds that 2 instances try to select the same `short_key` increases. Without `SKIP LOCKED`, when 2 instances try to select the same thing, the late comer will wait for the earlier one to release its lock then proceed. This is bad, not only because there is no point in waiting as the earlier one will just occupy it, also it could have just moved on and go find another slot. `SKIP LOCKED` does exactly this.
