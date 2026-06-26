$PBExportHeader$w_production_folder_word.srw
$PBExportComments$documents for current job
forward
global type w_production_folder_word from w_sheet
end type
type cb_print from u_cb within w_production_folder_word
end type
type st_title3 from statictext within w_production_folder_word
end type
type st_title2 from statictext within w_production_folder_word
end type
type cb_as from u_cb within w_production_folder_word
end type
type cb_open from u_cb within w_production_folder_word
end type
type em_job from editmask within w_production_folder_word
end type
type st_title1 from statictext within w_production_folder_word
end type
type tab_doc from tab within w_production_folder_word
end type
type tabpage_notes from u_tabpg_notes within tab_doc
end type
type tabpage_notes from u_tabpg_notes within tab_doc
end type
type tabpage_files from u_tabpg_fileview within tab_doc
end type
type tabpage_files from u_tabpg_fileview within tab_doc
end type
type tabpage_sales from userobject within tab_doc
end type
type lv_8 from u_lvs within tabpage_sales
end type
type st_2 from statictext within tabpage_sales
end type
type st_84_1 from u_st within tabpage_sales
end type
type st_84_2 from u_st within tabpage_sales
end type
type st_24_1 from u_st within tabpage_sales
end type
type st_24_2 from u_st within tabpage_sales
end type
type st_36_1 from u_st within tabpage_sales
end type
type st_36_2 from u_st within tabpage_sales
end type
type st_60_1 from u_st within tabpage_sales
end type
type st_60_2 from u_st within tabpage_sales
end type
type st_75_1 from u_st within tabpage_sales
end type
type st_75_2 from u_st within tabpage_sales
end type
type st_108_1 from u_st within tabpage_sales
end type
type st_108_2 from u_st within tabpage_sales
end type
type st_110_2 from u_st within tabpage_sales
end type
type tabpage_sales from userobject within tab_doc
lv_8 lv_8
st_2 st_2
st_84_1 st_84_1
st_84_2 st_84_2
st_24_1 st_24_1
st_24_2 st_24_2
st_36_1 st_36_1
st_36_2 st_36_2
st_60_1 st_60_1
st_60_2 st_60_2
st_75_1 st_75_1
st_75_2 st_75_2
st_108_1 st_108_1
st_108_2 st_108_2
st_110_2 st_110_2
end type
type tabpage_receiving from userobject within tab_doc
end type
type lv_7 from u_lvs within tabpage_receiving
end type
type st_3 from statictext within tabpage_receiving
end type
type tabpage_receiving from userobject within tab_doc
lv_7 lv_7
st_3 st_3
end type
type tabpage_prod from userobject within tab_doc
end type
type lv_prod from u_lvs within tabpage_prod
end type
type st_4 from statictext within tabpage_prod
end type
type tabpage_prod from userobject within tab_doc
lv_prod lv_prod
st_4 st_4
end type
type tabpage_material from userobject within tab_doc
end type
type lv_6 from u_lvs within tabpage_material
end type
type st_1 from statictext within tabpage_material
end type
type tabpage_material from userobject within tab_doc
lv_6 lv_6
st_1 st_1
end type
type tabpage_quality from userobject within tab_doc
end type
type lv_5 from u_lvs within tabpage_quality
end type
type st_5 from statictext within tabpage_quality
end type
type tabpage_quality from userobject within tab_doc
lv_5 lv_5
st_5 st_5
end type
type tabpage_invoice from userobject within tab_doc
end type
type lv_1 from u_lvs within tabpage_invoice
end type
type st_6 from statictext within tabpage_invoice
end type
type tabpage_invoice from userobject within tab_doc
lv_1 lv_1
st_6 st_6
end type
type tabpage_ship from userobject within tab_doc
end type
type lv_2 from u_lvs within tabpage_ship
end type
type st_7 from statictext within tabpage_ship
end type
type tabpage_ship from userobject within tab_doc
lv_2 lv_2
st_7 st_7
end type
type tabpage_cost from userobject within tab_doc
end type
type lv_3 from u_lvs within tabpage_cost
end type
type st_8 from statictext within tabpage_cost
end type
type tabpage_cost from userobject within tab_doc
lv_3 lv_3
st_8 st_8
end type
type tabpage_maint from userobject within tab_doc
end type
type lv_4 from u_lvs within tabpage_maint
end type
type st_9 from statictext within tabpage_maint
end type
type tabpage_maint from userobject within tab_doc
lv_4 lv_4
st_9 st_9
end type
type tabpage_template from userobject within tab_doc
end type
type lv_9 from u_lvs within tabpage_template
end type
type st_10 from statictext within tabpage_template
end type
type tabpage_template from userobject within tab_doc
lv_9 lv_9
st_10 st_10
end type
type tab_doc from tab within w_production_folder_word
tabpage_notes tabpage_notes
tabpage_files tabpage_files
tabpage_sales tabpage_sales
tabpage_receiving tabpage_receiving
tabpage_prod tabpage_prod
tabpage_material tabpage_material
tabpage_quality tabpage_quality
tabpage_invoice tabpage_invoice
tabpage_ship tabpage_ship
tabpage_cost tabpage_cost
tabpage_maint tabpage_maint
tabpage_template tabpage_template
end type
type cb_close from u_cb within w_production_folder_word
end type
type dw_report from u_dw within w_production_folder_word
end type
type gb_job from groupbox within w_production_folder_word
end type
end forward

