# aws-quicksight-tool

aws-quicksight-toolは、AWS QuickSightのCLIを補助するためのツールです。
名前空間別のデータセット一覧をCSV出力することができます。またデータセット別のSPICE使用量を一覧化できます。

quicksight-tool assists in the use of the AWS QuickSight CLI.
It can output a CSV listing of QuickSight data sets by namespace, and the spice capacity of each data set.

## Prerequisites and Preparation

### Prerequisites

* データセットのインポートモード：SPICE
* QuickSightのCLIのdescribe-data-setを利用できるデータソースを利用したデータセット群
  * 利用可能なデータソースの例：Aurora, Athenaなど(CSVは2022/7/24時点で対応していない。)

### Setting Environment Variables

* [AWS CLI の名前付きプロファイル](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-profiles.html)を設定してください。
* AWSのアカウント情報を環境変数に設定してください。

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

* データセットが属している名前空間を識別するためにデータセットIDに任意で付番を行っている場合は、その付番ルールをスクリプトに反映してください。
* 付番ルールの例
  * defaultの名前空間:ステージング環境用として区別するために接頭語「staging-」を使用。
  * マルチテナント別の名前空間：接頭語「tenant-1-」を使用。
* 名前空間を利用していないかつ独自の付番ルールが無い場合は、特に対応不要です。

## Usage

### Command

```txt
cmd/get_data_set_list --profile=<profile>
(cmd/get_data_set_list -p <profile>)
```

### Outputs

#### **outputs/ListDataSets.csv**

以下のようなリストが出力されます。

|namespace|data_set_id|data_set_name|spice_capacity|permissions_to_default|created_at|last_updated_at|
|:----|:----|:----|:----|:----|:----|:----|
|default|data_set_id_1|data_set_name_1|0.047563[GB]|✅|2022-06-20 18:44:10|2022-07-24 05:17:34|
|tenant-1|data_set_id_2|data_set_name_2|0.016687[GB]|-|2022-07-20 11:01:46|2022-07-24 05:18:10|
|tenant-2|data_set_id_3|data_set_name_3|0.056743[GB]|-|2022-07-20 11:01:46|2022-07-24 05:18:10|

#### **outputs/ListDataSetNames.txt**

以下のように出力対象になったデータセットIDの文字列もテキストファイルで出力されます。シェルスクリプトなどの一括処理などに利用ください。

```txt
'data_set_id_1',
'data_set_id_2',
'data_set_id_3',
```

## Options

### --namespace

特定の名前空間にpermissionsが付与されているデータセットを一覧化したい場合に利用。

```txt
cmd/get_data_set_list --profile=<profile> --namespace=tenant1
(cmd/get_data_set_list -p <profile> -n tenant1)
```

### --only-named

独自の付番規則でデータセットIDが付番されているデータセットを一覧化したい場合に利用。

```txt
cmd/get_data_set_list --profile=<profile> --only-named
(cmd/get_data_set_list -p <profile> -on)
```
