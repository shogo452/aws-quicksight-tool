module Quicksight
  class DescribeAnalysis
    def initialize(profile, analysis_id)
      @profile= profile
      @analysis_id = analysis_id
    end

    def execute
      if @profile == "ngydv"
        resp = `aws quicksight describe-analysis \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --analysis-id #{@analysis_id}`
      else
        resp = `aws quicksight describe-analysis \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --analysis-id #{@analysis_id} \
        --profile #{@profile}`
      end

      resp = JSON.parse(resp)

      if !resp || !resp['Analysis']
        puts "===== Command failed: aws quicksight describe-analysis, analysis_id: #{@analysis_id} ====="
        return nil
      end

      resp
    rescue StandardError => e
      puts "===== Command failed: aws quicksight describe-analysis, analysis_id: #{@analysis_id}, error: #{e}  ====="
      return nil
    end
  end
end