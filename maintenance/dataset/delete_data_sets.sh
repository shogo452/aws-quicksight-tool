#!/bin/bash

# To describe AWS_ACCOUNT_ID in maintenance/.dev
source ./maintenance/.env

# To describe ANALYSIS_IDS in maintenance/.target_resources
source ./maintenance/.target_resources

for data_set_id in "${DATASET_IDS[@]}" ; do
  aws quicksight delete-data-set \
            --aws-account-id $AWS_ACCOUNT_ID \
            --data-set-id "${data_set_id}" | jq .
done