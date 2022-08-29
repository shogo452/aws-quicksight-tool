#!/bin/bash

# To describe AWS_ACCOUNT_ID in maintenance/.dev
source ../.env

analysis_ids=(
"dashboard_id_1"
"dashboard_id_2"
)

for administrator_arn in "${administrator_arns[@]}" ; do
  for dashboard_id in "${dashboard_ids[@]}" ; do
    aws quicksight update-dashboard-permissions \
              --aws-account-id $AWS_ACCOUNT_ID \
              --dashboard-id ${dashboard_id} \
              --grant-permissions Principal=${administrator_arn},,Actions=quicksight:DescribeDashboard,quicksight:ListDashboardVersions,quicksight:QueryDashboard
  don
done