global type w_production_folder_word from w_sheet
string tag = "ABCO production document management"
integer x = 4
integer y = 3
integer width = 4619
integer height = 2096
string title = "Production E-Job Folder "
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type long ue_production_production_order ( )
event type long ue_production_production_summary ( )
event type long ue_open ( )
event type long ue_display_doc_info ( long al_job )
event type long ue_template_first_piece ( )
cb_print cb_print
st_title3 st_title3
st_title2 st_title2
cb_as cb_as
cb_open cb_open
em_job em_job
st_title1 st_title1
tab_doc tab_doc
cb_close cb_close
dw_report dw_report
gb_job gb_job
end type
global w_production_folder_word w_production_folder_word

type variables
Long il_job
end variables

forward prototypes
public function string wf_get_partial_and_wh (long al_job)
public subroutine wf_set_values (long al_job)
end prototypes

event type string ue_whoami();RETURN "w_production_folder"
end event

event type long ue_production_production_order();Int li_sheettype

dw_report.Reset()

CONNECT USING SQLCA;
SELECT CUSTOMER_ORDER.SHEET_HANDLING_TYPE INTO :li_sheettype
FROM AB_JOB, CUSTOMER_ORDER 
WHERE (AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM) AND (AB_JOB.AB_JOB_NUM = :il_job)   
USING SQLCA;

CHOOSE CASE li_sheettype
	CASE 1
		dw_report.DataObject = "d_report_prod_order_by_lot_folder"
	CASE ELSE
		dw_report.DataObject = "d_report_prod_order_folder"
END CHOOSE

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

String ls_cust, ls_shape, ls_tcust
Long ll_order, ll_cust
Real lr_l, lr_s, lr_w, lr_l_p, lr_l_m, lr_s_p, lr_s_m, lr_w_p, lr_w_m
Int li_item
Long ll_coil_wt, ll_row, ll_i, ll_skids, ll_max_skid_wt
Real lr_yield, lr_pcwt
String ls_modstring
Int li_skid_num

SELECT order_abc_num, order_item_num, material_yield 
INTO :ll_order, :li_item, :lr_yield
FROM ab_job 
WHERE ab_job_num = :il_job
USING SQLCA;

SELECT orig_customer_id INTO :ll_cust
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
IF ll_cust > 0 THEN
	SELECT customer_short_name INTO :ls_tcust
	FROM customer
	WHERE customer_id = :ll_cust
	USING SQLCA;
	ls_cust =  Upper(Trim(ls_tcust))
	ls_modstring = "cust_t.Text = ~"" + ls_cust + "~""
	dw_report.Modify(ls_modstring) 
END IF

SELECT sheet_type, max_skid_wt, theoretical_unit_wt INTO :ls_shape, :ll_max_skid_wt, :lr_pcwt
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

