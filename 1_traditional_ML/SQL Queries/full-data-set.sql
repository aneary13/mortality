DROP MATERIALIZED VIEW IF EXISTS fulldataset CASCADE;
CREATE MATERIALIZED VIEW fulldataset AS

-- This calculates the age on admission for each patient
WITH agedata AS (
	SELECT ie.subject_id, ie.hadm_id, ie.icustay_id,
		round( ( CAST(ie.intime AS date) - CAST(pa.dob AS date) ) / 365.242 , 2 ) AS age
	FROM icustays ie
			INNER JOIN
		patients pa
			ON ie.subject_id = pa.subject_id
	),

-- This combines the vitalsfirstday, labsfirstday, uofirstday and gcsfirstday with the age information from above
fullset AS (
	SELECT vitals.subject_id, vitals.hadm_id, vitals.icustay_id,
		vitals.heartrate_min, vitals.heartrate_max, vitals.heartrate_mean,
		vitals.sysbp_min, vitals.sysbp_max, vitals.sysbp_mean,
		vitals.diasbp_min, vitals.diasbp_max, vitals.diasbp_mean,
		vitals.meanbp_min, vitals.meanbp_max, vitals.meanbp_mean,
		vitals.resprate_min, vitals.resprate_max, vitals.resprate_mean,
		vitals.tempc_min, vitals.tempc_max, vitals.tempc_mean,
		vitals.spo2_min, vitals.spo2_max, vitals.spo2_mean,
		vitals.glucose_min, vitals.glucose_max, vitals.glucose_mean,
		labs.aniongap_min, labs.aniongap_max,
		labs.albumin_min, labs.albumin_max,
		labs.bands_min, labs.bands_max,
		labs.bicarbonate_min, labs.bicarbonate_max,
		labs.bilirubin_min, labs.bilirubin_max,
		labs.creatinine_min, labs.creatinine_max,
		labs.chloride_min, labs.chloride_max,
		labs.glucose_min AS lab_glucose_min, labs.glucose_max AS lab_glucose_max,
		labs.hematocrit_min, labs.hematocrit_max,
		labs.hemoglobin_min, labs.hemoglobin_max,
		labs.lactate_min, labs.lactate_max,
		labs.platelet_min, labs.platelet_max,
		labs.potassium_min, labs.potassium_max,
		labs.ptt_min, labs.ptt_max,
		labs.inr_min, labs.inr_max,
		labs.pt_min, labs.pt_max,
		labs.sodium_min, labs.sodium_max,
		labs.bun_min, labs.bun_max,
		labs.wbc_min, labs.wbc_max,
		uo.urineoutput,
		gcs.mingcs, gcs.gcsmotor, gcs.gcsverbal, gcs.gcseyes, gcs.endotrachflag,
		ad.age, 
		CAST(ie.outtime AS timestamp), CAST(ie.intime AS timestamp), round( CAST(ie.outtime AS date) - CAST(ie.intime AS date) , 2) AS los,
		adm.hospital_expire_flag AS mortality,
		ad.age = MIN(ad.age) OVER(PARTITION BY ad.subject_id) AS first_admit_flag
	FROM
		vitalsfirstday vitals
			INNER JOIN
		labsfirstday labs
			ON vitals.icustay_id = labs.icustay_id
			INNER JOIN
		uofirstday uo
			ON labs.icustay_id = uo.icustay_id
			INNER JOIN
		gcsfirstday gcs
			ON uo.icustay_id = gcs.icustay_id
			INNER JOIN
		agedata ad
			ON gcs.icustay_id = ad.icustay_id
			INNER JOIN
		icustays ie
			ON ad.icustay_id = ie.icustay_id
			INNER JOIN
		admissions adm
			ON ie.hadm_id = adm.hadm_id
	)

-- This query extracts all of the data for patients over 18 years old on their first ICU admission
SELECT *
FROM fullset
WHERE age >= 18 AND first_admit_flag = true