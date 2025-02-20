# Introduction
Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets salary in data analytics.

See SQL queries here [project_sql folder](/project_sql/)

# Tools I Used

- **SQL:** the backbone of my analysis, allowing me to query the database and discover critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git and Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approaced each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles I filtered data analyst positions by average yearly salary and location, focusing on remote jobs

```sql
SELECT job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE job_title_short = 'Data Analyst'
    AND (
        job_work_from_home = TRUE
    )
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
✅ ***Quick Takeaways:***

- Mantys is a clear outlier with a massive $650K salary — worth verifying if it’s a high-level role or anomaly.
- Big tech and telecom companies (Meta, AT&T, Pinterest) are offering highly competitive salaries in the $230K–$336K range.
- SmartAsset appears twice with high-paying Principal Data Analyst roles — potentially signaling growth or a strong data team.
- Even the "lowest" salaries here are $184K, which is well above the market average for Data Analysts — indicating these roles likely require seniority or specialized analytics skills.

### 2. Top Paying Skills For Data Analyst Jobs

```sql
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM job_postings_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE job_title_short = 'Data Analyst'
        AND (
            job_work_from_home = TRUE
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
```

✅***Quick Takeaways:***

- **SQL is the most in-demand skill**, appearing in 6 job postings.
- **Power BI (4), Excel (3), SSRS (3)** are also commonly required, indicating a strong demand for reporting and visualization tools.
- **SSIS, SAS, and PowerPoint (2 each)** are moderately required.
- **Python and R appear only once**, suggesting that coding-heavy roles may be less common in this dataset.
- **A mix of tools like SPSS, SQL Server, Oracle, and Tableau appears infrequently**, but they may be role-specific.
- **Phoenix is listed once**, which may refer to specialized software or a framework.

# What I Learned
# Conclustion
