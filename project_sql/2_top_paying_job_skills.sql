/* What skills are required for top paying jobs
- Use the top 10 highest paying Data Analyst
- Add specific skills required for these roles
- Why? It provides a detailed look at which skills are in demand for high paying jobs
*/

WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM job_postings_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE job_title_short = 'Data Analyst'
        AND (
            job_location = 'Philadelphia, PA'
        )
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skillS_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

/*

### Key Insights from the Skills Column:

1. **SQL is the most in-demand skill**, appearing in 6 job postings.
2. **Power BI (4), Excel (3), SSRS (3)** are also commonly required, indicating a strong demand for reporting and visualization tools.
3. **SSIS, SAS, and PowerPoint (2 each)** are moderately required.
4. **Python and R appear only once**, suggesting that coding-heavy roles may be less common in this dataset.
5. **A mix of tools like SPSS, SQL Server, Oracle, and Tableau appears infrequently**, but they may be role-specific.
6. **Phoenix is listed once**, which may refer to specialized software or a framework.


