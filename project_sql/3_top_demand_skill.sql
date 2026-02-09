SELECT
    skills,
    COUNT(sj.job_id) as demand_count
FROM job_postings_fact j
JOIN skills_job_dim sj ON sj.job_id=j.job_id
JOIN skills_dim s ON s.skill_id=sj.skill_id
WHERE job_title_short='Data Analyst '
GROUP BY skills
ORDER BY demand_count DESC



LIMIT 5