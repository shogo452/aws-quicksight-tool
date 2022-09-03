#!/bin/bash

# To create .dev and describe AWS_ACCOUNT_ID, USER_ARNS, ANALYSIS_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Users =============================================="
echo "${USER_ARNS[@]}"
echo "========================================== Analysis ==========================================="
echo "${ANALYSIS_IDS[@]}"
echo "==============================================================================================="

while true; do
    read -p "Do you wish to revoke author permissions to the users for the analyses? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 0;;
        * ) echo "Please answer yes or no.";;
    esac
done

for user_arn in "${USER_ARNS[@]}" ; do
  for analysis_id in "${analysis_ids[@]}" ; do
    aws quicksight update-analysis-permissions \
              --aws-account-id $AWS_ACCOUNT_ID \
              --analysis-id ${analysis_id} \
              --revoke-permissions Principal=${user_arn},Actions=quicksight:RestoreAnalysis,quicksight:UpdateAnalysisPermissions,quicksight:DeleteAnalysis,quicksight:QueryAnalysis,quicksight:DescribeAnalysisPermissions,quicksight:DescribeAnalysis,quicksight:UpdateAnalysis
  done
done
