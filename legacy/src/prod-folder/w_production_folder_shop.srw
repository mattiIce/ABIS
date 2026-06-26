$PBExportHeader$w_production_folder_shop.srw
$PBExportComments$documents for current job for shop floor
forward
global type w_production_folder_shop from w_sheet
end type
type lv_jobs from u_lvs within w_production_folder_shop
end type
type st_job from statictext within w_production_folder_shop
end type
type st_msg from statictext within w_production_folder_shop
end type
type dw_c_job from u_dw within w_production_folder_shop
end type
type cbx_job from checkbox within w_production_folder_shop
end type
type cb_shot from u_cb within w_production_folder_shop
end type
type cb_stop from u_cb within w_production_folder_shop
end type
type cb_play from u_cb within w_production_folder_shop
end type
type cb_print from u_cb within w_production_folder_shop
end type
type st_title3 from statictext within w_production_folder_shop
end type
type st_title2 from statictext within w_production_folder_shop
end type
type cb_open from u_cb within w_production_folder_shop
end type
type em_job from editmask within w_production_folder_shop
end type
type st_title1 from statictext within w_production_folder_shop
end type
type tab_doc from tab within w_production_folder_shop
end type
type tabpage_prod from userobject within tab_doc
end type
type lv_prod from u_lvs within tabpage_prod
end type
type tabpage_prod from userobject within tab_doc
lv_prod lv_prod
end type
type tabpage_files from u_tabpg_fileview_shop within tab_doc
end type
type tabpage_files from u_tabpg_fileview_shop within tab_doc
end type
type tabpage_material from userobject within tab_doc
end type
type lv_matrial from u_lvs within tabpage_material
end type
type tabpage_material from userobject within tab_doc
lv_matrial lv_matrial
end type
type tabpage_ship from userobject within tab_doc
end type
type lv_shipment from u_lvs within tabpage_ship
end type
type tabpage_ship from userobject within tab_doc
lv_shipment lv_shipment
end type
type tabpage_template from userobject within tab_doc
end type
type lv_templates from u_lvs within tabpage_template
end type
type tabpage_template from userobject within tab_doc
lv_templates lv_templates
end type
type tabpage_notes from userobject within tab_doc
end type
type cb_save from u_cb within tabpage_notes
end type
type cb_delete from u_cb within tabpage_notes
end type
type dw_notes from u_dw within tabpage_notes
end type
type cb_add from u_cb within tabpage_notes
end type
type tabpage_notes from userobject within tab_doc
cb_save cb_save
cb_delete cb_delete
dw_notes dw_notes
cb_add cb_add
end type
type tab_doc from tab within w_production_folder_shop
tabpage_prod tabpage_prod
tabpage_files tabpage_files
tabpage_material tabpage_material
tabpage_ship tabpage_ship
tabpage_template tabpage_template
tabpage_notes tabpage_notes
end type
type cb_close from u_cb within w_production_folder_shop
end type
type dw_report from u_dw within w_production_folder_shop
end type
type gb_job from groupbox within w_production_folder_shop
end type
type gb_2 from groupbox within w_production_folder_shop
end type
type ole_video from olecustomcontrol within w_production_folder_shop
end type
type gb_1 from groupbox within w_production_folder_shop
end type
end forward

global type w_production_folder_shop from w_sheet
string tag = "ABCO production document management"
integer x = 4
integer y = 3
integer width = 6096
integer height = 3242
string title = "Production E-Job Folder "
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type long ue_production_production_order ( )
event type long ue_production_production_summary ( )
event type long ue_open ( )
event type long ue_display_doc_info ( long al_job )
event type long ue_template_first_piece ( )
event type long ue_matrial_sheet_tickets ( )
event type long ue_matrial_scrap_tickets ( )
event type long ue_matrial_coil_tickets ( )
event type long ue_matrial_sample_tickets ( )
event type long ue_material_sheet_skid_list ( )
event type long ue_material_scrap_skid_list ( )
event type long ue_sales_customer_order ( )
event type long ue_template_skid_ticket ( )
event type long ue_template_scrap_ticket ( )
event type long ue_template_sample_ticket ( )
event type long ue_template_coil_eval_1 ( )
event type long ue_template_coil_eval_2 ( )
event type long ue_template_coil_eval_for_all ( )
event type long ue_open_current_job ( )
event type long ue_open_existing_job ( )
event type long ue_timely_refresh ( )
event type long ue_material_empty_sample_ticket ( )
event type long ue_material_empty_skid_ticket ( )
event type long ue_material_empty_scrap_ticket ( )
event type long ue_material_current_coil_ticket ( )
lv_jobs lv_jobs
st_job st_job
st_msg st_msg
dw_c_job dw_c_job
cbx_job cbx_job
cb_shot cb_shot
cb_stop cb_stop
cb_play cb_play
cb_print cb_print
st_title3 st_title3
st_title2 st_title2
cb_open cb_open
em_job em_job
st_title1 st_title1
tab_doc tab_doc
cb_close cb_close
dw_report dw_report
gb_job gb_job
gb_2 gb_2
ole_video ole_video
gb_1 gb_1
end type
global w_production_folder_shop w_production_folder_shop

type variables
Long il_job, il_user, il_shift

boolean ib_post_open,ib_autostart
int ii_line_id
n_tmg itmg_refresh_display
n_tmg itmg_every_second
n_tmg itmg_every_2_seconds
n_tmg itmg_every_minute
string is_remotehost,is_media_url,is_media_type
end variables

forward prototypes
public function string wf_get_partial_and_wh (long al_job)
public subroutine wf_set_values (long al_job)
public function long wf_rejected_coil_wt (long al_coil_num)
end prototypes

event type string ue_whoami();RETURN "w_production_folder_shop"
end event

event type long ue_production_production_order();Int li_sheettype
Int li_filenum
Long ll_flen
Long ll_pic_id
Long ll_new_pos
Int li_loops, li_i
Blob lb_pic
String	ls_modstr, ls_rtn //Alex Gerlants. 07/20/2016