//part dimensions should be Width x Length 
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_length_plus, rt_length_minus, rt_width,  rt_width_plus, rt_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "PARALLELOGRAM"
		SELECT p_length, p_length_plus,p_length_minus, p_width,  p_width_plus,  p_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "FENDER"
		SELECT fe_side, fe_side_plus, fe_side_minus INTO :lr_w, :lr_w_p, :lr_w_m
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "CHEVRON"
		SELECT ch_length, ch_length_plus, ch_length_minus, ch_width, ch_width_plus, ch_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "CIRCLE"
		SELECT c_diameter, c_diameter_plus, c_diameter_minus INTO :lr_w, :lr_w_p, :lr_w_m
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_long_plus, tr_long_minus, tr_width, tr_width_plus , tr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_long_plus, ltr_long_minus, ltr_width, ltr_width_plus, ltr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_long_plus, rtr_long_minus, rtr_width, rtr_width_plus, rtr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "REINFORCEMENT"
		SELECT re_length, re_length_plus, re_length_minus, re_width,  re_width_plus, re_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM reinforcement
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "LIFTGATE"
		SELECT li_length, li_length_plus, li_length_minus, li_width,  li_width_plus, li_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM liftgate_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "OTHER"
		SELECT x_1, x_2 
		INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
END CHOOSE		

ls_modstring = "w_t.Text = ~"" + String(lr_w, "###,###.###") + "~""
dw_report.Modify(ls_modstring)
IF IsNULL(lr_w_p) OR lr_w_p = 0 THEN
	ls_modstring = "w_p_t.Text = ~"+ 0.000~""
ELSE	
	ls_modstring = "w_p_t.Text = ~"+" + String(lr_w_p, "###.###") + "~""
END IF
dw_report.Modify(ls_modstring) 
IF IsNULL(lr_w_m) OR lr_w_m = 0 THEN 
	ls_modstring = "w_m_t.Text = ~"- 0.000~""
ELSE	
	ls_modstring = "w_m_t.Text = ~"-" + String(lr_w_m, "##.###") + "~""
END IF
dw_report.Modify(ls_modstring) 

ls_modstring = "l_t.Text = ~"" + String(lr_l, "###,###.###") + "~""
dw_report.Modify(ls_modstring) 
IF NOT(IsNULL(lr_l) OR (lr_l = 0)) THEN
	IF IsNULL(lr_l_p) OR lr_l_p = 0 THEN
		ls_modstring = "l_p_t.Text = ~"+ 0.000~""
	ELSE		
		ls_modstring = "l_p_t.Text = ~"+" + String(lr_l_p, "##.###") + "~""
	END IF
	dw_report.Modify(ls_modstring)
	IF IsNULL(lr_l_m) OR lr_l_m = 0 THEN 
		ls_modstring = "l_m_t.Text = ~"- 0.000~""
	ELSE	
		ls_modstring = "l_m_t.Text = ~"-" + String(lr_l_m, "##.###") + "~""
	END IF
	dw_report.Modify(ls_modstring) 
END IF

DataStore lds_coil
lds_coil = CREATE datastore  
lds_coil.DataObject = "d_report_ab_job_coil"  
lds_coil.SetTransObject (SQLCA)  
lds_coil.Retrieve(il_job)

ll_row = lds_coil.rowCount()
ll_coil_wt = 0
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coil_wt = ll_coil_wt + lds_coil.GetItemNumber(ll_i, "process_coil_process_quantity")
	NEXT
END IF
DESTROY lds_coil

ls_modstring = "total_coil_t.Text = ~"" + String(ll_coil_wt, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

ls_modstring = "partial_t.Text = ~"" + wf_get_partial_and_wh(il_job) + "~""
dw_report.Modify(ls_modstring) 



RETURN 1

end event

event type long ue_production_production_summary();dw_report.Reset()

dw_report.DataObject = "d_report_prod_order_summary_folder"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)
wf_set_values(il_job)

String ls_modstring
SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :il_job
USING SQLCA;

SELECT orig_customer_id, enduser_id INTO :ll_cust, :ll_enduser
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
SELECT customer_short_name INTO :ls_cust
FROM customer
WHERE customer_id = :ll_cust
USING SQLCA;
IF ll_enduser > 0 THEN
	SELECT customer_short_name INTO :ls_enduser
	FROM customer
	WHERE customer_id = :ll_enduser
	USING SQLCA;
	ls_cust = ls_cust + " ( " + Trim(ls_enduser) + " )"
END IF

SELECT sheet_type, alloy2, temper, order_item_desc, gauge, enduser_part_num  
INTO :ls_shape, :ls_alloy, :ls_temper, :ls_desc, :lr_gauge, :ls_part#
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

IF IsNULL(ls_desc) THEN 
	ls_desc = "  "
ELSE
	ls_desc = Trim(ls_desc)
