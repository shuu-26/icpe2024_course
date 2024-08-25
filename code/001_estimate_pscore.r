###################################################################################
#
# 001: Estimate propensity score 
# 
# Author(s): John Tazare
# Purpose: This script is to import processed data and estimate propensity scores
# Outputs of this script:
# - Processed dataset: ./data/data_processed.rds
# 
###################################################################################

# Load libraries --------------------------------------------------------------
library(dbplyr)
library(tidyverse)

# Load libraries --------------------------------------------------------------
data_processed <- read_csv("data/data_processed.csv")

# Estimate propensity scores --------------------------------------------------

# Specify logistic regression model
# Note: treatment is the variable name defining treatment groups
psModel <- glm(treatment ~ age + sex + prior_copd + prior_cvd + bmi + deprivation_score , family=binomial(), data= data_processed) 

# Append patient-level estimated propensity score (pscore) to data_processed 
data_processed$pscore <- predict(psModel, type = "response")