module Quicksight
  class ListNamespaces
    def initialize(profile)
      @profile = profile
    end

    def execute
      if @profile == "ngydv"
        resp = `aws quicksight list-namespaces \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']}`
      else
        resp = `aws quicksight list-namespaces \
        --aws-account-id #{ENV['QS_TOOL_AWS_ACCOUNT_ID']} \
        --profile #{@profile}`
      end

      resp = JSON.parse(resp)

      if !resp || !resp["Namespaces"]
        warn '===== Command failed: aws quicksight list-namespaces ====='
        exit(1)
      end

      resp
    end
  end
end