END IF
IF IsNULL(ls_part#) THEN 
	ls_part# = "  "
ELSE
	ls_part# = Trim(ls_part#)
END IF

//part dimensions should be Width x Length 
ls_spec = ls_alloy + " - " + ls_temper + "    " + String(lr_gauge, "##.######") + " X "
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec +  String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = " "
END CHOOSE	
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part#


ls_modstring = "customer_t.Text = ~"" + ls_cust + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "material_t.Text = ~"" + ls_spec + "~""
dw_report.Modify(ls_modstring) 

RETURN 1
end event

event type long ue_open();Long ll_job, ll_exist

ll_job = Long(em_job.Text)
ll_exist = 0
CONNECT USING SQLCA;
SELECT Count(ab_job_num) INTO :ll_exist
FROM ab_job
WHERE ab_job_num = :ll_job
USING SQLCA;
IF ll_exist = 0 OR IsNULL(ll_exist) THEN
	MessageBox("Warning", "Job " + em_job.Text + " does not exist.", StopSign!)
	this.Title = "Production E-Job Folder"
	RETURN 0
ELSE
	il_job = ll_job
	this.Event ue_display_doc_info(il_job)
	this.Title = "Production E-Job Folder  - Job# " + String(ll_job)
END IF
RETURN 1
end event

event type long ue_display_doc_info(long al_job);SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper, ls_po, ls_status
Long ll_cust, ll_order, ll_enduser, ll_skid, ll_coil
Int li_item, li_status
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num, job_status INTO :ll_order, :li_item, :li_status
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT orig_customer_id, enduser_id, orig_customer_po INTO :ll_cust, :ll_enduser, :ls_po
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
SELECT customer_short_name INTO :ls_cust
FROM customer
WHERE customer_id = :ll_cust
USING SQLCA;
IF ll_enduser > 0 THEN
	SELECT customer_short_name INTO :ls_enduser
	FROM customer
	WHERE customer_id = :ll_enduser
	USING SQLCA;
	ls_cust = Upper(ls_cust) + " (End user: " + Trim(ls_enduser) + " )"
END IF
st_title1.Text = "Job# " + String(al_job) + "   " + ls_cust + "   Customer PO# " + ls_po + "   ABCO Order# " + String(ll_order)

SELECT sheet_type, alloy2, temper, order_item_desc, gauge, enduser_part_num  
INTO :ls_shape, :ls_alloy, :ls_temper, :ls_desc, :lr_gauge, :ls_part#
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

IF IsNULL(ls_desc) THEN 
	ls_desc = "  "
ELSE
	ls_desc = Trim(ls_desc)
END IF
IF IsNULL(ls_part#) THEN 
	ls_part# = "  "
ELSE
	ls_part# = Trim(ls_part#)
END IF

//part dimensions should be Width x Length 
ls_spec = ls_alloy + " - " + ls_temper + "    " + String(lr_gauge, "##.######") + " X "
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec +  String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = " "
END CHOOSE	
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part#
st_title2.Text = ls_spec

CHOOSE CASE li_status
	CASE 0
		ls_status = "Done"
	CASE 2
		ls_status = "New"
	CASE 1
		ls_status = "InProcess"
	CASE 4
		ls_status = "Canceled"
	CASE 5
		ls_status = "OnHold"
	CASE ELSE
		ls_status = "Unknown"
END CHOOSE

SELECT Count(SHEET_SKID_NUM) INTO :ll_skid   
FROM SHEET_SKID 
WHERE ( AB_JOB_NUM = :al_job ) AND  ( SKID_SHEET_STATUS <> 6 )
USING SQLCA;

SELECT Count(COIL_ABC_NUM) INTO :ll_coil  
FROM process_coil 
WHERE AB_JOB_NUM = :al_job 
USING SQLCA;

st_title3.Text = "Type: " + Upper(Trim(ls_shape)) + "   Number of coils: " + String(ll_coil) + "   Number of sheet skids: " + String(ll_skid) + "   Job status: " + ls_status


RETURN 1
end event

event type long ue_template_first_piece();dw_report.Reset()

dw_report.DataObject = "d_first_piece_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

public function string wf_get_partial_and_wh (long al_job);String ls_s
DataStore lds_p
Long ll_row, ll_i

ls_s = ""

lds_p = CREATE DataStore
lds_p.DataObject = "d_ab_job_process_partial"
lds_p.SetTransObject(SQLCA)
lds_p.Retrieve(al_job)
ll_row = lds_p.RowCount()
IF ll_row > 0 THEN 
	ls_s = "use partial skid "
	FOR ll_i = 1 TO ll_row 
		ls_s = ls_s + " " + String(lds_p.GetItemNumber(ll_i,"sheet_skid_num"))
	NEXT
END IF
DESTROY lds_p

RETURN ls_s
end function

public subroutine wf_set_values (long al_job);String ls_modstring
Long ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_t, ll_rejnet, ll_l1, ll_l2, ll_unprocessed_num, ll_unprocessednet

CONNECT USING SQLCA;

SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/05
SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessed_num
ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessednet
ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
//END Modified by Victor Huang in 04/05

//ll_l1 = tab_production.tabpage_rejcoil.dw_rejcoil_list.RowCount()
//ll_l2 = tab_production.tabpage_reband.dw_rebanded_list.RowCount()
ll_l = ll_l1 + ll_l2
ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		//ll_rejnet = ll_rejnet + wf_rejected_coil_wt(tab_production.tabpage_rejcoil.dw_rejcoil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		//ll_rejnet = ll_rejnet + wf_rejected_coil_wt(tab_production.tabpage_reband.dw_rebanded_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_coilnet = ll_l

SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_sheetnet = ll_l

SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_scrapnet = ll_l

SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(sheet_tare_wt),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_sheetnet
ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(scrap_tare_wt),0) INTO :ll_l
FROM scrap_skid
WHERE scrap_ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_scrapnet
ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet
ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
dw_report.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/06
ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
dw_report.Modify(ls_modstring)
//END Modified by Victor Huang in 04/06
end subroutine

on w_production_folder_word.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.st_title3=create st_title3
this.st_title2=create st_title2
this.cb_as=create cb_as
this.cb_open=create cb_open
this.em_job=create em_job
this.st_title1=create st_title1
this.tab_doc=create tab_doc
this.cb_close=create cb_close
this.dw_report=create dw_report
this.gb_job=create gb_job
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.st_title3
this.Control[iCurrent+3]=this.st_title2
this.Control[iCurrent+4]=this.cb_as
this.Control[iCurrent+5]=this.cb_open
this.Control[iCurrent+6]=this.em_job
this.Control[iCurrent+7]=this.st_title1
this.Control[iCurrent+8]=this.tab_doc
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_report
this.Control[iCurrent+11]=this.gb_job
end on

on w_production_folder_word.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.st_title3)
destroy(this.st_title2)
destroy(this.cb_as)
destroy(this.cb_open)
destroy(this.em_job)
destroy(this.st_title1)
destroy(this.tab_doc)
destroy(this.cb_close)
destroy(this.dw_report)
destroy(this.gb_job)
end on

