#!/bin/bash

# To describe AWS_ACCOUNT_ID in maintenance/.dev
source ../.env

analysis_ids=(
"analysis_id_1"
"analysis_id_2"
)

for analysis_id in "${analysis_ids[@]}" ; do
    aws quicksight delete-analysis \
    --aws-account-id $AWS_ACCOUNT_ID \
    --analysis-id "${analysis_id}" | jq .
done