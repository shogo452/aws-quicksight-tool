module Quicksight
  class ListAnalyses
    def initialize(profile)
      @profile= profile
    end

    def execute
      if @profile == "ngydv"
        resp = `aws quicksight list-analyses \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']}`
      else
        resp = `aws quicksight list-analyses \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --profile #{@profile}`
      end

      resp = JSON.parse(resp) 

      if !resp || !resp['AnalysisSummaryList']
        warn '===== Command failed: aws quicksight list-analyses ====='
        exit(1)
      end

      resp
    end
  end
end