event close;call super::close;f_display_app()
end event

event pfc_print;call super::pfc_print;PrintSetup()

dw_report.print()

return 1

end event

type cb_print from u_cb within w_production_folder_word
string tag = "Print"
integer x = 3899
integer y = 1910
integer width = 322
integer height = 99
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;RETURN Parent.Event pfc_print()
end event

type st_title3 from statictext within w_production_folder_word
integer x = 984
integer y = 163
integer width = 3606
integer height = 54
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_title2 from statictext within w_production_folder_word
integer x = 984
integer y = 93
integer width = 3599
integer height = 54
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_as from u_cb within w_production_folder_word
integer x = 234
integer y = 144
integer width = 461
integer height = 93
integer taborder = 40
integer textsize = -7
integer weight = 700
string facename = "Arial"
boolean enabled = false
string text = "Advanced Search"
end type

event clicked;call super::clicked;Open(w_folder_job_search)
end event

type cb_open from u_cb within w_production_folder_word
integer x = 567
integer y = 45
integer width = 351
integer height = 93
integer taborder = 30
integer textsize = -7
integer weight = 700
string facename = "Arial"
string text = "Open"
end type

event clicked;call super::clicked;dw_report.DataObject = ""
st_title1.Text = ""
st_title2.Text = ""
st_title3.Text = ""
il_job = 0
dw_report.Reset()
Parent.Event ue_open()
end event

type em_job from editmask within w_production_folder_word
integer x = 29
integer y = 51
integer width = 530
integer height = 83
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "########"
end type

