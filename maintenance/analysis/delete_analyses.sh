#!/bin/bash

# To create .dev and describe AWS_ACCOUNT_ID, ANALYSIS_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Analysis ==========================================="
echo "${ANALYSIS_IDS[@]}"
echo "==============================================================================================="

while true; do
    read -p "Do you wish to delete the analyses? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 0;;
        * ) echo "Please answer yes or no.";;
    esac
done

for analysis_id in "${ANALYSIS_IDS[@]}" ; do
    aws quicksight delete-analysis \
    --aws-account-id $AWS_ACCOUNT_ID \
    --analysis-id "${analysis_id}" | jq .
done