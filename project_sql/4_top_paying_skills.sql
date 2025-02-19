/*What are the top skills based on salary?
- Look at average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries and remote jobs
- Why? It reveals how different skills impact salary levels for Data Analysts
*/

SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS skill_avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY skill_avg_salary DESC
LIMIT 25;

/*
Top-Paid Skills:

PySpark – A powerful big data processing framework. High demand for data engineers working with massive datasets explains its top-tier salary.
Bitbucket – A Git-based source code repository, popular for CI/CD pipelines in enterprise environments, especially Atlassian-integrated stacks.
⚙️ Data & AI Tools:
3. Couchbase / Watson – NoSQL databases and AI platforms are crucial for modern, scalable apps and intelligent systems.
4. DataRobot – An automated machine learning (AutoML) platform—specialized AI tools often pay a premium.
5. Jupyter / Pandas / Numpy / Scikit-learn – Core Python data science libraries, reflecting the constant need for analysts and data scientists.

☁️ Cloud & DevOps:
6. GitLab / Jenkins / Kubernetes / Airflow – CI/CD, orchestration, and workflow automation—critical in modern DevOps and MLOps.
7. Databricks / GCP / PostgreSQL – Cloud data platforms and databases, essential for scalable data infrastructure.

🚀 Programming & Infrastructure:
8. Golang / Scala / Swift – High-performance programming languages, often used in backend, mobile, and distributed systems.
9. Linux – Still a cornerstone for servers and cloud environments.

📊 Business & Collaboration Tools:
10. Atlassian / Twilio / Notion / MicroStrategy – Productivity, communication, and BI platforms—important for tech-driven businesses.

✨ Key Insight:

High salaries often reflect specialization (e.g., PySpark, DataRobot), enterprise adoption (Bitbucket, MicroStrategy), and scalability demands (Kubernetes, Airflow).
Knowing a combination of these—like DevOps with cloud data platforms or AI with big data tools—puts professionals in high demand.
*/