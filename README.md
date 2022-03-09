# Mortality Prediction

this work was undertaken at the beginning of my research in NUIG. At this stage, I needed to improve my technical skills. I was working from a paper titled "Benchmarking Deep Learning Models on Large Healthcare Datasets" by Purushotham et al, 2018. 

As an exercise, I attempted to reproduce some of their results with my own implementations from scratch. This provided me the oportunity to practice SQL and Python, as well as helping me to explore the MIMIC-III database. Specifically, I was focussing on the mortality prediction task.

The data being used here is taken from the MIMIC-III database, an open source, anonymised database containing patient data collected in the ICU.

Below is an overview of what is contained in each folder. More information about the specifics of the notebooks in each folder is detailed in their respected *README.md*:
- **0_exploring_SQL** - my first attempt to look at the work, mostly exploring the database and querying different tables.
- **1_traditional_ML** - first implementation of classifiers to predict patient mortality, using logistic regression and decision trees.
- **2_deep_ML** - implementation of a GRU model, and comparing the results to logistic regression and clinical warning scores.
- **3_fine_tuning** - exploring the effect on the performance of the GRU model of using different training sets.
- **X_SQL_queries** - just some practice querying the database.