SetPointer(HourGlass!)

dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

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

SELECT order_abc_num, order_item_num, material_yield, sketch_id 
INTO :ll_order, :li_item, :lr_yield, :ll_pic_id
FROM ab_job 
WHERE ab_job_num = :il_job
USING SQLCA;

IF IsNULL(ll_pic_id)  THEN ll_pic_id = 0

	SELECTBLOB sketch_view 
	INTO :lb_pic
	FROM sketch_jpg
	WHERE sketch_id = :ll_pic_id
	USING SQLCA;
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
		Return -1
	END IF

	ll_flen = Len(lb_pic)
	IF ll_flen > 32765 THEN
		IF Mod(ll_flen, 32765) = 0 THEN
			li_loops = ll_flen / 32765
		ELSE
			li_loops = (ll_flen / 32765) + 1
		END IF
	ELSE
		li_loops = 1
	END IF

	ll_new_pos = 1
	li_filenum = FileOpen(gs_efSketch_file, StreamMode!, Write!, LockReadWrite!, Replace!)
	FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
	FileClose(li_FileNum)

	FOR li_i = 1 TO li_loops
		li_filenum = FileOpen(gs_efSketch_file, StreamMode!, Write!, LockreadWrite!,Append!)
		FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
		FileClose(li_FileNum)
	NEXT

//Alex Gerlants. 07/20/2016. Begin
//.\efsketch.jpg
//Change file efsketch.jpg location from ".\efsketch.jpg" (as on d_report_prod_order_folder and d_report_prod_order_by_lot_folder)
//to gs_efsketch_file
ls_modstr = "p_1.filename = '" + gs_efsketch_file + "'"
ls_rtn = dw_report.Modify(ls_modstr)
//Alex Gerlants. 07/20/2016. End

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

event type long ue_production_production_summary();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

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

event type long ue_open();Long ll_job, ll_exist, ll_c_job
String ls_login

ll_job = Long(em_job.Text)
ll_exist = 0
tab_doc.tabpage_notes.dw_notes.Reset()
st_title1.Text = ""
st_title2.Text = ""
st_title3.Text = ""

CONNECT USING SQLCA;
SELECT Count(ab_job_num) INTO :ll_exist
FROM ab_job
WHERE ab_job_num = :ll_job
USING SQLCA;
IF ll_exist = 0 OR IsNULL(ll_exist) THEN
	il_job = 0
	MessageBox("Warning", "Job " + em_job.Text + " does not exist.", StopSign!)
	this.Title = "Production E-Job Folder"
	tab_doc.tabpage_files.of_init(il_job)
	RETURN 0
ELSE
	ls_login = gnv_app.of_GetUserId()
	il_user = 0

	CONNECT USING SQLCA;
	SELECT user_id INTO :il_user
	FROM security_user
	WHERE lower(login_id) = lower(:ls_login) //Alex Gerlants. 05/03/2016
	USING SQLCA;

	IF il_user < 1 THEN 
		MessageBox("Warning", "Invalid user account", StopSign!)
		RETURN -2
	END IF
	
	SELECT ab_job_num INTO :ll_c_job
	FROM line_current_status
	WHERE line_num = 6
	USING SQLCA;
	IF ll_c_job = 0 OR IsNULL(ll_c_job) OR ll_job <> ll_c_job THEN
		ole_video.Visible = FALSE
		dw_c_job.Visible = FALSE
		st_msg.Visible = TRUE
		st_msg.Text = "No live data for this job"
	END IF
	
	
	il_job = ll_job
	this.Event ue_display_doc_info(il_job)
	tab_doc.tabpage_notes.dw_notes.settransobject( sqlca)
	tab_doc.tabpage_notes.dw_notes.Retrieve(il_job, il_user)
	tab_doc.tabpage_files.of_init(il_job)
	this.Title = "Production E-Job Folder  - Job# " + String(ll_job)
END IF
tab_doc.SelectedTab = 1
tab_doc.Height = 352
cb_print.Enabled = TRUE
tab_doc.Event ue_reset_bg_color()
tab_doc.tabpage_prod.TabBackColor=RGB(255,255,0)		
RETURN this.Event ue_production_production_order()
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
st_title1.Text = ls_cust + "   Customer PO# " + ls_po + "   ABCO Order# " + String(ll_order)

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

event type long ue_template_first_piece();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_first_piece_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_matrial_sheet_tickets();RETURN 1
end event

event type long ue_matrial_scrap_tickets();RETURN 1
end event

event type long ue_matrial_coil_tickets();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_report_matrial_coil_barcode"

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)
dw_report.ResetUpdate()

RETURN 1
end event

event type long ue_matrial_sample_tickets();RETURN 1
end event

event type long ue_material_sheet_skid_list();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_report_shopfloor_skid"

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper, ls_sle_1, ls_sle_2
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#, ls_po

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :il_job
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
	ls_cust = ls_cust + " ( " + Trim(ls_enduser) + " )"
END IF
ls_cust = ls_cust + "          Cust.P.O.# " + ls_po
ls_sle_1 = Upper(ls_cust)

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
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE ELSE
		ls_spec = ls_spec + " "
END CHOOSE	
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part#
ls_sle_2 = ls_spec


String ls_modstring
ls_modstring = "customer_t.Text = ~"" + ls_sle_1 + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "material_t.Text = ~"" + ls_sle_2 + "~""
dw_report.Modify(ls_modstring) 

Long ll_net, ll_tare
CONNECT USING SQLCA;
SELECT SUM(sheet_net_wt), SUM(sheet_tare_wt) INTO :ll_net, :ll_tare
FROM sheet_skid
WHERE ab_job_num = :il_job
USING SQLCA;
	
ls_modstring = "gross_t.Text = ~"" + String((ll_net + ll_tare), "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

//sync skid wt
Long ll_totalrow, ll_row, ll_i
Long ll_nwt, ll_inwt
Long ll_skid, ll_skid_netwt, ll_lastitem, ll_lastitem_netwt

