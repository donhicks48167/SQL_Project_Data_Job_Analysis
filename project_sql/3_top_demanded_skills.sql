/*What are the most in demand skills for data analysts?
- Identify the top 5 in demand skills for a data analyst
- Focus on all jobs not just remote
- Why? Provdides insights into the most valuable skills for data analysts
*/

SELECT skills, COUNT(job_id) AS total_job_postings
FROM skills_job_dim
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_id IN (
    SELECT job_id FROM job_postings_fact WHERE job_title_short = 'Data Analyst' 
)
GROUP BY skills
ORDER BY total_job_postings DESC
LIMIT 5;