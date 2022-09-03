#!/bin/bash

# To create .dev and describe AWS_ACCOUNT_ID, DATASOURCE_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Datasources ==========================================="
echo "${DATASOURCE_IDS[@]}"
echo "==============================================================================================="

while true; do
    read -p "Do you wish to delete the datasources? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 0;;
        * ) echo "Please answer yes or no.";;
    esac
done

for data_source_id in "${DATASOURCE_IDS[@]}" ; do
  aws quicksight delete-data-source \
            --aws-account-id $AWS_ACCOUNT_ID \
            --data-source-id "${data_source_id}" | jq .
done