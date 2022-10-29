#!/bin/bash

# To create .env and describe AWS_ACCOUNT_ID, DATASOURCE_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Datasources ==========================================="
for data_source_id in "${DATASOURCE_IDS[@]}" ; do
    echo "${data_source_id}"
done
echo "==============================================================================================="

while true; do
    read -p "Do you wish to delete the datasources? (y/n): " yn
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
    for data_source_id in "${DATASOURCE_IDS[@]}" ; do
        aws quicksight delete-data-source \
                    --aws-account-id $AWS_ACCOUNT_ID \
                    --data-source-id "${data_source_id}" | jq .
    done
else
    for data_source_id in "${DATASOURCE_IDS[@]}" ; do
        aws quicksight delete-data-source \
                    --aws-account-id $AWS_ACCOUNT_ID \
                    --profile $profile \
                    --data-source-id "${data_source_id}" | jq .
    done
fi