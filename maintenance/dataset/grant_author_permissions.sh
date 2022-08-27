#!/bin/bash

# To describe AWS_ACCOUNT_ID in .dev
source ../../.env

data_set_ids=(
"data_set_id_1"
"data_set_id_2"
)

for user_arn in "${USER_ARN[@]}" ; do
  for data_set_id in "${data_set_ids[@]}" ; do
    aws quicksight update-data-set-permissions \
              --aws-account-id $AWS_ACCOUNT_ID \
              --data-set-id "${data_set_id}" \
              --grant-permissions Principal=${user_arn},Actions=quicksight:DescribeDataSet,quicksight:DescribeDataSetPermissions,quicksight:PassDataSet,quicksight:DescribeIngestion,quicksight:ListIngestions,quicksight:UpdateDataSet,quicksight:DeleteDataSet,quicksight:CreateIngestion,quicksight:CancelIngestion,quicksight:UpdateDataSetPermissions | jq .
  done
done