type st_title1 from statictext within w_production_folder_word
integer x = 984
integer y = 22
integer width = 3588
integer height = 54
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type tab_doc from tab within w_production_folder_word
integer x = 4
integer y = 253
integer width = 973
integer height = 1651
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean fixedwidth = true
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
integer selectedtab = 1
tabpage_notes tabpage_notes
tabpage_files tabpage_files
tabpage_sales tabpage_sales
tabpage_receiving tabpage_receiving
tabpage_prod tabpage_prod
tabpage_material tabpage_material
tabpage_quality tabpage_quality
tabpage_invoice tabpage_invoice
tabpage_ship tabpage_ship
tabpage_cost tabpage_cost
tabpage_maint tabpage_maint
tabpage_template tabpage_template
end type

on tab_doc.create
this.tabpage_notes=create tabpage_notes
this.tabpage_files=create tabpage_files
this.tabpage_sales=create tabpage_sales
this.tabpage_receiving=create tabpage_receiving
this.tabpage_prod=create tabpage_prod
this.tabpage_material=create tabpage_material
this.tabpage_quality=create tabpage_quality
this.tabpage_invoice=create tabpage_invoice
this.tabpage_ship=create tabpage_ship
this.tabpage_cost=create tabpage_cost
this.tabpage_maint=create tabpage_maint
this.tabpage_template=create tabpage_template
this.Control[]={this.tabpage_notes,&
this.tabpage_files,&
this.tabpage_sales,&
this.tabpage_receiving,&
this.tabpage_prod,&
this.tabpage_material,&
this.tabpage_quality,&
this.tabpage_invoice,&
this.tabpage_ship,&
this.tabpage_cost,&
this.tabpage_maint,&
this.tabpage_template}
end on

on tab_doc.destroy
destroy(this.tabpage_notes)
destroy(this.tabpage_files)
destroy(this.tabpage_sales)
destroy(this.tabpage_receiving)
destroy(this.tabpage_prod)
destroy(this.tabpage_material)
destroy(this.tabpage_quality)
destroy(this.tabpage_invoice)
destroy(this.tabpage_ship)
destroy(this.tabpage_cost)
destroy(this.tabpage_maint)
destroy(this.tabpage_template)
end on

event clicked;CHOOSE CASE this.SelectedTab
	CASE 1  //notes
		this.Width = 4582
		tabpage_notes.of_init(il_job)
		cb_print.Enabled = FALSE
	CASE 2 //file
		this.Width = 4582
		tabpage_files.of_init(il_job)
		cb_print.Enabled = FALSE
	CASE ELSE  //other
		this.Width = 973
		cb_print.Enabled = TRUE
END CHOOSE
RETURN 1
end event

event selectionchanged;dw_report.DataObject = ""
dw_report.Reset()
end event

event constructor;this.Width = 4582
end event

type tabpage_notes from u_tabpg_notes within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
string text = "Notes"
long tabbackcolor = 65535
end type

type tabpage_files from u_tabpg_fileview within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
string text = "Files"
long tabbackcolor = 15793151
end type

type tabpage_sales from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Sales"
long tabtextcolor = 33554432
long tabbackcolor = 16776960
long picturemaskcolor = 536870912
lv_8 lv_8
st_2 st_2
st_84_1 st_84_1
st_84_2 st_84_2
st_24_1 st_24_1
st_24_2 st_24_2
st_36_1 st_36_1
st_36_2 st_36_2
st_60_1 st_60_1
st_60_2 st_60_2
st_75_1 st_75_1
st_75_2 st_75_2
st_108_1 st_108_1
st_108_2 st_108_2
st_110_2 st_110_2
end type

on tabpage_sales.create
this.lv_8=create lv_8
this.st_2=create st_2
this.st_84_1=create st_84_1
this.st_84_2=create st_84_2
this.st_24_1=create st_24_1
this.st_24_2=create st_24_2
this.st_36_1=create st_36_1
this.st_36_2=create st_36_2
this.st_60_1=create st_60_1
this.st_60_2=create st_60_2
this.st_75_1=create st_75_1
this.st_75_2=create st_75_2
this.st_108_1=create st_108_1
this.st_108_2=create st_108_2
this.st_110_2=create st_110_2
this.Control[]={this.lv_8,&
this.st_2,&
this.st_84_1,&
this.st_84_2,&
this.st_24_1,&
this.st_24_2,&
this.st_36_1,&
this.st_36_2,&
this.st_60_1,&
this.st_60_2,&
this.st_75_1,&
this.st_75_2,&
this.st_108_1,&
this.st_108_2,&
this.st_110_2}
end on

