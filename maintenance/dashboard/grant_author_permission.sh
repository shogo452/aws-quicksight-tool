#!/bin/bash

# To create .env and describe AWS_ACCOUNT_ID, USER_ARNS, DASHBOARD_IDS.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/.env

IFS=$'\n'
echo "========================================== Users =============================================="
for user_arn in "${USER_ARNS[@]}" ; do
  echo "${user_arn}"
done
echo "========================================== Dashboards ========================================="
for dashboard_id in "${DASHBOARD_IDS[@]}" ; do
  echo "${dashboard_id}"
done
echo "==============================================================================================="

while true; do
    read -p "Do you wish to grant author permissions to the users for the dashboards? (y/n): " yn
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
  for user_arn in "${USER_ARNS[@]}" ; do
    for dashboard_id in "${DASHBOARD_IDS[@]}" ; do
      aws quicksight update-dashboard-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --dashboard-id ${dashboard_id} \
                --grant-permissions Principal=${user_arn},Actions=quicksight:DescribeDashboard,quicksight:ListDashboardVersions,quicksight:UpdateDashboardPermissions,quicksight:QueryDashboard,quicksight:UpdateDashboard,quicksight:DeleteDashboard,quicksight:DescribeDashboardPermissions,quicksight:UpdateDashboardPublishedVersion | jq .
    done
  done
else
  for user_arn in "${USER_ARNS[@]}" ; do
    for dashboard_id in "${DASHBOARD_IDS[@]}" ; do
      aws quicksight update-dashboard-permissions \
                --aws-account-id $AWS_ACCOUNT_ID \
                --profile $profile \
                --dashboard-id ${dashboard_id} \
                --grant-permissions Principal=${user_arn},Actions=quicksight:DescribeDashboard,quicksight:ListDashboardVersions,quicksight:UpdateDashboardPermissions,quicksight:QueryDashboard,quicksight:UpdateDashboard,quicksight:DeleteDashboard,quicksight:DescribeDashboardPermissions,quicksight:UpdateDashboardPublishedVersion | jq .
    done
  done
fi
