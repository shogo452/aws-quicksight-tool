#!/bin/bash
source ../../.env

data_source_ids=(
"data_source_1"
"data_source_2"
)

for data_source_id in "${data_source_ids[@]}" ; do
  aws quicksight delete-data-source \
            --aws-account-id $AWS_ACCOUNT_ID \
            --data-source-id "${data_source_id}" | jq .
done