dw_report.AcceptText()
ll_totalrow = dw_report.RowCount()
IF ll_totalrow < 1 THEN RETURN 0
FOR ll_row = 1 TO ll_totalrow
	ll_nwt = dw_report.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt")
	dw_report.SetItem(ll_row, "citem_net_kg", Int(ll_nwt  * 0.45359 + 0.5 ))
NEXT
dw_report.AcceptText()

FOR ll_row = 1 TO ll_totalrow
	ll_skid = dw_report.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
	ll_skid_netwt = dw_report.GetItemNumber(ll_row, "net_wt_kg", Primary!, FALSE)
	ll_nwt = 0
	ll_lastitem = 0
	FOR ll_i = 1 TO ll_totalrow
		IF dw_report.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num") = ll_skid THEN
			ll_inwt = dw_report.GetItemNumber(ll_i, "citem_net_kg", Primary!, FALSE)
			IF ISNULL(ll_inwt) THEN ll_inwt = 0
			ll_nwt = ll_nwt + ll_inwt
			ll_lastitem_netwt = ll_inwt
			ll_lastitem = ll_i
		END IF
	NEXT
	IF ll_nwt <> ll_skid_netwt THEN
		dw_report.SetItem(ll_lastitem, "citem_net_kg", ll_lastitem_netwt + (ll_skid_netwt - ll_nwt))
	END IF
NEXT 


dw_report.ResetUpdate()

RETURN 1

end event

event type long ue_material_scrap_skid_list();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_office_entry_report_scrap_list"

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

SetPointer(HourGlass!)

String ls_cust_name, ls_mod

select customer_short_name into :ls_cust_name
from customer_order, customer, ab_job
where (customer.customer_id = customer_order.orig_customer_id) and (ab_job.order_abc_num = customer_order.order_abc_num) and (ab_job.ab_job_num = :il_job)
using SQLCA;

ls_cust_name = Upper(ls_cust_name)
ls_cust_name = Trim(ls_cust_name)

ls_mod = "cust_t.Text = ~"" + ls_cust_name + "~""
dw_report.Modify(ls_mod) 

dw_report.ResetUpdate()

RETURN 1
end event

event type long ue_sales_customer_order();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_report_order_entry"

SetPointer(HourGlass!)

Long ll_order

select order_abc_num into :ll_order
from ab_job
where ab_job_num = :il_job
using SQLCA;

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ll_order)

dw_report.ResetUpdate()

RETURN 1
end event

event type long ue_template_skid_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_skid_ticket_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_scrap_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_scrap_skid_ticket_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_sample_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_report_sample_ticket_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_coil_eval_1();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_coil_evaluation_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_coil_eval_2();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_coil_evaluation_template_page_2"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_coil_eval_for_all();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_coil_evaluation_per_job_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_open_current_job();Long ll_job
String ls_login

tab_doc.tabpage_notes.dw_notes.Reset()
st_title1.Text = ""
st_title2.Text = ""
st_title3.Text = ""

CONNECT USING SQLCA;

ll_job = 0

SELECT ab_job_num, shift_num INTO :ll_job, :il_shift
FROM line_current_status
WHERE line_num = 6
USING SQLCA;
IF ll_job = 0 OR IsNULL(ll_job) THEN
	il_job = 0
	//MessageBox("Warning", "BL 110 is not processing any order.", StopSign!)
	st_msg.Text = "Not processing any orders"
	st_msg.Visible = TRUE
	dw_c_job.Visible = FALSE
	this.Title = "Production E-Job Folder"
	tab_doc.tabpage_files.of_init(il_job)
	RETURN 0
ELSE
	ls_login = gnv_app.of_GetUserId()
	il_user = 0

	CONNECT USING SQLCA;
	SELECT user_id INTO :il_user
	FROM security_user
	WHERE lower(login_id) = lower(:ls_login) //Alex Gerlants. 05/03/2016
	USING SQLCA;

	IF il_user < 1 THEN 
		MessageBox("Warning", "Invalid user account", StopSign!)
		RETURN -2
	END IF
	
	st_msg.Visible = FALSE
	dw_c_job.Visible = TRUE
	
	il_job = ll_job
	dw_c_job.Event ue_retrieve(il_job)
	//this.Event ue_display_doc_info(il_job)
	tab_doc.tabpage_notes.dw_notes.settransobject( sqlca)
	tab_doc.tabpage_notes.dw_notes.Retrieve(il_job, il_user)
	tab_doc.tabpage_files.of_init(il_job)
	this.Title = "Production E-Job Folder  - Job# " + String(ll_job)
	em_job.Text = String(il_job)
	
END IF

tab_doc.SelectedTab = 1
tab_doc.Height = 352
cb_print.Enabled = TRUE
tab_doc.Event ue_reset_bg_color()
tab_doc.tabpage_prod.TabBackColor=RGB(255,255,0)	

lv_jobs.of_Reset()
DataStore lds_item
Long ll_r, ll_row
lds_item = Create DataStore
lds_item.DataObject = "d_jobs_for_current_shift"
lds_item.SetTransObject(SQLCA)
lds_item.Retrieve()
ll_row = lds_item.RowCount()
IF ll_row > 0 THEN
	FOR ll_r = 1 TO ll_row
		lv_jobs.AddItem(String(lds_item.GetItemNumber(ll_r, "shift_coil_ab_job_num")), 1)
	NEXT
END IF
DESTROY lds_item


RETURN this.Event ue_production_production_order()
end event

event type long ue_open_existing_job();Long ll_job, ll_exist, ll_c_job
String ls_login

ll_job = il_job
ll_exist = 0
tab_doc.tabpage_notes.dw_notes.Reset()
st_title1.Text = ""
st_title2.Text = ""
st_title3.Text = ""
em_job.Text = String(il_job)

em_job.Enabled = TRUE
cb_open.Enabled = TRUE
cbx_job.Checked = FALSE

