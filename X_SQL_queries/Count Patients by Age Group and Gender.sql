WITH first_admission_time AS
(
  SELECT
      p.subject_id, p.dob, p.gender
      , MIN (a.admittime) AS first_admittime
      , MIN( ROUND( (cast(admittime as date) - cast(dob as date)) / 365.242,2) )
          AS first_admit_age
  FROM patients p
  INNER JOIN admissions a
  ON p.subject_id = a.subject_id
  GROUP BY p.subject_id, p.dob, p.gender
  ORDER BY p.subject_id
)
, age as
(
  SELECT
      subject_id, dob, gender
      , first_admittime, first_admit_age
      , CASE
          WHEN first_admit_age > 89
              then '>89'
          WHEN first_admit_age >= 14
              THEN 'adult'
          WHEN first_admit_age <= 1
              THEN 'neonate'
          ELSE 'middle'
          END AS age_group
  FROM first_admission_time
)
select age_group, gender
  , count(subject_id) as NumberOfPatients
from age
group by age_group, gender