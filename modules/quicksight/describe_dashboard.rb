module Quicksight
  class DescribeDashboard
    def initialize(profile, dashboard_id)
      @profile= profile
      @dashboard_id = dashboard_id
    end

    def execute
      if @profile == "ngydv"
        resp = `aws quicksight describe-dashboard \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --dashboard-id #{@dashboard_id}`
      else
        resp = `aws quicksight describe-dashboard \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --dashboard-id #{@dashboard_id} \
        --profile #{@profile}`
      end

      resp = JSON.parse(resp)

      if !resp || !resp['Dashboard']
        puts "===== Command failed: aws quicksight describe-dashboard, dashboard_id: #{@dashboard_id} ====="
        return nil
      end

      resp
    rescue StandardError => e
      puts "===== Command failed: aws quicksight describe-dashboard, dashboard_id: #{@dashboard_id}, error: #{e}  ====="
      return nil
    end
  end
end