CONNECT USING SQLCA;
SELECT Count(ab_job_num) INTO :ll_exist
FROM ab_job
WHERE ab_job_num = :ll_job
USING SQLCA;
IF ll_exist = 0 OR IsNULL(ll_exist) THEN
	il_job = 0
	MessageBox("Warning", "Job " + em_job.Text + " does not exist.", StopSign!)
	this.Title = "Production E-Job Folder"
	tab_doc.tabpage_files.of_init(il_job)
	RETURN 0
ELSE
	ls_login = gnv_app.of_GetUserId()
	il_user = 0

	CONNECT USING SQLCA;
	SELECT user_id INTO :il_user
	FROM security_user
	WHERE lower(login_id) = lower(:ls_login) //Alex Gerlants. 05/03/2016
	USING SQLCA;

	IF il_user < 1 THEN 
		MessageBox("Warning", "Invalid user account", StopSign!)
		RETURN -2
	END IF
	
	SELECT ab_job_num INTO :ll_c_job
	FROM line_current_status
	WHERE line_num = 6
	USING SQLCA;
	IF ll_c_job = 0 OR IsNULL(ll_c_job) OR ll_job <> ll_c_job THEN
		ole_video.Visible = FALSE
		dw_c_job.Visible = FALSE
		st_msg.Visible = TRUE
		st_msg.Text = "Processed job in this shift"
	END IF
	
	this.Event ue_display_doc_info(il_job)
	tab_doc.tabpage_notes.dw_notes.settransobject( sqlca)
	tab_doc.tabpage_notes.dw_notes.Retrieve(il_job, il_user)
	tab_doc.tabpage_files.of_init(il_job)
	this.Title = "Production E-Job Folder  - Job# " + String(ll_job)
END IF
tab_doc.SelectedTab = 1
tab_doc.Height = 352
cb_print.Enabled = TRUE
tab_doc.Event ue_reset_bg_color()
tab_doc.tabpage_prod.TabBackColor=RGB(255,255,0)		
RETURN this.Event ue_production_production_order()
end event

event type long ue_timely_refresh();IF NOT(cbx_job.Checked) THEN RETURN 0

Long ll_job, ll_shift

CONNECT USING SQLCA;

ll_job = 0

SELECT ab_job_num, shift_num INTO :ll_job, :ll_shift
FROM line_current_status
WHERE line_num = 6
USING SQLCA;
IF (ll_job = il_job) AND (ll_shift = il_shift) THEN RETURN 0

RETURN this.event ue_open_current_job()
end event

event type long ue_material_empty_sample_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_report_sample_ticket_template_nodata"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_material_empty_skid_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_skid_ticket_template_nodata"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_material_empty_scrap_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_scrap_skid_ticket_template_nodata"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_material_current_coil_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

Long ll_coil

dw_report.DataObject = "d_report_coil_barcode_single"
dw_report.SetTransObject(sqlca)

SELECT coil_abc_num INTO :ll_coil
FROM line_current_status
WHERE ab_job_num = :il_job
USING SQLCA;

dw_report.Retrieve(ll_coil)

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
DataStore lds_rej, lds_reb

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

lds_rej = CREATE DataStore
lds_rej.DataObject = "d_ab_job_rej_coil_list"
lds_rej.SetTransObject(SQLCA)
lds_rej.Retrieve(al_job)
ll_l1 = lds_rej.RowCount()

lds_reb = CREATE DataStore
lds_reb.DataObject = "d_ab_job_reband_coil_list"
lds_reb.SetTransObject(SQLCA)
lds_reb.Retrieve(al_job)
ll_l2 = lds_reb.RowCount()

