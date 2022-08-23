[dashboard]dashboard_id_1 : dashboard_name_id_1
└ [analysis]analysis_id_1 : analysis_name_1
    ├── [dataset]data_set_id_1 : data_set_name_1
    │       ├── data_set_id_7 : data_set_name_7
    │       └── data_set_id_8 : data_set_name_8
    ├── data_set_id_2 : data_set_name_2
    └── data_set_id_3 : data_set_name_3
dashboard_id_2 : dashboard_name_id_2
└ analysis_id_2 : analysis_id_2
    ├── data_set_id_4 : data_set_name_4
    ├── data_set_id_5 : data_set_name_5
    └── data_set_id_6 : data_set_name_6

├── README.md
├── cmd
│   ├── get_dashboard_tree
│   └── get_data_set_list
└── modules
    └── quicksight
        ├── describe_dashboard.rb
        ├── describe_data_set.rb
        ├── describe_data_set_permissions.rb
        ├── list_data_sets.rb
        └── list_namespaces.rb

{ dashboard_id: "hogehoge", dashboard_name: "hogehoge", analysis_id: "hogehoge", analysis_name: "fugafuga", 
datasets: { data_set_id_1: data_set_name_1_label, data_set_id_2, data_set_name_2_label, data_set_id_3 : data_set_name_3_label }, dataset_children: { data_set_id_1: [data_set_id_4_lanel] }
}
