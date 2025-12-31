-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH daily_users_rank AS (
 SELECT CAST(sent_at AS DATE) AS sent_date,
        user_name,
        COUNT(*) AS messages_count,
        RANK() OVER(PARTITION BY CAST(sent_at AS DATE)
                    ORDER BY COUNT(*) DESC) AS daily_rank
 FROM npn_users u 
 JOIN npn_messages m 
 ON u.user_id = m.sender_id
 GROUP BY 1, 2
) 

 SELECT sent_date, user_name, messages_count
 FROM daily_users_rank 
 WHERE daily_rank = 1;
