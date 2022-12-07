#!/bin/bash

# To create .dev and describe AWS_ACCOUNT_ID, USER_ARNS, DATASET_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Users =============================================="
for user_arn in "${USER_ARNS[@]}" ; do
  echo "${user_arn}"
done
echo "========================================== Datasources ==========================================="
for data_source_id in "${DATASOURCE_IDS[@]}" ; do
  echo "${data_source_id}"
done
echo "==============================================================================================="

while true; do
    read -p "Do you wish to revoke author permissions to the users for the datasources? (y/n): " yn
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
    for data_set_id in "${DATASOURCE_IDS[@]}" ; do
      aws quicksight update-data-source-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --data-source-id "${data_source_id}" \
                --revoke-permissions Principal=${user_arn},Actions=quicksight:UpdateDataSourcePermissions,quicksight:DescribeDataSourcePermissions,quicksight:PassDataSource,quicksight:DescribeDataSource,quicksight:DeleteDataSource,quicksight:UpdateDataSource | jq .
    done
  done
else
  for user_arn in "${USER_ARNS[@]}" ; do
    for data_set_id in "${DATASOURCE_IDS[@]}" ; do
      aws quicksight update-data-source-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --profile $profile \
                --data-source-id "${data_source_id}" \
                --revoke-permissions Principal=${user_arn},Actions=quicksight:UpdateDataSourcePermissions,quicksight:DescribeDataSourcePermissions,quicksight:PassDataSource,quicksight:DescribeDataSource,quicksight:DeleteDataSource,quicksight:UpdateDataSource | jq .
    done
  done
fi
