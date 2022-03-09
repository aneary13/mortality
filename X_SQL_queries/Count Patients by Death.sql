SELECT expire_flag, COUNT(*)
FROM patients
GROUP BY expire_flag;