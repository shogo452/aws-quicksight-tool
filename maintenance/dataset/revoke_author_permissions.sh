#!/bin/bash

# To describe AWS_ACCOUNT_ID in maintenance/.dev
source ./maintenance/.env

# To describe ANALYSIS_IDS in maintenance/.target_resources
source ./maintenance/.target_resources

for user_arn in "${ADMIN_ARNS[@]}" do
  for data_set_id in "${DATASET_IDS[@]}" do
    aws quicksight update-data-set-permissions \
              --aws-account-id $AWS_ACCOUNT_ID \
              --data-set-id "${data_set_id}" \
              --revoke-permissions Principal=${user_arn},Actions=quicksight:DescribeDataSet,quicksight:DescribeDataSetPermissions,quicksight:PassDataSet,quicksight:DescribeIngestion,quicksight:ListIngestions,quicksight:UpdateDataSet,quicksight:DeleteDataSet,quicksight:CreateIngestion,quicksight:CancelIngestion,quicksight:UpdateDataSetPermissions | jq .
  done
done