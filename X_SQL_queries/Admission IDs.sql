WITH admission_time AS
(
	SELECT a.subject_id, a.hadm_id, a.admittime, p.dob,
		MIN(a.admittime) OVER (PARTITION BY a.subject_id) AS first_admittime,
		ROUND((CAST(a.admittime AS date) - CAST(p.dob AS date))/365.242,2) AS admit_age
	FROM admissions a
	INNER JOIN patients p
	ON a.subject_id = p.subject_id
)
, age AS
(
	SELECT subject_id, hadm_id, admit_age,
		admittime = first_admittime AS first_admit_flag
	FROM admission_time
)
SELECT COUNT(hadm_id)
FROM age
WHERE admit_age >= 18 AND first_admit_flag = true