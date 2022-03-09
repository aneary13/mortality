SELECT ie.subject_id, ie.hadm_id, ie.icustay_id,
    ie.intime, ie.outtime, adm.deathtime,
    ROUND((cast(ie.intime as date) - cast(pat.dob as date))/365.242, 2) AS age,
    ROUND((cast(ie.intime as date) - cast(adm.admittime as date))/365.242, 2) AS preiculos,
    CASE
        WHEN ROUND((cast(ie.intime as date) - cast(pat.dob as date))/365.242, 2) <= 1
            THEN 'neonate'
        WHEN ROUND((cast(ie.intime as date) - cast(pat.dob as date))/365.242, 2) <= 14
            THEN 'middle'
        -- all ages > 89 in the database were replaced with 300
        WHEN ROUND((cast(ie.intime as date) - cast(pat.dob as date))/365.242, 2) > 100
            THEN '>89'
        ELSE 'adult'
        END AS ICUSTAY_AGE_GROUP,
    -- note that there is already a "hospital_expire_flag" field in the admissions table which you could use
    CASE
        WHEN adm.hospital_expire_flag = 1 then 'Y'           
    ELSE 'N'
    END AS hospital_expire_flag,
    -- note also that hospital_expire_flag is equivalent to "Is adm.deathtime not null?"
    CASE
        WHEN adm.deathtime BETWEEN ie.intime and ie.outtime
            THEN 'Y'
        -- sometimes there are typographical errors in the death date, so check before intime
        WHEN adm.deathtime <= ie.intime
            THEN 'Y'
        WHEN adm.dischtime <= ie.outtime
            AND adm.discharge_location = 'DEAD/EXPIRED'
            THEN 'Y'
        ELSE 'N'
        END AS ICUSTAY_EXPIRE_FLAG
FROM icustays ie
INNER JOIN patients pat
ON ie.subject_id = pat.subject_id
INNER JOIN admissions adm
ON ie.hadm_id = adm.hadm_id;