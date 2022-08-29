#!/bin/bash

# To describe AWS_ACCOUNT_ID in maintenance/.dev
source ../.env

analysis_ids=(
"analysis_id_1"
"analysis_id_2"
)

for administrator_arn in "${administrator_arns[@]}" ; do
  for analysis_id in "${analysis_ids[@]}" ; do
    aws quicksight update-analysis-permissions \
              --aws-account-id $AWS_ACCOUNT_ID \
              --analysis-id ${analysis_id} \
              --grant-permissions Principal=${administrator_arn},Actions=quicksight:RestoreAnalysis,quicksight:UpdateAnalysisPermissions,quicksight:DeleteAnalysis,quicksight:QueryAnalysis,quicksight:DescribeAnalysisPermissions,quicksight:DescribeAnalysis,quicksight:UpdateAnalysis
  done
done
