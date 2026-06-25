# ABIS — Data Model (live Oracle schema)

> **Source of truth.** Regenerated from a live Oracle data-dictionary
> dump of the **`DBO`** schema (`oracle_schema.txt`, via `tools/oracle_introspect.sql`) by
> `tools/ingest_oracle_schema.py`. This **supersedes** the earlier partial
> model inferred from ~40 DataWindows. Machine-readable form:
> [`data-model/oracle_schema.json`](data-model/oracle_schema.json).

- **412** tables · **335** with a primary key · **238** foreign keys · **82** sequences

## Table index

| Table | Rows | Cols | PK | FKs |
|---|--:|--:|---|--:|
| [`ABIS_INI`](#abis_ini) | 67 | 5 | PROCESS, SECTION, KEY | 0 |
| [`ABIS_RELEASE`](#abis_release) | 20,414 | 7 | INSTALL_COMPUTER, INSTALL_USER, CURRENT_BUILD_DTTM, NEW_BUILD_DTTM, INSTALL_DTTM, TEST_OR_PROD | 0 |
| [`ABIS_SCRAP_STATUS_X12`](#abis_scrap_status_x12) | 3 | 2 | ABIS_SCRAP_STATUS, TABLE70_MATERIAL_STATUS_OP | 0 |
| [`ABIS_SCRAP_TYPE_X12`](#abis_scrap_type_x12) | 8 | 2 | ABIS_SCRAP_TYPE, TABLE67_MATERIAL_CLASS | 0 |
| [`ABIS_X12_COIL`](#abis_x12_coil) | 9 | 4 | ABIS_COIL_STATUS, TABLE67_MATERIAL_CLASS, TABLE70_MATERIAL_STATUS_OP | 0 |
| [`ABIS_X12_SKID`](#abis_x12_skid) | 11 | 4 | ABIS_SKID_STATUS, TABLE67_MATERIAL_CLASS, TABLE70_MATERIAL_STATUS_OP | 0 |
| [`AB_AUDIT`](#ab_audit) | 0 | 4 | TABLE_NAME, USER_ID, EVENT_DATE | 0 |
| [`AB_JOB`](#ab_job) | 97,390 | 34 | AB_JOB_NUM | 3 |
| [`AB_JOB_870_HISTORY`](#ab_job_870_history) | 4,566 | 6 | AB_JOB_NUM, EDI_FILE_ID | 0 |
| [`AB_JOB_STATUS_DESC`](#ab_job_status_desc) | 5 | 2 | AB_JOB_STATUS_CODE | 0 |
| [`ALCAN_COIL_RETEST_DATE`](#alcan_coil_retest_date) | 6,045 | 2 | COIL_ORG_NUM | 0 |
| [`ALEX1`](#alex1) | 2 | 28 | — | 0 |
| [`ALLOY_DENSITY`](#alloy_density) | 41 | 2 | ALLOY_NUM | 0 |
| [`ALLOY_HEAT_TREATMENT`](#alloy_heat_treatment) | 248 | 2 | ALLOY | 0 |
| [`ALLOY_TYPE`](#alloy_type) | 45 | 3 | ALLOY, CUSTOMER_ID | 1 |
| [`ALPHABET`](#alphabet) | 26 | 2 | LETTER_NUMBER | 0 |
| [`APP_MAIN_MENU`](#app_main_menu) | 0 | 7 | ITEM_ID | 0 |
| [`AUTO_REPORT_CUSTOMERS`](#auto_report_customers) | 47 | 2 | CUSTOMER_NAME, CUSTOMER_ID | 0 |
| [`AUTO_REPORT_EMAILS`](#auto_report_emails) | 212 | 6 | REPORT_NAME, CUSTOMER_NAME, EMAIL_ADDRESS | 0 |
| [`AUTO_REPORT_RUN_LOG`](#auto_report_run_log) | 227,357 | 2 | — | 0 |
| [`AUTO_REPORT_SCHEDULE`](#auto_report_schedule) | 120 | 7 | REPORT_NAME, CUSTOMER_NAME, RUN_DAY_NAME, RUN_TIME | 0 |
| [`BARCODE_STRING`](#barcode_string) | 0 | 2 | COIL_ORG_NUM | 0 |
| [`BILLTO_ALBL_EMAIL`](#billto_albl_email) | 1 | 1 | — | 0 |
| [`CARRIER`](#carrier) | 1,004 | 13 | CARRIER_ID | 0 |
| [`CCARD`](#ccard) | 0 | 4 | CCARD_ID | 0 |
| [`CERT_LABEL_CUSTOMER`](#cert_label_customer) | 3 | 2 | CUSTOMER_CODE | 0 |
| [`CERT_LABEL_CUSTOMERS`](#cert_label_customers) | 3 | 1 | CUSTOMER_ID | 0 |
| [`CERT_LABEL_DATA_ELEMENTS`](#cert_label_data_elements) | 70 | 5 | CUSTOMER_ID, CUSTOMER_CODE, DATA_ELEMENT | 0 |
| [`CERT_LABEL_SHIPTO_NAME`](#cert_label_shipto_name) | 2 | 2 | CUSTOMER_ID | 0 |
| [`CHEMICAL_ELEMENTS`](#chemical_elements) | 118 | 2 | SYMBOL | 0 |
| [`CHEVRON`](#chevron) | 1,316 | 9 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`CIRCLE`](#circle) | 543 | 7 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`COIL`](#coil) | 149,563 | 46 | COIL_ABC_NUM | 2 |
| [`COILS_WEIGHT_ZEROED_OUT`](#coils_weight_zeroed_out) | 0 | 7 | — | 0 |
| [`COIL_EVAL_SHEET_DETAIL`](#coil_eval_sheet_detail) | 61 | 34 | AB_JOB_NUM, COIL_ORG_NUM, COIL_ABC_NUM, SKID_NUM, SHIFT, EMPLOYEE_ID, EVAL_DATE, BL_LINE | 0 |
| [`COIL_EVAL_SHEET_DETAIL2`](#coil_eval_sheet_detail2) | 56 | 34 | AB_JOB_NUM, COIL_ORG_NUM, COIL_ABC_NUM, SKID_NUM, SHIFT, EMPLOYEE_ID, EVAL_DATE, BL_LINE | 0 |
| [`COIL_EVAL_SHEET_DETAIL3`](#coil_eval_sheet_detail3) | 56 | 34 | AB_JOB_NUM, COIL_ORG_NUM, COIL_ABC_NUM, SKID_NUM, SHIFT, EMPLOYEE_ID, EVAL_DATE, BL_LINE | 0 |
| [`COIL_EVAL_SHEET_HEADER`](#coil_eval_sheet_header) | 68 | 24 | AB_JOB_NUM, COIL_ORG_NUM, COIL_ABC_NUM, SHIFT, EMPLOYEE_ID, EVAL_DATE, BL_LINE | 0 |
| [`COIL_EVAL_SHEET_SCRAP`](#coil_eval_sheet_scrap) | 77 | 14 | AB_JOB_NUM, COIL_ORG_NUM, COIL_ABC_NUM, SCRAP_CODE, SHIFT, EMPLOYEE_ID, EVAL_DATE, BL_LINE | 0 |
| [`COIL_LOG`](#coil_log) | 2 | 7 | ENTRY_NUM | 0 |
| [`COIL_LUBE_WEIGHT`](#coil_lube_weight) | 1,261 | 5 | COIL_ABC_NUM | 0 |
| [`COIL_OWNERSHIP_TRANSFER`](#coil_ownership_transfer) | 0 | 10 | COIL_ABC_NUM_ORIG | 0 |
| [`COIL_QUALITY`](#coil_quality) | 6,871 | 24 | COIL_ABC_NUM | 0 |
| [`COIL_QUALITY_FLAW_MAPPING`](#coil_quality_flaw_mapping) | 6,074 | 8 | COIL_ABC_NUM, STARTING_POSITION, ENDING_POSITION, FLAW_CODE | 0 |
| [`COIL_RECEIVING`](#coil_receiving) | 0 | 6 | COIL_ABC_NUM, BOL, CUSTOMER_ID | 2 |
| [`COIL_STATUS`](#coil_status) | 15 | 2 | — | 0 |
| [`COIL_TRACK`](#coil_track) | 93,468 | 10 | COIL_ABC_NUM, COIL_TRACK_DATE | 0 |
| [`COIL_TRACK_QA`](#coil_track_qa) | 0 | 6 | COIL_ABC_NUM, COIL_TRACK_DATE | 1 |
| [`CUSTOMER`](#customer) | 1,973 | 39 | CUSTOMER_ID | 2 |
| [`CUSTOMER_CONTACT`](#customer_contact) | 63 | 15 | CONTACT_ID | 1 |
| [`CUSTOMER_CUSTOMER`](#customer_customer) | 7 | 3 | O_CUSTOMER_ID, E_CUSTOMER_ID | 2 |
| [`CUSTOMER_CUSTOMER_EDI_CODE`](#customer_customer_edi_code) | 4 | 4 | FROM_CUSTOMER_ID, TO_CUSTOMER_ID | 2 |
| [`CUSTOMER_DUNS_XREF`](#customer_duns_xref) | 0 | 2 | CUSTOMER_NAME, CUSTOMER_DUNS_NUMBER_STRING | 0 |
| [`CUSTOMER_EDI`](#customer_edi) | 12 | 5 | CUSTOMER_EDI_NAME, CUSTOMER_ID | 2 |
| [`CUSTOMER_EDI_SCHEDULE`](#customer_edi_schedule) | 0 | 4 | SCHEDULE_ID, CUSTOMER_ID, CUSTOMER_EDI_NAME | 2 |
| [`CUSTOMER_INV_COILS_REPORT_EXT`](#customer_inv_coils_report_ext) | 1 | 2 | CUSTOMER_ID | 1 |
| [`CUSTOMER_ORDER`](#customer_order) | 48,273 | 18 | ORDER_ABC_NUM | 2 |
| [`CUSTOMER_SH_REPORT_TEMPLATES`](#customer_sh_report_templates) | 16 | 3 | CUSTOMER_ID, SHIPTO_ID, SH_REPORT_TEMPLATE_ID | 3 |
| [`CUSTOMER_SPECIAL_PARTS`](#customer_special_parts) | 20 | 4 | CUSTOMER_ID, ENDUSER_PART_NUM | 2 |
| [`CUSTOMER_SYSTEM`](#customer_system) | 34 | 10 | CUSTOMER_ID | 1 |
| [`CUSTOMER_TYPE`](#customer_type) | 8 | 2 | CUSTOMER_TYPE | 0 |
| [`CUST_SCRAP_TYPE_NEEDED`](#cust_scrap_type_needed) | 100 | 5 | CUSTOMER_ID, SCRAP_TYPE_ID | 2 |
| [`CUST_SH_DEFAULT_TEMPLATE`](#cust_sh_default_template) | 20 | 3 | SH_REPORT_TYPE_ID, CUSTOMER_ID | 2 |
| [`DATA_861`](#data_861) | 0 | 33 | CUSTOMER_ID, BOL, EDI_FILE_ID, COIL_ORG_NUM | 0 |
| [`DATA_IN_863`](#data_in_863) | 11,633 | 287 | EDI_FILE_ID, COIL_NUM | 0 |
| [`DATA_IN_863_REJECTED`](#data_in_863_rejected) | 33 | 287 | EDI_FILE_ID, COIL_NUM | 0 |
| [`DESADV_TAG`](#desadv_tag) | 57 | 2 | item | 0 |
| [`DIE`](#die) | 134 | 12 | DIE_ID | 0 |
| [`DIMPLING`](#dimpling) | 3 | 3 | DIMPLING_CODE | 0 |
| [`DT_CAUSE`](#dt_cause) | 43 | 3 | ID | 0 |
| [`DT_INSTANCE`](#dt_instance) | 345,326 | 7 | INSTANCE_NUM | 3 |
| [`DT_INSTANCE_DETAIL`](#dt_instance_detail) | 389,347 | 5 | INSTANCE_NUM, INSTANCE_ITEM | 2 |
| [`DT_SUMMARY`](#dt_summary) | 136,514 | 6 | SHIFT_NUM, AB_JOB_NUM, ID | 2 |
| [`EDGE_TRIM_TOLEARANCE`](#edge_trim_tolearance) | 1 | 2 | — | 0 |
| [`EDI_870_COIL_STATUS`](#edi_870_coil_status) | 861 | 8 | COIL_ABC_NUM, COIL_STATUS_CHANGE_DATE | 1 |
| [`EDI_DESADV_GM_LOG`](#edi_desadv_gm_log) | 0 | 3 | packing_list, line_no | 1 |
| [`EDI_FA`](#edi_fa) | 27,805 | 7 | GS_NUM | 0 |
| [`EDI_FILE_863`](#edi_file_863) | 20,805 | 7 | EDI_863_ID | 2 |
| [`EDI_INBOUND_856`](#edi_inbound_856) | 0 | 20 | EDI_INBOUND_LOG | 0 |
| [`EDI_LOG`](#edi_log) | 944 | 9 | EDI_LOG_TIMESTAMP, CUSTOMER_ID, CUSTOMER_EDI_NAME | 1 |
| [`EDI_LOG_FILE`](#edi_log_file) | 0 | 2 | timestamp | 0 |
| [`EDI_OUT_FILE`](#edi_out_file) | 838 | 7 | EDI_OUT_ID | 1 |
| [`EDI_TYPE`](#edi_type) | 4 | 3 | EDI_TYPE_ID, EDI_VERSION | 0 |
| [`EMPLOYEE`](#employee) | 6 | 5 | EMPLOYEE_ID | 0 |
| [`EMPLOYEES`](#employees) | 9 | 10 | EMPLOYEE_ID | 0 |
| [`EQUIPMENT_MODE`](#equipment_mode) | 1 | 2 | EQU_MODE | 0 |
| [`EQUIPMENT_TYPE`](#equipment_type) | 12 | 3 | EQUIPMENT_TYPE_CODE | 0 |
| [`EQUIPMENT_TYPE_CUSTOMER`](#equipment_type_customer) | 56 | 2 | CUSTOMER_ID, EQUIPMENT_TYPE_CODE | 2 |
| [`ERROR_EVT`](#error_evt) | 754 | 19 | ERROR_EVT_ID | 8 |
| [`ERROR_MESSAGE`](#error_message) | 0 | 1 | — | 0 |
| [`ERROR_TYPE`](#error_type) | 13 | 2 | ERROR_TYPE_ID | 0 |
| [`EVT_CARRIER_CONFIGURATION`](#evt_carrier_configuration) | 0 | 7 | NAME | 0 |
| [`EVT_DEST_PROFILE`](#evt_dest_profile) | 0 | 4 | — | 1 |
| [`EVT_HISTORY`](#evt_history) | 0 | 11 | — | 0 |
| [`EVT_INSTANCE`](#evt_instance) | 0 | 9 | — | 1 |
| [`EVT_MAIL_CONFIGURATION`](#evt_mail_configuration) | 0 | 5 | — | 0 |
| [`EVT_MONITOR_NODE`](#evt_monitor_node) | 0 | 2 | — | 0 |
| [`EVT_NOTIFY_STATUS`](#evt_notify_status) | 0 | 7 | — | 0 |
| [`EVT_OPERATORS`](#evt_operators) | 0 | 9 | — | 0 |
| [`EVT_OPERATORS_ADDITIONAL`](#evt_operators_additional) | 0 | 5 | — | 0 |
| [`EVT_OPERATORS_SYSTEMS`](#evt_operators_systems) | 0 | 5 | — | 0 |
| [`EVT_OUTSTANDING`](#evt_outstanding) | 0 | 10 | — | 0 |
| [`EVT_PROFILE`](#evt_profile) | 4 | 4 | — | 0 |
| [`EVT_PROFILE_EVENTS`](#evt_profile_events) | 4 | 8 | — | 0 |
| [`EVT_REGISTRY`](#evt_registry) | 0 | 3 | — | 0 |
| [`EVT_REGISTRY_BACKLOG`](#evt_registry_backlog) | 0 | 8 | — | 0 |
| [`FENDER`](#fender) | 81 | 10 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`FIRST_JOB_COIL_WT_0ED_OUT`](#first_job_coil_wt_0ed_out) | 0 | 10 | COIL_ABC_NUM, AB_JOB_NUM, SEQ_NUM, CURR_DATE_TIME | 0 |
| [`FLAW_CODES`](#flaw_codes) | 10 | 3 | FLAW_CODE | 0 |
| [`GM_DESTINATION_CUSTOMERS`](#gm_destination_customers) | 5 | 2 | CUSTOMER_ID, DES_SH_CUST_ID | 0 |
| [`GROUPDEPARTMENT`](#groupdepartment) | 21 | 3 | GROUPDEPARTMENT_ID | 0 |
| [`HANDLING_CODES`](#handling_codes) | 3 | 2 | HANDLING_CODE | 0 |
| [`IMPORTED_FILE_863`](#imported_file_863) | 8,596 | 5 | FILE_ID | 0 |
| [`INBOUND_841`](#inbound_841) | 4 | 64 | EDI_FILE_ID, PO | 0 |
| [`INBOUND_863`](#inbound_863) | 4,116 | 59 | EDI_FILE_ID, COIL_NUM | 0 |
| [`INBOUND_COIL`](#inbound_coil) | 86,208 | 27 | EDI_FILE_ID, BOL, ITEM_NUM | 0 |
| [`INBOUND_COIL_STATUS`](#inbound_coil_status) | 86,218 | 9 | EDI_FILE_ID, BOL, ITEM_NUM | 0 |
| [`INBOUND_SHIPMENT`](#inbound_shipment) | 65,639 | 19 | EDI_FILE_ID, BOL | 0 |
| [`INBOUND_SHIPMENT_CUSTOMER`](#inbound_shipment_customer) | 12 | 2 | CUSTOMER_ID, SHIP_FROM | 1 |
| [`INBOUND_SHIPMENT_STATUS`](#inbound_shipment_status) | 63,908 | 6 | EDI_FILE_ID, BOL | 0 |
| [`INBOUND_TRANSACTION`](#inbound_transaction) | 10,546 | 8 | EDI_FILE_ID | 0 |
| [`INVOICE`](#invoice) | 0 | 4 | AB_JOB_NUM, INVOICE_NUM | 1 |
| [`ITEMDEVICE`](#itemdevice) | 120 | 4 | ITEMDEVICE_ID | 2 |
| [`JOB_EFOLDER_NOTES`](#job_efolder_notes) | 10 | 4 | AB_JOB_NUM, USER_ID, TIMESTAMP | 2 |
| [`LAST_JOB_COIL_WT_ZEROED_OUT`](#last_job_coil_wt_zeroed_out) | 0 | 4 | — | 0 |
| [`LEFT_TRAPEZOID`](#left_trapezoid) | 0 | 13 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`LIFTGATE_SHAPE`](#liftgate_shape) | 134 | 10 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`LINE`](#line) | 8 | 17 | LINE_NUM | 0 |
| [`LINE_CODES`](#line_codes) | 11 | 2 | LINE_ID | 0 |
| [`LINE_CURRENT_STATUS`](#line_current_status) | 7 | 29 | LINE_NUM | 5 |
| [`LINE_DEFAULT_SCHEDULE`](#line_default_schedule) | 21 | 23 | LINE_NUM, SCHEDULE_TYPE | 1 |
| [`LINE_DIE_4SHEET_TYPE`](#line_die_4sheet_type) | 118 | 3 | SHEET_TYPE, LINE_NUM, DIE_ID | 2 |
| [`LINE_EMPLOYEES`](#line_employees) | 95 | 6 | EMPLOYEE_ID | 0 |
| [`LINE_OPERATOR`](#line_operator) | 26 | 7 | OPERATOR_ID | 2 |
| [`LINE_OPERATOR_GROUP`](#line_operator_group) | 4 | 3 | GROUP_ID | 0 |
| [`LINE_PRIORITY`](#line_priority) | 50 | 6 | LINE_NUM, AB_JOB_NUM | 2 |
| [`LINE_PRIORITY_COPY`](#line_priority_copy) | 40 | 4 | — | 0 |
| [`LINE_PROFILE`](#line_profile) | 0 | 3 | LINE_NUM, BUTTON_ID | 2 |
| [`LINE_SCHEDULE`](#line_schedule) | 21 | 7 | LINE_NUM, SCHEDULE_TYPE | 1 |
| [`LINE_SCHEDULE_PROFILE`](#line_schedule_profile) | 56 | 12 | LINE_ID, PROFILE_NUM | 1 |
| [`LINE_SHIFT_EMPLOYEE`](#line_shift_employee) | 0 | 3 | LINE_NUM, SCHEDULE_TYPE, EMPLOYEE_ID | 2 |
| [`LINE_SPM_STATUS`](#line_spm_status) | 8,351 | 4 | LINE_NUM, DATETIME | 1 |
| [`LUBE_WEIGHT`](#lube_weight) | 1,347 | 5 | COIL_ABC_NUM, LUBE_WEIGHT_ITEM_NUM | 0 |
| [`MAINT_ACTION`](#maint_action) | 51 | 1 | MAINT_ACTION | 0 |
| [`MAINT_FREQUENCY`](#maint_frequency) | 32 | 8 | MAINT_FREQ | 0 |
| [`MAINT_LOG`](#maint_log) | 5,327 | 28 | MAINT_LOG_ID | 2 |
| [`MAINT_LOG_PART_USED`](#maint_log_part_used) | 0 | 7 | MAINT_LOG_ID, PARTS_ID | 2 |
| [`MAINT_LOG_STAFF_USED`](#maint_log_staff_used) | 0 | 4 | MAINT_LOG_ID, EMPLOYEE_ID | 2 |
| [`MAINT_LOG_STATUS`](#maint_log_status) | 22 | 1 | MAINT_LOG_STATUS | 0 |
| [`MAINT_PROBLEMS`](#maint_problems) | 156 | 1 | MAINT_PROBLEMS | 0 |
| [`MAINT_PROBSWITH`](#maint_probswith) | 150 | 1 | MAINT_PROBSWITH | 0 |
| [`METAL_DENSITY`](#metal_density) | 68 | 2 | METAL_ALLOY | 0 |
| [`MICROSOFTDTPROPERTIES`](#microsoftdtproperties) | 0 | 6 | ID, PROPERTY | 0 |
| [`MILL_ID_CODES`](#mill_id_codes) | 3 | 2 | MILL_ID | 0 |
| [`ONHOLD_REASON`](#onhold_reason) | 7 | 2 | ONHOLD_REASON_CODE | 0 |
| [`OPERATOR_COMPETENCY_DISCIPLINE`](#operator_competency_discipline) | 25 | 2 | COMPETENCY_DISCIPLINE_ID | 0 |
| [`OPERATOR_RATE_TYPE`](#operator_rate_type) | 5 | 3 | RATE_TYPE_ID | 0 |
| [`OPERATOR_SKILL_LEVEL`](#operator_skill_level) | 0 | 3 | OPERATOR_ID, COMPETENCY_DISCIPLINE_ID | 2 |
| [`ORDER_COIL`](#order_coil) | 0 | 2 | ORDER_ABC_NUM, COIL_ABC_NUM | 2 |
| [`ORDER_ITEM`](#order_item) | 65,536 | 67 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 2 |
| [`OUTBOUND_EDI_TRANSACTION`](#outbound_edi_transaction) | 87,412 | 15 | EDI_FILE_ID | 1 |
| [`PACKAGING`](#packaging) | 0 | 2 | PACKAGING_CODE | 0 |
| [`PARALLELOGRAM`](#parallelogram) | 13 | 12 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`PARTS`](#parts) | 762 | 32 | PARTS_ID | 3 |
| [`PARTS_CATEGORIES`](#parts_categories) | 21 | 2 | PARTS_CATEGORIES_ID | 0 |
| [`PARTS_NAMING_CONVENTION`](#parts_naming_convention) | 335 | 5 | PARTS_NAMING_ID | 0 |
| [`PARTS_STATUS`](#parts_status) | 7 | 1 | PARTS_STATUS | 0 |
| [`PARTS_SUPPLIERS`](#parts_suppliers) | 762 | 4 | SUPPLIER_ID, PARTS_ID, SUPPLIER_PARTS_STATUS, STATUS_CHANGE_DATE | 2 |
| [`PARTS_UNIT`](#parts_unit) | 16 | 1 | UNITS | 0 |
| [`PART_NUM`](#part_num) | 9,856 | 54 | PART_NUM_ID | 4 |
| [`PART_NUM_CHEVRON`](#part_num_chevron) | 231 | 7 | PART_NUM_ID | 1 |
| [`PART_NUM_CIRCLE`](#part_num_circle) | 0 | 4 | PART_NUM_ID | 1 |
| [`PART_NUM_FENDER`](#part_num_fender) | 8 | 4 | PART_NUM_ID | 1 |
| [`PART_NUM_LEFT_TRAPEZOID`](#part_num_left_trapezoid) | 0 | 10 | PART_NUM_ID | 1 |
| [`PART_NUM_LIFTGATE`](#part_num_liftgate) | 8 | 7 | PART_NUM_ID | 1 |
| [`PART_NUM_PARALLELOGRAM`](#part_num_parallelogram) | 0 | 9 | PART_NUM_ID | 1 |
| [`PART_NUM_RECTANGLE`](#part_num_rectangle) | 3,813 | 7 | PART_NUM_ID | 1 |
| [`PART_NUM_REINFORCEMENT`](#part_num_reinforcement) | 8 | 7 | PART_NUM_ID | 1 |
| [`PART_NUM_RIGHT_TRAPEZOID`](#part_num_right_trapezoid) | 0 | 10 | PART_NUM_ID | 1 |
| [`PART_NUM_TRAPEZOID`](#part_num_trapezoid) | 96 | 10 | PART_NUM_ID | 1 |
| [`PART_NUM_X1_SHAPE`](#part_num_x1_shape) | 0 | 13 | PART_NUM_ID | 1 |
| [`PBCATCOL`](#pbcatcol) | 0 | 20 | — | 0 |
| [`PBCATEDT`](#pbcatedt) | 21 | 7 | — | 0 |
| [`PBCATFMT`](#pbcatfmt) | 20 | 4 | — | 0 |
| [`PBCATTBL`](#pbcattbl) | 0 | 25 | — | 0 |
| [`PBCATVLD`](#pbcatvld) | 0 | 5 | — | 0 |
| [`PLAN_TABLE`](#plan_table) | 0 | 19 | — | 0 |
| [`PM`](#pm) | 77 | 45 | PM_ID | 7 |
| [`PMACTIONPHRASES`](#pmactionphrases) | 31 | 1 | PMACTIONPHRASES | 0 |
| [`PMCOMPLETIONDETAILS`](#pmcompletiondetails) | 0 | 5 | PMCOMPLETION_ID | 1 |
| [`PMCOMPLETIONS`](#pmcompletions) | 2,051 | 12 | PMCOMPLETION_ID | 5 |
| [`PMCOMPLETIONS_STAFF_USED`](#pmcompletions_staff_used) | 0 | 4 | PMCOMPLETION_ID, EMPLOYEE_ID | 2 |
| [`PMCOMPLETION_PARTS_USED`](#pmcompletion_parts_used) | 0 | 7 | PMCOMPLETION_ID, PARTS_ID | 2 |
| [`PMINFOPHRASES`](#pminfophrases) | 7 | 1 | PMINFOPHRASES | 0 |
| [`PMPARTSREQUIRED`](#pmpartsrequired) | 0 | 4 | PARTS_ID, PM_ID | 2 |
| [`PMSHIFT`](#pmshift) | 8 | 1 | PMSHIFT | 0 |
| [`PM_ACTIONS`](#pm_actions) | 1,618 | 5 | PM_ACTION_ID | 1 |
| [`PM_STATUS`](#pm_status) | 5 | 2 | PM_STATUS_ID | 0 |
| [`PROCESSING_STRING_863`](#processing_string_863) | 46,251 | 7 | SAMPLE_ID, TEST_NUM | 0 |
| [`PROCESS_COIL`](#process_coil) | 183,495 | 9 | COIL_ABC_NUM, AB_JOB_NUM | 2 |
| [`PROCESS_COIL_STATUS`](#process_coil_status) | 11 | 2 | PROCESS_COIL_STATUS_CODE | 0 |
| [`PROCESS_COIL_TRACK`](#process_coil_track) | 48,265 | 8 | COIL_ABC_NUM, AB_JOB_NUM, PROCESS_COIL_TRACK_DATE | 0 |
| [`PROCESS_PARTIAL_SKID`](#process_partial_skid) | 8,335 | 8 | AB_JOB_NUM, SHEET_SKID_NUM | 2 |
| [`PRODUCTION_CONTROL_USERS`](#production_control_users) | 6 | 4 | USER_ID | 0 |
| [`PRODUCTION_SHEET_ITEM`](#production_sheet_item) | 713,835 | 13 | PROD_ITEM_NUM | 3 |
| [`PRODUCT_TYPE`](#product_type) | 43 | 3 | PRODUCT_TYPE_ID | 1 |
| [`PROD_ITEM_STATUS`](#prod_item_status) | 21 | 2 | — | 0 |
| [`PROD_SHEET_ITEM_TRACK`](#prod_sheet_item_track) | 22,230 | 16 | PROD_ITEM_NUM, LOG_DATE | 0 |
| [`PST_TEST_RESULT`](#pst_test_result) | 47,516 | 11 | COIL_ABC_NUM, POSITION, CREATED_DATE, SOURCE_ID | 0 |
| [`QA_ALBL_DEFECT_DISPOSITION`](#qa_albl_defect_disposition) | 7 | 3 | DISP_CODE | 0 |
| [`QA_CUSTOMER_QUALITY_SKID`](#qa_customer_quality_skid) | 2,248 | 10 | CUSTOMER_ID, AB_JOB_NUM, COIL_ABC_NUM, SHEET_SKID_NUM, DEFECT_CODE | 0 |
| [`QA_CUST_DEFECT_DISPOSITION`](#qa_cust_defect_disposition) | 8 | 4 | CUSTOMER_ID, DISP_CODE | 0 |
| [`QA_DEFECT`](#qa_defect) | 19 | 3 | DEFECT_CODE | 0 |
| [`QA_EMAIL_GROUP`](#qa_email_group) | 10 | 3 | LOGIN_ID, QA_EMAIL_GROUP_ID | 0 |
| [`QA_EMAIL_GROUP_DETAIL`](#qa_email_group_detail) | 30 | 2 | QA_EMAIL_GROUP_ID, QA_EMAIL_GROUP_DETAIL_ADDRESS | 0 |
| [`QR_REQUIRED_CUSTOMERS`](#qr_required_customers) | 2 | 1 | CUSTOMER_ID | 0 |
| [`QUALITY_COIL_EVAL_SCRAP`](#quality_coil_eval_scrap) | 6,954 | 9 | COIL_ABC_NUM, AB_JOB_NUM, SCRAP_ITEM_TYPE, SCRAP_ITEM_OD, SCRAP_ITEM_MILL | 3 |
| [`QUALITY_SCRAP_WORKSHEET`](#quality_scrap_worksheet) | 6,089 | 9 | COIL_ABC_NUM, AB_JOB_NUM, SCRAP_ITEM_TYPE, SCRAP_ITEM_OD, SCRAP_ITEM_MILL, SCRAP_SKID_NUM | 4 |
| [`QUEST_COM_PRODUCTS`](#quest_com_products) | 2 | 14 | PRODUCT_ID | 0 |
| [`QUEST_COM_PRODUCTS_USED_BY`](#quest_com_products_used_by) | 0 | 3 | PRODUCT_ID, USED_BY_PRODUCT_ID | 2 |
| [`QUEST_COM_PRODUCT_PRIVS`](#quest_com_product_privs) | 0 | 5 | PRODUCT_ID, PRIVILEGE_ID | 1 |
| [`QUEST_COM_USERS`](#quest_com_users) | 3 | 4 | USER_ID, PRODUCT_ID | 1 |
| [`QUEST_COM_USER_PRIVILEGES`](#quest_com_user_privileges) | 0 | 4 | PRODUCT_ID, USER_ID, PRIVILEGE_ID | 2 |
| [`RECEIVING_BOL`](#receiving_bol) | 10,264 | 7 | RECEIVING_BOL_ID | 1 |
| [`RECEIVING_BOL_COIL`](#receiving_bol_coil) | 82,290 | 23 | RECEIVING_BOL_ID, COIL_ID | 1 |
| [`RECOVERY_JOB_COIL`](#recovery_job_coil) | 11 | 7 | COIL_ABC_NUM, AB_JOB_NUM | 2 |
| [`RECOVERY_REPORT_CUSTOMER`](#recovery_report_customer) | 14 | 5 | CUSTOMER_ID, CUSTOMER_NAME | 1 |
| [`RECOVERY_REPORT_TEMPLATE`](#recovery_report_template) | 81 | 3 | CUSTOMER_ID, CUSTOMER_NAME, RECOVERY_REPORT_TYPE_ID | 2 |
| [`RECOVERY_REPORT_TYPE`](#recovery_report_type) | 12 | 4 | RECOVERY_REPORT_TYPE_ID | 0 |
| [`RECOVERY_SCRAP_WORKSHEET`](#recovery_scrap_worksheet) | 7 | 6 | COIL_ABC_NUM, AB_JOB_NUM, SCRAP_TYPE_ID | 2 |
| [`RECTANGLE`](#rectangle) | 33,374 | 10 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`REINFORCEMENT`](#reinforcement) | 42 | 10 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`REJECT_COIL`](#reject_coil) | 3,926 | 8 | COIL_ABC_NUM | 2 |
| [`REJECT_COIL_PACKING_ITEM`](#reject_coil_packing_item) | 3,714 | 4 | REJ_COIL_PACKING_ITEM, PACKING_LIST | 2 |
| [`REPORT_AUTO_RUN_LOG`](#report_auto_run_log) | 6 | 2 | — | 0 |
| [`RETURN_SCRAP_ITEM`](#return_scrap_item) | 62,220 | 13 | RETURN_SCRAP_ITEM_NUM | 4 |
| [`RIGHT_TRAPEZOID`](#right_trapezoid) | 0 | 13 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`ROUTING`](#routing) | 1,209 | 14 | ROUTING_SEQUENCE, CUSTOMER_ID, PART_NUM_ID, LINE_NUM, DIE_ID, SHEET_TYPE, SPM_STANDARD, SPM_PLANNED, NUMBER_OF_PEOPLE, EDGE_TRIM_Y_N, STACKER_Y_N | 0 |
| [`ROUTING_SEQUENCE`](#routing_sequence) | 0 | 2 | ROUTING_SEQ | 0 |
| [`SAMPLE_REQUIREMENT_CODES`](#sample_requirement_codes) | 4 | 2 | SAMPLE_REQUIREMENT_ID | 0 |
| [`SCAN_LOG`](#scan_log) | 10,533 | 5 | SCAN_ID | 1 |
| [`SCHEDULE`](#schedule) | 0 | 8 | SCHEDULE_ID | 0 |
| [`SCRAPED_PROCESS_PARTIAL_SKID`](#scraped_process_partial_skid) | 43 | 9 | AB_JOB_NUM, SHEET_SKID_NUM | 2 |
| [`SCRAPED_PRODUCTION_SHEET_ITEM`](#scraped_production_sheet_item) | 2,057 | 12 | PROD_ITEM_NUM | 2 |
| [`SCRAPED_SHEET_SKID`](#scraped_sheet_skid) | 1,879 | 17 | SHEET_SKID_NUM | 2 |
| [`SCRAPED_SHEET_SKID_DETAIL`](#scraped_sheet_skid_detail) | 2,057 | 3 | PROD_ITEM_NUM, SHEET_SKID_NUM | 2 |
| [`SCRAP_HANDLING_DESC`](#scrap_handling_desc) | 5 | 2 | SCRAP_HANDLING | 0 |
| [`SCRAP_LOCATION`](#scrap_location) | 3 | 2 | SCRAP_LOCATION_CODE | 0 |
| [`SCRAP_PACKING_ITEM`](#scrap_packing_item) | 55,393 | 4 | SC_PACKING_ITEM, PACKING_LIST | 2 |
| [`SCRAP_SKID`](#scrap_skid) | 147,779 | 19 | SCRAP_SKID_NUM | 1 |
| [`SCRAP_SKID_DETAIL`](#scrap_skid_detail) | 63,504 | 2 | SCRAP_SKID_NUM, RETURN_SCRAP_ITEM_NUM | 2 |
| [`SCRAP_SKID_STATUS_DESC`](#scrap_skid_status_desc) | 5 | 2 | SCRAP_SKID_STATUS_CODE | 0 |
| [`SCRAP_STATUS_DESC`](#scrap_status_desc) | 6 | 2 | SCRAP_STATUS | 0 |
| [`SCRAP_TRACK`](#scrap_track) | 74,503 | 14 | SCRAP_SKID_NO, LOG_DATE | 0 |
| [`SCRAP_TYPE`](#scrap_type) | 49 | 4 | SCRAP_TYPE_ID | 0 |
| [`SCRAP_TYPE_DESC`](#scrap_type_desc) | 11 | 2 | SCRAP_TYPE | 0 |
| [`SECTOR`](#sector) | 2 | 2 | SECTOR_CODE | 0 |
| [`SECURITY_APPLICATION`](#security_application) | 31 | 3 | APPLICATION_ID | 0 |
| [`SECURITY_GROUP`](#security_group) | 9 | 3 | USER_GROUP_ID | 0 |
| [`SECURITY_GROUP_APPLICATION`](#security_group_application) | 126 | 3 | APPLICATION_ID, USER_GROUP_ID | 2 |
| [`SECURITY_USER`](#security_user) | 63 | 9 | USER_ID | 0 |
| [`SECURITY_USER_APPLICATION`](#security_user_application) | 763 | 3 | USER_ID, APPLICATION_ID | 2 |
| [`SECURITY_USER_GROUP`](#security_user_group) | 154 | 2 | USER_ID, USER_GROUP_ID | 2 |
| [`SECURITY_USER_WEB_APP`](#security_user_web_app) | 3 | 2 | LOGIN_ID | 0 |
| [`SECURITY_USER_WEB_ROLE`](#security_user_web_role) | 6 | 2 | LOGIN_ID, WEB_ROLE | 1 |
| [`SEQUENCE_KEY`](#sequence_key) | 22 | 6 | SEQUENCE_NAME | 0 |
| [`SHAPE_DIE`](#shape_die) | 68 | 2 | SHEET_TYPE, DIE_ID | 1 |
| [`SHEET_PACKING_ITEM`](#sheet_packing_item) | 286,902 | 4 | SH_PACKING_ITEM, PACKING_LIST | 2 |
| [`SHEET_SKID`](#sheet_skid) | 617,213 | 21 | SHEET_SKID_NUM | 2 |
| [`SHEET_SKID_DETAIL`](#sheet_skid_detail) | 334,872 | 2 | PROD_ITEM_NUM, SHEET_SKID_NUM | 2 |
| [`SHEET_SKID_DIMENSION_CHECK`](#sheet_skid_dimension_check) | 256 | 13 | DIMENSION_CHECK_NUM | 0 |
| [`SHEET_SKID_PACKAGE`](#sheet_skid_package) | 0 | 2 | SHEET_SKID_NUM | 0 |
| [`SHEET_SKID_PACKAGE_HISTORY`](#sheet_skid_package_history) | 0 | 4 | SHEET_SKID_NUM, PACKAGE_NUM, CHANGE_DATE_TIME | 0 |
| [`SHIFT`](#shift) | 8,366 | 13 | SHIFT_NUM | 1 |
| [`SHIFT_COIL`](#shift_coil) | 45,285 | 12 | SHIFT_NUM, COIL_RUN_NUM | 2 |
| [`SHIFT_COIL_JOB`](#shift_coil_job) | 0 | 4 | SHIFT_NUM, AB_JOB_NUM, COIL_ABC_NUM | 2 |
| [`SHIFT_PROFILE`](#shift_profile) | 7 | 8 | ID | 0 |
| [`SHIFT_SCHEDULE`](#shift_schedule) | 18,724 | 7 | SHIFT_SCHEDULE_DATE, LINE_NUM, SCHEDULE_TYPE | 2 |
| [`SHIPMENT`](#shipment) | 118,738 | 30 | PACKING_LIST | 4 |
| [`SHIPMENT_TRACK`](#shipment_track) | 718 | 11 | LOG_DATE, PACKING_LIST_NO | 0 |
| [`SHIPMENT_TYPES`](#shipment_types) | 3 | 3 | — | 0 |
| [`SH_REPORT_DEFAULT_TEMPLATE`](#sh_report_default_template) | 8 | 2 | SH_REPORT_TYPE_ID | 2 |
| [`SH_REPORT_TEMPLATES`](#sh_report_templates) | 20 | 4 | SH_REPORT_TEMPLATE_ID | 1 |
| [`SH_REPORT_TYPE`](#sh_report_type) | 8 | 2 | SH_REPORT_TYPE_ID | 0 |
| [`SKETCH`](#sketch) | 128 | 6 | SKETCH_ID | 0 |
| [`SKETCH_JPG`](#sketch_jpg) | 214 | 6 | SKETCH_ID | 0 |
| [`SKID_DATA_ERROR_LOG`](#skid_data_error_log) | 0 | 6 | SHEET_SKID_NUM, LOG_DATE | 0 |
| [`SKID_ONHOLD_REASON_TRACK`](#skid_onhold_reason_track) | 0 | 8 | SHEET_SKID_NUM, LOG_DATE | 0 |
| [`SKID_STATUS`](#skid_status) | 18 | 2 | — | 0 |
| [`SKID_TRACK`](#skid_track) | 444,541 | 16 | SHEET_SKID_NUM, LOG_DATE | 0 |
| [`SMACTUALPARAMETER_S`](#smactualparameter_s) | 0 | 4 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMAGENTJOB_S`](#smagentjob_s) | 0 | 4 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMARCHIVE_S`](#smarchive_s) | 0 | 4 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMBREAKABLELINKS`](#smbreakablelinks) | 0 | 5 | LHSTYPE, LHSID, RHSTYPE, RHSID, ASSOCIATION_ID_ | 0 |
| [`SMCLIQUE`](#smclique) | 0 | 3 | — | 0 |
| [`SMCONFIGURATION`](#smconfiguration) | 1 | 2 | ATTRIBUTE | 0 |
| [`SMCONSOLESOSETTING_S`](#smconsolesosetting_s) | 0 | 3 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMDATABASE_S`](#smdatabase_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMDBAUTH_S`](#smdbauth_s) | 0 | 9 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMDEFAUTH_S`](#smdefauth_s) | 0 | 13 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMDEPENDENTLINKS`](#smdependentlinks) | 0 | 5 | DEPENDEEID, DEPENDENTID, ASSOCIATION_ID_, DEPENDEETYPE, DEPENDENTTYPE | 0 |
| [`SMDISTRIBUTIONSET_S`](#smdistributionset_s) | 0 | 5 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMFOLDER_S`](#smfolder_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMFORMALPARAMETER_S`](#smformalparameter_s) | 0 | 10 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMGLOBALCONFIGURATION_S`](#smglobalconfiguration_s) | 0 | 6 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMHOSTAUTH_S`](#smhostauth_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMHOST_S`](#smhost_s) | 0 | 10 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMINSTALLATION_S`](#sminstallation_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMLOGMESSAGE_S`](#smlogmessage_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMMONTHLYENTRY_S`](#smmonthlyentry_s) | 0 | 5 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMMONTHWEEKENTRY_S`](#smmonthweekentry_s) | 0 | 6 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMMOWNERLINKS`](#smmownerlinks) | 0 | 6 | MOWNERID, MOWNEEID, ASSOCIATION_ID_, MOWNERTYPE, MOWNEETYPE | 0 |
| [`SMOMSTRING_S`](#smomstring_s) | 0 | 3 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMOSNAMES_X`](#smosnames_x) | 0 | 1 | — | 0 |
| [`SMOWNERLINKS`](#smownerlinks) | 0 | 5 | OWNERID, OWNEEID, ASSOCIATION_ID_, OWNERTYPE, OWNEETYPE | 0 |
| [`SMPACKAGE_S`](#smpackage_s) | 0 | 6 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMPARALLELJOB_S`](#smparalleljob_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMPARALLELOPERATION_S`](#smparalleloperation_s) | 0 | 6 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMPARALLELSTATEMENT_S`](#smparallelstatement_s) | 0 | 4 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMPRODUCTATTRIBUTE_S`](#smproductattribute_s) | 0 | 12 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMPRODUCT_S`](#smproduct_s) | 0 | 9 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMP_AD_ADDRESSES_`](#smp_ad_addresses_) | 0 | 3 | OWNER, NODE, ALIAS | 0 |
| [`SMP_AD_DISCOVERED_NODES_`](#smp_ad_discovered_nodes_) | 0 | 2 | OWNER, NODE | 0 |
| [`SMP_AD_NODES_`](#smp_ad_nodes_) | 0 | 8 | OWNER, NODE | 0 |
| [`SMP_AD_PARMS_`](#smp_ad_parms_) | 0 | 2 | OWNER, BACKGROUND_DISCOVERY, BACKGROUND_FREQUENCY | 0 |
| [`SMP_AUTO_DISCOVERY_ITEM_`](#smp_auto_discovery_item_) | 0 | 6 | OWNER, IPADDR_BYTE1, IPADDR_BYTE2, IPADDR_BYTE3, IPADDR_BYTE4_UPPERLIMIT, IPADDR_BYTE4_LASTUSED | 0 |
| [`SMP_AUTO_DISCOVERY_PARMS_`](#smp_auto_discovery_parms_) | 0 | 5 | OWNER, AD_FREQUENCY, AD_CONN_TIMEOUT, AD_UPDATE_FREQUENCY, AD_UPDATE_COUNT | 0 |
| [`SMP_BLOB_`](#smp_blob_) | 9 | 4 | OWNER, ID, SUBID | 0 |
| [`SMP_BRM_ACTIVE_JOB_`](#smp_brm_active_job_) | 0 | 3 | — | 0 |
| [`SMP_BRM_CHANNEL_DEVICE_`](#smp_brm_channel_device_) | 0 | 11 | — | 0 |
| [`SMP_BRM_DEFAULT_CHANNEL_`](#smp_brm_default_channel_) | 0 | 2 | — | 0 |
| [`SMP_BRM_RC_CONNECT_STRING_`](#smp_brm_rc_connect_string_) | 0 | 4 | — | 0 |
| [`SMP_BRM_SAVED_JOB_`](#smp_brm_saved_job_) | 0 | 3 | — | 0 |
| [`SMP_BRM_TEMP_SCRIPTS_`](#smp_brm_temp_scripts_) | 0 | 3 | — | 0 |
| [`SMP_CREDENTIALS$`](#smp_credentials$) | 0 | 5 | — | 0 |
| [`SMP_EBU_ACTIVE_JOB_`](#smp_ebu_active_job_) | 0 | 3 | — | 0 |
| [`SMP_EBU_SAVED_JOB_`](#smp_ebu_saved_job_) | 0 | 3 | — | 0 |
| [`SMP_JOB_`](#smp_job_) | 0 | 11 | ID | 0 |
| [`SMP_JOB_EVENTLIST_`](#smp_job_eventlist_) | 0 | 1 | — | 0 |
| [`SMP_JOB_HISTORY_`](#smp_job_history_) | 0 | 11 | — | 0 |
| [`SMP_JOB_INSTANCE_`](#smp_job_instance_) | 0 | 11 | — | 0 |
| [`SMP_JOB_LIBRARY_`](#smp_job_library_) | 0 | 4 | — | 0 |
| [`SMP_JOB_TASK_INSTANCE_`](#smp_job_task_instance_) | 0 | 6 | — | 1 |
| [`SMP_LONG_TEXT_`](#smp_long_text_) | 0 | 3 | — | 0 |
| [`SMP_REP_VERSION`](#smp_rep_version) | 3 | 3 | — | 0 |
| [`SMP_SERVICES`](#smp_services) | 1 | 3 | — | 0 |
| [`SMP_SERVICE_DATA_`](#smp_service_data_) | 0 | 4 | OWNER, SERVICE_NAME, SERVICE_TYPE, NODE | 0 |
| [`SMP_SERVICE_GROUP_DEFN_`](#smp_service_group_defn_) | 0 | 2 | OWNER, GROUP_NAME, GROUP_TYPE | 0 |
| [`SMP_SERVICE_GROUP_ITEM_`](#smp_service_group_item_) | 0 | 4 | OWNER, GROUP_NAME, OBJECT_NAME, OBJECT_TYPE | 0 |
| [`SMP_SERVICE_ITEM_`](#smp_service_item_) | 0 | 5 | OWNER, SERVICE_NAME, SERVICE_TYPE | 0 |
| [`SMP_UPDATESERVICES_CALLED_`](#smp_updateservices_called_) | 0 | 1 | OWNER, CALLED | 0 |
| [`SMP_USER_DETAILS`](#smp_user_details) | 0 | 3 | — | 0 |
| [`SMP_VAB_ACTIVE_JOB_`](#smp_vab_active_job_) | 0 | 3 | — | 0 |
| [`SMP_VAB_SAVED_JOB_`](#smp_vab_saved_job_) | 0 | 3 | — | 0 |
| [`SMRELEASE_S`](#smrelease_s) | 0 | 10 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMRUN_S`](#smrun_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMSCHEDULE_S`](#smschedule_s) | 0 | 11 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMSHAREDORACLECLIENT_S`](#smsharedoracleclient_s) | 0 | 5 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMSHAREDORACLECONFIGURATION_S`](#smsharedoracleconfiguration_s) | 0 | 6 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMTABLESPACE_S`](#smtablespace_s) | 0 | 6 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMVCENDPOINT_S`](#smvcendpoint_s) | 0 | 7 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SMWEEKLYENTRY_S`](#smweeklyentry_s) | 0 | 5 | NAMEDOBJECT_ID_SEQUENCEID_ | 0 |
| [`SPLIT_SKID`](#split_skid) | 0 | 8 | AB_JOB_NUM, COIL_ABC_NUM, SHEET_SKID_NUM | 0 |
| [`SPM_EFIC_STANDARD`](#spm_efic_standard) | 97 | 5 | LINE_NUM, PART_NUM_ID, DIE_ID | 3 |
| [`STATE`](#state) | 56 | 2 | STATE | 0 |
| [`SUBSYSTEMEQUIPMENT`](#subsystemequipment) | 462 | 4 | SUBSYSEQUIPMENT_ID | 2 |
| [`SUPPLIERS`](#suppliers) | 76 | 17 | SUPPLIER_ID | 0 |
| [`SUPPRESS_BARCODE_PRINT`](#suppress_barcode_print) | 86 | 5 | COMPUTER_ID, CUSTOMER_ID, DES_SH_CUST_ID | 0 |
| [`SYSTEMEQUIPMENT`](#systemequipment) | 132 | 3 | SYSEQUIPMENT_ID | 1 |
| [`SYSTEM_LOG`](#system_log) | 2,951 | 4 | SYSTEM_LOG_KEY_NUM | 0 |
| [`SYSTEM_OPTIONS`](#system_options) | 4 | 5 | SYSTEM_OPTIONS_ID | 0 |
| [`SYS_EXPORT_SCHEMA_01`](#sys_export_schema_01) | 1,141 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_02`](#sys_export_schema_02) | 2,464 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_03`](#sys_export_schema_03) | 4,690 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_04`](#sys_export_schema_04) | 1,506 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_05`](#sys_export_schema_05) | 4,708 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_06`](#sys_export_schema_06) | 1,508 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_07`](#sys_export_schema_07) | 4,414 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_08`](#sys_export_schema_08) | 1,510 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_09`](#sys_export_schema_09) | 4,744 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_10`](#sys_export_schema_10) | 1,512 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_11`](#sys_export_schema_11) | 4,783 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_12`](#sys_export_schema_12) | 5,142 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_13`](#sys_export_schema_13) | 1,515 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_14`](#sys_export_schema_14) | 4,793 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_15`](#sys_export_schema_15) | 1,517 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_16`](#sys_export_schema_16) | 1,141 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_17`](#sys_export_schema_17) | 1,141 | 95 | — | 0 |
| [`SYS_EXPORT_SCHEMA_18`](#sys_export_schema_18) | 1,141 | 95 | — | 0 |
| [`TEMP_TEST_RESULT`](#temp_test_result) | 0 | 10 | — | 0 |
| [`TEST_863`](#test_863) | 287 | 1 | — | 0 |
| [`TITLECRAFT`](#titlecraft) | 46 | 4 | TITLECRAFT_ID | 1 |
| [`TMD_CODES_CHEMICAL`](#tmd_codes_chemical) | 29 | 2 | — | 0 |
| [`TMD_CODES_MECHANICAL`](#tmd_codes_mechanical) | 66 | 4 | — | 0 |
| [`TRANSPORTATION_METHOD`](#transportation_method) | 1 | 2 | TRANS_METHOD_CODE | 0 |
| [`TRAPEZOID`](#trapezoid) | 532 | 13 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`TRIM_TYPE`](#trim_type) | 2 | 2 | TRIM_TYPE_CODE | 0 |
| [`TRUCK_APPOINT_LOCKS`](#truck_appoint_locks) | 0 | 9 | APPOINTMENT_DATE, SLOT_NUMBER, TIME_START, COMPUTER_ID, SCREEN | 0 |
| [`TRUCK_APPOINT_RECEIVING`](#truck_appoint_receiving) | 0 | 11 | APPOINTMENT_DATE_TIME, CARRIER_NAME | 0 |
| [`TRUCK_APPOINT_SHIPPING`](#truck_appoint_shipping) | 0 | 11 | APPOINTMENT_DATE_TIME, CARRIER_ID | 0 |
| [`TRUCK_LOCATION`](#truck_location) | 9 | 2 | TRUCK_LOCATION_ID | 0 |
| [`TRUCK_RECEIVING_4DATE`](#truck_receiving_4date) | 330 | 15 | APPOINTMENT_DATE, SLOT_NUMBER | 0 |
| [`TRUCK_SHIPPING_4DATE`](#truck_shipping_4date) | 462 | 15 | APPOINTMENT_DATE, SLOT_NUMBER | 0 |
| [`UNIT_OF_MEASURE`](#unit_of_measure) | 8 | 3 | UOM_CODE | 0 |
| [`USER_LOG`](#user_log) | 100,437 | 5 | USER_LOG_ID | 0 |
| [`WH_ITEM`](#wh_item) | 14 | 15 | WH_ITEM_NUM, WH_PACKING_TICKET | 0 |
| [`WH_ITEM_DETAIL`](#wh_item_detail) | 21 | 8 | WH_ITEM_NUM, WH_PACKING_TICKET, WH_COIL_NUM | 1 |
| [`WH_PACKING_ITEM`](#wh_packing_item) | 9 | 4 | WH_PACKING_ITEM, PACKING_LIST | 2 |
| [`WINDOW_X_Y`](#window_x_y) | 20 | 5 | LINE_NUM, OBJECT_NAME | 0 |
| [`X1_SHAPE`](#x1_shape) | 122 | 15 | ORDER_ITEM_NUM, ORDER_ABC_NUM | 1 |
| [`YIELD_STRENGTH`](#yield_strength) | 34 | 3 | ALLOY, TEMPER | 0 |
| [`ZIP_CODE_DATA`](#zip_code_data) | 43,191 | 10 | ZIP_CODE | 0 |

## Tables

### ABIS_INI

_~67 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS` 🔑 | VARCHAR2(100) | NOT NULL |  |
| 2 | `SECTION` 🔑 | VARCHAR2(50) | NOT NULL |  |
| 3 | `KEY` 🔑 | VARCHAR2(100) | NOT NULL |  |
| 4 | `VALUE` | VARCHAR2(250) |  |  |
| 5 | `DESCRIPTION` | VARCHAR2(500) |  |  |

- **PK:** `PROCESS`, `SECTION`, `KEY`
- **Index** unique `PFK_ABIS_INI`: `PROCESS`, `SECTION`, `KEY`

### ABIS_RELEASE

_~20,414 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `INSTALL_COMPUTER` 🔑 | VARCHAR2(128) | NOT NULL |  |
| 2 | `INSTALL_USER` 🔑 | VARCHAR2(128) | NOT NULL |  |
| 3 | `CURRENT_BUILD_DTTM` 🔑 | DATE | NOT NULL |  |
| 4 | `NEW_BUILD_DTTM` 🔑 | DATE | NOT NULL |  |
| 5 | `INSTALL_DTTM` 🔑 | DATE | NOT NULL |  |
| 6 | `TEST_OR_PROD` 🔑 | VARCHAR2(10) | NOT NULL |  |
| 7 | `NOTE` | VARCHAR2(100) |  |  |

- **PK:** `INSTALL_COMPUTER`, `INSTALL_USER`, `CURRENT_BUILD_DTTM`, `NEW_BUILD_DTTM`, `INSTALL_DTTM`, `TEST_OR_PROD`
- **Index** unique `PFK_ABIS_RELEASE`: `INSTALL_COMPUTER`, `INSTALL_USER`, `CURRENT_BUILD_DTTM`, `NEW_BUILD_DTTM`, `INSTALL_DTTM`, `TEST_OR_PROD`

### ABIS_SCRAP_STATUS_X12

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ABIS_SCRAP_STATUS` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `TABLE70_MATERIAL_STATUS_OP` 🔑 | VARCHAR2(3) | NOT NULL |  |

- **PK:** `ABIS_SCRAP_STATUS`, `TABLE70_MATERIAL_STATUS_OP`
- **Index** unique `XPK_ABIS_SCRAP_STATUS_X12`: `ABIS_SCRAP_STATUS`, `TABLE70_MATERIAL_STATUS_OP`

### ABIS_SCRAP_TYPE_X12

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ABIS_SCRAP_TYPE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `TABLE67_MATERIAL_CLASS` 🔑 | VARCHAR2(3) | NOT NULL |  |

- **PK:** `ABIS_SCRAP_TYPE`, `TABLE67_MATERIAL_CLASS`
- **Index** unique `XPK_ABIS_SCRAP_TYPE_X12`: `ABIS_SCRAP_TYPE`, `TABLE67_MATERIAL_CLASS`

### ABIS_X12_COIL

_~9 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ABIS_COIL_STATUS` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `TABLE67_MATERIAL_CLASS` 🔑 | VARCHAR2(3) | NOT NULL |  |
| 3 | `TABLE70_MATERIAL_STATUS_OP` 🔑 | VARCHAR2(3) | NOT NULL |  |
| 4 | `TABLE68_MATERIAL_STATUS_QA` | VARCHAR2(3) |  |  |

- **PK:** `ABIS_COIL_STATUS`, `TABLE67_MATERIAL_CLASS`, `TABLE70_MATERIAL_STATUS_OP`
- **Index** unique `XPK_ABIS_X12_COIL`: `ABIS_COIL_STATUS`, `TABLE67_MATERIAL_CLASS`, `TABLE70_MATERIAL_STATUS_OP`

### ABIS_X12_SKID

_~11 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ABIS_SKID_STATUS` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `TABLE67_MATERIAL_CLASS` 🔑 | VARCHAR2(3) | NOT NULL |  |
| 3 | `TABLE70_MATERIAL_STATUS_OP` 🔑 | VARCHAR2(3) | NOT NULL |  |
| 4 | `TABLE68_MATERIAL_STATUS_QA` | VARCHAR2(3) |  |  |

- **PK:** `ABIS_SKID_STATUS`, `TABLE67_MATERIAL_CLASS`, `TABLE70_MATERIAL_STATUS_OP`
- **Index** unique `XPK_ABIS_X12_SKID`: `ABIS_SKID_STATUS`, `TABLE67_MATERIAL_CLASS`, `TABLE70_MATERIAL_STATUS_OP`

### AB_AUDIT

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 3 | `VALUE_FROM` | VARCHAR2(200) | NOT NULL |  |
| 4 | `VALUE_TO` | VARCHAR2(200) | NOT NULL |  |
| 5 | `USER_ID` 🔑 | VARCHAR2(20) | NOT NULL |  |
| 6 | `EVENT_DATE` 🔑 | TIMESTAMP(6) | NOT NULL |  |

- **PK:** `TABLE_NAME`, `USER_ID`, `EVENT_DATE`
- **Index** unique `PFK_AB_AUDIT`: `TABLE_NAME`, `USER_ID`, `EVENT_DATE`

### AB_JOB

_~97,390 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SKETCH_ID` | NUMBER(5,0) |  |  |
| 3 | `LINE_NUM` | NUMBER(2,0) |  |  |
| 4 | `ORDER_ITEM_NUM` | NUMBER(2,0) | NOT NULL |  |
| 5 | `MATERIAL_YIELD` | NUMBER(2,2) |  |  |
| 6 | `ORDER_ABC_NUM` | NUMBER(8,0) | NOT NULL |  |
| 7 | `TIME_DATE_STARTED` | DATE |  |  |
| 8 | `TIME_DATE_FINISHED` | DATE |  |  |
| 9 | `NUMBER_OF_MEN_USED` | NUMBER(2,0) |  |  |
| 10 | `CREATE_DATE` | DATE |  |  |
| 11 | `DUE_DATE` | DATE |  |  |
| 12 | `JOB_STATUS` | NUMBER(2,0) |  |  |
| 13 | `JOB_NOTES` | VARCHAR2(1024) |  |  |
| 14 | `SKETCH_JOB_NOTE` | VARCHAR2(1024) |  |  |
| 15 | `JOB_SHEET_WT` | NUMBER(8,0) |  |  |
| 16 | `JOB_PROCESS_QUANTITY` | NUMBER(8,0) |  |  |
| 17 | `JOB_SKID` | NUMBER(8,0) |  |  |
| 18 | `JOB_PIECES_SKID` | NUMBER(6,0) |  |  |
| 19 | `PITCH` | NUMBER(10,5) |  |  |
| 20 | `PITCH_PLUS` | NUMBER(6,6) |  |  |
| 21 | `PITCH_MINUS` | NUMBER(6,6) |  |  |
| 22 | `MACHINE_SETUP_TIME` | NUMBER(6,2) |  |  |
| 23 | `MACHINE_DOWN_TIME` | NUMBER(6,2) |  |  |
| 24 | `SCRAP_870_DATE` | DATE |  |  |
| 25 | `JOB_REFERENCE_CODES` | VARCHAR2(255) |  |  |
| 26 | `JOB_DONE_TIME` | DATE |  |  |
| 27 | `JOB_TARE_WT` | NUMBER(8,0) |  |  |
| 28 | `NONCONFORMING` | NUMBER(1,0) |  |  |
| 29 | `AUTO_PARTS` | NUMBER(1,0) |  |  |
| 30 | `EDGE_TRIM_SCRAP_PERCENTAGE` | NUMBER(2,2) |  |  |
| 31 | `DIE_ID` | NUMBER(4,0) |  |  |
| 32 | `EDI_FILE_ID_870` | NUMBER(9,0) |  |  |
| 33 | `EDI_DATE_870` | DATE |  |  |
| 34 | `ROUTING_SEQUENCE` | NUMBER(8,0) |  |  |

- **PK:** `AB_JOB_NUM`
- **FK:** (`SKETCH_ID`) → `SKETCH_JPG` (`SKETCH_ID`)
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** `ORDER_ABC_NUM_IDX`: `ORDER_ABC_NUM`
- **Index** unique `XPKAB_JOB`: `AB_JOB_NUM`

### AB_JOB_870_HISTORY

_~4,566 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `EDI_FILE_NAME` | VARCHAR2(40) |  |  |
| 4 | `CREATE_870_DATE_TIME` | TIMESTAMP(6) |  |  |
| 5 | `USER_ID` | VARCHAR2(50) |  |  |
| 6 | `NOTES` | VARCHAR2(512) |  |  |

- **PK:** `AB_JOB_NUM`, `EDI_FILE_ID`
- **Index** unique `PFK_AB_JOB_870_HISTORY`: `AB_JOB_NUM`, `EDI_FILE_ID`

### AB_JOB_STATUS_DESC

_~5 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_STATUS_CODE` 🔑 | NUMBER | NOT NULL |  |
| 2 | `AB_JOB_STATUS_DESC` | VARCHAR2(56) |  |  |

- **PK:** `AB_JOB_STATUS_CODE`
- **Index** unique `AB_JOB_STATUS_DESC`: `AB_JOB_STATUS_CODE`

### ALCAN_COIL_RETEST_DATE

_~6,045 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 2 | `RETEST_DATE` | DATE | NOT NULL |  |

- **PK:** `COIL_ORG_NUM`
- **Index** unique `ALCAN_COIL_RETEST_DATE_PK`: `COIL_ORG_NUM`

### ALEX1

_~2 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_FULL_NAME` | VARCHAR2(60) | NOT NULL |  |
| 3 | `CUSTOMER_TYPE` | NUMBER(2,0) |  |  |
| 4 | `CUSTOMER_SHORT_NAME` | CHAR(18) | NOT NULL |  |
| 5 | `CUSTOMER_STREET` | VARCHAR2(100) |  |  |
| 6 | `CUSTOMER_CITY` | CHAR(18) |  |  |
| 7 | `CUSTOMER_STATE` | VARCHAR2(30) |  |  |
| 8 | `CUSTOMER_ZIP` | CHAR(18) |  |  |
| 9 | `CUSTOMER_COUNTRY` | CHAR(18) |  |  |
| 10 | `CUSTOMER_PHONE_NUMBER` | CHAR(18) |  |  |
| 11 | `CUSTOMER_FAX_NUMBER` | CHAR(18) |  |  |
| 12 | `CUSTOMER_CREATE_DATE` | DATE |  |  |
| 13 | `CUSTOMER_MAINT_DATE` | DATE |  |  |
| 14 | `CUSTOMER_NOTES` | VARCHAR2(255) |  |  |
| 15 | `PARENT_ID` | NUMBER(8,0) |  |  |
| 16 | `TAX_ID` | VARCHAR2(32) |  |  |
| 17 | `TAX_EXEMPTION_NUM` | VARCHAR2(32) |  |  |
| 18 | `TAX_RATE` | NUMBER(2,2) |  |  |
| 19 | `CUSTOMER_DUNS_NUMBER` | NUMBER(9,0) |  |  |
| 20 | `BILL_TO_STREET` | VARCHAR2(64) |  |  |
| 21 | `BILL_TO_CITY` | VARCHAR2(18) |  |  |
| 22 | `BILL_TO_STATE` | VARCHAR2(30) |  |  |
| 23 | `BILL_TO_ZIP` | VARCHAR2(18) |  |  |
| 24 | `CUSTOMER_EXTERNAL_ID` | VARCHAR2(9) |  |  |
| 25 | `CUSTOMER_DUNS_NUMBER_STRING` | VARCHAR2(18) |  |  |
| 26 | `DESADV_REQ` | CHAR(1) |  |  |
| 27 | `EDI_REQ` | CHAR(1) |  |  |
| 28 | `QR_CODE_REQ` | CHAR(1) |  |  |


### ALLOY_DENSITY

_~41 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ALLOY_NUM` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `DENSITY` | NUMBER(3,3) |  |  |

- **PK:** `ALLOY_NUM`
- **Index** unique `SYS_C0036511`: `ALLOY_NUM`

### ALLOY_HEAT_TREATMENT

_~248 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ALLOY` 🔑 | VARCHAR2(40) | NOT NULL |  |
| 2 | `HEAT_TREATED` | CHAR(1) |  |  |

- **PK:** `ALLOY`
- **Index** unique `XPK_ALLOY_HEAT_TREATMENT`: `ALLOY`

### ALLOY_TYPE

_~45 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ALLOY` 🔑 | VARCHAR2(20) | NOT NULL |  |
| 2 | `ALCAN_SCRAP_PO` | VARCHAR2(20) | NOT NULL |  |
| 3 | `CUSTOMER_ID` 🔑 | NUMBER(5,0) | NOT NULL |  |

- **PK:** `ALLOY`, `CUSTOMER_ID`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `PK_ALLOY_CUSTOMER_ID`: `ALLOY`, `CUSTOMER_ID`

### ALPHABET

_~26 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LETTER_NUMBER` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `LETTER` | CHAR(1) |  |  |

- **PK:** `LETTER_NUMBER`
- **Index** unique `PFK_ALPHABET`: `LETTER_NUMBER`

### APP_MAIN_MENU

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ITEM_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `ITEM_NAME` | VARCHAR2(32) | NOT NULL |  |
| 3 | `ITEM_LEVEL` | NUMBER(4,0) | NOT NULL |  |
| 4 | `ITEM_PARENT` | NUMBER(4,0) | NOT NULL |  |
| 5 | `ITEM_ACTIVE` | NUMBER(1,0) | NOT NULL |  |
| 6 | `ITEM_APP` | VARCHAR2(64) |  |  |
| 7 | `ITEM_DESC` | VARCHAR2(512) |  |  |

- **PK:** `ITEM_ID`
- **Index** unique `SYS_C0036513`: `ITEM_ID`

### AUTO_REPORT_CUSTOMERS

_~47 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_NAME` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 2 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `CUSTOMER_NAME`, `CUSTOMER_ID`
- **Index** unique `XPK_AUTO_REPORT_CUSTOMERS`: `CUSTOMER_NAME`, `CUSTOMER_ID`

### AUTO_REPORT_EMAILS

_~212 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `REPORT_NAME` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 2 | `CUSTOMER_NAME` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 3 | `EMAIL_ADDRESS` 🔑 | VARCHAR2(128) | NOT NULL |  |
| 4 | `NOTE` | VARCHAR2(128) |  |  |
| 5 | `REPORT_NAME_4DISPLAY` | VARCHAR2(60) |  |  |
| 6 | `CUSTOMER_NAME_4DISPLAY` | VARCHAR2(60) |  |  |

- **PK:** `REPORT_NAME`, `CUSTOMER_NAME`, `EMAIL_ADDRESS`
- **Index** unique `XPK_AUTO_REPORT_EMAILS`: `REPORT_NAME`, `CUSTOMER_NAME`, `EMAIL_ADDRESS`

### AUTO_REPORT_RUN_LOG

_~227,357 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `RUN_DATE` | TIMESTAMP(6) | NOT NULL |  |
| 2 | `RUN_MESSAGE` | VARCHAR2(512) |  |  |


### AUTO_REPORT_SCHEDULE

_~120 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `REPORT_NAME` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 2 | `CUSTOMER_NAME` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 3 | `RUN_DAY_NAME` 🔑 | VARCHAR2(10) | NOT NULL |  |
| 4 | `RUN_TIME` 🔑 | VARCHAR2(5) | NOT NULL |  |
| 5 | `RUN_DAY_NUM` | VARCHAR2(10) |  |  |
| 6 | `REPORT_NAME_4DISPLAY` | VARCHAR2(60) |  |  |
| 7 | `CUSTOMER_NAME_4DISPLAY` | VARCHAR2(60) |  |  |

- **PK:** `REPORT_NAME`, `CUSTOMER_NAME`, `RUN_DAY_NAME`, `RUN_TIME`
- **Index** unique `XPK_AUTO_REPORT_SCHEDULE`: `REPORT_NAME`, `CUSTOMER_NAME`, `RUN_DAY_NAME`, `RUN_TIME`

### BARCODE_STRING

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 2 | `BARCODE_STRING` | VARCHAR2(4000) |  |  |

- **PK:** `COIL_ORG_NUM`
- **Index** unique `XPK_BARCODE_STRING`: `COIL_ORG_NUM`

### BILLTO_ALBL_EMAIL

_~1 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EMAIL` | VARCHAR2(32) | NOT NULL |  |


### CARRIER

_~1,004 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CARRIER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SCAC` | VARCHAR2(8) |  |  |
| 3 | `CARRIER_FULL_NAME` | VARCHAR2(60) |  |  |
| 4 | `CARRIER_TYPE_CODE` | VARCHAR2(36) |  |  |
| 5 | `CARRIER_STREET` | VARCHAR2(60) |  |  |
| 6 | `CARRIER_CITY` | VARCHAR2(18) |  |  |
| 7 | `CARRIER_STATE` | VARCHAR2(30) |  |  |
| 8 | `CARRIER_ZIP` | VARCHAR2(18) |  |  |
| 9 | `CARRIER_COUNTRY` | VARCHAR2(18) |  |  |
| 10 | `CARRIER_PHONE_NUMBER` | VARCHAR2(18) |  |  |
| 11 | `CARRIER_NOTE` | VARCHAR2(255) |  |  |
| 12 | `CARRIER_DUNS_NUMBER` | NUMBER(9,0) |  |  |
| 13 | `STATUS` | NUMBER(2,0) |  |  |

- **PK:** `CARRIER_ID`
- **Index** unique `XPKCARRIER`: `CARRIER_ID`

### CCARD

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CCARD_ID` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 2 | `CCARD_NAME` | VARCHAR2(64) | NOT NULL |  |
| 3 | `CCARD_EXPIRES` | DATE | NOT NULL |  |
| 4 | `CCARD_FOR` | VARCHAR2(128) |  |  |

- **PK:** `CCARD_ID`
- **Index** unique `SYS_C0036515`: `CCARD_ID`

### CERT_LABEL_CUSTOMER

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_CODE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `CUSTOMER_NAME` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `CUSTOMER_CODE`
- **Index** unique `XPK_CERT_LABEL_CUSTOMER`: `CUSTOMER_CODE`

### CERT_LABEL_CUSTOMERS

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`
- **Index** unique `XPK_CERT_LABEL_CUSTOMERS`: `CUSTOMER_ID`

### CERT_LABEL_DATA_ELEMENTS

_~70 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_CODE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `DATA_ELEMENT` 🔑 | VARCHAR2(10) | NOT NULL |  |
| 4 | `DATA_ELEMENT_DESC` | VARCHAR2(50) |  |  |
| 5 | `SEQ_NUM` | NUMBER |  |  |

- **PK:** `CUSTOMER_ID`, `CUSTOMER_CODE`, `DATA_ELEMENT`
- **Index** unique `XPK_CERT_LABEL_DATA_ELEMENTS`: `CUSTOMER_ID`, `CUSTOMER_CODE`, `DATA_ELEMENT`

### CERT_LABEL_SHIPTO_NAME

_~2 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CERT_LABEL_SHIPTO_NAME` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`
- **Index** unique `XPK_CERT_LABEL_SHIPTO_NAME`: `CUSTOMER_ID`

### CHEMICAL_ELEMENTS

_~118 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SYMBOL` 🔑 | VARCHAR2(3) | NOT NULL |  |
| 2 | `ELEMENT_NAME` | VARCHAR2(25) |  |  |

- **PK:** `SYMBOL`
- **Index** unique `SYS_C0036858`: `SYMBOL`

### CHEVRON

_~1,316 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `CH_LENGTH` | NUMBER(10,5) |  |  |
| 4 | `CH_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 5 | `CH_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 6 | `CH_WIDTH` | NUMBER(10,5) |  |  |
| 7 | `CH_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 8 | `CH_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 9 | `CH_DIE` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKCHEVRON`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### CIRCLE

_~543 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `C_DIAMETER` | NUMBER(10,5) |  |  |
| 4 | `C_DIAMETER_PLUS` | NUMBER(6,6) |  |  |
| 5 | `C_DIAMETER_MINUS` | NUMBER(6,6) |  |  |
| 6 | `C_DIE1` | VARCHAR2(18) |  |  |
| 7 | `C_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKCIRCLE`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### COIL

_~149,563 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` | VARCHAR2(32) | NOT NULL |  |
| 3 | `CUSTOMER_ID` | NUMBER(8,0) |  |  |
| 4 | `ICRA` | CHAR(18) |  |  |
| 5 | `MATERIAL_TYPE` | NUMBER(2,0) |  |  |
| 6 | `COIL_MID_NUM` | VARCHAR2(18) |  |  |
| 7 | `COIL_STATUS` | NUMBER(4,0) |  |  |
| 8 | `COIL_ALLOY` | NUMBER(4,0) |  |  |
| 9 | `COIL_TEMPER` | VARCHAR2(8) |  |  |
| 10 | `LOT_NUM` | VARCHAR2(18) | NOT NULL |  |
| 11 | `COIL_GAUGE` | NUMBER(5,4) |  |  |
| 12 | `COIL_WIDTH` | NUMBER(8,3) |  |  |
| 13 | `DATE_RECEIVED` | DATE |  |  |
| 14 | `COIL_ENTRY_DATE` | DATE |  |  |
| 15 | `NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 16 | `PIECES_PER_CASE` | NUMBER(2,0) |  |  |
| 17 | `COIL_LOCATION` | VARCHAR2(18) |  |  |
| 18 | `NET_WT_BALANCE` | NUMBER(8,0) | NOT NULL |  |
| 19 | `COIL_NOTES` | VARCHAR2(255) |  |  |
| 20 | `COIL_LINE_NUM` | NUMBER(4,0) |  |  |
| 21 | `COIL_EDI856_STATUS` | NUMBER(2,0) |  |  |
| 22 | `COIL_FROM_CUST_ID` | NUMBER(8,0) |  |  |
| 23 | `COIL_ALLOY2` | VARCHAR2(8) |  |  |
| 24 | `REBAND_WT` | NUMBER(8,0) |  |  |
| 25 | `REJECT_WT` | NUMBER(8,0) |  |  |
| 26 | `RECOVERY_RATE` | NUMBER(5,2) |  |  |
| 27 | `NET_WT_BALANCE_FROM_LINE` | NUMBER(8,0) |  |  |
| 28 | `COIL_STATUS_FROM_LINE` | NUMBER(4,0) |  |  |
| 29 | `PART_NUM` | VARCHAR2(32) |  |  |
| 30 | `SUPPLIER_SALES_NUM` | VARCHAR2(32) |  |  |
| 31 | `PURCHASE_ORDER_NUM` | VARCHAR2(32) |  |  |
| 32 | `ABCO_COIL_NET_WT` | NUMBER(8,0) |  |  |
| 33 | `CONSUMED_COIL_NUM` | VARCHAR2(32) |  |  |
| 34 | `MATERIAL_NUM` | VARCHAR2(32) |  |  |
| 35 | `CASH_DATE` | VARCHAR2(24) |  |  |
| 36 | `SCRAP_870_DATE` | DATE |  |  |
| 37 | `COIL_ABC_NUM_PREVIOUS` | NUMBER(8,0) |  |  |
| 38 | `CUSTOMER_ID_PREVIOUS` | NUMBER(8,0) |  |  |
| 39 | `COIL_ABC_NUM_NEW` | NUMBER(8,0) |  |  |
| 40 | `CUSTOMER_ID_NEW` | NUMBER(8,0) |  |  |
| 41 | `VO` | VARCHAR2(40) |  |  |
| 42 | `PO` | VARCHAR2(40) |  |  |
| 43 | `CNTRY_OF_CAST` | VARCHAR2(4) |  |  |
| 44 | `LFEED` | NUMBER(6,0) |  |  |
| 45 | `PRODUCTION_DESC_CODE` | CHAR(2) |  |  |
| 46 | `CUSTOMER_PO` | VARCHAR2(40) |  |  |

- **PK:** `COIL_ABC_NUM`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`COIL_FROM_CUST_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKINVENTORY`: `COIL_ABC_NUM`

### COILS_WEIGHT_ZEROED_OUT

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_NAME` | VARCHAR2(18) |  |  |
| 2 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 3 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 4 | `COIL_NET_WT` | NUMBER(8,0) |  |  |
| 5 | `SUM_PROCESS_WT` | NUMBER(10,0) |  |  |
| 6 | `LINE_DESC` | VARCHAR2(255) |  |  |
| 7 | `TIME_DATE_FINISHED` | DATE |  |  |


### COIL_EVAL_SHEET_DETAIL

_~61 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 5 | `SHIFT` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 6 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 7 | `EVAL_DATE` 🔑 | DATE | NOT NULL |  |
| 8 | `BL_LINE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 9 | `SKID_PIECES_PREV_COIL` | NUMBER(6,0) |  |  |
| 10 | `ITEM_GAUGE` | VARCHAR2(20) |  |  |
| 11 | `ITEM_WIDTH` | VARCHAR2(20) |  |  |
| 12 | `ITEM_LENGTH_OPERATOR` | VARCHAR2(20) |  |  |
| 13 | `ITEM_LENGTH_DRIVE` | VARCHAR2(20) |  |  |
| 14 | `ITEM_SQUARE` | VARCHAR2(20) |  |  |
| 15 | `ITEM_FLATNESS` | VARCHAR2(20) |  |  |
| 16 | `SKID_PIECES_THIS_COIL` | NUMBER(6,0) |  |  |
| 17 | `SHIFT_NUM` | VARCHAR2(20) |  |  |
| 18 | `ONHOLD` | CHAR(1) |  |  |
| 19 | `COMMENTS` | VARCHAR2(256) |  |  |
| 20 | `PROCESS_QUANTITY` | NUMBER(8,0) |  |  |
| 21 | `TRIM_SCRAP_GAUGE` | NUMBER(8,4) |  |  |
| 22 | `TRIM_SCRAP_WIDTH` | NUMBER(8,4) |  |  |
| 23 | `OD_CROP_LENGTH` | NUMBER(8,0) |  |  |
| 24 | `OD_CROP_NUM_OF_PIECES` | NUMBER(8,0) |  |  |
| 25 | `ID_CROP_LENGTH` | NUMBER(8,0) |  |  |
| 26 | `ID_CROP_NUM_OF_PIECES` | NUMBER(8,0) |  |  |
| 27 | `REQUIRES_OIL_Y_N` | CHAR(1) |  |  |
| 28 | `OIL_TYPE` | VARCHAR2(32) |  |  |
| 29 | `CAMBER_HEAD` | NUMBER(8,4) |  |  |
| 30 | `CAMBER_MIDDLE` | NUMBER(8,4) |  |  |
| 31 | `CAMBER_TAIL` | NUMBER(8,4) |  |  |
| 32 | `SCRAP_36_INCH_PIECES` | NUMBER(6,0) |  |  |
| 33 | `SCRAP_36_INCH_WT` | NUMBER(6,2) |  |  |
| 34 | `ADDL_COMMENTS` | VARCHAR2(256) |  |  |

- **PK:** `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SKID_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`
- **Index** unique `XPK_COIL_EVAL_SHEET_DETAIL`: `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SKID_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`

### COIL_EVAL_SHEET_DETAIL2

_~56 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 5 | `SHIFT` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 6 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 7 | `EVAL_DATE` 🔑 | DATE | NOT NULL |  |
| 8 | `BL_LINE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 9 | `SKID_PIECES_PREV_COIL` | NUMBER(6,0) |  |  |
| 10 | `ITEM_GAUGE` | VARCHAR2(20) |  |  |
| 11 | `ITEM_WIDTH` | VARCHAR2(20) |  |  |
| 12 | `ITEM_LENGTH_OPERATOR` | VARCHAR2(20) |  |  |
| 13 | `ITEM_LENGTH_DRIVE` | VARCHAR2(20) |  |  |
| 14 | `ITEM_SQUARE` | VARCHAR2(20) |  |  |
| 15 | `ITEM_FLATNESS` | VARCHAR2(20) |  |  |
| 16 | `SKID_PIECES_THIS_COIL` | NUMBER(6,0) |  |  |
| 17 | `SHIFT_NUM` | VARCHAR2(20) |  |  |
| 18 | `ONHOLD` | CHAR(1) |  |  |
| 19 | `COMMENTS` | VARCHAR2(256) |  |  |
| 20 | `PROCESS_QUANTITY` | NUMBER(8,0) |  |  |
| 21 | `TRIM_SCRAP_GAUGE` | NUMBER(8,4) |  |  |
| 22 | `TRIM_SCRAP_WIDTH` | NUMBER(8,4) |  |  |
| 23 | `OD_CROP_LENGTH` | NUMBER(8,0) |  |  |
| 24 | `OD_CROP_NUM_OF_PIECES` | NUMBER(8,0) |  |  |
| 25 | `ID_CROP_LENGTH` | NUMBER(8,0) |  |  |
| 26 | `ID_CROP_NUM_OF_PIECES` | NUMBER(8,0) |  |  |
| 27 | `REQUIRES_OIL_Y_N` | CHAR(1) |  |  |
| 28 | `OIL_TYPE` | VARCHAR2(32) |  |  |
| 29 | `CAMBER_HEAD` | NUMBER(8,4) |  |  |
| 30 | `CAMBER_MIDDLE` | NUMBER(8,4) |  |  |
| 31 | `CAMBER_TAIL` | NUMBER(8,4) |  |  |
| 32 | `SCRAP_36_INCH_PIECES` | NUMBER(6,0) |  |  |
| 33 | `SCRAP_36_INCH_WT` | NUMBER(6,2) |  |  |
| 34 | `ADDL_COMMENTS` | VARCHAR2(256) |  |  |

- **PK:** `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SKID_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`
- **Index** unique `XPK_COIL_EVAL_SHEET_DETAIL2`: `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SKID_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`

### COIL_EVAL_SHEET_DETAIL3

_~56 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 5 | `SHIFT` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 6 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 7 | `EVAL_DATE` 🔑 | DATE | NOT NULL |  |
| 8 | `BL_LINE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 9 | `SKID_PIECES_PREV_COIL` | NUMBER(6,0) |  |  |
| 10 | `ITEM_GAUGE` | NUMBER(8,4) |  |  |
| 11 | `ITEM_WIDTH` | NUMBER(8,4) |  |  |
| 12 | `ITEM_LENGTH_OPERATOR` | NUMBER(8,4) |  |  |
| 13 | `ITEM_LENGTH_DRIVE` | NUMBER(8,4) |  |  |
| 14 | `ITEM_SQUARE` | NUMBER(8,4) |  |  |
| 15 | `ITEM_FLATNESS` | NUMBER(8,4) |  |  |
| 16 | `SKID_PIECES_THIS_COIL` | NUMBER(6,0) |  |  |
| 17 | `SHIFT_NUM` | VARCHAR2(20) |  |  |
| 18 | `ONHOLD` | CHAR(1) |  |  |
| 19 | `COMMENTS` | VARCHAR2(256) |  |  |
| 20 | `PROCESS_QUANTITY` | NUMBER(8,0) |  |  |
| 21 | `TRIM_SCRAP_GAUGE` | NUMBER(8,4) |  |  |
| 22 | `TRIM_SCRAP_WIDTH` | NUMBER(8,4) |  |  |
| 23 | `OD_CROP_LENGTH` | NUMBER(8,0) |  |  |
| 24 | `OD_CROP_NUM_OF_PIECES` | NUMBER(8,0) |  |  |
| 25 | `ID_CROP_LENGTH` | NUMBER(8,0) |  |  |
| 26 | `ID_CROP_NUM_OF_PIECES` | NUMBER(8,0) |  |  |
| 27 | `REQUIRES_OIL_Y_N` | CHAR(1) |  |  |
| 28 | `OIL_TYPE` | VARCHAR2(32) |  |  |
| 29 | `CAMBER_HEAD` | NUMBER(8,4) |  |  |
| 30 | `CAMBER_MIDDLE` | NUMBER(8,4) |  |  |
| 31 | `CAMBER_TAIL` | NUMBER(8,4) |  |  |
| 32 | `SCRAP_36_INCH_PIECES` | NUMBER(6,0) |  |  |
| 33 | `SCRAP_36_INCH_WT` | NUMBER(6,2) |  |  |
| 34 | `ADDL_COMMENTS` | VARCHAR2(256) |  |  |

- **PK:** `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SKID_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`
- **Index** unique `XPK_COIL_EVAL_SHEET_DETAIL3`: `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SKID_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`

### COIL_EVAL_SHEET_HEADER

_~68 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `SHIFT` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 5 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 6 | `EVAL_DATE` 🔑 | DATE | NOT NULL |  |
| 7 | `BL_LINE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 8 | `PROCESS_QUANTITY` | NUMBER(8,0) |  |  |
| 9 | `TRIM_SCRAP_GAUGE` | NUMBER(8,4) |  |  |
| 10 | `TRIM_SCRAP_WIDTH` | NUMBER(8,4) |  |  |
| 11 | `CROP_LENGTH` | NUMBER(8,4) |  |  |
| 12 | `FEED_LENGTH` | NUMBER(8,4) |  |  |
| 13 | `REQUIRES_OIL_Y_N` | CHAR(1) |  |  |
| 14 | `OIL_TYPE` | VARCHAR2(32) |  |  |
| 15 | `CAMBER_HEAD` | NUMBER(8,4) |  |  |
| 16 | `CAMBER_MIDDLE` | NUMBER(8,4) |  |  |
| 17 | `CAMBER_TAIL` | NUMBER(8,4) |  |  |
| 18 | `SCRAP_36_INCH_PIECES` | NUMBER(6,0) |  |  |
| 19 | `SCRAP_36_INCH_WT` | NUMBER(12,4) |  |  |
| 20 | `ADDL_COMMENTS` | VARCHAR2(2560) |  |  |
| 21 | `SHIFT_NUM` | VARCHAR2(20) |  |  |
| 22 | `TRIM_SCRAP_WT` | NUMBER(12,4) |  |  |
| 23 | `ENGINEERED_SCRAP_WT` | NUMBER(12,4) |  |  |
| 24 | `CROP_SCRAP_WT` | NUMBER(12,4) |  |  |

- **PK:** `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`
- **Index** unique `XPK_COIL_EVAL_SHEET_HEADER`: `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`

### COIL_EVAL_SHEET_SCRAP

_~77 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `SCRAP_CODE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 5 | `SHIFT` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 6 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 7 | `EVAL_DATE` 🔑 | DATE | NOT NULL |  |
| 8 | `BL_LINE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 9 | `SCRAP_PIECES` | NUMBER(6,0) |  |  |
| 10 | `SCRAP_LBS` | NUMBER(6,0) |  |  |
| 11 | `COMMENTS` | VARCHAR2(256) |  |  |
| 12 | `SCRAP_LOCATION` | NUMBER |  |  |
| 13 | `INPUT_SEQUENCE` | NUMBER(3,0) |  |  |
| 14 | `CROP_OR_FEED_LENGTH` | VARCHAR2(20) |  |  |

- **PK:** `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SCRAP_CODE`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`
- **Index** unique `XPK_COIL_EVAL_SHEET_SCRAP`: `AB_JOB_NUM`, `COIL_ORG_NUM`, `COIL_ABC_NUM`, `SCRAP_CODE`, `SHIFT`, `EMPLOYEE_ID`, `EVAL_DATE`, `BL_LINE`

### COIL_LOG

_~2 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ENTRY_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LOG_AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 3 | `LOG_COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 4 | `STATUS_NEW` | NUMBER(4,0) |  |  |
| 5 | `LOG_NET_BALANC` | NUMBER(8,0) |  |  |
| 6 | `LOG_NOTES` | VARCHAR2(255) |  |  |
| 7 | `LOG_DATE` | DATE |  |  |

- **PK:** `ENTRY_NUM`
- **Index** unique `XPKCOIL_LOG`: `ENTRY_NUM`

### COIL_LUBE_WEIGHT

_~1,261 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LUBE_WEIGHT_TYPE` | VARCHAR2(10) |  |  |
| 3 | `SOURCE_CUSTOMER_ID` | NUMBER(8,0) |  |  |
| 4 | `READY_STATUS` | NUMBER(1,0) |  |  |
| 5 | `SET_READY_TIME` | DATE |  |  |

- **PK:** `COIL_ABC_NUM`
- **Index** unique `SYS_C0036520`: `COIL_ABC_NUM`

### COIL_OWNERSHIP_TRANSFER

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CERTIFICATE_NUM` | NUMBER(10,0) | NOT NULL |  |
| 2 | `COIL_ABC_NUM_ORIG` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `CUSTOMER_ID_ORIG` | NUMBER(8,0) |  |  |
| 4 | `CUSTOMER_ID_NEW` | NUMBER(8,0) |  |  |
| 5 | `COIL_ORG_NUM` | VARCHAR2(32) |  |  |
| 6 | `COIL_ABC_NUM_NEW` | NUMBER(8,0) |  |  |
| 7 | `TRANSFER_DATETIME` | DATE |  |  |
| 8 | `TRANSFER_PERFORMED_BY` | VARCHAR2(32) |  |  |
| 9 | `AUTHORIZATION_NOTE` | VARCHAR2(100) |  |  |
| 10 | `NOTES` | VARCHAR2(255) |  |  |

- **PK:** `COIL_ABC_NUM_ORIG`
- **Index** unique `PFK_COIL_OWNERSHIP_TRANSFER`: `COIL_ABC_NUM_ORIG`

### COIL_QUALITY

_~6,871 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` | VARCHAR2(32) | NOT NULL |  |
| 3 | `PART_NUM` | VARCHAR2(20) |  |  |
| 4 | `MATERIAL_GRADE` | VARCHAR2(10) |  |  |
| 5 | `PRE_TREATMENT_FLAG` | CHAR(1) |  |  |
| 6 | `CASH_DATE_JULIAN5` | VARCHAR2(5) |  |  |
| 7 | `CASH_DATE` | DATE |  |  |
| 8 | `CM_DATE` | DATE |  |  |
| 9 | `MILL_ID` | VARCHAR2(5) |  |  |
| 10 | `GROSS_COIL_LENGTH` | NUMBER(6,0) |  |  |
| 11 | `GROSS_COIL_LENGTH_UOM` | CHAR(6) |  |  |
| 12 | `NET_COIL_LENGTH` | NUMBER(6,0) |  |  |
| 13 | `NET_COIL_LENGTH_UOM` | CHAR(6) |  |  |
| 14 | `COIL_WIDTH` | NUMBER(8,3) |  |  |
| 15 | `COIL_WIDTH_UOM` | CHAR(6) |  |  |
| 16 | `COIL_WEIGHT` | NUMBER(7,0) |  |  |
| 17 | `COIL_WEIGHT_UOM` | CHAR(6) |  |  |
| 18 | `MATERIAL_THIKNESS` | NUMBER(5,4) |  |  |
| 19 | `MATERIAL_THIKNESS_UOM` | CHAR(6) |  |  |
| 20 | `CASH_LINE_ID` | NUMBER(5,0) |  |  |
| 21 | `PAYOFF_DIRECTION` | CHAR(1) |  |  |
| 22 | `SAMPLING_REQUIRED` | CHAR(1) |  |  |
| 23 | `PCC_NUMBER` | VARCHAR2(12) |  |  |
| 24 | `REVISION_LEVEL` | VARCHAR2(2) |  |  |

- **PK:** `COIL_ABC_NUM`
- **Index** unique `XPK_COIL_QUALITY`: `COIL_ABC_NUM`

### COIL_QUALITY_FLAW_MAPPING

_~6,074 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ORG_NUM` | VARCHAR2(32) | NOT NULL |  |
| 3 | `STARTING_POSITION` 🔑 | NUMBER(10,4) | NOT NULL |  |
| 4 | `ENDING_POSITION` 🔑 | NUMBER(10,4) | NOT NULL |  |
| 5 | `FLAW_CODE` 🔑 | CHAR(1) | NOT NULL |  |
| 6 | `STARTING_POSITION_UOM` | CHAR(6) |  |  |
| 7 | `ENDING_POSITION_UOM` | CHAR(6) |  |  |
| 8 | `HANDLING_CODE` | CHAR(1) |  |  |

- **PK:** `COIL_ABC_NUM`, `STARTING_POSITION`, `ENDING_POSITION`, `FLAW_CODE`
- **Index** unique `XPK_COIL_QUALITY_FLAW_MAPPING`: `COIL_ABC_NUM`, `STARTING_POSITION`, `ENDING_POSITION`, `FLAW_CODE`

### COIL_RECEIVING

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `BOL` 🔑 | VARCHAR2(40) | NOT NULL |  |
| 3 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `COIL_RECEIVING_TIME` | DATE |  |  |
| 5 | `RECEIVING_OPERATOR` | VARCHAR2(40) |  |  |
| 6 | `COIL_RECEIVING_STATUS` | NUMBER(8,0) |  |  |

- **PK:** `COIL_ABC_NUM`, `BOL`, `CUSTOMER_ID`
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036521`: `COIL_ABC_NUM`, `BOL`, `CUSTOMER_ID`

### COIL_STATUS

_~15 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_STATUS_CODE` | NUMBER | NOT NULL |  |
| 2 | `COIL_STATUS_DESC` | VARCHAR2(50) |  |  |


### COIL_TRACK

_~93,468 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_TRACK_DATE` 🔑 | DATE | NOT NULL |  |
| 3 | `COIL_PRE_STATUS` | NUMBER(4,0) | NOT NULL |  |
| 4 | `COIL_CUR_STATUS` | NUMBER(4,0) | NOT NULL |  |
| 5 | `COIL_PRE_NETWT` | NUMBER(8,0) | NOT NULL |  |
| 6 | `COIL_CUR_NETWT` | NUMBER(8,0) | NOT NULL |  |
| 7 | `COIL_MODIFIED_BY` | VARCHAR2(64) |  |  |
| 8 | `COIL_PRE_LOCATION` | VARCHAR2(64) |  |  |
| 9 | `COIL_CUR_LOCATION` | VARCHAR2(64) |  |  |
| 10 | `SCRAP_870_DATE` | DATE |  |  |

- **PK:** `COIL_ABC_NUM`, `COIL_TRACK_DATE`
- **Index** unique `COIL_TRACK_PK1`: `COIL_ABC_NUM`, `COIL_TRACK_DATE`

### COIL_TRACK_QA

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_TRACK_DATE` 🔑 | DATE | NOT NULL |  |
| 3 | `COIL_PRE_STATUS` | NUMBER(2,0) | NOT NULL |  |
| 4 | `COIL_CUR_STATUS` | NUMBER(2,0) | NOT NULL |  |
| 5 | `COIL_MODIFIED_BY` | VARCHAR2(64) | NOT NULL |  |
| 6 | `NOTE` | VARCHAR2(1024) | NOT NULL |  |

- **PK:** `COIL_ABC_NUM`, `COIL_TRACK_DATE`
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **Index** unique `SYS_C0036523`: `COIL_ABC_NUM`, `COIL_TRACK_DATE`

### CUSTOMER

_~1,973 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_FULL_NAME` | VARCHAR2(60) | NOT NULL |  |
| 3 | `CUSTOMER_TYPE` | NUMBER(2,0) |  |  |
| 4 | `CUSTOMER_SHORT_NAME` | CHAR(18) | NOT NULL |  |
| 5 | `CUSTOMER_STREET` | VARCHAR2(100) |  |  |
| 6 | `CUSTOMER_CITY` | CHAR(18) |  |  |
| 7 | `CUSTOMER_STATE` | VARCHAR2(30) |  |  |
| 8 | `CUSTOMER_ZIP` | CHAR(18) |  |  |
| 9 | `CUSTOMER_COUNTRY` | CHAR(18) |  |  |
| 10 | `CUSTOMER_PHONE_NUMBER` | CHAR(18) |  |  |
| 11 | `CUSTOMER_FAX_NUMBER` | CHAR(18) |  |  |
| 12 | `CUSTOMER_CREATE_DATE` | DATE |  |  |
| 13 | `CUSTOMER_MAINT_DATE` | DATE |  |  |
| 14 | `CUSTOMER_NOTES` | VARCHAR2(255) |  |  |
| 15 | `PARENT_ID` | NUMBER(8,0) |  |  |
| 16 | `TAX_ID` | VARCHAR2(32) |  |  |
| 17 | `TAX_EXEMPTION_NUM` | VARCHAR2(32) |  |  |
| 18 | `TAX_RATE` | NUMBER(2,2) |  |  |
| 19 | `CUSTOMER_DUNS_NUMBER` | NUMBER(9,0) |  |  |
| 20 | `BILL_TO_STREET` | VARCHAR2(64) |  |  |
| 21 | `BILL_TO_CITY` | VARCHAR2(18) |  |  |
| 22 | `BILL_TO_STATE` | VARCHAR2(30) |  |  |
| 23 | `BILL_TO_ZIP` | VARCHAR2(18) |  |  |
| 24 | `CUSTOMER_EXTERNAL_ID` | VARCHAR2(9) |  |  |
| 25 | `CUSTOMER_DUNS_NUMBER_STRING` | VARCHAR2(18) |  |  |
| 26 | `DESADV_REQ` | CHAR(1) |  |  |
| 27 | `EDI_REQ` | CHAR(1) |  |  |
| 28 | `QR_CODE_REQ` | CHAR(1) |  |  |
| 29 | `VALIDATE_MATERIAL` | CHAR(1) |  |  |
| 30 | `USE_PACKAGE_NUM` | CHAR(1) |  |  |
| 31 | `USE_CUSTOMER_WEBSITE_4SHIPPING` | CHAR(1) |  |  |
| 32 | `CASH_DATE_REQUIRED` | CHAR(1) |  |  |
| 33 | `CASH_DATE_ON_BOL` | CHAR(1) |  |  |
| 34 | `COIL_CERT_LABEL_REQ` | CHAR(1) |  |  |
| 35 | `CREATE_861_AT_RECEIVING` | CHAR(1) |  |  |
| 36 | `INV_REPORT_SAVEAS_XLSX` | VARCHAR2(1) |  |  |
| 37 | `CUST_PO_ON_INV_SKID_REPORT` | CHAR(1) |  |  |
| 38 | `USE_EDI_CODE_NOT_DUNS` | CHAR(1) |  |  |
| 39 | `PLANT_CODE` | VARCHAR2(32) |  |  |

- **PK:** `CUSTOMER_ID`
- **FK:** (`CUSTOMER_TYPE`) → `CUSTOMER_TYPE` (`CUSTOMER_TYPE`)
- **FK:** (`PARENT_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKCUSTOMER`: `CUSTOMER_ID`

### CUSTOMER_CONTACT

_~63 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CONTACT_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 3 | `FIRST_NAME` | VARCHAR2(18) |  |  |
| 4 | `LAST_NAME` | VARCHAR2(18) |  |  |
| 5 | `DEPARTMENT` | VARCHAR2(18) |  |  |
| 6 | `ADDRESS` | VARCHAR2(18) |  |  |
| 7 | `CITY` | VARCHAR2(18) |  |  |
| 8 | `STATE` | VARCHAR2(30) |  |  |
| 9 | `ZIP` | CHAR(10) |  |  |
| 10 | `COUNTRY` | VARCHAR2(18) |  |  |
| 11 | `PHONE1` | VARCHAR2(18) |  |  |
| 12 | `PHONE2` | VARCHAR2(18) |  |  |
| 13 | `FAX` | VARCHAR2(18) |  |  |
| 14 | `EMAIL1` | VARCHAR2(50) |  |  |
| 15 | `EMAIL2` | VARCHAR2(50) |  |  |

- **PK:** `CONTACT_ID`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKCUSTOMER_CONTACT`: `CONTACT_ID`

### CUSTOMER_CUSTOMER

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `O_CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `E_CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SUPPLY_CODE` | VARCHAR2(18) |  |  |

- **PK:** `O_CUSTOMER_ID`, `E_CUSTOMER_ID`
- **FK:** (`E_CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`O_CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKCUSTOMER_CUSTOMER`: `O_CUSTOMER_ID`, `E_CUSTOMER_ID`

### CUSTOMER_CUSTOMER_EDI_CODE

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `FROM_CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `TO_CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `EDI_CODE` | VARCHAR2(18) | NOT NULL |  |
| 4 | `NOTES` | VARCHAR2(256) |  |  |

- **PK:** `FROM_CUSTOMER_ID`, `TO_CUSTOMER_ID`
- **FK:** (`FROM_CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`TO_CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036772`: `FROM_CUSTOMER_ID`, `TO_CUSTOMER_ID`

### CUSTOMER_DUNS_XREF

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_NAME` 🔑 | VARCHAR2(50) | NOT NULL |  |
| 2 | `CUSTOMER_DUNS_NUMBER_STRING` 🔑 | VARCHAR2(18) | NOT NULL |  |

- **PK:** `CUSTOMER_NAME`, `CUSTOMER_DUNS_NUMBER_STRING`
- **Index** unique `PK_CUSTOMER_DUNS_XREF`: `CUSTOMER_NAME`, `CUSTOMER_DUNS_NUMBER_STRING`

### CUSTOMER_EDI

_~12 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_EDI_NAME` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 2 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `EDI_TYPE_ID` | NUMBER(3,0) |  |  |
| 4 | `EDI_VERSION` | VARCHAR2(18) |  |  |
| 5 | `CUSTOMER_EDI_DESC` | VARCHAR2(255) |  |  |

- **PK:** `CUSTOMER_EDI_NAME`, `CUSTOMER_ID`
- **FK:** (`EDI_TYPE_ID`, `EDI_VERSION`) → `EDI_TYPE` (`EDI_TYPE_ID`, `EDI_VERSION`)
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKCUSTOMER_EDI`: `CUSTOMER_EDI_NAME`, `CUSTOMER_ID`

### CUSTOMER_EDI_SCHEDULE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCHEDULE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `CUSTOMER_EDI_NAME` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 4 | `ENABLE` | NUMBER(1,0) |  |  |

- **PK:** `SCHEDULE_ID`, `CUSTOMER_ID`, `CUSTOMER_EDI_NAME`
- **FK:** (`CUSTOMER_EDI_NAME`, `CUSTOMER_ID`) → `CUSTOMER_EDI` (`CUSTOMER_EDI_NAME`, `CUSTOMER_ID`)
- **FK:** (`SCHEDULE_ID`) → `SCHEDULE` (`SCHEDULE_ID`)
- **Index** unique `XPKCUSTOMER_EDI_SCHEDULE`: `SCHEDULE_ID`, `CUSTOMER_ID`, `CUSTOMER_EDI_NAME`

### CUSTOMER_INV_COILS_REPORT_EXT

_~1 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `REPORT_EXT` | VARCHAR2(18) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `PK_CUST_INV_COILS_EXT`: `CUSTOMER_ID`

### CUSTOMER_ORDER

_~48,273 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `ORIG_CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 3 | `ENDUSER_ID` | NUMBER(8,0) |  |  |
| 4 | `ORIG_CUSTOMER_PO` | VARCHAR2(36) | NOT NULL |  |
| 5 | `ENDUSER_PO` | VARCHAR2(36) |  |  |
| 6 | `ORDER_TYPE` | NUMBER(2,0) |  |  |
| 7 | `REFERENCE` | VARCHAR2(18) |  |  |
| 8 | `TERM` | VARCHAR2(18) |  |  |
| 9 | `SCRAP_HANDING_TYPE` | VARCHAR2(18) |  |  |
| 10 | `CREATED_DATE` | DATE |  |  |
| 11 | `ORDER_CONTACT_ID` | NUMBER(8,0) |  |  |
| 12 | `CUST_ORDER_NOTE` | VARCHAR2(255) |  |  |
| 13 | `CUST_ORDER_LINE_NOTE` | NUMBER(4,0) |  |  |
| 14 | `SHEET_HANDLING_TYPE` | NUMBER(2,0) |  |  |
| 15 | `SALES_ORDER` | VARCHAR2(18) |  |  |
| 16 | `TIER1_CUSTOMER_ID` | NUMBER(8,0) |  |  |
| 17 | `CERT_LABEL_CUSTOMER_CODE` | NUMBER(2,0) |  |  |
| 18 | `EDI_CODE` | CHAR(18) |  |  |

- **PK:** `ORDER_ABC_NUM`
- **FK:** (`ORIG_CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`ENDUSER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKORDER`: `ORDER_ABC_NUM`

### CUSTOMER_SH_REPORT_TEMPLATES

_~16 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SHIPTO_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SH_REPORT_TEMPLATE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`, `SHIPTO_ID`, `SH_REPORT_TEMPLATE_ID`
- **FK:** (`SHIPTO_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`SH_REPORT_TEMPLATE_ID`) → `SH_REPORT_TEMPLATES` (`SH_REPORT_TEMPLATE_ID`)
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKCUSTOMER_SH_REPORT_TEMPLATE`: `CUSTOMER_ID`, `SHIPTO_ID`, `SH_REPORT_TEMPLATE_ID`

### CUSTOMER_SPECIAL_PARTS

_~20 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `ENDUSER_PART_NUM` 🔑 | VARCHAR2(22) | NOT NULL |  |
| 3 | `TIER1_CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 4 | `USED_FOR` | VARCHAR2(20) |  |  |

- **PK:** `CUSTOMER_ID`, `ENDUSER_PART_NUM`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`TIER1_CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `PFK_CUSTOMER_SPECIAL_PARTS`: `CUSTOMER_ID`, `ENDUSER_PART_NUM`

### CUSTOMER_SYSTEM

_~34 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `EDI_SHIPPING_CODE` | VARCHAR2(18) |  |  |
| 3 | `ISA_LOG` | NUMBER(8,0) |  |  |
| 4 | `GS856_LOG` | NUMBER(8,0) |  |  |
| 5 | `GS870_LOG` | NUMBER(8,0) |  |  |
| 6 | `REJ_SHEET_SKID_LOG` | NUMBER(8,0) |  |  |
| 7 | `REJ_COIL_LOG` | NUMBER(8,0) |  |  |
| 8 | `VAN_ACCOUNT_NUM` | VARCHAR2(18) |  |  |
| 9 | `COMMUNICATION_CODE` | VARCHAR2(18) |  |  |
| 10 | `GS03` | VARCHAR2(18) |  |  |

- **PK:** `CUSTOMER_ID`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKCUSTOMER_SYSTEM_VARIBLE`: `CUSTOMER_ID`

### CUSTOMER_TYPE

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_TYPE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `CUSTOMER_TYPE_DESCRIPTION` | VARCHAR2(18) |  |  |

- **PK:** `CUSTOMER_TYPE`
- **Index** unique `XPKCUSTOMER_TYPE`: `CUSTOMER_TYPE`

### CUST_SCRAP_TYPE_NEEDED

_~100 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SCRAP_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 3 | `ABC_OR_MILL` | VARCHAR2(16) |  |  |
| 4 | `AUTOPARTS` | NUMBER(1,0) |  |  |
| 5 | `NON_AUTOPARTS` | NUMBER(1,0) |  |  |

- **PK:** `CUSTOMER_ID`, `SCRAP_TYPE_ID`
- **FK:** (`SCRAP_TYPE_ID`) → `SCRAP_TYPE` (`SCRAP_TYPE_ID`)
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036765`: `CUSTOMER_ID`, `SCRAP_TYPE_ID`

### CUST_SH_DEFAULT_TEMPLATE

_~20 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SH_REPORT_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SH_REPORT_TEMPLATE_ID` | NUMBER(3,0) | NOT NULL |  |

- **PK:** `SH_REPORT_TYPE_ID`, `CUSTOMER_ID`
- **FK:** (`SH_REPORT_TYPE_ID`) → `SH_REPORT_TYPE` (`SH_REPORT_TYPE_ID`)
- **FK:** (`SH_REPORT_TEMPLATE_ID`) → `SH_REPORT_TEMPLATES` (`SH_REPORT_TEMPLATE_ID`)
- **Index** unique `XPKCUST_SH_DEFAULT_TEMPLATE`: `SH_REPORT_TYPE_ID`, `CUSTOMER_ID`

### DATA_861

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `BOL` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `COIL_ORG_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 5 | `RECEIVING_BOL_ID` | NUMBER(8,0) |  |  |
| 6 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 7 | `COIL_STATUS` | NUMBER(2,0) |  |  |
| 8 | `DAMAGED_FAULT` | NUMBER(1,0) |  |  |
| 9 | `DAMAGED_CODE` | NUMBER(3,0) |  |  |
| 10 | `TEMPER` | VARCHAR2(8) |  |  |
| 11 | `NET_WEIGHT` | NUMBER(8,0) |  |  |
| 12 | `GROSS_WEIGHT` | NUMBER(8,0) |  |  |
| 13 | `LINEAL_FEED` | NUMBER(7,2) |  |  |
| 14 | `COIL_WIDTH` | NUMBER(9,4) |  |  |
| 15 | `COIL_GAUGE` | NUMBER(5,4) |  |  |
| 16 | `DENSITY` | FLOAT |  |  |
| 17 | `LOT` | VARCHAR2(40) |  |  |
| 18 | `PACK_ID` | VARCHAR2(40) |  |  |
| 19 | `ALLOY` | VARCHAR2(40) |  |  |
| 20 | `PART_NUM` | VARCHAR2(40) |  |  |
| 21 | `SUPPLIER_SALES_NUM` | VARCHAR2(40) |  |  |
| 22 | `CONSUMED_COIL_NUM` | VARCHAR2(32) |  |  |
| 23 | `MATERIAL_NUM` | VARCHAR2(32) |  |  |
| 24 | `CASH_DATE` | VARCHAR2(24) |  |  |
| 25 | `COIL_FROM_CUST_ID` | NUMBER(8,0) |  |  |
| 26 | `CREATED_DATE` | DATE |  |  |
| 27 | `RECEIVED_DATE` | DATE |  |  |
| 28 | `PO` | VARCHAR2(40) |  |  |
| 29 | `PO_LINE_NUM` | NUMBER(4,0) |  |  |
| 30 | `CUSTOMER_DUNS_NUMBER` | VARCHAR2(18) |  |  |
| 31 | `MILL_DUNS_NUMBER` | VARCHAR2(18) |  |  |
| 32 | `PACKAGING_CODE` | VARCHAR2(20) |  |  |
| 33 | `LOADING_QTY` | NUMBER(10,0) |  |  |

- **PK:** `CUSTOMER_ID`, `BOL`, `EDI_FILE_ID`, `COIL_ORG_NUM`
- **Index** unique `XPK_DATA_861`: `CUSTOMER_ID`, `BOL`, `EDI_FILE_ID`, `COIL_ORG_NUM`

### DATA_IN_863

_~11,633 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `WD` | VARCHAR2(20) |  |  |
| 4 | `TH` | VARCHAR2(20) |  |  |
| 5 | `TWO` | VARCHAR2(20) |  |  |
| 6 | `TTY_F_M1` | VARCHAR2(20) |  |  |
| 7 | `TTY_F_M2` | VARCHAR2(20) |  |  |
| 8 | `TTU_F_M1` | VARCHAR2(20) |  |  |
| 9 | `TTU_F_M2` | VARCHAR2(20) |  |  |
| 10 | `TEL_F_M1` | VARCHAR2(20) |  |  |
| 11 | `TEL_F_M2` | VARCHAR2(20) |  |  |
| 12 | `TRL_F_M1` | VARCHAR2(20) |  |  |
| 13 | `TRL_F_M2` | VARCHAR2(20) |  |  |
| 14 | `TNL_F_M1` | VARCHAR2(20) |  |  |
| 15 | `TNL_F_M2` | VARCHAR2(20) |  |  |
| 16 | `TTY_B_M1` | VARCHAR2(20) |  |  |
| 17 | `TTY_B_M2` | VARCHAR2(20) |  |  |
| 18 | `TTU_B_M1` | VARCHAR2(20) |  |  |
| 19 | `TTU_B_M2` | VARCHAR2(20) |  |  |
| 20 | `TEL_B_M1` | VARCHAR2(20) |  |  |
| 21 | `TEL_B_M2` | VARCHAR2(20) |  |  |
| 22 | `TRL_B_M1` | VARCHAR2(20) |  |  |
| 23 | `TRL_B_M2` | VARCHAR2(20) |  |  |
| 24 | `TNL_B_M1` | VARCHAR2(20) |  |  |
| 25 | `TNL_B_M2` | VARCHAR2(20) |  |  |
| 26 | `TTO_F_M1` | VARCHAR2(20) |  |  |
| 27 | `TTO_F_M2` | VARCHAR2(20) |  |  |
| 28 | `TTS_F_M1` | VARCHAR2(20) |  |  |
| 29 | `TTS_F_M2` | VARCHAR2(20) |  |  |
| 30 | `TES_F_M1` | VARCHAR2(20) |  |  |
| 31 | `TES_F_M2` | VARCHAR2(20) |  |  |
| 32 | `TRD_F_M1` | VARCHAR2(20) |  |  |
| 33 | `TRD_F_M2` | VARCHAR2(20) |  |  |
| 34 | `TND_F_M1` | VARCHAR2(20) |  |  |
| 35 | `TND_F_M2` | VARCHAR2(20) |  |  |
| 36 | `TTT_F_M1` | VARCHAR2(20) |  |  |
| 37 | `TTT_F_M2` | VARCHAR2(20) |  |  |
| 38 | `TTL_F_M1` | VARCHAR2(20) |  |  |
| 39 | `TTL_F_M2` | VARCHAR2(20) |  |  |
| 40 | `TET_F_M1` | VARCHAR2(20) |  |  |
| 41 | `TET_F_M2` | VARCHAR2(20) |  |  |
| 42 | `TRT_F_M1` | VARCHAR2(20) |  |  |
| 43 | `TRT_F_M2` | VARCHAR2(20) |  |  |
| 44 | `TNT_F_M1` | VARCHAR2(20) |  |  |
| 45 | `TNT_F_M2` | VARCHAR2(20) |  |  |
| 46 | `SI` | VARCHAR2(20) |  |  |
| 47 | `FE` | VARCHAR2(20) |  |  |
| 48 | `CU` | VARCHAR2(20) |  |  |
| 49 | `MN` | VARCHAR2(20) |  |  |
| 50 | `MG` | VARCHAR2(20) |  |  |
| 51 | `CR` | VARCHAR2(20) |  |  |
| 52 | `NI` | VARCHAR2(20) |  |  |
| 53 | `ZN` | VARCHAR2(20) |  |  |
| 54 | `TI` | VARCHAR2(20) |  |  |
| 55 | `GH` | VARCHAR2(20) |  |  |
| 56 | `AL` | VARCHAR2(20) |  |  |
| 57 | `BB` | VARCHAR2(20) |  |  |
| 58 | `V` | VARCHAR2(20) |  |  |
| 59 | `STATUS` | NUMBER(1,0) |  |  |
| 60 | `WT` | VARCHAR2(20) |  |  |
| 61 | `ITH_F_M1` | VARCHAR2(20) |  |  |
| 62 | `ITH_F_M2` | VARCHAR2(20) |  |  |
| 63 | `ITH_B_M1` | VARCHAR2(20) |  |  |
| 64 | `ITH_B_M2` | VARCHAR2(20) |  |  |
| 65 | `TTS_B_M1` | VARCHAR2(20) |  |  |
| 66 | `TTS_B_M2` | VARCHAR2(20) |  |  |
| 67 | `TTL_B_M1` | VARCHAR2(20) |  |  |
| 68 | `TTL_B_M2` | VARCHAR2(20) |  |  |
| 69 | `TTO_B_M1` | VARCHAR2(20) |  |  |
| 70 | `TTO_B_M2` | VARCHAR2(20) |  |  |
| 71 | `TTT_B_M1` | VARCHAR2(20) |  |  |
| 72 | `TTT_B_M2` | VARCHAR2(20) |  |  |
| 73 | `TND_B_M1` | VARCHAR2(20) |  |  |
| 74 | `TND_B_M2` | VARCHAR2(20) |  |  |
| 75 | `TNT_B_M1` | VARCHAR2(20) |  |  |
| 76 | `TNT_B_M2` | VARCHAR2(20) |  |  |
| 77 | `TMD_B_M1` | VARCHAR2(20) |  |  |
| 78 | `TMD_B_M2` | VARCHAR2(20) |  |  |
| 79 | `TMD_F_M1` | VARCHAR2(20) |  |  |
| 80 | `TMD_F_M2` | VARCHAR2(20) |  |  |
| 81 | `TRD_B_M1` | VARCHAR2(20) |  |  |
| 82 | `TRD_B_M2` | VARCHAR2(20) |  |  |
| 83 | `TRT_B_M1` | VARCHAR2(20) |  |  |
| 84 | `TRT_B_M2` | VARCHAR2(20) |  |  |
| 85 | `TES_B_M1` | VARCHAR2(20) |  |  |
| 86 | `TES_B_M2` | VARCHAR2(20) |  |  |
| 87 | `TET_B_M1` | VARCHAR2(20) |  |  |
| 88 | `TET_B_M2` | VARCHAR2(20) |  |  |
| 89 | `THL_B_M1` | VARCHAR2(20) |  |  |
| 90 | `THL_B_M2` | VARCHAR2(20) |  |  |
| 91 | `THL_F_M1` | VARCHAR2(20) |  |  |
| 92 | `THL_F_M2` | VARCHAR2(20) |  |  |
| 93 | `THD_B_M1` | VARCHAR2(20) |  |  |
| 94 | `THD_B_M2` | VARCHAR2(20) |  |  |
| 95 | `THD_F_M1` | VARCHAR2(20) |  |  |
| 96 | `THD_F_M2` | VARCHAR2(20) |  |  |
| 97 | `THT_B_M1` | VARCHAR2(20) |  |  |
| 98 | `THT_B_M2` | VARCHAR2(20) |  |  |
| 99 | `THT_F_M1` | VARCHAR2(20) |  |  |
| 100 | `THT_F_M2` | VARCHAR2(20) |  |  |
| 101 | `PROC_DATE` | VARCHAR2(20) |  |  |
| 102 | `PROC_TIME` | VARCHAR2(20) |  |  |
| 103 | `PROD_DATE` | VARCHAR2(20) |  |  |
| 104 | `PROD_TIME` | VARCHAR2(20) |  |  |
| 105 | `CASH_DATE` | VARCHAR2(20) |  |  |
| 106 | `LUBE_DATE` | VARCHAR2(20) |  |  |
| 107 | `SHIP_DATE` | VARCHAR2(20) |  |  |
| 108 | `SHIP_TIME` | VARCHAR2(20) |  |  |
| 109 | `B` | VARCHAR2(20) |  |  |
| 110 | `CA` | VARCHAR2(20) |  |  |
| 111 | `CD` | VARCHAR2(20) |  |  |
| 112 | `LB` | VARCHAR2(20) |  |  |
| 113 | `SX` | VARCHAR2(20) |  |  |
| 114 | `PB` | VARCHAR2(20) |  |  |
| 115 | `SB` | VARCHAR2(20) |  |  |
| 116 | `SN` | VARCHAR2(20) |  |  |
| 117 | `ZR` | VARCHAR2(20) |  |  |
| 118 | `X27_B_M1` | VARCHAR2(20) |  |  |
| 119 | `X27_B_M2` | VARCHAR2(20) |  |  |
| 120 | `X27_F_M1` | VARCHAR2(20) |  |  |
| 121 | `X27_F_M2` | VARCHAR2(20) |  |  |
| 122 | `N4T_B_M1` | VARCHAR2(20) |  |  |
| 123 | `N4T_B_M2` | VARCHAR2(20) |  |  |
| 124 | `N4T_F_M1` | VARCHAR2(20) |  |  |
| 125 | `N4T_F_M2` | VARCHAR2(20) |  |  |
| 126 | `N5T_B_M1` | VARCHAR2(20) |  |  |
| 127 | `N5T_B_M2` | VARCHAR2(20) |  |  |
| 128 | `N5T_F_M1` | VARCHAR2(20) |  |  |
| 129 | `N5T_F_M2` | VARCHAR2(20) |  |  |
| 130 | `MDO_B_M1` | VARCHAR2(20) |  |  |
| 131 | `MDO_B_M2` | VARCHAR2(20) |  |  |
| 132 | `MDO_F_M1` | VARCHAR2(20) |  |  |
| 133 | `MDO_F_M2` | VARCHAR2(20) |  |  |
| 134 | `TTE_B_M1` | VARCHAR2(20) |  |  |
| 135 | `TTE_B_M2` | VARCHAR2(20) |  |  |
| 136 | `TTE_F_M1` | VARCHAR2(20) |  |  |
| 137 | `TTE_F_M2` | VARCHAR2(20) |  |  |
| 138 | `TTZ_B_M1` | VARCHAR2(20) |  |  |
| 139 | `TTZ_B_M2` | VARCHAR2(20) |  |  |
| 140 | `TTZ_F_M1` | VARCHAR2(20) |  |  |
| 141 | `TTZ_F_M2` | VARCHAR2(20) |  |  |
| 142 | `ARO_B_M1` | VARCHAR2(20) |  |  |
| 143 | `ARO_B_M2` | VARCHAR2(20) |  |  |
| 144 | `ARO_F_M1` | VARCHAR2(20) |  |  |
| 145 | `ARO_F_M2` | VARCHAR2(20) |  |  |
| 146 | `BKN_B_M1` | VARCHAR2(20) |  |  |
| 147 | `BKN_B_M2` | VARCHAR2(20) |  |  |
| 148 | `BKN_F_M1` | VARCHAR2(20) |  |  |
| 149 | `BKN_F_M2` | VARCHAR2(20) |  |  |
| 150 | `TPS_B_M1` | VARCHAR2(20) |  |  |
| 151 | `TPS_B_M2` | VARCHAR2(20) |  |  |
| 152 | `TPS_F_M1` | VARCHAR2(20) |  |  |
| 153 | `TPS_F_M2` | VARCHAR2(20) |  |  |
| 154 | `ISU_B_M1` | VARCHAR2(20) |  |  |
| 155 | `ISU_B_M2` | VARCHAR2(20) |  |  |
| 156 | `ISU_F_M1` | VARCHAR2(20) |  |  |
| 157 | `ISU_F_M2` | VARCHAR2(20) |  |  |
| 158 | `ITL_B_M1` | VARCHAR2(20) |  |  |
| 159 | `ITL_B_M2` | VARCHAR2(20) |  |  |
| 160 | `ITL_F_M1` | VARCHAR2(20) |  |  |
| 161 | `ITL_F_M2` | VARCHAR2(20) |  |  |
| 162 | `ITD_B_M1` | VARCHAR2(20) |  |  |
| 163 | `ITD_B_M2` | VARCHAR2(20) |  |  |
| 164 | `ITD_F_M1` | VARCHAR2(20) |  |  |
| 165 | `ITD_F_M2` | VARCHAR2(20) |  |  |
| 166 | `ITT_B_M1` | VARCHAR2(20) |  |  |
| 167 | `ITT_B_M2` | VARCHAR2(20) |  |  |
| 168 | `ITT_F_M1` | VARCHAR2(20) |  |  |
| 169 | `ITT_F_M2` | VARCHAR2(20) |  |  |
| 170 | `UPT_B_M1` | VARCHAR2(20) |  |  |
| 171 | `UPT_B_M2` | VARCHAR2(20) |  |  |
| 172 | `UPT_F_M1` | VARCHAR2(20) |  |  |
| 173 | `UPT_F_M2` | VARCHAR2(20) |  |  |
| 174 | `ULT_B_M1` | VARCHAR2(20) |  |  |
| 175 | `ULT_B_M2` | VARCHAR2(20) |  |  |
| 176 | `ULT_F_M1` | VARCHAR2(20) |  |  |
| 177 | `ULT_F_M2` | VARCHAR2(20) |  |  |
| 178 | `YPN_B_M1` | VARCHAR2(20) |  |  |
| 179 | `YPN_B_M2` | VARCHAR2(20) |  |  |
| 180 | `YPN_F_M1` | VARCHAR2(20) |  |  |
| 181 | `YPN_F_M2` | VARCHAR2(20) |  |  |
| 182 | `BI` | VARCHAR2(20) |  |  |
| 183 | `ZB` | VARCHAR2(20) |  |  |
| 184 | `CO` | VARCHAR2(20) |  |  |
| 185 | `IK` | VARCHAR2(20) |  |  |
| 186 | `ZP` | VARCHAR2(20) |  |  |
| 187 | `SS` | VARCHAR2(20) |  |  |
| 188 | `SH` | VARCHAR2(20) |  |  |
| 189 | `ZAS` | VARCHAR2(20) |  |  |
| 190 | `EDI_FILE_NAME` | VARCHAR2(50) |  |  |
| 191 | `CHEMICAL_TEST_DATE` | VARCHAR2(20) |  |  |
| 192 | `DPA_B_M1` | VARCHAR2(20) |  |  |
| 193 | `DPA_B_M2` | VARCHAR2(20) |  |  |
| 194 | `DPA_F_M1` | VARCHAR2(20) |  |  |
| 195 | `DPA_F_M2` | VARCHAR2(20) |  |  |
| 196 | `ZV` | VARCHAR2(20) |  |  |
| 197 | `ZLT` | VARCHAR2(20) |  |  |
| 198 | `ZLB` | VARCHAR2(20) |  |  |
| 199 | `ZLN` | VARCHAR2(20) |  |  |
| 200 | `ZLX` | VARCHAR2(20) |  |  |
| 201 | `YSR_B_M1` | VARCHAR2(20) |  |  |
| 202 | `YSR_B_M2` | VARCHAR2(20) |  |  |
| 203 | `YSR_F_M1` | VARCHAR2(20) |  |  |
| 204 | `YSR_F_M2` | VARCHAR2(20) |  |  |
| 205 | `GRADE` | VARCHAR2(20) |  |  |
| 206 | `LUBE_WEIGHT` | VARCHAR2(20) |  |  |
| 207 | `LUBE_WEIGHT_UOM` | VARCHAR2(20) |  |  |
| 208 | `TTY_B_UOM` | VARCHAR2(10) |  |  |
| 209 | `TTU_B_UOM` | VARCHAR2(10) |  |  |
| 210 | `TEL_B_UOM` | VARCHAR2(10) |  |  |
| 211 | `TRL_B_UOM` | VARCHAR2(10) |  |  |
| 212 | `TNL_B_UOM` | VARCHAR2(10) |  |  |
| 213 | `ITH_B_UOM` | VARCHAR2(10) |  |  |
| 214 | `TTS_B_UOM` | VARCHAR2(10) |  |  |
| 215 | `TTL_B_UOM` | VARCHAR2(10) |  |  |
| 216 | `TTO_B_UOM` | VARCHAR2(10) |  |  |
| 217 | `TTT_B_UOM` | VARCHAR2(10) |  |  |
| 218 | `TND_B_UOM` | VARCHAR2(10) |  |  |
| 219 | `TNT_B_UOM` | VARCHAR2(10) |  |  |
| 220 | `TMD_B_UOM` | VARCHAR2(10) |  |  |
| 221 | `TRD_B_UOM` | VARCHAR2(10) |  |  |
| 222 | `TRT_B_UOM` | VARCHAR2(10) |  |  |
| 223 | `TES_B_UOM` | VARCHAR2(10) |  |  |
| 224 | `TET_B_UOM` | VARCHAR2(10) |  |  |
| 225 | `THL_B_UOM` | VARCHAR2(10) |  |  |
| 226 | `THD_B_UOM` | VARCHAR2(10) |  |  |
| 227 | `THT_B_UOM` | VARCHAR2(10) |  |  |
| 228 | `X27_B_UOM` | VARCHAR2(10) |  |  |
| 229 | `N4T_B_UOM` | VARCHAR2(10) |  |  |
| 230 | `N5T_B_UOM` | VARCHAR2(10) |  |  |
| 231 | `MDO_B_UOM` | VARCHAR2(10) |  |  |
| 232 | `TTE_B_UOM` | VARCHAR2(10) |  |  |
| 233 | `TTZ_B_UOM` | VARCHAR2(10) |  |  |
| 234 | `ARO_B_UOM` | VARCHAR2(10) |  |  |
| 235 | `BKN_B_UOM` | VARCHAR2(10) |  |  |
| 236 | `TPS_B_UOM` | VARCHAR2(10) |  |  |
| 237 | `ISU_B_UOM` | VARCHAR2(10) |  |  |
| 238 | `ITL_B_UOM` | VARCHAR2(10) |  |  |
| 239 | `ITD_B_UOM` | VARCHAR2(10) |  |  |
| 240 | `ITT_B_UOM` | VARCHAR2(10) |  |  |
| 241 | `UPT_B_UOM` | VARCHAR2(10) |  |  |
| 242 | `ULT_B_UOM` | VARCHAR2(10) |  |  |
| 243 | `YPN_B_UOM` | VARCHAR2(10) |  |  |
| 244 | `DPA_B_UOM` | VARCHAR2(10) |  |  |
| 245 | `YSR_B_UOM` | VARCHAR2(10) |  |  |
| 246 | `TTY_F_UOM` | VARCHAR2(10) |  |  |
| 247 | `TTU_F_UOM` | VARCHAR2(10) |  |  |
| 248 | `TEL_F_UOM` | VARCHAR2(10) |  |  |
| 249 | `TRL_F_UOM` | VARCHAR2(10) |  |  |
| 250 | `TNL_F_UOM` | VARCHAR2(10) |  |  |
| 251 | `ITH_F_UOM` | VARCHAR2(10) |  |  |
| 252 | `TTS_F_UOM` | VARCHAR2(10) |  |  |
| 253 | `TTL_F_UOM` | VARCHAR2(10) |  |  |
| 254 | `TTO_F_UOM` | VARCHAR2(10) |  |  |
| 255 | `TTT_F_UOM` | VARCHAR2(10) |  |  |
| 256 | `TND_F_UOM` | VARCHAR2(10) |  |  |
| 257 | `TNT_F_UOM` | VARCHAR2(10) |  |  |
| 258 | `TMD_F_UOM` | VARCHAR2(10) |  |  |
| 259 | `TRD_F_UOM` | VARCHAR2(10) |  |  |
| 260 | `TRT_F_UOM` | VARCHAR2(10) |  |  |
| 261 | `TES_F_UOM` | VARCHAR2(10) |  |  |
| 262 | `TET_F_UOM` | VARCHAR2(10) |  |  |
| 263 | `THL_F_UOM` | VARCHAR2(10) |  |  |
| 264 | `THD_F_UOM` | VARCHAR2(10) |  |  |
| 265 | `THT_F_UOM` | VARCHAR2(10) |  |  |
| 266 | `X27_F_UOM` | VARCHAR2(10) |  |  |
| 267 | `N4T_F_UOM` | VARCHAR2(10) |  |  |
| 268 | `N5T_F_UOM` | VARCHAR2(10) |  |  |
| 269 | `MDO_F_UOM` | VARCHAR2(10) |  |  |
| 270 | `TTE_F_UOM` | VARCHAR2(10) |  |  |
| 271 | `TTZ_F_UOM` | VARCHAR2(10) |  |  |
| 272 | `ARO_F_UOM` | VARCHAR2(10) |  |  |
| 273 | `BKN_F_UOM` | VARCHAR2(10) |  |  |
| 274 | `TPS_F_UOM` | VARCHAR2(10) |  |  |
| 275 | `ISU_F_UOM` | VARCHAR2(10) |  |  |
| 276 | `ITL_F_UOM` | VARCHAR2(10) |  |  |
| 277 | `ITD_F_UOM` | VARCHAR2(10) |  |  |
| 278 | `ITT_F_UOM` | VARCHAR2(10) |  |  |
| 279 | `UPT_F_UOM` | VARCHAR2(10) |  |  |
| 280 | `ULT_F_UOM` | VARCHAR2(10) |  |  |
| 281 | `YPN_F_UOM` | VARCHAR2(10) |  |  |
| 282 | `DPA_F_UOM` | VARCHAR2(10) |  |  |
| 283 | `YSR_F_UOM` | VARCHAR2(10) |  |  |
| 284 | `DATE_TIME_RECEIVED` | VARCHAR2(20) |  |  |
| 285 | `CNTRY_OF_CAST` | VARCHAR2(4) |  |  |
| 286 | `PRIMARY_CNTRY_OF_SMELT` | VARCHAR2(3) |  |  |
| 287 | `SECONDARY_CNTRY_OF_SMELT` | VARCHAR2(3) |  |  |

- **PK:** `EDI_FILE_ID`, `COIL_NUM`
- **Index** unique `SYS_C0036801`: `EDI_FILE_ID`, `COIL_NUM`

### DATA_IN_863_REJECTED

_~33 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `WD` | VARCHAR2(20) |  |  |
| 4 | `TH` | VARCHAR2(20) |  |  |
| 5 | `TWO` | VARCHAR2(20) |  |  |
| 6 | `TTY_F_M1` | VARCHAR2(20) |  |  |
| 7 | `TTY_F_M2` | VARCHAR2(20) |  |  |
| 8 | `TTU_F_M1` | VARCHAR2(20) |  |  |
| 9 | `TTU_F_M2` | VARCHAR2(20) |  |  |
| 10 | `TEL_F_M1` | VARCHAR2(20) |  |  |
| 11 | `TEL_F_M2` | VARCHAR2(20) |  |  |
| 12 | `TRL_F_M1` | VARCHAR2(20) |  |  |
| 13 | `TRL_F_M2` | VARCHAR2(20) |  |  |
| 14 | `TNL_F_M1` | VARCHAR2(20) |  |  |
| 15 | `TNL_F_M2` | VARCHAR2(20) |  |  |
| 16 | `TTY_B_M1` | VARCHAR2(20) |  |  |
| 17 | `TTY_B_M2` | VARCHAR2(20) |  |  |
| 18 | `TTU_B_M1` | VARCHAR2(20) |  |  |
| 19 | `TTU_B_M2` | VARCHAR2(20) |  |  |
| 20 | `TEL_B_M1` | VARCHAR2(20) |  |  |
| 21 | `TEL_B_M2` | VARCHAR2(20) |  |  |
| 22 | `TRL_B_M1` | VARCHAR2(20) |  |  |
| 23 | `TRL_B_M2` | VARCHAR2(20) |  |  |
| 24 | `TNL_B_M1` | VARCHAR2(20) |  |  |
| 25 | `TNL_B_M2` | VARCHAR2(20) |  |  |
| 26 | `TTO_F_M1` | VARCHAR2(20) |  |  |
| 27 | `TTO_F_M2` | VARCHAR2(20) |  |  |
| 28 | `TTS_F_M1` | VARCHAR2(20) |  |  |
| 29 | `TTS_F_M2` | VARCHAR2(20) |  |  |
| 30 | `TES_F_M1` | VARCHAR2(20) |  |  |
| 31 | `TES_F_M2` | VARCHAR2(20) |  |  |
| 32 | `TRD_F_M1` | VARCHAR2(20) |  |  |
| 33 | `TRD_F_M2` | VARCHAR2(20) |  |  |
| 34 | `TND_F_M1` | VARCHAR2(20) |  |  |
| 35 | `TND_F_M2` | VARCHAR2(20) |  |  |
| 36 | `TTT_F_M1` | VARCHAR2(20) |  |  |
| 37 | `TTT_F_M2` | VARCHAR2(20) |  |  |
| 38 | `TTL_F_M1` | VARCHAR2(20) |  |  |
| 39 | `TTL_F_M2` | VARCHAR2(20) |  |  |
| 40 | `TET_F_M1` | VARCHAR2(20) |  |  |
| 41 | `TET_F_M2` | VARCHAR2(20) |  |  |
| 42 | `TRT_F_M1` | VARCHAR2(20) |  |  |
| 43 | `TRT_F_M2` | VARCHAR2(20) |  |  |
| 44 | `TNT_F_M1` | VARCHAR2(20) |  |  |
| 45 | `TNT_F_M2` | VARCHAR2(20) |  |  |
| 46 | `SI` | VARCHAR2(20) |  |  |
| 47 | `FE` | VARCHAR2(20) |  |  |
| 48 | `CU` | VARCHAR2(20) |  |  |
| 49 | `MN` | VARCHAR2(20) |  |  |
| 50 | `MG` | VARCHAR2(20) |  |  |
| 51 | `CR` | VARCHAR2(20) |  |  |
| 52 | `NI` | VARCHAR2(20) |  |  |
| 53 | `ZN` | VARCHAR2(20) |  |  |
| 54 | `TI` | VARCHAR2(20) |  |  |
| 55 | `GH` | VARCHAR2(20) |  |  |
| 56 | `AL` | VARCHAR2(20) |  |  |
| 57 | `BB` | VARCHAR2(20) |  |  |
| 58 | `V` | VARCHAR2(20) |  |  |
| 59 | `STATUS` | NUMBER(1,0) |  |  |
| 60 | `WT` | VARCHAR2(20) |  |  |
| 61 | `ITH_F_M1` | VARCHAR2(20) |  |  |
| 62 | `ITH_F_M2` | VARCHAR2(20) |  |  |
| 63 | `ITH_B_M1` | VARCHAR2(20) |  |  |
| 64 | `ITH_B_M2` | VARCHAR2(20) |  |  |
| 65 | `TTS_B_M1` | VARCHAR2(20) |  |  |
| 66 | `TTS_B_M2` | VARCHAR2(20) |  |  |
| 67 | `TTL_B_M1` | VARCHAR2(20) |  |  |
| 68 | `TTL_B_M2` | VARCHAR2(20) |  |  |
| 69 | `TTO_B_M1` | VARCHAR2(20) |  |  |
| 70 | `TTO_B_M2` | VARCHAR2(20) |  |  |
| 71 | `TTT_B_M1` | VARCHAR2(20) |  |  |
| 72 | `TTT_B_M2` | VARCHAR2(20) |  |  |
| 73 | `TND_B_M1` | VARCHAR2(20) |  |  |
| 74 | `TND_B_M2` | VARCHAR2(20) |  |  |
| 75 | `TNT_B_M1` | VARCHAR2(20) |  |  |
| 76 | `TNT_B_M2` | VARCHAR2(20) |  |  |
| 77 | `TMD_B_M1` | VARCHAR2(20) |  |  |
| 78 | `TMD_B_M2` | VARCHAR2(20) |  |  |
| 79 | `TMD_F_M1` | VARCHAR2(20) |  |  |
| 80 | `TMD_F_M2` | VARCHAR2(20) |  |  |
| 81 | `TRD_B_M1` | VARCHAR2(20) |  |  |
| 82 | `TRD_B_M2` | VARCHAR2(20) |  |  |
| 83 | `TRT_B_M1` | VARCHAR2(20) |  |  |
| 84 | `TRT_B_M2` | VARCHAR2(20) |  |  |
| 85 | `TES_B_M1` | VARCHAR2(20) |  |  |
| 86 | `TES_B_M2` | VARCHAR2(20) |  |  |
| 87 | `TET_B_M1` | VARCHAR2(20) |  |  |
| 88 | `TET_B_M2` | VARCHAR2(20) |  |  |
| 89 | `THL_B_M1` | VARCHAR2(20) |  |  |
| 90 | `THL_B_M2` | VARCHAR2(20) |  |  |
| 91 | `THL_F_M1` | VARCHAR2(20) |  |  |
| 92 | `THL_F_M2` | VARCHAR2(20) |  |  |
| 93 | `THD_B_M1` | VARCHAR2(20) |  |  |
| 94 | `THD_B_M2` | VARCHAR2(20) |  |  |
| 95 | `THD_F_M1` | VARCHAR2(20) |  |  |
| 96 | `THD_F_M2` | VARCHAR2(20) |  |  |
| 97 | `THT_B_M1` | VARCHAR2(20) |  |  |
| 98 | `THT_B_M2` | VARCHAR2(20) |  |  |
| 99 | `THT_F_M1` | VARCHAR2(20) |  |  |
| 100 | `THT_F_M2` | VARCHAR2(20) |  |  |
| 101 | `PROC_DATE` | VARCHAR2(20) |  |  |
| 102 | `PROC_TIME` | VARCHAR2(20) |  |  |
| 103 | `PROD_DATE` | VARCHAR2(20) |  |  |
| 104 | `PROD_TIME` | VARCHAR2(20) |  |  |
| 105 | `CASH_DATE` | VARCHAR2(20) |  |  |
| 106 | `LUBE_DATE` | VARCHAR2(20) |  |  |
| 107 | `SHIP_DATE` | VARCHAR2(20) |  |  |
| 108 | `SHIP_TIME` | VARCHAR2(20) |  |  |
| 109 | `B` | VARCHAR2(20) |  |  |
| 110 | `CA` | VARCHAR2(20) |  |  |
| 111 | `CD` | VARCHAR2(20) |  |  |
| 112 | `LB` | VARCHAR2(20) |  |  |
| 113 | `SX` | VARCHAR2(20) |  |  |
| 114 | `PB` | VARCHAR2(20) |  |  |
| 115 | `SB` | VARCHAR2(20) |  |  |
| 116 | `SN` | VARCHAR2(20) |  |  |
| 117 | `ZR` | VARCHAR2(20) |  |  |
| 118 | `X27_B_M1` | VARCHAR2(20) |  |  |
| 119 | `X27_B_M2` | VARCHAR2(20) |  |  |
| 120 | `X27_F_M1` | VARCHAR2(20) |  |  |
| 121 | `X27_F_M2` | VARCHAR2(20) |  |  |
| 122 | `N4T_B_M1` | VARCHAR2(20) |  |  |
| 123 | `N4T_B_M2` | VARCHAR2(20) |  |  |
| 124 | `N4T_F_M1` | VARCHAR2(20) |  |  |
| 125 | `N4T_F_M2` | VARCHAR2(20) |  |  |
| 126 | `N5T_B_M1` | VARCHAR2(20) |  |  |
| 127 | `N5T_B_M2` | VARCHAR2(20) |  |  |
| 128 | `N5T_F_M1` | VARCHAR2(20) |  |  |
| 129 | `N5T_F_M2` | VARCHAR2(20) |  |  |
| 130 | `MDO_B_M1` | VARCHAR2(20) |  |  |
| 131 | `MDO_B_M2` | VARCHAR2(20) |  |  |
| 132 | `MDO_F_M1` | VARCHAR2(20) |  |  |
| 133 | `MDO_F_M2` | VARCHAR2(20) |  |  |
| 134 | `TTE_B_M1` | VARCHAR2(20) |  |  |
| 135 | `TTE_B_M2` | VARCHAR2(20) |  |  |
| 136 | `TTE_F_M1` | VARCHAR2(20) |  |  |
| 137 | `TTE_F_M2` | VARCHAR2(20) |  |  |
| 138 | `TTZ_B_M1` | VARCHAR2(20) |  |  |
| 139 | `TTZ_B_M2` | VARCHAR2(20) |  |  |
| 140 | `TTZ_F_M1` | VARCHAR2(20) |  |  |
| 141 | `TTZ_F_M2` | VARCHAR2(20) |  |  |
| 142 | `ARO_B_M1` | VARCHAR2(20) |  |  |
| 143 | `ARO_B_M2` | VARCHAR2(20) |  |  |
| 144 | `ARO_F_M1` | VARCHAR2(20) |  |  |
| 145 | `ARO_F_M2` | VARCHAR2(20) |  |  |
| 146 | `BKN_B_M1` | VARCHAR2(20) |  |  |
| 147 | `BKN_B_M2` | VARCHAR2(20) |  |  |
| 148 | `BKN_F_M1` | VARCHAR2(20) |  |  |
| 149 | `BKN_F_M2` | VARCHAR2(20) |  |  |
| 150 | `TPS_B_M1` | VARCHAR2(20) |  |  |
| 151 | `TPS_B_M2` | VARCHAR2(20) |  |  |
| 152 | `TPS_F_M1` | VARCHAR2(20) |  |  |
| 153 | `TPS_F_M2` | VARCHAR2(20) |  |  |
| 154 | `ISU_B_M1` | VARCHAR2(20) |  |  |
| 155 | `ISU_B_M2` | VARCHAR2(20) |  |  |
| 156 | `ISU_F_M1` | VARCHAR2(20) |  |  |
| 157 | `ISU_F_M2` | VARCHAR2(20) |  |  |
| 158 | `ITL_B_M1` | VARCHAR2(20) |  |  |
| 159 | `ITL_B_M2` | VARCHAR2(20) |  |  |
| 160 | `ITL_F_M1` | VARCHAR2(20) |  |  |
| 161 | `ITL_F_M2` | VARCHAR2(20) |  |  |
| 162 | `ITD_B_M1` | VARCHAR2(20) |  |  |
| 163 | `ITD_B_M2` | VARCHAR2(20) |  |  |
| 164 | `ITD_F_M1` | VARCHAR2(20) |  |  |
| 165 | `ITD_F_M2` | VARCHAR2(20) |  |  |
| 166 | `ITT_B_M1` | VARCHAR2(20) |  |  |
| 167 | `ITT_B_M2` | VARCHAR2(20) |  |  |
| 168 | `ITT_F_M1` | VARCHAR2(20) |  |  |
| 169 | `ITT_F_M2` | VARCHAR2(20) |  |  |
| 170 | `UPT_B_M1` | VARCHAR2(20) |  |  |
| 171 | `UPT_B_M2` | VARCHAR2(20) |  |  |
| 172 | `UPT_F_M1` | VARCHAR2(20) |  |  |
| 173 | `UPT_F_M2` | VARCHAR2(20) |  |  |
| 174 | `ULT_B_M1` | VARCHAR2(20) |  |  |
| 175 | `ULT_B_M2` | VARCHAR2(20) |  |  |
| 176 | `ULT_F_M1` | VARCHAR2(20) |  |  |
| 177 | `ULT_F_M2` | VARCHAR2(20) |  |  |
| 178 | `YPN_B_M1` | VARCHAR2(20) |  |  |
| 179 | `YPN_B_M2` | VARCHAR2(20) |  |  |
| 180 | `YPN_F_M1` | VARCHAR2(20) |  |  |
| 181 | `YPN_F_M2` | VARCHAR2(20) |  |  |
| 182 | `BI` | VARCHAR2(20) |  |  |
| 183 | `ZB` | VARCHAR2(20) |  |  |
| 184 | `CO` | VARCHAR2(20) |  |  |
| 185 | `IK` | VARCHAR2(20) |  |  |
| 186 | `ZP` | VARCHAR2(20) |  |  |
| 187 | `SS` | VARCHAR2(20) |  |  |
| 188 | `SH` | VARCHAR2(20) |  |  |
| 189 | `ZAS` | VARCHAR2(20) |  |  |
| 190 | `EDI_FILE_NAME` | VARCHAR2(50) |  |  |
| 191 | `CHEMICAL_TEST_DATE` | VARCHAR2(20) |  |  |
| 192 | `DPA_B_M1` | VARCHAR2(20) |  |  |
| 193 | `DPA_B_M2` | VARCHAR2(20) |  |  |
| 194 | `DPA_F_M1` | VARCHAR2(20) |  |  |
| 195 | `DPA_F_M2` | VARCHAR2(20) |  |  |
| 196 | `ZV` | VARCHAR2(20) |  |  |
| 197 | `ZLT` | VARCHAR2(20) |  |  |
| 198 | `ZLB` | VARCHAR2(20) |  |  |
| 199 | `ZLN` | VARCHAR2(20) |  |  |
| 200 | `ZLX` | VARCHAR2(20) |  |  |
| 201 | `YSR_B_M1` | VARCHAR2(20) |  |  |
| 202 | `YSR_B_M2` | VARCHAR2(20) |  |  |
| 203 | `YSR_F_M1` | VARCHAR2(20) |  |  |
| 204 | `YSR_F_M2` | VARCHAR2(20) |  |  |
| 205 | `GRADE` | VARCHAR2(20) |  |  |
| 206 | `LUBE_WEIGHT` | VARCHAR2(20) |  |  |
| 207 | `LUBE_WEIGHT_UOM` | VARCHAR2(20) |  |  |
| 208 | `TTY_B_UOM` | VARCHAR2(10) |  |  |
| 209 | `TTU_B_UOM` | VARCHAR2(10) |  |  |
| 210 | `TEL_B_UOM` | VARCHAR2(10) |  |  |
| 211 | `TRL_B_UOM` | VARCHAR2(10) |  |  |
| 212 | `TNL_B_UOM` | VARCHAR2(10) |  |  |
| 213 | `ITH_B_UOM` | VARCHAR2(10) |  |  |
| 214 | `TTS_B_UOM` | VARCHAR2(10) |  |  |
| 215 | `TTL_B_UOM` | VARCHAR2(10) |  |  |
| 216 | `TTO_B_UOM` | VARCHAR2(10) |  |  |
| 217 | `TTT_B_UOM` | VARCHAR2(10) |  |  |
| 218 | `TND_B_UOM` | VARCHAR2(10) |  |  |
| 219 | `TNT_B_UOM` | VARCHAR2(10) |  |  |
| 220 | `TMD_B_UOM` | VARCHAR2(10) |  |  |
| 221 | `TRD_B_UOM` | VARCHAR2(10) |  |  |
| 222 | `TRT_B_UOM` | VARCHAR2(10) |  |  |
| 223 | `TES_B_UOM` | VARCHAR2(10) |  |  |
| 224 | `TET_B_UOM` | VARCHAR2(10) |  |  |
| 225 | `THL_B_UOM` | VARCHAR2(10) |  |  |
| 226 | `THD_B_UOM` | VARCHAR2(10) |  |  |
| 227 | `THT_B_UOM` | VARCHAR2(10) |  |  |
| 228 | `X27_B_UOM` | VARCHAR2(10) |  |  |
| 229 | `N4T_B_UOM` | VARCHAR2(10) |  |  |
| 230 | `N5T_B_UOM` | VARCHAR2(10) |  |  |
| 231 | `MDO_B_UOM` | VARCHAR2(10) |  |  |
| 232 | `TTE_B_UOM` | VARCHAR2(10) |  |  |
| 233 | `TTZ_B_UOM` | VARCHAR2(10) |  |  |
| 234 | `ARO_B_UOM` | VARCHAR2(10) |  |  |
| 235 | `BKN_B_UOM` | VARCHAR2(10) |  |  |
| 236 | `TPS_B_UOM` | VARCHAR2(10) |  |  |
| 237 | `ISU_B_UOM` | VARCHAR2(10) |  |  |
| 238 | `ITL_B_UOM` | VARCHAR2(10) |  |  |
| 239 | `ITD_B_UOM` | VARCHAR2(10) |  |  |
| 240 | `ITT_B_UOM` | VARCHAR2(10) |  |  |
| 241 | `UPT_B_UOM` | VARCHAR2(10) |  |  |
| 242 | `ULT_B_UOM` | VARCHAR2(10) |  |  |
| 243 | `YPN_B_UOM` | VARCHAR2(10) |  |  |
| 244 | `DPA_B_UOM` | VARCHAR2(10) |  |  |
| 245 | `YSR_B_UOM` | VARCHAR2(10) |  |  |
| 246 | `TTY_F_UOM` | VARCHAR2(10) |  |  |
| 247 | `TTU_F_UOM` | VARCHAR2(10) |  |  |
| 248 | `TEL_F_UOM` | VARCHAR2(10) |  |  |
| 249 | `TRL_F_UOM` | VARCHAR2(10) |  |  |
| 250 | `TNL_F_UOM` | VARCHAR2(10) |  |  |
| 251 | `ITH_F_UOM` | VARCHAR2(10) |  |  |
| 252 | `TTS_F_UOM` | VARCHAR2(10) |  |  |
| 253 | `TTL_F_UOM` | VARCHAR2(10) |  |  |
| 254 | `TTO_F_UOM` | VARCHAR2(10) |  |  |
| 255 | `TTT_F_UOM` | VARCHAR2(10) |  |  |
| 256 | `TND_F_UOM` | VARCHAR2(10) |  |  |
| 257 | `TNT_F_UOM` | VARCHAR2(10) |  |  |
| 258 | `TMD_F_UOM` | VARCHAR2(10) |  |  |
| 259 | `TRD_F_UOM` | VARCHAR2(10) |  |  |
| 260 | `TRT_F_UOM` | VARCHAR2(10) |  |  |
| 261 | `TES_F_UOM` | VARCHAR2(10) |  |  |
| 262 | `TET_F_UOM` | VARCHAR2(10) |  |  |
| 263 | `THL_F_UOM` | VARCHAR2(10) |  |  |
| 264 | `THD_F_UOM` | VARCHAR2(10) |  |  |
| 265 | `THT_F_UOM` | VARCHAR2(10) |  |  |
| 266 | `X27_F_UOM` | VARCHAR2(10) |  |  |
| 267 | `N4T_F_UOM` | VARCHAR2(10) |  |  |
| 268 | `N5T_F_UOM` | VARCHAR2(10) |  |  |
| 269 | `MDO_F_UOM` | VARCHAR2(10) |  |  |
| 270 | `TTE_F_UOM` | VARCHAR2(10) |  |  |
| 271 | `TTZ_F_UOM` | VARCHAR2(10) |  |  |
| 272 | `ARO_F_UOM` | VARCHAR2(10) |  |  |
| 273 | `BKN_F_UOM` | VARCHAR2(10) |  |  |
| 274 | `TPS_F_UOM` | VARCHAR2(10) |  |  |
| 275 | `ISU_F_UOM` | VARCHAR2(10) |  |  |
| 276 | `ITL_F_UOM` | VARCHAR2(10) |  |  |
| 277 | `ITD_F_UOM` | VARCHAR2(10) |  |  |
| 278 | `ITT_F_UOM` | VARCHAR2(10) |  |  |
| 279 | `UPT_F_UOM` | VARCHAR2(10) |  |  |
| 280 | `ULT_F_UOM` | VARCHAR2(10) |  |  |
| 281 | `YPN_F_UOM` | VARCHAR2(10) |  |  |
| 282 | `DPA_F_UOM` | VARCHAR2(10) |  |  |
| 283 | `YSR_F_UOM` | VARCHAR2(10) |  |  |
| 284 | `DATE_TIME_RECEIVED` | VARCHAR2(20) |  |  |
| 285 | `CNTRY_OF_CAST` | VARCHAR2(4) |  |  |
| 286 | `PRIMARY_CNTRY_OF_SMELT` | VARCHAR2(3) |  |  |
| 287 | `SECONDARY_CNTRY_OF_SMELT` | VARCHAR2(3) |  |  |

- **PK:** `EDI_FILE_ID`, `COIL_NUM`
- **Index** unique `SYS_C0036839`: `EDI_FILE_ID`, `COIL_NUM`

### DESADV_TAG

_~57 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `item` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `element` | VARCHAR2(255) |  |  |

- **PK:** `item`
- **Index** unique `DESADV_TAGPrimaryKey1`: `item`

### DIE

_~134 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DIE_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `DIE_NAME` | VARCHAR2(32) |  |  |
| 4 | `STATUS` | NUMBER(2,0) |  |  |
| 5 | `TOOL_NUM` | VARCHAR2(32) |  |  |
| 6 | `PART_NAME` | VARCHAR2(64) |  |  |
| 7 | `GROSS_WEIGHT` | NUMBER(8,0) |  |  |
| 8 | `LOCATION` | VARCHAR2(32) |  |  |
| 9 | `DESCRIPTION` | VARCHAR2(64) |  |  |
| 10 | `ENGINEERED_SCRAP_Y_N` | CHAR(1) |  |  |
| 11 | `NUM_OF_PARTS_PER_HIT` | NUMBER(1,0) |  |  |
| 12 | `ANGLE_CHANGE_MINUTES` | NUMBER(4,0) |  |  |
| 13 | `AVERAGE_DIE_CHANGE_MINUTES` | NUMBER(4,0) |  |  |

- **PK:** `DIE_ID`
- **Index** unique `SYS_C0036536`: `DIE_ID`

### DIMPLING

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DIMPLING_CODE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `DIMPLING_DESC` | VARCHAR2(100) | NOT NULL |  |
| 3 | `DIMPLING_NOTE` | VARCHAR2(100) |  |  |

- **PK:** `DIMPLING_CODE`
- **Index** unique `PK_DIMPLING`: `DIMPLING_CODE`

### DT_CAUSE

_~43 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NOTE` | VARCHAR2(50) |  |  |
| 2 | `CAUSE_NAME` | VARCHAR2(30) | NOT NULL |  |
| 3 | `ID` 🔑 | NUMBER(5,0) | NOT NULL |  |

- **PK:** `ID`
- **Index** unique `DT_CAUSE_X`: `ID`

### DT_INSTANCE

_~345,326 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `INSTANCE_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 3 | `LINE_NUM` | NUMBER(2,0) |  |  |
| 4 | `STARTING_TIME` | DATE |  |  |
| 5 | `ENDING_TIME` | DATE |  |  |
| 6 | `NOTE` | VARCHAR2(255) |  |  |
| 7 | `SHIFT_NUM` | NUMBER(8,0) |  |  |

- **PK:** `INSTANCE_NUM`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **FK:** (`SHIFT_NUM`) → `SHIFT` (`SHIFT_NUM`)
- **Index** unique `DT_INSTANCE_X`: `INSTANCE_NUM`

### DT_INSTANCE_DETAIL

_~389,347 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `INSTANCE_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `INSTANCE_ITEM` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 3 | `ID` | NUMBER(4,0) |  |  |
| 4 | `DURATION` | NUMBER(8,0) |  |  |
| 5 | `NOTE` | VARCHAR2(255) |  |  |

- **PK:** `INSTANCE_NUM`, `INSTANCE_ITEM`
- **FK:** (`ID`) → `DT_CAUSE` (`ID`)
- **FK:** (`INSTANCE_NUM`) → `DT_INSTANCE` (`INSTANCE_NUM`)
- **Index** unique `DT_INSTANCE_DETAIL_X`: `INSTANCE_NUM`, `INSTANCE_ITEM`

### DT_SUMMARY

_~136,514 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHIFT_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 4 | `COUNT` | NUMBER(4,0) |  |  |
| 5 | `DURATION` | NUMBER(8,0) |  |  |
| 6 | `NOTE` | VARCHAR2(1024) |  |  |

- **PK:** `SHIFT_NUM`, `AB_JOB_NUM`, `ID`
- **FK:** (`ID`) → `DT_CAUSE` (`ID`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `SYS_C0036540`: `SHIFT_NUM`, `AB_JOB_NUM`, `ID`

### EDGE_TRIM_TOLEARANCE

_~1 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LOWER_LIMIT` | NUMBER(5,2) | NOT NULL |  |
| 2 | `UPPER_LIMIT` | NUMBER(5,2) | NOT NULL |  |


### EDI_870_COIL_STATUS

_~861 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_STATUS_CHANGE_DATE` 🔑 | DATE | NOT NULL |  |
| 3 | `COIL_PRE_STATUS` | NUMBER(8,0) |  |  |
| 4 | `COIL_CUR_STATUS` | NUMBER(8,0) |  |  |
| 5 | `EDI_870_DATE` | DATE |  |  |
| 6 | `TRANSACTION_NUM` | NUMBER(8,0) |  |  |
| 7 | `COIL_PRE_WT` | NUMBER(8,0) |  |  |
| 8 | `COIL_CUR_WT` | NUMBER(8,0) |  |  |

- **PK:** `COIL_ABC_NUM`, `COIL_STATUS_CHANGE_DATE`
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **Index** unique `SYS_C0036541`: `COIL_ABC_NUM`, `COIL_STATUS_CHANGE_DATE`

### EDI_DESADV_GM_LOG

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `packing_list` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `line_no` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `tag` | CHAR(255) |  |  |

- **PK:** `packing_list`, `line_no`
- **FK:** (`packing_list`) → `SHIPMENT` (`PACKING_LIST`)
- **Index** `EDI_DESADV_LOGIndex1`: `packing_list`
- **Index** unique `EDI_DESADV_LOGPrimaryKey1`: `packing_list`, `line_no`

### EDI_FA

_~27,805 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `GS_NUM` 🔑 | NUMBER(9,0) | NOT NULL |  |
| 2 | `DUNS_NUM` | VARCHAR2(18) |  |  |
| 3 | `SEND_TIME` | DATE |  |  |
| 4 | `EDI_FILE_NAME` | VARCHAR2(40) |  |  |
| 5 | `FA_EDI_FILE_NAME` | VARCHAR2(40) |  |  |
| 6 | `FA_RECEIVE_TIME` | DATE |  |  |
| 7 | `FA_STATUS` | NUMBER(1,0) |  |  |

- **PK:** `GS_NUM`
- **Index** unique `SYS_C0036543`: `GS_NUM`

### EDI_FILE_863

_~20,805 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_863_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `FILE_ID` | NUMBER(8,0) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `EDI_FILE` | LONG | NOT NULL |  |
| 5 | `COIL_ORG_NUM` | VARCHAR2(32) | NOT NULL |  |
| 6 | `CREATED_DATE` | DATE | NOT NULL |  |
| 7 | `SEND_STATUS` | NUMBER(1,0) |  |  |

- **PK:** `EDI_863_ID`
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`FILE_ID`) → `IMPORTED_FILE_863` (`FILE_ID`)
- **Index** unique `EDI_FILE_863_PK`: `EDI_863_ID`

### EDI_INBOUND_856

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_INBOUND_LOG` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `EDI_ISA_LOG` | NUMBER(8,0) |  |  |
| 3 | `EDI_GS_LOG` | NUMBER(8,0) |  |  |
| 4 | `EDI_ST_LOG` | NUMBER(8,0) |  |  |
| 5 | `EDI_BILL_OF_LADING` | NUMBER(8,0) |  |  |
| 6 | `EDI_DUNS_NUM` | VARCHAR2(18) |  |  |
| 7 | `EDI_ORG_NUM` | VARCHAR2(18) |  |  |
| 8 | `EDI_ICRA` | VARCHAR2(18) |  |  |
| 9 | `EDI_COIL_MID_NUM` | VARCHAR2(18) |  |  |
| 10 | `EDI_COIL_ALLOY` | VARCHAR2(8) |  |  |
| 11 | `EDI_COIL_TEMPER` | VARCHAR2(8) |  |  |
| 12 | `EDI_LOT_NUM` | VARCHAR2(18) |  |  |
| 13 | `EDI_COIL_GAUGE` | NUMBER(5,4) |  |  |
| 14 | `EDI_COIL_WIDTH` | NUMBER(7,2) |  |  |
| 15 | `DATE_SHIPPED` | DATE |  |  |
| 16 | `DATE_RECEIVED` | DATE |  |  |
| 17 | `NET_WT` | NUMBER(8,0) |  |  |
| 18 | `EDI_PC` | NUMBER(2,0) |  |  |
| 19 | `EDI_COIL_NOTES` | VARCHAR2(255) |  |  |
| 20 | `EDI_COIL_LINE_NUM` | NUMBER(2,0) |  |  |

- **PK:** `EDI_INBOUND_LOG`
- **Index** unique `SYS_C0036545`: `EDI_INBOUND_LOG`

### EDI_LOG

_~944 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_LOG_TIMESTAMP` 🔑 | DATE | NOT NULL |  |
| 2 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `CUSTOMER_EDI_NAME` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 4 | `EDI_LOG_CONTENTS` | VARCHAR2(255) |  |  |
| 5 | `EDI_LOG_FLAG` | NUMBER(1,0) |  |  |
| 6 | `EDI_FILE_ID` | NUMBER(8,0) |  |  |
| 7 | `ISA_SEQ` | NUMBER(8,0) |  |  |
| 8 | `GS_SEQ` | NUMBER(8,0) |  |  |
| 9 | `EDI_TEXT` | VARCHAR2(2000) |  |  |

- **PK:** `EDI_LOG_TIMESTAMP`, `CUSTOMER_ID`, `CUSTOMER_EDI_NAME`
- **FK:** (`CUSTOMER_EDI_NAME`, `CUSTOMER_ID`) → `CUSTOMER_EDI` (`CUSTOMER_EDI_NAME`, `CUSTOMER_ID`)
- **Index** unique `XPKEDI_LOG`: `EDI_LOG_TIMESTAMP`, `CUSTOMER_ID`, `CUSTOMER_EDI_NAME`

### EDI_LOG_FILE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `timestamp` 🔑 | DATE | NOT NULL |  |
| 2 | `content` | LONG RAW |  |  |

- **PK:** `timestamp`
- **Index** unique `EDI_LOG_FILEPrimaryKey1`: `timestamp`

### EDI_OUT_FILE

_~838 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_OUT_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_EDI_NAME` | VARCHAR2(18) |  |  |
| 3 | `CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 4 | `EDI_CREATED_DATE` | DATE |  |  |
| 5 | `EDI_FILE_NAME` | VARCHAR2(64) |  |  |
| 6 | `EDI_FILE_PATH` | VARCHAR2(64) |  |  |
| 7 | `EDI_FILE_ARCHIVE_PATH` | VARCHAR2(64) |  |  |

- **PK:** `EDI_OUT_ID`
- **FK:** (`CUSTOMER_EDI_NAME`, `CUSTOMER_ID`) → `CUSTOMER_EDI` (`CUSTOMER_EDI_NAME`, `CUSTOMER_ID`)
- **Index** unique `XPKEDI_OUT_ID`: `EDI_OUT_ID`

### EDI_TYPE

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `EDI_VERSION` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 3 | `EDI_TYPE_DESCRIPTION` | VARCHAR2(255) |  |  |

- **PK:** `EDI_TYPE_ID`, `EDI_VERSION`
- **Index** unique `XPKEDI_TYPE`: `EDI_TYPE_ID`, `EDI_VERSION`

### EMPLOYEE

_~6 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LAST_NAME` | VARCHAR2(20) |  |  |
| 3 | `FIRST_NAME` | VARCHAR2(20) |  |  |
| 4 | `BADGE_NUM` | VARCHAR2(20) |  |  |
| 5 | `PASSWORD` | VARCHAR2(20) |  |  |

- **PK:** `EMPLOYEE_ID`
- **Index** unique `SYS_C0036550`: `EMPLOYEE_ID`

### EMPLOYEES

_~9 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `FIRST_NAME` | VARCHAR2(32) | NOT NULL |  |
| 3 | `LAST_NAME` | VARCHAR2(32) | NOT NULL |  |
| 4 | `POINITIALS` | VARCHAR2(16) |  |  |
| 5 | `TITLECRAFT` | VARCHAR2(32) |  |  |
| 6 | `SITE` | VARCHAR2(32) |  |  |
| 7 | `GROUPDEPARTMENT` | VARCHAR2(32) |  |  |
| 8 | `EMAIL` | VARCHAR2(32) |  |  |
| 9 | `EXTENSION` | VARCHAR2(32) |  |  |
| 10 | `WORKPHONE` | VARCHAR2(32) |  |  |

- **PK:** `EMPLOYEE_ID`
- **Index** unique `SYS_C0036551`: `EMPLOYEE_ID`

### EQUIPMENT_MODE

_~1 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EQU_MODE` 🔑 | VARCHAR2(8) | NOT NULL |  |
| 2 | `EQU_MODE_DESC` | VARCHAR2(50) |  |  |

- **PK:** `EQU_MODE`
- **Index** unique `SYS_C0036552`: `EQU_MODE`

### EQUIPMENT_TYPE

_~12 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EQUIPMENT_TYPE_CODE` 🔑 | VARCHAR2(4) | NOT NULL |  |
| 2 | `EQUIPMENT_TYPE_DESC` | VARCHAR2(20) | NOT NULL |  |
| 3 | `EQUIPMENT_TYPE_NOTE` | VARCHAR2(300) |  |  |

- **PK:** `EQUIPMENT_TYPE_CODE`
- **Index** unique `PK_EQUIPMENT_TYPE`: `EQUIPMENT_TYPE_CODE`

### EQUIPMENT_TYPE_CUSTOMER

_~56 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `EQUIPMENT_TYPE_CODE` 🔑 | VARCHAR2(4) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`, `EQUIPMENT_TYPE_CODE`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`EQUIPMENT_TYPE_CODE`) → `EQUIPMENT_TYPE` (`EQUIPMENT_TYPE_CODE`)
- **Index** unique `PK_EQUIPMENT_TYPE_CUSTOMER`: `CUSTOMER_ID`, `EQUIPMENT_TYPE_CODE`

### ERROR_EVT

_~754 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ERROR_EVT_ID` 🔑 | NUMBER(9,0) | NOT NULL |  |
| 2 | `EVT_TIME` | DATE | NOT NULL |  |
| 3 | `ERROR_TYPE_ID` | NUMBER(3,0) | NOT NULL |  |
| 4 | `ERROR_USER` | VARCHAR2(12) | NOT NULL |  |
| 5 | `ERROR_COMMENT` | VARCHAR2(255) |  |  |
| 6 | `LINE_ID` | NUMBER(5,0) |  |  |
| 7 | `SHIFT_ID` | NUMBER(8,0) |  |  |
| 8 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 9 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 10 | `SHEET_SKID_NUM` | NUMBER(8,0) |  |  |
| 11 | `SCRAP_SKID_NUM` | NUMBER(8,0) |  |  |
| 12 | `DT_INSTANCE_NUM` | NUMBER(8,0) |  |  |
| 13 | `OPC_ITEM` | VARCHAR2(50) |  |  |
| 14 | `TITLE` | VARCHAR2(50) |  |  |
| 15 | `MESSAGE` | VARCHAR2(255) |  |  |
| 16 | `SCRIPT` | VARCHAR2(255) |  |  |
| 17 | `LINE_IN_SCRIPT` | NUMBER(5,0) |  |  |
| 18 | `DB_ERROR_CODE` | NUMBER(8,0) |  |  |
| 19 | `DB_ERROR_TEXT` | VARCHAR2(255) |  |  |

- **PK:** `ERROR_EVT_ID`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`DT_INSTANCE_NUM`) → `DT_INSTANCE` (`INSTANCE_NUM`)
- **FK:** (`ERROR_TYPE_ID`) → `ERROR_TYPE` (`ERROR_TYPE_ID`)
- **FK:** (`LINE_ID`) → `LINE` (`LINE_NUM`)
- **FK:** (`SCRAP_SKID_NUM`) → `SCRAP_SKID` (`SCRAP_SKID_NUM`)
- **FK:** (`SHEET_SKID_NUM`) → `SHEET_SKID` (`SHEET_SKID_NUM`)
- **FK:** (`SHIFT_ID`) → `SHIFT` (`SHIFT_NUM`)
- **Index** unique `PK_ERROR_EVT_ERROR_EVT_ID`: `ERROR_EVT_ID`

### ERROR_MESSAGE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ERROR_MESSAGE_TEXT` | VARCHAR2(500) | NOT NULL |  |


### ERROR_TYPE

_~13 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ERROR_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `ERROR_TYPE` | VARCHAR2(21) | NOT NULL |  |

- **PK:** `ERROR_TYPE_ID`
- **Index** unique `PK_ERROR_TYPE`: `ERROR_TYPE_ID`

### EVT_CARRIER_CONFIGURATION

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAME` 🔑 | VARCHAR2(40) | NOT NULL |  |
| 2 | `PHONE` | VARCHAR2(20) | NOT NULL |  |
| 3 | `DATABITS` | NUMBER |  |  |
| 4 | `PARITY` | NUMBER |  |  |
| 5 | `BAUDRATE` | NUMBER |  |  |
| 6 | `STOPBITS` | NUMBER |  |  |
| 7 | `FLOWCTRL` | NUMBER |  |  |

- **PK:** `NAME`
- **Index** unique `SYS_C0036555`: `NAME`

### EVT_DEST_PROFILE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DESTINATION_NAME` | VARCHAR2(80) |  |  |
| 2 | `NOTIFY_OPER_ON_DUTY` | NUMBER |  |  |
| 3 | `PROFILE_ID` | NUMBER(7,0) |  |  |
| 4 | `SEND_SNMP_TRAP` | NUMBER |  |  |

- **FK:** (`PROFILE_ID`) → `EVT_PROFILE` (`PROFILE_ID`)

### EVT_HISTORY

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NODE_NAME` | VARCHAR2(32) |  |  |
| 2 | `AGENT_ID` | NUMBER(7,0) |  |  |
| 3 | `SEVERITY` | NUMBER(2,0) |  |  |
| 4 | `OBJECT_NAME` | VARCHAR2(80) |  |  |
| 5 | `OCCUR_DATE` | DATE |  |  |
| 6 | `EVENT_NAME` | VARCHAR2(50) |  |  |
| 7 | `MESSAGE` | VARCHAR2(2000) |  |  |
| 8 | `ACK_DATE` | DATE |  |  |
| 9 | `ACK_BY` | NUMBER(2,0) |  |  |
| 10 | `ACK_COMMENTS` | VARCHAR2(512) |  |  |
| 11 | `NOTIFY_ID` | NUMBER(7,0) |  |  |


### EVT_INSTANCE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROFILE_ID` | NUMBER(7,0) |  |  |
| 2 | `EVENT_ID` | NUMBER(7,0) |  |  |
| 3 | `NODE_NAME` | VARCHAR2(32) |  |  |
| 4 | `DESTINATION_NAME` | VARCHAR2(80) |  |  |
| 5 | `DAEMON_ID` | NUMBER(7,0) |  |  |
| 6 | `AGENT_ID` | NUMBER(7,0) |  |  |
| 7 | `STATUS` | NUMBER(7,0) |  |  |
| 8 | `ERROR_CODE` | NUMBER(7,0) |  |  |
| 9 | `ERROR_TEXT` | VARCHAR2(255) |  |  |

- **FK:** (`PROFILE_ID`) → `EVT_PROFILE` (`PROFILE_ID`)

### EVT_MAIL_CONFIGURATION

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CURRENT_SELECTION` | VARCHAR2(10) |  |  |
| 2 | `SMTP_USER` | VARCHAR2(80) |  |  |
| 3 | `SMTP_SERVER` | VARCHAR2(80) |  |  |
| 4 | `MAPI_USER` | VARCHAR2(80) |  |  |
| 5 | `MAPI_PASSWORD` | VARCHAR2(80) |  |  |


### EVT_MONITOR_NODE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NODE_NAME` | VARCHAR2(32) |  |  |
| 2 | `COUNT` | NUMBER |  |  |

- **Unique** (SYS_C0036556): `NODE_NAME`

### EVT_NOTIFY_STATUS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NOTIFY_ID` | NUMBER(7,0) |  |  |
| 2 | `SUB_NOTIFY_ID` | NUMBER(7,0) |  |  |
| 3 | `ADMIN_ID` | NUMBER(7,0) |  |  |
| 4 | `NOTIFY_METHOD` | NUMBER |  |  |
| 5 | `STATUS` | NUMBER |  |  |
| 6 | `MESSAGE` | VARCHAR2(80) |  |  |
| 7 | `NOTIFY_TIME` | DATE |  |  |


### EVT_OPERATORS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `OPER_ID` | NUMBER(7,0) |  |  |
| 2 | `NAME` | VARCHAR2(80) |  |  |
| 3 | `COMMENTS` | VARCHAR2(80) |  |  |
| 4 | `EMAIL_SERVICE` | VARCHAR2(80) |  |  |
| 5 | `EMAIL_ADDRESS` | VARCHAR2(80) |  |  |
| 6 | `PAGING_SERVICE` | VARCHAR2(80) |  |  |
| 7 | `PAGING_PIN` | VARCHAR2(20) |  |  |
| 8 | `MAPI_NAME` | VARCHAR2(80) |  |  |
| 9 | `SMTP_NAME` | VARCHAR2(80) |  |  |

- **Unique** (SYS_C0036557): `OPER_ID`

### EVT_OPERATORS_ADDITIONAL

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DESTINATION_NAME` | VARCHAR2(80) |  |  |
| 2 | `PROFILE_ID` | NUMBER(7,0) |  |  |
| 3 | `OPER_ID` | NUMBER(7,0) |  |  |
| 4 | `EMAIL` | NUMBER |  |  |
| 5 | `PAGING` | NUMBER |  |  |


### EVT_OPERATORS_SYSTEMS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `OPER_ID` | NUMBER(7,0) |  |  |
| 2 | `SERVICE_TYPE` | VARCHAR2(32) |  |  |
| 3 | `SYSTEM_NAME` | VARCHAR2(32) |  |  |
| 4 | `EMAIL_SCHEDULE` | RAW(42) |  |  |
| 5 | `PAGING_SCHEDULE` | RAW(42) |  |  |


### EVT_OUTSTANDING

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NODE_NAME` | VARCHAR2(32) |  |  |
| 2 | `AGENT_ID` | NUMBER(7,0) |  |  |
| 3 | `SEVERITY` | NUMBER(2,0) |  |  |
| 4 | `OBJECT_NAME` | VARCHAR2(80) |  |  |
| 5 | `OCCUR_DATE` | DATE |  |  |
| 6 | `EVENT_NAME` | VARCHAR2(50) |  |  |
| 7 | `MESSAGE` | VARCHAR2(2000) |  |  |
| 8 | `ACKNOWLEDGED` | NUMBER(2,0) |  |  |
| 9 | `ACK_COMMENTS` | VARCHAR2(512) |  |  |
| 10 | `NOTIFY_ID` | NUMBER(7,0) |  |  |


### EVT_PROFILE

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROFILE_ID` | NUMBER(7,0) |  |  |
| 2 | `PROFILE_NAME` | VARCHAR2(32) |  |  |
| 3 | `PROFILE_DESCRIPTION` | VARCHAR2(80) |  |  |
| 4 | `SERVICE_NAME` | VARCHAR2(80) |  |  |

- **Unique** (SYS_C0036558): `PROFILE_ID`
- **Unique** (SYS_C0036559): `PROFILE_NAME`

### EVT_PROFILE_EVENTS

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROFILE_ID` | NUMBER(7,0) |  |  |
| 2 | `EVENT_ID` | NUMBER |  |  |
| 3 | `EVENT_NAME` | VARCHAR2(80) |  |  |
| 4 | `FREQUENCY` | NUMBER |  |  |
| 5 | `FREQUENCY_UNITS` | VARCHAR2(12) |  |  |
| 6 | `NUM_ARGS` | NUMBER |  |  |
| 7 | `ARGS` | VARCHAR2(256) |  |  |
| 8 | `FIXIT_JOB_ID` | NUMBER |  |  |

- **Unique** (SYS_C0036560): `PROFILE_ID`, `EVENT_ID`

### EVT_REGISTRY

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPID` | VARCHAR2(80) |  |  |
| 2 | `EVENT_NAME` | VARCHAR2(80) |  |  |
| 3 | `SYSTEM_NAME` | VARCHAR2(80) |  |  |

- **Unique** (EVT_REGISTRY_CONSTRAINT): `APPID`, `EVENT_NAME`, `SYSTEM_NAME`

### EVT_REGISTRY_BACKLOG

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPID` | VARCHAR2(80) |  |  |
| 2 | `EVENT_NAME` | VARCHAR2(80) |  |  |
| 3 | `SYSTEM_NAME` | VARCHAR2(80) |  |  |
| 4 | `NODE_NAME` | VARCHAR2(80) |  |  |
| 5 | `OCCUR_DATE` | DATE |  |  |
| 6 | `SEVERITY` | NUMBER(2,0) |  |  |
| 7 | `CHUNK_SEQ_NUMBER` | NUMBER(4,0) |  |  |
| 8 | `MESSAGE` | VARCHAR2(2000) |  |  |


### FENDER

_~81 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `FE_SIDE` | NUMBER(10,5) |  |  |
| 4 | `FE_SIDE_PLUS` | NUMBER(6,6) |  |  |
| 5 | `FE_SIDE_MINUS` | NUMBER(6,6) |  |  |
| 6 | `FE_DIE1` | VARCHAR2(18) |  |  |
| 7 | `FE_DIE2` | VARCHAR2(18) |  |  |
| 8 | `FE_LENGTH` | NUMBER(10,5) |  |  |
| 9 | `FE_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 10 | `FE_LENGTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKFENDER`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### FIRST_JOB_COIL_WT_0ED_OUT

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SEQ_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `CURR_DATE_TIME` 🔑 | TIMESTAMP(6) | NOT NULL |  |
| 5 | `LINE_DESC` | VARCHAR2(255) |  |  |
| 6 | `BEGIN_WT` | NUMBER(8,0) |  |  |
| 7 | `DW_2_OBJECT_WT` | NUMBER(8,0) |  |  |
| 8 | `END_WT` | NUMBER(8,0) |  |  |
| 9 | `NEW_STATUS` | NUMBER(3,0) |  |  |
| 10 | `NOTES` | VARCHAR2(255) |  |  |

- **PK:** `COIL_ABC_NUM`, `AB_JOB_NUM`, `SEQ_NUM`, `CURR_DATE_TIME`
- **Index** unique `XPK_FIRST_JOB_COIL_WT_0ED_OUT`: `COIL_ABC_NUM`, `AB_JOB_NUM`, `SEQ_NUM`, `CURR_DATE_TIME`

### FLAW_CODES

_~10 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `FLAW_CODE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `REASON` | VARCHAR2(100) |  |  |
| 3 | `NOTE` | VARCHAR2(500) |  |  |

- **PK:** `FLAW_CODE`
- **Index** unique `XPK_FLAW_CODES`: `FLAW_CODE`

### GM_DESTINATION_CUSTOMERS

_~5 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `DES_SH_CUST_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`, `DES_SH_CUST_ID`
- **Index** unique `XPK_GM_DESTINATION_CUSTOMERS`: `CUSTOMER_ID`, `DES_SH_CUST_ID`

### GROUPDEPARTMENT

_~21 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `GROUPDEPARTMENT_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `GROUPDEPARTMENT` | VARCHAR2(64) | NOT NULL |  |
| 3 | `DEPTTYPE` | VARCHAR2(128) |  |  |

- **PK:** `GROUPDEPARTMENT_ID`
- **Index** unique `SYS_C0036563`: `GROUPDEPARTMENT_ID`

### HANDLING_CODES

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `HANDLING_CODE` 🔑 | CHAR(1) | NOT NULL |  |
| 2 | `HANDLING_CODE_NAME` | VARCHAR2(100) |  |  |

- **PK:** `HANDLING_CODE`
- **Index** unique `XPK_HANDLING_CODES`: `HANDLING_CODE`

### IMPORTED_FILE_863

_~8,596 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `FILE_STRING` | LONG | NOT NULL |  |
| 3 | `SAMPLE_ID` | VARCHAR2(20) | NOT NULL |  |
| 4 | `CREATED_DATE` | DATE | NOT NULL |  |
| 5 | `NOTES` | VARCHAR2(255) |  |  |

- **PK:** `FILE_ID`
- **Index** unique `IMPORTED_FILE_863_PK`: `FILE_ID`

### INBOUND_841

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PO` 🔑 | VARCHAR2(20) | NOT NULL |  |
| 3 | `REVISION` | VARCHAR2(20) |  |  |
| 4 | `ALLOY` | VARCHAR2(20) |  |  |
| 5 | `TEMPER` | VARCHAR2(8) |  |  |
| 6 | `LW_FLAG` | VARCHAR2(1) |  |  |
| 7 | `MIN_GAUGE` | VARCHAR2(20) |  |  |
| 8 | `MAX_GAUGE` | VARCHAR2(20) |  |  |
| 9 | `TEI_MIN` | VARCHAR2(20) |  |  |
| 10 | `TEI_MAX` | VARCHAR2(20) |  |  |
| 11 | `TBE_MIN` | VARCHAR2(20) |  |  |
| 12 | `TBE_MAX` | VARCHAR2(20) |  |  |
| 13 | `TWO_MIN` | VARCHAR2(20) |  |  |
| 14 | `TWO_MAX` | VARCHAR2(20) |  |  |
| 15 | `TPS_MIN` | VARCHAR2(20) |  |  |
| 16 | `TPS_MAX` | VARCHAR2(20) |  |  |
| 17 | `TTL_MIN` | VARCHAR2(20) |  |  |
| 18 | `TTL_MAX` | VARCHAR2(20) |  |  |
| 19 | `TTL_TPF_MIN` | VARCHAR2(20) |  |  |
| 20 | `TTL_TPF_MAX` | VARCHAR2(20) |  |  |
| 21 | `TTY_MIN` | VARCHAR2(20) |  |  |
| 22 | `TTY_MAX` | VARCHAR2(20) |  |  |
| 23 | `TTY_TPF_MIN` | VARCHAR2(20) |  |  |
| 24 | `TTY_TPF_MAX` | VARCHAR2(20) |  |  |
| 25 | `TEL_MIN` | VARCHAR2(20) |  |  |
| 26 | `TEL_MAX` | VARCHAR2(20) |  |  |
| 27 | `TEL_TPF_MIN` | VARCHAR2(20) |  |  |
| 28 | `TEL_TPF_MAX` | VARCHAR2(20) |  |  |
| 29 | `TNL_MIN` | VARCHAR2(20) |  |  |
| 30 | `TNL_MAX` | VARCHAR2(20) |  |  |
| 31 | `TNL_TPF_MIN` | VARCHAR2(20) |  |  |
| 32 | `TNL_TPF_MAX` | VARCHAR2(20) |  |  |
| 33 | `TTS_MIN` | VARCHAR2(20) |  |  |
| 34 | `TTS_MAX` | VARCHAR2(20) |  |  |
| 35 | `TTS_TPF_MIN` | VARCHAR2(20) |  |  |
| 36 | `TTS_TPF_MAX` | VARCHAR2(20) |  |  |
| 37 | `TTT_MIN` | VARCHAR2(20) |  |  |
| 38 | `TTT_MAX` | VARCHAR2(20) |  |  |
| 39 | `TTT_TPF_MIN` | VARCHAR2(20) |  |  |
| 40 | `TTT_TPF_MAX` | VARCHAR2(20) |  |  |
| 41 | `TET_MIN` | VARCHAR2(20) |  |  |
| 42 | `TET_MAX` | VARCHAR2(20) |  |  |
| 43 | `TET_TPF_MIN` | VARCHAR2(20) |  |  |
| 44 | `TET_TPF_MAX` | VARCHAR2(20) |  |  |
| 45 | `TNT_MIN` | VARCHAR2(20) |  |  |
| 46 | `TNT_MAX` | VARCHAR2(20) |  |  |
| 47 | `TNT_TPF_MIN` | VARCHAR2(20) |  |  |
| 48 | `TNT_TPF_MAX` | VARCHAR2(20) |  |  |
| 49 | `TTO_MIN` | VARCHAR2(20) |  |  |
| 50 | `TTO_MAX` | VARCHAR2(20) |  |  |
| 51 | `TTO_TPF_MIN` | VARCHAR2(20) |  |  |
| 52 | `TTO_TPF_MAX` | VARCHAR2(20) |  |  |
| 53 | `TES_MIN` | VARCHAR2(20) |  |  |
| 54 | `TES_MAX` | VARCHAR2(20) |  |  |
| 55 | `TES_TPF_MIN` | VARCHAR2(20) |  |  |
| 56 | `TES_TPF_MAX` | VARCHAR2(20) |  |  |
| 57 | `TND_MIN` | VARCHAR2(20) |  |  |
| 58 | `TND_MAX` | VARCHAR2(20) |  |  |
| 59 | `TND_TPF_MIN` | VARCHAR2(20) |  |  |
| 60 | `TND_TPF_MAX` | VARCHAR2(20) |  |  |
| 61 | `TTU_MIN` | VARCHAR2(20) |  |  |
| 62 | `TTU_MAX` | VARCHAR2(20) |  |  |
| 63 | `TTU_TPF_MIN` | VARCHAR2(20) |  |  |
| 64 | `TTU_TPF_MAX` | VARCHAR2(20) |  |  |

- **PK:** `EDI_FILE_ID`, `PO`
- **Index** unique `SYS_C0036565`: `EDI_FILE_ID`, `PO`

### INBOUND_863

_~4,116 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `WD` | VARCHAR2(20) |  |  |
| 4 | `TH` | VARCHAR2(20) |  |  |
| 5 | `TWO` | VARCHAR2(20) |  |  |
| 6 | `TTY_F_M1` | VARCHAR2(20) |  |  |
| 7 | `TTY_F_M2` | VARCHAR2(20) |  |  |
| 8 | `TTU_F_M1` | VARCHAR2(20) |  |  |
| 9 | `TTU_F_M2` | VARCHAR2(20) |  |  |
| 10 | `TEL_F_M1` | VARCHAR2(20) |  |  |
| 11 | `TEL_F_M2` | VARCHAR2(20) |  |  |
| 12 | `TRL_F_M1` | VARCHAR2(20) |  |  |
| 13 | `TRL_F_M2` | VARCHAR2(20) |  |  |
| 14 | `TNL_F_M1` | VARCHAR2(20) |  |  |
| 15 | `TNL_F_M2` | VARCHAR2(20) |  |  |
| 16 | `TTY_B_M1` | VARCHAR2(20) |  |  |
| 17 | `TTY_B_M2` | VARCHAR2(20) |  |  |
| 18 | `TTU_B_M1` | VARCHAR2(20) |  |  |
| 19 | `TTU_B_M2` | VARCHAR2(20) |  |  |
| 20 | `TEL_B_M1` | VARCHAR2(20) |  |  |
| 21 | `TEL_B_M2` | VARCHAR2(20) |  |  |
| 22 | `TRL_B_M1` | VARCHAR2(20) |  |  |
| 23 | `TRL_B_M2` | VARCHAR2(20) |  |  |
| 24 | `TNL_B_M1` | VARCHAR2(20) |  |  |
| 25 | `TNL_B_M2` | VARCHAR2(20) |  |  |
| 26 | `TTO_F_M1` | VARCHAR2(20) |  |  |
| 27 | `TTO_F_M2` | VARCHAR2(20) |  |  |
| 28 | `TTS_F_M1` | VARCHAR2(20) |  |  |
| 29 | `TTS_F_M2` | VARCHAR2(20) |  |  |
| 30 | `TES_F_M1` | VARCHAR2(20) |  |  |
| 31 | `TES_F_M2` | VARCHAR2(20) |  |  |
| 32 | `TRD_F_M1` | VARCHAR2(20) |  |  |
| 33 | `TRD_F_M2` | VARCHAR2(20) |  |  |
| 34 | `TND_F_M1` | VARCHAR2(20) |  |  |
| 35 | `TND_F_M2` | VARCHAR2(20) |  |  |
| 36 | `TTT_F_M1` | VARCHAR2(20) |  |  |
| 37 | `TTT_F_M2` | VARCHAR2(20) |  |  |
| 38 | `TTL_F_M1` | VARCHAR2(20) |  |  |
| 39 | `TTL_F_M2` | VARCHAR2(20) |  |  |
| 40 | `TET_F_M1` | VARCHAR2(20) |  |  |
| 41 | `TET_F_M2` | VARCHAR2(20) |  |  |
| 42 | `TRT_F_M1` | VARCHAR2(20) |  |  |
| 43 | `TRT_F_M2` | VARCHAR2(20) |  |  |
| 44 | `TNT_F_M1` | VARCHAR2(20) |  |  |
| 45 | `TNT_F_M2` | VARCHAR2(20) |  |  |
| 46 | `SI` | VARCHAR2(20) |  |  |
| 47 | `FE` | VARCHAR2(20) |  |  |
| 48 | `CU` | VARCHAR2(20) |  |  |
| 49 | `MN` | VARCHAR2(20) |  |  |
| 50 | `MG` | VARCHAR2(20) |  |  |
| 51 | `CR` | VARCHAR2(20) |  |  |
| 52 | `NI` | VARCHAR2(20) |  |  |
| 53 | `ZN` | VARCHAR2(20) |  |  |
| 54 | `TI` | VARCHAR2(20) |  |  |
| 55 | `GH` | VARCHAR2(20) |  |  |
| 56 | `AL` | VARCHAR2(20) |  |  |
| 57 | `BB` | VARCHAR2(20) |  |  |
| 58 | `V` | VARCHAR2(20) |  |  |
| 59 | `STATUS` | NUMBER(1,0) |  |  |

- **PK:** `EDI_FILE_ID`, `COIL_NUM`
- **Index** unique `SYS_C0036566`: `EDI_FILE_ID`, `COIL_NUM`

### INBOUND_COIL

_~86,208 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `BOL` 🔑 | VARCHAR2(40) | NOT NULL |  |
| 3 | `ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 4 | `COIL_NUMBER` | VARCHAR2(32) |  |  |
| 5 | `PS_COIL_NUMBER` | VARCHAR2(32) |  |  |
| 6 | `TEMPER` | VARCHAR2(8) |  |  |
| 7 | `NET_WEIGHT` | NUMBER(8,0) |  |  |
| 8 | `GROSS_WEIGHT` | NUMBER(8,0) |  |  |
| 9 | `LINEAL_FEED` | NUMBER(7,2) |  |  |
| 10 | `COIL_WIDTH` | NUMBER(9,4) |  |  |
| 11 | `COIL_GAUGE` | NUMBER(5,4) |  |  |
| 12 | `DENSITY` | NUMBER |  |  |
| 13 | `LOT` | VARCHAR2(40) |  |  |
| 14 | `PACK_ID` | VARCHAR2(40) |  |  |
| 15 | `ALLOY` | VARCHAR2(40) |  |  |
| 16 | `CONSUMED_COIL_NUM` | VARCHAR2(32) |  |  |
| 17 | `MATERIAL_NUM` | VARCHAR2(32) |  |  |
| 18 | `CASH_DATE` | VARCHAR2(24) |  |  |
| 19 | `DATE_TIME_RECEIVED` | VARCHAR2(20) |  |  |
| 20 | `VO` | VARCHAR2(40) |  |  |
| 21 | `PO` | VARCHAR2(40) |  |  |
| 22 | `PART_NUM` | VARCHAR2(40) |  |  |
| 23 | `PO_LINE_NUM` | NUMBER(8,0) |  |  |
| 24 | `CNTRY_OF_CAST` | VARCHAR2(4) |  |  |
| 25 | `LFEED` | NUMBER(6,0) |  |  |
| 26 | `PRODUCTION_DESC_CODE` | CHAR(2) |  |  |
| 27 | `CUSTOMER_PO` | VARCHAR2(40) |  |  |

- **PK:** `EDI_FILE_ID`, `BOL`, `ITEM_NUM`
- **Index** unique `PK_INBOUND_COIL_NEW`: `EDI_FILE_ID`, `BOL`, `ITEM_NUM`

### INBOUND_COIL_STATUS

_~86,218 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `BOL` 🔑 | VARCHAR2(40) | NOT NULL |  |
| 3 | `ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 4 | `DAMAGED_CODE` | NUMBER(3,0) |  |  |
| 5 | `DAMAGED_FAULT` | NUMBER(1,0) |  |  |
| 6 | `STATUS` | NUMBER(1,0) |  |  |
| 7 | `COIL_NUMBER` | VARCHAR2(32) |  |  |
| 8 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 9 | `BARCODE_STRING` | VARCHAR2(4000) |  |  |

- **PK:** `EDI_FILE_ID`, `BOL`, `ITEM_NUM`
- **Index** unique `PK_INBOUND_COIL_STATUS_NEW`: `EDI_FILE_ID`, `BOL`, `ITEM_NUM`

### INBOUND_SHIPMENT

_~65,639 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `BOL` 🔑 | VARCHAR2(40) | NOT NULL |  |
| 3 | `GROSS` | NUMBER(8,0) |  |  |
| 4 | `NET` | NUMBER(8,0) |  |  |
| 5 | `TD1` | VARCHAR2(40) |  |  |
| 6 | `LN` | VARCHAR2(40) |  |  |
| 7 | `SCAC` | VARCHAR2(40) |  |  |
| 8 | `TRAILER_ID` | VARCHAR2(40) |  |  |
| 9 | `PK` | VARCHAR2(40) |  |  |
| 10 | `SHIP_TO` | VARCHAR2(40) |  |  |
| 11 | `SHIP_FROM` | VARCHAR2(40) |  |  |
| 12 | `PART_NUMBER` | VARCHAR2(40) |  |  |
| 13 | `PO` | VARCHAR2(40) |  |  |
| 14 | `CONTACT_NUMBER` | VARCHAR2(40) |  |  |
| 15 | `TOTAL_WEIGHT` | NUMBER(8,0) |  |  |
| 16 | `VO` | VARCHAR2(40) |  |  |
| 17 | `MILL_DUNS_NUM` | VARCHAR2(40) |  |  |
| 18 | `PACKAGING_CODE` | VARCHAR2(20) |  |  |
| 19 | `LOADING_QTY` | NUMBER(4,0) |  |  |

- **PK:** `EDI_FILE_ID`, `BOL`
- **Index** unique `XPKINBOUND_SHIPMENT`: `EDI_FILE_ID`, `BOL`

### INBOUND_SHIPMENT_CUSTOMER

_~12 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SHIP_FROM` 🔑 | VARCHAR2(40) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`, `SHIP_FROM`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036570`: `CUSTOMER_ID`, `SHIP_FROM`

### INBOUND_SHIPMENT_STATUS

_~63,908 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `BOL` 🔑 | VARCHAR2(40) | NOT NULL |  |
| 3 | `STATUS` | NUMBER(1,0) |  |  |
| 4 | `RECEIVED_TIME` | DATE |  |  |
| 5 | `FILENAME_861` | VARCHAR2(100) |  |  |
| 6 | `CREATED_861_DATE_TIME` | DATE |  |  |

- **PK:** `EDI_FILE_ID`, `BOL`
- **Index** unique `PK_INBOUND_SHIPMENT_STATUS`: `EDI_FILE_ID`, `BOL`

### INBOUND_TRANSACTION

_~10,546 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `DUNS_FROM` | VARCHAR2(40) |  |  |
| 3 | `DUNS_TO` | VARCHAR2(40) |  |  |
| 4 | `TRANSACTION_DATE` | VARCHAR2(40) |  |  |
| 5 | `TRANSACTION_TIME` | VARCHAR2(40) |  |  |
| 6 | `INTERCHANGE_CONTROL_NUMBER` | VARCHAR2(40) |  |  |
| 7 | `EDI_FILE_NAME` | VARCHAR2(40) | NOT NULL |  |
| 8 | `EDI_FILE_RAW` | LONG RAW |  |  |

- **PK:** `EDI_FILE_ID`
- **Index** unique `XPKINBOUND_TRANSACTION`: `EDI_FILE_ID`

### INVOICE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `INVOICE_NUM` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `TIMESTAMP` | DATE | NOT NULL |  |
| 4 | `NOTES` | VARCHAR2(2048) |  |  |

- **PK:** `AB_JOB_NUM`, `INVOICE_NUM`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `SYS_C0036573`: `AB_JOB_NUM`, `INVOICE_NUM`

### ITEMDEVICE

_~120 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ITEMDEVICE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SUBSYSEQUIPMENT_ID` | NUMBER(8,0) |  |  |
| 3 | `SYSEQUIPMENT_ID` | NUMBER(8,0) |  |  |
| 4 | `ITEMDEVICE` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `ITEMDEVICE_ID`
- **FK:** (`SUBSYSEQUIPMENT_ID`) → `SUBSYSTEMEQUIPMENT` (`SUBSYSEQUIPMENT_ID`)
- **FK:** (`SYSEQUIPMENT_ID`) → `SYSTEMEQUIPMENT` (`SYSEQUIPMENT_ID`)
- **Index** unique `SYS_C0036574`: `ITEMDEVICE_ID`

### JOB_EFOLDER_NOTES

_~10 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `USER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `TIMESTAMP` 🔑 | DATE | NOT NULL |  |
| 4 | `NOTES` | VARCHAR2(2048) |  |  |

- **PK:** `AB_JOB_NUM`, `USER_ID`, `TIMESTAMP`
- **FK:** (`USER_ID`) → `SECURITY_USER` (`USER_ID`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `SYS_C0036575`: `AB_JOB_NUM`, `USER_ID`, `TIMESTAMP`

### LAST_JOB_COIL_WT_ZEROED_OUT

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` | NUMBER(8,0) | NOT NULL |  |
| 3 | `BEGIN_WT` | NUMBER(8,0) | NOT NULL |  |
| 4 | `END_WT` | NUMBER(8,0) | NOT NULL |  |


### LEFT_TRAPEZOID

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `LTR_LONG_LENGTH` | NUMBER(10,5) |  |  |
| 4 | `LTR_LONG_PLUS` | NUMBER(6,6) |  |  |
| 5 | `LTR_LONG_MINUS` | NUMBER(6,6) |  |  |
| 6 | `LTR_SHORT_LENGTH` | NUMBER(10,5) |  |  |
| 7 | `LTR_SHORT_PLUS` | NUMBER(6,6) |  |  |
| 8 | `LTR_SHORT_MINUS` | NUMBER(6,6) |  |  |
| 9 | `LTR_WIDTH` | NUMBER(10,5) |  |  |
| 10 | `LTR_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 11 | `LTR_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 12 | `LTR_DIE1` | VARCHAR2(18) |  |  |
| 13 | `LTR_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKLEFT_HAND_TRAPEZOID`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### LIFTGATE_SHAPE

_~134 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `LI_WIDTH` | NUMBER(10,5) |  |  |
| 4 | `LI_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 5 | `LI_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 6 | `LI_LENGTH` | NUMBER(10,5) |  |  |
| 7 | `LI_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 8 | `LI_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 9 | `LI_DIE1` | VARCHAR2(18) |  |  |
| 10 | `LI_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `PK_LIFTGATE_SHAPE`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### LINE

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `MAX_WIDTH` | NUMBER(5,2) |  |  |
| 3 | `MAX_SPEED` | NUMBER(5,2) |  |  |
| 4 | `MIN_THICKNESS` | NUMBER(5,4) |  |  |
| 5 | `MAX_THICKNESS` | NUMBER(7,3) |  |  |
| 6 | `MAX_THICKNESS_OTEMPER` | NUMBER(5,4) |  |  |
| 7 | `MAX_WEIGHT` | NUMBER(8,0) |  |  |
| 8 | `LINE_SHEET_LENGTH` | NUMBER(7,2) |  |  |
| 9 | `MIN_COIL_INSIDE_DIAMETER` | NUMBER(5,2) |  |  |
| 10 | `MAX_COIL_INSIDE_DIAMETER` | NUMBER(5,2) |  |  |
| 11 | `MAX_COIL_OUTSIDE_DIAMETER` | NUMBER(5,2) |  |  |
| 12 | `LINE_LOCATION` | VARCHAR2(18) |  |  |
| 13 | `LINE_STATUS` | NUMBER(2,0) |  |  |
| 14 | `LINE_DESC` | VARCHAR2(255) |  |  |
| 15 | `AVG_LB_PER_HR` | NUMBER(6,0) |  |  |
| 16 | `AUTO_DATA_ACQUISITION` | NUMBER(1,0) |  |  |
| 17 | `AVERAGE_COIL_CHANGE_MINUTES` | NUMBER(4,0) |  |  |

- **PK:** `LINE_NUM`
- **Index** unique `SYS_C0036578`: `LINE_NUM`

### LINE_CODES

_~11 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_ID` 🔑 | VARCHAR2(5) | NOT NULL |  |
| 2 | `LINE_NAME` | VARCHAR2(40) |  |  |

- **PK:** `LINE_ID`
- **Index** unique `XPK_LINE_CODES`: `LINE_ID`

### LINE_CURRENT_STATUS

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `SCRAP_SKID_NUM` | NUMBER(8,0) |  |  |
| 3 | `SHEET_SKID_NUM` | NUMBER(8,0) |  |  |
| 4 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 5 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 6 | `SHIFT_NUM` | NUMBER(8,0) |  |  |
| 7 | `LINE_STATUS` | NUMBER(5,0) |  |  |
| 8 | `COIL_PROCESS_RATE` | NUMBER(3,0) |  |  |
| 9 | `SHEET_SKID_LOCATION_0` | NUMBER(8,0) |  |  |
| 10 | `SHEET_SKID_LOCATION_1` | NUMBER(8,0) |  |  |
| 11 | `SHEET_SKID_LOCATION_2` | NUMBER(8,0) |  |  |
| 12 | `SHEET_SKID_LOCATION_3` | NUMBER(8,0) |  |  |
| 13 | `SHEET_SKID_LOCATION_4` | NUMBER(8,0) |  |  |
| 14 | `SHEET_SKID_LOCATION_5` | NUMBER(8,0) |  |  |
| 15 | `SHEET_SKID_LOCATION_6` | NUMBER(8,0) |  |  |
| 16 | `SHEET_SKID_LOCATION_7` | NUMBER(8,0) |  |  |
| 17 | `SHEET_SKID_LOCATION_8` | NUMBER(8,0) |  |  |
| 18 | `SHEET_SKID_LOCATION_9` | NUMBER(8,0) |  |  |
| 19 | `SHEET_SKID_LOCATION_10` | NUMBER(8,0) |  |  |
| 20 | `SHEET_SKID_LOCATION_11` | NUMBER(8,0) |  |  |
| 21 | `SHEET_SKID_LOCATION_12` | NUMBER(8,0) |  |  |
| 22 | `SHEET_SKID_LOCATION_13` | NUMBER(8,0) |  |  |
| 23 | `SHEET_SKID_LOCATION_14` | NUMBER(8,0) |  |  |
| 24 | `SHEET_SKID_LOCATION_15` | NUMBER(8,0) |  |  |
| 25 | `SHEET_SKID_LOCATION_16` | NUMBER(8,0) |  |  |
| 26 | `SHEET_SKID_LOCATION_17` | NUMBER(8,0) |  |  |
| 27 | `SHEET_SKID_LOCATION_18` | NUMBER(8,0) |  |  |
| 28 | `SHEET_SKID_STACKER_1` | NUMBER(8,0) |  |  |
| 29 | `SHEET_SKID_STACKER_2` | NUMBER(8,0) |  |  |

- **PK:** `LINE_NUM`
- **FK:** (`SCRAP_SKID_NUM`) → `SCRAP_SKID` (`SCRAP_SKID_NUM`)
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`SHIFT_NUM`) → `SHIFT` (`SHIFT_NUM`)
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **Index** unique `SYS_C0036579`: `LINE_NUM`

### LINE_DEFAULT_SCHEDULE

_~21 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `SCHEDULE_TYPE` 🔑 | NUMBER(1,0) | NOT NULL |  |
| 3 | `MON_START` | DATE |  |  |
| 4 | `MON_END` | DATE |  |  |
| 5 | `MON_CANCEL` | NUMBER(1,0) | NOT NULL |  |
| 6 | `TUE_START` | DATE |  |  |
| 7 | `TUE_END` | DATE |  |  |
| 8 | `TUE_CANCEL` | NUMBER(1,0) | NOT NULL |  |
| 9 | `WED_START` | DATE |  |  |
| 10 | `WED_END` | DATE |  |  |
| 11 | `WED_CANCEL` | NUMBER(1,0) | NOT NULL |  |
| 12 | `THU_START` | DATE |  |  |
| 13 | `THU_END` | DATE |  |  |
| 14 | `THU_CANCEL` | NUMBER(1,0) | NOT NULL |  |
| 15 | `FRI_START` | DATE |  |  |
| 16 | `FRI_END` | DATE |  |  |
| 17 | `FRI_CANCEL` | NUMBER(1,0) | NOT NULL |  |
| 18 | `SAT_START` | DATE |  |  |
| 19 | `SAT_END` | DATE |  |  |
| 20 | `SAT_CANCEL` | NUMBER(1,0) | NOT NULL |  |
| 21 | `SUN_START` | DATE |  |  |
| 22 | `SUN_END` | DATE |  |  |
| 23 | `SUN_CANCEL` | NUMBER(1,0) | NOT NULL |  |

- **PK:** `LINE_NUM`, `SCHEDULE_TYPE`
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **Index** unique `SYS_C0036580`: `LINE_NUM`, `SCHEDULE_TYPE`

### LINE_DIE_4SHEET_TYPE

_~118 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_TYPE` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 2 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `DIE_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |

- **PK:** `SHEET_TYPE`, `LINE_NUM`, `DIE_ID`
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **FK:** (`DIE_ID`) → `DIE` (`DIE_ID`)
- **Index** unique `XPK_LINE_DIE_4SHEET_TYPE`: `SHEET_TYPE`, `LINE_NUM`, `DIE_ID`

### LINE_EMPLOYEES

_~95 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LAST_NAME` | VARCHAR2(20) |  |  |
| 3 | `FIRST_NAME` | VARCHAR2(20) |  |  |
| 4 | `ALLOWED_COIL_EVAL_Y_N` | CHAR(1) |  |  |
| 5 | `ACTIVE` | CHAR(1) |  |  |
| 6 | `OPERATOR` | CHAR(1) |  |  |

- **PK:** `EMPLOYEE_ID`
- **Index** unique `SYS_C0036811`: `EMPLOYEE_ID`

### LINE_OPERATOR

_~26 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `OPERATOR_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `FIRST_NAME` | VARCHAR2(12) | NOT NULL |  |
| 3 | `LAST_NAME` | VARCHAR2(12) | NOT NULL |  |
| 4 | `PHOTO` | BLOB |  |  |
| 5 | `RATE_TYPE_ID` | NUMBER(4,0) |  |  |
| 6 | `GROUP_ID` | NUMBER(4,0) |  |  |
| 7 | `ACTIVE` | CHAR(1) |  |  |

- **PK:** `OPERATOR_ID`
- **FK:** (`GROUP_ID`) → `LINE_OPERATOR_GROUP` (`GROUP_ID`)
- **FK:** (`RATE_TYPE_ID`) → `OPERATOR_RATE_TYPE` (`RATE_TYPE_ID`)
- **Index** unique `PK_LINE_OPERATOR_OPERATOR_ID`: `OPERATOR_ID`

### LINE_OPERATOR_GROUP

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `GROUP_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `GROUP_NAME` | VARCHAR2(50) | NOT NULL |  |
| 3 | `NOTE` | VARCHAR2(50) |  |  |

- **PK:** `GROUP_ID`
- **Index** unique `PK_LINE_OPERATOR_GROUP_ID`: `GROUP_ID`

### LINE_PRIORITY

_~50 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `PRIORITY_NUM` | NUMBER(3,0) |  |  |
| 4 | `COIL_REQUIRED` | NUMBER(2,0) |  |  |
| 5 | `NOTE` | VARCHAR2(30) |  |  |
| 6 | `STATUS` | NUMBER(2,0) |  |  |

- **PK:** `LINE_NUM`, `AB_JOB_NUM`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **Index** unique `LINE_PRIORITY_PK`: `LINE_NUM`, `AB_JOB_NUM`

### LINE_PRIORITY_COPY

_~40 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` | NUMBER(2,0) | NOT NULL |  |
| 2 | `PRIORITY_NUM` | NUMBER(3,0) | NOT NULL |  |
| 3 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 4 | `STATUS` | NUMBER(2,0) |  |  |

- **Index** unique `LINE_PRIORITY_X`: `LINE_NUM`, `PRIORITY_NUM`

### LINE_PROFILE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(5,0) | NOT NULL |  |
| 2 | `BUTTON_ID` 🔑 | NUMBER(5,0) | NOT NULL |  |
| 3 | `CAUSE_ID` | NUMBER(5,0) | NOT NULL |  |

- **PK:** `LINE_NUM`, `BUTTON_ID`
- **FK:** (`CAUSE_ID`) → `DT_CAUSE` (`ID`)
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **Index** unique `LINE_PROFILE_X`: `LINE_NUM`, `BUTTON_ID`

### LINE_SCHEDULE

_~21 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `SCHEDULE_TYPE` 🔑 | NUMBER(1,0) | NOT NULL |  |
| 3 | `SUPERVISOR_ID` | NUMBER(8,0) |  |  |
| 4 | `STANDARD_STARTING_TIME` | DATE |  |  |
| 5 | `STANDARD_ENDING_TIME` | DATE |  |  |
| 6 | `PLANNED_STARTING_TIME` | DATE |  |  |
| 7 | `PLANNED_ENDING_TIME` | DATE |  |  |

- **PK:** `LINE_NUM`, `SCHEDULE_TYPE`
- **FK:** (`SUPERVISOR_ID`) → `EMPLOYEE` (`EMPLOYEE_ID`)
- **Index** unique `SYS_C0036585`: `LINE_NUM`, `SCHEDULE_TYPE`

### LINE_SCHEDULE_PROFILE

_~56 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `PROFILE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `FIRST_SHIFT_START` | DATE | NOT NULL |  |
| 4 | `FIRST_SHIFT_END` | DATE | NOT NULL |  |
| 5 | `FIRST_SHIFT_OFF` | NUMBER(1,0) | NOT NULL |  |
| 6 | `SECOND_SHIFT_START` | DATE | NOT NULL |  |
| 7 | `SECOND_SHIFT_END` | DATE | NOT NULL |  |
| 8 | `SECOND_SHIFT_OFF` | NUMBER(1,0) | NOT NULL |  |
| 9 | `THIRD_SHIFT_START` | DATE | NOT NULL |  |
| 10 | `THIRD_SHIFT_END` | DATE | NOT NULL |  |
| 11 | `THIRD_SHIFT_OFF` | NUMBER(1,0) | NOT NULL |  |
| 12 | `DESCRIPTION` | VARCHAR2(20) | NOT NULL |  |

- **PK:** `LINE_ID`, `PROFILE_NUM`
- **FK:** (`LINE_ID`) → `LINE` (`LINE_NUM`)
- **Index** unique `PK_LINE_SCHEDULE_PROFILE`: `LINE_ID`, `PROFILE_NUM`

### LINE_SHIFT_EMPLOYEE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `SCHEDULE_TYPE` 🔑 | NUMBER(1,0) | NOT NULL |  |
| 3 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `LINE_NUM`, `SCHEDULE_TYPE`, `EMPLOYEE_ID`
- **FK:** (`LINE_NUM`, `SCHEDULE_TYPE`) → `LINE_SCHEDULE` (`LINE_NUM`, `SCHEDULE_TYPE`)
- **FK:** (`EMPLOYEE_ID`) → `EMPLOYEE` (`EMPLOYEE_ID`)
- **Index** unique `SYS_C0036587`: `LINE_NUM`, `SCHEDULE_TYPE`, `EMPLOYEE_ID`

### LINE_SPM_STATUS

_~8,351 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `DATETIME` 🔑 | DATE | NOT NULL |  |
| 3 | `SPM` | NUMBER(5,1) | NOT NULL |  |
| 4 | `NOTE` | VARCHAR2(25) |  |  |

- **PK:** `LINE_NUM`, `DATETIME`
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **Index** unique `PK_LINE_STATUS`: `LINE_NUM`, `DATETIME`

### LUBE_WEIGHT

_~1,347 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LUBE_WEIGHT_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `LUBE_WEIGHT` | NUMBER(8,4) |  |  |
| 4 | `PROCESS_DATE` | DATE |  |  |
| 5 | `PROCESS_BY` | VARCHAR2(32) |  |  |

- **PK:** `COIL_ABC_NUM`, `LUBE_WEIGHT_ITEM_NUM`
- **Index** unique `SYS_C0036589`: `COIL_ABC_NUM`, `LUBE_WEIGHT_ITEM_NUM`

### MAINT_ACTION

_~51 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_ACTION` 🔑 | VARCHAR2(128) | NOT NULL |  |

- **PK:** `MAINT_ACTION`
- **Index** unique `SYS_C0036590`: `MAINT_ACTION`

### MAINT_FREQUENCY

_~32 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_FREQ` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 2 | `FREQ_TYPE` | VARCHAR2(32) | NOT NULL |  |
| 3 | `NUMPERYEAR` | NUMBER(4,0) |  |  |
| 4 | `DAYSBETWEEN` | NUMBER(5,1) |  |  |
| 5 | `PMRANGE` | NUMBER(5,1) |  |  |
| 6 | `LOWREPEAT` | NUMBER(5,3) |  |  |
| 7 | `MIDREPEAT` | NUMBER(5,3) |  |  |
| 8 | `HIGHREPEAT` | NUMBER(5,3) |  |  |

- **PK:** `MAINT_FREQ`
- **Index** unique `SYS_C0036591`: `MAINT_FREQ`

### MAINT_LOG

_~5,327 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_LOG_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `MAINT_LOG_STATUS` | VARCHAR2(128) |  |  |
| 3 | `GROUPDEPARTMENT_ID` | NUMBER(8,0) |  |  |
| 4 | `SYSTEMEQUIPMENT` | VARCHAR2(128) |  |  |
| 5 | `SUBSYSTEMEQUIPMENT` | VARCHAR2(128) |  |  |
| 6 | `ITEMDEVICE` | VARCHAR2(128) |  |  |
| 7 | `PROBDATETIME` | DATE | NOT NULL |  |
| 8 | `PROB_DETAILS` | VARCHAR2(1024) | NOT NULL |  |
| 9 | `ACTIONS` | VARCHAR2(1024) |  |  |
| 10 | `AUTHOR` | VARCHAR2(64) | NOT NULL |  |
| 11 | `REPORTEDBY` | VARCHAR2(64) |  |  |
| 12 | `ENTEREDDATETIME` | DATE | NOT NULL |  |
| 13 | `ASSIGNEDTO` | VARCHAR2(128) |  |  |
| 14 | `COMPLETEDDATETIME` | DATE |  |  |
| 15 | `COMPLETEDBY` | VARCHAR2(128) |  |  |
| 16 | `LABORHOURS` | NUMBER(8,2) |  |  |
| 17 | `PROB_COST` | NUMBER(8,2) |  |  |
| 18 | `LASTAPPENDEDBY` | VARCHAR2(64) |  |  |
| 19 | `LASTAPPENDEDDATE` | DATE |  |  |
| 20 | `SCRIBE` | VARCHAR2(32) |  |  |
| 21 | `REMARK` | VARCHAR2(64) |  |  |
| 22 | `FLAG` | VARCHAR2(32) |  |  |
| 23 | `HASIMAGE` | NUMBER(1,0) |  |  |
| 24 | `IMAGEPATH` | VARCHAR2(128) |  |  |
| 25 | `SPTEXT` | VARCHAR2(64) |  |  |
| 26 | `SPYESNO` | NUMBER(1,0) |  |  |
| 27 | `SPNUMBER` | VARCHAR2(64) |  |  |
| 28 | `SPDATE` | DATE |  |  |

- **PK:** `MAINT_LOG_ID`
- **FK:** (`MAINT_LOG_STATUS`) → `MAINT_LOG_STATUS` (`MAINT_LOG_STATUS`)
- **FK:** (`GROUPDEPARTMENT_ID`) → `GROUPDEPARTMENT` (`GROUPDEPARTMENT_ID`)
- **Index** unique `SYS_C0036592`: `MAINT_LOG_ID`

### MAINT_LOG_PART_USED

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_LOG_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PARTS_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `QTY_USED` | NUMBER(6,2) | NOT NULL |  |
| 4 | `VALUEEA` | NUMBER(8,2) | NOT NULL |  |
| 5 | `PARTUSED_NOTES` | VARCHAR2(512) |  |  |
| 6 | `DATETAKEN` | DATE |  |  |
| 7 | `TAKENBY` | VARCHAR2(64) |  |  |

- **PK:** `MAINT_LOG_ID`, `PARTS_ID`
- **FK:** (`PARTS_ID`) → `PARTS` (`PARTS_ID`)
- **FK:** (`MAINT_LOG_ID`) → `MAINT_LOG` (`MAINT_LOG_ID`)
- **Index** unique `SYS_C0036593`: `MAINT_LOG_ID`, `PARTS_ID`

### MAINT_LOG_STAFF_USED

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_LOG_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `HOURS_USED` | NUMBER(6,2) |  |  |
| 4 | `HOURLY_RATE` | NUMBER(6,2) |  |  |

- **PK:** `MAINT_LOG_ID`, `EMPLOYEE_ID`
- **FK:** (`EMPLOYEE_ID`) → `EMPLOYEES` (`EMPLOYEE_ID`)
- **FK:** (`MAINT_LOG_ID`) → `MAINT_LOG` (`MAINT_LOG_ID`)
- **Index** unique `SYS_C0036594`: `MAINT_LOG_ID`, `EMPLOYEE_ID`

### MAINT_LOG_STATUS

_~22 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_LOG_STATUS` 🔑 | VARCHAR2(128) | NOT NULL |  |

- **PK:** `MAINT_LOG_STATUS`
- **Index** unique `SYS_C0036595`: `MAINT_LOG_STATUS`

### MAINT_PROBLEMS

_~156 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_PROBLEMS` 🔑 | VARCHAR2(128) | NOT NULL |  |

- **PK:** `MAINT_PROBLEMS`
- **Index** unique `SYS_C0036596`: `MAINT_PROBLEMS`

### MAINT_PROBSWITH

_~150 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MAINT_PROBSWITH` 🔑 | VARCHAR2(128) | NOT NULL |  |

- **PK:** `MAINT_PROBSWITH`
- **Index** unique `SYS_C0036597`: `MAINT_PROBSWITH`

### METAL_DENSITY

_~68 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `METAL_ALLOY` 🔑 | VARCHAR2(8) | NOT NULL |  |
| 2 | `METAL_DENSITY` | NUMBER(5,5) |  |  |

- **PK:** `METAL_ALLOY`
- **Index** unique `SYS_C0036598`: `METAL_ALLOY`

### MICROSOFTDTPROPERTIES

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `OBJECTID` | NUMBER |  |  |
| 3 | `PROPERTY` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 4 | `VALUE` | VARCHAR2(255) |  |  |
| 5 | `LVALUE` | LONG RAW |  |  |
| 6 | `VERSION` | NUMBER | NOT NULL | (0) |

- **PK:** `ID`, `PROPERTY`
- **Index** unique `MICROSOFT_PK_DTPROPERTIES`: `ID`, `PROPERTY`

### MILL_ID_CODES

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MILL_ID` 🔑 | VARCHAR2(5) | NOT NULL |  |
| 2 | `MILL_NAME` | VARCHAR2(40) |  |  |

- **PK:** `MILL_ID`
- **Index** unique `XPK_MILL_ID_CODES`: `MILL_ID`

### ONHOLD_REASON

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ONHOLD_REASON_CODE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `ONHOLD_REASON_DESC` | VARCHAR2(256) |  |  |

- **PK:** `ONHOLD_REASON_CODE`
- **Index** unique `PFK_ONHOLD_REASON`: `ONHOLD_REASON_CODE`

### OPERATOR_COMPETENCY_DISCIPLINE

_~25 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COMPETENCY_DISCIPLINE_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `COMPETENCY_DISCIPLINE` | NVARCHAR2 | NOT NULL |  |

- **PK:** `COMPETENCY_DISCIPLINE_ID`
- **Index** unique `PK_OPERATOR_COMPETENCE_DISCIP`: `COMPETENCY_DISCIPLINE_ID`

### OPERATOR_RATE_TYPE

_~5 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `RATE_TYPE_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `RATE_TYPE_NAME` | VARCHAR2(20) | NOT NULL |  |
| 3 | `RATE` | NUMBER(5,2) | NOT NULL |  |

- **PK:** `RATE_TYPE_ID`
- **Index** unique `PK_RATE_TYPE_ID_ID`: `RATE_TYPE_ID`

### OPERATOR_SKILL_LEVEL

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `OPERATOR_ID` 🔑 | NUMBER(5,0) | NOT NULL |  |
| 2 | `COMPETENCY_DISCIPLINE_ID` 🔑 | NUMBER(5,0) | NOT NULL |  |
| 3 | `SKILL_LEVEL` | NUMBER(2,0) |  |  |

- **PK:** `OPERATOR_ID`, `COMPETENCY_DISCIPLINE_ID`
- **FK:** (`COMPETENCY_DISCIPLINE_ID`) → `OPERATOR_COMPETENCY_DISCIPLINE` (`COMPETENCY_DISCIPLINE_ID`)
- **FK:** (`OPERATOR_ID`) → `LINE_OPERATOR` (`OPERATOR_ID`)
- **Index** unique `PK_OPERATOR_SKILL_LEVEL`: `OPERATOR_ID`, `COMPETENCY_DISCIPLINE_ID`

### ORDER_COIL

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `ORDER_ABC_NUM`, `COIL_ABC_NUM`
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`ORDER_ABC_NUM`) → `CUSTOMER_ORDER` (`ORDER_ABC_NUM`)
- **Index** unique `XPKORDER_COIL`: `ORDER_ABC_NUM`, `COIL_ABC_NUM`

### ORDER_ITEM

_~65,536 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SHEET_TYPE` | CHAR(18) | NOT NULL |  |
| 4 | `ENDUSER_PART_NUM` | VARCHAR2(22) |  |  |
| 5 | `SUPPLIER_CODE` | VARCHAR2(32) |  |  |
| 6 | `ORDER_ITEM_DESC` | VARCHAR2(255) |  |  |
| 7 | `QUANTITY` | NUMBER(8,0) |  |  |
| 8 | `QUANTITY_PLUS` | NUMBER(8,0) |  |  |
| 9 | `MATERIAL_END_USE` | VARCHAR2(255) |  |  |
| 10 | `ITEM_DUE_DATE` | DATE |  |  |
| 11 | `QUANTITY_MINUS` | NUMBER(8,0) |  |  |
| 12 | `MAX_SKID_WT` | NUMBER(8,0) |  |  |
| 13 | `ALLOY` | NUMBER(4,0) |  |  |
| 14 | `TEMPER` | VARCHAR2(8) |  |  |
| 15 | `GAUGE` | NUMBER(6,5) |  |  |
| 16 | `GAUGE_P` | NUMBER(6,6) |  |  |
| 17 | `GAUGE_M` | NUMBER(6,6) |  |  |
| 18 | `SH_TOLERANC_MINUS` | VARCHAR2(18) |  |  |
| 19 | `SURFACE` | VARCHAR2(255) |  |  |
| 20 | `SH_TOLERANCE_PLUS` | VARCHAR2(18) |  |  |
| 21 | `FLATNESS` | VARCHAR2(255) |  |  |
| 22 | `OIL_STENCIL_INTERLEAVE` | VARCHAR2(255) |  |  |
| 23 | `PROCESSING_OTHER_SPEC` | VARCHAR2(255) |  |  |
| 24 | `PACKAGING_SPEC1` | VARCHAR2(100) |  |  |
| 25 | `PACKAGING_SPEC2` | VARCHAR2(100) |  |  |
| 26 | `PACKAGING_SPEC3` | VARCHAR2(100) |  |  |
| 27 | `PACKAGING_SPEC4` | VARCHAR2(100) |  |  |
| 28 | `PACKAGING_SPEC5` | VARCHAR2(100) |  |  |
| 29 | `PACKAGING_SPEC6` | VARCHAR2(100) |  |  |
| 30 | `PACKAGING_SPEC7` | VARCHAR2(100) |  |  |
| 31 | `PACKAGING_BANDS` | VARCHAR2(100) |  |  |
| 32 | `PACKAGING_OTHER_SPEC` | VARCHAR2(100) |  |  |
| 33 | `ITEM_NOTE` | VARCHAR2(255) |  |  |
| 34 | `ITEM_STATUS` | NUMBER(2,0) |  |  |
| 35 | `UNIT_PRICE` | NUMBER(13,5) |  |  |
| 36 | `THEORETICAL_UNIT_WT` | NUMBER(9,5) |  |  |
| 37 | `PIECES_SKID` | NUMBER(6,0) |  |  |
| 38 | `PIECES_SKID_PLUS` | NUMBER(6,0) |  |  |
| 39 | `PIECES_SKID_MINUS` | NUMBER(6,0) |  |  |
| 40 | `ITEM_ATTACHMENTS` | VARCHAR2(255) |  |  |
| 41 | `GOVT_CONTRACT_NUM` | VARCHAR2(32) |  |  |
| 42 | `STACKS_SKID` | NUMBER(2,0) |  |  |
| 43 | `ALLOY2` | VARCHAR2(8) |  |  |
| 44 | `ITEM_CHARGE` | VARCHAR2(18) |  |  |
| 45 | `PART_NUM_ID` | NUMBER(8,0) |  |  |
| 46 | `PART_COPIED` | VARCHAR2(3) |  |  |
| 47 | `STARTING_GOODS_MATERIAL_NUM` | VARCHAR2(32) |  |  |
| 48 | `FINISHED_GOODS_MATERIAL_NUM` | VARCHAR2(32) |  |  |
| 49 | `CUST_PROD_LINE_ID` | VARCHAR2(8) |  |  |
| 50 | `SECTOR` | NUMBER(3,0) |  |  |
| 51 | `TRIMMED_WIDTH_OVERRIDE_USER` | VARCHAR2(30) |  |  |
| 52 | `TRIMMED_WIDTH_OVERRIDDEN` | CHAR(1) |  |  |
| 53 | `TRIMMED_COIL_WIDTH` | NUMBER(8,3) |  |  |
| 54 | `INCOMING_COIL_WIDTH` | NUMBER(8,3) |  |  |
| 55 | `TRIM_TYPE_CODE` | NUMBER |  |  |
| 56 | `TRIMMING_REQUIRED` | CHAR(1) |  |  |
| 57 | `ITEM_CREATED_DTTM` | DATE |  |  |
| 58 | `ITEM_ACTIVE` | CHAR(1) |  |  |
| 59 | `DIMPLING_CODE` | NUMBER(2,0) |  |  |
| 60 | `SPEC` | VARCHAR2(50) |  |  |
| 61 | `LUBE_WEIGHT` | NUMBER(8,5) |  |  |
| 62 | `ALBL_LUBE_RESPONSIBLE` | CHAR(1) |  |  |
| 63 | `DESIGNATION` | VARCHAR2(50) |  |  |
| 64 | `PART_NUM` | NUMBER(8,0) |  |  |
| 65 | `SPM` | NUMBER(4,0) |  |  |
| 66 | `EFFICIENCY_PERCENT` | NUMBER(3,0) |  |  |
| 67 | `BILLTO_ALBL` | CHAR(1) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **FK:** (`ORDER_ABC_NUM`) → `CUSTOMER_ORDER` (`ORDER_ABC_NUM`)
- **Index** unique `XPKORDER_ITEM`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### OUTBOUND_EDI_TRANSACTION

_~87,412 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `EDI_FILE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `DUNS_FROM` | VARCHAR2(40) | NOT NULL |  |
| 3 | `DUNS_TO` | VARCHAR2(40) | NOT NULL |  |
| 4 | `INTERCHANGE_CONTROL_NUMBER` | NUMBER(9,0) | NOT NULL |  |
| 5 | `GROUP_CONTROL_NUMBER` | NUMBER(9,0) | NOT NULL |  |
| 6 | `TRANSACTION_TIME` | DATE | NOT NULL |  |
| 7 | `CUSTOMER_SENT_TO` | VARCHAR2(40) |  |  |
| 8 | `EDI_FILE_NAME` | VARCHAR2(40) | NOT NULL |  |
| 9 | `FA_RECEIVE_STATUS` | NUMBER(2,0) |  |  |
| 10 | `EDI_FILE_RAW` | LONG RAW |  |  |
| 11 | `CUSTOMER_ID` | NUMBER(8,0) |  |  |
| 12 | `SET_CONTROL_NUM` | NUMBER(9,0) |  |  |
| 13 | `TRANSACTION_TYPE_ID` | VARCHAR2(10) |  |  |
| 14 | `FA_RECEIVED_TIME` | VARCHAR2(40) |  |  |
| 15 | `FA_RECEIVED_FILE_NAME` | VARCHAR2(50) |  |  |

- **PK:** `EDI_FILE_ID`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `PK_OUTBOUND_EDI_TRANSACTION`: `EDI_FILE_ID`

### PACKAGING

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PACKAGING_CODE` 🔑 | CHAR(8) | NOT NULL |  |
| 2 | `PACKAGING_DESC` | VARCHAR2(50) |  |  |

- **PK:** `PACKAGING_CODE`
- **Index** unique `SYS_C0036606`: `PACKAGING_CODE`

### PARALLELOGRAM

_~13 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `P_LENGTH` | NUMBER(10,5) |  |  |
| 4 | `P_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 5 | `P_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 6 | `P_WIDTH` | NUMBER(10,5) |  |  |
| 7 | `P_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 8 | `P_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 9 | `P_ANGLE1` | NUMBER(10,5) |  |  |
| 10 | `P_ANGLE2` | NUMBER(10,5) |  |  |
| 11 | `P_DIE1` | VARCHAR2(18) |  |  |
| 12 | `P_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKPARALLELOGRAM`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### PARTS

_~762 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PARTS_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PARTS_CATEGORIES_ID` | NUMBER(4,0) |  |  |
| 3 | `UNITS` | VARCHAR2(32) |  |  |
| 4 | `PARTS_STATUS` | VARCHAR2(32) |  |  |
| 5 | `INTERNAL_ID` | VARCHAR2(64) | NOT NULL |  |
| 6 | `LOCATION` | VARCHAR2(32) |  |  |
| 7 | `FNUM` | NUMBER(8,0) |  |  |
| 8 | `DESCRIPTION` | VARCHAR2(128) |  |  |
| 9 | `VALUEEA` | NUMBER(8,2) |  |  |
| 10 | `QTYONHAND` | NUMBER(8,0) |  |  |
| 11 | `STOCKVALUE` | NUMBER(8,2) |  |  |
| 12 | `MAXLEVEL` | NUMBER(8,0) |  |  |
| 13 | `QTYONORDER` | NUMBER(8,0) |  |  |
| 14 | `QTYONBACKORDER` | NUMBER(8,0) |  |  |
| 15 | `LASTORDERNUM` | NUMBER(8,0) |  |  |
| 16 | `LASTORDERDATE` | DATE |  |  |
| 17 | `LASTQTYORDERED` | NUMBER(8,0) |  |  |
| 18 | `LASTQTYRECEIVED` | NUMBER(8,0) |  |  |
| 19 | `LASTRECEIVEDDATE` | DATE |  |  |
| 20 | `LEADTIME` | NUMBER(4,0) |  |  |
| 21 | `PARTS_ENTERED_DATE` | DATE | NOT NULL |  |
| 22 | `PARTS_ENTERED_BY` | VARCHAR2(64) |  |  |
| 23 | `PARTS_NOTES` | VARCHAR2(512) |  |  |
| 24 | `SPTEXT` | VARCHAR2(64) |  |  |
| 25 | `SPYESNO` | NUMBER(2,0) |  |  |
| 26 | `SPNUMBER` | VARCHAR2(64) |  |  |
| 27 | `SPDATE` | DATE |  |  |
| 28 | `PARTS_VIEW` | BLOB |  |  |
| 29 | `VENDOR_PART_NUMBER` | VARCHAR2(128) |  |  |
| 30 | `REORDERPOINT` | NUMBER(8,0) |  |  |
| 31 | `MANUFACTURE` | VARCHAR2(64) |  |  |
| 32 | `MANUF_PART_NUM` | VARCHAR2(128) |  |  |

- **PK:** `PARTS_ID`
- **FK:** (`PARTS_CATEGORIES_ID`) → `PARTS_CATEGORIES` (`PARTS_CATEGORIES_ID`)
- **FK:** (`UNITS`) → `PARTS_UNIT` (`UNITS`)
- **FK:** (`PARTS_STATUS`) → `PARTS_STATUS` (`PARTS_STATUS`)
- **Index** unique `SYS_C0036608`: `PARTS_ID`

### PARTS_CATEGORIES

_~21 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PARTS_CATEGORIES_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `PARTS_CATEGORY` | VARCHAR2(64) | NOT NULL |  |

- **PK:** `PARTS_CATEGORIES_ID`
- **Index** unique `SYS_C0036609`: `PARTS_CATEGORIES_ID`

### PARTS_NAMING_CONVENTION

_~335 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PARTS_NAMING_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `NAMING_AREA` | VARCHAR2(128) | NOT NULL |  |
| 3 | `TITLE` | VARCHAR2(256) | NOT NULL |  |
| 4 | `ABBREVIATION` | VARCHAR2(16) | NOT NULL |  |
| 5 | `NOTES` | VARCHAR2(128) |  |  |

- **PK:** `PARTS_NAMING_ID`
- **Index** unique `SYS_C0036610`: `PARTS_NAMING_ID`

### PARTS_STATUS

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PARTS_STATUS` 🔑 | VARCHAR2(32) | NOT NULL |  |

- **PK:** `PARTS_STATUS`
- **Index** unique `SYS_C0036611`: `PARTS_STATUS`

### PARTS_SUPPLIERS

_~762 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SUPPLIER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PARTS_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SUPPLIER_PARTS_STATUS` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 4 | `STATUS_CHANGE_DATE` 🔑 | DATE | NOT NULL |  |

- **PK:** `SUPPLIER_ID`, `PARTS_ID`, `SUPPLIER_PARTS_STATUS`, `STATUS_CHANGE_DATE`
- **FK:** (`PARTS_ID`) → `PARTS` (`PARTS_ID`)
- **FK:** (`SUPPLIER_ID`) → `SUPPLIERS` (`SUPPLIER_ID`)
- **Index** unique `SYS_C0036612`: `SUPPLIER_ID`, `PARTS_ID`, `SUPPLIER_PARTS_STATUS`, `STATUS_CHANGE_DATE`

### PARTS_UNIT

_~16 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `UNITS` 🔑 | VARCHAR2(32) | NOT NULL |  |

- **PK:** `UNITS`
- **Index** unique `SYS_C0036613`: `UNITS`

### PART_NUM

_~9,856 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 3 | `ENDUSER_ID` | NUMBER(8,0) |  |  |
| 4 | `ENDUSER_PART_NUM` | VARCHAR2(22) |  |  |
| 5 | `SHEET_TYPE` | CHAR(18) |  |  |
| 6 | `ALLOY` | VARCHAR2(8) |  |  |
| 7 | `TEMPER` | VARCHAR2(8) |  |  |
| 8 | `GAUGE` | NUMBER(6,5) |  |  |
| 9 | `GAUGE_P` | NUMBER(6,6) |  |  |
| 10 | `GAUGE_M` | NUMBER(6,6) |  |  |
| 11 | `PACKAGING_SPEC1` | VARCHAR2(100) |  |  |
| 12 | `PACKAGING_SPEC2` | VARCHAR2(100) |  |  |
| 13 | `PACKAGING_SPEC3` | VARCHAR2(100) |  |  |
| 14 | `PACKAGING_SPEC4` | VARCHAR2(100) |  |  |
| 15 | `PACKAGING_SPEC5` | VARCHAR2(100) |  |  |
| 16 | `PACKAGING_SPEC6` | VARCHAR2(100) |  |  |
| 17 | `PACKAGING_SPEC7` | VARCHAR2(100) |  |  |
| 18 | `PACKAGING_BANDS` | VARCHAR2(100) |  |  |
| 19 | `PACKAGING_OTHER_SPEC` | VARCHAR2(100) |  |  |
| 20 | `DIE_1` | NUMBER(4,0) |  |  |
| 21 | `DIE_2` | NUMBER(4,0) |  |  |
| 22 | `ITEM_STATUS` | NUMBER(2,0) | NOT NULL |  |
| 23 | `ITEM_NOTE` | VARCHAR2(255) |  |  |
| 24 | `ITEM_DESC` | VARCHAR2(255) |  |  |
| 25 | `SUPPLIER_CODE` | NUMBER(8,0) |  |  |
| 26 | `MATERIAL_END_USE` | VARCHAR2(255) |  |  |
| 27 | `MAX_SKID_WT` | NUMBER(8,0) |  |  |
| 28 | `SH_TOLERANCE_MINUS` | NUMBER(8,0) |  |  |
| 29 | `SURFACE` | VARCHAR2(255) |  |  |
| 30 | `SH_TOLERANCE_PLUS` | NUMBER(8,0) |  |  |
| 31 | `FLATNESS` | VARCHAR2(255) |  |  |
| 32 | `OIL_STENCIL_INTERLEAVE` | VARCHAR2(255) |  |  |
| 33 | `PROCESSING_OTHER_SPEC` | VARCHAR2(255) |  |  |
| 34 | `THEORETICAL_UNIT_WT` | NUMBER(8,5) |  |  |
| 35 | `PIECES_SKID` | NUMBER(6,0) |  |  |
| 36 | `PIECES_SKID_PLUS` | NUMBER(6,0) |  |  |
| 37 | `PIECES_SKID_MINUS` | NUMBER(6,0) |  |  |
| 38 | `ITEM_ATTACHMENTS` | VARCHAR2(255) |  |  |
| 39 | `GOVT_CONTRACT_NUM` | VARCHAR2(32) |  |  |
| 40 | `STACKS_SKID` | NUMBER(2,0) |  |  |
| 41 | `AUTOPARTS` | NUMBER(1,0) |  |  |
| 42 | `SECTOR` | NUMBER(3,0) |  |  |
| 43 | `TRIMMED_WIDTH_OVERRIDDEN` | CHAR(1) |  |  |
| 44 | `TRIMMED_WIDTH_OVERRIDE_USER` | VARCHAR2(30) |  |  |
| 45 | `TRIMMED_COIL_WIDTH` | NUMBER(8,3) |  |  |
| 46 | `INCOMING_COIL_WIDTH` | NUMBER(8,3) |  |  |
| 47 | `TRIM_TYPE_CODE` | NUMBER |  |  |
| 48 | `TRIMMING_REQUIRED` | CHAR(1) |  |  |
| 49 | `DIMPLING_CODE` | NUMBER(2,0) |  |  |
| 50 | `SPECIAL_PART` | CHAR(1) |  |  |
| 51 | `DIE_ID` | NUMBER(4,0) |  |  |
| 52 | `LINE_NUM` | NUMBER(2,0) |  |  |
| 53 | `SPM` | NUMBER(4,0) |  |  |
| 54 | `EFFICIENCY_PERCENT` | NUMBER(3,0) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`DIE_1`) → `DIE` (`DIE_ID`)
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`DIE_2`) → `DIE` (`DIE_ID`)
- **FK:** (`ENDUSER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036614`: `PART_NUM_ID`

### PART_NUM_CHEVRON

_~231 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CH_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `CH_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 4 | `CH_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 5 | `CH_WIDTH` | NUMBER(10,5) |  |  |
| 6 | `CH_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 7 | `CH_WIDTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036615`: `PART_NUM_ID`

### PART_NUM_CIRCLE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `C_DIAMETER` | NUMBER(10,5) |  |  |
| 3 | `C_DIAMETER_PLUS` | NUMBER(6,6) |  |  |
| 4 | `C_DIAMETER_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036616`: `PART_NUM_ID`

### PART_NUM_FENDER

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `FE_SIDE` | NUMBER(10,5) |  |  |
| 3 | `FE_SIDE_PLUS` | NUMBER(6,6) |  |  |
| 4 | `FE_SIDE_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036617`: `PART_NUM_ID`

### PART_NUM_LEFT_TRAPEZOID

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LTR_LONG_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `LTR_LONG_PLUS` | NUMBER(6,6) |  |  |
| 4 | `LTR_LONG_MINUS` | NUMBER(6,6) |  |  |
| 5 | `LTR_SHORT_LENGTH` | NUMBER(10,5) |  |  |
| 6 | `LTR_SHORT_PLUS` | NUMBER(6,6) |  |  |
| 7 | `LTR_SHORT_MINUS` | NUMBER(6,6) |  |  |
| 8 | `LTR_WIDTH` | NUMBER(10,5) |  |  |
| 9 | `LTR_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 10 | `LTR_WIDTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036618`: `PART_NUM_ID`

### PART_NUM_LIFTGATE

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LI_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `LI_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 4 | `LI_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 5 | `LI_WIDTH` | NUMBER(10,5) |  |  |
| 6 | `LI_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 7 | `LI_WIDTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036619`: `PART_NUM_ID`

### PART_NUM_PARALLELOGRAM

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `P_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `P_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 4 | `P_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 5 | `P_WIDTH` | NUMBER(10,5) |  |  |
| 6 | `P_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 7 | `P_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 8 | `P_ANGLE1` | NUMBER(10,5) |  |  |
| 9 | `P_ANGLE2` | NUMBER(10,5) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036620`: `PART_NUM_ID`

### PART_NUM_RECTANGLE

_~3,813 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `RT_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `RT_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 4 | `RT_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 5 | `RT_WIDTH` | NUMBER(10,5) |  |  |
| 6 | `RT_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 7 | `RT_WIDTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036621`: `PART_NUM_ID`

### PART_NUM_REINFORCEMENT

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `RE_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `RE_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 4 | `RE_LENGHT_MINUS` | NUMBER(6,6) |  |  |
| 5 | `RE_WIDTH` | NUMBER(10,5) |  |  |
| 6 | `RE_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 7 | `RE_WIDTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036622`: `PART_NUM_ID`

### PART_NUM_RIGHT_TRAPEZOID

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `RTR_LONG_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `RTR_LONG_PLUS` | NUMBER(6,6) |  |  |
| 4 | `RTR_LONG_MINUS` | NUMBER(6,6) |  |  |
| 5 | `RTR_SHORT_LENGTH` | NUMBER(10,5) |  |  |
| 6 | `RTR_SHORT_PLUS` | NUMBER(6,6) |  |  |
| 7 | `RTR_SHORT_MINUS` | NUMBER(6,6) |  |  |
| 8 | `RTR_WIDTH` | NUMBER(10,5) |  |  |
| 9 | `RTR_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 10 | `RTR_WIDTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036623`: `PART_NUM_ID`

### PART_NUM_TRAPEZOID

_~96 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `TR_LONG_LENGTH` | NUMBER(10,5) |  |  |
| 3 | `TR_LONG_PLUS` | NUMBER(6,6) |  |  |
| 4 | `TR_LONG_MINUS` | NUMBER(6,6) |  |  |
| 5 | `TR_SHORT_LENGTH` | NUMBER(10,5) |  |  |
| 6 | `TR_SHORT_PLUS` | NUMBER(6,6) |  |  |
| 7 | `TR_SHORT_MINUS` | NUMBER(6,6) |  |  |
| 8 | `TR_WIDTH` | NUMBER(10,5) |  |  |
| 9 | `TR_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 10 | `TR_WIDTH_MINUS` | NUMBER(6,6) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036624`: `PART_NUM_ID`

### PART_NUM_X1_SHAPE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `X_1` | NUMBER(10,5) |  |  |
| 3 | `X_2` | NUMBER(10,5) |  |  |
| 4 | `X_3` | NUMBER(10,5) |  |  |
| 5 | `X_4` | NUMBER(10,5) |  |  |
| 6 | `X_5` | NUMBER(10,5) |  |  |
| 7 | `X_6` | NUMBER(10,5) |  |  |
| 8 | `X_7` | NUMBER(10,5) |  |  |
| 9 | `X_8` | NUMBER(10,5) |  |  |
| 10 | `X_9` | NUMBER(10,5) |  |  |
| 11 | `X_10` | NUMBER(10,5) |  |  |
| 12 | `X_11` | NUMBER(10,5) |  |  |
| 13 | `X_12` | NUMBER(10,5) |  |  |

- **PK:** `PART_NUM_ID`
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **Index** unique `SYS_C0036625`: `PART_NUM_ID`

### PBCATCOL

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PBC_TNAM` | CHAR(31) | NOT NULL |  |
| 2 | `PBC_TID` | FLOAT |  |  |
| 3 | `PBC_OWNR` | CHAR(31) | NOT NULL |  |
| 4 | `PBC_CNAM` | CHAR(31) | NOT NULL |  |
| 5 | `PBC_CID` | FLOAT |  |  |
| 6 | `PBC_LABL` | VARCHAR2(254) |  |  |
| 7 | `PBC_LPOS` | FLOAT |  |  |
| 8 | `PBC_HDR` | VARCHAR2(254) |  |  |
| 9 | `PBC_HPOS` | FLOAT |  |  |
| 10 | `PBC_JTFY` | FLOAT |  |  |
| 11 | `PBC_MASK` | VARCHAR2(31) |  |  |
| 12 | `PBC_CASE` | FLOAT |  |  |
| 13 | `PBC_HGHT` | FLOAT |  |  |
| 14 | `PBC_WDTH` | FLOAT |  |  |
| 15 | `PBC_PTRN` | VARCHAR2(31) |  |  |
| 16 | `PBC_BMAP` | CHAR(1) |  |  |
| 17 | `PBC_INIT` | VARCHAR2(254) |  |  |
| 18 | `PBC_CMNT` | VARCHAR2(254) |  |  |
| 19 | `PBC_EDIT` | VARCHAR2(31) |  |  |
| 20 | `PBC_TAG` | VARCHAR2(254) |  |  |

- **Index** unique `PBCATC_X`: `PBC_TNAM`, `PBC_OWNR`, `PBC_CNAM`

### PBCATEDT

_~21 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PBE_NAME` | VARCHAR2(30) | NOT NULL |  |
| 2 | `PBE_EDIT` | VARCHAR2(254) |  |  |
| 3 | `PBE_TYPE` | FLOAT |  |  |
| 4 | `PBE_CNTR` | FLOAT |  |  |
| 5 | `PBE_SEQN` | FLOAT | NOT NULL |  |
| 6 | `PBE_FLAG` | FLOAT |  |  |
| 7 | `PBE_WORK` | CHAR(32) |  |  |

- **Index** unique `PBCATE_X`: `PBE_NAME`, `PBE_SEQN`

### PBCATFMT

_~20 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PBF_NAME` | VARCHAR2(30) | NOT NULL |  |
| 2 | `PBF_FRMT` | VARCHAR2(254) |  |  |
| 3 | `PBF_TYPE` | FLOAT |  |  |
| 4 | `PBF_CNTR` | FLOAT |  |  |

- **Index** unique `PBCATF_X`: `PBF_NAME`

### PBCATTBL

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PBT_TNAM` | CHAR(31) | NOT NULL |  |
| 2 | `PBT_TID` | FLOAT |  |  |
| 3 | `PBT_OWNR` | CHAR(31) | NOT NULL |  |
| 4 | `PBD_FHGT` | FLOAT |  |  |
| 5 | `PBD_FWGT` | FLOAT |  |  |
| 6 | `PBD_FITL` | CHAR(1) |  |  |
| 7 | `PBD_FUNL` | CHAR(1) |  |  |
| 8 | `PBD_FCHR` | FLOAT |  |  |
| 9 | `PBD_FPTC` | FLOAT |  |  |
| 10 | `PBD_FFCE` | CHAR(18) |  |  |
| 11 | `PBH_FHGT` | FLOAT |  |  |
| 12 | `PBH_FWGT` | FLOAT |  |  |
| 13 | `PBH_FITL` | CHAR(1) |  |  |
| 14 | `PBH_FUNL` | CHAR(1) |  |  |
| 15 | `PBH_FCHR` | FLOAT |  |  |
| 16 | `PBH_FPTC` | FLOAT |  |  |
| 17 | `PBH_FFCE` | CHAR(18) |  |  |
| 18 | `PBL_FHGT` | FLOAT |  |  |
| 19 | `PBL_FWGT` | FLOAT |  |  |
| 20 | `PBL_FITL` | CHAR(1) |  |  |
| 21 | `PBL_FUNL` | CHAR(1) |  |  |
| 22 | `PBL_FCHR` | FLOAT |  |  |
| 23 | `PBL_FPTC` | FLOAT |  |  |
| 24 | `PBL_FFCE` | CHAR(18) |  |  |
| 25 | `PBT_CMNT` | VARCHAR2(254) |  |  |

- **Index** unique `PBCATT_X`: `PBT_TNAM`, `PBT_OWNR`

### PBCATVLD

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PBV_NAME` | VARCHAR2(30) | NOT NULL |  |
| 2 | `PBV_VALD` | VARCHAR2(254) |  |  |
| 3 | `PBV_TYPE` | FLOAT |  |  |
| 4 | `PBV_CNTR` | FLOAT |  |  |
| 5 | `PBV_MSG` | VARCHAR2(254) |  |  |

- **Index** unique `PBCATV_X`: `PBV_NAME`

### PLAN_TABLE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `STATEMENT_ID` | VARCHAR2(30) |  |  |
| 2 | `TIMESTAMP` | DATE |  |  |
| 3 | `REMARKS` | VARCHAR2(80) |  |  |
| 4 | `OPERATION` | VARCHAR2(30) |  |  |
| 5 | `OPTIONS` | VARCHAR2(30) |  |  |
| 6 | `OBJECT_NODE` | VARCHAR2(128) |  |  |
| 7 | `OBJECT_OWNER` | VARCHAR2(30) |  |  |
| 8 | `OBJECT_NAME` | VARCHAR2(30) |  |  |
| 9 | `OBJECT_INSTANCE` | NUMBER |  |  |
| 10 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 11 | `OPTIMIZER` | VARCHAR2(255) |  |  |
| 12 | `SEARCH_COLUMNS` | NUMBER |  |  |
| 13 | `ID` | NUMBER |  |  |
| 14 | `PARENT_ID` | NUMBER |  |  |
| 16 | `COST` | NUMBER |  |  |
| 17 | `CARDINALITY` | NUMBER |  |  |
| 18 | `BYTES` | NUMBER |  |  |
| 19 | `OTHER_TAG` | VARCHAR2(255) |  |  |
| 20 | `OTHER` | LONG |  |  |


### PM

_~77 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PMSHIFT` | VARCHAR2(32) |  |  |
| 3 | `TITLECRAFT_ID` | NUMBER(8,0) |  |  |
| 4 | `MAINT_FREQ` | VARCHAR2(32) |  |  |
| 5 | `ITEMDEVICE_ID` | NUMBER(8,0) |  |  |
| 6 | `SUBSYSEQUIPMENT_ID` | NUMBER(8,0) |  |  |
| 7 | `SYSEQUIPMENT_ID` | NUMBER(8,0) |  |  |
| 8 | `GROUPDEPARTMENT_ID` | NUMBER(8,0) |  |  |
| 9 | `ASSIGNEDTOGROUP` | VARCHAR2(64) |  |  |
| 10 | `PM_STATUS` | NUMBER(2,0) |  |  |
| 11 | `PM_NOTICE` | VARCHAR2(1024) |  |  |
| 12 | `PM_COMPLETED` | DATE |  |  |
| 13 | `COMPLETED_BY` | VARCHAR2(64) |  |  |
| 14 | `MINS_PER_UNIT` | NUMBER(8,3) |  |  |
| 15 | `NUM_OF_UNITS` | NUMBER(4,0) |  |  |
| 16 | `NUMOFTIMESPERYEAR` | NUMBER(4,0) |  |  |
| 17 | `PMRANGE` | NUMBER(4,0) |  |  |
| 18 | `DAYSBETWEEN` | NUMBER(6,2) |  |  |
| 19 | `LASTUPDATE` | DATE |  |  |
| 20 | `LASTREADDATE` | DATE |  |  |
| 21 | `NEXTDUEDATE` | DATE |  |  |
| 22 | `NUMOVERDUE` | NUMBER(8,0) |  |  |
| 23 | `NUMOVERDUERESETDATE` | DATE |  |  |
| 24 | `PM_REPEAT` | NUMBER(4,0) |  |  |
| 25 | `NEXTDUEREADING` | NUMBER(4,0) |  |  |
| 26 | `COMPLETEDREADING` | NUMBER(6,0) |  |  |
| 27 | `LASTREADING` | NUMBER(6,0) |  |  |
| 28 | `LOWREPEAT` | NUMBER(4,0) |  |  |
| 29 | `MIDREPEAT` | NUMBER(4,0) |  |  |
| 30 | `HIGNREPEAT` | NUMBER(4,0) |  |  |
| 31 | `PMREFERENCE` | VARCHAR2(1024) |  |  |
| 32 | `PM_COST` | NUMBER(8,2) |  |  |
| 33 | `AUTHOR` | VARCHAR2(64) |  |  |
| 34 | `SCRIBE` | VARCHAR2(32) |  |  |
| 35 | `ADDEDPMHOURS` | NUMBER(8,2) |  |  |
| 36 | `PM_ENTERED` | DATE | NOT NULL |  |
| 37 | `HASIMAGE` | NUMBER(1,0) | NOT NULL |  |
| 38 | `IMAGE_PATH` | VARCHAR2(128) |  |  |
| 39 | `SPTEXT` | VARCHAR2(64) |  |  |
| 40 | `SPYESNO` | NUMBER(1,0) |  |  |
| 41 | `SPNUMBER` | NUMBER(8,0) |  |  |
| 42 | `SPDATETIME` | DATE |  |  |
| 43 | `DISPLAY_STYLE` | NUMBER(2,0) |  |  |
| 44 | `PM_ACTION_HEADER` | VARCHAR2(1024) |  |  |
| 45 | `PM_ACTION_TAILER` | VARCHAR2(1024) |  |  |

- **PK:** `PM_ID`
- **FK:** (`TITLECRAFT_ID`) → `TITLECRAFT` (`TITLECRAFT_ID`)
- **FK:** (`MAINT_FREQ`) → `MAINT_FREQUENCY` (`MAINT_FREQ`)
- **FK:** (`ITEMDEVICE_ID`) → `ITEMDEVICE` (`ITEMDEVICE_ID`)
- **FK:** (`SUBSYSEQUIPMENT_ID`) → `SUBSYSTEMEQUIPMENT` (`SUBSYSEQUIPMENT_ID`)
- **FK:** (`SYSEQUIPMENT_ID`) → `SYSTEMEQUIPMENT` (`SYSEQUIPMENT_ID`)
- **FK:** (`GROUPDEPARTMENT_ID`) → `GROUPDEPARTMENT` (`GROUPDEPARTMENT_ID`)
- **FK:** (`PMSHIFT`) → `PMSHIFT` (`PMSHIFT`)
- **Index** unique `SYS_C0036626`: `PM_ID`

### PMACTIONPHRASES

_~31 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PMACTIONPHRASES` 🔑 | VARCHAR2(128) | NOT NULL |  |

- **PK:** `PMACTIONPHRASES`
- **Index** unique `SYS_C0036627`: `PMACTIONPHRASES`

### PMCOMPLETIONDETAILS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PMCOMPLETION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `ACTION_ITEMS` | VARCHAR2(128) | NOT NULL |  |
| 3 | `ITEM_DETAILS` | NUMBER(8,0) | NOT NULL |  |
| 4 | `ITEMCHECKED` | NUMBER(1,0) |  |  |
| 5 | `ITEM_NOTES` | VARCHAR2(1024) |  |  |

- **PK:** `PMCOMPLETION_ID`
- **FK:** (`PMCOMPLETION_ID`) → `PMCOMPLETIONS` (`PMCOMPLETION_ID`)
- **Index** unique `SYS_C0036628`: `PMCOMPLETION_ID`

### PMCOMPLETIONS

_~2,051 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PMCOMPLETION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `ITEMDEVICE_ID` | NUMBER(8,0) |  |  |
| 3 | `SUBSYSEQUIPMENT_ID` | NUMBER(8,0) |  |  |
| 4 | `SYSEQUIPMENT_ID` | NUMBER(8,0) |  |  |
| 5 | `GROUPDEPARTMENT_ID` | NUMBER(8,0) |  |  |
| 6 | `PM_ID` | NUMBER(8,0) |  |  |
| 7 | `PM_STATUS` | NUMBER(2,0) | NOT NULL |  |
| 8 | `COMPLETEDDATE` | DATE | NOT NULL |  |
| 9 | `ASSIGNEDTOGROUP` | VARCHAR2(64) | NOT NULL |  |
| 10 | `COMPLETEDBY` | VARCHAR2(64) | NOT NULL |  |
| 11 | `COMPLETED_NOTES` | VARCHAR2(1024) |  |  |
| 12 | `RECORDEDDATE` | DATE |  |  |

- **PK:** `PMCOMPLETION_ID`
- **FK:** (`ITEMDEVICE_ID`) → `ITEMDEVICE` (`ITEMDEVICE_ID`)
- **FK:** (`SUBSYSEQUIPMENT_ID`) → `SUBSYSTEMEQUIPMENT` (`SUBSYSEQUIPMENT_ID`)
- **FK:** (`SYSEQUIPMENT_ID`) → `SYSTEMEQUIPMENT` (`SYSEQUIPMENT_ID`)
- **FK:** (`GROUPDEPARTMENT_ID`) → `GROUPDEPARTMENT` (`GROUPDEPARTMENT_ID`)
- **FK:** (`PM_ID`) → `PM` (`PM_ID`)
- **Index** unique `SYS_C0036629`: `PMCOMPLETION_ID`

### PMCOMPLETIONS_STAFF_USED

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PMCOMPLETION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `EMPLOYEE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `HOURS_USED` | NUMBER(6,2) |  |  |
| 4 | `HOURLY_RATE` | NUMBER(6,2) |  |  |

- **PK:** `PMCOMPLETION_ID`, `EMPLOYEE_ID`
- **FK:** (`EMPLOYEE_ID`) → `EMPLOYEES` (`EMPLOYEE_ID`)
- **FK:** (`PMCOMPLETION_ID`) → `PMCOMPLETIONS` (`PMCOMPLETION_ID`)
- **Index** unique `SYS_C0036630`: `PMCOMPLETION_ID`, `EMPLOYEE_ID`

### PMCOMPLETION_PARTS_USED

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PMCOMPLETION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PARTS_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `QTY_USED` | NUMBER(6,2) | NOT NULL |  |
| 4 | `VALUEEA` | NUMBER(8,2) | NOT NULL |  |
| 5 | `PARTUSED_NOTES` | VARCHAR2(512) |  |  |
| 6 | `DATETAKEN` | DATE | NOT NULL |  |
| 7 | `TAKENBY` | VARCHAR2(64) | NOT NULL |  |

- **PK:** `PMCOMPLETION_ID`, `PARTS_ID`
- **FK:** (`PARTS_ID`) → `PARTS` (`PARTS_ID`)
- **FK:** (`PMCOMPLETION_ID`) → `PMCOMPLETIONS` (`PMCOMPLETION_ID`)
- **Index** unique `SYS_C0036631`: `PMCOMPLETION_ID`, `PARTS_ID`

### PMINFOPHRASES

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PMINFOPHRASES` 🔑 | VARCHAR2(256) | NOT NULL |  |

- **PK:** `PMINFOPHRASES`
- **Index** unique `SYS_C0036632`: `PMINFOPHRASES`

### PMPARTSREQUIRED

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PARTS_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `QTY` | NUMBER(6,2) | NOT NULL |  |
| 4 | `PMPARTS_NOTES` | VARCHAR2(512) |  |  |

- **PK:** `PARTS_ID`, `PM_ID`
- **FK:** (`PM_ID`) → `PM` (`PM_ID`)
- **FK:** (`PARTS_ID`) → `PARTS` (`PARTS_ID`)
- **Index** unique `SYS_C0036633`: `PARTS_ID`, `PM_ID`

### PMSHIFT

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PMSHIFT` 🔑 | VARCHAR2(32) | NOT NULL |  |

- **PK:** `PMSHIFT`
- **Index** unique `SYS_C0036634`: `PMSHIFT`

### PM_ACTIONS

_~1,618 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PM_ACTION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PM_ID` | NUMBER(8,0) | NOT NULL |  |
| 3 | `ACTION_ITEMS` | VARCHAR2(1024) |  |  |
| 4 | `ITEM_DETAILS` | VARCHAR2(1024) |  |  |
| 5 | `ITEM_VIEW` | BLOB |  |  |

- **PK:** `PM_ACTION_ID`
- **FK:** (`PM_ID`) → `PM` (`PM_ID`)
- **Index** unique `SYS_C0036635`: `PM_ACTION_ID`

### PM_STATUS

_~5 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PM_STATUS_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PM_STATUS` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `PM_STATUS_ID`
- **Index** unique `SYS_C0036636`: `PM_STATUS_ID`

### PROCESSING_STRING_863

_~46,251 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SAMPLE_ID` 🔑 | VARCHAR2(20) | NOT NULL |  |
| 2 | `TEST_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `SEND_STATUS` | NUMBER(1,0) | NOT NULL |  |
| 4 | `DATA_STRING` | VARCHAR2(2000) | NOT NULL |  |
| 5 | `COIL_ORG_NUM` | VARCHAR2(32) | NOT NULL |  |
| 6 | `CREATED_DATE` | DATE |  |  |
| 7 | `TEST_TYPE` | NUMBER(1,0) |  |  |

- **PK:** `SAMPLE_ID`, `TEST_NUM`
- **Index** unique `PROCESSING_STRING_863_PK`: `SAMPLE_ID`, `TEST_NUM`

### PROCESS_COIL

_~183,495 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `PROCESS_COIL_STATUS` | NUMBER(4,0) |  |  |
| 4 | `PROCESS_QUANTITY` | NUMBER(8,0) | NOT NULL |  |
| 5 | `PROCESS_DATE` | DATE |  |  |
| 6 | `SHIFT_PROCESS_STATUS` | NUMBER(4,0) |  |  |
| 7 | `CURRENT_WT` | NUMBER(8,0) |  |  |
| 8 | `PROCESS_END_WT` | NUMBER(8,0) |  |  |
| 9 | `SCRAP_870_DATE` | DATE |  |  |

- **PK:** `COIL_ABC_NUM`, `AB_JOB_NUM`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **Index** unique `XPKPROCESS_COIL`: `COIL_ABC_NUM`, `AB_JOB_NUM`

### PROCESS_COIL_STATUS

_~11 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_COIL_STATUS_CODE` 🔑 | NUMBER | NOT NULL |  |
| 2 | `PROCESS_COIL_STATUS_DESC` | VARCHAR2(50) |  |  |

- **PK:** `PROCESS_COIL_STATUS_CODE`
- **Index** unique `PROCESS_COIL_STATUS`: `PROCESS_COIL_STATUS_CODE`

### PROCESS_COIL_TRACK

_~48,265 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `PROCESS_COIL_TRACK_DATE` 🔑 | DATE | NOT NULL |  |
| 4 | `PROCESS_COIL_PRE_STATUS` | NUMBER(4,0) |  |  |
| 5 | `PROCESS_COIL_CUR_STATUS` | NUMBER(4,0) |  |  |
| 6 | `PROCESS_QUANTITY_PRE_NETWT` | NUMBER(8,0) |  |  |
| 7 | `PROCESS_QUANTITY_CUR_NETWT` | NUMBER(8,0) |  |  |
| 8 | `PROCESS_COIL_MODIFIED_BY` | VARCHAR2(64) |  |  |

- **PK:** `COIL_ABC_NUM`, `AB_JOB_NUM`, `PROCESS_COIL_TRACK_DATE`
- **Index** unique `PROCESS_COIL_TRACK_PK1`: `COIL_ABC_NUM`, `AB_JOB_NUM`, `PROCESS_COIL_TRACK_DATE`

### PROCESS_PARTIAL_SKID

_~8,335 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `PARTIAL_SKID_AB_JOB_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `PARTIAL_SHEET_NET_WT` | NUMBER(8,0) |  |  |
| 5 | `PARTIAL_SKID_LOCATION` | VARCHAR2(18) |  |  |
| 6 | `PARTIAL_SKID_DATE` | DATE |  |  |
| 7 | `PARTIAL_SKID_PIECES` | NUMBER(6,0) |  |  |
| 8 | `PARTIAL_SHEET_THEORETICAL_WT` | NUMBER(8,0) |  |  |

- **PK:** `AB_JOB_NUM`, `SHEET_SKID_NUM`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`SHEET_SKID_NUM`) → `SHEET_SKID` (`SHEET_SKID_NUM`)
- **Index** unique `XPKPROCESS_PARTIAL_SKID`: `AB_JOB_NUM`, `SHEET_SKID_NUM`

### PRODUCTION_CONTROL_USERS

_~6 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `USER_LAST_NAME` | VARCHAR2(18) |  |  |
| 3 | `USER_FIRST_NAME` | VARCHAR2(18) |  |  |
| 4 | `COMPUTER_ID` | VARCHAR2(64) |  |  |

- **PK:** `USER_ID`
- **Index** unique `PFK_PRODUCTION_CONTROL_USERS`: `USER_ID`

### PRODUCTION_SHEET_ITEM

_~713,835 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROD_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 3 | `AB_JOB_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `PROD_ITEM_STATUS` | NUMBER(2,0) |  |  |
| 5 | `PROD_ITEM_PIECES` | NUMBER(6,0) |  |  |
| 6 | `PROD_ITEM_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 7 | `PROD_ITEM_THEORETICAL_WT` | NUMBER(8,0) |  |  |
| 8 | `PROD_ITEM_EDI870_DATE` | DATE |  |  |
| 9 | `PROD_ITEM_DATE` | DATE |  |  |
| 10 | `PROD_ITEM_NOTE` | VARCHAR2(255) |  |  |
| 11 | `PROD_ITEM_PLACEMENT` | VARCHAR2(18) |  |  |
| 12 | `SHIFT_NUM` | NUMBER(8,0) |  |  |
| 13 | `EDI_FILE_ID_870` | NUMBER(8,0) |  |  |

- **PK:** `PROD_ITEM_NUM`
- **FK:** (`SHIFT_NUM`) → `SHIFT` (`SHIFT_NUM`)
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `XPKPRODUCTION_SHEET_ITEM`: `PROD_ITEM_NUM`

### PRODUCT_TYPE

_~43 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PRODUCT_TYPE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_ID` | NUMBER(8,0) |  |  |
| 3 | `PRODUCT_TYPE` | VARCHAR2(64) | NOT NULL |  |

- **PK:** `PRODUCT_TYPE_ID`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036768`: `PRODUCT_TYPE_ID`

### PROD_ITEM_STATUS

_~21 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROD_ITEM_STATUS_CODE` | NUMBER |  |  |
| 2 | `PROD_ITEM_STATUS_DESC` | VARCHAR2(50) |  |  |

- **Index** `IDX1_PROD_ITEM_STATUS`: `PROD_ITEM_STATUS_CODE`

### PROD_SHEET_ITEM_TRACK

_~22,230 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROD_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LOG_DATE` 🔑 | DATE | NOT NULL |  |
| 3 | `PRE_NET_WT` | NUMBER(8,0) |  |  |
| 4 | `CUR_NET_WT` | NUMBER(8,0) |  |  |
| 5 | `MODIFIED_BY` | VARCHAR2(32) | NOT NULL |  |
| 6 | `RECORD_DELETED` | NUMBER(1,0) |  |  |
| 7 | `PRE_PIECES` | NUMBER(8,0) |  |  |
| 8 | `CUR_PIECES` | NUMBER(8,0) |  |  |
| 9 | `PRE_THEO_WT` | NUMBER(8,0) |  |  |
| 10 | `CUR_THEO_WT` | NUMBER(8,0) |  |  |
| 11 | `PRE_AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 12 | `CUR_AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 13 | `PRE_COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 14 | `CUR_COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 15 | `PRE_STATUS` | NUMBER(4,0) |  |  |
| 16 | `CUR_STATUS` | NUMBER(4,0) |  |  |

- **PK:** `PROD_ITEM_NUM`, `LOG_DATE`
- **Index** unique `SYS_C0036763`: `PROD_ITEM_NUM`, `LOG_DATE`

### PST_TEST_RESULT

_~47,516 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `CREATED_DATE` 🔑 | DATE | NOT NULL |  |
| 4 | `SOURCE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 5 | `TEST_TYPE` | NUMBER(1,0) |  |  |
| 6 | `YTS_VAL` | NUMBER(10,5) |  |  |
| 7 | `UTS_VAL` | NUMBER(10,5) |  |  |
| 8 | `ELONG_VAL` | NUMBER(10,5) |  |  |
| 9 | `R_VAL` | NUMBER(10,8) |  |  |
| 10 | `N_VAL` | NUMBER(10,8) |  |  |
| 11 | `THICKNESS` | NUMBER(10,7) |  |  |
| 12 | `WIDTH` | NUMBER(11,7) |  |  |

- **PK:** `COIL_ABC_NUM`, `POSITION`, `CREATED_DATE`, `SOURCE_ID`
- **Index** unique `SYS_C0036641`: `COIL_ABC_NUM`, `POSITION`, `CREATED_DATE`, `SOURCE_ID`

### QA_ALBL_DEFECT_DISPOSITION

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DISP_CODE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `DISP_DESC` | VARCHAR2(100) | NOT NULL |  |
| 3 | `NOTE` | VARCHAR2(1028) |  |  |

- **PK:** `DISP_CODE`
- **Index** unique `PK_QA_ALBL_DEFECT_DISPOSITION`: `DISP_CODE`

### QA_CUSTOMER_QUALITY_SKID

_~2,248 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 5 | `DEFECT_CODE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 6 | `ALBL_DISP_CODE` | NUMBER(3,0) |  |  |
| 7 | `CUST_DISP_CODE` | NUMBER(3,0) |  |  |
| 8 | `QA_RECORD_DATE` | DATE |  |  |
| 9 | `NOTE` | VARCHAR2(500) |  |  |
| 10 | `USER_ID` | VARCHAR2(50) |  |  |

- **PK:** `CUSTOMER_ID`, `AB_JOB_NUM`, `COIL_ABC_NUM`, `SHEET_SKID_NUM`, `DEFECT_CODE`
- **Index** unique `PK_QA_CUSTOMER_QUALITY_SKID`: `CUSTOMER_ID`, `AB_JOB_NUM`, `COIL_ABC_NUM`, `SHEET_SKID_NUM`, `DEFECT_CODE`

### QA_CUST_DEFECT_DISPOSITION

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `DISP_CODE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 3 | `DISP_DESC` | VARCHAR2(100) | NOT NULL |  |
| 4 | `NOTE` | VARCHAR2(1028) |  |  |

- **PK:** `CUSTOMER_ID`, `DISP_CODE`
- **Index** unique `PK_QA_CUST_DEFECT_DISPOSITION`: `CUSTOMER_ID`, `DISP_CODE`

### QA_DEFECT

_~19 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DEFECT_CODE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `DEFECT_DESC` | VARCHAR2(100) | NOT NULL |  |
| 3 | `NOTE` | VARCHAR2(1028) |  |  |

- **PK:** `DEFECT_CODE`
- **Index** unique `PK_QA_DEFECT`: `DEFECT_CODE`

### QA_EMAIL_GROUP

_~10 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LOGIN_ID` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 2 | `QA_EMAIL_GROUP_ID` 🔑 | NUMBER | NOT NULL |  |
| 3 | `QA_EMAIL_GROUP_NAME` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `LOGIN_ID`, `QA_EMAIL_GROUP_ID`
- **Index** unique `PFK_QA_EMAIL_GROUP`: `LOGIN_ID`, `QA_EMAIL_GROUP_ID`

### QA_EMAIL_GROUP_DETAIL

_~30 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `QA_EMAIL_GROUP_ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `QA_EMAIL_GROUP_DETAIL_ADDRESS` 🔑 | VARCHAR2(128) | NOT NULL |  |

- **PK:** `QA_EMAIL_GROUP_ID`, `QA_EMAIL_GROUP_DETAIL_ADDRESS`
- **Index** unique `PFK_QA_EMAIL_GROUP_DETAIL`: `QA_EMAIL_GROUP_ID`, `QA_EMAIL_GROUP_DETAIL_ADDRESS`

### QR_REQUIRED_CUSTOMERS

_~2 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`
- **Index** unique `PFK_QR_REQUIRED_CUSTOMERS`: `CUSTOMER_ID`

### QUALITY_COIL_EVAL_SCRAP

_~6,954 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SCRAP_ITEM_TYPE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 4 | `SCRAP_ITEM_PIECE` | NUMBER(5,0) |  |  |
| 5 | `SCRAP_ITEM_NET_WT` | NUMBER(8,0) |  |  |
| 6 | `SCRAP_ITEM_NOTE` | VARCHAR2(256) |  |  |
| 7 | `SCRAP_ITEM_OD` 🔑 | NUMBER(1,0) | NOT NULL | 1 |
| 8 | `SCRAP_ITEM_MILL` 🔑 | NUMBER(1,0) | NOT NULL | 1 |
| 9 | `DATA_SOURCE` | VARCHAR2(32) |  |  |

- **PK:** `COIL_ABC_NUM`, `AB_JOB_NUM`, `SCRAP_ITEM_TYPE`, `SCRAP_ITEM_OD`, `SCRAP_ITEM_MILL`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`SCRAP_ITEM_TYPE`) → `SCRAP_TYPE` (`SCRAP_TYPE_ID`)
- **Index** unique `PK_QUALITY_SCRAP_ITEM`: `COIL_ABC_NUM`, `AB_JOB_NUM`, `SCRAP_ITEM_TYPE`, `SCRAP_ITEM_OD`, `SCRAP_ITEM_MILL`

### QUALITY_SCRAP_WORKSHEET

_~6,089 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SCRAP_ITEM_TYPE` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 4 | `SCRAP_ITEM_PIECE` | NUMBER(5,0) |  |  |
| 5 | `SCRAP_ITEM_NET_WT` | NUMBER(8,0) |  |  |
| 6 | `SCRAP_ITEM_NOTE` | VARCHAR2(256) |  |  |
| 7 | `SCRAP_ITEM_OD` 🔑 | NUMBER(1,0) | NOT NULL | 1 |
| 8 | `SCRAP_ITEM_MILL` 🔑 | NUMBER(1,0) | NOT NULL | 1 |
| 9 | `SCRAP_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `COIL_ABC_NUM`, `AB_JOB_NUM`, `SCRAP_ITEM_TYPE`, `SCRAP_ITEM_OD`, `SCRAP_ITEM_MILL`, `SCRAP_SKID_NUM`
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`SCRAP_ITEM_TYPE`) → `SCRAP_TYPE` (`SCRAP_TYPE_ID`)
- **FK:** (`SCRAP_SKID_NUM`) → `SCRAP_SKID` (`SCRAP_SKID_NUM`)
- **Index** unique `PK_QUALITY_SCRAP_ITEM_LINE`: `COIL_ABC_NUM`, `AB_JOB_NUM`, `SCRAP_ITEM_TYPE`, `SCRAP_ITEM_OD`, `SCRAP_ITEM_MILL`, `SCRAP_SKID_NUM`

### QUEST_COM_PRODUCTS

_~2 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PRODUCT_ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `PRODUCT_NAME` | VARCHAR2(30) | NOT NULL |  |
| 3 | `PRODUCT_PREFIX` | VARCHAR2(8) | NOT NULL |  |
| 4 | `INSTALL_USER` | VARCHAR2(30) | NOT NULL |  |
| 5 | `GRANT_PROCEDURE` | VARCHAR2(2000) |  |  |
| 6 | `REVOKE_PROCEDURE` | VARCHAR2(2000) |  |  |
| 7 | `PRODUCT_VERSION` | VARCHAR2(20) |  |  |
| 8 | `DEINSTALL_SCRIPT` | LONG |  |  |
| 9 | `GRANT_PRIV_PROCEDURE` | VARCHAR2(2000) |  |  |
| 10 | `REVOKE_PRIV_PROCEDURE` | VARCHAR2(2000) |  |  |
| 11 | `INSTALLED_BY` | VARCHAR2(30) |  |  |
| 12 | `PRODUCT_SCHEMA_VERSION` | VARCHAR2(20) |  |  |
| 13 | `PRODUCT_BASE_VERSION` | VARCHAR2(20) |  |  |
| 14 | `STAND_ALONE_PRODUCT_FLAG` | VARCHAR2(1) |  |  |

- **PK:** `PRODUCT_ID`
- **Unique** (QUEST_COM_PRDUCTS_U2): `PRODUCT_PREFIX`
- **Unique** (QUEST_COM_PRODUCT_U1): `PRODUCT_NAME`
- **Index** unique `QUEST_COM_PRODUCTS_PK`: `PRODUCT_ID`

### QUEST_COM_PRODUCTS_USED_BY

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PRODUCT_ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `USED_BY_PRODUCT_ID` 🔑 | NUMBER | NOT NULL |  |
| 3 | `PRODUCT_VERSION` | VARCHAR2(20) |  |  |

- **PK:** `PRODUCT_ID`, `USED_BY_PRODUCT_ID`
- **FK:** (`PRODUCT_ID`) → `QUEST_COM_PRODUCTS` (`PRODUCT_ID`)
- **FK:** (`USED_BY_PRODUCT_ID`) → `QUEST_COM_PRODUCTS` (`PRODUCT_ID`)
- **Index** unique `QUEST_COM_PRODUCTS_USED_BY_PK`: `PRODUCT_ID`, `USED_BY_PRODUCT_ID`

### QUEST_COM_PRODUCT_PRIVS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PRODUCT_ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `PRIVILEGE_ID` 🔑 | VARCHAR2(60) | NOT NULL |  |
| 3 | `PRIVILEGE_DESCRIPTION` | VARCHAR2(256) | NOT NULL |  |
| 4 | `VALIDATION_ROUTINE` | VARCHAR2(2000) |  |  |
| 5 | `PRIVILEGE_LEVEL` | VARCHAR2(256) |  |  |

- **PK:** `PRODUCT_ID`, `PRIVILEGE_ID`
- **FK:** (`PRODUCT_ID`) → `QUEST_COM_PRODUCTS` (`PRODUCT_ID`)
- **Index** unique `QUEST_COM_PRODUCT_PRIVS_PK`: `PRODUCT_ID`, `PRIVILEGE_ID`

### QUEST_COM_USERS

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USER_ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `PRODUCT_ID` 🔑 | NUMBER | NOT NULL |  |
| 3 | `AUTHORIZATION_LEVEL` | VARCHAR2(60) |  |  |
| 4 | `INSTALL_USER` | VARCHAR2(30) |  |  |

- **PK:** `USER_ID`, `PRODUCT_ID`
- **FK:** (`PRODUCT_ID`) → `QUEST_COM_PRODUCTS` (`PRODUCT_ID`)
- **Index** unique `QUEST_COM_USERS_PK`: `USER_ID`, `PRODUCT_ID`

### QUEST_COM_USER_PRIVILEGES

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PRODUCT_ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `USER_ID` 🔑 | NUMBER | NOT NULL |  |
| 3 | `PRIVILEGE_ID` 🔑 | VARCHAR2(60) | NOT NULL |  |
| 4 | `PRIVILEGE_LEVEL` | VARCHAR2(2000) |  |  |

- **PK:** `PRODUCT_ID`, `USER_ID`, `PRIVILEGE_ID`
- **FK:** (`USER_ID`, `PRODUCT_ID`) → `QUEST_COM_USERS` (`USER_ID`, `PRODUCT_ID`)
- **FK:** (`PRODUCT_ID`, `PRIVILEGE_ID`) → `QUEST_COM_PRODUCT_PRIVS` (`PRODUCT_ID`, `PRIVILEGE_ID`)
- **Index** unique `QUEST_COM_USER_PRIV_PK`: `PRODUCT_ID`, `USER_ID`, `PRIVILEGE_ID`

### RECEIVING_BOL

_~10,264 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `RECEIVING_BOL_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `BOL` | VARCHAR2(32) | NOT NULL |  |
| 3 | `CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 4 | `CREATED_BY` | VARCHAR2(32) |  |  |
| 5 | `CREATED_DATE` | DATE |  |  |
| 6 | `RECEIVED_DATE` | DATE |  |  |
| 7 | `STATUS` | NUMBER(2,0) |  |  |

- **PK:** `RECEIVING_BOL_ID`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036651`: `RECEIVING_BOL_ID`

### RECEIVING_BOL_COIL

_~82,290 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `RECEIVING_BOL_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ID` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `COIL_ORG_NUM` | VARCHAR2(32) | NOT NULL |  |
| 4 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 5 | `STATUS` | NUMBER(2,0) |  |  |
| 6 | `DAMAGED_FAULT` | NUMBER(1,0) |  |  |
| 7 | `DAMAGED_CODE` | NUMBER(3,0) |  |  |
| 8 | `TEMPER` | VARCHAR2(8) |  |  |
| 9 | `NET_WEIGHT` | NUMBER(8,0) |  |  |
| 10 | `GROSS_WEIGHT` | NUMBER(8,0) |  |  |
| 11 | `LINEAL_FEED` | NUMBER(7,2) |  |  |
| 12 | `COIL_WIDTH` | NUMBER(9,4) |  |  |
| 13 | `COIL_GAUGE` | NUMBER(5,4) |  |  |
| 14 | `DENSITY` | FLOAT |  |  |
| 15 | `LOT` | VARCHAR2(40) |  |  |
| 16 | `PACK_ID` | VARCHAR2(40) |  |  |
| 17 | `ALLOY` | VARCHAR2(40) |  |  |
| 18 | `PART_NUM` | VARCHAR2(40) |  |  |
| 19 | `SUPPLIER_SALES_NUM` | VARCHAR2(40) |  |  |
| 20 | `PURCHASE_ORDER_NUM` | VARCHAR2(40) |  |  |
| 21 | `CONSUMED_COIL_NUM` | VARCHAR2(32) |  |  |
| 22 | `MATERIAL_NUM` | VARCHAR2(32) |  |  |
| 23 | `CASH_DATE` | VARCHAR2(24) |  |  |

- **PK:** `RECEIVING_BOL_ID`, `COIL_ID`
- **FK:** (`RECEIVING_BOL_ID`) → `RECEIVING_BOL` (`RECEIVING_BOL_ID`)
- **Index** unique `SYS_C0036652`: `RECEIVING_BOL_ID`, `COIL_ID`

### RECOVERY_JOB_COIL

_~11 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SPECIAL_ATTENTION` | NUMBER(1,0) |  |  |
| 4 | `SPECIAL_HANDLING` | NUMBER(1,0) |  |  |
| 5 | `COIL_REJECTED` | NUMBER(1,0) |  |  |
| 6 | `COIL_REBANDED` | NUMBER(1,0) |  |  |
| 7 | `PRODUCT_TYPE_ID` | NUMBER(8,0) |  |  |

- **PK:** `COIL_ABC_NUM`, `AB_JOB_NUM`
- **FK:** (`PRODUCT_TYPE_ID`) → `PRODUCT_TYPE` (`PRODUCT_TYPE_ID`)
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **Index** unique `SYS_C0036766`: `COIL_ABC_NUM`, `AB_JOB_NUM`

### RECOVERY_REPORT_CUSTOMER

_~14 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_NAME` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 3 | `AUTO_ONLY` | NUMBER(1,0) | NOT NULL |  |
| 4 | `COMM_ONLY` | NUMBER(1,0) | NOT NULL |  |
| 5 | `ALL_PRODUCTS` | NUMBER(1,0) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`, `CUSTOMER_NAME`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `SYS_C0036769`: `CUSTOMER_ID`, `CUSTOMER_NAME`

### RECOVERY_REPORT_TEMPLATE

_~81 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_NAME` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 3 | `RECOVERY_REPORT_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |

- **PK:** `CUSTOMER_ID`, `CUSTOMER_NAME`, `RECOVERY_REPORT_TYPE_ID`
- **FK:** (`RECOVERY_REPORT_TYPE_ID`) → `RECOVERY_REPORT_TYPE` (`RECOVERY_REPORT_TYPE_ID`)
- **FK:** (`CUSTOMER_ID`, `CUSTOMER_NAME`) → `RECOVERY_REPORT_CUSTOMER` (`CUSTOMER_ID`, `CUSTOMER_NAME`)
- **Index** unique `SYS_C0036771`: `CUSTOMER_ID`, `CUSTOMER_NAME`, `RECOVERY_REPORT_TYPE_ID`

### RECOVERY_REPORT_TYPE

_~12 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `RECOVERY_REPORT_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `RECOVERY_REPORT_TYPE` | VARCHAR2(64) | NOT NULL |  |
| 3 | `RECOVERY_REPORT_DATAWINDOW` | VARCHAR2(64) |  |  |
| 4 | `RECOVERY_REPORT_EVENT` | VARCHAR2(64) |  |  |

- **PK:** `RECOVERY_REPORT_TYPE_ID`
- **Index** unique `SYS_C0036770`: `RECOVERY_REPORT_TYPE_ID`

### RECOVERY_SCRAP_WORKSHEET

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SCRAP_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 4 | `SCRAP_ITEM_PIECE` | NUMBER(5,0) | NOT NULL |  |
| 5 | `SCRAP_ITEM_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 6 | `SCRAP_ITEM_NOTES` | VARCHAR2(256) |  |  |

- **PK:** `COIL_ABC_NUM`, `AB_JOB_NUM`, `SCRAP_TYPE_ID`
- **FK:** (`SCRAP_TYPE_ID`) → `SCRAP_TYPE` (`SCRAP_TYPE_ID`)
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **Index** unique `SYS_C0036767`: `COIL_ABC_NUM`, `AB_JOB_NUM`, `SCRAP_TYPE_ID`

### RECTANGLE

_~33,374 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `RT_LENGTH` | NUMBER(10,5) |  |  |
| 4 | `RT_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 5 | `RT_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 6 | `RT_WIDTH` | NUMBER(10,5) |  |  |
| 7 | `RT_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 8 | `RT_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 9 | `RT_DIE1` | VARCHAR2(18) |  |  |
| 10 | `RT_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKRECTANGLE`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### REINFORCEMENT

_~42 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `RE_WIDTH` | NUMBER(10,5) |  |  |
| 4 | `RE_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 5 | `RE_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 6 | `RE_LENGTH` | NUMBER(10,5) |  |  |
| 7 | `RE_LENGTH_PLUS` | NUMBER(6,6) |  |  |
| 8 | `RE_LENGTH_MINUS` | NUMBER(6,6) |  |  |
| 9 | `RE_DIE1` | VARCHAR2(18) |  |  |
| 10 | `RE_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `PK_REINFORCEMENT`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### REJECT_COIL

_~3,926 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 3 | `REJECT_COIL_LOCATION` | VARCHAR2(18) |  |  |
| 4 | `REJECT_COIL_QUANTITY` | NUMBER(8,0) |  |  |
| 5 | `REJECT_COIL_STATUS` | NUMBER(2,0) |  |  |
| 6 | `REJECT_COIL_EDI_DATE` | DATE |  |  |
| 7 | `REJECT_COIL_DATE` | DATE |  |  |
| 8 | `REJECT_COIL_NOTE` | VARCHAR2(255) |  |  |

- **PK:** `COIL_ABC_NUM`
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `XPKREJECT_COIL`: `COIL_ABC_NUM`

### REJECT_COIL_PACKING_ITEM

_~3,714 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `REJ_COIL_PACKING_ITEM` 🔑 | NUMBER | NOT NULL |  |
| 2 | `PACKING_LIST` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `REJ_COIL_PACKAGING_TICKET` | NUMBER | NOT NULL |  |
| 4 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |

- **PK:** `REJ_COIL_PACKING_ITEM`, `PACKING_LIST`
- **FK:** (`COIL_ABC_NUM`) → `REJECT_COIL` (`COIL_ABC_NUM`)
- **FK:** (`PACKING_LIST`) → `SHIPMENT` (`PACKING_LIST`)
- **Index** unique `XPKREJ_COIL_PACKING_ITEM`: `REJ_COIL_PACKING_ITEM`, `PACKING_LIST`

### REPORT_AUTO_RUN_LOG

_~6 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `RUN_DATE` | DATE | NOT NULL |  |
| 2 | `RUN_MESSAGE` | VARCHAR2(512) |  |  |


### RETURN_SCRAP_ITEM

_~62,220 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `RETURN_SCRAP_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 3 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 4 | `RETURN_ITEM_NET_WT` | NUMBER(8,0) |  |  |
| 5 | `RETURN_ITEM_DATE` | DATE |  |  |
| 6 | `RETURN_ITEM_NOTES` | VARCHAR2(255) |  |  |
| 7 | `SCRAP_ITEM_PIECES` | NUMBER(5,0) |  |  |
| 8 | `SCRAP_ITEM_TYPE` | NUMBER(3,0) |  |  |
| 9 | `MILL` | NUMBER(1,0) |  |  |
| 10 | `SHIFT_NUM` | NUMBER(8,0) |  |  |
| 11 | `OD` | NUMBER(1,0) |  |  |
| 12 | `SCRAP_ITEM_870_DATE` | DATE |  |  |
| 13 | `SCRAP_870_ICN` | NUMBER(9,0) |  |  |

- **PK:** `RETURN_SCRAP_ITEM_NUM`
- **FK:** (`COIL_ABC_NUM`) → `COIL` (`COIL_ABC_NUM`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`SCRAP_ITEM_TYPE`) → `SCRAP_TYPE` (`SCRAP_TYPE_ID`)
- **FK:** (`SHIFT_NUM`) → `SHIFT` (`SHIFT_NUM`)
- **Index** unique `SYS_C0036657`: `RETURN_SCRAP_ITEM_NUM`

### RIGHT_TRAPEZOID

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `RTR_LONG_LENGTH` | NUMBER(10,5) |  |  |
| 4 | `RTR_LONG_PLUS` | NUMBER(6,6) |  |  |
| 5 | `RTR_LONG_MINUS` | NUMBER(6,6) |  |  |
| 6 | `RTR_SHORT_LENGTH` | NUMBER(10,5) |  |  |
| 7 | `RTR_SHORT_PLUS` | NUMBER(6,6) |  |  |
| 8 | `RTR_SHORT_MINUS` | NUMBER(6,6) |  |  |
| 9 | `RTR_WIDTH` | NUMBER(10,5) |  |  |
| 10 | `RTR_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 11 | `RTR_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 12 | `RTR_DIE1` | VARCHAR2(18) |  |  |
| 13 | `RTR_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKRIGHT_HAND_TRAPEZOID`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### ROUTING

_~1,209 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ROUTING_SEQUENCE` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 5 | `DIE_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 6 | `SHEET_TYPE` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 7 | `SPM_STANDARD` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 8 | `SPM_PLANNED` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 9 | `NUMBER_OF_PEOPLE` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 10 | `EDGE_TRIM_Y_N` 🔑 | CHAR(1) | NOT NULL |  |
| 11 | `STACKER_Y_N` 🔑 | CHAR(1) | NOT NULL |  |
| 12 | `EFFIC_PERCENT_STANDARD` | NUMBER(3,0) |  |  |
| 13 | `EFFIC_PERCENT_PLANNED` | NUMBER(3,0) |  |  |
| 14 | `ITEM_ROUTING` | CHAR(1) |  |  |

- **PK:** `ROUTING_SEQUENCE`, `CUSTOMER_ID`, `PART_NUM_ID`, `LINE_NUM`, `DIE_ID`, `SHEET_TYPE`, `SPM_STANDARD`, `SPM_PLANNED`, `NUMBER_OF_PEOPLE`, `EDGE_TRIM_Y_N`, `STACKER_Y_N`
- **Index** unique `SYS_C0036851`: `ROUTING_SEQUENCE`, `CUSTOMER_ID`, `PART_NUM_ID`, `LINE_NUM`, `DIE_ID`, `SHEET_TYPE`, `SPM_STANDARD`, `SPM_PLANNED`, `NUMBER_OF_PEOPLE`, `EDGE_TRIM_Y_N`, `STACKER_Y_N`
- **Index** unique `XPK_ROUTING`: `ROUTING_SEQUENCE`, `CUSTOMER_ID`, `PART_NUM_ID`

### ROUTING_SEQUENCE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ROUTING_SEQ` 🔑 | CHAR(8) | NOT NULL |  |
| 2 | `ROUTING_SEQ_DESC` | VARCHAR2(50) |  |  |

- **PK:** `ROUTING_SEQ`
- **Index** unique `SYS_C0036659`: `ROUTING_SEQ`

### SAMPLE_REQUIREMENT_CODES

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SAMPLE_REQUIREMENT_ID` 🔑 | CHAR(1) | NOT NULL |  |
| 2 | `SAMPLE_REQUIREMENT_NAME` | VARCHAR2(40) |  |  |

- **PK:** `SAMPLE_REQUIREMENT_ID`
- **Index** unique `XPK_SAMPLE_REQUIREMENT_CODES`: `SAMPLE_REQUIREMENT_ID`

### SCAN_LOG

_~10,533 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCAN_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SCAN_DATETIME` | DATE | NOT NULL |  |
| 3 | `AB_JOB_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `SCAN_STATION` | VARCHAR2(16) | NOT NULL |  |
| 5 | `NOTE` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `SCAN_ID`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `SYS_C0036660`: `SCAN_ID`

### SCHEDULE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCHEDULE_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SCHEDULE_NAME` | VARCHAR2(18) |  |  |
| 3 | `SCHEDULE_DESCRIPTION` | VARCHAR2(18) |  |  |
| 4 | `MINUTE` | NUMBER(2,0) |  |  |
| 5 | `HOUR` | NUMBER(2,0) |  |  |
| 6 | `DAY_OF_THE_MONTH` | VARCHAR2(18) |  |  |
| 7 | `MONTH_OF_THE_YEAR` | VARCHAR2(18) |  |  |
| 8 | `DAY_OF_THE_WEEK` | VARCHAR2(18) |  |  |

- **PK:** `SCHEDULE_ID`
- **Index** unique `SYS_C0036661`: `SCHEDULE_ID`

### SCRAPED_PROCESS_PARTIAL_SKID

_~43 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `PARTIAL_SKID_AB_JOB_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `PARTIAL_SHEET_NET_WT` | NUMBER(8,0) |  |  |
| 5 | `PARTIAL_SKID_LOCATION` | VARCHAR2(18) |  |  |
| 6 | `PARTIAL_SKID_DATE` | DATE |  |  |
| 7 | `PARTIAL_SKID_PIECES` | NUMBER(6,0) |  |  |
| 8 | `PARTIAL_SHEET_THEORETICAL_WT` | NUMBER(8,0) |  |  |
| 9 | `SCRAP_SKID_NUM` | NUMBER(8,0) | NOT NULL |  |

- **PK:** `AB_JOB_NUM`, `SHEET_SKID_NUM`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`SHEET_SKID_NUM`) → `SCRAPED_SHEET_SKID` (`SHEET_SKID_NUM`)
- **Index** unique `SYS_C0036662`: `AB_JOB_NUM`, `SHEET_SKID_NUM`

### SCRAPED_PRODUCTION_SHEET_ITEM

_~2,057 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROD_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ABC_NUM` | NUMBER(8,0) |  |  |
| 3 | `AB_JOB_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `PROD_ITEM_STATUS` | NUMBER(2,0) |  |  |
| 5 | `PROD_ITEM_PIECES` | NUMBER(6,0) |  |  |
| 6 | `PROD_ITEM_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 7 | `PROD_ITEM_THEORETICAL_WT` | NUMBER(8,0) |  |  |
| 8 | `PROD_ITEM_EDI870_DATE` | DATE |  |  |
| 9 | `PROD_ITEM_DATE` | DATE |  |  |
| 10 | `PROD_ITEM_NOTE` | VARCHAR2(255) |  |  |
| 11 | `PROD_ITEM_PLACEMENT` | VARCHAR2(18) |  |  |
| 12 | `SCRAP_SKID_NUM` | NUMBER(8,0) | NOT NULL |  |

- **PK:** `PROD_ITEM_NUM`
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `SYS_C0036663`: `PROD_ITEM_NUM`

### SCRAPED_SHEET_SKID

_~1,879 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 3 | `SHEET_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 4 | `SHEET_TARE_WT` | NUMBER(8,0) | NOT NULL |  |
| 5 | `SKID_EDI856_DATE` | DATE |  |  |
| 6 | `SKID_LOCATION` | VARCHAR2(18) |  |  |
| 7 | `SKID_DATE` | DATE |  |  |
| 8 | `SKID_SHEET_STATUS` | NUMBER(4,0) |  |  |
| 9 | `SKID_PIECES` | NUMBER(6,0) |  |  |
| 10 | `SHEET_THEORETICAL_WT` | NUMBER(8,0) |  |  |
| 11 | `SKID_FROM_IF_WHED` | NUMBER(8,0) |  |  |
| 12 | `SKID_TICKET_IF_WHED` | VARCHAR2(32) |  |  |
| 13 | `REF_ORDER_ABC_NUM` | NUMBER(8,0) |  |  |
| 14 | `SKID_TYPE_IF_WHED` | NUMBER(4,0) |  |  |
| 15 | `REF_ORDER_ABC_ITEM` | NUMBER(4,0) |  |  |
| 16 | `SKID_SHEET_STATUS_HELD_BY_QC` | NUMBER(4,0) |  |  |
| 17 | `SCRAP_SKID_NUM` | NUMBER(8,0) | NOT NULL |  |

- **PK:** `SHEET_SKID_NUM`
- **FK:** (`REF_ORDER_ABC_NUM`) → `CUSTOMER_ORDER` (`ORDER_ABC_NUM`)
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **Index** unique `SYS_C0036664`: `SHEET_SKID_NUM`

### SCRAPED_SHEET_SKID_DETAIL

_~2,057 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROD_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SCRAP_SKID_NUM` | NUMBER(8,0) | NOT NULL |  |

- **PK:** `PROD_ITEM_NUM`, `SHEET_SKID_NUM`
- **FK:** (`SHEET_SKID_NUM`) → `SCRAPED_SHEET_SKID` (`SHEET_SKID_NUM`)
- **FK:** (`PROD_ITEM_NUM`) → `SCRAPED_PRODUCTION_SHEET_ITEM` (`PROD_ITEM_NUM`)
- **Index** unique `SYS_C0036665`: `PROD_ITEM_NUM`, `SHEET_SKID_NUM`

### SCRAP_HANDLING_DESC

_~5 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_HANDLING` 🔑 | NUMBER | NOT NULL |  |
| 2 | `SCRAP_HANDLING_DESC` | VARCHAR2(50) |  |  |

- **PK:** `SCRAP_HANDLING`
- **Index** unique `SCRAP_HANDLING_KEY`: `SCRAP_HANDLING`

### SCRAP_LOCATION

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_LOCATION_CODE` 🔑 | NUMBER | NOT NULL |  |
| 2 | `SCRAP_LOCATION_DESC` | VARCHAR2(30) |  |  |

- **PK:** `SCRAP_LOCATION_CODE`
- **Index** unique `XPK_SCRAP_LOCATION`: `SCRAP_LOCATION_CODE`

### SCRAP_PACKING_ITEM

_~55,393 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SC_PACKING_ITEM` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `PACKING_LIST` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SCRAP_SKID_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `SCRAP_PACKAGING_TICKET` | NUMBER(8,0) | NOT NULL |  |

- **PK:** `SC_PACKING_ITEM`, `PACKING_LIST`
- **FK:** (`PACKING_LIST`) → `SHIPMENT` (`PACKING_LIST`)
- **FK:** (`SCRAP_SKID_NUM`) → `SCRAP_SKID` (`SCRAP_SKID_NUM`)
- **Index** unique `XPKSHEET_PACKING_ITEM`: `SC_PACKING_ITEM`, `PACKING_LIST`

### SCRAP_SKID

_~147,779 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CUSTOMER_ID` | NUMBER(8,0) |  |  |
| 3 | `SCRAP_TYPE` | NUMBER(2,0) |  |  |
| 4 | `SCRAP_ALLOY` | NUMBER(4,0) |  |  |
| 5 | `SCRAP_TEMPER` | VARCHAR2(8) |  |  |
| 6 | `SCRAP_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 7 | `SCRAP_TARE_WT` | NUMBER(8,0) | NOT NULL |  |
| 8 | `SCRAP_CUST_PO` | VARCHAR2(32) |  |  |
| 9 | `SCRAP_AB_JOB_NUM` | VARCHAR2(18) |  |  |
| 10 | `SCRAP_LOCATION` | VARCHAR2(18) |  |  |
| 11 | `SCRAP_DATE` | DATE |  |  |
| 12 | `SKID_SCRAP_STATUS` | NUMBER(4,0) |  |  |
| 13 | `SCRAP_NOTES` | VARCHAR2(255) |  |  |
| 14 | `SCRAP_ALLOY2` | VARCHAR2(8) |  |  |
| 15 | `TOTE_NUM` | NUMBER(3,0) |  |  |
| 16 | `SCRAP_SKID_DISPLAY_NUM` | VARCHAR2(16) |  |  |
| 17 | `TRAILER_NAME` | VARCHAR2(20) |  |  |
| 18 | `CUSTOMER_ID_ORIG` | NUMBER(8,0) |  |  |
| 19 | `SCRAP_HANDLING_TYPE` | VARCHAR2(18) |  |  |

- **PK:** `SCRAP_SKID_NUM`
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKSHEET_SKID`: `SCRAP_SKID_NUM`

### SCRAP_SKID_DETAIL

_~63,504 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `RETURN_SCRAP_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `SCRAP_SKID_NUM`, `RETURN_SCRAP_ITEM_NUM`
- **FK:** (`RETURN_SCRAP_ITEM_NUM`) → `RETURN_SCRAP_ITEM` (`RETURN_SCRAP_ITEM_NUM`)
- **FK:** (`SCRAP_SKID_NUM`) → `SCRAP_SKID` (`SCRAP_SKID_NUM`)
- **Index** unique `SYS_C0036668`: `SCRAP_SKID_NUM`, `RETURN_SCRAP_ITEM_NUM`

### SCRAP_SKID_STATUS_DESC

_~5 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_SKID_STATUS_CODE` 🔑 | NUMBER | NOT NULL |  |
| 2 | `SCRAP_SKID_STATUS_DESC` | VARCHAR2(56) |  |  |

- **PK:** `SCRAP_SKID_STATUS_CODE`
- **Index** unique `SCRAP_SKID_STATUS_DESC`: `SCRAP_SKID_STATUS_CODE`

### SCRAP_STATUS_DESC

_~6 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_STATUS` 🔑 | NUMBER | NOT NULL |  |
| 2 | `SCRAP_STATUS_DESC` | VARCHAR2(50) |  |  |

- **PK:** `SCRAP_STATUS`
- **Index** `IDX1_SCRAP_STATUS_DESC`: `SCRAP_STATUS`

### SCRAP_TRACK

_~74,503 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_SKID_NO` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LOG_DATE` 🔑 | DATE | NOT NULL |  |
| 3 | `PRE_STATUS` | NUMBER(2,0) |  |  |
| 4 | `CUR_STATUS` | NUMBER(2,0) |  |  |
| 5 | `PRE_NET_WT` | NUMBER(8,0) |  |  |
| 6 | `CUR_NET_WT` | NUMBER(8,0) |  |  |
| 7 | `PRE_AB_JOB_NUM` | VARCHAR2(18) |  |  |
| 8 | `CUR_AB_JOB_NUM` | VARCHAR2(18) |  |  |
| 9 | `PRE_CUST_PO` | VARCHAR2(32) |  |  |
| 10 | `CUR_CUST_PO` | VARCHAR2(32) |  |  |
| 11 | `MODIFIED_BY` | VARCHAR2(18) |  |  |
| 12 | `PRE_TARE_WT` | NUMBER(8,0) |  |  |
| 13 | `CUR_TARE_WT` | NUMBER(8,0) |  |  |
| 14 | `RECORD_DELETED` | NUMBER(1,0) |  |  |

- **PK:** `SCRAP_SKID_NO`, `LOG_DATE`
- **Index** unique `PK_SCRAP_TRACK`: `SCRAP_SKID_NO`, `LOG_DATE`

### SCRAP_TYPE

_~49 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `SCRAP_CODE` | VARCHAR2(10) | NOT NULL |  |
| 3 | `SCRAP_DEFECT` | VARCHAR2(50) | NOT NULL |  |
| 4 | `NOTE` | VARCHAR2(50) |  |  |

- **PK:** `SCRAP_TYPE_ID`
- **Index** unique `PK_SCRAP_TYPE_ID`: `SCRAP_TYPE_ID`

### SCRAP_TYPE_DESC

_~11 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SCRAP_TYPE` 🔑 | NUMBER | NOT NULL |  |
| 2 | `SCRAP_TYPE_DESC` | VARCHAR2(50) |  |  |

- **PK:** `SCRAP_TYPE`
- **Index** unique `SCRAP_TYPE_KEY`: `SCRAP_TYPE`

### SECTOR

_~2 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SECTOR_CODE` 🔑 | NUMBER | NOT NULL |  |
| 2 | `SECTOR_DESC` | VARCHAR2(30) | NOT NULL |  |

- **PK:** `SECTOR_CODE`
- **Index** unique `PFK_SECTOR`: `SECTOR_CODE`

### SECURITY_APPLICATION

_~31 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPLICATION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `APPLICATION_NAME` | VARCHAR2(64) |  |  |
| 3 | `APPLICATION_NOTES` | VARCHAR2(255) |  |  |

- **PK:** `APPLICATION_ID`
- **Index** unique `XPKSECURITY_APPLICATION`: `APPLICATION_ID`

### SECURITY_GROUP

_~9 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USER_GROUP_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `GROUP_NAME` | VARCHAR2(32) |  |  |
| 3 | `GROUP_NOTES` | VARCHAR2(255) |  |  |

- **PK:** `USER_GROUP_ID`
- **Index** unique `XPKSECURITY_GROUP`: `USER_GROUP_ID`

### SECURITY_GROUP_APPLICATION

_~126 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPLICATION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `USER_GROUP_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `GROUP_APPLICATION_PRIVILEGE` | NUMBER(1,0) |  |  |

- **PK:** `APPLICATION_ID`, `USER_GROUP_ID`
- **FK:** (`APPLICATION_ID`) → `SECURITY_APPLICATION` (`APPLICATION_ID`)
- **FK:** (`USER_GROUP_ID`) → `SECURITY_GROUP` (`USER_GROUP_ID`)
- **Index** unique `XPKSECURITY_GROUP_APPLICATION`: `APPLICATION_ID`, `USER_GROUP_ID`

### SECURITY_USER

_~63 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LOGIN_ID` | VARCHAR2(18) |  |  |
| 3 | `USER_LAST_NAME` | VARCHAR2(18) |  |  |
| 4 | `USER_FIRST_NAME` | VARCHAR2(18) |  |  |
| 5 | `USER_MIDDLE_INITIAL` | VARCHAR2(18) |  |  |
| 6 | `LAST_LOGIN_TIME` | DATE |  |  |
| 7 | `LAST_MODIFIED_DATE` | DATE |  |  |
| 8 | `USER_STATUS` | NUMBER(2,0) |  |  |
| 9 | `USER_NOTES` | VARCHAR2(255) |  |  |

- **PK:** `USER_ID`
- **Index** unique `XPKSECURITY_USER`: `USER_ID`

### SECURITY_USER_APPLICATION

_~763 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `APPLICATION_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `USER_APPLICATION_PRIVILEGE` | NUMBER(1,0) |  |  |

- **PK:** `USER_ID`, `APPLICATION_ID`
- **FK:** (`USER_ID`) → `SECURITY_USER` (`USER_ID`)
- **FK:** (`APPLICATION_ID`) → `SECURITY_APPLICATION` (`APPLICATION_ID`)
- **Index** unique `XPKSECURITY_USER_APPLICATION`: `USER_ID`, `APPLICATION_ID`

### SECURITY_USER_GROUP

_~154 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `USER_GROUP_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `USER_ID`, `USER_GROUP_ID`
- **FK:** (`USER_ID`) → `SECURITY_USER` (`USER_ID`)
- **FK:** (`USER_GROUP_ID`) → `SECURITY_GROUP` (`USER_GROUP_ID`)
- **Index** unique `XPKSECURITY_USER_GROUP`: `USER_ID`, `USER_GROUP_ID`

### SECURITY_USER_WEB_APP

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LOGIN_ID` 🔑 | VARCHAR2(10) | NOT NULL |  |
| 2 | `LOGIN_PASSWD` | VARCHAR2(10) | NOT NULL |  |

- **PK:** `LOGIN_ID`
- **Index** unique `PK_WEB_APP`: `LOGIN_ID`

### SECURITY_USER_WEB_ROLE

_~6 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LOGIN_ID` 🔑 | VARCHAR2(10) | NOT NULL |  |
| 2 | `WEB_ROLE` 🔑 | VARCHAR2(18) | NOT NULL |  |

- **PK:** `LOGIN_ID`, `WEB_ROLE`
- **FK:** (`LOGIN_ID`) → `SECURITY_USER_WEB_APP` (`LOGIN_ID`)
- **Index** unique `PK_WEB_ROLE`: `LOGIN_ID`, `WEB_ROLE`

### SEQUENCE_KEY

_~22 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `SEQUENCE_START_NUM` | NUMBER(6,0) |  |  |
| 3 | `SEQUENCE_MAX_NUM` | NUMBER(9,0) |  |  |
| 4 | `SEQUENCE_INCREMENT_NUM` | NUMBER(3,0) |  |  |
| 5 | `SEQUENCE_CYCLE` | NUMBER(1,0) |  |  |
| 6 | `SEQUENCE_CACHE_NUM` | NUMBER(3,0) |  |  |
| 7 | `SEQUENCE_CURVAL` | NUMBER(9,0) |  |  |

- **PK:** `SEQUENCE_NAME`
- **Index** unique `SYS_C0036679`: `SEQUENCE_NAME`

### SHAPE_DIE

_~68 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_TYPE` 🔑 | CHAR(18) | NOT NULL |  |
| 2 | `DIE_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |

- **PK:** `SHEET_TYPE`, `DIE_ID`
- **FK:** (`DIE_ID`) → `DIE` (`DIE_ID`)
- **Index** unique `SYS_C0036680`: `SHEET_TYPE`, `DIE_ID`

### SHEET_PACKING_ITEM

_~286,902 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SH_PACKING_ITEM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `PACKING_LIST` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SHEET_SKID_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `SHEET_PACKAGING_TICKET` | NUMBER(8,0) | NOT NULL |  |

- **PK:** `SH_PACKING_ITEM`, `PACKING_LIST`
- **FK:** (`PACKING_LIST`) → `SHIPMENT` (`PACKING_LIST`)
- **FK:** (`SHEET_SKID_NUM`) → `SHEET_SKID` (`SHEET_SKID_NUM`)
- **Index** unique `XPK3SHEET_PACKING_ITEM`: `SH_PACKING_ITEM`, `PACKING_LIST`

### SHEET_SKID

_~617,213 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 3 | `SHEET_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 4 | `SHEET_TARE_WT` | NUMBER(8,0) | NOT NULL |  |
| 5 | `SKID_EDI856_DATE` | DATE |  |  |
| 6 | `SKID_LOCATION` | VARCHAR2(18) |  |  |
| 7 | `SKID_DATE` | DATE |  |  |
| 8 | `SKID_SHEET_STATUS` | NUMBER(4,0) |  |  |
| 9 | `SKID_PIECES` | NUMBER(6,0) |  |  |
| 10 | `SHEET_THEORETICAL_WT` | NUMBER(8,0) |  |  |
| 11 | `SKID_FROM_IF_WHED` | NUMBER(8,0) |  |  |
| 12 | `SKID_TICKET_IF_WHED` | VARCHAR2(32) |  |  |
| 13 | `REF_ORDER_ABC_NUM` | NUMBER(8,0) |  |  |
| 14 | `SKID_TYPE_IF_WHED` | NUMBER(4,0) |  |  |
| 15 | `REF_ORDER_ABC_ITEM` | NUMBER(4,0) |  |  |
| 16 | `SKID_SHEET_STATUS_HELD_BY_QC` | NUMBER(4,0) |  |  |
| 17 | `SKID_SEQ_FOR_JOB` | NUMBER(4,0) |  |  |
| 18 | `SHEET_SKID_QUALITY_NOTES` | VARCHAR2(255) |  |  |
| 19 | `SHEET_SKID_DISPLAY_NUM` | VARCHAR2(16) |  |  |
| 20 | `SHEET_SKID_DISPLAY_NUM_SUFFIX` | CHAR(1) |  |  |
| 21 | `ONHOLD_REASON_CODE` | NUMBER(3,0) |  |  |

- **PK:** `SHEET_SKID_NUM`
- **FK:** (`AB_JOB_NUM`) → `AB_JOB` (`AB_JOB_NUM`)
- **FK:** (`REF_ORDER_ABC_NUM`) → `CUSTOMER_ORDER` (`ORDER_ABC_NUM`)
- **Index** unique `XPK3SHEET_SKID`: `SHEET_SKID_NUM`

### SHEET_SKID_DETAIL

_~334,872 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROD_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `PROD_ITEM_NUM`, `SHEET_SKID_NUM`
- **FK:** (`PROD_ITEM_NUM`) → `PRODUCTION_SHEET_ITEM` (`PROD_ITEM_NUM`)
- **FK:** (`SHEET_SKID_NUM`) → `SHEET_SKID` (`SHEET_SKID_NUM`)
- **Index** unique `XPKSHEET_SKID_DETAIL`: `PROD_ITEM_NUM`, `SHEET_SKID_NUM`

### SHEET_SKID_DIMENSION_CHECK

_~256 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` | NUMBER(8,0) | NOT NULL |  |
| 2 | `PC_NUMBER` | NUMBER(4,0) | NOT NULL |  |
| 3 | `GAUGE` | NUMBER(6,5) |  |  |
| 4 | `WIDTH` | NUMBER(9,5) |  |  |
| 5 | `LENGTH_OPER` | NUMBER(10,5) |  |  |
| 6 | `LENGTH_DRIVE` | NUMBER(10,5) |  |  |
| 7 | `SQUARE` | NUMBER(10,5) |  |  |
| 8 | `HEAD_DIMENSION` | NUMBER(10,5) |  |  |
| 9 | `ALL_CUT_EDGE` | NUMBER(2,0) |  |  |
| 10 | `IN_SPEC` | NUMBER(2,0) | NOT NULL |  |
| 11 | `CHECKED_BY` | VARCHAR2(15) |  |  |
| 12 | `NOTE` | VARCHAR2(25) |  |  |
| 13 | `DIMENSION_CHECK_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |

- **PK:** `DIMENSION_CHECK_NUM`
- **Unique** (PK_SHEET_DIM_CHECK): `SHEET_SKID_NUM`, `PC_NUMBER`
- **Index** `INDEX_SHEET_SKID_NUM`: `SHEET_SKID_NUM`
- **Index** unique `INDEX_SHEET_SKID_PC_NUM`: `SHEET_SKID_NUM`, `PC_NUMBER`
- **Index** unique `PK_SHEET_DIM_CHECK_NUMBER`: `DIMENSION_CHECK_NUM`

### SHEET_SKID_PACKAGE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PACKAGE_NUM` | NUMBER(10,0) |  |  |

- **PK:** `SHEET_SKID_NUM`
- **Index** unique `XPK_SHEET_SKID_PACKAGE`: `SHEET_SKID_NUM`

### SHEET_SKID_PACKAGE_HISTORY

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `PACKAGE_NUM` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 3 | `CHANGE_USER` | VARCHAR2(20) |  |  |
| 4 | `CHANGE_DATE_TIME` 🔑 | DATE | NOT NULL |  |

- **PK:** `SHEET_SKID_NUM`, `PACKAGE_NUM`, `CHANGE_DATE_TIME`
- **Index** unique `XPK_SHEET_SKID_PACKAGE_HISTORY`: `SHEET_SKID_NUM`, `PACKAGE_NUM`, `CHANGE_DATE_TIME`

### SHIFT

_~8,366 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHIFT_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `START_TIME` | DATE |  |  |
| 3 | `END_TIME` | DATE |  |  |
| 4 | `NOTE` | VARCHAR2(1024) |  |  |
| 5 | `LINE_NUM` | NUMBER(5,0) |  |  |
| 6 | `SHEDULE_TYPE` | NUMBER(1,0) |  |  |
| 7 | `PLANNED_STARTING_TIME` | DATE |  |  |
| 8 | `PLANNED_ENDING_TIME` | DATE |  |  |
| 9 | `SCHEDULE_TYPE` | NUMBER(1,0) |  |  |
| 10 | `DT_TOTAL` | NUMBER(8,0) |  |  |
| 11 | `OPERATOR_INITIAL` | VARCHAR2(10) |  |  |
| 12 | `SHIFT_DATA_STATUS` | NUMBER(2,0) |  |  |
| 13 | `OPERATOR_SIGN_TIME` | DATE |  |  |

- **PK:** `SHIFT_NUM`
- **FK:** (`LINE_NUM`, `SHEDULE_TYPE`) → `LINE_SCHEDULE` (`LINE_NUM`, `SCHEDULE_TYPE`)
- **Index** unique `PK_SHIFT_NUM`: `SHIFT_NUM`

### SHIFT_COIL

_~45,285 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHIFT_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_RUN_NUM` 🔑 | NUMBER(5,0) | NOT NULL |  |
| 3 | `AB_JOB_NUM` | NUMBER(8,0) | NOT NULL |  |
| 4 | `COIL_ABC_NUM` | NUMBER(8,0) | NOT NULL |  |
| 5 | `COIL_BEGIN_STATUS` | NUMBER(4,0) |  |  |
| 6 | `COIL_END_STATUS` | NUMBER(4,0) |  |  |
| 7 | `COIL_BEGIN_WT` | NUMBER(8,0) |  |  |
| 8 | `COIL_END_WT` | NUMBER(8,0) |  |  |
| 9 | `COIL_BEGIN_TIME` | DATE |  |  |
| 10 | `COIL_END_TIME` | DATE |  |  |
| 11 | `NOTE` | VARCHAR2(25) |  |  |
| 12 | `PROCESS_WT` | NUMBER(8,0) |  |  |

- **PK:** `SHIFT_NUM`, `COIL_RUN_NUM`
- **FK:** (`SHIFT_NUM`) → `SHIFT` (`SHIFT_NUM`)
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **Index** unique `PK_SHIFT_RUN`: `SHIFT_NUM`, `COIL_RUN_NUM`

### SHIFT_COIL_JOB

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHIFT_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `STATUS` | NUMBER(2,0) |  |  |

- **PK:** `SHIFT_NUM`, `AB_JOB_NUM`, `COIL_ABC_NUM`
- **FK:** (`SHIFT_NUM`) → `SHIFT` (`SHIFT_NUM`)
- **FK:** (`COIL_ABC_NUM`, `AB_JOB_NUM`) → `PROCESS_COIL` (`COIL_ABC_NUM`, `AB_JOB_NUM`)
- **Index** unique `SYS_C0036688`: `SHIFT_NUM`, `AB_JOB_NUM`, `COIL_ABC_NUM`

### SHIFT_PROFILE

_~7 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ID` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `DESCRIPTION` | VARCHAR2(64) |  |  |
| 3 | `STARTING_TIME_1ST` | VARCHAR2(32) |  |  |
| 4 | `ENDING_TIME_1ST` | VARCHAR2(32) |  |  |
| 5 | `STARTING_TIME_2ND` | VARCHAR2(32) |  |  |
| 6 | `ENDING_TIME_2ND` | VARCHAR2(32) |  |  |
| 7 | `STARTING_TIME_3RD` | VARCHAR2(32) |  |  |
| 8 | `ENDING_TIME_3RD` | VARCHAR2(32) |  |  |

- **PK:** `ID`
- **Index** unique `SYS_C0036689`: `ID`

### SHIFT_SCHEDULE

_~18,724 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHIFT_SCHEDULE_DATE` 🔑 | DATE | NOT NULL |  |
| 2 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `SCHEDULE_TYPE` 🔑 | NUMBER(1,0) | NOT NULL |  |
| 4 | `SUPERVISOR_ID` | NUMBER(8,0) |  |  |
| 5 | `SHIFT_STARTING_TIME` | DATE |  |  |
| 6 | `SHIFT_ENDING_TIME` | DATE |  |  |
| 7 | `SHIFT_CANCELLED` | NUMBER(1,0) |  |  |

- **PK:** `SHIFT_SCHEDULE_DATE`, `LINE_NUM`, `SCHEDULE_TYPE`
- **FK:** (`LINE_NUM`, `SCHEDULE_TYPE`) → `LINE_SCHEDULE` (`LINE_NUM`, `SCHEDULE_TYPE`)
- **FK:** (`SUPERVISOR_ID`) → `EMPLOYEE` (`EMPLOYEE_ID`)
- **Index** unique `SYS_C0036690`: `SHIFT_SCHEDULE_DATE`, `LINE_NUM`, `SCHEDULE_TYPE`

### SHIPMENT

_~118,738 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PACKING_LIST` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `CARRIER_ID` | NUMBER(8,0) |  |  |
| 3 | `BILL_OF_LADING` | NUMBER(8,0) | NOT NULL |  |
| 4 | `DES_SH_CUST_ID` | NUMBER(8,0) |  |  |
| 5 | `VEHICLE_ID` | VARCHAR2(32) |  |  |
| 6 | `VEHICLE_ID_PREFIX` | VARCHAR2(18) |  |  |
| 7 | `VEHICLE_STATUS` | NUMBER(2,0) |  |  |
| 8 | `SHIPMENT_SCHEDULED_DATE_TIME` | DATE |  |  |
| 9 | `DATE_SENT` | DATE |  |  |
| 10 | `SHIPMENT_ACTUALED_DATE_TIME` | DATE |  |  |
| 11 | `SHIPMENT_DES_EDI856_DATE` | DATE |  |  |
| 12 | `SHIPMENT_NOTES` | VARCHAR2(255) |  |  |
| 13 | `CUSTOMER_ID` | NUMBER(8,0) |  |  |
| 14 | `SHIPMENT_STATUS` | NUMBER(2,0) |  |  |
| 15 | `TRANSPORTATION_METHOD_CODE` | VARCHAR2(36) |  |  |
| 16 | `CARRIER_DESCRIPTION_CODE` | VARCHAR2(36) |  |  |
| 17 | `CARRIER_INITIAL` | CHAR(2) |  |  |
| 18 | `SHIPMENT_EDI856_DATE` | DATE |  |  |
| 19 | `SHIPMENT_ENDUSER_ID` | NUMBER(8,0) |  |  |
| 20 | `SHIPMENT_ATHORIZATION_CODE` | VARCHAR2(36) |  |  |
| 21 | `SHIPMENT_REFERENCE_CODES` | VARCHAR2(750) |  |  |
| 22 | `SCRAP_SALES_ORDER_NUM` | VARCHAR2(32) |  |  |
| 23 | `EQUIPMENT_TYPE` | VARCHAR2(4) |  |  |
| 24 | `SHIPMENT_DESADV_DATE` | DATE |  |  |
| 25 | `EDI_REQ` | CHAR(1) |  |  |
| 26 | `EDI_FILE_ID_856` | NUMBER(8,0) |  |  |
| 27 | `EDI_FILE_ID_DESADV` | NUMBER(8,0) |  |  |
| 28 | `EDI_TRIGGERED` | CHAR(1) |  |  |
| 29 | `SHIPMENT_TYPE` | CHAR(1) |  |  |
| 30 | `BILLTO_ALBL` | CHAR(1) |  |  |

- **PK:** `PACKING_LIST`
- **FK:** (`DES_SH_CUST_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`CUSTOMER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **FK:** (`CARRIER_ID`) → `CARRIER` (`CARRIER_ID`)
- **FK:** (`SHIPMENT_ENDUSER_ID`) → `CUSTOMER` (`CUSTOMER_ID`)
- **Index** unique `XPKSHIPMENT`: `PACKING_LIST`

### SHIPMENT_TRACK

_~718 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LOG_DATE` 🔑 | DATE | NOT NULL |  |
| 2 | `PACKING_LIST_NO` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `PRE_SHIPMENT_STATUS` | NUMBER(5,0) | NOT NULL |  |
| 4 | `CUR_SHIPMENT_STATUS` | NUMBER(5,0) | NOT NULL |  |
| 5 | `PRE_VEHICLE_STATUS` | NUMBER(5,0) | NOT NULL |  |
| 6 | `CUR_VEHICLE_STATUS` | NUMBER(5,0) | NOT NULL |  |
| 7 | `PRE_CUST_ID` | NUMBER(5,0) | NOT NULL |  |
| 8 | `CUR_CUST_ID` | NUMBER(5,0) | NOT NULL |  |
| 9 | `PRE_SHIP_TO_ID` | NUMBER(5,0) | NOT NULL |  |
| 10 | `CUR_SHIP_TO_ID` | NUMBER(5,0) | NOT NULL |  |
| 11 | `MODIFIED_BY` | VARCHAR2(25) | NOT NULL |  |

- **PK:** `LOG_DATE`, `PACKING_LIST_NO`
- **Index** unique `SHIPMENT_TRACK_PK1`: `LOG_DATE`, `PACKING_LIST_NO`

### SHIPMENT_TYPES

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHIPMENT_TYPE` | CHAR(1) | NOT NULL |  |
| 2 | `TYPE_MEANING` | VARCHAR2(50) | NOT NULL |  |
| 3 | `TYPE_COMMENT` | VARCHAR2(100) |  |  |


### SH_REPORT_DEFAULT_TEMPLATE

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SH_REPORT_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `SH_REPORT_TEMPLATE_ID` | NUMBER(3,0) | NOT NULL |  |

- **PK:** `SH_REPORT_TYPE_ID`
- **FK:** (`SH_REPORT_TYPE_ID`) → `SH_REPORT_TYPE` (`SH_REPORT_TYPE_ID`)
- **FK:** (`SH_REPORT_TEMPLATE_ID`) → `SH_REPORT_TEMPLATES` (`SH_REPORT_TEMPLATE_ID`)
- **Index** unique `XPKSH_REPORT_DEFAULT_TEMPLATE`: `SH_REPORT_TYPE_ID`

### SH_REPORT_TEMPLATES

_~20 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SH_REPORT_TEMPLATE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `SH_REPORT_TYPE_ID` | NUMBER(3,0) | NOT NULL |  |
| 3 | `SH_REPORT_TEMPLATE_NAME` | VARCHAR2(32) | NOT NULL |  |
| 4 | `SH_REPORT_TEMPLATE_OBJECT` | VARCHAR2(64) | NOT NULL |  |

- **PK:** `SH_REPORT_TEMPLATE_ID`
- **FK:** (`SH_REPORT_TYPE_ID`) → `SH_REPORT_TYPE` (`SH_REPORT_TYPE_ID`)
- **Index** unique `XPKSH_REPORT_TEMPLATES`: `SH_REPORT_TEMPLATE_ID`

### SH_REPORT_TYPE

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SH_REPORT_TYPE_ID` 🔑 | NUMBER(3,0) | NOT NULL |  |
| 2 | `SH_REPORT_TYPE_NAME` | VARCHAR2(32) | NOT NULL |  |

- **PK:** `SH_REPORT_TYPE_ID`
- **Index** unique `XPKSH_REPORT_TYPE`: `SH_REPORT_TYPE_ID`

### SKETCH

_~128 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SKETCH_ID` 🔑 | NUMBER(5,0) | NOT NULL |  |
| 2 | `SKETCH_NAME` | VARCHAR2(16) |  |  |
| 3 | `SKETCH_VIEW` | LONG RAW |  |  |
| 4 | `SKETCH_NOTES` | VARCHAR2(1024) |  |  |
| 5 | `SKETCH_SYS_NOTE` | VARCHAR2(255) |  |  |
| 6 | `SKETCH_STATUS` | NUMBER(2,0) |  |  |

- **PK:** `SKETCH_ID`
- **Index** unique `XPKSKETCH`: `SKETCH_ID`

### SKETCH_JPG

_~214 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SKETCH_ID` 🔑 | NUMBER(5,0) | NOT NULL |  |
| 2 | `SKETCH_NAME` | VARCHAR2(16) |  |  |
| 3 | `SKETCH_VIEW` | LONG RAW |  |  |
| 4 | `SKETCH_NOTES` | VARCHAR2(1024) |  |  |
| 5 | `SKETCH_SYS_NOTE` | VARCHAR2(255) |  |  |
| 6 | `SKETCH_STATUS` | NUMBER(2,0) |  |  |

- **PK:** `SKETCH_ID`
- **Index** unique `SYS_C0036697`: `SKETCH_ID`

### SKID_DATA_ERROR_LOG

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LOG_DATE` 🔑 | DATE | NOT NULL |  |
| 3 | `ENTER_BY` | VARCHAR2(32) | NOT NULL |  |
| 4 | `LOG_DESC` | VARCHAR2(1024) | NOT NULL |  |
| 5 | `NOTIFIED_DATE` | DATE |  |  |
| 6 | `NOTIFIED_TO` | VARCHAR2(512) |  |  |

- **PK:** `SHEET_SKID_NUM`, `LOG_DATE`
- **Index** unique `SYS_C0036764`: `SHEET_SKID_NUM`, `LOG_DATE`

### SKID_ONHOLD_REASON_TRACK

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LOG_DATE` 🔑 | TIMESTAMP(6) | NOT NULL |  |
| 3 | `PRE_STATUS` | NUMBER(4,0) |  |  |
| 4 | `CUR_STATUS` | NUMBER(4,0) |  |  |
| 5 | `PRE_ONHOLD_REASON_CODE` | NUMBER(3,0) |  |  |
| 6 | `CUR_ONHOLD_REASON_CODE` | NUMBER(3,0) |  |  |
| 7 | `MODIFIED_BY` | VARCHAR2(15) |  |  |
| 8 | `NEW_SKID` | CHAR(1) |  |  |

- **PK:** `SHEET_SKID_NUM`, `LOG_DATE`
- **Index** unique `PFK_SKID_ONHOLD_REASON_TRACK`: `SHEET_SKID_NUM`, `LOG_DATE`

### SKID_STATUS

_~18 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SKID_STATUS_CODE` | NUMBER |  |  |
| 2 | `SKID_STATUS_DESC` | VARCHAR2(50) |  |  |

- **Index** `IDX1_SKID_STATUS`: `SKID_STATUS_CODE`

### SKID_TRACK

_~444,541 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `LOG_DATE` 🔑 | DATE | NOT NULL |  |
| 3 | `PRE_STATUS` | NUMBER(4,0) |  |  |
| 4 | `CUR_STATUS` | NUMBER(4,0) |  |  |
| 5 | `PRE_SHEET_NET_WT` | NUMBER(8,0) |  |  |
| 6 | `CUR_SHEET_NET_WT` | NUMBER(8,0) |  |  |
| 7 | `PRE_SKID_PIECES` | NUMBER(8,0) |  |  |
| 8 | `CUR_SKID_PIECES` | NUMBER(8,0) |  |  |
| 9 | `MODIFIED_BY` | VARCHAR2(15) |  |  |
| 10 | `PRE_REF_ORDER_NO` | NUMBER(8,0) |  |  |
| 11 | `CUR_REF_ORDER_NO` | NUMBER(8,0) |  |  |
| 12 | `PRE_TARE_WT` | NUMBER(8,0) |  |  |
| 13 | `CUR_TARE_WT` | NUMBER(8,0) |  |  |
| 14 | `PRE_AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 15 | `CUR_AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 16 | `RECORD_DELETED` | NUMBER(1,0) |  |  |

- **PK:** `SHEET_SKID_NUM`, `LOG_DATE`
- **Index** unique `SKID_TRACK_PK1`: `SHEET_SKID_NUM`, `LOG_DATE`

### SMACTUALPARAMETER_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `NUMBERPARAMETER_VALUE_` | NUMBER(10,0) |  |  |
| 4 | `STRINGPARAMETER_VALUE_` | VARCHAR2(512) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036699`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMAGENTJOB_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `AGENTJOB_STATE_` | NUMBER(10,0) |  |  |
| 4 | `AGENTJOB_FINISHSTATE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036700`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMARCHIVE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `ARCHIVE_PRDLOCATION_` | VARCHAR2(512) |  |  |
| 4 | `ARCHIVE_ARCHIVELOCATION_` | VARCHAR2(512) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036701`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMBREAKABLELINKS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LHSID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `LHSTYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 3 | `RHSID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 4 | `RHSTYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 5 | `ASSOCIATION_ID_` 🔑 | NUMBER(10,0) | NOT NULL |  |

- **PK:** `LHSTYPE`, `LHSID`, `RHSTYPE`, `RHSID`, `ASSOCIATION_ID_`
- **Index** `SMLHSINDEX`: `LHSID`, `LHSTYPE`
- **Index** `SMRHSINDEX`: `RHSID`, `RHSTYPE`
- **Index** unique `SYS_C0036702`: `LHSTYPE`, `LHSID`, `RHSTYPE`, `RHSID`, `ASSOCIATION_ID_`

### SMCLIQUE

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CLIQUEID` | NUMBER(10,0) |  |  |
| 2 | `ID` | NUMBER(10,0) |  |  |
| 3 | `TYPE` | NUMBER(10,0) |  |  |


### SMCONFIGURATION

_~1 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ATTRIBUTE` 🔑 | VARCHAR2(20) | NOT NULL |  |
| 2 | `VALUE` | VARCHAR2(512) |  |  |

- **PK:** `ATTRIBUTE`
- **Index** unique `SYS_C0036703`: `ATTRIBUTE`

### SMCONSOLESOSETTING_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `CSOSETTING_SOSETTING_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036704`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMDATABASE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `DATABASE_NAME_` | VARCHAR2(512) |  |  |
| 4 | `DATABASE_DESCRIPTION_` | VARCHAR2(512) |  |  |
| 5 | `DATABASE_CONNECTSTRING_` | VARCHAR2(512) |  |  |
| 6 | `DATABASE_STATE_` | NUMBER(10,0) |  |  |
| 7 | `DATABASE_ARCHIVELM_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036705`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMDBAUTH_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `DBAUTH_CONSOLEUSER_` | VARCHAR2(512) |  |  |
| 4 | `DBAUTH_DBUSERNAME_` | VARCHAR2(512) |  |  |
| 5 | `DBAUTH_ISDBUSERNAMESET_` | NUMBER(10,0) |  |  |
| 6 | `DBAUTH_DBPASSWORD_` | VARCHAR2(512) |  |  |
| 7 | `DBAUTH_ISDBPASSWORDSET_` | NUMBER(10,0) |  |  |
| 8 | `DBAUTH_INTERNALPASSWORD_` | VARCHAR2(512) |  |  |
| 9 | `DBAUTH_ISINTERNALPASSWORDSET_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036706`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMDEFAUTH_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `DEFAUTH_CONSOLEUSER_` | VARCHAR2(512) |  |  |
| 4 | `DEFAUTH_OSUSERNAME_` | VARCHAR2(512) |  |  |
| 5 | `DEFAUTH_ISOSUSERNAMESET_` | NUMBER(10,0) |  |  |
| 6 | `DEFAUTH_OSPASSWORD_` | VARCHAR2(512) |  |  |
| 7 | `DEFAUTH_ISOSPASSWORDSET_` | NUMBER(10,0) |  |  |
| 8 | `DEFAUTH_DBUSERNAME_` | VARCHAR2(512) |  |  |
| 9 | `DEFAUTH_ISDBUSERNAMESET_` | NUMBER(10,0) |  |  |
| 10 | `DEFAUTH_DBPASSWORD_` | VARCHAR2(512) |  |  |
| 11 | `DEFAUTH_ISDBPASSWORDSET_` | NUMBER(10,0) |  |  |
| 12 | `DEFAUTH_INTERNALPASSWORD_` | VARCHAR2(512) |  |  |
| 13 | `DEFAUTH_ISINTERNALPASSWORDSET_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036707`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMDEPENDENTLINKS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DEPENDENTID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `DEPENDENTTYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 3 | `DEPENDEEID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 4 | `DEPENDEETYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 5 | `ASSOCIATION_ID_` 🔑 | NUMBER(10,0) | NOT NULL |  |

- **PK:** `DEPENDEEID`, `DEPENDENTID`, `ASSOCIATION_ID_`, `DEPENDEETYPE`, `DEPENDENTTYPE`
- **Index** `SMDEPENDEEINDEX`: `DEPENDEEID`, `DEPENDEETYPE`
- **Index** `SMDEPENDENTINDEX`: `DEPENDENTID`, `DEPENDENTTYPE`
- **Index** unique `SYS_C0036708`: `DEPENDEEID`, `DEPENDENTID`, `ASSOCIATION_ID_`, `DEPENDEETYPE`, `DEPENDENTTYPE`

### SMDISTRIBUTIONSET_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `DISTRIBUTIONSET_STATE_` | NUMBER(10,0) |  |  |
| 4 | `DISTRIBUTIONSET_LOCATION_` | VARCHAR2(512) |  |  |
| 5 | `DISTRIBUTIONSET_OS_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036709`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMFOLDER_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `FOLDER_FOLDERNAME_` | VARCHAR2(512) |  |  |
| 4 | `FOLDER_DESCRIPTION_` | VARCHAR2(512) |  |  |
| 5 | `FOLDER_LASTUPDATE_` | DATE |  |  |
| 6 | `FOLDER_USERDATA1_` | NUMBER(10,0) |  |  |
| 7 | `FOLDER_USERDATA2_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036710`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMFORMALPARAMETER_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `FORMALPARAMETER_PARAMETERNAME_` | VARCHAR2(512) |  |  |
| 4 | `FORMALPARAMETER_DESCRIPTION_` | VARCHAR2(512) |  |  |
| 5 | `FORMALPARAMETER_ISSCALAR_` | NUMBER(10,0) |  |  |
| 6 | `FORMALPARAMETER_ISMANDATORY_` | NUMBER(10,0) |  |  |
| 7 | `FORMALPARAMETER_USERDEFFLAG_` | NUMBER(10,0) |  |  |
| 8 | `NUMBERFORMALPARAMETER_LBOUND_` | NUMBER(10,0) |  |  |
| 9 | `NUMBERFORMALPARAMETER_UBOUND_` | NUMBER(10,0) |  |  |
| 10 | `OBJECTFORMALPARAMETER_FPOT_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036711`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMGLOBALCONFIGURATION_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `GCONFIG_VERSION_` | VARCHAR2(512) |  |  |
| 4 | `CCONFIG_NAME_` | VARCHAR2(512) |  |  |
| 5 | `CCONFIG_TIME_` | DATE |  |  |
| 6 | `HCONFIG_SOSETTING_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036712`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMHOSTAUTH_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `HOSTAUTH_CONSOLEUSER_` | VARCHAR2(512) |  |  |
| 4 | `HOSTAUTH_OSUSERNAME_` | VARCHAR2(512) |  |  |
| 5 | `HOSTAUTH_ISOSUSERNAMESET_` | NUMBER(10,0) |  |  |
| 6 | `HOSTAUTH_OSPASSWORD_` | VARCHAR2(512) |  |  |
| 7 | `HOSTAUTH_ISOSPASSWORDSET_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036713`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMHOST_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `HOST_HOSTNAME_` | VARCHAR2(512) |  |  |
| 4 | `HOST_RPCADDRESS_` | VARCHAR2(512) |  |  |
| 5 | `HOST_FTPADDRESS_` | VARCHAR2(512) |  |  |
| 6 | `HOST_OS_` | VARCHAR2(512) |  |  |
| 7 | `HOST_OSVERSION_` | VARCHAR2(512) |  |  |
| 8 | `HOST_STATE_` | NUMBER(10,0) |  |  |
| 9 | `HOST_ISSOSERVER_` | NUMBER(10,0) |  |  |
| 10 | `HOST_ISDISTRIBUTIONHOST_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036714`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMINSTALLATION_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `INSTALLATION_ORACLEHOME_` | VARCHAR2(512) |  |  |
| 4 | `INSTALLATION_LANGUAGE_` | VARCHAR2(512) |  |  |
| 5 | `INSTALLATION_OS_` | VARCHAR2(512) |  |  |
| 6 | `INSTALLATION_OSVERSION_` | VARCHAR2(512) |  |  |
| 7 | `INSTALLATION_MACHINETYPE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036715`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMLOGMESSAGE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `LOGMESSAGE_TIME_` | DATE |  |  |
| 4 | `LOGMESSAGE_PROGRAMCOUNTER_` | VARCHAR2(512) |  |  |
| 5 | `LOGMESSAGE_MESSAGE_` | VARCHAR2(512) |  |  |
| 6 | `LOGMESSAGE_KIND_` | NUMBER(10,0) |  |  |
| 7 | `LOGMESSAGE_PRIORITY_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036716`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMMONTHLYENTRY_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `MONTHLYENTRY_DAY_` | NUMBER(10,0) |  |  |
| 4 | `MONTHLYENTRY_TOFDAY_SPM_` | NUMBER(10,0) |  |  |
| 5 | `MONTHLYENTRY_TOFDAY_ZONE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036717`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMMONTHWEEKENTRY_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `MONTHWEEKENTRY_DAY_WKOFMON_` | NUMBER(10,0) |  |  |
| 4 | `MONTHWEEKENTRY_DAY_DOFWK_` | NUMBER(10,0) |  |  |
| 5 | `MONTHWEEKENTRY_TOFDAY_SPM_` | NUMBER(10,0) |  |  |
| 6 | `MONTHWEEKENTRY_TOFDAY_ZONE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036718`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMMOWNERLINKS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `MOWNERID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `MOWNERTYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 3 | `MOWNEEID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 4 | `MOWNEETYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 5 | `ASSOCIATION_ID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 6 | `ASSOCIATION_REMARKS_` | VARCHAR2(256) |  |  |

- **PK:** `MOWNERID`, `MOWNEEID`, `ASSOCIATION_ID_`, `MOWNERTYPE`, `MOWNEETYPE`
- **Index** `SMMOWNEEINDEX`: `MOWNEEID`, `MOWNEETYPE`
- **Index** `SMMOWNERINDEX`: `MOWNERID`, `MOWNERTYPE`
- **Index** unique `SYS_C0036719`: `MOWNERID`, `MOWNEEID`, `ASSOCIATION_ID_`, `MOWNERTYPE`, `MOWNEETYPE`

### SMOMSTRING_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `OMSTRING_VALUE_` | VARCHAR2(512) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036720`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMOSNAMES_X

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `OS` | VARCHAR2(80) |  |  |


### SMOWNERLINKS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `OWNERID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `OWNERTYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 3 | `OWNEEID` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 4 | `OWNEETYPE` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 5 | `ASSOCIATION_ID_` 🔑 | NUMBER(10,0) | NOT NULL |  |

- **PK:** `OWNERID`, `OWNEEID`, `ASSOCIATION_ID_`, `OWNERTYPE`, `OWNEETYPE`
- **Index** `SMOWNEEINDEX`: `OWNEEID`, `OWNEETYPE`
- **Index** `SMOWNERINDEX`: `OWNERID`, `OWNERTYPE`
- **Index** unique `SYS_C0036721`: `OWNERID`, `OWNEEID`, `ASSOCIATION_ID_`, `OWNERTYPE`, `OWNEETYPE`

### SMPACKAGE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `PACKAGE_NAME_` | VARCHAR2(512) |  |  |
| 4 | `PACKAGE_OS_` | VARCHAR2(512) |  |  |
| 5 | `PACKAGE_CREATIONDATE_` | DATE |  |  |
| 6 | `PACKAGE_STATE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036722`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMPARALLELJOB_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `PARALLELJOB_ISSELFDELETING_` | NUMBER(10,0) |  |  |
| 4 | `PARALLELJOB_LASTSAVETIME_` | DATE |  |  |
| 5 | `PARALLELJOB_STATE_` | NUMBER(10,0) |  |  |
| 6 | `PARALLELJOB_FINISHSTATE_` | NUMBER(10,0) |  |  |
| 7 | `PARALLELJOB_OEMJOBID_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036723`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMPARALLELOPERATION_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `PARALLELOPERATION_NAME_` | VARCHAR2(512) |  |  |
| 4 | `PARALLELOPERATION_DESCRIPTION_` | VARCHAR2(512) |  |  |
| 5 | `PARALLELOPERATION_PARALLEL_` | NUMBER(10,0) |  |  |
| 6 | `BUILTINOPERATION_BUILTINID_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036724`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMPARALLELSTATEMENT_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `PARALLELSTATEMENT_POSITION_` | NUMBER(10,0) |  |  |
| 4 | `PARALLELSTATEMENT_CONTINUE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036725`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMPRODUCTATTRIBUTE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `PRODUCTATTRIBUTE_PRODUCTNAME_` | VARCHAR2(512) |  |  |
| 4 | `PRODUCTATTRIBUTE_ITFCLABEL_` | VARCHAR2(512) |  |  |
| 5 | `PRODUCTATTRIBUTE_VERSION_` | VARCHAR2(512) |  |  |
| 6 | `PRODUCTATTRIBUTE_OS_` | VARCHAR2(512) |  |  |
| 7 | `PRODUCTATTRIBUTE_PRODUCTSIZE_` | NUMBER(10,0) |  |  |
| 8 | `PRODUCTATTRIBUTE_PRDPATH_` | VARCHAR2(256) |  |  |
| 9 | `PRODUCTATTRIBUTE_PARENT_` | VARCHAR2(256) |  |  |
| 10 | `PRODUCTATTRIBUTE_VISIBLE_` | VARCHAR2(256) |  |  |
| 11 | `PRODUCTATTRIBUTE_OPEN_` | VARCHAR2(256) |  |  |
| 12 | `PRODUCTATTRIBUTE_DESCR_` | VARCHAR2(512) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036726`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMPRODUCT_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `PRODUCT_OWNERID_` | NUMBER(10,0) |  |  |
| 4 | `PRODUCT_OWNERTYPE_` | NUMBER(10,0) |  |  |
| 5 | `PRODUCT_PRODUCTID_` | NUMBER(10,0) |  |  |
| 6 | `PRODUCT_DEPENDENCIES_` | VARCHAR2(512) |  |  |
| 7 | `PRODUCT_SHARABLE_` | VARCHAR2(10) |  |  |
| 8 | `PRODUCT_SELECTED_` | VARCHAR2(10) |  |  |
| 9 | `PRODUCT_PRDFILE_` | VARCHAR2(512) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036727`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMP_AD_ADDRESSES_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `NODE` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 3 | `ALIAS` 🔑 | VARCHAR2(512) | NOT NULL |  |
| 4 | `ADDRESS` | VARCHAR2(1024) |  |  |

- **PK:** `OWNER`, `NODE`, `ALIAS`
- **Index** unique `SYS_C0036728`: `OWNER`, `NODE`, `ALIAS`

### SMP_AD_DISCOVERED_NODES_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `NODE` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 3 | `ADDRESS` | VARCHAR2(1024) |  |  |

- **PK:** `OWNER`, `NODE`
- **Index** unique `SYS_C0036729`: `OWNER`, `NODE`

### SMP_AD_NODES_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `NODE` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 3 | `REMOTE_NAME` | VARCHAR2(120) |  |  |
| 4 | `SELECTED_FOR_DISCOVERY` | NUMBER(1,0) |  |  |
| 5 | `DISCOVER_STATE` | VARCHAR2(120) |  |  |
| 6 | `DISCOVER_FLAGS` | NUMBER(1,0) |  |  |
| 7 | `DISCOVER_TIME` | DATE |  |  |
| 8 | `LAST_CONTACT_ATTEMPT` | DATE |  |  |
| 9 | `SEQUENCE` | NUMBER(6,0) |  |  |

- **PK:** `OWNER`, `NODE`
- **Index** unique `SYS_C0036730`: `OWNER`, `NODE`

### SMP_AD_PARMS_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `BACKGROUND_DISCOVERY` 🔑 | NUMBER | NOT NULL |  |
| 3 | `BACKGROUND_FREQUENCY` 🔑 | NUMBER(7,0) | NOT NULL |  |

- **PK:** `OWNER`, `BACKGROUND_DISCOVERY`, `BACKGROUND_FREQUENCY`
- **Index** unique `SYS_C0036731`: `OWNER`, `BACKGROUND_DISCOVERY`, `BACKGROUND_FREQUENCY`

### SMP_AUTO_DISCOVERY_ITEM_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `IPADDR_BYTE1` 🔑 | NUMBER | NOT NULL |  |
| 3 | `IPADDR_BYTE2` 🔑 | NUMBER | NOT NULL |  |
| 4 | `IPADDR_BYTE3` 🔑 | NUMBER | NOT NULL |  |
| 5 | `IPADDR_BYTE4` | NUMBER |  |  |
| 6 | `IPADDR_BYTE4_UPPERLIMIT` 🔑 | NUMBER | NOT NULL |  |
| 7 | `IPADDR_BYTE4_LASTUSED` 🔑 | NUMBER | NOT NULL |  |

- **PK:** `OWNER`, `IPADDR_BYTE1`, `IPADDR_BYTE2`, `IPADDR_BYTE3`, `IPADDR_BYTE4_UPPERLIMIT`, `IPADDR_BYTE4_LASTUSED`
- **Index** unique `SYS_C0036732`: `OWNER`, `IPADDR_BYTE1`, `IPADDR_BYTE2`, `IPADDR_BYTE3`, `IPADDR_BYTE4_UPPERLIMIT`, `IPADDR_BYTE4_LASTUSED`

### SMP_AUTO_DISCOVERY_PARMS_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `AD_FREQUENCY` 🔑 | NUMBER | NOT NULL |  |
| 3 | `AD_CONN_TIMEOUT` 🔑 | NUMBER | NOT NULL |  |
| 4 | `AD_UPDATE_FREQUENCY` 🔑 | NUMBER | NOT NULL |  |
| 5 | `AD_UPDATE_COUNT` 🔑 | NUMBER | NOT NULL |  |
| 6 | `AD_ENABLE` | NUMBER(1,0) |  |  |

- **PK:** `OWNER`, `AD_FREQUENCY`, `AD_CONN_TIMEOUT`, `AD_UPDATE_FREQUENCY`, `AD_UPDATE_COUNT`
- **Index** unique `SYS_C0036733`: `OWNER`, `AD_FREQUENCY`, `AD_CONN_TIMEOUT`, `AD_UPDATE_FREQUENCY`, `AD_UPDATE_COUNT`

### SMP_BLOB_

_~9 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `ID` 🔑 | VARCHAR2(125) | NOT NULL |  |
| 3 | `SUBID` 🔑 | VARCHAR2(125) | NOT NULL |  |
| 4 | `LEN` | NUMBER |  |  |
| 5 | `DATA` | LONG RAW |  |  |

- **PK:** `OWNER`, `ID`, `SUBID`
- **Index** `REPOSITORY_BLOB_ID`: `ID`, `SUBID`
- **Index** unique `SYS_C0036734`: `OWNER`, `ID`, `SUBID`

### SMP_BRM_ACTIVE_JOB_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `JOBID` | VARCHAR2(32) |  |  |
| 2 | `TARGETDB` | VARCHAR2(32) |  |  |
| 3 | `JOBNAME` | VARCHAR2(32) |  |  |


### SMP_BRM_CHANNEL_DEVICE_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CHANNELNAME` | VARCHAR2(32) |  |  |
| 2 | `FORMATSTRING` | VARCHAR2(256) |  |  |
| 3 | `FORMATDEST` | VARCHAR2(256) |  |  |
| 4 | `CHANNELDEVICE` | VARCHAR2(8) |  |  |
| 5 | `DEVICENAME` | VARCHAR2(32) |  |  |
| 6 | `DEVICETYPE` | VARCHAR2(32) |  |  |
| 7 | `PARAMETERS` | VARCHAR2(32) |  |  |
| 8 | `LIMITSIZE` | VARCHAR2(8) |  |  |
| 9 | `READRATE` | VARCHAR2(8) |  |  |
| 10 | `OPENFILES` | VARCHAR2(8) |  |  |
| 11 | `DBNAME` | VARCHAR2(32) |  |  |


### SMP_BRM_DEFAULT_CHANNEL_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CHANNELNAME` | VARCHAR2(32) |  |  |
| 2 | `DBNAME` | VARCHAR2(32) |  |  |


### SMP_BRM_RC_CONNECT_STRING_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `DBNAME` | VARCHAR2(32) |  |  |
| 2 | `USERNAME` | VARCHAR2(255) |  |  |
| 3 | `PASSWORD` | RAW(255) |  |  |
| 4 | `SERVICE` | VARCHAR2(255) |  |  |


### SMP_BRM_SAVED_JOB_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `JOBNAME` | VARCHAR2(32) |  |  |
| 2 | `JOBDESCRIPTION` | VARCHAR2(32) |  |  |
| 3 | `DBNAME` | VARCHAR2(32) |  |  |


### SMP_BRM_TEMP_SCRIPTS_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `JOBID` | VARCHAR2(32) |  |  |
| 2 | `TCLSCRIPT` | VARCHAR2(512) |  |  |
| 3 | `RMANSCRIPT` | VARCHAR2(512) |  |  |


### SMP_CREDENTIALS$

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `SERVICE_TYPE` | NUMBER |  |  |
| 3 | `SERVICE_NAME` | VARCHAR2(255) |  |  |
| 4 | `USERNAME` | VARCHAR2(255) |  |  |
| 5 | `PASSWORD` | RAW(255) |  |  |
| 6 | `ROLE` | VARCHAR2(10) |  |  |


### SMP_EBU_ACTIVE_JOB_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `JOBID` | VARCHAR2(32) |  |  |
| 2 | `TARGETDB` | VARCHAR2(32) |  |  |
| 3 | `JOBNAME` | VARCHAR2(32) |  |  |


### SMP_EBU_SAVED_JOB_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `JOBNAME` | VARCHAR2(32) |  |  |
| 2 | `JOBDESCRIPTION` | VARCHAR2(32) |  |  |
| 3 | `DBNAME` | VARCHAR2(32) |  |  |


### SMP_JOB_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ID` 🔑 | NUMBER | NOT NULL |  |
| 3 | `NAME` | VARCHAR2(64) |  |  |
| 4 | `TYPE` | NUMBER |  |  |
| 5 | `SERVICE_ID` | VARCHAR2(255) |  |  |
| 6 | `SCHEDULE` | VARCHAR2(512) |  |  |
| 7 | `MACHINE_NAME` | VARCHAR2(255) |  |  |
| 8 | `READONLY` | NUMBER |  |  |
| 9 | `JOB_DESCRIPTION` | VARCHAR2(255) |  |  |
| 10 | `FIXEDIT` | NUMBER |  |  |
| 11 | `LIBRARY` | NUMBER |  |  |
| 12 | `JOB_TMPSCRIPTFILE` | VARCHAR2(100) |  |  |

- **PK:** `ID`
- **Index** unique `PK_JOBID`: `ID`

### SMP_JOB_EVENTLIST_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ID` | NUMBER |  |  |

- **Index** `I_SMP_JOB_EVENTLIST_ID`: `ID`

### SMP_JOB_HISTORY_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ID` | NUMBER |  |  |
| 3 | `NAME` | VARCHAR2(32) |  |  |
| 4 | `TYPE` | NUMBER |  |  |
| 5 | `AGENT_JOB_ID` | NUMBER |  |  |
| 6 | `STATUS` | NUMBER |  |  |
| 7 | `TIMESTAMP` | DATE |  |  |
| 8 | `DESTINATION` | VARCHAR2(100) |  |  |
| 9 | `TOTAL_PARAMS` | NUMBER |  |  |
| 10 | `PARAMETERS` | VARCHAR2(512) |  |  |
| 11 | `OUTPUT_DATA` | NUMBER |  |  |
| 12 | `EXECUTION` | NUMBER |  |  |

- **Index** `SMP_JOB_HISTORY_INDEX`: `ID`, `DESTINATION`, `EXECUTION`

### SMP_JOB_INSTANCE_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ID` | NUMBER |  |  |
| 3 | `AGENT_JOB_ID` | NUMBER |  |  |
| 4 | `NODE` | VARCHAR2(80) |  |  |
| 5 | `DESTINATION` | VARCHAR2(512) |  |  |
| 6 | `DESTINATION_TYPE` | NUMBER |  |  |
| 7 | `STATUS` | NUMBER |  |  |
| 8 | `NEXT_EXECUTION` | DATE |  |  |
| 9 | `PARAMETERS` | VARCHAR2(1024) |  |  |
| 10 | `GROUP_NAME` | VARCHAR2(64) |  |  |
| 11 | `STATE` | VARCHAR2(8) |  |  |
| 12 | `EXECUTION` | NUMBER |  |  |

- **Index** `I_SMP_JOB_INSTANCE_ID`: `ID`

### SMP_JOB_LIBRARY_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `LIBNAME` | VARCHAR2(64) |  |  |
| 3 | `JOBNAME` | VARCHAR2(64) |  |  |
| 4 | `DESTINATIONTYPE` | NUMBER |  |  |
| 5 | `JOBID` | NUMBER |  |  |


### SMP_JOB_TASK_INSTANCE_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ID` | NUMBER |  |  |
| 3 | `TASK_LEVEL` | NUMBER |  |  |
| 4 | `TASK_SEQUENCE` | NUMBER |  |  |
| 5 | `CLSID` | VARCHAR2(128) |  |  |
| 6 | `DISPLAY_NAME` | VARCHAR2(80) |  |  |
| 7 | `LENGTH` | NUMBER |  |  |

- **FK:** (`ID`) → `SMP_JOB_` (`ID`)
- **Index** `I_SMP_JOB_TASK_INSTANCE_ID`: `ID`

### SMP_LONG_TEXT_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `ID` | NUMBER |  |  |
| 3 | `LEN` | NUMBER |  |  |
| 4 | `DATA` | LONG |  |  |

- **Index** `SMP_LONG_TEXT_INDEX`: `ID`

### SMP_REP_VERSION

_~3 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `C_COMPONENT` | VARCHAR2(255) |  |  |
| 2 | `C_CURRENT_VERSION` | VARCHAR2(255) |  |  |
| 3 | `C_UNUSED` | VARCHAR2(255) |  |  |


### SMP_SERVICES

_~1 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TYPE` | NUMBER |  |  |
| 2 | `CLSID` | VARCHAR2(128) |  |  |
| 3 | `INTNAME` | VARCHAR2(128) |  |  |


### SMP_SERVICE_DATA_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `SERVICE_NAME` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 3 | `SERVICE_TYPE` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 4 | `NODE` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 5 | `DATA` | VARCHAR2(1024) |  |  |

- **PK:** `OWNER`, `SERVICE_NAME`, `SERVICE_TYPE`, `NODE`
- **Index** unique `SYS_C0036736`: `OWNER`, `SERVICE_NAME`, `SERVICE_TYPE`, `NODE`

### SMP_SERVICE_GROUP_DEFN_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `GROUP_NAME` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 3 | `GROUP_TYPE` 🔑 | NUMBER | NOT NULL |  |

- **PK:** `OWNER`, `GROUP_NAME`, `GROUP_TYPE`
- **Index** unique `SYS_C0036737`: `OWNER`, `GROUP_NAME`, `GROUP_TYPE`

### SMP_SERVICE_GROUP_ITEM_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `GROUP_NAME` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 3 | `OBJECT_NAME` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 4 | `OBJECT_TYPE` 🔑 | NUMBER | NOT NULL |  |
| 5 | `ISAGROUP` | VARCHAR2(4) |  |  |

- **PK:** `OWNER`, `GROUP_NAME`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** unique `SYS_C0036738`: `OWNER`, `GROUP_NAME`, `OBJECT_NAME`, `OBJECT_TYPE`

### SMP_SERVICE_ITEM_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `SERVICE_NAME` 🔑 | VARCHAR2(120) | NOT NULL |  |
| 3 | `SERVICE_TYPE` 🔑 | NUMBER | NOT NULL |  |
| 4 | `NODE` | VARCHAR2(120) |  |  |
| 5 | `LISTENER_LIST` | VARCHAR2(120) |  |  |
| 6 | `OPSNAME` | VARCHAR2(120) |  |  |

- **PK:** `OWNER`, `SERVICE_NAME`, `SERVICE_TYPE`
- **Index** unique `SYS_C0036739`: `OWNER`, `SERVICE_NAME`, `SERVICE_TYPE`

### SMP_UPDATESERVICES_CALLED_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 2 | `CALLED` 🔑 | NUMBER | NOT NULL |  |

- **PK:** `OWNER`, `CALLED`
- **Index** unique `SYS_C0036740`: `OWNER`, `CALLED`

### SMP_USER_DETAILS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USERNAME` | VARCHAR2(255) |  |  |
| 2 | `MACHINE` | VARCHAR2(255) |  |  |
| 3 | `LOGGED_AT` | DATE |  |  |


### SMP_VAB_ACTIVE_JOB_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `JOBID` | VARCHAR2(32) |  |  |
| 2 | `TARGETDB` | VARCHAR2(32) |  |  |
| 3 | `JOBNAME` | VARCHAR2(32) |  |  |


### SMP_VAB_SAVED_JOB_

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `JOBNAME` | VARCHAR2(32) |  |  |
| 2 | `JOBDESCRIPTION` | VARCHAR2(32) |  |  |
| 3 | `DBNAME` | VARCHAR2(32) |  |  |


### SMRELEASE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `RELEASE_STATE_` | NUMBER(10,0) |  |  |
| 4 | `RELEASE_MEDIATYPE_` | NUMBER(10,0) |  |  |
| 5 | `RELEASE_PRODFILETYPE_` | NUMBER(10,0) |  |  |
| 6 | `RELEASE_LOCATION_` | VARCHAR2(512) |  |  |
| 7 | `RELEASE_DESCRIPTION_` | VARCHAR2(512) |  |  |
| 8 | `RELEASE_PARTNUMBER_` | VARCHAR2(512) |  |  |
| 9 | `RELEASE_THIRDPARTYRELEASEPRAM_` | VARCHAR2(512) |  |  |
| 10 | `RELEASE_USERREMARK_` | VARCHAR2(512) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036741`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMRUN_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `RUN_STATE_` | NUMBER(10,0) |  |  |
| 4 | `RUN_STARTTIME_` | DATE |  |  |
| 5 | `RUN_ENDTIME_` | DATE |  |  |
| 6 | `RUN_PROGRAMCOUNTER_` | VARCHAR2(512) |  |  |
| 7 | `RUN_FINISHSTATE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036742`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMSCHEDULE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `SCHEDULE_HASEXPIRATION_` | NUMBER(10,0) |  |  |
| 4 | `SCHEDULE_EXP_DATE_` | DATE |  |  |
| 5 | `SCHEDULE_EXP_TOD_SPM_` | NUMBER(10,0) |  |  |
| 6 | `SCHEDULE_EXP_TOD_ZONE_` | NUMBER(10,0) |  |  |
| 7 | `REPEATED_ISIMMEDIATE_` | NUMBER(10,0) |  |  |
| 8 | `REPEATED_STARTTIME_DATE_` | DATE |  |  |
| 9 | `REPEATED_STARTTIME_TOD_SPM_` | NUMBER(10,0) |  |  |
| 10 | `REPEATED_STARTTIME_TOD_ZONE_` | NUMBER(10,0) |  |  |
| 11 | `REPEATED_SECONDSINPERIOD_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036743`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMSHAREDORACLECLIENT_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `SOCLIENT_NAME_` | VARCHAR2(512) |  |  |
| 4 | `SOCLIENT_OS_` | VARCHAR2(512) |  |  |
| 5 | `SOCLIENT_OSVER_` | VARCHAR2(512) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036744`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMSHAREDORACLECONFIGURATION_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `SOCONFIG_NAME_` | VARCHAR2(512) |  |  |
| 4 | `SOCONFIG_OS_` | VARCHAR2(512) |  |  |
| 5 | `SOCONFIG_SOSETTING_` | NUMBER(10,0) |  |  |
| 6 | `SOCONFIG_KIND_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036745`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMTABLESPACE_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `TABLESPACE_NAME_` | VARCHAR2(512) |  |  |
| 4 | `TABLESPACE_FREESPACE_` | NUMBER(10,0) |  |  |
| 5 | `TABLESPACE_TOTALSPACE_` | NUMBER(10,0) |  |  |
| 6 | `TABLESPACE_LARGESTFEXT_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036746`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMVCENDPOINT_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `VC_ISLIVE_` | NUMBER(10,0) |  |  |
| 4 | `VC_TYPE_` | NUMBER(10,0) |  |  |
| 5 | `VC_NAME_` | VARCHAR2(512) |  |  |
| 6 | `VC_TIME_` | DATE |  |  |
| 7 | `VC_LASTMESSAGENO_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036747`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SMWEEKLYENTRY_S

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `NAMEDOBJECT_ID_SEQUENCEID_` 🔑 | NUMBER(10,0) | NOT NULL |  |
| 2 | `NAMEDOBJECT_ID_OBJECTTYPE_` | NUMBER(10,0) |  |  |
| 3 | `WEEKLYENTRY_DAY_` | NUMBER(10,0) |  |  |
| 4 | `WEEKLYENTRY_TOFDAY_SPM_` | NUMBER(10,0) |  |  |
| 5 | `WEEKLYENTRY_TOFDAY_ZONE_` | NUMBER(10,0) |  |  |

- **PK:** `NAMEDOBJECT_ID_SEQUENCEID_`
- **Index** unique `SYS_C0036748`: `NAMEDOBJECT_ID_SEQUENCEID_`

### SPLIT_SKID

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `AB_JOB_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `COIL_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `SHEET_SKID_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 4 | `SHEET_SKID_NUM_WITH_LETTER` | VARCHAR2(16) |  |  |
| 5 | `COIL_ORG_NUM` | VARCHAR2(32) |  |  |
| 6 | `ITEM_SHEET_NET_WT` | NUMBER(8,0) |  |  |
| 7 | `ITEM_SKID_PIECES` | NUMBER(6,0) |  |  |
| 8 | `SUFFIX` | CHAR(1) |  |  |

- **PK:** `AB_JOB_NUM`, `COIL_ABC_NUM`, `SHEET_SKID_NUM`
- **Index** unique `PK_SPLIT_SKID`: `AB_JOB_NUM`, `COIL_ABC_NUM`, `SHEET_SKID_NUM`

### SPM_EFIC_STANDARD

_~97 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `PART_NUM_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `DIE_ID` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 4 | `SPM_STANDARD` | NUMBER(4,0) | NOT NULL |  |
| 5 | `EFFIC_PERCENT_STANDARD` | NUMBER(3,0) | NOT NULL |  |

- **PK:** `LINE_NUM`, `PART_NUM_ID`, `DIE_ID`
- **FK:** (`LINE_NUM`) → `LINE` (`LINE_NUM`)
- **FK:** (`PART_NUM_ID`) → `PART_NUM` (`PART_NUM_ID`)
- **FK:** (`DIE_ID`) → `DIE` (`DIE_ID`)
- **Index** unique `XPK_SPM_EFIC_STANDARD`: `LINE_NUM`, `PART_NUM_ID`, `DIE_ID`

### STATE

_~56 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `STATE` 🔑 | CHAR(2) | NOT NULL |  |
| 2 | `STATE_FULL_NAME` | VARCHAR2(30) |  |  |

- **PK:** `STATE`
- **Index** unique `SYS_C0036749`: `STATE`

### SUBSYSTEMEQUIPMENT

_~462 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SUBSYSEQUIPMENT_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SYSEQUIPMENT_ID` | NUMBER(8,0) |  |  |
| 3 | `GROUPDEPARTMENT_ID` | NUMBER(8,0) |  |  |
| 4 | `SUBSYSTEMEQUIPMENT` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `SUBSYSEQUIPMENT_ID`
- **FK:** (`SYSEQUIPMENT_ID`) → `SYSTEMEQUIPMENT` (`SYSEQUIPMENT_ID`)
- **FK:** (`GROUPDEPARTMENT_ID`) → `GROUPDEPARTMENT` (`GROUPDEPARTMENT_ID`)
- **Index** unique `SYS_C0036750`: `SUBSYSEQUIPMENT_ID`

### SUPPLIERS

_~76 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SUPPLIER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SUPPLIER_NAME` | VARCHAR2(64) | NOT NULL |  |
| 3 | `SUPPLIER_PHONE` | VARCHAR2(32) |  |  |
| 4 | `SUPPLIER_FAX` | VARCHAR2(32) |  |  |
| 5 | `SUPPLIER_ATTN_NAME` | VARCHAR2(64) |  |  |
| 6 | `SUPPLIER_CONTACT` | VARCHAR2(64) |  |  |
| 7 | `SUPPLIER_CONTACT_TITLE` | VARCHAR2(32) |  |  |
| 8 | `SUPPLIER_ADDRESS` | VARCHAR2(255) |  |  |
| 9 | `SUPPLIER_ADDRESS_2` | VARCHAR2(255) |  |  |
| 10 | `SUPPLIER_CITY` | VARCHAR2(32) |  |  |
| 11 | `SUPPLIER_ZIP` | VARCHAR2(32) |  |  |
| 12 | `SUPPLIER_STATE` | VARCHAR2(16) |  |  |
| 13 | `SUPPLIER_COUNTRY` | VARCHAR2(64) |  |  |
| 14 | `SUPPLIER_STATUS` | NUMBER(2,0) | NOT NULL |  |
| 15 | `SUPPLIER_EMAIL` | VARCHAR2(64) |  |  |
| 16 | `SUPPLIER_NOTES` | VARCHAR2(512) |  |  |
| 17 | `SUPPLIER_CELLPHONE` | VARCHAR2(32) |  |  |

- **PK:** `SUPPLIER_ID`
- **Index** unique `SYS_C0036751`: `SUPPLIER_ID`

### SUPPRESS_BARCODE_PRINT

_~86 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `COMPUTER_ID` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 2 | `CUSTOMER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `DES_SH_CUST_ID` 🔑 | VARCHAR2(10) | NOT NULL |  |
| 4 | `NOTE` | VARCHAR2(64) |  |  |
| 5 | `USER_ID` | NUMBER(8,0) |  |  |

- **PK:** `COMPUTER_ID`, `CUSTOMER_ID`, `DES_SH_CUST_ID`
- **Index** unique `SYS_C0036840`: `COMPUTER_ID`, `CUSTOMER_ID`, `DES_SH_CUST_ID`

### SYSTEMEQUIPMENT

_~132 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SYSEQUIPMENT_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `GROUPDEPARTMENT_ID` | NUMBER(8,0) |  |  |
| 3 | `SYSTEMEQUIPMENT` | VARCHAR2(128) | NOT NULL |  |

- **PK:** `SYSEQUIPMENT_ID`
- **FK:** (`GROUPDEPARTMENT_ID`) → `GROUPDEPARTMENT` (`GROUPDEPARTMENT_ID`)
- **Index** unique `SYS_C0036752`: `SYSEQUIPMENT_ID`

### SYSTEM_LOG

_~2,951 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SYSTEM_LOG_KEY_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `SYSTEM_LOG_TIMESTAMP` | DATE |  |  |
| 3 | `SYSTEM_LOG_CONTENTS` | VARCHAR2(1024) |  |  |
| 4 | `SYSTEM_LOG_FLAG` | NUMBER(1,0) |  |  |

- **PK:** `SYSTEM_LOG_KEY_NUM`
- **Index** unique `XPKSYSTEM_LOG`: `SYSTEM_LOG_KEY_NUM`

### SYSTEM_OPTIONS

_~4 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `SYSTEM_OPTIONS_ID` 🔑 | NUMBER | NOT NULL |  |
| 2 | `SYSTEM_OPTION_NAME` | VARCHAR2(50) | NOT NULL |  |
| 3 | `SYSTEM_OPTION_ENABLED` | CHAR(1) |  |  |
| 4 | `SYSTEM_OPTION_VALUE` | VARCHAR2(50) |  |  |
| 5 | `SYSTEM_OPTION_NOTES` | VARCHAR2(256) |  |  |

- **PK:** `SYSTEM_OPTIONS_ID`
- **Index** unique `SYS_C0036754`: `SYSTEM_OPTIONS_ID`

### SYS_EXPORT_SCHEMA_01

_~1,141 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036816): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_0000523DB_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_0000523DB_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_02

_~2,464 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036824): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_00005826C_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_00005826C_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_03

_~4,690 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036825): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058283_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058283_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_04

_~1,506 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036826): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_0000582E9_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_0000582E9_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_05

_~4,708 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036827): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058300_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058300_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_06

_~1,508 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036828): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058366_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058366_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_07

_~4,414 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036829): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_00005837D_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_00005837D_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_08

_~1,510 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036830): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_0000583E8_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_0000583E8_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_09

_~4,744 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036831): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058402_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058402_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_10

_~1,512 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036832): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_00005846D_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_00005846D_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_11

_~4,783 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036833): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058487_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058487_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_12

_~5,142 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036834): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058710_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058710_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_13

_~1,515 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036835): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_00005872A_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_00005872A_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_14

_~4,793 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036836): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058F2A_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058F2A_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_15

_~1,517 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036837): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000058F93_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000058F93_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_16

_~1,141 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036857): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_000085B04_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_000085B04_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_17

_~1,141 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036859): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_00008603B_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_00008603B_IND_2`: `BASE_PROCESS_ORDER`

### SYS_EXPORT_SCHEMA_18

_~1,141 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `PROCESS_ORDER` | NUMBER |  |  |
| 2 | `DUPLICATE` | NUMBER |  |  |
| 3 | `DUMP_FILEID` | NUMBER |  |  |
| 4 | `DUMP_POSITION` | NUMBER |  |  |
| 5 | `DUMP_LENGTH` | NUMBER |  |  |
| 6 | `DUMP_ORIG_LENGTH` | NUMBER |  |  |
| 7 | `DUMP_ALLOCATION` | NUMBER |  |  |
| 8 | `COMPLETED_ROWS` | NUMBER |  |  |
| 9 | `ERROR_COUNT` | NUMBER |  |  |
| 10 | `ELAPSED_TIME` | NUMBER |  |  |
| 11 | `OBJECT_TYPE_PATH` | VARCHAR2(200) |  |  |
| 12 | `OBJECT_PATH_SEQNO` | NUMBER |  |  |
| 13 | `OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 14 | `IN_PROGRESS` | CHAR(1) |  |  |
| 15 | `OBJECT_NAME` | VARCHAR2(500) |  |  |
| 16 | `OBJECT_LONG_NAME` | VARCHAR2(4000) |  |  |
| 17 | `OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 18 | `ORIGINAL_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 19 | `ORIGINAL_OBJECT_NAME` | VARCHAR2(4000) |  |  |
| 20 | `PARTITION_NAME` | VARCHAR2(30) |  |  |
| 21 | `SUBPARTITION_NAME` | VARCHAR2(30) |  |  |
| 22 | `DATAOBJ_NUM` | NUMBER |  |  |
| 23 | `FLAGS` | NUMBER |  |  |
| 24 | `PROPERTY` | NUMBER |  |  |
| 25 | `TRIGFLAG` | NUMBER |  |  |
| 26 | `CREATION_LEVEL` | NUMBER |  |  |
| 27 | `COMPLETION_TIME` | DATE |  |  |
| 28 | `OBJECT_TABLESPACE` | VARCHAR2(30) |  |  |
| 29 | `SIZE_ESTIMATE` | NUMBER |  |  |
| 30 | `OBJECT_ROW` | NUMBER |  |  |
| 31 | `PROCESSING_STATE` | CHAR(1) |  |  |
| 32 | `PROCESSING_STATUS` | CHAR(1) |  |  |
| 33 | `BASE_PROCESS_ORDER` | NUMBER |  |  |
| 34 | `BASE_OBJECT_TYPE` | VARCHAR2(30) |  |  |
| 35 | `BASE_OBJECT_NAME` | VARCHAR2(30) |  |  |
| 36 | `BASE_OBJECT_SCHEMA` | VARCHAR2(30) |  |  |
| 37 | `ANCESTOR_PROCESS_ORDER` | NUMBER |  |  |
| 38 | `DOMAIN_PROCESS_ORDER` | NUMBER |  |  |
| 39 | `PARALLELIZATION` | NUMBER |  |  |
| 40 | `UNLOAD_METHOD` | NUMBER |  |  |
| 41 | `LOAD_METHOD` | NUMBER |  |  |
| 42 | `GRANULES` | NUMBER |  |  |
| 43 | `SCN` | NUMBER |  |  |
| 44 | `GRANTOR` | VARCHAR2(30) |  |  |
| 45 | `XML_CLOB` | CLOB |  |  |
| 46 | `PARENT_PROCESS_ORDER` | NUMBER |  |  |
| 47 | `NAME` | VARCHAR2(30) |  |  |
| 48 | `VALUE_T` | VARCHAR2(4000) |  |  |
| 49 | `VALUE_N` | NUMBER |  |  |
| 50 | `IS_DEFAULT` | NUMBER |  |  |
| 51 | `FILE_TYPE` | NUMBER |  |  |
| 52 | `USER_DIRECTORY` | VARCHAR2(4000) |  |  |
| 53 | `USER_FILE_NAME` | VARCHAR2(4000) |  |  |
| 54 | `FILE_NAME` | VARCHAR2(4000) |  |  |
| 55 | `EXTEND_SIZE` | NUMBER |  |  |
| 56 | `FILE_MAX_SIZE` | NUMBER |  |  |
| 57 | `PROCESS_NAME` | VARCHAR2(30) |  |  |
| 58 | `LAST_UPDATE` | DATE |  |  |
| 59 | `WORK_ITEM` | VARCHAR2(30) |  |  |
| 60 | `OBJECT_NUMBER` | NUMBER |  |  |
| 61 | `COMPLETED_BYTES` | NUMBER |  |  |
| 62 | `TOTAL_BYTES` | NUMBER |  |  |
| 63 | `METADATA_IO` | NUMBER |  |  |
| 64 | `DATA_IO` | NUMBER |  |  |
| 65 | `CUMULATIVE_TIME` | NUMBER |  |  |
| 66 | `PACKET_NUMBER` | NUMBER |  |  |
| 67 | `INSTANCE_ID` | NUMBER |  |  |
| 68 | `OLD_VALUE` | VARCHAR2(4000) |  |  |
| 69 | `SEED` | NUMBER |  |  |
| 70 | `LAST_FILE` | NUMBER |  |  |
| 71 | `USER_NAME` | VARCHAR2(30) |  |  |
| 72 | `OPERATION` | VARCHAR2(30) |  |  |
| 73 | `JOB_MODE` | VARCHAR2(30) |  |  |
| 74 | `QUEUE_TABNUM` | NUMBER |  |  |
| 75 | `CONTROL_QUEUE` | VARCHAR2(30) |  |  |
| 76 | `STATUS_QUEUE` | VARCHAR2(30) |  |  |
| 77 | `REMOTE_LINK` | VARCHAR2(4000) |  |  |
| 78 | `VERSION` | NUMBER |  |  |
| 79 | `JOB_VERSION` | VARCHAR2(30) |  |  |
| 80 | `DB_VERSION` | VARCHAR2(30) |  |  |
| 81 | `TIMEZONE` | VARCHAR2(64) |  |  |
| 82 | `STATE` | VARCHAR2(30) |  |  |
| 83 | `PHASE` | NUMBER |  |  |
| 84 | `GUID` | RAW(16) |  |  |
| 85 | `START_TIME` | DATE |  |  |
| 86 | `BLOCK_SIZE` | NUMBER |  |  |
| 87 | `METADATA_BUFFER_SIZE` | NUMBER |  |  |
| 88 | `DATA_BUFFER_SIZE` | NUMBER |  |  |
| 89 | `DEGREE` | NUMBER |  |  |
| 90 | `PLATFORM` | VARCHAR2(101) |  |  |
| 91 | `ABORT_STEP` | NUMBER |  |  |
| 92 | `INSTANCE` | VARCHAR2(60) |  |  |
| 93 | `CLUSTER_OK` | NUMBER |  |  |
| 94 | `SERVICE_NAME` | VARCHAR2(100) |  |  |
| 95 | `OBJECT_INT_OID` | VARCHAR2(32) |  |  |

- **Unique** (SYS_C0036870): `PROCESS_ORDER`, `DUPLICATE`
- **Index** `SYS_MTABLE_00008F279_IND_1`: `OBJECT_SCHEMA`, `OBJECT_NAME`, `OBJECT_TYPE`
- **Index** `SYS_MTABLE_00008F279_IND_2`: `BASE_PROCESS_ORDER`

### TEMP_TEST_RESULT

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `CREATED_DATE` | DATE |  |  |
| 2 | `TEST_TYPE` | NUMBER(1,0) |  |  |
| 4 | `YTS` | NUMBER(10,5) |  |  |
| 5 | `UTS` | NUMBER(10,5) |  |  |
| 6 | `ELONGATION` | NUMBER(10,5) |  |  |
| 7 | `R` | NUMBER(10,8) |  |  |
| 8 | `N` | NUMBER(10,8) |  |  |
| 9 | `WIDTH` | NUMBER(10,7) |  |  |
| 10 | `THICKNESS` | NUMBER(10,7) |  |  |
| 11 | `COIL_ORG_NUM` | VARCHAR2(32) |  |  |


### TEST_863

_~287 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TEST_863` | CHAR(40) |  |  |


### TITLECRAFT

_~46 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TITLECRAFT_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `GROUPDEPARTMENT_ID` | NUMBER(8,0) |  |  |
| 3 | `TITLECRAFT` | VARCHAR2(64) | NOT NULL |  |
| 4 | `HOURLYRATE` | NUMBER(6,2) |  |  |

- **PK:** `TITLECRAFT_ID`
- **FK:** (`GROUPDEPARTMENT_ID`) → `GROUPDEPARTMENT` (`GROUPDEPARTMENT_ID`)
- **Index** unique `SYS_C0036755`: `TITLECRAFT_ID`

### TMD_CODES_CHEMICAL

_~29 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TMD_CODE` | CHAR(3) |  |  |
| 2 | `DESCRIPTION` | VARCHAR2(20) |  |  |


### TMD_CODES_MECHANICAL

_~66 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TMD_CODE` | CHAR(3) |  |  |
| 2 | `PSD` | CHAR(2) |  |  |
| 3 | `DESCRIPTION` | VARCHAR2(40) |  |  |
| 4 | `NOTES` | VARCHAR2(256) |  |  |


### TRANSPORTATION_METHOD

_~1 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TRANS_METHOD_CODE` 🔑 | VARCHAR2(8) | NOT NULL |  |
| 2 | `TRANS_DESC` | VARCHAR2(50) |  |  |

- **PK:** `TRANS_METHOD_CODE`
- **Index** unique `SYS_C0036756`: `TRANS_METHOD_CODE`

### TRAPEZOID

_~532 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `TR_LONG_LENGTH` | NUMBER(10,5) |  |  |
| 4 | `TR_LONG_PLUS` | NUMBER(6,6) |  |  |
| 5 | `TR_LONG_MINUS` | NUMBER(6,6) |  |  |
| 6 | `TR_SHORT_LENGTH` | NUMBER(10,5) |  |  |
| 7 | `TR_SHORT_PLUS` | NUMBER(6,6) |  |  |
| 8 | `TR_SHORT_MINUS` | NUMBER(6,6) |  |  |
| 9 | `TR_WIDTH` | NUMBER(10,5) |  |  |
| 10 | `TR_WIDTH_PLUS` | NUMBER(6,6) |  |  |
| 11 | `TR_WIDTH_MINUS` | NUMBER(6,6) |  |  |
| 12 | `TR_DIE1` | VARCHAR2(18) |  |  |
| 13 | `TR_DIE2` | VARCHAR2(18) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKTRAPEZOID`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### TRIM_TYPE

_~2 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TRIM_TYPE_CODE` 🔑 | NUMBER | NOT NULL |  |
| 2 | `TRIM_TYPE_DESC` | VARCHAR2(20) | NOT NULL |  |

- **PK:** `TRIM_TYPE_CODE`
- **Index** unique `PFK_TRIM_TYPE`: `TRIM_TYPE_CODE`

### TRUCK_APPOINT_LOCKS

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPOINTMENT_DATE` 🔑 | CHAR(10) | NOT NULL |  |
| 2 | `SLOT_NUMBER` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `TIME_START` 🔑 | CHAR(8) | NOT NULL |  |
| 4 | `COMPUTER_ID` 🔑 | VARCHAR2(64) | NOT NULL |  |
| 5 | `SCREEN` 🔑 | CHAR(9) | NOT NULL |  |
| 6 | `LOGIN_ID` | VARCHAR2(18) |  |  |
| 7 | `USER_LAST_NAME` | VARCHAR2(18) |  |  |
| 8 | `USER_FIRST_NAME` | VARCHAR2(18) |  |  |
| 9 | `LOCK_DATE_TIME` | DATE |  |  |

- **PK:** `APPOINTMENT_DATE`, `SLOT_NUMBER`, `TIME_START`, `COMPUTER_ID`, `SCREEN`
- **Index** unique `XPK_TRUCK_APPOINT_LOCKS`: `APPOINTMENT_DATE`, `SLOT_NUMBER`, `TIME_START`, `COMPUTER_ID`, `SCREEN`

### TRUCK_APPOINT_RECEIVING

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPOINTMENT_DATE_TIME` 🔑 | CHAR(19) | NOT NULL |  |
| 2 | `CARRIER_NAME` 🔑 | VARCHAR2(60) | NOT NULL |  |
| 3 | `APPOINTMENT_NUMBER` | NUMBER(8,0) | NOT NULL |  |
| 4 | `TRUCK_LOAD_NUM` | VARCHAR2(60) | NOT NULL |  |
| 5 | `NUMBER_OF_ITEMS` | NUMBER(4,0) | NOT NULL |  |
| 6 | `CARRIER_ID` | NUMBER(8,0) |  |  |
| 7 | `OTHER` | VARCHAR2(60) |  |  |
| 8 | `NOTES` | VARCHAR2(1024) |  |  |
| 9 | `TRUCK_LOCATION` | VARCHAR2(20) |  |  |
| 10 | `APPINTMENT_CREATED_DTTM` | DATE |  |  |
| 11 | `APPINTMENT_CREATED_BY` | VARCHAR2(20) |  |  |

- **PK:** `APPOINTMENT_DATE_TIME`, `CARRIER_NAME`
- **Index** unique `XPK_TRUCK_APPOINT_RECEIVING`: `APPOINTMENT_DATE_TIME`, `CARRIER_NAME`

### TRUCK_APPOINT_SHIPPING

_~0 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPOINTMENT_DATE_TIME` 🔑 | DATE | NOT NULL |  |
| 2 | `CARRIER_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `APPOINTMENT_NUMBER` | NUMBER(8,0) | NOT NULL |  |
| 4 | `CUSTOMER_ID` | NUMBER(8,0) | NOT NULL |  |
| 5 | `BOL` | NUMBER(8,0) | NOT NULL |  |
| 6 | `NUMBER_OF_ITEMS` | NUMBER(4,0) | NOT NULL |  |
| 7 | `OTHER` | VARCHAR2(60) |  |  |
| 8 | `LOAD_STAGED_AT` | VARCHAR2(20) |  |  |
| 9 | `TRUCK_STATUS` | VARCHAR2(30) |  |  |
| 10 | `APPINTMENT_CREATED_DTTM` | DATE |  |  |
| 11 | `APPINTMENT_CREATED_BY` | VARCHAR2(20) |  |  |

- **PK:** `APPOINTMENT_DATE_TIME`, `CARRIER_ID`
- **Index** unique `XPK_TRUCK_APPOINT_SHIPPING`: `APPOINTMENT_DATE_TIME`, `CARRIER_ID`

### TRUCK_LOCATION

_~9 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `TRUCK_LOCATION_ID` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `TRUCK_LOCATION_DESC` | VARCHAR2(20) | NOT NULL |  |

- **PK:** `TRUCK_LOCATION_ID`
- **Index** unique `XPK_TRUCK_LOCATION`: `TRUCK_LOCATION_ID`

### TRUCK_RECEIVING_4DATE

_~330 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPOINTMENT_DATE` 🔑 | CHAR(10) | NOT NULL |  |
| 2 | `SLOT_NUMBER` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `SLOT_TIME_START` | CHAR(8) |  |  |
| 4 | `SLOT_TIME_END` | CHAR(8) |  |  |
| 5 | `CARRIER_NAME` | VARCHAR2(60) |  |  |
| 6 | `APPOINTMENT_NUMBER` | NUMBER(8,0) |  |  |
| 7 | `TRUCK_NUM` | VARCHAR2(60) |  |  |
| 8 | `LOAD_BOL_NUM` | VARCHAR2(60) |  |  |
| 9 | `NUMBER_OF_ITEMS` | NUMBER(4,0) |  |  |
| 10 | `CARRIER_ID` | NUMBER(8,0) |  |  |
| 11 | `OTHER` | VARCHAR2(60) |  |  |
| 12 | `NOTES` | VARCHAR2(1024) |  |  |
| 13 | `TRUCK_LOCATION` | VARCHAR2(20) |  |  |
| 14 | `APPINTMENT_CREATED_DTTM` | DATE |  |  |
| 15 | `APPINTMENT_CREATED_BY` | VARCHAR2(20) |  |  |

- **PK:** `APPOINTMENT_DATE`, `SLOT_NUMBER`
- **Index** unique `XPK_TRUCK_RECEIVING_4DATE`: `APPOINTMENT_DATE`, `SLOT_NUMBER`

### TRUCK_SHIPPING_4DATE

_~462 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `APPOINTMENT_DATE` 🔑 | CHAR(10) | NOT NULL |  |
| 2 | `SLOT_NUMBER` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 3 | `SLOT_TIME_START` | CHAR(8) |  |  |
| 4 | `SLOT_TIME_END` | CHAR(8) |  |  |
| 5 | `CARRIER_NAME` | VARCHAR2(60) |  |  |
| 6 | `APPOINTMENT_NUMBER` | NUMBER(8,0) |  |  |
| 7 | `TRUCK_NUM` | VARCHAR2(60) |  |  |
| 8 | `LOAD_BOL_NUM` | VARCHAR2(60) |  |  |
| 9 | `NUMBER_OF_ITEMS` | NUMBER(4,0) |  |  |
| 10 | `CARRIER_ID` | NUMBER(8,0) |  |  |
| 11 | `OTHER` | VARCHAR2(60) |  |  |
| 12 | `NOTES` | VARCHAR2(1024) |  |  |
| 13 | `TRUCK_LOCATION` | VARCHAR2(20) |  |  |
| 14 | `APPINTMENT_CREATED_DTTM` | DATE |  |  |
| 15 | `APPINTMENT_CREATED_BY` | VARCHAR2(20) |  |  |

- **PK:** `APPOINTMENT_DATE`, `SLOT_NUMBER`
- **Index** unique `XPK_TRUCK_SHIPPING_4DATE`: `APPOINTMENT_DATE`, `SLOT_NUMBER`

### UNIT_OF_MEASURE

_~8 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `UOM_CODE` 🔑 | VARCHAR2(3) | NOT NULL |  |
| 2 | `UOM_ABBREV` | VARCHAR2(10) |  |  |
| 3 | `UOM_CODE_DESC` | VARCHAR2(80) |  |  |

- **PK:** `UOM_CODE`
- **Index** unique `XPK_UNIT_OF_MEASURE`: `UOM_CODE`

### USER_LOG

_~100,437 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `USER_LOG_ID` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `USER_LOG_USER_NAME` | VARCHAR2(32) | NOT NULL |  |
| 3 | `USER_LOGOUT_TIMESTAMP` | DATE |  |  |
| 4 | `USER_LOG_NOTES` | VARCHAR2(255) |  |  |
| 5 | `USER_LOGIN_TIMESTAMP` | DATE | NOT NULL |  |

- **PK:** `USER_LOG_ID`
- **Index** unique `XPKUSER_LOG`: `USER_LOG_ID`

### WH_ITEM

_~14 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `WH_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `WH_PACKING_TICKET` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `ASSO_ORDER_ABC_NUM` | NUMBER(8,0) |  |  |
| 4 | `ASSO_AB_JOB_NUM` | NUMBER(8,0) |  |  |
| 5 | `WH_PRODUCT_FROM` | NUMBER(8,0) |  |  |
| 6 | `WH_PRODUCT_TO` | NUMBER(8,0) |  |  |
| 7 | `WH_BILL_TO` | NUMBER(8,0) |  |  |
| 8 | `WH_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 9 | `WH_TARE_WT` | NUMBER(8,0) |  |  |
| 10 | `WH_DATE_RECEIVED` | DATE |  |  |
| 11 | `WH_STATUS` | NUMBER(8,0) |  |  |
| 12 | `WH_LOCATION` | VARCHAR2(18) |  |  |
| 13 | `WH_EDI856_DATE` | DATE |  |  |
| 14 | `WH_EDI870_DATE` | DATE |  |  |
| 15 | `WH_NOTES` | VARCHAR2(255) |  |  |

- **PK:** `WH_ITEM_NUM`, `WH_PACKING_TICKET`
- **Index** unique `XPKWH_ITEM`: `WH_ITEM_NUM`, `WH_PACKING_TICKET`

### WH_ITEM_DETAIL

_~21 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `WH_ITEM_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 2 | `WH_PACKING_TICKET` 🔑 | VARCHAR2(32) | NOT NULL |  |
| 3 | `WH_COIL_NUM` 🔑 | VARCHAR2(18) | NOT NULL |  |
| 4 | `WH_LOT_NUM` | VARCHAR2(18) |  |  |
| 5 | `WH_ITEM_PIECES` | NUMBER(6,0) |  |  |
| 6 | `WH_ITEM_NET_WT` | NUMBER(8,0) | NOT NULL |  |
| 7 | `WH_ITEM_THEORETICAL_WT` | NUMBER(8,0) |  |  |
| 8 | `WH_DETAIL_NOTES` | VARCHAR2(255) |  |  |

- **PK:** `WH_ITEM_NUM`, `WH_PACKING_TICKET`, `WH_COIL_NUM`
- **FK:** (`WH_ITEM_NUM`, `WH_PACKING_TICKET`) → `WH_ITEM` (`WH_ITEM_NUM`, `WH_PACKING_TICKET`)
- **Index** unique `XPKWH_ITEM_DETAIL`: `WH_ITEM_NUM`, `WH_PACKING_TICKET`, `WH_COIL_NUM`

### WH_PACKING_ITEM

_~9 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `WH_PACKING_ITEM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `PACKING_LIST` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `WH_PACKING_TICKET` | VARCHAR2(32) |  |  |
| 4 | `WH_ITEM_NUM` | NUMBER(8,0) |  |  |

- **PK:** `WH_PACKING_ITEM`, `PACKING_LIST`
- **FK:** (`WH_ITEM_NUM`, `WH_PACKING_TICKET`) → `WH_ITEM` (`WH_ITEM_NUM`, `WH_PACKING_TICKET`)
- **FK:** (`PACKING_LIST`) → `SHIPMENT` (`PACKING_LIST`)
- **Index** unique `XPKE_56`: `WH_PACKING_ITEM`, `PACKING_LIST`

### WINDOW_X_Y

_~20 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `LINE_NUM` 🔑 | NUMBER(4,0) | NOT NULL |  |
| 2 | `OBJECT_NAME` 🔑 | VARCHAR2(128) | NOT NULL |  |
| 3 | `ALIAS_NAME` | VARCHAR2(32) |  |  |
| 4 | `WINDOW_X` | NUMBER(7,0) |  |  |
| 5 | `WINDOW_Y` | NUMBER(7,0) |  |  |

- **PK:** `LINE_NUM`, `OBJECT_NAME`
- **Index** unique `WINDOW_X_Y_PK1`: `LINE_NUM`, `OBJECT_NAME`

### X1_SHAPE

_~122 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ORDER_ITEM_NUM` 🔑 | NUMBER(2,0) | NOT NULL |  |
| 2 | `ORDER_ABC_NUM` 🔑 | NUMBER(8,0) | NOT NULL |  |
| 3 | `X_1` | NUMBER(10,5) |  |  |
| 4 | `X_2` | NUMBER(10,5) |  |  |
| 5 | `X_3` | NUMBER(10,5) |  |  |
| 6 | `X_4` | NUMBER(10,5) |  |  |
| 7 | `X_5` | NUMBER(10,5) |  |  |
| 8 | `X_6` | NUMBER(10,5) |  |  |
| 9 | `X_DIE` | VARCHAR2(18) |  |  |
| 10 | `X_7` | NUMBER(10,5) |  |  |
| 11 | `X_8` | NUMBER(10,5) |  |  |
| 12 | `X_9` | NUMBER(10,5) |  |  |
| 13 | `X_10` | NUMBER(10,5) |  |  |
| 14 | `X_11` | NUMBER(10,5) |  |  |
| 15 | `X_12` | NUMBER(10,5) |  |  |

- **PK:** `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`
- **FK:** (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`) → `ORDER_ITEM` (`ORDER_ITEM_NUM`, `ORDER_ABC_NUM`)
- **Index** unique `XPKX1_SHAPE`: `ORDER_ITEM_NUM`, `ORDER_ABC_NUM`

### YIELD_STRENGTH

_~34 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ALLOY` 🔑 | VARCHAR2(12) | NOT NULL |  |
| 2 | `TEMPER` 🔑 | VARCHAR2(8) | NOT NULL |  |
| 3 | `YIELD_STRENGTH` | VARCHAR2(50) | NOT NULL |  |

- **PK:** `ALLOY`, `TEMPER`
- **Index** unique `PFK_YIELD_STRENGTH`: `ALLOY`, `TEMPER`

### ZIP_CODE_DATA

_~43,191 rows_

| # | Column | Type | Null | Default |
|--:|---|---|:--:|---|
| 1 | `ZIP_CODE` 🔑 | VARCHAR2(10) | NOT NULL |  |
| 2 | `CITY` | VARCHAR2(30) | NOT NULL |  |
| 3 | `STATE` | VARCHAR2(2) | NOT NULL |  |
| 4 | `START_LATITUDE` | NUMBER(10,6) | NOT NULL |  |
| 5 | `START_LONGITUDE` | NUMBER(10,6) | NOT NULL |  |
| 6 | `TIMEZONE` | NUMBER |  |  |
| 7 | `DST` | NUMBER |  |  |
| 8 | `ABCO_LATITUDE` | NUMBER(10,6) | NOT NULL |  |
| 9 | `ABCO_LONGITUDE` | NUMBER(10,6) | NOT NULL |  |
| 10 | `ABCO_DISTANCE` | NUMBER(10,6) | NOT NULL |  |

- **PK:** `ZIP_CODE`
- **Index** unique `SYS_C0036773`: `ZIP_CODE`

## Sequences

| Sequence | Last number |
|---|--:|
| `AB_JOB_NUM_SEQ` | 124272 |
| `AB_SCRAP_THEO` | 10002 |
| `BILL_OF_LADING_SEQ` | 135574 |
| `CARRIER_ID_SEQ` | 1263 |
| `COIL_ABC_NUM_SEQ` | 123771 |
| `COIL_EVAL_SCRAP_SEQ` | 226 |
| `COIL_OWNERSHIP_TRANSFER_SEQ` | 1 |
| `COIL_OWNER_TRANSFER_CERTIF_SEQ` | 60 |
| `CUSTOMER_CONTACT_ID_SEQ` | 1038 |
| `CUSTOMER_ID_SEQ` | 3070 |
| `DIE_ID_SEQ` | 1057 |
| `DT_INSTANCE_SEQ` | 799529 |
| `EDI_863_IMPORTED_FILE_ID_SEQ` | 30541 |
| `EDI_BSN_LOG_SEQ` | 67428 |
| `EDI_BSR_LOG_SEQ` | 2000 |
| `EDI_FILE_ID_SEQ` | 170399 |
| `EDI_GS_LOG_SEQ` | 356660 |
| `EDI_INBOUND_FILE_ID_SEQ` | 423170 |
| `EDI_OUT_ID_SEQ` | 1000 |
| `EDI_ST_LOG_SEQ` | 289803 |
| `ERROR_EVT_SEQ` | 30097 |
| `EVT_NOTIFY_SEQ` | 1 |
| `EVT_OPERATORS_SEQ` | 21 |
| `EVT_PROFILE_SEQ` | 4 |
| `INBOUND_SHIPMENT_ID_SEQ` | 81 |
| `INVOICE_ID_SEQ` | 40000 |
| `MICROSOFTSEQDTPROPERTIES` | 51 |
| `ORDER_ABC_NUM_SEQ` | 52146 |
| `PACKING_LIST_NUM_SEQ` | 135574 |
| `PART_NUM_ID_SEQ` | 11126 |
| `PROD_ITEM_NUM_SEQ` | 1605334 |
| `RECEIVING_BOL_ID_SEQ` | 52789 |
| `RETURN_SCRAP_ITEM_ID_SEQ` | 184702 |
| `ROUTING_SEQ` | 1452 |
| `SCAN_LOG_SEQ` | 35702 |
| `SCRAP_SKID_NUM_SEQ` | 176132 |
| `SHEET_PACKAGING_TICKET_SEQ` | 18038 |
| `SHEET_SKID_DIMENSION_CHECK_SEQ` | 10405 |
| `SHEET_SKID_NUM_SEQ` | 844343 |
| `SHIFT_NUM_SEQ` | 28618 |
| `SKETCH_ID_SEQ` | 363 |
| `SMACTUALPARAMETERSEQUENCE` | 1 |
| `SMAGENTJOBSEQUENCE` | 1 |
| `SMARCHIVESEQUENCE` | 1 |
| `SMCONSOLESOSETTINGSEQUENCE` | 1 |
| `SMDATABASESEQUENCE` | 1 |
| `SMDBAUTHSEQUENCE` | 1 |
| `SMDEFAUTHSEQUENCE` | 1 |
| `SMDISTRIBUTIONSETSEQUENCE` | 1 |
| `SMFOLDERSEQUENCE` | 1 |
| `SMFORMALPARAMETERSEQUENCE` | 1 |
| `SMGLOBALCONFIGURATIONSEQUENCE` | 1 |
| `SMHOSTAUTHSEQUENCE` | 1 |
| `SMHOSTSEQUENCE` | 1 |
| `SMINSTALLATIONSEQUENCE` | 1 |
| `SMLOGMESSAGESEQUENCE` | 1 |
| `SMMONTHLYENTRYSEQUENCE` | 1 |
| `SMMONTHWEEKENTRYSEQUENCE` | 1 |
| `SMOMSTRINGSEQUENCE` | 1 |
| `SMPACKAGESEQUENCE` | 1 |
| `SMPARALLELJOBSEQUENCE` | 1 |
| `SMPARALLELOPERATIONSEQUENCE` | 1 |
| `SMPARALLELSTATEMENTSEQUENCE` | 1 |
| `SMPRODUCTATTRIBUTESEQUENCE` | 1 |
| `SMPRODUCTSEQUENCE` | 1 |
| `SMP_BRM_ID` | 1 |
| `SMP_JOB_ID_` | 1 |
| `SMP_LONG_ID` | 1 |
| `SMP_SERVICE_SEQ` | 16640 |
| `SMRELEASESEQUENCE` | 1 |
| `SMRUNSEQUENCE` | 1 |
| `SMSCHEDULESEQUENCE` | 1 |
| `SMSHAREDORACLECLIENTSEQUENCE` | 1 |
| `SMSHAREDORACLECONFIGSEQUENCE` | 1 |
| `SMTABLESPACESEQUENCE` | 1 |
| `SMTEMPORARYSEQUENCE` | 21 |
| `SMVCENDPOINTSEQUENCE` | 1 |
| `SMWEEKLYENTRYSEQUENCE` | 1 |
| `SYSTEM_LOG_ID_SEQ` | 148620 |
| `TRUCK_APPT_RECV_SEQ` | 63 |
| `USER_LOG_ID_SEQ` | 244391 |
| `WH_ITEM_NUM_SEQ` | 1519 |

