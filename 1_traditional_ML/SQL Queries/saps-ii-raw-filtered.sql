DROP MATERIALIZED VIEW IF EXISTS sapsii_raw_filtered;
CREATE MATERIALIZED VIEW sapsii_raw_filtered AS
(
	WITH first_admission AS
	(
		SELECT *, age = MIN(age) OVER(PARTITION BY subject_id) AS first_admit_flag
		FROM sapsii_raw
	)
	SELECT *
	FROM first_admission
	WHERE age >= 18 AND first_admit_flag = true
)