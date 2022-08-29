#!/bin/bash

# To describe AWS_ACCOUNT_ID in maintenance/.dev
source ../.env

data_set_ids=(
"data_set_id_1"
"data_set_id_2"
)

for data_set_id in "${data_set_ids[@]}" ; do
  aws quicksight delete-data-set \
            --aws-account-id $AWS_ACCOUNT_ID \
            --data-set-id "${data_set_id}" | jq .
done