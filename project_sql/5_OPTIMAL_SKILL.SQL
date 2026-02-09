WITH demanding_skills AS (
    SELECT
        s.skill_id,
        s.skills,
        COUNT(sj.job_id) AS demand_count
    FROM job_postings_fact j
    JOIN skills_job_dim sj 
        ON sj.job_id = j.job_id
    JOIN skills_dim s 
        ON s.skill_id = sj.skill_id
    WHERE j.job_title_short = 'Data Analyst'
      AND j.salary_year_avg IS NOT NULL
    GROUP BY s.skill_id, s.skills
),

avg_sal_per_skill AS (
    SELECT
        s.skill_id,
        ROUND(AVG(j.salary_year_avg), 0) AS avg_sal
    FROM job_postings_fact j
    JOIN skills_job_dim sj 
        ON sj.job_id = j.job_id
    JOIN skills_dim s 
        ON s.skill_id = sj.skill_id
    WHERE j.job_title_short = 'Data Analyst'
      AND j.salary_year_avg IS NOT NULL
    GROUP BY s.skill_id
)

SELECT 
    d.skill_id,
    d.skills,
    d.demand_count,
    a.avg_sal
FROM demanding_skills d
JOIN avg_sal_per_skill a
    ON d.skill_id = a.skill_id
WHERE d.demand_count > 10
ORDER BY a.avg_sal DESC,
 d.demand_count DESC
     
LIMIT 10





SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_sal
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER join skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND salary_year_avg IS NOT NULL
        AND job_work_from_home = true
    GROUP BY skills_dim.skill_id
    HAVING COUNT(skills_job_dim.job_id) > 10
    ORDER BY avg_sal DESC,
        demand_count DESC
    LIMIT 20;
    



