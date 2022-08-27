# aws-quicksight-tool

aws-quicksight-tool assists in the use of the AWS QuickSight CLI.

The following things can be performed with it.

* Output a CSV listing of QuickSight data sets by namespace, and the spice capacity of each data set
* Tree-like output of relationships between assets such as dashboards and analyses and datasets
* Tabular output of import history into SPICE for a single data set

## Prerequisites and Preparation

### Prerequisites

* Import Mode of Dataset：SPICE
* Datasets are created with datasource of Aurora or Athena etc. and supported the Describe Data Set API
  * Datasource based on CSV is not supported as of 2022/7/24.

### Setting Environment Variables

* To Set [named profiles for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
* To set your AWS account credentials in environment variables.

  ```txt
  vim ~/.zshrc
  ```

  ```
  # ~/.zshrc
  export QS_TOOL_AWS_ACCOUNT_ID={AWS_ACCOUNT_ID}
  ```

  ```txt
  source ~/.zshrc
  ```
  
  ```txt
  touch .env
  vim .env
  ```
  
  ```
  # .env
  AWS_ACCOUNT_ID={AWS_ACCOUNT_ID}
  ```

### Applying an own naming rules

* If you have arbitrarily numbered the dataset ID to identify the namespace to which the dataset belongs, to reflect the numbering rule in the script.
* Example of a numbering rule
  * default namespace: use the prefix "staging-" to distinguish it for staging environments.
  * Multi-tenant separate namespace: use the prefix such as "tenant-1-".
* If you do not use namespaces and do not have your own numbering rules, you do not need to take any special action.

## Usage : Output CSV list

### Command

```txt
cmd/get_data_set_list -h
Usage: To get data set lists on AWS QuickSight
    -p, --profile PROFILE_NAME       AWS profile name (Required)
    -o, --only-named                 only named datasets (Optional, default: false)
    -n, --namespace NAMESPACE        Namespace (Optional)
    -h, --help                       Show help.

cmd/get_data_set_list --profile=<profile>
```

### Outputs

#### outputs/ListDataSets.csv

The following list is output.

|namespace|data_set_id|data_set_name|spice_capacity|permissions_to_default|created_at|last_updated_at|
|:----|:----|:----|:----|:----|:----|:----|
|default|data_set_id_1|data_set_name_1|0.047563[GB]|✅|2022-06-20 18:44:10|2022-07-24 05:17:34|
|tenant-1|data_set_id_2|data_set_name_2|0.016687[GB]|-|2022-07-20 11:01:46|2022-07-24 05:18:10|
|tenant-2|data_set_id_3|data_set_name_3|0.056743[GB]|-|2022-07-20 11:01:46|2022-07-24 05:18:10|

#### outputs/ListDataSetNames.txt

The string of the data set ID targeted for output is also output as a text file as shown below. Please use it for batch processing in shell scripts, etc.

```txt
'data_set_id_1',
'data_set_id_2',
'data_set_id_3',
```

### Options

#### --namespace

To use when you want to list data sets that have been given permissions in a specific namespace.

```txt
cmd/get_data_set_list --profile=<profile> --namespace=tenant-1
```

#### --only-named

To use when you want to list data sets whose data set IDs are numbered with your own numbering rules.

```txt
cmd/get_data_set_list --profile=<profile> --only-named
```

## Usage : Tree view of dashboard and belonged assets

### Command

```txt
cmd/get_dashboard_tree -h
Usage: To get dashboard tree with analysis and datasets on AWS QuickSight
    -p, --profile PROFILE_NAME       AWS profile name (Required)
    -d, --dashboard-id DASHBOARD_ID  Dashboard ID (Optional)
    -h, --help                       Show help.

cmd/get_dashboard_tree --profile=<profile>
```

### Output

#### **outputs/DashboardTree.txt**

The following text is output.

```txt
[dashboard] dashboard_id_1 : dashboard_name_id_1
└ [analysis] analysis_id_1 : analysis_name_1
    ├── [dataset] data_set_id_1 : data_set_name_1
    │       ├── [dataset] data_set_id_7 : data_set_name_7
    │       └── [dataset] data_set_id_8 : data_set_name_8
    ├✕─ [dataset] data_set_id_2 (🚨 Not Found)
    └── [dataset] data_set_id_3 : data_set_name_3

[dashboard] dashboard_id_2 : dashboard_name_id_2
└ [analysis] analysis_id_2 : analysis_id_2
    ├── [dataset] data_set_id_4 : data_set_name_4
    ├── [dataset] data_set_id_5 : data_set_name_5
    └── [dataset] data_set_id_6 : data_set_name_6
```

## Usage : Tree view of analysis and belonged datasets

This command also can be output an analysis not published to any dashboards.

### Command

```txt
cmd/get_analysis_tree -h
Usage: To get analysis tree with datasets on AWS QuickSight
    -p, --profile PROFILE_NAME       AWS profile name (Required)
    -a, --analysis-id ANALYSIS_ID    Analysis ID (Optional)
    -h, --help                       Show help.

cmd/get_analysis_tree --profile=<profile>
```

### Output

#### **outputs/AnalysisTree.txt**

The following text is output.

```txt
[analysis] analysis_id_1 : analysis_name_1
 ├── [dataset] data_set_id_2 : data_set_name_2
 │      ├── [dataset] data_set_id_4 : data_set_name_4
 │      └── [dataset] data_set_id_5 : data_set_name_5
 ├── [dataset] data_set_id_3 : data_set_name_3
 │      ├── [dataset] data_set_id_6 : data_set_name_6
 │      └── [dataset] data_set_id_7 : data_set_name_7
 └✕─ [dataset] data_set_id_8 (🚨 Not Found)

[analysis] analysis_id_2 : analysis_name_2
 └── [dataset] data_set_id_9 : data_set_name_9
```

### Options

#### --analysis-id

```txt
cmd/get_analysis_tree --profile=<profile> --analysis-id=<analysis-id>
```

## Usage : Output import history of SPICE

### Command

```txt
cmd/get_ingestion_history -h                                                       
Usage: To get ingestion history on AWS QuickSight
    -p, --profile PROFILE_NAME       AWS profile name (Required)
    -d, --dataset-id DATASET_ID      Dataset ID (Required)
    -l, --limit LIMIT                Limit (Optional)
    -h, --help                       Show help.

cmd/get_ingestion_history --profile=<profile> --dataset-id=<dataset_id>
```

### Output

```txt
+--------------------------------------+---------------------+------------+-----------------------+
| Ingesion ID                          | Ingestion At        | Total Rows | Ingestion Size [GB]   |
+--------------------------------------+---------------------+------------+-----------------------+
| aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee | 2022-08-24 12:05:24 | 174        | 2.488028258085251e-05 |
| ffffffff-gggg-hhhh-iiii-jjjjjjjjjjjj | 2022-08-24 11:10:29 | 174        | 2.488028258085251e-05 |
| kkkkkkkk-llll-mmmm-nnnn-oooooooooooo | 2022-08-24 05:15:22 | 174        | 2.488028258085251e-05 |
| pppppppp-qqqq-rrrr-ssss-tttttttttttt | 2022-08-23 05:15:13 | 137        | 1.936499029397964e-05 |
| uuuuuuuu-vvvv-wwww-xxxx-yyyyyyyyyyyy | 2022-08-22 09:12:07 | 137        | 1.936499029397964e-05 |
+--------------------------------------+---------------------+------------+-----------------------+
```

### Options

#### --limit

```txt
cmd/get_ingestion_history --profile=<profile> --dataset-id=<dataset_id> --limit=<number>
```
