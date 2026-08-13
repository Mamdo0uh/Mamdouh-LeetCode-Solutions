SELECT user_id, COUNT(prompt) prompt_count, ROUND(AVG(tokens*1.00),2) avg_tokens
FROM prompts
GROUP BY user_id
HAVING COUNT(prompt) > 2 AND MAX(tokens) > AVG(tokens)
ORDER BY avg_tokens DESC, user_id;