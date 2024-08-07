### Installation
In order to run all the code related to the project, you will need to download the following libraries: 
tidytext, stringr, tidyr, SnowballC, kableExtra, textdata, openNLP, entity, caret, xgboost, glmnet.

### Running
To begin running the project, you will first need to download the data from [https://www.kaggle.com/datasets/rupindersinghrana/airbnb-price-dataset]. 
Once the data is downloaded, you are ready to begin preprocessing. 
To do this, start by running Preprocessing.Rmd. 
This will clean up the data (output is here: cleaned_data.csv) and get it ready for our natural language processing which is the next step - NLP.Rmd. 
Please note that the Named Entity Recognition step of NLP will take ~20 minutes to run. 
NLP-sentiment.Rmd is not used for our final analysis, but you are still welcome to run this if curious. 
Afterwards, you will use the outputs from NLP.Rmd (locations_df, name.csv, description.csv) to run feature selection - PCAandLASSO.Rmd. 
This concludes preprocessing and brings us to analysis.

To run the acutal analysis use the final preprocessing table (LASSOnlp.csv). 
We setup a few models - linear regression, random forest, XGBoost, and multiple linear regression. 
For linear regression, AIC, and Best Subset Regression, run LR_AIC.Rmd. 
For the random forest and XGBoost based multiple linear regression, run XGB_RF.Rmd.

### Directories
The directory structure is simple. 
The code is located in Code; the data inputs and outputs for the code are located in Data.
The final writeup can be found in Final Report.


