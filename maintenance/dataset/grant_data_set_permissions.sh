#!/bin/bash
source ./.env

for user_arn in "${USER_ARN[@]}" ; do
  for data_set_id in "${DATASET_IDS[@]}" ; do
    aws quicksight update-data-set-permissions \
              --aws-account-id $AWS_ACCOUNT_ID \
              --data-set-id "${data_set_id}" \
              --grant-permissions Principal=${user_arn},Actions=quicksight:DescribeDataSet,quicksight:DescribeDataSetPermissions,quicksight:PassDataSet,quicksight:DescribeIngestion,quicksight:ListIngestions,quicksight:UpdateDataSet,quicksight:DeleteDataSet,quicksight:CreateIngestion,quicksight:CancelIngestion,quicksight:UpdateDataSetPermissions
  done
done