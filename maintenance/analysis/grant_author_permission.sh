#!/bin/bash

# To describe AWS_ACCOUNT_ID in maintenance/.dev
source ./maintenance/.env
source ./maintenance/.target_resources

for administrator_arn in "${ADMIN_ARNS[@]}" ; do
  for analysis_id in "${ANALYSIS_IDS[@]}" ; do
    aws quicksight update-analysis-permissions \
              --aws-account-id $AWS_ACCOUNT_ID \
              --analysis-id ${analysis_id} \
              --grant-permissions Principal=${administrator_arn},Actions=quicksight:RestoreAnalysis,quicksight:UpdateAnalysisPermissions,quicksight:DeleteAnalysis,quicksight:QueryAnalysis,quicksight:DescribeAnalysisPermissions,quicksight:DescribeAnalysis,quicksight:UpdateAnalysis
  done
done
