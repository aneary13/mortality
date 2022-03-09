# Mortality Prediction

This is my next attempt at recreating one of the tasks presented in the paper "Benchmarking Deep Learning Models on Large Healthcare Datasets" by Purushotham et al, 2018.

Here, I actually get to implementing some ML models to predict patient mortality.

The data being used here is taken from the MIMIC-III database, an open source, anonymised database containing patient data collected in the ICU.

Below is an overview of what each notebook is doing:
- **0_create_saps_data.ipynb** - queries MIMIC-III for data relating to the SAPS-II clinical warning score. Note, this data was created using a materialised view with the queries in the *SQL Queries* folder.
- **1_data_split.ipynb** - splits the data into training, validation and test sets.
- **2_data_clean.ipynb** - remove rows with missing data.
- **3_classification_numeric.ipynb** - train decision tree and logistic regression classifiers with numeric features only.
- **4_classification_all.ipynb** - train decision tree and logistic regression classifiers with numeric and categorical features, where the categorical features are one-hot encoded.
- **5_full_pipeline.ipynb** - repeats the above steps, including many more features than are found in SAPS-II. Also repeats model training and testing with a balanced dataset.