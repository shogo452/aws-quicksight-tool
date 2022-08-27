#!/bin/bash

# To describe AWS_ACCOUNT_ID in .dev
source ../../.env

namespaces=(
"namespace_1"
"namespace_2"
)

for namespace in "${namespaces[@]}" ; do
  aws quicksight delete-namespace \
            --aws-account-id $AWS_ACCOUNT_ID \
            --namespace "${namespace}" | jq .
done