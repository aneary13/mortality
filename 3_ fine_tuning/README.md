# Mortality Prediction

This is the first attempt at recreating one of the tasks presented in the paper "Benchmarking Deep Learning Models on Large Healthcare Datasets" by Purushotham et al, 2018.

Here, I implement an RNN model to predict patient mortality. This notebook also explores the effect on performance of using data collected on different days of a patient's stay, as well as the effect of balancing the target classes.

The data being used here is taken from the MIMIC-III database, an open source, anonymised database containing patient data collected in the ICU.

Below is an overview of what each notebook is doing:
- **0_patient_selection.ipynb** - queries MIMIC-III for all admission IDs of patients over 18 years old, on their first admission.
- **features** - this folder contains notebooks to query MIMIC-III for all the features we're going to use to train our models
- **1_data_prep.ipynb** - prepares the data for analysis. Static features are broadcast to 24-hour time series. Impossible values are clipped. The dataset is split and standardised. Some data for an individual patient is visualised.
- **2_gru_model.ipynb** - implements a GRU model, and looks at the performance effect of using different training sets.
- **X_all_SQL_queries.ipynb** - this was an attempt to combine all the individual notebooks for each feature into one super notebook.