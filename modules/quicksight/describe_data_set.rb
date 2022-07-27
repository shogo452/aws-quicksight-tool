module Quicksight
  class DescribeDataSet
    def initialize(profile, data_set_id)
      @profile= profile
      @data_set_id = data_set_id
    end

    def execute
      if @profile == "ngydv"
        resp = `aws quicksight describe-data-set \
        --aws-account-id #{ENV['QA_TOOL_AWS_ACCOUNT_ID']} \
        --data-set-id #{@data_set_id}`
      else
        resp = `aws quicksight describe-data-set \
        --aws-account-id #{ENV['QA_TOOL_AWS_ACCOUNT_ID']} \
        --data-set-id #{@data_set_id} \
        --profile #{@profile}`
      end

      resp = JSON.parse(resp)

      if !resp || !resp['DataSet']
        puts "===== Command failed: aws quicksight describe-data-set, data_set_id: #{@data_set_id} ====="
        return nil
      end

      resp
    rescue StandardError => e
      puts "===== Command failed: aws quicksight describe-data-set, data_set_id: #{@data_set_id}, error: #{e}  ====="
      return nil
    end
  end
end