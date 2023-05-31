#!/bin/bash

# To create .env and describe AWS_ACCOUNT_ID, DASHBOARDS_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Dashboards ==========================================="
echo "${DASHBOARDS_IDS[@]}"
echo "==============================================================================================="

while true; do
    read -p "Do you wish to delete the dashboards? (y/n): " yn
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
    for dashboard_id in "${DASHBOARDS_IDS[@]}" ; do
        aws quicksight delete-dashboard \
        --aws-account-id $AWS_ACCOUNT_ID \
        --dashboard-id "${dashboard_id}" | jq .
    done
else
    for dashboard_id in "${DASHBOARDS_IDS[@]}" ; do
        aws quicksight delete-dashboard \
        --aws-account-id $AWS_ACCOUNT_ID \
        --profile $profile
        --dashboard-id "${dashboard_id}" | jq .
    done
fi