/* What are the most optimal skills to learn( aka it's in high demand and a high paying skill)?
- Identify skills in high demand and associated with high average salaries for Data analyst jobs
- Concentrate on remote positions with specified salaries
- Why? Targets skills that offer job security and financial benefits
*/

WITH in_demand AS (
    SELECT skills_job_dim.skill_id,
        COUNT(job_id) AS total_job_postings
    FROM skills_job_dim
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_id IN (
            SELECT job_id
            FROM job_postings_fact
            WHERE job_title_short = 'Data Analyst'
            AND salary_year_avg IS NOT NULL
        )    
    GROUP BY skills_job_dim.skill_id
    ORDER BY total_job_postings DESC
),
avg_salary AS (
    SELECT skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS skill_avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
    ORDER BY skill_avg_salary DESC
)
SELECT skills_dim.skill_id,
    skills_dim.skills,
    in_demand.total_job_postings,
    avg_salary.skill_avg_salary
From skills_dim
    INNER JOIN avg_salary ON skills_dim.skill_id = avg_salary.skill_id
    INNER JOIN in_demand ON skills_dim.skill_id = in_demand.skill_id
WHERE 
    in_demand.total_job_postings > 10
ORDER BY in_demand.total_job_postings DESC, avg_salary.skill_avg_salary DESC
LIMIT 25     
;
