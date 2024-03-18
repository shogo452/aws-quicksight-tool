#!/bin/bash

# To create .env and describe AWS_ACCOUNT_ID, DATASET_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Datasets ==========================================="
for data_set_id in "${DATASET_IDS[@]}" ; do
    echo "${data_set_id}"
done
echo "==============================================================================================="

while true; do
    read -p "Do you wish to delete the datasets? (y/n): " yn
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
    for data_set_id in "${DATASET_IDS[@]}" ; do
        aws quicksight delete-data-set \
                    --aws-account-id $AWS_ACCOUNT_ID \
                    --data-set-id "${data_set_id}" | jq .
    done
else
    for data_set_id in "${DATASET_IDS[@]}" ; do
        aws quicksight delete-data-set \
                    --aws-account-id $AWS_ACCOUNT_ID \
                    --profile $profile \
                    --data-set-id "${data_set_id}" | jq .
    done
fi
