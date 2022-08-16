# aws-quicksight-tool

aws-quicksight-tool assists in the use of the AWS QuickSight CLI.
It can output a CSV listing of QuickSight data sets by namespace, and the spice capacity of each data set.

## Prerequisites and Preparation

### Prerequisites

* Import Mode of Dataset：SPICE
* Datasets are created with datasource of Aurora or Athena etc. and supported the Describe Data Set API
  * DatasourceCSV is not supported as of 2022/7/24.
  
### Setting Environment Variables

* To Set [named profiles for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
* To set your AWS account credentials in environment variables.

  ```txt
  vim .zshrc
  ```

  ```
  # .zshrc

  export QA_TOOL_AWS_REGION={REGION}
  export QA_TOOL_AWS_ACCOUNT_ID={AWS_ACCOUNT_ID}
  ```

  ```txt
  source .zshrc
  ```

### Applying an own naming rules

* If you have arbitrarily numbered the dataset ID to identify the namespace to which the dataset belongs, to reflect the numbering rule in the script.
* Example of a numbering rule
  * default namespace: use the prefix "staging-" to distinguish it for staging environments.
  * Multi-tenant separate namespace: use the prefix such as "tenant-1-".
* If you do not use namespaces and do not have your own numbering rules, you do not need to take any special action.

## Usage

### Command

```txt
cmd/get_data_set_list -h
Usage: To get data set lists on AWS QuickSight
    -p, --profile PROFILE_NAME       AWS profile name (Required)
    -o, --only-namedn                only named datasets (Optional, default: false)
    -n, --namespace NAMESPACE        Namespace (Optional)
    -h, --help                       Show help.

cmd/get_data_set_list --profile=<profile>
($ cmd/get_data_set_list -p <profile>)
```

### Outputs

#### **outputs/ListDataSets.csv**

The following list is output.

|namespace|data_set_id|data_set_name|spice_capacity|permissions_to_default|created_at|last_updated_at|
|:----|:----|:----|:----|:----|:----|:----|
|default|data_set_id_1|data_set_name_1|0.047563[GB]|✅|2022-06-20 18:44:10|2022-07-24 05:17:34|
|tenant-1|data_set_id_2|data_set_name_2|0.016687[GB]|-|2022-07-20 11:01:46|2022-07-24 05:18:10|
|tenant-2|data_set_id_3|data_set_name_3|0.056743[GB]|-|2022-07-20 11:01:46|2022-07-24 05:18:10|

#### **outputs/ListDataSetNames.txt**

The string of the data set ID targeted for output is also output as a text file as shown below. Please use it for batch processing in shell scripts, etc.

```txt
'data_set_id_1',
'data_set_id_2',
'data_set_id_3',
```

## Options

### --namespace

To use when you want to list data sets that have been given permissions in a specific namespace.

```txt
cmd/get_data_set_list --profile=<profile> --namespace=tenant1
(cmd/get_data_set_list -p <profile> -n tenant1)
```

### --only-named

To use when you want to list data sets whose data set IDs are numbered with your own numbering rules.

```txt
cmd/get_data_set_list --profile=<profile> --only-named
(cmd/get_data_set_list -p <profile> -on)
```
