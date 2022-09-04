#!/bin/bash

# To create .env and describe AWS_ACCOUNT_ID, ANALYSES_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Analyses ==========================================="
echo "${ANALYSES_IDS[@]}"
echo "==============================================================================================="

while true; do
    read -p "Do you wish to delete the analyses? (y/n): " yn
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
    for analysis_id in "${ANALYSES_IDS[@]}" ; do
        aws quicksight delete-analysis \
        --aws-account-id $AWS_ACCOUNT_ID \
        --analysis-id "${analysis_id}" | jq .
    done
else
    for analysis_id in "${ANALYSES_IDS[@]}" ; do
        aws quicksight delete-analysis \
        --aws-account-id $AWS_ACCOUNT_ID \
        --profile $profile
        --analysis-id "${analysis_id}" | jq .
    done
fi