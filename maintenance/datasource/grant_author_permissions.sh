#!/bin/bash

# To create .dev and describe AWS_ACCOUNT_ID, USER_ARNS, DATASOURCE_IDS.
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
    read -p "Do you wish to grant author permissions to the users for the datasources? (y/n): " yn
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
    for data_source_id in "${DATASOURCE_IDS[@]}" ; do
      aws quicksight update-data-source-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --data-source-id "${data_source_id}" \
                --grant-permissions Principal=${user_arn},Actions=quicksight:DescribeDataSource,quicksight:DescribeDataSourcePermissions,quicksight:PassDataSource,quicksight:UpdateDataSource,quicksight:DeleteDataSource,quicksight:UpdateDataSourcePermissions | jq .
    done
  done
else
  for user_arn in "${USER_ARNS[@]}" ; do
    for data_source_id in "${DATASOURCE_IDS[@]}" ; do
      aws quicksight update-data-source-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --profile $profile \
                --data-source-id "${data_source_id}" \
                --grant-permissions Principal=${user_arn},Actions=quicksight:DescribeDataSource,quicksight:DescribeDataSourcePermissions,quicksight:PassDataSource,quicksight:UpdateDataSource,quicksight:DeleteDataSource,quicksight:UpdateDataSourcePermissions | jq .
    done
  done
fi