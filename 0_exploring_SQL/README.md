# Mortality Prediction

This is the first attempt at recreating one of the tasks presented in the paper "Benchmarking Deep Learning Models on Large Healthcare Datasets" by Purushotham et al, 2018. 

The data being used here is taken from the MIMIC-III database, an open source, anonymised database containing patient data collected in the ICU.

Below is an overview of what each notebook is doing:
- **0_get_admission_IDs.ipynb** - queries MIMIC-III for all admission IDs of patients over 18 years old, on their first admission.
- **1_get_item_IDs.ipynb** - queries MIMIC-III for item IDs associated with the above patients, from 6 different tables (INPUTEVENTS, OUTPUTEVENTS, CHARTEVENTS, LABEVENTS, MICROBIOLOGYEVENTS and PRESCRIPTIONS).
- **2_choose_units_input.ipynb** - check the units of all item IDs in the table INPUTEVENTS.
- **3_choose_units_output.ipynb** - check the units of all item IDs in the table OUTPUTEVENTS.
- **4_choose_units_chart.ipynb** - check the units of all item IDs in the table CHARTEVENTS.
- **5_choose_units_lab.ipynb** - check the units of all item IDs in the table LABEVENTS.