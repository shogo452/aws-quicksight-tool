#!/bin/bash

# To create .env and describe AWS_ACCOUNT_ID, USER_ARNS, ANALYSES_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Users =============================================="
echo "${USER_ARNS[@]}"
echo "========================================== Analyses ==========================================="
echo "${ANALYSES_IDS[@]}"
echo "==============================================================================================="

while true; do
    read -p "Do you wish to revoke author permissions to the users for the analyses? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 0;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo 'Please input your profile.'
echo -n 'PROFILE: '
read profile

if [ $profile = 'ngydv' ]; then
  for user_arn in "${USER_ARNS[@]}" ; do
    for analysis_id in "${ANALYSES_IDS[@]}" ; do
      aws quicksight update-analysis-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --analysis-id ${analysis_id} \
                --revoke-permissions Principal=${user_arn},Actions=quicksight:RestoreAnalysis,quicksight:UpdateAnalysisPermissions,quicksight:DeleteAnalysis,quicksight:QueryAnalysis,quicksight:DescribeAnalysisPermissions,quicksight:DescribeAnalysis,quicksight:UpdateAnalysis | jq .
    done
  done
else
  for user_arn in "${USER_ARNS[@]}" ; do
    for analysis_id in "${ANALYSES_IDS[@]}" ; do
      aws quicksight update-analysis-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --profile $profile \
                --analysis-id ${analysis_id} \
                --revoke-permissions Principal=${user_arn},Actions=quicksight:RestoreAnalysis,quicksight:UpdateAnalysisPermissions,quicksight:DeleteAnalysis,quicksight:QueryAnalysis,quicksight:DescribeAnalysisPermissions,quicksight:DescribeAnalysis,quicksight:UpdateAnalysis | jq .
    done
  done
fi