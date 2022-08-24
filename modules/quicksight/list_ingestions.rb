module Quicksight
  class ListIngestions
    def initialize(profile, data_set_id)
      @profile= profile
      @data_set_id = data_set_id
    end

    def execute
      if @profile == "ngydv"
        resp = `aws quicksight list-ingestions \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --data-set-id #{@data_set_id}`
      else
        resp = `aws quicksight list-ingestions \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --data-set-id #{@data_set_id} \
        --profile #{@profile}`
      end

      resp = JSON.parse(resp)

      if !resp || !resp['Ingestions']
        warn '===== Command failed: aws quicksight list-ingestions ====='
        exit(1)
      end

      resp
    end
  end
end