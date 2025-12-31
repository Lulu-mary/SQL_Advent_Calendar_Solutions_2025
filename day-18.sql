-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

SELECT subject, score, quiz_date
FROM (
  SELECT subject, 
         score,
         quiz_date,
         RANK() OVER(PARTITION BY subject
                     ORDER BY quiz_date DESC) AS latest_date,
         RANK() OVER(PARTITION BY subject
                     ORDER BY quiz_date) AS earliest_date
  FROM daily_quiz_scores
) AS subquery
WHERE latest_date = 1 OR earliest_date = 1