on tabpage_sales.destroy
destroy(this.lv_8)
destroy(this.st_2)
destroy(this.st_84_1)
destroy(this.st_84_2)
destroy(this.st_24_1)
destroy(this.st_24_2)
destroy(this.st_36_1)
destroy(this.st_36_2)
destroy(this.st_60_1)
destroy(this.st_60_2)
destroy(this.st_75_1)
destroy(this.st_75_2)
destroy(this.st_108_1)
destroy(this.st_108_2)
destroy(this.st_110_2)
end on

type lv_8 from u_lvs within tabpage_sales
integer x = 11
integer y = 70
integer width = 633
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_2 from statictext within tabpage_sales
integer x = 18
integer width = 581
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sales documents:"
boolean focusrectangle = false
end type

type st_84_1 from u_st within tabpage_sales
integer x = 1053
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_84_2 from u_st within tabpage_sales
integer x = 1053
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_24_1 from u_st within tabpage_sales
integer x = 3127
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_24_2 from u_st within tabpage_sales
integer x = 3127
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_36_1 from u_st within tabpage_sales
integer x = 2611
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_36_2 from u_st within tabpage_sales
integer x = 2611
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_60_1 from u_st within tabpage_sales
integer x = 2092
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_60_2 from u_st within tabpage_sales
integer x = 2092
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_75_1 from u_st within tabpage_sales
integer x = 1576
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_75_2 from u_st within tabpage_sales
integer x = 1576
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_108_1 from u_st within tabpage_sales
integer x = 534
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_108_2 from u_st within tabpage_sales
integer x = 534
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_110_2 from u_st within tabpage_sales
integer x = 15
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type tabpage_receiving from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Receiving"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
long picturemaskcolor = 536870912
lv_7 lv_7
st_3 st_3
end type

on tabpage_receiving.create
this.lv_7=create lv_7
this.st_3=create st_3
this.Control[]={this.lv_7,&
this.st_3}
end on

on tabpage_receiving.destroy
destroy(this.lv_7)
destroy(this.st_3)
end on

type lv_7 from u_lvs within tabpage_receiving
integer x = 15
integer y = 67
integer width = 633
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_3 from statictext within tabpage_receiving
integer x = 15
integer width = 688
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coil receiving documents:"
boolean focusrectangle = false
end type

type tabpage_prod from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 67108864
string text = "Production"
long tabtextcolor = 33554432
long tabbackcolor = 134217729
long picturemaskcolor = 536870912
lv_prod lv_prod
st_4 st_4
end type

on tabpage_prod.create
this.lv_prod=create lv_prod
this.st_4=create st_4
this.Control[]={this.lv_prod,&
this.st_4}
end on

on tabpage_prod.destroy
destroy(this.lv_prod)
destroy(this.st_4)
end on

type lv_prod from u_lvs within tabpage_prod
integer x = 15
integer y = 86
integer width = 640
integer height = 1536
integer taborder = 50
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {"Production Order","Production Summary"}
integer itempictureindex[] = {2,2}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event rbuttonup;//override
RETURN 1
end event

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

type st_4 from statictext within tabpage_prod
integer y = 3
integer width = 618
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Production documents:"
boolean focusrectangle = false
end type

type tabpage_material from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Material"
long tabtextcolor = 33554432
long tabbackcolor = 15793151
long picturemaskcolor = 536870912
lv_6 lv_6
st_1 st_1
end type

on tabpage_material.create
this.lv_6=create lv_6
this.st_1=create st_1
this.Control[]={this.lv_6,&
this.st_1}
end on

on tabpage_material.destroy
destroy(this.lv_6)
destroy(this.st_1)
end on

type lv_6 from u_lvs within tabpage_material
integer x = 11
integer y = 64
integer width = 633
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_1 from statictext within tabpage_material
integer x = 11
integer width = 589
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Material documents:"
boolean focusrectangle = false
end type

type tabpage_quality from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Quality"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
lv_5 lv_5
st_5 st_5
end type

on tabpage_quality.create
this.lv_5=create lv_5
this.st_5=create st_5
this.Control[]={this.lv_5,&
this.st_5}
end on

on tabpage_quality.destroy
destroy(this.lv_5)
destroy(this.st_5)
end on

