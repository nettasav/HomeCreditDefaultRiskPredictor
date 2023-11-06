# Home Credit Default Risk Predictor

Based on data from the [Home Credit Default Risk data source on Kaggle](https://www.kaggle.com/competitions/home-credit-default-risk)

## Introduction

Within the field of data science, our final project is centered around the intricate domain of loan default prediction. The primary objective of this project is to develop a robust classification model that accurately predicts whether a loan applicant is likely to experience payment difficulties (class 1) or not (class 0). Payment difficulties are defined as instances where the client had late payments of more than X days on at least one of the first Y installments of the loan within our dataset. This problem holds significant importance in the financial sector, as it directly influences the lending decisions of financial institutions.

### Common Problems:
The prediction of payment difficulties poses several common challenges faced by data scientists. These include handling imbalanced datasets, effectively dealing with missing data, engineering features that capture the nuances of payment behavior, appropriately encoding and handling categorical variables, and selecting or developing appropriate evaluation metrics to assess the model's performance accurately.

### Goals of the Project:
The overarching goal of this project is to construct an accurate predictive model that aids financial institutions in identifying loan applicants who are likely to face payment difficulties.  Emphasis is solely placed on maximizing recall metric, ensuring that the model identifies as many true instances of payment difficulties as possible, even if it results in a higher number of false positives.

### Existing Knowledge about the Problem:
The problem of predicting payment difficulties in loan applicants has been extensively studied in the financial and data science literature. Researchers have highlighted the significance of features such as payment history, credit score, loan amount, income, employment history, and debt-to-income ratios in predicting payment behavior. Various machine learning algorithms, including logistic regression, decision trees, random forests, and gradient boosting, have been applied to address this challenge.

### Defining the Desired Outcome:
The desired outcome is a classification model that takes an applicant's profile and loan application information as input and generates predictions about the likelihood of payment difficulties. The model's performance will be evaluated using recall, which measures the ability to correctly identify instances of payment difficulties among all actual instances. 

### Factors Influencing the Outcome:
Several factors influence the prediction of payment difficulties:

Payment History: A history of late payments on previous loans can indicate a higher risk of future payment difficulties.
Credit Score: Lower credit scores might be associated with a higher likelihood of payment difficulties.
Income and Employment History: Stable income and employment history could imply a lower risk of payment difficulties.
Debt-to-Income Ratio: Higher ratios might suggest a borrower's financial strain and increase the risk of payment difficulties.
Loan Amount and Terms: Larger loan amounts or longer terms might impact payment behavior.
Potential for Novel Insights:

## Methodology (Project design)

### Data Sources and Usage:

The project draws upon a diverse set of data sources, each contributing unique insights into the loan prediction task. The data is provided in multiple CSV files, each containing different aspects of information relevant to the prediction of payment difficulties for loan applicants.

application_{train|test}.csv:
This is the primary table, split into two files for training (with the TARGET variable) and testing (without the TARGET variable). It contains static data for each loan application, including applicant information, loan amount, income, credit history, etc. Each row represents a single loan application.

bureau.csv:
This dataset contains information about the client's previous credits obtained from other financial institutions, as reported to the Credit Bureau. It provides historical credit data for clients who have a loan in the sample, contributing information about their credit behavior.

bureau_balance.csv:
This table contains monthly balances of the previous credits reported to the Credit Bureau. It gives insights into the month-by-month history of the client's previous credits, helping to understand patterns and trends.

POS_CASH_balance.csv:
This dataset offers monthly balance snapshots of previous point-of-sale (POS) and cash loans that the applicant had with Home Credit. It provides a history of payment and cash loan behavior.

credit_card_balance.csv:
Similar to the POS_CASH_balance dataset, this table contains monthly balance snapshots of the applicant's previous credit card behavior with Home Credit.

previous_application.csv:
This dataset captures all previous applications for Home Credit loans made by clients who have loans in the sample. It offers insights into the applicants' previous loan application behavior.

installments_payments.csv:
This dataset records the repayment history for previously disbursed credits in Home Credit. It provides detailed information about payments and missed payments for installments.

HomeCredit_columns_description.csv:
This file contains descriptions for the columns in the various data files, serving as a reference for understanding the data and its features.

Here are a few potential sources of bias:

Sampling Bias: The data might not be representative of the entire population of loan applicants. If the sample is not selected randomly or if certain segments of the population are underrepresented, the model's predictions could be skewed.

Labeling Bias: The way payment difficulties are labeled (e.g., late payments exceeding a certain threshold) might be subjective or influenced by external factors. This could introduce bias into the training data, affecting the model's ability to generalize to new data.

Feature Selection Bias: The features used to train the model might introduce bias if they are not representative of the true predictors of payment difficulties. Biased or incomplete features can lead the model to make inaccurate or unfair predictions.

Historical Bias: If historical lending practices were biased or discriminatory, the data collected from those practices might carry forward biases. For example, if certain groups were unfairly denied loans in the past, the model trained on this data could perpetuate those biases.

Missing Data Bias: If certain groups of applicants have more missing data in their profiles, it could lead to biased predictions. The model might unfairly penalize applicants with incomplete profiles, regardless of their actual creditworthiness.

Socioeconomic Bias: Features related to income, employment, and education can introduce socioeconomic bias. If certain groups are systematically disadvantaged in these areas, the model's predictions could disproportionately impact them.

Geographical Bias: Loan applicants from different geographical regions might face different economic conditions or lending practices. This can introduce bias if geographic factors are not adequately captured in the model.

Temporal Bias: Economic conditions and lending practices can change over time. If the training data spans different time periods, the model might capture historical biases that are no longer relevant.

Addressing these biases requires a combination of data preprocessing techniques, model selection, and evaluation methods. Strategies like oversampling underrepresented groups, using fair algorithms that mitigate bias, and performing thorough exploratory data analysis can help identify and rectify bias in the data. Additionally, transparency and ongoing monitoring of the model's performance can help detect and mitigate biases as they emerge. It's essential to ensure that the model's predictions are both accurate and fair for all groups of loan applicants.

### Exploratory Data Analysis (EDA) Strategy:

#### Univariate Analysis:
1. Continuous Numeric Variables:
   - Calculate descriptive statistics (mean, median, standard deviation) to understand central tendencies and variability.
   - Identify extreme points or outliers that might influence the distribution.
   - Plot histograms and box plots to visualize data distribution and identify potential skewness or multimodality.
   
2. Categorical Variables:
   - Calculate categorical distribution percentages to understand the prevalence of different categories.
   - Visualize categorical distribution using bar plots to identify major categories and potential imbalances.
   - Investigate any irregular or unexpected categories that might require further analysis.
   
Main Points:
- Identify extreme values, distribution patterns, and potential anomalies in the data.
- Note any observations for future manipulation, such as handling outliers or missing values.
   
#### Multivariate Analysis:
1. Numeric vs. Numeric:
   - Calculate correlations to understand relationships between continuous numeric variables.
   - Visualize relationships using scatter plots to detect potential trends or patterns.
   - Identify anomalies like hyperbolic trends that might require special attention.

2. Numeric vs. Categorical:
   - Perform T-tests or ANOVA to identify significant differences in continuous variable distributions across different categorical groups.
   - Evaluate whether certain categories are associated with specific numerical values.

3. Categorical vs. Categorical:
   - Use chi-square tests to detect differences between categorical variables.
   - Identify relationships or dependencies between different categorical attributes.
   
Main Points:
- Investigate correlations and differences among variables to uncover insights.
- Analyze scatter plots for visual trends and identify potential anomalies.
- Take note of significant relationships for future analysis, especially concerning the target variable.

#### Outlier Analysis:
1. Outlier Detection for Numeric Variables:
   - For Normally Distributed Data: Use box plots, z-scores, and statistical tests to identify outliers.
   - For Non-Normally Distributed Data: Apply IQR method to detect outliers.
   
2. Deciding Which Outliers to Omit:
   - Test differences between original and outlier-free data to decide whether to omit outliers.
   - Use T-tests or KS tests to evaluate changes in statistical measures due to outliers.
   
3. Outlier Treatment:
   - Apply transformations to mitigate outlier impact (e.g., logarithmic transformation).
   - Consider imputation or stratification to handle outliers.
   
Main Points:
- Detects outliers using appropriate methods based on data distribution.
- Decide whether to remove outliers or apply transformations.
- Take note of changes in distribution and correlation due to outlier removal.

#### Missing Data Analysis:
1.  Visualize missing data patterns using heat maps or plots to understand the extent and location of missing values.
   - Perform tests to determine whether missingness is completely at random (MCAR), at random (MAR), or not at random (MNAR).
   
2. Divide the data into 3 groups according to the percentage of missing data in each column.
Below 40% - check the missing mechanism and impute (MAR) / change to categorical (MNAR) according to the results. 
Between 40-70 % - convert to categorical columns based on the IQR  method
Above 70% - drop the column or replace it with a missing indicator if the column contain information that we want to preserve
   
Main Points:
- Visualize missing data patterns and assess missing data mechanisms.
- Apply appropriate imputation methods based on the nature of missingness.
  
## Models

### Model Development Strategy:

Data Division:
We plan to divide the data into training, validation, and test sets using a test-train split approach. The dataset will be divided into 80% training and 20% test data. From the training data, we will further allocate 20% as a validation set for tuning hyperparameters and evaluating the model's performance during development.

Balancing Data:
Due to the imbalance in the target variable (instances of payment difficulties being relatively low), we intend to balance the data. We will utilize the Synthetic Minority Over-sampling Technique (SMOTE) to generate synthetic samples of the minority class (payment difficulties). This will enhance the model's ability to capture the nuances of the minority class and improve its overall performance, particularly in terms of recall.

Stratification/Subsampling:
Stratification will be applied during the train-test split and SMOTE process. Stratified sampling ensures that the distribution of classes is maintained in both the training and test sets. Additionally, SMOTE will oversample the minority class while considering the characteristics of the majority class, further mitigating class imbalance.

Outcome Modeling Techniques:
We will focus on classification techniques for modeling the outcome, given the binary nature of the target variable (payment difficulties or not). Unsupervised techniques won't be applicable in this context, and regression is not suitable for predicting a categorical outcome.

Cross-Validation and Bootstrap:
Given the large dataset, we won't employ cross-validation or bootstrap techniques. These methods are typically used to maximize the use of limited data by repeatedly resampling. With a substantial dataset, a single train-test split and SMOTE procedure should provide ample data for effective model training and validation.

Model Evaluation Measures:
The primary evaluation metric for the model will be recall. Recall is vital in this context as it focuses on minimizing false negatives, ensuring that instances of payment difficulties are not overlooked. A missed instance of payment difficulty (false negative) could have more severe consequences than a false positive, making recall the ideal metric to prioritize in this loan prediction scenario.

Ensemble vs. Best Model:
We plan to evaluate the performance of individual models and then explore the possibility of using ensemble techniques. Ensembling can combine predictions from multiple models to potentially enhance overall predictive accuracy. However, our decision to use an ensemble will depend on the relative performance of individual models and the potential gains in prediction.

## Results

We initially had a dataset with 307,511 rows and 203 features. After applying feature engineering techniques, we reduced the dataset to 306,531 rows while retaining only 39 relevant features.

Before addressing data imbalance issues, our dataset was divided into three subsets:

Training Data: 196,179 rows with 39 features.
Testing Data: 61,307 rows with the same 39 features.
Validation Data: 49,045 rows, again with the same 39 features.
To mitigate data imbalance concerns, we undertook data balancing techniques, resulting in the following dataset sizes:

Training Data (Balanced): Expanded to 360,642 rows, maintaining the 39 features.
Testing Data (Unchanged): 61,307 rows with the same 39 features.
Validation Data (Unchanged): 49,045 rows with the same 39 features.

Outliers Handling:

We addressed outliers in the dataset using various strategies, including log transformation, depending on the nature of the data. Here's a summary:
Log Transformation: Applied to 5 features.
Log Transformation for Non-Negative Values: Employed for 12 features.
Log Transformation for Values Between 0-1: Utilized for 10 features.
Log Transformation with Shift to Avoid 0: Applied to 8 features.
Replaced Outliers with NaN: Done for 76 features.

Missing Data Handling:

To deal with missing data, we utilized the following techniques:
Addition of Missing Category: Introduced for 31 features.
Creation of IQR Quartiles: Utilized for 78 features.
Creation of Missing Indicators: Introduced for 4 features.
Feature Dropping: Removed 14 features.
Imputation for Categorical Features: Performed for 1 feature.
Imputation for Numerical Features: Executed for 6 features.

Advanced Techniques:

In addition to these preprocessing steps, we also attempted more advanced techniques such as Principal Component Analysis (PCA), log transformation, and multivariate analysis to further enhance our dataset's quality and prepare it for our final project. These techniques may help us uncover valuable insights and patterns in the data, which will be crucial for our project's success.

Models:
We initially ran several classification models to determine the one with the highest recall score, and Random Forest emerged as the top performer. Following hyperparameter tuning, we fine-tuned the selected model with the optimal parameters. When we tested this refined model, it achieved an impressive recall score of 0.91.

## Challenges

Data Volume and Variables Amount: When dealing with a large dataset, computational resources, processing time, and storage capacity become significant challenges. Processing such vast amounts of data can be slow and resource-intensive. Additionally, large datasets may require careful sampling or dimensionality reduction techniques to ensure that the model can handle the data efficiently without compromising important information.

Understanding Variables: The challenge here lies in comprehending the meaning and significance of each variable (feature) within the dataset. Poorly documented or ambiguous variables can hinder the feature engineering process and make it difficult to draw meaningful insights from the data. Addressing this challenge requires thorough data exploration, consultation with domain experts, and robust documentation to ensure that variables are correctly interpreted and utilized.

Imbalanced Data: Imbalanced data presents a challenge in classification tasks where one class significantly outnumbers the others. This imbalance can lead to model bias, where the model tends to favor the majority class and performs poorly on the minority class. The challenge is to find effective strategies to overcome this bias, such as oversampling, undersampling, or using specialized algorithms. Additionally, choosing appropriate evaluation metrics, beyond accuracy, is crucial when dealing with imbalanced data to assess the model's performance accurately.





