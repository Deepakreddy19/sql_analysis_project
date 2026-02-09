SELECT
    skills,
    ROUND(AVG(salary_year_avg),0)as avg_sal
FROM job_postings_fact j
INNER JOIN skills_job_dim sj ON sj.job_id=j.job_id
INNER JOIN skills_dim s ON s.skill_id=sj.skill_id
WHERE job_title_short='Data Analyst' AND  salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_sal DESC



LIMIT 20