type lv_5 from u_lvs within tabpage_quality
integer x = 15
integer y = 64
integer width = 636
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_5 from statictext within tabpage_quality
integer x = 11
integer width = 571
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quality documents:"
boolean focusrectangle = false
end type

type tabpage_invoice from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 67108864
string text = "Invoicing"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
long picturemaskcolor = 536870912
lv_1 lv_1
st_6 st_6
end type

on tabpage_invoice.create
this.lv_1=create lv_1
this.st_6=create st_6
this.Control[]={this.lv_1,&
this.st_6}
end on

on tabpage_invoice.destroy
destroy(this.lv_1)
destroy(this.st_6)
end on

type lv_1 from u_lvs within tabpage_invoice
integer x = 29
integer y = 74
integer width = 600
integer height = 1552
integer taborder = 60
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_6 from statictext within tabpage_invoice
integer x = 7
integer width = 640
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Accounting documents:"
boolean focusrectangle = false
end type

type tabpage_ship from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Shipment"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
lv_2 lv_2
st_7 st_7
end type

on tabpage_ship.create
this.lv_2=create lv_2
this.st_7=create st_7
this.Control[]={this.lv_2,&
this.st_7}
end on

on tabpage_ship.destroy
destroy(this.lv_2)
destroy(this.st_7)
end on

type lv_2 from u_lvs within tabpage_ship
integer x = 26
integer y = 58
integer width = 603
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_7 from statictext within tabpage_ship
integer x = 15
integer width = 625
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shipping documents:"
boolean focusrectangle = false
end type

type tabpage_cost from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Cost Analysis"
long tabtextcolor = 33554432
long tabbackcolor = 65280
long picturemaskcolor = 536870912
lv_3 lv_3
st_8 st_8
end type

on tabpage_cost.create
this.lv_3=create lv_3
this.st_8=create st_8
this.Control[]={this.lv_3,&
this.st_8}
end on

on tabpage_cost.destroy
destroy(this.lv_3)
destroy(this.st_8)
end on

type lv_3 from u_lvs within tabpage_cost
integer x = 40
integer y = 61
integer width = 607
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_8 from statictext within tabpage_cost
integer width = 625
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cost documents:"
boolean focusrectangle = false
end type

type tabpage_maint from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Maintenance"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
long picturemaskcolor = 536870912
lv_4 lv_4
st_9 st_9
end type

on tabpage_maint.create
this.lv_4=create lv_4
this.st_9=create st_9
this.Control[]={this.lv_4,&
this.st_9}
end on

on tabpage_maint.destroy
destroy(this.lv_4)
destroy(this.st_9)
end on

type lv_4 from u_lvs within tabpage_maint
integer x = 15
integer y = 67
integer width = 644
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_9 from statictext within tabpage_maint
integer x = 7
integer y = 3
integer width = 658
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Maintenance documents:"
boolean focusrectangle = false
end type

type tabpage_template from userobject within tab_doc
integer x = 300
integer y = 13
integer width = 658
integer height = 1626
long backcolor = 79741120
string text = "Templates"
long tabtextcolor = 33554432
long tabbackcolor = 134217729
long picturemaskcolor = 536870912
lv_9 lv_9
st_10 st_10
end type

on tabpage_template.create
this.lv_9=create lv_9
this.st_10=create st_10
this.Control[]={this.lv_9,&
this.st_10}
end on

on tabpage_template.destroy
destroy(this.lv_9)
destroy(this.st_10)
end on

type lv_9 from u_lvs within tabpage_template
integer x = 15
integer y = 77
integer width = 640
integer height = 1536
integer taborder = 60
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {"First Piece Verification",""}
integer itempictureindex[] = {2,0}
string largepicturename[] = {"Custom050!","Custom070!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "FIRST PIECE VERIFICATION"
		a_w.Dynamic Event ue_template_first_piece()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_10 from statictext within tabpage_template
integer x = 4
integer width = 658
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Templates:"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_production_folder_word
string tag = "Exit"
integer x = 4264
integer y = 1910
integer width = 322
integer height = 99
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type dw_report from u_dw within w_production_folder_word
integer x = 980
integer y = 253
integer width = 3606
integer height = 1651
integer taborder = 60
boolean hsplitscroll = true
end type

event constructor;call super::constructor;SetTransObject(sqlca)
end event

event rbuttondown;//override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type gb_job from groupbox within w_production_folder_word
integer width = 969
integer height = 246
integer taborder = 10
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select a job"
end type