ll_l = ll_l1 + ll_l2
ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(lds_rej.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(lds_reb.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

DESTROY lds_rej
DESTROY lds_reb

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

public function long wf_rejected_coil_wt (long al_coil_num);Long ll_wt1, ll_wt2, ll_wt, ll_shift_end_wt

CONNECT USING SQLCA;

SELECT process_quantity, process_end_wt INTO :ll_wt, :ll_shift_end_wt
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (ab_job_num = :il_job)
USING SQLCA;
IF IsNULL(ll_wt) THEN ll_wt = 0

IF IsNULL(ll_shift_end_wt) THEN
	SELECT net_wt_balance INTO :ll_wt1
	FROM coil
	WHERE coil_abc_num = :al_coil_num
	USING SQLCA;
	IF ISNULL(ll_wt1) THEN ll_wt1 = 0
ELSE
	ll_wt1 = ll_shift_end_wt
END IF

SELECT MAX(process_quantity) INTO :ll_wt2
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (process_quantity < :ll_wt)
USING SQLCA;
IF IsNULL(ll_wt2) THEN ll_wt2 = 0

RETURN MAX(ll_wt1, ll_wt2)
end function

on w_production_folder_shop.create
int iCurrent
call super::create
this.lv_jobs=create lv_jobs
this.st_job=create st_job
this.st_msg=create st_msg
this.dw_c_job=create dw_c_job
this.cbx_job=create cbx_job
this.cb_shot=create cb_shot
this.cb_stop=create cb_stop
this.cb_play=create cb_play
this.cb_print=create cb_print
this.st_title3=create st_title3
this.st_title2=create st_title2
this.cb_open=create cb_open
this.em_job=create em_job
this.st_title1=create st_title1
this.tab_doc=create tab_doc
this.cb_close=create cb_close
this.dw_report=create dw_report
this.gb_job=create gb_job
this.gb_2=create gb_2
this.ole_video=create ole_video
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_jobs
this.Control[iCurrent+2]=this.st_job
this.Control[iCurrent+3]=this.st_msg
this.Control[iCurrent+4]=this.dw_c_job
this.Control[iCurrent+5]=this.cbx_job
this.Control[iCurrent+6]=this.cb_shot
this.Control[iCurrent+7]=this.cb_stop
this.Control[iCurrent+8]=this.cb_play
this.Control[iCurrent+9]=this.cb_print
this.Control[iCurrent+10]=this.st_title3
this.Control[iCurrent+11]=this.st_title2
this.Control[iCurrent+12]=this.cb_open
this.Control[iCurrent+13]=this.em_job
this.Control[iCurrent+14]=this.st_title1
this.Control[iCurrent+15]=this.tab_doc
this.Control[iCurrent+16]=this.cb_close
this.Control[iCurrent+17]=this.dw_report
this.Control[iCurrent+18]=this.gb_job
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.ole_video
this.Control[iCurrent+21]=this.gb_1
end on

on w_production_folder_shop.destroy
call super::destroy
destroy(this.lv_jobs)
destroy(this.st_job)
destroy(this.st_msg)
destroy(this.dw_c_job)
destroy(this.cbx_job)
destroy(this.cb_shot)
destroy(this.cb_stop)
destroy(this.cb_play)
destroy(this.cb_print)
destroy(this.st_title3)
destroy(this.st_title2)
destroy(this.cb_open)
destroy(this.em_job)
destroy(this.st_title1)
destroy(this.tab_doc)
destroy(this.cb_close)
destroy(this.dw_report)
destroy(this.gb_job)
destroy(this.gb_2)
destroy(this.ole_video)
destroy(this.gb_1)
end on

event close;call super::close;//f_display_app()
end event

event pfc_print;call super::pfc_print;//PrintSetup()

dw_report.print()

return 1

end event

event open;call super::open;il_job = 0
il_user = 0

ole_video.Width = 2209
ole_video.Height = 1366

st_msg.Visible = FALSE

Timer(60)
end event

event pfc_postopen;call super::pfc_postopen;is_media_type = "mjpeg"
is_media_url = "http://" + "192.168.10.141" + "/axis-cgi/mjpg/video.cgi"


ib_autostart = true
ole_video.object.MediaType = is_media_type
ole_video.object.MediaURL = is_media_url
ole_video.object.StretchToFit = true
ole_video.object.MaintainAspectRatio = false
ole_video.object.FullScreen = false
ole_video.object.play
cb_play.enabled = false


//--------------End of Video-------------------------

dw_c_job.SetTransObject(SQLCA)

this.Event ue_open_current_job()
end event

event timer;call super::timer;//This.Event ue_timely_refresh()
end event

type lv_jobs from u_lvs within w_production_folder_shop
integer x = 4147
integer y = 2643
integer width = 1916
integer height = 256
integer taborder = 80
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

IF index = -1 THEN RETURN 0

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

il_job = Long(llvi_current.Label)

RETURN Parent.Event ue_open_existing_job()


end event

event rbuttonup;//override
RETURN 1
end event

event constructor;call super::constructor;//of_setdatasource(TRUE)
//
//this.inv_datasource.of_register("shift_coil_ab_job_num", "d_jobs_for_current_shift",SQLCA)
//this.inv_datasource.of_RegisterReportColumn()
//this.Event pfc_populate()
end event

type st_job from statictext within w_production_folder_shop
integer x = 3858
integer y = 2678
integer width = 289
integer height = 166
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "List of jobs processed in current shift:"
boolean focusrectangle = false
end type

type st_msg from statictext within w_production_folder_shop
integer x = 3869
integer y = 1693
integer width = 2194
integer height = 195
integer textsize = -28
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217750
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_c_job from u_dw within w_production_folder_shop
event type long ue_retrieve ( long al_job )
integer x = 3862
integer y = 1549
integer width = 2205
integer height = 1085
integer taborder = 90
string dataobject = "d_current_job_status"
boolean vscrollbar = false
boolean livescroll = false
end type

event type long ue_retrieve(long al_job);SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper, ls_po
Long ll_cust, ll_order, ll_enduser, ll_row
Int li_item, li_status
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#

dw_c_job.Retrieve(il_job)
ll_row = dw_c_job.GetRow()
IF ll_row <= 0 THEN 
	MessageBox("Warning", "Error retrieving job details.")
	RETURN ll_row
END IF

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
dw_c_job.SetItem(ll_row, "Enduser", ls_enduser)

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
dw_c_job.SetItem(ll_row, "alloy", ls_alloy )
dw_c_job.SetItem(ll_row, "temper", ls_temper) 
dw_c_job.SetItem(ll_row, "Gauge", String(lr_gauge, "##.######")) 

ls_spec = ""
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
dw_c_job.SetItem(ll_row, "sheettype", ls_shape) 
dw_c_job.SetItem(ll_row, "WidthLength", ls_spec) 

dw_c_job.ResetUpdate()

RETURN al_job
end event

event constructor;call super::constructor;of_setPrintPreview(FALSE)
SetTransObject(sqlca)
end event

type cbx_job from checkbox within w_production_folder_shop
integer x = 91
integer y = 211
integer width = 823
integer height = 61
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Show processing production order"
boolean checked = true
end type

event clicked;If this.Checked THEN
	em_job.Enabled = FALSE
	cb_open.Enabled = FALSE
	Parent.Event ue_open_current_job() 
	ole_video.Visible = TRUE
	dw_c_job.Visible = TRUE
	st_msg.Visible = FALSE
ELSE
	em_job.Enabled = TRUE
	cb_open.Enabled = TRUE
END IF
RETURN 0
end event

type cb_shot from u_cb within w_production_folder_shop
integer x = 5347
integer y = 90
integer width = 278
integer height = 77
integer taborder = 90
string text = "SnapShot"
end type

event clicked;call super::clicked;string ls_file
ls_file = "C:\Abis\snapshot.jpg"
ole_video.object.SaveCurrentImage(0,ls_file)
MessageBox("Image saved", "Snap shot saved to " + ls_file)
end event

type cb_stop from u_cb within w_production_folder_shop
integer x = 4893
integer y = 90
integer width = 278
integer height = 77
integer taborder = 80
string text = "Stop"
end type

event clicked;call super::clicked;ole_video.object.stop
cb_play.enabled = true
cb_stop.enabled = false
end event

type cb_play from u_cb within w_production_folder_shop
integer x = 4440
integer y = 90
integer width = 278
integer height = 77
integer taborder = 70
string text = "Play"
end type

event clicked;call super::clicked;ole_video.object.play
cb_stop.enabled = true
cb_play.enabled = false
end event

type cb_print from u_cb within w_production_folder_shop
string tag = "Print"
integer x = 1584
integer y = 2781
integer width = 640
integer height = 125
integer taborder = 80
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;RETURN Parent.Event pfc_print()
end event

type st_title3 from statictext within w_production_folder_shop
integer x = 1002
integer y = 218
integer width = 2823
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

type st_title2 from statictext within w_production_folder_shop
integer x = 1002
integer y = 147
integer width = 2823
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

type cb_open from u_cb within w_production_folder_shop
integer x = 592
integer y = 109
integer width = 351
integer height = 93
integer taborder = 30
integer textsize = -7
integer weight = 700
string facename = "Arial"
boolean enabled = false
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

type em_job from editmask within w_production_folder_shop
integer x = 55
integer y = 115
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
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "########"
end type

type st_title1 from statictext within w_production_folder_shop
integer x = 1002
integer y = 77
integer width = 2827
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

type tab_doc from tab within w_production_folder_shop
event type long ue_reset_bg_color ( )
integer x = 15
integer y = 298
integer width = 3811
integer height = 355
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
integer selectedtab = 1
tabpage_prod tabpage_prod
tabpage_files tabpage_files
tabpage_material tabpage_material
tabpage_ship tabpage_ship
tabpage_template tabpage_template
tabpage_notes tabpage_notes
end type

event type long ue_reset_bg_color();this.tabpage_prod.TabBackColor=RGB(210,210,210)
this.tabpage_notes.TabBackColor=RGB(210,210,210)
this.tabpage_files.TabBackColor=RGB(210,210,210)
this.tabpage_material.TabBackColor=RGB(210,210,210)
this.tabpage_ship.TabBackColor=RGB(210,210,210)
this.tabpage_template.TabBackColor=RGB(210,210,210)

RETURN 1
end event

on tab_doc.create
this.tabpage_prod=create tabpage_prod
this.tabpage_files=create tabpage_files
this.tabpage_material=create tabpage_material
this.tabpage_ship=create tabpage_ship
this.tabpage_template=create tabpage_template
this.tabpage_notes=create tabpage_notes
this.Control[]={this.tabpage_prod,&
this.tabpage_files,&
this.tabpage_material,&
this.tabpage_ship,&
this.tabpage_template,&
this.tabpage_notes}
end on

on tab_doc.destroy
destroy(this.tabpage_prod)
destroy(this.tabpage_files)
destroy(this.tabpage_material)
destroy(this.tabpage_ship)
destroy(this.tabpage_template)
destroy(this.tabpage_notes)
end on

event clicked;CHOOSE CASE this.SelectedTab
	CASE 1  //prod
		this.Height = 352
		cb_print.Enabled = TRUE
		this.Event ue_reset_bg_color()
		tab_doc.tabpage_prod.TabBackColor=RGB(255,255,0)		
	CASE 6  //notes
		this.Height = 2474
		cb_print.Enabled = FALSE
		this.Event ue_reset_bg_color()
		tab_doc.tabpage_notes.TabBackColor=RGB(255,255,0)
	CASE 2 //file
		this.Height = 2474
		tabpage_files.of_init(il_job)
		cb_print.Enabled = FALSE
		this.Event ue_reset_bg_color()
		tab_doc.tabpage_files.TabBackColor=RGB(255,255,0)
	CASE 3  //material
		this.Height = 352
		cb_print.Enabled = TRUE
		this.Event ue_reset_bg_color()
		tab_doc.tabpage_material.TabBackColor=RGB(255,255,0)		
	CASE 4 //ship
		this.Height = 352
		cb_print.Enabled = TRUE
		this.Event ue_reset_bg_color()
		tab_doc.tabpage_ship.TabBackColor=RGB(255,255,0)		
	CASE 5  //template
		this.Height = 352
		cb_print.Enabled = TRUE
		this.Event ue_reset_bg_color()
		tab_doc.tabpage_template.TabBackColor=RGB(255,255,0)		
	CASE ELSE  //other
			//
END CHOOSE


RETURN 1
end event

event selectionchanged;dw_report.DataObject = ""
dw_report.Reset()
end event

type tabpage_prod from userobject within tab_doc
integer x = 15
integer y = 96
integer width = 3781
integer height = 246
long backcolor = 67108864
string text = "Production"
long tabtextcolor = 33554432
long tabbackcolor = 65535
long picturemaskcolor = 536870912
lv_prod lv_prod
end type

on tabpage_prod.create
this.lv_prod=create lv_prod
this.Control[]={this.lv_prod}
end on

on tabpage_prod.destroy
destroy(this.lv_prod)
end on

type lv_prod from u_lvs within tabpage_prod
integer y = 10
integer width = 3781
integer height = 240
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

type tabpage_files from u_tabpg_fileview_shop within tab_doc
integer x = 15
integer y = 96
integer height = 246
string text = "Files"
end type

type tabpage_material from userobject within tab_doc
integer x = 15
integer y = 96
integer width = 3781
integer height = 246
long backcolor = 134217750
string text = "Inventory"
long tabtextcolor = 33554432
long tabbackcolor = 134217750
long picturemaskcolor = 536870912
lv_matrial lv_matrial
end type

on tabpage_material.create
this.lv_matrial=create lv_matrial
this.Control[]={this.lv_matrial}
end on

on tabpage_material.destroy
destroy(this.lv_matrial)
end on

type lv_matrial from u_lvs within tabpage_material
integer y = 3
integer width = 3781
integer height = 246
integer taborder = 60
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {"Sheet Skid List","Scrap Skid List","All Coil Tickets","Blank Skid Ticket","Blank Scrap Ticket","Blank Sample Ticket","Current Coil Ticket"}
integer itempictureindex[] = {2,2,2,2,2,2,2}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page
Int ii_c

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

ii_c = 0
SELECT COUNT(*) INTO :ii_c
FROM line_current_status
WHERE ab_job_num = :il_job
USING SQLCA;
	

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "SKID BARCODE TICKETS"
		a_w.Dynamic Event ue_matrial_skid_tickets()
	CASE "SCRAP BARCODE TICKETS"
		a_w.Dynamic Event ue_matrial_scrap_tickets()
	CASE "ALL COIL TICKETS"
		a_w.Dynamic Event ue_matrial_coil_tickets()
	CASE "SAMPLE TICKETS"
		a_w.Dynamic Event ue_material_sample_tickets()
	CASE "SHEET SKID LIST"
		a_w.Dynamic Event ue_material_sheet_skid_list()
	CASE "SCRAP SKID LIST"
		a_w.Dynamic Event ue_material_scrap_skid_list()
	CASE "BLANK SAMPLE TICKET"
		a_w.Dynamic Event ue_material_empty_sample_ticket()
	CASE "BLANK SKID TICKET"
		a_w.Dynamic Event ue_material_empty_skid_ticket()
	CASE "BLANK SCRAP TICKET"
		a_w.Dynamic Event ue_material_empty_scrap_ticket()
	CASE "CURRENT COIL TICKET"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			OpenwithParm(w_folder_message, "Current Coil Ticket: This coil ticket only available while coil is being processed.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_material_current_coil_ticket()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type tabpage_ship from userobject within tab_doc
integer x = 15
integer y = 96
integer width = 3781
integer height = 246
long backcolor = 67108864
string text = "Shipment"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
lv_shipment lv_shipment
end type

on tabpage_ship.create
this.lv_shipment=create lv_shipment
this.Control[]={this.lv_shipment}
end on

on tabpage_ship.destroy
destroy(this.lv_shipment)
end on

type lv_shipment from u_lvs within tabpage_ship
integer y = 6
integer width = 3781
integer height = 240
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

type tabpage_template from userobject within tab_doc
integer x = 15
integer y = 96
integer width = 3781
integer height = 246
long backcolor = 67108864
string text = "Templates"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
lv_templates lv_templates
end type

on tabpage_template.create
this.lv_templates=create lv_templates
this.Control[]={this.lv_templates}
end on

on tabpage_template.destroy
destroy(this.lv_templates)
end on

type lv_templates from u_lvs within tabpage_template
integer y = 10
integer width = 3792
integer height = 240
integer taborder = 60
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean fixedlocations = true
boolean showheader = false
boolean labelwrap = false
boolean scrolling = false
boolean hideselection = false
boolean fullrowselect = true
boolean underlinehot = true
string item[] = {"First Piece Verification","Skid Ticket  ","Scrap Ticket  ","Sample Ticket","Coil Eval for current coil","Coil Eval Page 2","Coil Eval for all coils"}
integer itempictureindex[] = {2,2,2,2,2,2,2}
string largepicturename[] = {"Custom050!","Custom070!"}
string smallpicturename[] = {"Custom050!","Custom070!"}
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page
Int ii_c

IF index = -1 THEN RETURN 0


a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

ii_c = 0
SELECT COUNT(*) INTO :ii_c
FROM line_current_status
WHERE ab_job_num = :il_job
USING SQLCA;
	
this.GetItem(index, llvi_current)

llvi_current.Label = Upper(TRIM(llvi_current.Label))

CHOOSE CASE llvi_current.Label
	CASE "FIRST PIECE VERIFICATION"
		a_w.Dynamic Event ue_template_first_piece()
	CASE "SKID TICKET"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			OpenwithParm(w_folder_message, "Skid Ticket: This template only available while job is being processed.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_skid_ticket()
	CASE "SCRAP TICKET"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			OpenwithParm(w_folder_message, "Scrap Ticket: This template only available while job is being processed.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_scrap_ticket()
	CASE "SAMPLE TICKET"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			OpenwithParm(w_folder_message, "Sample Ticket: This template only available while job is being processed.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_sample_ticket()
	CASE "COIL EVAL FOR CURRENT COIL"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			OpenwithParm(w_folder_message, "Coil Eval for Current Coil: This template only available while job is being processed.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_coil_eval_1()
	CASE "COIL EVAL PAGE 2"
		a_w.Dynamic Event ue_template_coil_eval_2()
	CASE "COIL EVAL FOR ALL COILS"
		a_w.Dynamic Event ue_template_coil_eval_for_all()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type tabpage_notes from userobject within tab_doc
integer x = 15
integer y = 96
integer width = 3781
integer height = 246
long backcolor = 67108864
string text = "Notes"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_save cb_save
cb_delete cb_delete
dw_notes dw_notes
cb_add cb_add
end type

on tabpage_notes.create
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.dw_notes=create dw_notes
this.cb_add=create cb_add
this.Control[]={this.cb_save,&
this.cb_delete,&
this.dw_notes,&
this.cb_add}
end on

on tabpage_notes.destroy
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.dw_notes)
destroy(this.cb_add)
end on

type cb_save from u_cb within tabpage_notes
integer x = 2253
integer y = 2240
integer width = 351
integer height = 93
integer taborder = 31
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;IF il_job = 0 OR il_user = 0 THEN
	MessageBox("Warning", "Please select a job first.")
	RETURN -1
END IF

Int li_return

tab_doc.tabpage_notes.dw_notes.AcceptText()

li_return = tab_doc.tabpage_notes.dw_notes.of_UpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 0 THEN
	//No Change
	Return 0
END IF

li_return = tab_doc.tabpage_notes.dw_notes.Update()
IF li_return <> 1 THEN
	ROLLBACK using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN 
		MessageBox("Rollback Error", SQLCA.SQLErrText )
	ELSE
		MessageBox("Update Failed", "But Rollback succeeded" )
	END IF
ELSE
	COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText )
		Return -2
	END IF
END IF

Return 1
end event

type cb_delete from u_cb within tabpage_notes
integer x = 1715
integer y = 2240
integer width = 351
integer height = 93
integer taborder = 21
string facename = "Arial"
string text = "&Delete"
end type

event clicked;call super::clicked;SetPointer(HourGlass!)
IF il_job = 0 OR il_user = 0 THEN
	MessageBox("Warning", "Please select a job first.")
	RETURN -1
END IF

integer li_rc
Long ll_row, ll_user
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_doc.tabpage_notes.dw_notes.GetRow()
	If ll_row < 1 THEN RETURN
	ll_user = tab_doc.tabpage_notes.dw_notes.GetItemNumber(ll_row, "job_efolder_notes_user_id", Primary!, FALSE)
	IF ll_user <> il_user THEN
		MessageBox("Warning", "You may delete your own notes.", StopSign!)
		RETURN
	END IF
	tab_doc.tabpage_notes.dw_notes.Deleterow(0)
END IF
RETURN

end event

type dw_notes from u_dw within tabpage_notes
integer y = 19
integer width = 3781
integer height = 2211
integer taborder = 11
string dataobject = "d_efolder_notes"
boolean livescroll = false
end type

event constructor;call super::constructor;SetRowFocusIndicator(Hand!)

of_SetBase(TRUE)
//of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)


end event

event pfc_addrow;call super::pfc_addrow;long ll_row
DateTime ldt_t
String ls_f, ls_l

ll_row = this.GetRow()
ldt_t = DateTime(Today(), Now())

SELECT user_first_name, user_last_name INTO :ls_f, :ls_l
FROM security_user
WHERE user_id = :il_user
USING SQLCA;

SetItem(ll_row, "job_efolder_notes_timestamp", ldt_t)
SetItem(ll_row, "job_efolder_notes_user_id", il_user)
SetItem(ll_row, "job_efolder_notes_ab_job_num", il_job)
SetItem(ll_row, "security_user_user_first_name", ls_f)
SetItem(ll_row, "security_user_user_last_name", ls_l)

Return ll_row
end event

event rbuttondown;//override
RETURN 0
end event

event rbuttonup;//override
RETURN 0
end event

type cb_add from u_cb within tabpage_notes
integer x = 1178
integer y = 2240
integer width = 351
integer height = 93
integer taborder = 11
string facename = "Arial"
string text = "&Add"
end type

event clicked;call super::clicked;IF il_job = 0 OR il_user = 0 THEN
	MessageBox("Warning", "Please select a job first.")
	RETURN -1
END IF
RETURN tab_doc.tabpage_notes.dw_notes.event pfc_addrow()
end event

type cb_close from u_cb within w_production_folder_shop
string tag = "Exit"
boolean visible = false
integer x = 5427
integer y = 2970
integer width = 640
integer height = 115
integer taborder = 70
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type dw_report from u_dw within w_production_folder_shop
integer x = 15
integer y = 653
integer width = 3811
integer height = 2125
integer taborder = 60
boolean livescroll = false
end type

event constructor;call super::constructor;of_setPrintPreview(FALSE)
SetTransObject(sqlca)
end event

event rbuttondown;//override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type gb_job from groupbox within w_production_folder_shop
integer x = 26
integer y = 61
integer width = 969
integer height = 227
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

type gb_2 from groupbox within w_production_folder_shop
integer x = 4
integer width = 3833
integer height = 2925
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Job E-Folder"
end type

type ole_video from olecustomcontrol within w_production_folder_shop
event onerror ( long theerrorcode,  string theerrorinfo )
event onnewimage ( )
event onclick ( integer ocx_x,  integer ocx_y )
event ondoubleclick ( integer nbutton,  integer nshiftstate,  integer fx,  integer fy )
event onmousedown ( integer nbutton,  integer nshiftstate,  integer fx,  integer fy )
event onmouseup ( integer nbutton,  integer nshiftstate,  integer fx,  integer fy )
event onmousemove ( integer nbutton,  integer nshiftstate,  integer fx,  integer fy )
event onstatuschange ( long thenewstatus,  long theoldstatus )
event onjoydown ( integer nbutton )
event onjoyup ( integer nbutton )
event onmousewheel ( integer nshiftstate,  integer delta,  integer fx,  integer fy )
event onuserwindowchanged ( integer theid,  long thexpos,  long theypos,  long thewidth,  long theheight,  long thestate,  boolean isforced )
integer x = 3862
integer y = 179
integer width = 2209
integer height = 1363
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_production_folder_shop.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event onerror(long theerrorcode, string theerrorinfo);MessageBox(string(theerrorcode), theerrorinfo)
end event

type gb_1 from groupbox within w_production_folder_shop
integer x = 3844
integer width = 2238
integer height = 2925
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Live Line Status"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_production_folder_shop.bin 3992 
2000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000018494ca001d1e41800000003000001000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000007e00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003745395c84227d0e14c6286858d0aa1a90000000018494ca001d1e41818494ca001d1e418000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000020000007e0000000000000001fffffffe00000003fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000800000031f10000233900020008000000000000000b000a0008006e0000006e006f000000650000000b001e0003000800000000000200080000000000020003000000003a98000a0008006e0000006e006f000000650000000b00020008000000000000000b0000000b0000000b0002000800000000000000030077000000000800000031f10000233900020008000000000000000b000a0008006e0000006e006f000000650000000b001e0003000800000000000200080000000000020003000000003a98000a0008006e0000006e006f000000650000000b00020008000000000000000b0000000b0000000b00020008000000000000000300740000004f0061006a006200630065002000740020003d0022002200700000006f0072002d0064006f00660064006c007200650070002e006c0062007700280070005f006f00720075006400740063006f0069005f006e006f00660064006c00720065002e00290076006c0074005f006d0065006c007000740061007300650063002e0069006c006b0063006400650030002e00330030003a0039002000200020002000640020005f007700650072006f0070007400720052002e00730065007400650029002800700000006f0072002d0064006f00660064006c007200650070002e006c0062007700280070005f006f00720075006400740063006f0069005f006e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_production_folder_shop.bin 3992 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
