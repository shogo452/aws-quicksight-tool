#!/bin/bash

# To create .dev and describe AWS_ACCOUNT_ID, USER_ARNS, DATASET_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Users =============================================="
for user_arn in "${USER_ARNS[@]}" ; do
  echo "${user_arn}"
done
echo "========================================== Datasets ==========================================="
for data_set_id in "${DATASET_IDS[@]}" ; do
  echo "${data_set_id}"
done
echo "==============================================================================================="

while true; do
    read -p "Do you wish to change author permissions to reader permissions for the datasets? (y/n): " yn
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
    echo "USER_ARN: ${user_arn}"
    for data_set_id in "${DATASET_IDS[@]}" ; do
      echo "DATASET_ID: ${data_set_id}"

      echo "=========== Before ==========="
      aws quicksight describe-data-set-permissions --aws-account-id=720333470894  --data-set-id=$DATASET_ID | jq .Permissions

      echo "=========== Status to revoke author permissions ==========="
      aws quicksight update-data-set-permissions \
          --aws-account-id $AWS_ACCOUNT_ID \
          --data-set-id ${data_set_id} \
          --revoke-permissions Principal=${user_arn},Actions=quicksight:DescribeDataSet,quicksight:DescribeDataSetPermissions,quicksight:PassDataSet,quicksight:DescribeIngestion,quicksight:ListIngestions,quicksight:UpdateDataSet,quicksight:DeleteDataSet,quicksight:CreateIngestion,quicksight:CancelIngestion,quicksight:UpdateDataSetPermissions | jq .Status

      echo "=========== Status to grant reader permissions ==========="
      aws quicksight update-data-set-permissions \
          --aws-account-id $AWS_ACCOUNT_ID \
          --data-set-id ${data_set_id} \
          --grant-permissions Principal=${user_arn},Actions=quicksight:PassDataSet,quicksight:DescribeIngestion,quicksight:DescribeDataSet,quicksight:DescribeDataSetPermissions,quicksight:ListIngestions | jq .Status
      
      echo "=========== After ==========="
      aws quicksight describe-data-set-permissions --aws-account-id=720333470894  --data-set-id=$DATASET_ID | jq .Permissions
    done
  done
else
  for user_arn in "${USER_ARNS[@]}" ; do
    echo "USER_ARN: ${user_arn}"
    for data_set_id in "${DATASET_IDS[@]}" ; do
      echo "DATASET_ID: ${data_set_id}"

      echo "=========== Before ==========="
      aws quicksight describe-data-set-permissions --aws-account-id=720333470894 --profile $profile --data-set-id=$DATASET_ID | jq .Permissions

      echo "=========== Status to revoke author permissions ==========="
      aws quicksight update-data-set-permissions \
          --aws-account-id $AWS_ACCOUNT_ID \
          --profile $profile \
          --data-set-id ${data_set_id} \
          --revoke-permissions Principal=${user_arn},Actions=quicksight:DescribeDataSet,quicksight:DescribeDataSetPermissions,quicksight:PassDataSet,quicksight:DescribeIngestion,quicksight:ListIngestions,quicksight:UpdateDataSet,quicksight:DeleteDataSet,quicksight:CreateIngestion,quicksight:CancelIngestion,quicksight:UpdateDataSetPermissions | jq .Status

      echo "=========== Status to grant reader permissions ==========="
      aws quicksight update-data-set-permissions \
          --aws-account-id $AWS_ACCOUNT_ID \
          --profile $profile \
          --data-set-id ${data_set_id} \
          --grant-permissions Principal=${user_arn},Actions=quicksight:PassDataSet,quicksight:DescribeIngestion,quicksight:DescribeDataSet,quicksight:DescribeDataSetPermissions,quicksight:ListIngestions | jq .Status
      
      echo "=========== After ==========="
      aws quicksight describe-data-set-permissions --aws-account-id=720333470894 --profile $profile --data-set-id=$DATASET_ID | jq .Permissions
    done
  done
fi
