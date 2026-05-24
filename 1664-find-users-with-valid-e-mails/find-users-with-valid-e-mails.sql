SELECT user_id, name, mail
FROM Users
WHERE mail LIKE '[A-Za-z]%@leetcode.com' COLLATE Latin1_General_BIN
  AND mail NOT LIKE '%[^A-Za-z0-9_.-]%@leetcode.com';