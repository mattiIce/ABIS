$PBExportHeader$w_office_skid_entry.srw
$PBExportComments$<Sheet> Used in office to input skid information inherited from pfemain/sheet
forward
global type w_office_skid_entry from w_sheet
end type
type st_11 from statictext within w_office_skid_entry
end type
type st_10 from statictext within w_office_skid_entry
end type
type cb_reprint_skid_tag from commandbutton within w_office_skid_entry
end type
type dw_selected_rows from datawindow within w_office_skid_entry
end type
type dw_abis_ini from datawindow within w_office_skid_entry
end type
type cb_refresh_all from commandbutton within w_office_skid_entry
end type
type tab_skids from tab within w_office_skid_entry
end type
type tabpage_sheet from userobject within tab_skids
end type
type cb_group_edit from commandbutton within tabpage_sheet
end type
type cb_converttoscrap from u_cb within tabpage_sheet
end type
type cb_refresh from u_cb within tabpage_sheet
end type
type cb_modify from u_cb within tabpage_sheet
end type
type cb_delete from u_cb within tabpage_sheet
end type
type cb_insert from u_cb within tabpage_sheet
end type
type cb_print from u_cb within tabpage_sheet
end type
type cb_new from u_cb within tabpage_sheet
end type
type cb_cancel from u_cb within tabpage_sheet
end type
type cb_save from u_cb within tabpage_sheet
end type
type dw_skid_editor from u_dw within tabpage_sheet
end type
type dw_skid_list from u_dw within tabpage_sheet
end type
type gb_1 from groupbox within tabpage_sheet
end type
type tabpage_sheet from userobject within tab_skids
cb_group_edit cb_group_edit
cb_converttoscrap cb_converttoscrap
cb_refresh cb_refresh
cb_modify cb_modify
cb_delete cb_delete
cb_insert cb_insert
cb_print cb_print
cb_new cb_new
cb_cancel cb_cancel
cb_save cb_save
dw_skid_editor dw_skid_editor
dw_skid_list dw_skid_list
gb_1 gb_1
end type
type tabpage_scrap from userobject within tab_skids
end type
type cb_convertback from u_cb within tabpage_scrap
end type
type cb_scrapcredit from u_cb within tabpage_scrap
end type
type dw_report from u_dw within tabpage_scrap
end type
type cb_ref from u_cb within tabpage_scrap
end type
type cb_sort from u_cb within tabpage_scrap
end type
type cb_print_scrap from u_cb within tabpage_scrap
end type
type cb_edit from u_cb within tabpage_scrap
end type
type cb_removeitem from u_cb within tabpage_scrap
end type
type cb_remove from u_cb within tabpage_scrap
end type
type cb_newitem from u_cb within tabpage_scrap
end type
type cb_new_scrap from u_cb within tabpage_scrap
end type
type cb_ereset from u_cb within tabpage_scrap
end type
type cb_esave from u_cb within tabpage_scrap
end type
type dw_editor from u_dw within tabpage_scrap
end type
type st_9 from statictext within tabpage_scrap
end type
type dw_scrap_item from u_dw within tabpage_scrap
end type
type st_6 from statictext within tabpage_scrap
end type
type st_7 from statictext within tabpage_scrap
end type
type st_5 from statictext within tabpage_scrap
end type
type st_3 from statictext within tabpage_scrap
end type
type st_4 from statictext within tabpage_scrap
end type
type st_2 from statictext within tabpage_scrap
end type
type st_8 from statictext within tabpage_scrap
end type
type dw_scrap_list from u_dw within tabpage_scrap
end type
type tabpage_scrap from userobject within tab_skids
cb_convertback cb_convertback
cb_scrapcredit cb_scrapcredit
dw_report dw_report
cb_ref cb_ref
cb_sort cb_sort
cb_print_scrap cb_print_scrap
cb_edit cb_edit
cb_removeitem cb_removeitem
cb_remove cb_remove
cb_newitem cb_newitem
cb_new_scrap cb_new_scrap
cb_ereset cb_ereset
cb_esave cb_esave
dw_editor dw_editor
st_9 st_9
dw_scrap_item dw_scrap_item
st_6 st_6
st_7 st_7
st_5 st_5
st_3 st_3
st_4 st_4
st_2 st_2
st_8 st_8
dw_scrap_list dw_scrap_list
end type
type tabpage_scrap_credit from userobject within tab_skids
end type
type cb_convertbacktoscrap from u_cb within tabpage_scrap_credit
end type
type cb_print_scrap_credit from u_cb within tabpage_scrap_credit
end type
type dw_scrap_credit from u_dw within tabpage_scrap_credit
end type
type tabpage_scrap_credit from userobject within tab_skids
cb_convertbacktoscrap cb_convertbacktoscrap
cb_print_scrap_credit cb_print_scrap_credit
dw_scrap_credit dw_scrap_credit
end type
type tabpage_qa_skid from userobject within tab_skids
end type
type cb_3 from commandbutton within tabpage_qa_skid
end type
type cb_add_group from commandbutton within tabpage_qa_skid
end type
type cb_2 from commandbutton within tabpage_qa_skid
end type
type cb_1 from commandbutton within tabpage_qa_skid
end type
type dw_report_attached from datawindow within tabpage_qa_skid
end type
type cb_attach_report_2email from commandbutton within tabpage_qa_skid
end type
type st_rows from statictext within tabpage_qa_skid
end type
type cb_report from commandbutton within tabpage_qa_skid
end type
type dw_coils_4job from datawindow within tabpage_qa_skid
end type
type st_1 from statictext within tabpage_qa_skid
end type
type cb_retrieve_defect from commandbutton within tabpage_qa_skid
end type
type cb_delete_defect from commandbutton within tabpage_qa_skid
end type
type cb_qa_save from commandbutton within tabpage_qa_skid
end type
type cb_add_defect from commandbutton within tabpage_qa_skid
end type
type dw_qa_customer_quality_skid from datawindow within tabpage_qa_skid
end type
type st_17 from statictext within tabpage_qa_skid
end type
type cb_clear from commandbutton within tabpage_qa_skid
end type
type cb_delete_email from commandbutton within tabpage_qa_skid
end type
type cb_add_email from commandbutton within tabpage_qa_skid
end type
type dw_qa_email_address from datawindow within tabpage_qa_skid
end type
type cb_clear_attached_files from commandbutton within tabpage_qa_skid
end type
type st_16 from statictext within tabpage_qa_skid
end type
type dw_attached_file_name from datawindow within tabpage_qa_skid
end type
type st_15 from statictext within tabpage_qa_skid
end type
type sle_email_address_from from singlelineedit within tabpage_qa_skid
end type
type st_email_from from statictext within tabpage_qa_skid
end type
type mle_email_body from multilineedit within tabpage_qa_skid
end type
type st_13 from statictext within tabpage_qa_skid
end type
type sle_email_subject from singlelineedit within tabpage_qa_skid
end type
type cb_email_files from commandbutton within tabpage_qa_skid
end type
type cb_attach_files from commandbutton within tabpage_qa_skid
end type
type st_12 from statictext within tabpage_qa_skid
end type
type dw_skids_4job from datawindow within tabpage_qa_skid
end type
type r_1 from rectangle within tabpage_qa_skid
end type
type tabpage_qa_skid from userobject within tab_skids
cb_3 cb_3
cb_add_group cb_add_group
cb_2 cb_2
cb_1 cb_1
dw_report_attached dw_report_attached
cb_attach_report_2email cb_attach_report_2email
st_rows st_rows
cb_report cb_report
dw_coils_4job dw_coils_4job
st_1 st_1
cb_retrieve_defect cb_retrieve_defect
cb_delete_defect cb_delete_defect
cb_qa_save cb_qa_save
cb_add_defect cb_add_defect
dw_qa_customer_quality_skid dw_qa_customer_quality_skid
st_17 st_17
cb_clear cb_clear
cb_delete_email cb_delete_email
cb_add_email cb_add_email
dw_qa_email_address dw_qa_email_address
cb_clear_attached_files cb_clear_attached_files
st_16 st_16
dw_attached_file_name dw_attached_file_name
st_15 st_15
sle_email_address_from sle_email_address_from
st_email_from st_email_from
mle_email_body mle_email_body
st_13 st_13
sle_email_subject sle_email_subject
cb_email_files cb_email_files
cb_attach_files cb_attach_files
st_12 st_12
dw_skids_4job dw_skids_4job
r_1 r_1
end type
type tab_skids from tab within w_office_skid_entry
tabpage_sheet tabpage_sheet
tabpage_scrap tabpage_scrap
tabpage_scrap_credit tabpage_scrap_credit
tabpage_qa_skid tabpage_qa_skid
end type
type dw_prod_order_detail from u_dw within w_office_skid_entry
end type
type cb_close from u_cb within w_office_skid_entry
end type
type st_title1 from u_st within w_office_skid_entry
end type
type st_title# from u_st within w_office_skid_entry
end type
type dw_coil_status from u_dw within w_office_skid_entry
end type
end forward

global type w_office_skid_entry from w_sheet
integer x = 73
integer y = 160
integer width = 4521
integer height = 1996
string title = "Skid Entry"
string menuname = "m_office_entry"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type integer ue_partial_exist ( long al_skid )
event ue_new_scrap_skid ( )
event ue_delete_scrap_skid ( )
event ue_delete_scrap_item ( )
event ue_scrap_report ( )
event ue_sort_scrap ( )
event ue_ref_scrap ( )
event ue_read_only ( )
st_11 st_11
st_10 st_10
cb_reprint_skid_tag cb_reprint_skid_tag
dw_selected_rows dw_selected_rows
dw_abis_ini dw_abis_ini
cb_refresh_all cb_refresh_all
tab_skids tab_skids
dw_prod_order_detail dw_prod_order_detail
cb_close cb_close
st_title1 st_title1
st_title# st_title#
dw_coil_status dw_coil_status
end type
global w_office_skid_entry w_office_skid_entry

type variables
Long il_current_job_num
Long il_current_order
Real ir_theo_pcwt
Long il_partial[]
Long il_cur_skid
Boolean ib_partial
Int ii_action  //0 - nothing  1 - newskid 2- new item 3-delect 4 - modify
Int il_current_order_item

//scrap handling
integer ii_dw_flag
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_readonly
Integer ii_action_scrap
Long il_cur_scrap_skid, il_cur_item

Long		il_modified_row //Alex Gerlants. 05/07/2018
Boolean	ib_use_package_num //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Long		il_selected_row //Alex Gerlants. Scrap Credit

//---

//Alex_Gerlants. 1260_Incoming_Customer_Quality. 08/16/2021. Begin
//String	is_attached_file_name[]
Long		il_customer_id //Alex_Gerlants. 1260_Incoming_Customer_Quality
Boolean	ib_pdf_done, ib_xls_done
String	is_skid_string
//String	is_customer_short_name_pdf, is_customer_short_name_xls

//SMTP email variables
n_smtp 	in_smtp

//Populated in Open event for w_inventory_reports
String	is_from_email //Sender email address
String	is_from_name //Sender name
String	is_server //SMTP server IP address
Integer	ii_port //SMTP port
String	is_send_email //Recipient email address
String	is_send_name //Recipient name
String	is_logfile //Log file where we record SMTP email messages if email fails
String	is_subject //Email subject line
String	is_email_folder //Windows folder where the files to attach to email are
String	is_file_name_2email //Beginning part of file name(s) to email
String	is_work_folder //Work folder where work files are created and deleted after they are used
String	is_archive_folder //Folder where the emailed files are archived
String	is_combine_bat_file //Bat file to combine pdf and xls file
String	is_taskkill_bat_file //Bat file to kill AcroRd32.exe tasks. They slow XLS creation
Boolean	ib_debugviewer = False

//---

//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
Boolean		ib_xls_done_comb
//String		is_email_addresses[]

//Diagnostic variables
Long			il_rows_coils, il_rows_scrap, il_rows_skids, il_rows_combined
Long			il_sum_skid_pieces, il_sum_item_pieces, il_sum_coil_net_wt, il_sum_coil_net_wt_balance
Long			il_sum_scrap_net_wt, il_sum_scrap_tare_wt
Long			il_sum_skid_net_wt, il_sum_item_net_wt
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. end

Integer		ii_inv_report_saveas_xlsx //Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic
//Alex_Gerlants. 1260_Incoming_Customer_Quality. 08/16/2021. End

Long			il_row_orig //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit




end variables

forward prototypes
public subroutine wf_get_prodorder# ()
public function integer wf_check_coil ()
public function string wf_filter_condition ()
public function integer wf_get_partial_skid ()
public function boolean wf_is_partial (long al_skid)
public function real wf_get_pc_theowt ()
public subroutine wf_set_action (integer ai_action)
public function integer wf_check_skid_wt (long al_skid, long al_item)
public function long wf_item_netwts (long al_skid, long al_item)
public function long wf_get_skid_theowt ()
public function integer wf_coil_sheet_wt (long al_coil, long al_item, long al_itemwt)
public function long wf_new_scrap_skid# ()
public subroutine wf_display_total_info ()
public function integer wf_check_info ()
public subroutine wf_set_scrap_action (integer ai_action)
public subroutine wf_coil_info ()
public subroutine wf_update_skid_list ()
public function integer wf_assign_package_num_2sheet_skid ()
public function long wf_get_package_num_4skid (long al_sheet_skid_num, n_tr_abc01 atr)
public subroutine wf_retrieve_scrap_handling (ref string as_scrap_handling_cust_order)
public function integer wf_scrap_credit (boolean ab_display_message, long al_scrap_skid_num, boolean ab_new_skid)
public function boolean wf_check_scrap_skid_status ()
public function boolean wf_check_sheet_skid_status ()
public subroutine wf_retrieve_qa_defect ()
public subroutine wf_retrieve_cust_defect_disposition (long al_ab_job_num)
public subroutine wf_retrieve_albl_defect_disposition ()
public subroutine wf_retrieve_skids_4job (long al_ab_job_num)
public subroutine excel_open_csv_saveas_xls ()
public subroutine wf_populate_abis_ini_variables ()
public function boolean wf_send_smtp_email (string as_email_from, string as_email_to, string as_subject, string as_body, string as_attached_file_name[])
public function integer wf_retrieve_d_qa_email_address ()
public function long wf_get_customer_id (long al_ab_job_num)
public function integer wf_save_qa_skid ()
public function long wf_retrieve_qa_customer_quality_skid (long al_sheet_skid_num)
public function integer wf_update_qa_customer_quality_skid ()
public subroutine wf_insert_qa_customer_quality_skid ()
public subroutine wf_retrieve_coils_4job (long al_ab_job_num)
public function integer wf_save_qa_customer_quality_many_skids (long al_customer_id, long al_ab_job_num, long al_coil_abc_num, long al_skids[], str_all_data_types astr_all_data_types[])
public function integer wf_attach_report_2email (string as_coil_org_num)
public function integer wf_retrieve_skids_4job_coil (long al_ab_job_num, boolean ab_initial_retrieve)
public subroutine wf_add_remove_selected_row (long al_selected_row, string as_add_delete)
public function integer wf_save_group_edit ()
public function integer wf_check_tare_wt ()
public function integer wf_check_onhold_reason ()
public function integer wf_insert_skid_onhold_reason_track (boolean ab_new_skid)
public function integer wf_attach_summary_2email (long al_ab_job_num)
public function string wf_cust_prod_info_customer (long al_job)
public function string wf_cust_prod_info_spec (long al_job)
public function integer wf_syn_skid_wt (ref datastore ads)
public subroutine wf_set_display_values (long al_job, ref datastore ads)
public function long wf_rejected_coil_wt (long al_ab_job_num, long al_coil_abc_num)
public subroutine wf_email_files_cleanup (string as_files_2delete[])
end prototypes

event ue_whoami;RETURN "w_offics_skid_entry"
end event

event type integer ue_partial_exist(long al_skid);Long ll_row, ll_l

ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF ll_row > 0 THEN
	FOR ll_l = 1 TO ll_row
		IF tab_skids.tabpage_sheet.dw_skid_list.getItemNumber(ll_l, "sheet_skid_sheet_skid_num", Primary!, FALSE) = al_skid THEN
			RETURN 1
		END IF
	NEXT
END IF

RETURN 0
end event

event ue_new_scrap_skid();Int li_i
Long ll_skid
li_i = MessageBox("Question","Use a existing pallet?",Question!, YesNoCancel!, 1)
IF li_i = 3 THEN RETURN
IF li_i = 1 THEN
	Open(w_select_new_scrap_skid)
	ll_skid = Message.DoubleParm
	tab_skids.tabpage_scrap.dw_editor.Event ue_addscrap(ll_skid)
	tab_skids.tabpage_scrap.dw_scrap_list.SetFilter("skid_scrap_status <> 6")
	tab_skids.tabpage_scrap.dw_scrap_list.Filter()
ELSE
	tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
	tab_skids.tabpage_scrap.dw_editor.DataObject = "d_office_entry_scrap_skid_list_editor"
	tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 
	tab_skids.tabpage_scrap.dw_editor.Event pfc_addrow()
END IF
end event

event ue_delete_scrap_skid();SetPointer(HourGlass!)

integer li_rc, li_status, li_rowcount
Long ll_row, ll_scrap_item, li_return, scrap_skid_id
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
	If ll_row < 1 THEN RETURN
	li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
	IF li_status = 0 THEN
		MessageBox("Error", "This scrap skid had been shipped!", StopSign!)
		RETURN
	END IF
	/*
	li_rowcount = tab_skids.tabpage_scrap.dw_scrap_item.RowCount()
	IF li_rowcount > 1 THEN
		MessageBox("Warning", "There are more than one items on this skid, Please delete items first.", StopSign!)
		RETURN
	END IF	
	
	*/
	il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	//MessageBox ("info", il_cur_scrap_skid)
	scrap_skid_id = il_cur_scrap_skid
	//transaction dboconnect
	//dboconnect = create transaction
	//dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	//dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	//dboconnect.LogID = gs_LogID
	//dboconnect.LogPass = gs_LogPass
	//connect using SQLCA;
	//if dboconnect.SQLCode<0 then 
	//	MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
   //return
	//end if

	DECLARE p_delete procedure for f_delete_scrap_skid (:scrap_skid_id) using sqlca;
	execute p_delete;
if sqlca.SQLCode <> 0 then 
	MessageBox ("Stored Procedure Failed!!!",sqlca.sqlerrtext,exclamation!)
	return
end if
fetch p_delete INTO :li_return; 
//close p_edi;

close p_delete;
IF li_return >10000 THEN
	MessageBox("Warning", "Skid assigned to shipment " +String(li_return) + "!!! Please delete in shipment first!", StopSign! )
	return
end if
//disconnect using sqlca;
//destroy dboconnect;
	

		IF tab_skids.tabpage_scrap.dw_scrap_list.GetRow() > 0 THEN
			tab_skids.tabpage_scrap.dw_scrap_list.DeleteRow(tab_skids.tabpage_scrap.dw_scrap_list.GetRow() )
		END IF









//	ll_row = tab_skids.tabpage_scrap.dw_scrap_item.GetRow()
//	il_cur_item =  tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE)
//	tab_skids.tabpage_scrap.dw_scrap_list.RowsCopy(tab_skids.tabpage_scrap.dw_scrap_list.GetRow(), tab_skids.tabpage_scrap.dw_scrap_list.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
//	wf_set_scrap_action(5)
//	tab_skids.tabpage_scrap.dw_editor.Event ue_del_row()

END IF
RETURN
end event

event ue_delete_scrap_item();SetPointer(HourGlass!)

integer li_rc, li_status, li_rowcount
Long ll_row
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
	If ll_row < 1 THEN RETURN
	li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
	IF li_status = 0 THEN
		MessageBox("Warning", "This scrap skid had been shipped!", StopSign!)
		RETURN
	END IF
	li_rowcount = tab_skids.tabpage_scrap.dw_scrap_item.RowCount()
	IF li_rowcount = 1 THEN
		MessageBox("Warning", "This is the last item on the skid!", StopSign!)
		RETURN
	END IF	
	il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	tab_skids.tabpage_scrap.dw_scrap_item.RowsCopy(tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
	wf_set_scrap_action(3)
	tab_skids.tabpage_scrap.dw_editor.Event ue_del_row()
END IF
RETURN

end event

event ue_scrap_report();//tab_skids.tabpage_scrap.dw_scrap_list.Print(TRUE)
	
//	Datawindow lds_temp
//lds_temp = Message.PowerObjectParm
SetPointer(HourGlass!)

tab_skids.tabpage_scrap.dw_scrap_list.ShareData(tab_skids.tabpage_scrap.dw_report )

long ll_row_cust
String ls_cust_name, ls_mod

//ll_row_cust = dw_customer.GetRow()
//ls_cust_name = dw_customer.GetItemString(ll_row_cust, "customer_short_name", Primary!, TRUE)
select customer_short_name into :ls_cust_name
from customer_order, customer
where customer.customer_id = customer_order.orig_customer_id and order_abc_num = :il_current_order
using SQLCA;

ls_cust_name = Upper(ls_cust_name)
ls_cust_name = Trim(ls_cust_name)

ls_mod = "cust_t.Text = ~"" + ls_cust_name + "~""
tab_skids.tabpage_scrap.dw_report.Modify(ls_mod) 

//dw_report.SetFocus()
	tab_skids.tabpage_scrap.dw_report.SetFocus()
	Printsetup()
	tab_skids.tabpage_scrap.dw_report.Print(TRUE)

end event

event ue_sort_scrap();String ls_null
SetNULL(ls_null)
tab_skids.tabpage_scrap.dw_scrap_list.inv_sort.of_SetSort(ls_null)
tab_skids.tabpage_scrap.dw_scrap_list.inv_sort.of_Sort()
//tab_skids.tabpage_scrap.dw_report.inv_sort.of_SetSort(ls_null)
//tab_skids.tabpage_scrap.dw_report.inv_sort.of_Sort()

end event

event ue_ref_scrap();Long ll_row, ll_id

//CHOOSE CASE tab_skids.SelectedTab
	//CASE 1 //skid
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		IF ll_row < 1 THEN RETURN
		ll_id = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
		IF ll_id > 0 THEN
			OpenWithParm(w_scrap_skid_detail_info, ll_id)
		END IF		
	//CASE 2 //rej coil
		//ll_row = tab_skid.tabpage_rejcoil.dw_rejcoils.GetRow()
		//IF ll_row < 1 THEN RETURN
		//ll_id = tab_scrap.tabpage_rejcoil.dw_rejcoils.GetItemNumber(ll_row, "coil_coil_abc_num", Primary!, FALSE)
		//IF ll_id > 0 THEN
		//	OpenWithParm(w_coil_detail_info, ll_id)
		//END IF		
//END CHOOSE
end event

event ue_read_only();tab_skids.tabpage_scrap.cb_new_scrap.Enabled = FALSE
tab_skids.tabpage_scrap.cb_newitem.Enabled = FALSE
tab_skids.tabpage_scrap.cb_edit.Enabled = FALSE
tab_skids.tabpage_scrap.cb_esave.Enabled = FALSE
tab_skids.tabpage_scrap.cb_ereset.Enabled = FALSE
tab_skids.tabpage_scrap.cb_remove.Enabled = FALSE
tab_skids.tabpage_scrap.cb_removeitem.Enabled = TRUE		

//m_prod_scrap.m_file.m_new.Disable()
//m_prod_scrap.m_file.m_save.Disable()
//m_prod_scrap.m_file.m_delete.Disable()

end event

public subroutine wf_get_prodorder# ();SingleLineEdit sle_order#
sle_order# = Message.PowerObjectParm
st_title#.Text = sle_order#.Text
il_current_job_num = Long(st_title#.Text)

end subroutine

public function integer wf_check_coil ();Long ll_coil, ll_trows, ll_i, ll_trowc, ll_j

dw_coil_status.AcceptText()
ll_trowc = dw_coil_status.RowCount()
IF ll_trowc < 1 THEN RETURN 0

FOR ll_i = 1 TO ll_trows
	ll_coil = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_coil_abc_num", Primary!, FALSE)
	FOR ll_j = 1 TO ll_trowc
		IF dw_coil_status.GetItemNumber(ll_j, "coil_coil_abc_num", Primary!, FALSE) = ll_coil THEN 
			IF dw_coil_status.GetItemNumber(ll_j, "coil_coil_status", Primary!, FALSE) = 2 THEN
				dw_coil_status.SetItem(ll_j, "coil_coil_status", 1) //processing
			END IF
		END IF
	NEXT
NEXT 

RETURN 1
end function

public function string wf_filter_condition ();Int li_up, li_i
String ls_terms

ls_terms = " ( sheet_skid_ab_job_num = " + String(il_current_job_num) + ") "
li_up = UpperBound(il_partial)
IF li_up > 0 THEN
	FOR li_i = 1 TO li_up
		IF il_partial[li_i] > 0 THEN
			ls_terms = ls_terms + " OR (sheet_skid_sheet_skid_num = " + String(il_partial[li_i]) + " ) "
		END IF
	NEXT
END IF

RETURN ls_terms
end function

public function integer wf_get_partial_skid ();Long ll_skid
Long ll_i
Long ll_row, ll_l
DataStore lds_d

lds_d = CREATE DataStore
lds_d.DataObject = "d_job_partial_skid_list"
lds_d.setTransObject(SQLCA)
lds_d.retrieve(il_current_job_num)

IF RowCount(lds_d) = 0 THEN RETURN 0

FOR ll_i = 1 TO rowCount(lds_d) 
	ll_skid = lds_d.GetItemNumber(ll_i, "sheet_skid_num")
	il_partial[Upperbound(il_partial) + 1] = ll_skid

	ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
	IF ll_row > 0 THEN
		FOR ll_l = 1 TO ll_row
			IF tab_skids.tabpage_sheet.dw_skid_list.getItemNumber(ll_l, "sheet_skid_sheet_skid_num", Primary!, FALSE) = ll_skid THEN
				IF tab_skids.tabpage_sheet.dw_skid_list.getItemNumber(ll_l,"sheet_skid_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_l, "sheet_skid_ab_job_num", il_current_job_num)
				END IF
			END IF
		NEXT
	END IF
	
//	ll_row = dw_skid_data.RowCount()
//	IF ll_row > 0 THEN
//		FOR ll_l = 1 TO ll_row
//			IF dw_skid_data.getItemNumber(ll_l, "sheet_skid_num", Primary!, FALSE) = ll_skid THEN
//				IF dw_skid_data.getItemNumber(ll_l,"ab_job_num", Primary!, FALSE) <> il_current_job_num THEN
//					dw_skid_data.SetItem(ll_l, "ab_job_num", il_current_job_num)
//				END IF
//			END IF
//		NEXT
//	END IF
	
NEXT
tab_skids.tabpage_sheet.dw_skid_list.AcceptText()
tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_SetFilter(wf_filter_condition())
tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_Filter()


DESTROY lds_d

RETURN 0
end function

public function boolean wf_is_partial (long al_skid);Boolean lb_partial

lb_partial = FALSE

RETURN lb_partial
end function

public function real wf_get_pc_theowt ();Long ll_order_item, ll_order
Real lr_wt

lr_wt = 0
CONNECT USING SQLCA;
SELECT order_item_num, order_abc_num INTO :ll_order_item, :ll_order
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;

IF ll_order_item > 0 AND ll_order > 0 THEN
	SELECT theoretical_unit_wt INTO :lr_wt
	FROM order_item
	WHERE order_abc_num = :ll_order AND order_item_num = :ll_order_item
	USING SQLCA;
END IF
IF IsNULL(lr_wt) THEN lr_wt = 0

RETURN lr_wt
end function

public subroutine wf_set_action (integer ai_action);IF ai_action = 0 THEN
	tab_skids.tabpage_sheet.cb_new.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_insert.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_delete.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_modify.Enabled = TRUE
	tab_skids.tabpage_sheet.cb_refresh.Enabled = TRUE
ELSE
	tab_skids.tabpage_sheet.cb_new.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_insert.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_delete.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_modify.Enabled = FALSE
	tab_skids.tabpage_sheet.cb_refresh.Enabled = FALSE
END IF
ii_action = ai_action

end subroutine

public function integer wf_check_skid_wt (long al_skid, long al_item);Long ll_row, ll_pc, ll_totalpc, ll_totalwt
Long ll_trow, ll_skid, ll_item, ll_i, ll_net
Long ll_otherpc, ll_othernet

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()
ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
ll_pc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_net = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)

ll_totalpc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
ll_totalwt = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)

ll_trow = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF (ll_trow < 1) OR IsNULL(ll_trow) THEN RETURN 0
ll_otherpc = 0
ll_othernet = 0
FOR ll_i = 1 TO ll_trow
	ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE)
	IF ll_skid = al_skid AND al_item <> ll_item THEN
		ll_otherpc = ll_otherpc + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
		ll_othernet = ll_othernet + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)		
	END IF
NEXT
IF ll_otherpc <> ll_totalpc - ll_pc THEN
	IF MessageBox("Question", "Skid pieces do not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
END IF
IF ll_othernet <> ll_totalwt - ll_net THEN
	IF MessageBox("Question", "Skid net wt does not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -2
END IF

RETURN 1
end function

public function long wf_item_netwts (long al_skid, long al_item);Long ll_net
Long ll_row, ll_i

ll_net = 0
ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF ll_row < 1 THEN RETURN ll_net
FOR ll_i = 1 TO ll_row
	IF al_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i,"sheet_skid_sheet_skid_num", Primary!, FALSE) THEN
		IF al_item <> tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_detail_prod_item_num", Primary!, FALSE) THEN
			ll_net = ll_net + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
		END IF
	END IF
NEXT	

RETURN ll_net
end function

public function long wf_get_skid_theowt ();Long ll_theowt
Long ll_row, ll_i, ll_skid, ll_item

ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
IF ll_row < 1 THEN RETURN ll_theowt
ll_skid = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_num", Primary!, FALSE)
ll_theowt = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)

ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
IF ll_row < 1 THEN RETURN ll_theowt	
FOR ll_i = 1 TO ll_row
	IF ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i,"sheet_skid_sheet_skid_num", Primary!, FALSE) THEN
		IF ll_item <> tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_detail_prod_item_num", Primary!, FALSE) THEN
			ll_theowt = ll_theowt + tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
		END IF
	END IF
NEXT	

RETURN ll_theowt
end function

public function integer wf_coil_sheet_wt (long al_coil, long al_item, long al_itemwt);Long ll_coilwt, ll_sheetwt, ll_othersheet
String	ls_answer //Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt

IF IsNULL(al_item) OR IsNULL(al_coil) OR IsNULL(al_itemwt) THEN RETURN 0

CONNECT USING SQLCA;
SELECT process_quantity INTO :ll_coilwt
FROM process_coil
WHERE coil_abc_num = :al_coil AND ab_job_num = :il_current_job_num
USING SQLCA;

IF ll_coilwt < 1 OR IsNULL(ll_coilwt) THEN RETURN 0

SELECT nvl(SUM(prod_item_net_wt), 0) INTO :ll_othersheet //Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. Added nvl().
FROM production_sheet_item
WHERE coil_abc_num = :al_coil AND ab_job_num = :il_current_job_num AND prod_item_num <> :al_item
USING SQLCA;
ll_sheetwt = al_itemwt + ll_othersheet

//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. Comment out begin
//IF ll_sheetwt > ll_coilwt THEN
//	IF MessageBox("Question", "This coil has more net sheet wt than the beginning coil wt, continue?", Question!, YesNo!, 1) <> 1 THEN RETURN -1
//END IF 
//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. Comment out end


//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. Begin
//ll_sheetwt = ll_sheetwt + 50000 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

If ll_sheetwt > ll_coilwt Then
	Open(w_net_wt_warning)
	ls_answer = Message.StringParm
	
	If Upper(ls_answer) <> "YES" Then Return -1
End If
//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. End

RETURN 1
end function

public function long wf_new_scrap_skid# ();Long  ll_int_next_id
String ls_col_name

ls_col_name = 'scrap_skid_num_seq'
SELECT scrap_skid_num_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;

// generate next id using oracle sequence 
UPDATE sequence_key
SET sequence_curval = :ll_int_next_id
WHERE sequence_name = :ls_col_name
USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
	ROLLBACK using SQLCA;
	Return -2
ELSE
	COMMIT using SQLCA;
END IF

Return ll_int_next_id
end function

public subroutine wf_display_total_info ();/*
String ls_where, ls_select
Long ll_item

CONNECT USING SQLCA;
//ls_select = "SELECT COUNT(scrap_skid.scrap_skid_num) FROM scrap_skid "
//ls_where = wf_display_total_terms()
//IF IsNULL(ls_where) THEN RETURN 

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
String ls_Mysql
ls_Mysql = "SELECT COUNT(scrap_skid.scrap_skid_num) FROM scrap_skid where ((scrap_ab_job_num = " + String (il_current_job_num) + ")  OR ( SKID_SCRAP_STATUS = 6 ))   AND	( CUSTOMER_ID <> 1054 )"//ls_select + ls_where

PREPARE SQLSA FROM :ls_Mysql;
OPEN DYNAMIC my_cursor;
FETCH my_cursor INTO :ll_item;
CLOSE my_cursor ;

IF IsNULL(ll_item) THEN ll_item = 0

IF ll_item < 2 THEN
	tab_skids.tabpage_scrap.dw_scrap_list.Object.item_t.Text = String(ll_item, "#,###,###")
	tab_skids.tabpage_scrap.dw_scrap_list.Object.skid_t.Text = "Scrap Skid"
ELSE
	tab_skids.tabpage_scrap.dw_scrap_list.Object.item_t.Text = String(ll_item, "#,###,###")
	tab_skids.tabpage_scrap.dw_scrap_list.Object.skid_t.Text = "Scrap Skids"
END IF
*/
RETURN 
end subroutine

public function integer wf_check_info ();Long ll_row, ll_row2, ll_cust, ll_job, ll_icoil
String ls_alloy, ls_calloy
Long ll_ccust

//ll_row = dw_customer.GetRow()
//IF ll_row > 0 THEN
//	ll_cust = dw_customer.GetITemNumber(ll_row, "customer_id")
//END IF
select orig_customer_id into :ll_cust
from customer_order
where order_abc_num = :il_current_order
using SQLCA;

tab_skids.tabpage_scrap.dw_editor.AcceptText()
ll_row = tab_skids.tabpage_scrap.dw_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN 0
CHOOSE CASE ii_action
	CASE 1, 4  //skid
		ll_job = Long(tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_ab_job_num", Primary!, FALSE))
	CASE 2, 6   //item
		ll_icoil = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_coil_abc_num", Primary!, FALSE)
		ll_job = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_ab_job_num", Primary!, FALSE)
		ll_row2 = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		IF (ll_row2 > 0) THEN
			ls_alloy = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_row2, "scrap_alloy2", Primary!, FALSE)
		ELSE
			ls_alloy = ""
		END IF
END CHOOSE
IF ll_job > 0 THEN
	CONNECT USING SQLCA;
	SELECT customer_order.orig_customer_id INTO :ll_ccust
	FROM customer_order, ab_job
	WHERE ab_job.ab_job_num = :ll_job and ab_job.order_abc_num = customer_order.order_abc_num
	USING SQLCA;
	IF ll_ccust <> ll_cust THEN
		IF MessageBox("Warning", "Job number and customer do NOT match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -1
	END IF
	SELECT order_item.alloy2 INTO :ls_calloy
	FROM order_item, ab_job
	WHERE ab_job.ab_job_num = :ll_job and ab_job.order_abc_num = order_item.order_abc_num and ab_job.order_item_num = order_item.order_item_num
	USING SQLCA;
	IF (ls_calloy <> ls_alloy) and (ls_alloy <> "") THEN
		IF MessageBox("Warning", "Job and scrap skid alloy do not match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -2
	END IF
END IF
IF ll_icoil > 0 THEN
	CONNECT USING SQLCA;
	SELECT coil_alloy2 INTO :ls_calloy
	FROM coil
	WHERE coil_abc_num = :ll_icoil
	USING SQLCA;
	IF (ls_calloy <> ls_alloy) and (ls_alloy <> "") THEN
		IF MessageBox("Warning", "Coil and scrap skid alloy do not match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -3
	END IF	
END IF
	
RETURN 1
end function

public subroutine wf_set_scrap_action (integer ai_action);IF ai_action = 0 THEN
	IF f_security_door("Scrap Handling") = 1 THEN
		tab_skids.tabpage_scrap.cb_new_scrap.Enabled = TRUE
		tab_skids.tabpage_scrap.cb_newitem.Enabled = TRUE
		tab_skids.tabpage_scrap.cb_edit.Enabled = TRUE
		tab_skids.tabpage_scrap.cb_esave.Enabled = FALSE
		tab_skids.tabpage_scrap.cb_ereset.Enabled = FALSE
		tab_skids.tabpage_scrap.cb_remove.Enabled = TRUE		
		tab_skids.tabpage_scrap.cb_removeitem.Enabled = TRUE		
	ELSE
		//This.Event ue_read_only()
	END IF
ELSE
	tab_skids.tabpage_scrap.cb_new_scrap.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_newitem.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_edit.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_remove.Enabled = FALSE
	tab_skids.tabpage_scrap.cb_removeitem.Enabled = TRUE		
	tab_skids.tabpage_scrap.cb_esave.Enabled = TRUE
	tab_skids.tabpage_scrap.cb_ereset.Enabled = TRUE
END IF
ii_action_scrap = ai_action
end subroutine

public subroutine wf_coil_info ();//Alex Gerlants. 03/14/2018. Begin
/*
Function:	wf_coil_info
				It will update information needed to show in compute_1 on dw_skid_list
Returns:		none
Arguments:	none
*/

Long		ll_coil_abc_num
String	ls_coil_org_num, ls_coil_mid_num, ls_lot_num


ll_coil_abc_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.production_sheet_item_coil_abc_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()]

select	coil_org_num, coil_mid_num, lot_num
into		:ls_coil_org_num, :ls_coil_mid_num, :ls_lot_num
from		coil
where		coil_abc_num = :ll_coil_abc_num
using		sqlca;

tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_org_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()] = ls_coil_org_num
tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_mid_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()] = ls_coil_mid_num
tab_skids.tabpage_sheet.dw_skid_editor.Object.lot_num[tab_skids.tabpage_sheet.dw_skid_editor.GetRow()] = ls_lot_num
//Alex Gerlants. 03/14/2018. End
end subroutine

public subroutine wf_update_skid_list ();//Alex Gerlants. 05/07/2018. Begin
/*
Function:	wf_update_skid_list
Returns:		None
Arguments:	None
*/
String	ls_coil_org_num, ls_coil_mid_num, ls_lot_num
Long		ll_editor_rows, ll_coil_abc_num, ll_editor_row
Integer	li_onhold_reason_code //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason

//Get coil_org_num, coil_mid_num, lot_num, and coil_abc_num from dw_skid_editor
tab_skids.tabpage_sheet.dw_skid_editor.GetRow()

ll_editor_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
//ll_editor_rows = tab_skids.tabpage_sheet.dw_skid_editor.RowCount()

If ll_editor_row > 0 Then
	ls_coil_org_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_org_num[ll_editor_row]
	ls_coil_mid_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_mid_num[ll_editor_row]
	ls_lot_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.lot_num[ll_editor_row]
	ll_coil_abc_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.production_sheet_item_coil_abc_num[ll_editor_row]
	li_onhold_reason_code = tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code[ll_editor_row] //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason
	
	//Update dw_skid_list
	If il_modified_row > 0 Then
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_org_num[il_modified_row] = ls_coil_org_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_mid_num[il_modified_row] = ls_coil_mid_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.lot_num[il_modified_row] = ls_lot_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.production_sheet_item_coil_abc_num[il_modified_row] = ll_coil_abc_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.onhold_reason_code[il_modified_row] = li_onhold_reason_code //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason
		
		il_modified_row = 0 //Reset
	End If
End If
//Alex Gerlants. 05/07/2018. End
end subroutine

public function integer wf_assign_package_num_2sheet_skid ();//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
/*
Function:	wf_assign_package_num_2sheet_skid
Returns:		integer	 1 if ok
							-1 if DB error
Arguments:	none							
*/

Integer	li_rtn = 1
Long		ll_ab_job_num, ll_rows, ll_row, ll_sheet_skid_num
Boolean	lb_use_package_num


li_rtn = f_get_use_package_num_4job(il_current_job_num, sqlca, lb_use_package_num)

If li_rtn = 0 Then //OK in f_get_use_package_num_4job(). li_rtn = sqlca.sqlcode in f_get_use_package_num_4job().
	If IsNull(lb_use_package_num) Then lb_use_package_num = False
Else //DB error in f_get_use_package_num_4job(). Error message is in this function.
	lb_use_package_num = False
End If

If lb_use_package_num Then
	tab_skids.tabpage_sheet.dw_skid_list.AcceptText()
	
	ll_rows = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
	
	For ll_row = 1 To ll_rows
		ll_ab_job_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_ab_job_num[ll_row]
		ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row]
		
		li_rtn = f_assign_package_num(ll_ab_job_num, ll_sheet_skid_num, sqlca)
		
		If li_rtn <> 0 Then //Error in f_assign_package_num()
			Return -1
		End If
	Next
	End If

Return li_rtn
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
end function

public function long wf_get_package_num_4skid (long al_sheet_skid_num, n_tr_abc01 atr);//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
/*
Function:	wf_get_package_num_4skid
Returns:		long <== package_num if ok
					  <== -1 if db error
Arguments:	value	long			al_sheet_skid_num
				value	n_tr_abc01	atr
*/
Long		ll_package_num

SetNull(ll_package_num)

select	package_num
into		:ll_package_num
from		dbo.sheet_skid_package
where		sheet_skid_num = :al_sheet_skid_num
using		atr;

Choose Case atr.sqlcode
	Case 0 //Row found. OK
		//
	Case 100 //Row not found
		//ll_package_num = Null. OK
	Case Else //DB error
		ll_package_num = -1
	
		MessageBox("DB error", 	"Database error occurred in wf_get_package_num_4skid for w_office_skid_entry " + &
										"while triyng to retrieve package number from table sheet_skid_package " + &
										"for skid " + String(al_sheet_skid_num) + &
										"~n~r~n~rError:~n~r" + atr.sqlerrtext)
End Choose

Return ll_package_num
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
end function

public subroutine wf_retrieve_scrap_handling (ref string as_scrap_handling_cust_order);//Alex Gerlants. Scrap Credit. Begin
/*
Function:	wf_retrieve_scrap_handling
Returns:		none
Arguments:	value	string	as_scrap_handling_cust_order
*/
DataWindowChild 	ldwc
Integer				li_rtn
String				ls_find_string
Long					ll_found_row

Long					ll_rows, ll_inserted_row, ll_null
String				ls_null

li_rtn = tab_skids.tabpage_scrap.dw_editor.GetChild("scrap_handling_type", ldwc)

If li_rtn = 1 Then
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	ls_find_string = "scrap_handling_type = '" + as_scrap_handling_cust_order + "'"
	
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ldwc.ScrollToRow(ll_found_row)
		tab_skids.tabpage_scrap.dw_editor.Object.scrap_handling_type[1] = as_scrap_handling_cust_order
	End If
	
	//ll_inserted_row = ldwc.InsertRow(1)

	//If ll_inserted_row > 0 Then
		//SetNull(ll_null)
		//SetNull(ls_null)
		//
		//ldwc.SetItem(ll_inserted_row, "customer_id", ll_null)
		//ldwc.SetItem(ll_inserted_row, "customer_short_name", ls_null)
	//End If
End If
//Alex Gerlants. Scrap Credit. End
end subroutine

public function integer wf_scrap_credit (boolean ab_display_message, long al_scrap_skid_num, boolean ab_new_skid);//Alex Gerlants. Scrap Credit. Begin
/*
Function:	wf_scrap_credit
Return:		integer	<==	 1 if OK
									-1 if DB error
Arguments:	value	boolean	ab_display_message
				value	long		al_scrap_skid_num
				value	boolean	ab_new_skid
*/

Integer	li_rtn = 1
Boolean	lb_window_open
Long		ll_row
Int 		li_status,  li_answer

If ab_new_skid Then
	li_answer = 1
Else //Modify skid
	ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
	
	If ll_row < 1 Then Return -1
	
	li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, False)
	
	If li_status = 0 Then
		MessageBox("Error","Failed to modify this scrap skid because it has been shipped to customer already.", StopSign!)
		Return 0
	//Else
	//	ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	End If
	
	If ab_display_message Then //This comes from Clicked event for cb_esave on Scrap tab
		li_answer = MessageBox("Confirmation","Please confirm making scrap skid #" + String(al_scrap_skid_num) + " into scrap credit.", Question!, YesNo!)
	Else
		li_answer = 1
	End If
End If

If li_answer  =  1 Then
	update	scrap_skid  
	set		customer_id = 1054  
	where	scrap_skid.scrap_skid_num =  :al_scrap_skid_num  
	using	sqlca;
	
	IF sqlca.sqlcode = -1 THEN 
	  MessageBox("Database error", "Error in wf_scrap_credit for w_office_skid_entry while modifying table scrap_skid." + &
												"~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
	  li_rtn = -1
	Else //OK
		//lb_window_open = f_other_window_open("Scrap & Reject Sheets")
		//If lb_window_open Then Close(w_prod_scrap)
	End If

	tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
Else
	Return 0
End If	

Return li_rtn
//Alex Gerlants. Scrap Credit. End

end function

public function boolean wf_check_scrap_skid_status ();//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. Begin
/*
Function:	wf_check_scrap_skid_status
Returns:		boolean	True if OK to change skid status
							False if not OK to change skid status
*/

Long		ll_row, ll_scrap_skid_num, ll_scrap_skid_status_new, ll_scrap_skid_status_prev, ll_found_row
Integer	li_answer
String	ls_find_string, ls_yes_no
Boolean	lb_ok_2change_status = True

//tab_skids.tabpage_scrap.dw_editor.AcceptText()
//
//ll_row = tab_skids.tabpage_scrap.dw_editor.GetRow()
//ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_editor.Object.scrap_skid_detail_scrap_skid_num[ll_row]
//ll_scrap_skid_status_new = tab_skids.tabpage_scrap.dw_editor.Object.skid_scrap_status[ll_row]
//
//ls_find_string = "sheet_skid_sheet_skid_num = " + String(ll_scrap_skid_num)
//ll_found_row = tab_skids.tabpage_sheet.dw_skid_list.Find(ls_find_string, 1, tab_skids.tabpage_sheet.dw_skid_list.RowCount())
//
//If ll_found_row > 0 Then
//	ll_scrap_skid_status_prev = tab_skids.tabpage_scrap.dw_scrap_list.Object.skid_scrap_status[ll_found_row]
//	
//	If ll_scrap_skid_status_prev = 0 And ll_scrap_skid_status_new <> 0 Then //Skid is Gone
	
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.Object.scrap_skid_num[ll_row]
	
		//Display warning
		OpenWithParm(w_skid_status_change_warning, ll_scrap_skid_num)
		ls_yes_no = Message.StringParm
		
		If ls_yes_no = "YES" Then
			lb_ok_2change_status = True
		Else
			lb_ok_2change_status = False
		End If
//	
//		////Display warning
//		//li_answer = MessageBox("Are you sure?", "Skid "  + String(ll_scrap_skid_num) + " is gone.~n~r" + &
//		//								"Are you sure you want to change its status?", &
//		//								Question!, YesNo!, 2)
//		//														
//		//If li_answer = 2 Then //No
//		//	lb_ok_2change_status = False
//		//End If
//	End If
//End If

Return lb_ok_2change_status
//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. End
end function

public function boolean wf_check_sheet_skid_status ();//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. Begin
/*
Function:	wf_check_sheet_skid_status
Returns:		boolean	True if OK to change skid status
							False if not OK to change skid status
*/

Long		ll_row, ll_skid_sheet_num, ll_skid_sheet_status_new, ll_skid_sheet_status_prev, ll_found_row
Integer	li_answer
String	ls_find_string, ls_yes_no
Boolean	lb_ok_2change_status = True

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()

ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()

If ll_row <= 0 Then Return False

ll_skid_sheet_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_sheet_skid_num[ll_row]
ll_skid_sheet_status_new = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_skid_sheet_status[ll_row]

ls_find_string = "sheet_skid_sheet_skid_num = " + String(ll_skid_sheet_num)
ll_found_row = tab_skids.tabpage_sheet.dw_skid_list.Find(ls_find_string, 1, tab_skids.tabpage_sheet.dw_skid_list.RowCount())

If ll_found_row > 0 Then
	ll_skid_sheet_status_prev = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_skid_sheet_status[ll_found_row]
	
	If ll_skid_sheet_status_prev = 0 And ll_skid_sheet_status_new <> 0 Then //Skid is Gone
	
		//Display warning
		OpenWithParm(w_skid_status_change_warning, ll_skid_sheet_num)
		ls_yes_no = Message.StringParm
		
		If ls_yes_no = "YES" Then
			lb_ok_2change_status = True
		Else
			lb_ok_2change_status = False
		End If
	
		////Display warning
		//li_answer = MessageBox("Are you sure?", "Skid "  + String(ll_skid_sheet_num) + " is gone.~n~r" + &
		//								"Are you sure you want to change its status?", &
		//								Question!, YesNo!, 2)
		//														
		//If li_answer = 2 Then //No
		//	lb_ok_2change_status = False
		//End If
	End If
End If

Return lb_ok_2change_status
//Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning. End
end function

public subroutine wf_retrieve_qa_defect ();////Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
///*
//Function:	wf_retrieve_qa_defect
//Returns:		none
//Arguments:	none
//*/
//DataWindowChild 	ldwc
//Integer				li_rtn
//Long					ll_rows
//
//li_rtn = tab_skids.tabpage_qa_skid.dw_qa_defect.GetChild("defect", ldwc)
//
//If li_rtn = 1 Then
//	ldwc.SetTransObject(sqlca)
//	ll_rows = ldwc.Retrieve()
//End If
////Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end subroutine

public subroutine wf_retrieve_cust_defect_disposition (long al_ab_job_num);////Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
///*
//Function:	wf_retrieve_cust_defect_disposition
//Returns:		none
//Arguments:	value	long al_ab_job_num
//*/
//
//DataWindowChild 	ldwc
//Integer				li_rtn
//Long					ll_customer_id
//Long					ll_rows
//
//li_rtn = tab_skids.tabpage_qa_skid.dw_qa_cust_defect_disposition.GetChild("disp_desc", ldwc)
//
//If li_rtn = 1 Then
//	ldwc.SetTransObject(sqlca)
//	ll_rows = ldwc.Retrieve(il_customer_id)
//End If
////Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end subroutine

public subroutine wf_retrieve_albl_defect_disposition ();////Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
///*
//Function:	wf_retrieve_albl_defect_disposition
//Returns:		none
//Arguments:	none
//*/
//DataWindowChild 	ldwc
//Integer				li_rtn
//Long					ll_rows
//
//li_rtn = tab_skids.tabpage_qa_skid.dw_qa_albl_defect_disposition.GetChild("disp_desc", ldwc)
//
//If li_rtn = 1 Then
//	ldwc.SetTransObject(sqlca)
//	ll_rows = ldwc.Retrieve()
//End If
////Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end subroutine

public subroutine wf_retrieve_skids_4job (long al_ab_job_num);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_retrieve_skids_4job
Returns:		none
Arguments:	value	long al_ab_job_num
*/
DataWindowChild 	ldwc
Integer				li_rtn
Long					ll_rows

tab_skids.tabpage_qa_skid.dw_skids_4job.SetTransObject(sqlca)
ll_rows = tab_skids.tabpage_qa_skid.dw_skids_4job.Retrieve(al_ab_job_num)
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End

end subroutine

public subroutine excel_open_csv_saveas_xls ();//Alex_Gerlants. 1260_Incoming_Customer_Quality. 08/16/2021. Begin
/* 
Function:	excel_open_csv_saveas_xls
Returns:		none
Arguments:	none

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_file_name, ls_email_file, ls_file_in, ls_file_out, ls_file_archive
String		ls_work_folder, ls_email_folder, ls_archive_folder 
String		ls_date, ls_time, ls_date_time
Integer		li_rtn, li_filenum
Long			ll_pos
Boolean		lb_rtn
Any			la_rtn

SetPointer( HourGlass! )

ls_work_folder = is_work_folder
If Right(is_work_folder, 1) <> "\" Then is_work_folder = is_work_folder + "\"

ls_email_folder = is_email_folder
If Right(ls_email_folder, 1) <> "\" Then ls_email_folder = ls_email_folder + "\"

ls_archive_folder = is_archive_folder
If Right(ls_archive_folder, 1) <> "\" Then ls_archive_folder = ls_archive_folder + "\"

ls_file_name = "Inventory_all.csv"

ls_file_in = ls_work_folder + ls_file_name

lole_OLE = CREATE OleObject
li_rtn = lole_OLE.ConnectToNewObject('excel.application')

If li_rtn = 0 Then
	lole_OLE.Application.DisplayAlerts = "False"
	la_rtn = lole_OLE.Workbooks.Open(ls_file_in)
	lole_OLE.Visible=FALSE
	
	If ii_inv_report_saveas_xlsx = 0 Then //Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic
		ls_file_out = Left(ls_file_in, Len(ls_file_in) - 3) + "xls"
	//Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic. Begin
	Else //ii_inv_report_saveas_xlsx = 1
		ls_file_out = Left(ls_file_in, Len(ls_file_in) - 3) + "xlsx"
	End If //Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic
	
	FileDelete(ls_file_out)
	
	//MessageBox("excel_open_csv_saveas_xls for w_inventory_reports", "Before saveas. ls_file_out = " + ls_file_out)
	
	If ii_inv_report_saveas_xlsx = 0 Then //Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic
		lole_OLE.ActiveWorkbook.SaveAs(ls_file_out, 56) //excel8 <== xls
	//Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic. Begin		
	Else //ii_inv_report_saveas_xlsx = 1
		lole_OLE.ActiveWorkbook.SaveAs(ls_file_out, 51) //xlsx
	End If
	//Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic. End
	
	//MessageBox("excel_open_csv_saveas_xls for w_inventory_reports", "After saveas. ls_file_out = " + ls_file_out)
	
	lole_OLE.Application.DisplayAlerts = "False"
End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

Garbagecollect()

//---

ls_date = String(Today(), "mmddyyyy")
ls_time = String(Now(), "hhmmss")
ls_date_time = ls_date + "_" + ls_time

ll_pos = Pos(ls_file_out, "Inventory_all.xls", 1)

If ll_pos > 0 Then
	If ii_inv_report_saveas_xlsx = 0 Then //Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic
		ls_email_file = Left(ls_file_out, ll_pos - 1) + "email\" + "Inventory_" + ls_date_time + ".xls"
	//Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic. Begin		
	Else //ii_inv_report_saveas_xlsx = 1
		ls_email_file = Left(ls_file_out, ll_pos - 1) + "email\" + "Inventory_" + ls_date_time + ".xlsx"
	End If
	//Alex Gerlants. 04/09/2021. 1156_Change_Excel_Type_4Arconic. End
		
	li_filenum = FileCopy(ls_file_out, ls_email_file, True) //True - Override if file exists
	
	ls_file_archive = ls_archive_folder + Right(ls_email_file, Len(ls_email_file) - Len(ls_email_folder))
End If

If li_filenum = 1 Then //OK
	lb_rtn = FileDelete(ls_file_in)
	//lb_rtn = FileDelete(ls_file_out)
	//li_rtn = FileMove(ls_file_out, ls_file_archive)
End If

SetPointer( Arrow! )
//Alex_Gerlants. 1260_Incoming_Customer_Quality. 08/16/2021. End
end subroutine

public subroutine wf_populate_abis_ini_variables ();//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_populate_abis_ini_variables
Returns:		none
Arguments:	none
*/

Long		ll_row, ll_rows
Integer	li_rtn
String	ls_port, ls_send_email

is_from_name = gnv_app.of_GetUserId()

dw_abis_ini.SetTransObject(sqlca)
ll_rows = dw_abis_ini.Retrieve('qa')

If ll_rows > 0 Then
	is_server = f_get_ini_value("qa","smtp_email","server","192.168.3.67")
	
	ls_port = f_get_ini_value("qa","smtp_email","port","25")
			
	If IsNumber(ls_port) Then
		ii_port = Integer(ls_port)
	Else
		ii_port = 25
	End If
	
	is_logfile = f_get_ini_value("qa","smtp_email","logfile","c:\temp\SMTP_Email_LogFile.txt")
	is_send_name = f_get_ini_value("qa","smtp_email","send_name","ALBL QA Department")
Else
	is_server = "192.168.3.67"
	ii_port = 25
	is_logfile = "c:\temp\SMTP_Email_LogFile.txt"
	is_send_name = "ALBL QA Department"
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end subroutine

public function boolean wf_send_smtp_email (string as_email_from, string as_email_to, string as_subject, string as_body, string as_attached_file_name[]);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_send_smtp_email
Returns:		boolean
Arguments:	value	string	as_email_from				<== Sender email
				value	string	as_email_to					<== Recipient email address
				value	string	as_subject					<== Email subject
				value	string	as_body						<== Email body
				value	string	as_attached_file_name[]	<== Files to attach to email.
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email, ls_subject, ls_body
String	ls_from_email, ls_from_name

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject(as_subject)

//ls_body = tab_skids.tabpage_qa_skid.mle_email_body.Text
in_smtp.of_SetBody(as_body, False)
in_smtp.of_SetFrom(as_email_from, is_from_name)

//ls_send_email = tab_skids.tabpage_qa_skid.sle_email_address_from.Text
in_smtp.of_AddAddress(as_email_to, as_email_to)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public function integer wf_retrieve_d_qa_email_address ();//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_retrieve_d_qa_email_address
Returns:		integer
Arguments:	none
*/

Integer	li_rtn = 1
Long		ll_customer_id, ll_rows
String	ls_customer_name

select	dbo.auto_report_customers.customer_name
into		:ls_customer_name
from		ab_job
      	join customer_order on customer_order.order_abc_num = ab_job.order_abc_num
			join dbo.auto_report_customers on customer_order.orig_customer_id = dbo.auto_report_customers.customer_id
where		ab_job.ab_job_num = :il_current_job_num
and		rownum = 1
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	tab_skids.tabpage_qa_skid.dw_qa_email_address.SetTransObject(sqlca)
	ll_rows = tab_skids.tabpage_qa_skid.dw_qa_email_address.Retrieve(ls_customer_name)
Else
	If sqlca.sqlcode < 0 Then//DB error
		MessageBox("Database error", "Database error while retrieving customer id for job " + String(il_current_job_num) + &
					"~n~rDB error:~n~r" + sqlca.sqlerrtext)
		li_rtn = -1
	End If
End If

Return li_rtn
end function

public function long wf_get_customer_id (long al_ab_job_num);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_get_customer_id
Returns:		none
Arguments:	value	long al_ab_job_num
*/

Long					ll_customer_id

select	customer_order.orig_customer_id
into		:ll_customer_id
from		ab_job
			join customer_order on customer_order.order_abc_num = ab_job.order_abc_num
where		ab_job.ab_job_num = :al_ab_job_num
using		sqlca;

If sqlca.sqlcode <> 0 Then
	ll_customer_id = 0 //Don't bother with an error message. User will call support anyway.
End If

Return ll_customer_id
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public function integer wf_save_qa_skid ();////Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
///*
//Function:	wf_save_qa_skid
//Returns:		integer
//Arguments:	none
//*/
//
Integer	li_rtn = 1, li_defect_code, li_albl_disp_code, li_cust_disp_code, li_count
//Long		ll_sheet_skid_num
//DateTime	ldtm_current_datetime
//String	ls_note
//
//ldtm_current_datetime = DateTime(Today(), Now())
//ll_sheet_skid_num = tab_skids.tabpage_qa_skid.dw_skids_4job.Object.sheet_skid_num[1]
//li_defect_code = tab_skids.tabpage_qa_skid.dw_qa_defect.Object.defect[1]
//li_albl_disp_code = tab_skids.tabpage_qa_skid.dw_qa_albl_defect_disposition.Object.disp_desc[1]
//li_cust_disp_code = tab_skids.tabpage_qa_skid.dw_qa_cust_defect_disposition.Object.disp_desc[1]
//ls_note = tab_skids.tabpage_qa_skid.mle_email_body.Text
//
//select	count(*)
//into		:li_count
//from		qa_customer_quality_skid
//where		customer_id = :il_customer_id
//and		sheet_skid_num = :ll_sheet_skid_num
//and		defect_code = :li_defect_code
//using		sqlca;
//
//Choose Case sqlca.sqlcode
//	Case 0 //OK. Row exists
//		update	qa_customer_quality_skid
//		set		albl_disp_code = :li_albl_disp_code,
//					cust_disp_code = :li_cust_disp_code,
//					qa_record_date = :ldtm_current_datetime,
//					note = :ls_note
//		using		sqlca;
//		
//		If sqlca.sqlcode <> 0 Then //DB error
//			MessageBox("Database error", "Database error in wf_save_qa_skid while updating table qa_customer_quality_skid." + &
//								"~n~rDB error:~n~rsqlca.sqlerrtext")
//			li_rtn = -1
//		End If
//	Case 100 //OK. Row does not exist
//		insert into qa_customer_quality_skid
//		values	(:il_customer_id, :ll_sheet_skid_num, :li_defect_code, :li_albl_disp_code, li_cust_disp_code, :ldtm_current_datetime, :ls_note)
//		using		sqlca;
//	Case Else //DB error
//	
//End Choose
//
Return li_rtn
////Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public function long wf_retrieve_qa_customer_quality_skid (long al_sheet_skid_num);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_retrieve_qa_customer_quality_skid
Returns:		long
Arguments:	none
*/
DataWindowChild 	ldwc
Integer				li_rtn, li_null, li_disp_code
Long					ll_rows, ll_row_inserted
String				ls_filter_string, ls_note, ls_null, ls_disp_code

ll_rows = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Retrieve(il_customer_id, al_sheet_skid_num)

SetNull(li_null)
SetNull(ls_null)

If ll_rows > 0 Then
	ls_note = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.note[1]
	//tab_skids.tabpage_qa_skid.mle_email_body.Text = ls_note
	
	//Filter cust_disp_code for il_customer_id
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetChild("cust_disp_code", ldwc)

	If li_rtn = 1 Then
		ls_filter_string = "customer_id = " + String(il_customer_id)
		ldwc.SetFilter(ls_filter_string)
		ldwc.Filter()
		
		li_disp_code = ldwc.GetItemNumber(1, "disp_code")
		
		If Not IsNull(li_disp_code) Then
			ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
			
			If ll_row_inserted > 0 Then
				ldwc.SetItem(ll_row_inserted, "customer_id", il_customer_id)
				ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
				ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
			End If
		End If
	End If
	
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetChild("albl_disp_code", ldwc)

	If li_rtn = 1 Then
		
		ls_disp_code = ldwc.GetItemString(1, "disp_code")
		
		If Not IsNull(li_disp_code) Then
			ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
			
			If ll_row_inserted > 0 Then
				ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
				ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
			End If
		End If
	End If
End If

Return ll_rows
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public function integer wf_update_qa_customer_quality_skid ();//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_update_qa_customer_quality_skid
Returns:		integer
Arguments:	none
*/

Integer	li_rtn = 1, li_defect_code, li_count
Long		ll_customer_id, ll_sheet_skid_num, ll_current_row, ll_rows, ll_row, ll_found_row, ll_row_find
DateTime	ldt_current_datetime
String	ls_error_string, ls_find_string

tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.AcceptText()
ll_rows = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.RowCount()

////For the current row, we have to copy email subject to qa_customer_quality_skid.note
//ll_current_row = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetRow()
//
//If ll_current_row > 0 Then

If ll_rows > 0 Then
	For ll_row = 1 To ll_rows
		//Make sure that the 3 key columns are populated. If not, reject update
		ll_customer_id = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.customer_id[ll_row]
		ll_sheet_skid_num = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.sheet_skid_num[ll_row]
		li_defect_code = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.defect_code[ll_row]
		
		If IsNull(ll_customer_id) Or IsNull(ll_sheet_skid_num) Or IsNull(li_defect_code) Then
			//MessageBox("Required field not populated", "Defect must be populated on line " + String(ll_row) + ". ~n~rPlease correct.")
			ls_error_string = "Defect must be populated on line " + String(ll_row) + "~n~r"
			
		End If
		
		If li_rtn = 1 Then //OK above
			//tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.note[ll_row] = tab_skids.tabpage_qa_skid.mle_email_body.Text
			
			ldt_current_datetime = DateTime(Today(), Now())
			tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.qa_record_date[ll_row] = ldt_current_datetime
			tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.user_id[ll_row] = is_from_name
		End If
	//End If
	Next
	
	If ls_error_string <> "" Then
		li_rtn = -1
		MessageBox("Required field not populated", ls_error_string + "~n~rPlease correct.")
	End If
	
//	If li_rtn = 1 Then //OK above
//		//Scan for multiple li_defect_code
//		For ll_row = 1 To ll_rows
//			li_defect_code = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.defect_code[ll_row]
//			ls_find_string = "defect_code = " + String(li_defect_code)
//			
//			For ll_row_find = 1 To ll_rows
//				ll_found_row = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Find(ls_find_string, ll_row, tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.RowCount())
//				
//				If ll_found_row > 0 Then
//					li_count++
//				End If
//			Next
//			
//			If li_count > 1 Then
//				li_rtn = -1
//				MessageBox("Error. Multiple defect code", "Defect code " + String(li_defect_code) + " occurs more than once.~n~rPlease correct.", StopSign!)
//				Exit
//			End If
//		Next
//	End If
	
	If li_rtn = 1 Then //OK above
		li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Update()
		
		If li_rtn = 1 Then //OK
			commit using sqlca;
			wf_retrieve_qa_customer_quality_skid(ll_sheet_skid_num)
			MessageBox("Success", "QA update successful for skid " + String(ll_sheet_skid_num))
		Else	//Error
			rollback using sqlca;
			//MessageBox() is in dberror event for tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid
		End If
	End If
Else
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Update()
		
	If li_rtn = 1 Then //OK
		commit using sqlca;
		wf_retrieve_qa_customer_quality_skid(ll_sheet_skid_num)
		MessageBox("Success", "QA update successful for skid " + String(ll_sheet_skid_num))
	Else	//Error
		rollback using sqlca;
		//MessageBox() is in dberror event for tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid
	End If
End If

Return li_rtn
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public subroutine wf_insert_qa_customer_quality_skid ();//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_insert_qa_customer_quality_skid
Returns:		none
Arguments:	none
*/

DataWindowChild 	ldwc
Integer				li_row_inserted, li_rtn, li_rows, li_defect_code, li_null, li_disp_code
Long					ll_row_inserted
String				ls_filter_string, ls_null, ls_disp_code

li_row_inserted = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.InsertRow(0)

SetNull(li_null)
SetNull(ls_null)

If li_row_inserted > 0 Then
	//Filter cust_disp_code for il_customer_id
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetChild("cust_disp_code", ldwc)

	If li_rtn = 1 Then
		ls_filter_string = "customer_id = " + String(il_customer_id)
		li_rtn = ldwc.SetFilter(ls_filter_string)
		li_rtn = ldwc.Filter()
	End If
	
	//Populate columns
	//tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.customer_id[li_row_inserted] = il_customer_id
	
	//ll_sheet_skid_num = tab_skids.tabpage_qa_skid.dw_skids_4job.Object.sheet_skid_num[1]
	//tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.sheet_skid_num[li_row_inserted] = al_sheet_skid_num
	
	//---
	
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetChild("cust_disp_code", ldwc)

	If li_rtn = 1 Then
		li_disp_code = ldwc.GetItemNumber(1, "disp_code")
		
		If Not IsNull(li_disp_code) Then
			ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
			
			If ll_row_inserted > 0 Then
				ldwc.SetItem(ll_row_inserted, "customer_id", il_customer_id)
				ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
				ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
			End If
		End If
	End If
	
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetChild("albl_disp_code", ldwc)

	If li_rtn = 1 Then
		ls_disp_code = ldwc.GetItemString(1, "disp_code")
		
		If Not IsNull(li_disp_code) Then
			ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
			
			If ll_row_inserted > 0 Then
				ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
				ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
			End If
		End If
	End If
	
	//---
	
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end subroutine

public subroutine wf_retrieve_coils_4job (long al_ab_job_num);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_retrieve_coils_4job
Returns:		none
Arguments:	value	long al_ab_job_num
*/
DataWindowChild 	ldwc
Integer				li_rtn
Long					ll_rows

tab_skids.tabpage_qa_skid.dw_coils_4job.SetTransObject(sqlca)
ll_rows = tab_skids.tabpage_qa_skid.dw_coils_4job.Retrieve(al_ab_job_num)
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End

end subroutine

public function integer wf_save_qa_customer_quality_many_skids (long al_customer_id, long al_ab_job_num, long al_coil_abc_num, long al_skids[], str_all_data_types astr_all_data_types[]);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_save_qa_customer_quality_many_skids
Returns:		none
Arguments:	value	long						al_customer_id
				value	long						al_ab_job_num
				value	long						al_coil_abc_num
				value	long						al_skids[]		<== sheet_skid_num to save information for
				value	str_all_data_types	astr_all_data_types[]	<== One or more defects to save for each skid in al_sheet_skid_num[]
*/

Long						ll_customer_id, ll_sheet_skid_num, ll_rows
Integer					li_defect_code, li_albl_disp_code, li_cust_disp_code, li_number_of_skids, li_i
Integer					li_row_inserted, li_rtn, li_j, li_number_of_defects
DateTime					ldt_qa_record_date
String					ls_note, ls_user_id, ls_skid_string
DataStore				lds_qa_customer_quality_skid

lds_qa_customer_quality_skid = Create DataStore
lds_qa_customer_quality_skid.DataObject = "d_qa_customer_quality_skid_2"
lds_qa_customer_quality_skid.SetTransObject(sqlca)

ldt_qa_record_date = DateTime(Today(), Now())
li_number_of_skids = UpperBound(al_skids[])

For li_i = 1 To li_number_of_skids
	ll_sheet_skid_num = al_skids[][li_i]
	ls_skid_string = ls_skid_string + String(ll_sheet_skid_num) + ", "
	li_number_of_defects = UpperBound(astr_all_data_types[])
	
	For li_j = 1 To li_number_of_defects
		li_defect_code = astr_all_data_types[li_j].integer_var[1]
		li_albl_disp_code = astr_all_data_types[li_j].integer_var[2]
		li_cust_disp_code = astr_all_data_types[li_j].integer_var[3]
		ls_note = astr_all_data_types[li_j].string_var[1]
		ls_user_id = astr_all_data_types[li_j].string_var[2]
		
		ll_rows = lds_qa_customer_quality_skid.Retrieve(al_customer_id, ll_sheet_skid_num, li_defect_code)
		
		li_rtn = 1 //Initialize before Case
		
		Choose Case ll_rows
			Case 0 //Row does not exist
				li_row_inserted = lds_qa_customer_quality_skid.InsertRow(0)
				
				If li_row_inserted > 0 Then
					lds_qa_customer_quality_skid.Object.customer_id[li_row_inserted] = al_customer_id
					lds_qa_customer_quality_skid.Object.ab_job_num[li_row_inserted] = al_ab_job_num
					lds_qa_customer_quality_skid.Object.coil_abc_num[li_row_inserted] = al_coil_abc_num
					lds_qa_customer_quality_skid.Object.sheet_skid_num[li_row_inserted] = ll_sheet_skid_num
					lds_qa_customer_quality_skid.Object.defect_code[li_row_inserted] = li_defect_code
					lds_qa_customer_quality_skid.Object.albl_disp_code[li_row_inserted] = li_albl_disp_code
					lds_qa_customer_quality_skid.Object.cust_disp_code[li_row_inserted] = li_cust_disp_code
					lds_qa_customer_quality_skid.Object.qa_record_date[li_row_inserted] = ldt_qa_record_date
					lds_qa_customer_quality_skid.Object.note[li_row_inserted] = ls_note
					lds_qa_customer_quality_skid.Object.user_id[li_row_inserted] = ls_user_id
				End If
			Case 1 //Row exists for key columns ll_customer_id, ll_sheet_skid_num, li_defect_code
				lds_qa_customer_quality_skid.Object.albl_disp_code[1] = li_albl_disp_code
				lds_qa_customer_quality_skid.Object.cust_disp_code[1] = li_cust_disp_code
				lds_qa_customer_quality_skid.Object.qa_record_date[1] = ldt_qa_record_date
				lds_qa_customer_quality_skid.Object.note[1] = ls_note
				lds_qa_customer_quality_skid.Object.user_id[1] = ls_user_id
			Case Else //DB error
				li_rtn = -1
		End Choose
		
		If li_rtn = 1 Then //OK
			li_rtn = lds_qa_customer_quality_skid.Update()
					
			//If li_rtn = 1 Then //OK
			//	commit using sqlca;
			//Else
			//	rollback using sqlca;
			//End If
		End If
	Next
Next //For li_i = 1 To li_number_of_skids

//Remove the last comma
ls_skid_string = Left(ls_skid_string, Len(ls_skid_string) - 2)

If li_rtn = 1 Then //OK
	commit using sqlca;
	MessageBox("Success", "QA update successful for skids " + ls_skid_string)
Else	//Error
	rollback using sqlca;
	MessageBox("Failure", "QA update failed for skids " + ls_skid_string)
End If

Return li_rtn
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public function integer wf_attach_report_2email (string as_coil_org_num);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_attach_report_2email
Returns:		integer
Arguments:	value	string	as_coil_org_num
*/

Long			ll_selected_row, ll_sheet_skid_num, ll_rows, ll_coil_abc_num, ll_ab_job_num
Integer		li_rtn, li_row_inserted, li_found_row, li_answer, li_selected_row
String		ls_date_time, ls_file, ls_modstring, ls_rtn, ls_find_strig, ls_customer_short_name, ls_coil_org_num, ls_skid_string
String		ls_coil_string
Boolean		lb_directoryexists
DataStore	lds_report

//Check if C:\temp exists.
lb_directoryexists = DirectoryExists("C:\temp")

If Not lb_directoryexists Then //Folder C:\temp doesn't exist
	CreateDirectory("C:\temp") //Create ls_folder
End If

ls_date_time = String(DateTime(Today(), Now()), "mmddyyyy_hhmmss")
//ls_file = "C:\TEMP\QA_Defects_Report-" + ls_date_time + ".pdf"

If as_coil_org_num = "" Then
	ls_file = "C:\TEMP\QA_Defects_Report.pdf"
Else
	ls_file = "C:\TEMP\QA_Defects_Report_Cust_Coil_" + as_coil_org_num + ".pdf"
End If

lds_report = Create DataStore
lds_report.DataObject = "d_qa_skid_report_excel"

ll_rows = tab_skids.tabpage_qa_skid.dw_report_attached.RowCount()

If ll_rows > 0 Then
	li_rtn = tab_skids.tabpage_qa_skid.dw_report_attached.RowsCopy(1, ll_rows,  Primary!, lds_report, 1, Primary!)
	
	If li_rtn = 1 Then //OK above
		ls_customer_short_name = lds_report.Object.customer[1]
		ll_ab_job_num = lds_report.Object.ab_job_num[1]
		
		//---
		
		//Get coil string
		li_selected_row = tab_skids.tabpage_qa_skid.dw_coils_4job.GetSelectedRow(0)
		
		If li_selected_row <= 0 Then
			ls_modstring = "coil_or_lot_head_t.Text = '" + "All coils" + "'"
		Else
			Do While li_selected_row > 0
				ls_coil_org_num = tab_skids.tabpage_qa_skid.dw_coils_4job.Object.coil_org_num[li_selected_row]
				ls_coil_string = ls_coil_string + ls_coil_org_num + ","
				li_selected_row = tab_skids.tabpage_qa_skid.dw_coils_4job.GetSelectedRow(li_selected_row) //Start after ll_selected_row
			Loop
			
			//Remove the last comma
			ls_coil_string = Left(ls_coil_string, Len(ls_coil_string) - 1)
			ls_modstring = "coil_or_lot_head_t.Text = 'Coils: " + ls_coil_string + "'"
		End If
		
		ls_rtn = lds_report.Modify(ls_modstring)
			
		//---
		
		//Get skid string
		li_selected_row = tab_skids.tabpage_qa_skid.dw_skids_4job.GetSelectedRow(0)
		
		If li_selected_row <= 0 Then
			ls_modstring = "sheet_skid_num_head_t.Text = '" + "All skids for coil" + "'"
		Else
			Do While li_selected_row > 0
				ll_sheet_skid_num = tab_skids.tabpage_qa_skid.dw_skids_4job.Object.sheet_skid_num[li_selected_row]
				ls_skid_string = ls_skid_string + String(ll_sheet_skid_num) + ","
				li_selected_row = tab_skids.tabpage_qa_skid.dw_skids_4job.GetSelectedRow(li_selected_row) //Start after ll_selected_row
			Loop
			
			//Remove the last comma
			ls_skid_string = Left(ls_skid_string, Len(ls_skid_string) - 1)
			ls_modstring = "sheet_skid_num_head_t.Text = 'Skids: " + ls_skid_string + "'"
		End If
		
		ls_rtn = lds_report.Modify(ls_modstring)
		
		//---
		
		ls_modstring = "qa_customer_head_t.Text = 'Customer: " + ls_customer_short_name + "'"
		ls_rtn = lds_report.Modify(ls_modstring)
		
		ls_modstring = "ab_job_num_head_t.Text = 'Job: " + String(ll_ab_job_num) + "'"
		ls_rtn = lds_report.Modify(ls_modstring)
		
		//ls_modstring = "coil_or_lot_head_t.Text = 'Customer Coil: " + ls_coil_org_num + "'"
		//ls_rtn = lds_report.Modify(ls_modstring)
		
		//If len(ls_skid_string) > 0 Then
		//	ls_modstring = "sheet_skid_num_head_t.Text = 'Skids: " + ls_skid_string + "'"
		//Else
		//	ls_modstring = "sheet_skid_num_head_t.Text = '" + "All skids for coil" + "'"
		//End If
		//ls_rtn = lds_report.Modify(ls_modstring)
	
		//f_update_data_export(lds_report)
		//li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
		
		//MessageBox("wf_attach_report_2email", "After saving datastore~n~rls_file = " + ls_file + "~n~rll_rows = " + String(ll_rows) + "~n~rli_rtn = " + String(li_rtn))
		
		ls_find_strig = "attached_file_name = '" + ls_file + "'"
		li_found_row = tab_skids.tabpage_qa_skid.dw_attached_file_name.Find(ls_find_strig, 1, tab_skids.tabpage_qa_skid.dw_attached_file_name.RowCount())
		
		If li_found_row <= 0 Then //Report not attached
			li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
			
			If li_row_inserted > 0 Then
				tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
				f_update_data_export(lds_report)
				li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
			End If
		Else //Report already attached
			li_answer = MessageBox("Report already attached", "Report: " + ls_file + " is already attached." + &
											"~n~rWould you like to replace this report with a new version?", Question!, YesNo!, 2)
			
			If li_answer = 1 Then //Yes
				f_update_data_export(lds_report)
				li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
		
				//li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
				//
				//If li_row_inserted > 0 Then
				//	tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
				//End If
			End If
		End If
	End If
End If

Return li_rtn
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public function integer wf_retrieve_skids_4job_coil (long al_ab_job_num, boolean ab_initial_retrieve);//Alex_Gerlants. 1260_Incoming_Customer_Quality2. Begin
/*
Function:	wf_retrieve_skids_4job_coil
Returns:		long	<== Number of skids
Arguments:	value	boolean 	ab_initial_retrieve	<== True if this function is called from window Open event
																	 False otherwise
*/

Integer	li_rtn, li_i, li_selected_row
Long		ll_selected_row, ll_sheet_skid_num, ll_rows, ll_coil_abc_num, ll_ab_job_num, ll_coil_abc_num_arr[]
Long		ll_pos
String	ls_skid_string, ls_sql_orig, ls_sql_add_1, ls_sql_add_2, ls_sql_new, ls_coil_org_num, ls_coil_abc_num_string
String	ls_left_part, ls_right_part

ls_sql_orig = tab_skids.tabpage_qa_skid.dw_skids_4job.GetSqlSelect()
ll_ab_job_num = al_ab_job_num

If ab_initial_retrieve Then
	ls_sql_add_1 = " where production_sheet_item.ab_job_num = " + String(ll_ab_job_num)
	ls_sql_add_2 = " where scraped_sheet_skid.ab_job_num = " + String(ll_ab_job_num)
Else
	li_selected_row = tab_skids.tabpage_qa_skid.dw_coils_4job.GetSelectedRow(0)
	
	If li_selected_row > 0 Then
		Do While li_selected_row > 0
			ll_coil_abc_num = tab_skids.tabpage_qa_skid.dw_coils_4job.Object.coil_abc_num[li_selected_row]
			ll_coil_abc_num_arr[UpperBound(ll_coil_abc_num_arr[]) + 1] = ll_coil_abc_num
			li_selected_row = tab_skids.tabpage_qa_skid.dw_coils_4job.GetSelectedRow(li_selected_row) //Start after li_selected_row
		Loop
	End If
	
	
	If UpperBound(ll_coil_abc_num_arr[]) = 0 Then //There are no selected coils
		//Select all skids for al_ab_job_num
		ls_sql_add_1 = " where production_sheet_item.ab_job_num = " + String(ll_ab_job_num)
		ls_sql_add_2 = " where scraped_sheet_skid.ab_job_num = " + String(ll_ab_job_num)
	Else //One or more coils selected
		For li_i = 1 To UpperBound(ll_coil_abc_num_arr[])
			ll_coil_abc_num = ll_coil_abc_num_arr[li_i]
			ls_coil_abc_num_string = ls_coil_abc_num_string + String(ll_coil_abc_num) + ","
		Next
		
		//Remove the last comma
		ls_coil_abc_num_string = Left(ls_coil_abc_num_string, Len(ls_coil_abc_num_string) - 1)
		
		//Select skids for al_ab_job_num and al_coil_abc_num
		ls_sql_add_1 = " where production_sheet_item.ab_job_num = " + String(ll_ab_job_num) + " and production_sheet_item.coil_abc_num in (" + ls_coil_abc_num_string + ")"
		ls_sql_add_2 = " where scraped_sheet_skid.ab_job_num = " + String(ll_ab_job_num) + " and coil.coil_abc_num in (" + ls_coil_abc_num_string + ")"
	End If
End If

//---

ll_pos = Pos(ls_sql_orig, "union all", 1)

If ll_pos > 0 Then
	ls_left_part = Left(ls_sql_orig, ll_pos - 1)
	ls_right_part = Right(ls_sql_orig, Len(ls_sql_orig) - ll_pos + 1)
Else
	//
End If

ls_left_part =  ls_left_part + ls_sql_add_1
ls_right_part = ls_right_part + ls_sql_add_2 + " order by 1"
ls_sql_new = ls_left_part+ " " + ls_right_part

//---

//ls_sql_add_1 = ls_sql_add_1 + " order by 1"
//ls_sql_add_2 = ls_sql_add_2 + " order by 1"

//ls_sql_new = ls_sql_orig + ls_sql_add_1
tab_skids.tabpage_qa_skid.dw_skids_4job.SetSqlSelect(ls_sql_new)
tab_skids.tabpage_qa_skid.dw_skids_4job.SetTransObject(sqlca)
ll_rows = tab_skids.tabpage_qa_skid.dw_skids_4job.Retrieve()

//MessageBox("wf_retrieve_skids_4job_coil", "ll_rows = " + String(ll_rows))

//Restore original SQL
tab_skids.tabpage_qa_skid.dw_skids_4job.SetSqlSelect(ls_sql_orig)

Return ll_rows
//Alex_Gerlants. 1260_Incoming_Customer_Quality2. End
end function

public subroutine wf_add_remove_selected_row (long al_selected_row, string as_add_delete);//Alex Gerlants. 12/30/2020. 1070_Scrap_Screen_Group_Edit. Begin
/*
Function:	wf_add_remove_selected_row
Returns:		none
Arguments:	value			long			al_selected_row
				value			sring			as_add_delete
*/
Long		ll_inserted_row, ll_found_row
String	ls_find_string, ls_sort_string

ls_find_string = "number = " + String(al_selected_row)
ll_found_row = dw_selected_rows.Find(ls_find_string, 1, dw_selected_rows.RowCount())

If as_add_delete = "add" Then
	If ll_found_row <= 0 Then
		ll_inserted_row = dw_selected_rows.InsertRow(0)
		
		If ll_inserted_row > 0 Then
			dw_selected_rows.Object.number[ll_inserted_row] = al_selected_row
		End If
	End If
Else //as_add_delete = "delete"
	If ll_found_row > 0 Then
		dw_selected_rows.DeleteRow(ll_found_row)
	End If
End If

If dw_selected_rows.RowCount() > 0 Then
	ls_sort_string = "number"
	dw_selected_rows.SetSort(ls_sort_string)
	dw_selected_rows.Sort()
End If
//Alex Gerlants. 12/30/2020. 1070_Scrap_Screen_Group_Edit. End
end subroutine

public function integer wf_save_group_edit ();//Alex Gerlants. 03/22/2022. 1462_Office_Skid_Entry_Group_Edit. Begin
/*
Function:	wf_save_group_edit
Return:		integer
Arguments:	none
*/

Integer	li_rtn = 1
Integer	li_skid_sheet_status
Long		ll_rows, ll_row, ll_row_2update, ll_sheet_skid_num

ll_rows = dw_selected_rows.RowCount()

For ll_row = 1 To ll_rows
	ll_row_2update = dw_selected_rows.Object.number[ll_row]
	ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row_2update]
	li_skid_sheet_status = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_skid_sheet_status[ll_row_2update]
	
	update	sheet_skid
	set		skid_sheet_status = :li_skid_sheet_status
	where		sheet_skid_num = :ll_sheet_skid_num
	using		sqlca;
	
	If sqlca.sqlcode <> 0 Then //DB error
		li_rtn = -1
	
		MessageBox("Database error", 	"Database error in wf_save_group_edit for w_office_skid_entry while updating table sheet_skid for skid " + String(li_skid_sheet_status) + &
												"~n~rError:~n~r" + sqlca.SqlErrText + &
												"~n~r~n~rPlease contact abis support.")
												
		Exit
	End If
Next

If sqlca.sqlcode = 0 Then //OK in loop above
	commit using sqlca;
Else //DB error above
	rollback using sqlca;
End If

tab_skids.tabpage_sheet.dw_skid_list.ResetUpdate()
dw_selected_rows.Reset() //Clear selected rows list
tab_skids.tabpage_sheet.dw_skid_list.SelectRow(0, False) //Unselect all rows
tab_skids.tabpage_sheet.cb_group_edit.Enabled = False
wf_set_action(0)

Return li_rtn
//Alex Gerlants. 03/22/2022. 1462_Office_Skid_Entry_Group_Edit. End
end function

public function integer wf_check_tare_wt ();//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Begin
/*
Function:	wf_check_tare_wt
Returns:		integer	<==  1 if sheet_skid_sheet_tare_wt populated on tab_skids.tabpage_sheet.dw_skid_editor
								 -1 if sheet_skid_sheet_tare_wt < 0
Aguments:	none
*/

Integer	li_rtn = 1, li_row
Long 		ll_tare_wt

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()
li_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()

ll_tare_wt = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_sheet_tare_wt[li_row]

If IsNull(ll_tare_wt) Then ll_tare_wt = 0

If ll_tare_wt < 0 Then
	li_rtn = -1
	MessageBox("Tare weight invalid", "Tare weight less than zero", StopSign!)
End If

Return li_rtn
//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. End
end function

public function integer wf_check_onhold_reason ();//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Begin
/*
Function:	wf_check_onhold_reason
Returns:		integer	<==  1 if sheet_skid_sheet_tare_wt populated on tab_skids.tabpage_sheet.dw_skid_editor
								 -1 if sheet_skid_sheet_tare_wt NOT populated on tab_skids.tabpage_sheet.dw_skid_editor
Aguments:	none
*/

Integer	li_rtn = 1, li_row, li_onhold_reason_code, li_sheet_skid_skid_sheet_status
Long 		ll_tare_wt

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()
li_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()

If li_row > 0 Then
	li_sheet_skid_skid_sheet_status = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_skid_sheet_status[li_row]
	li_onhold_reason_code = tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code[li_row]
	
	If IsNull(li_onhold_reason_code) Then li_onhold_reason_code = 0
	
	If (li_sheet_skid_skid_sheet_status = 4 Or li_sheet_skid_skid_sheet_status = 10) And li_onhold_reason_code <= 0 Then //Skid is on-hold, but there is no reason code
		li_rtn = -1
		MessageBox("On-Hold reason missing", "Please select On-Hold reason", StopSign!)
	End If
End If

Return li_rtn
//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. End
end function

public function integer wf_insert_skid_onhold_reason_track (boolean ab_new_skid);//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Begin
/*
Function:	wf_insert_skid_onhold_reason_track
Returns:		integer  1 if OK
                    -1 if DB error
Arguments:	value	boolean	ab_new_skid				
*/

Integer					li_rtn = 1 //Initialize to OK
Integer					li_skid_sheet_status_orig, li_skid_sheet_status_new, li_onhold_reason_code_orig, li_onhold_reason_code_new
Integer					li_row_list_selected, li_row_editor
Long						ll_sheet_skid_num
String					ls_user_name
DateTime					ldt_current_date
str_all_data_types	lstr_all_data_types

ls_user_name = gnv_app.of_GetUserId()
tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()
ldt_current_date = DateTime(Today(), Now())

If ab_new_skid Then
	SetNull(li_skid_sheet_status_orig)
	li_onhold_reason_code_orig = -99 //It will be converted to NULL in f_insert_skid_onhold_reason_track()
	
	li_row_editor = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
		
	If li_row_editor > 0 Then
		ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_sheet_skid_num[li_row_editor]
		li_skid_sheet_status_new = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_skid_sheet_status[li_row_editor]
		li_onhold_reason_code_new = tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code[li_row_editor]
		
		If li_onhold_reason_code_orig <> li_onhold_reason_code_new Then
			lstr_all_data_types.long_var[1] = ll_sheet_skid_num
			lstr_all_data_types.datetime_var[1] = ldt_current_date
			lstr_all_data_types.integer_var[1] = li_skid_sheet_status_orig
			lstr_all_data_types.integer_var[2] = li_skid_sheet_status_new
			lstr_all_data_types.integer_var[3] = li_onhold_reason_code_orig
			lstr_all_data_types.integer_var[4] = li_onhold_reason_code_new
			lstr_all_data_types.string_var[1] = ls_user_name
			lstr_all_data_types.string_var[2] = "Y"
			
			li_rtn = f_insert_skid_onhold_reason_track(lstr_all_data_types, sqlca)
		End If
	End If
Else //Modified skid
	li_row_list_selected = tab_skids.tabpage_sheet.dw_skid_list.GetSelectedRow(0)
	
	If li_row_list_selected > 0 Then
		li_skid_sheet_status_orig = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_skid_sheet_status[li_row_list_selected]
		li_onhold_reason_code_orig = tab_skids.tabpage_sheet.dw_skid_list.Object.onhold_reason_code[li_row_list_selected]
		
		If IsNull(li_onhold_reason_code_orig) Then li_onhold_reason_code_orig = -99 //It will be converted to NULL in f_insert_skid_onhold_reason_track()
		
		li_row_editor = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
		
		If li_row_editor > 0 Then
			ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_sheet_skid_num[li_row_editor]
			li_skid_sheet_status_new = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_skid_sheet_status[li_row_editor]
			li_onhold_reason_code_new = tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code[li_row_editor]
			If IsNull(li_onhold_reason_code_new) Then li_onhold_reason_code_new = -99 //It will be converted to NULL in f_insert_skid_onhold_reason_track()
			
			If li_onhold_reason_code_orig <> li_onhold_reason_code_new Then
				lstr_all_data_types.long_var[1] = ll_sheet_skid_num
				lstr_all_data_types.datetime_var[1] = ldt_current_date
				lstr_all_data_types.integer_var[1] = li_skid_sheet_status_orig
				lstr_all_data_types.integer_var[2] = li_skid_sheet_status_new
				lstr_all_data_types.integer_var[3] = li_onhold_reason_code_orig
				lstr_all_data_types.integer_var[4] = li_onhold_reason_code_new
				lstr_all_data_types.string_var[1] = ls_user_name
				lstr_all_data_types.string_var[2] = "N"
				
				If Not IsNull(ll_sheet_skid_num) And Not IsNull(ldt_current_date) Then
					li_rtn = f_insert_skid_onhold_reason_track(lstr_all_data_types, sqlca)
				Else
					MessageBox("", "")
				End If
			End If
		End If
	End If
End If

			

Return li_rtn
//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. End
end function

public function integer wf_attach_summary_2email (long al_ab_job_num);//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
/*
Function:	wf_attach_summary_2email
Returns:		integer
Arguments:	value	long	al_ab_job_num
*/

Long							ll_selected_row, ll_sheet_skid_num, ll_rows, ll_coil_abc_num, ll_ab_job_num
Long 							ll_net, ll_tare, ll_coil_wt, ll_item_wt
Integer						li_rtn, li_row_inserted, li_found_row, li_answer, li_selected_row
String						ls_date_time, ls_file, ls_modstring, ls_rtn, ls_find_strig, ls_customer_short_name, ls_coil_org_num, ls_skid_string
String						ls_customer, ls_spec
Boolean						lb_directoryexists, lb_rtn
DataStore					lds_report
str_all_data_types		lstr_all_data_types
w_qa_summary_selection	lw_qa_summary_selection
String						ls_files_2delete[]

Open(lw_qa_summary_selection)

lstr_all_data_types = Message.PowerObjectParm

If lstr_all_data_types.integer_var[1] = -99 Then //User clicked on Cancel on w_qa_summary_selection
	Return 1
End If

ls_customer = wf_cust_prod_info_customer(al_ab_job_num)
ls_spec = wf_cust_prod_info_spec(al_ab_job_num)

//Check if C:\temp exists.
lb_directoryexists = DirectoryExists("C:\temp")

If Not lb_directoryexists Then //Folder C:\temp doesn't exist
	CreateDirectory("C:\temp") //Create ls_folder
End If

If lstr_all_data_types.integer_var[1] = 1 Then
	//ls_date_time = String(DateTime(Today(), Now()), "mmddyyyy_hhmmss")
	ls_file = "C:\TEMP\Prod_Summary_Report_Job" + String(al_ab_job_num) + ".pdf"
	
	lds_report = Create DataStore
	lds_report.DataObject = "d_report_prod_order_summary"
	lds_report.SetTransObject(sqlca)
	ll_rows = lds_report.Retrieve(al_ab_job_num)
	
	If ll_rows > 0 Then
		//ls_customer = wf_cust_prod_info_customer(al_ab_job_num)
		//ls_spec = wf_cust_prod_info_spec(al_ab_job_num)
		
		ls_modstring = "customer_t.Text = ~"" + ls_customer + "~""
		lds_report.Modify(ls_modstring) 
		
		ls_modstring = "material_t.Text = ~"" + ls_spec + "~""
		lds_report.Modify(ls_modstring)
		
		wf_set_display_values(al_ab_job_num, lds_report)
		
		ls_find_strig = "attached_file_name = '" + ls_file + "'"
		li_found_row = tab_skids.tabpage_qa_skid.dw_attached_file_name.Find(ls_find_strig, 1, tab_skids.tabpage_qa_skid.dw_attached_file_name.RowCount())
		
		If li_found_row <= 0 Then //Report not attached
			li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
			
			If li_row_inserted > 0 Then
				tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
				f_update_data_export(lds_report)
				li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
			End If
		Else //Report already attached
			li_answer = MessageBox("Report already attached", "Report: " + ls_file + " is already attached." + &
											"~n~rWould you like to replace this report with a new version?", Question!, YesNo!, 2)
			
			If li_answer = 1 Then //Yes
				li_rtn = tab_skids.tabpage_qa_skid.dw_attached_file_name.DeleteRow(li_found_row)
				//lb_rtn = FileDelete(ls_file)
				ls_files_2delete[UpperBound(ls_files_2delete[]) + 1] = ls_file
				wf_email_files_cleanup(ls_files_2delete[])
				
				li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
				
				If li_row_inserted > 0 Then
					tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
					f_update_data_export(lds_report)
					li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
				End If
			End If
		End If
	End If
End If

//---

If lstr_all_data_types.integer_var[2] = 1 Then
	ls_file = "C:\TEMP\Skid_Summary_Report_Job" + String(al_ab_job_num) + ".pdf"
	
	lds_report = Create DataStore
	lds_report.DataObject = "d_report_shopfloor_skid"
	lds_report.SetTransObject(sqlca)
	ll_rows = lds_report.Retrieve(al_ab_job_num)
	
	If ll_rows > 0 Then
		//ls_customer = wf_cust_prod_info_customer(al_ab_job_num)
		//ls_spec = wf_cust_prod_info_spec(al_ab_job_num)
		
		ls_modstring = "customer_t.Text = ~"" + ls_customer + "~""
		lds_report.Modify(ls_modstring) 
		
		ls_modstring = "material_t.Text = ~"" + ls_spec + "~""
		lds_report.Modify(ls_modstring)
		
		connect using sqlca;
	  
		select	sum(sheet_net_wt), sum(sheet_tare_wt) 
		into 		:ll_net, :ll_tare
		from 		sheet_skid
		where 	ab_job_num = :al_ab_job_num
		using 	sqlca;
			
		ls_modstring = "gross_t.Text = ~"" + String((ll_net + ll_tare), "###,###,###") + "~""
		lds_report.Modify(ls_modstring)
		
		wf_syn_skid_wt(lds_report)
		
		ls_find_strig = "attached_file_name = '" + ls_file + "'"
		li_found_row = tab_skids.tabpage_qa_skid.dw_attached_file_name.Find(ls_find_strig, 1, tab_skids.tabpage_qa_skid.dw_attached_file_name.RowCount())
		
		If li_found_row <= 0 Then //Report not attached
			li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
			
			If li_row_inserted > 0 Then
				tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
				f_update_data_export(lds_report)
				li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
			End If
		Else //Report already attached
			li_answer = MessageBox("Report already attached", "Report: " + ls_file + " is already attached." + &
											"~n~rWould you like to replace this report with a new version?", Question!, YesNo!, 2)
			
			If li_answer = 1 Then //Yes
				li_rtn = tab_skids.tabpage_qa_skid.dw_attached_file_name.DeleteRow(li_found_row)
				//lb_rtn = FileDelete(ls_file)
				ls_files_2delete[UpperBound(ls_files_2delete[]) + 1] = ls_file
				wf_email_files_cleanup(ls_files_2delete[])
				
				li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
				
				If li_row_inserted > 0 Then
					tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
					f_update_data_export(lds_report)
					li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
				End If
			End If
		End If
	End If
End If

//---

If lstr_all_data_types.integer_var[3] = 1 Then
	ls_file = "C:\TEMP\Skid_Coil_Summary_Report_Job" + String(al_ab_job_num) + ".pdf"
	
	lds_report = Create DataStore
	lds_report.DataObject = "d_report_shopfloor_skid_coil"
	lds_report.SetTransObject(sqlca)
	ll_rows = lds_report.Retrieve(al_ab_job_num)
	
	If ll_rows > 0 Then
		//ls_customer = wf_cust_prod_info_customer(al_ab_job_num)
		//ls_spec = wf_cust_prod_info_spec(al_ab_job_num)
		
		ls_modstring = "customer_t.Text = ~"" + ls_customer + "~""
		lds_report.Modify(ls_modstring) 
		
		ls_modstring = "material_t.Text = ~"" + ls_spec + "~""
		lds_report.Modify(ls_modstring)
		
		connect using sqlca;
		
		select	sum(process_quantity) 
		into 		:ll_coil_wt
		from 		process_coil
		where 	ab_job_num = :al_ab_job_num
		using 	sqlca;
		 
		ls_modstring = "coil_t.Text = ~"" + String(ll_coil_wt, "#########") + "~""
		lds_report.modify(ls_modstring) 
		
		connect using sqlca;
		
		select	sum(prod_item_net_wt) into :ll_item_wt
		from 		production_sheet_item
		where 	ab_job_num = :al_ab_job_num
		using 	sqlca;
		
		ls_modstring = "scrap_t.Text = ~"" + String((ll_coil_wt - ll_item_wt), "#########") + "~""
		lds_report.Modify(ls_modstring)
		
		ls_find_strig = "attached_file_name = '" + ls_file + "'"
		li_found_row = tab_skids.tabpage_qa_skid.dw_attached_file_name.Find(ls_find_strig, 1, tab_skids.tabpage_qa_skid.dw_attached_file_name.RowCount())
		
		If li_found_row <= 0 Then //Report not attached
			li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
			
			If li_row_inserted > 0 Then
				tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
				f_update_data_export(lds_report)
				li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
			End If
		Else //Report already attached
			li_answer = MessageBox("Report already attached", "Report: " + ls_file + " is already attached." + &
											"~n~rWould you like to replace this report with a new version?", Question!, YesNo!, 2)
			
			If li_answer = 1 Then //Yes
				li_rtn = tab_skids.tabpage_qa_skid.dw_attached_file_name.DeleteRow(li_found_row)
				//lb_rtn = FileDelete(ls_file)
				ls_files_2delete[UpperBound(ls_files_2delete[]) + 1] = ls_file
				wf_email_files_cleanup(ls_files_2delete[])
				
				li_row_inserted = tab_skids.tabpage_qa_skid.dw_attached_file_name.InsertRow(0)
				
				If li_row_inserted > 0 Then
					tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row_inserted] = ls_file
					f_update_data_export(lds_report)
					li_rtn = lds_report.SaveAs(ls_file, PDF!, True)
				End If
			End If
		End If
	End If
End If

tab_skids.tabpage_qa_skid.dw_attached_file_name.ResetUpdate()

Return li_rtn
//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. End
end function

public function string wf_cust_prod_info_customer (long al_job);//1797_Skid_Summary_Recap_Report. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
/*
Function:	wf_cust_prod_info_customer
Return:		string
Arguments:	value	long	al_job
*/

SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#, ls_po, ls_finished_goods

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
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
	ls_cust = ls_cust + " ( " + Trim(ls_enduser) + " )"
END IF
ls_cust = ls_cust + "          Cust.P.O.# " + ls_po

Return Upper(ls_cust)
//1797_Skid_Summary_Recap_Report. 01/30/2023. 1797_Skid_Summary_Recap_Report. End
end function

public function string wf_cust_prod_info_spec (long al_job);//1797_Skid_Summary_Recap_Report. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
/*
Function:	wf_cust_prod_info_spec
Return:		any	lstr_all_data_types
Arguments:	value	long	al_job
*/

SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#, ls_po, ls_finished_goods

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

//SELECT orig_customer_id, enduser_id, orig_customer_po INTO :ll_cust, :ll_enduser, :ls_po
//FROM customer_order
//WHERE order_abc_num = :ll_order
//USING SQLCA;
//SELECT customer_short_name INTO :ls_cust
//FROM customer
//WHERE customer_id = :ll_cust
//USING SQLCA;
//IF ll_enduser > 0 THEN
//	SELECT customer_short_name INTO :ls_enduser
//	FROM customer
//	WHERE customer_id = :ll_enduser
//	USING SQLCA;
//	ls_cust = ls_cust + " ( " + Trim(ls_enduser) + " )"
//END IF
//ls_cust = ls_cust + "          Cust.P.O.# " + ls_po
////sle_1.Text = Upper(ls_cust)
//lstr_all_data_types.string_var[1] = Upper(ls_cust)

//---------------------------------------------------------------------------------------------------------------------

SELECT sheet_type, alloy2, temper, order_item_desc, gauge, enduser_part_num, finished_goods_material_num 
INTO :ls_shape, :ls_alloy, :ls_temper, :ls_desc, :lr_gauge, :ls_part#, :ls_finished_goods
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;
IF isNULL(ls_finished_goods) THEN ls_finished_goods = " "

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

	//Alex Gerlants. 10/14/2020. Skid_Recap_Report_Fix. Begin
	Case "LIFTGATE"
		select	li_width, li_length
		into		:lr_w, :lr_l
		from		liftgate_shape
		where		order_abc_num = :ll_order AND order_item_num = :li_item
		using		sqlca;
		
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
		
	Case "REINFORCEMENT"
		select	re_width, re_length
		into		:lr_w, :lr_l
		from		reinforcement
		where		order_abc_num = :ll_order AND order_item_num = :li_item
		using		sqlca;
		
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	//Alex Gerlants. 10/14/2020. Skid_Recap_Report_Fix. End

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
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part# + "    " + ls_finished_goods
//sle_2.Text = ls_spec

Return	ls_spec
//1797_Skid_Summary_Recap_Report. 01/30/2023. 1797_Skid_Summary_Recap_Report. End
end function

public function integer wf_syn_skid_wt (ref datastore ads);//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
/*
Function:   wf_syn_skid_wt
Return:     integer
Arguments:  Reference datastore ads
*/

Long	ll_totalrow, ll_row, ll_i
Long	ll_nwt, ll_inwt
Long	ll_skid, ll_skid_netwt, ll_lastitem, ll_lastitem_netwt

ads.AcceptText()
ll_totalrow = ads.RowCount()
IF ll_totalrow < 1 THEN RETURN 0
FOR ll_row = 1 TO ll_totalrow
  ll_nwt = ads.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt")
  ads.SetItem(ll_row, "citem_net_kg", Int(ll_nwt  * 0.45359 + 0.5 ))
NEXT
ads.AcceptText()

FOR ll_row = 1 TO ll_totalrow
  ll_skid = ads.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
  ll_skid_netwt = ads.GetItemNumber(ll_row, "net_wt_kg", Primary!, FALSE)
  ll_nwt = 0
  ll_lastitem = 0
  FOR ll_i = 1 TO ll_totalrow
    IF ads.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num") = ll_skid THEN
      ll_inwt = ads.GetItemNumber(ll_i, "citem_net_kg", Primary!, FALSE)
      IF ISNULL(ll_inwt) THEN ll_inwt = 0
      ll_nwt = ll_nwt + ll_inwt
      ll_lastitem_netwt = ll_inwt
      ll_lastitem = ll_i
    END IF
  NEXT
  IF ll_nwt <> ll_skid_netwt THEN
    ads.SetItem(ll_lastitem, "citem_net_kg", ll_lastitem_netwt + (ll_skid_netwt - ll_nwt))
  END IF
NEXT 

RETURN 1
//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. End
end function

public subroutine wf_set_display_values (long al_job, ref datastore ads);//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
/*
Function:   wf_set_display_values
Return:     none
Arguments:  value			long			al_job
            Reference	datastore	ads
*/

String		ls_modstring
Long			ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_rejnet, ll_t, ll_l1, ll_l2, ll_rebandedwt, ll_unprocessed_num, ll_unprocessednet
Long			ll_rows, ll_coil_abc_num
DataStore	lds_ab_job_rej_coil_list, lds_ab_job_reband_coil_list

lds_ab_job_rej_coil_list = Create DataStore
lds_ab_job_rej_coil_list.DataObject = "d_ab_job_rej_coil_list"
lds_ab_job_rej_coil_list.SetTransObject(sqlca)
ll_rows = lds_ab_job_rej_coil_list.Retrieve(al_job)

lds_ab_job_reband_coil_list = Create DataStore
lds_ab_job_reband_coil_list.DataObject = "d_ab_job_reband_coil_list"
lds_ab_job_reband_coil_list.SetTransObject(sqlca)
ll_rows = lds_ab_job_reband_coil_list.Retrieve(al_job)

CONNECT USING SQLCA;

SELECT NVL(COUNT(coil_abc_num),0) 
INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;

ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

//Modified by Victor Huang in 04/05
SELECT NVL(COUNT(coil_abc_num),0) 
INTO :ll_unprocessed_num
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2  //for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessed_num
ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) 
INTO :ll_unprocessednet
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2  //for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessednet
ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

ll_l1 = lds_ab_job_rej_coil_list.RowCount()
ll_l2 = lds_ab_job_reband_coil_list.RowCount()
ll_l = ll_l1 + ll_l2

ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		ll_coil_abc_num = lds_ab_job_rej_coil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num")
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(al_job, ll_coil_abc_num)
	NEXT
  
  ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
  lds_ab_job_rej_coil_list.Modify(ls_modstring) 
END IF

ll_rebandedwt = 0

IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		ll_coil_abc_num = lds_ab_job_rej_coil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num")
	 	ll_rebandedwt = ll_rebandedwt + wf_rejected_coil_wt(al_job, ll_coil_abc_num)
	NEXT
  ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rebandedwt, "###,###,###") + "~""
  lds_ab_job_reband_coil_list.Modify(ls_modstring) 
END IF
ll_rejnet = ll_rejnet + ll_rebandedwt
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
ads.Modify(ls_modstring) 


SELECT NVL(COUNT(sheet_skid_num),0) 
INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;

ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

SELECT NVL(COUNT(return_scrap_item_num),0) 
INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;

ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) 
INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;

ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 
ll_coilnet = ll_l

SELECT NVL(SUM(prod_item_net_wt),0) 
INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;

ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 
ll_sheetnet = ll_l

SELECT NVL(SUM(return_item_net_wt),0) 
INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;

ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 
ll_scrapnet = ll_l

SELECT NVL(SUM(prod_item_pieces),0) 
INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;

ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

SELECT SUM(sheet_tare_wt) 
INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;

ll_l = ll_l + ll_sheetnet
ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 

SELECT NVL(SUM(scrap_tare_wt),0) 
INTO :ll_l
FROM scrap_skid
WHERE scrap_ab_job_num = :al_job
USING SQLCA;

ll_l = ll_l + ll_scrapnet
ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ads.Modify(ls_modstring) 


ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet
 
ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
ads.Modify(ls_modstring) 

ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
ads.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/06
ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
ads.Modify(ls_modstring)
//END Modified by Victor Huang in 04/06

//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. End
end subroutine

public function long wf_rejected_coil_wt (long al_ab_job_num, long al_coil_abc_num);//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
/*
Function:	wf_rejected_coil_wt
Returns:		long
Arguments:	value	long	al_ab_job_num
				value	long	al_coil_abc_num
*/


Long ll_wt1, ll_wt2, ll_wt, ll_shift_end_wt

CONNECT USING SQLCA;

SELECT process_quantity, process_end_wt INTO :ll_wt, :ll_shift_end_wt
FROM process_coil
WHERE (coil_abc_num = :al_coil_abc_num) AND (ab_job_num = :al_ab_job_num)
USING SQLCA;
IF IsNULL(ll_wt) THEN ll_wt = 0

IF IsNULL(ll_shift_end_wt) THEN
	SELECT net_wt_balance INTO :ll_wt1
	FROM coil
	WHERE coil_abc_num = :al_coil_abc_num
	USING SQLCA;
	IF ISNULL(ll_wt1) THEN ll_wt1 = 0
ELSE
	ll_wt1 = ll_shift_end_wt
END IF

SELECT MAX(process_quantity) INTO :ll_wt2
FROM process_coil
WHERE (coil_abc_num = :al_coil_abc_num) AND (process_quantity < :ll_wt)
USING SQLCA;
IF IsNULL(ll_wt2) THEN ll_wt2 = 0

RETURN MAX(ll_wt1, ll_wt2)
//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. End
end function

public subroutine wf_email_files_cleanup (string as_files_2delete[]);//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
/*
Function:	wf_email_files_cleanup
Returns:		none
Arguments:	value	string	as_files_2delete[]
*/

String	ls_filename
Integer 	li_i, li_files
Boolean	lb_rtn

li_files = UpperBound(as_files_2delete[])

If li_files > 0 Then
	For li_i = 1 To li_files
		ls_filename = as_files_2delete[li_i]
		
		If Lower(Left(ls_filename, 7)) = "c:\temp" Then
			lb_rtn = FileDelete(ls_filename)
		End If
	Next
End If
//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. End
end subroutine

on w_office_skid_entry.create
int iCurrent
call super::create
if this.MenuName = "m_office_entry" then this.MenuID = create m_office_entry
this.st_11=create st_11
this.st_10=create st_10
this.cb_reprint_skid_tag=create cb_reprint_skid_tag
this.dw_selected_rows=create dw_selected_rows
this.dw_abis_ini=create dw_abis_ini
this.cb_refresh_all=create cb_refresh_all
this.tab_skids=create tab_skids
this.dw_prod_order_detail=create dw_prod_order_detail
this.cb_close=create cb_close
this.st_title1=create st_title1
this.st_title#=create st_title#
this.dw_coil_status=create dw_coil_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_11
this.Control[iCurrent+2]=this.st_10
this.Control[iCurrent+3]=this.cb_reprint_skid_tag
this.Control[iCurrent+4]=this.dw_selected_rows
this.Control[iCurrent+5]=this.dw_abis_ini
this.Control[iCurrent+6]=this.cb_refresh_all
this.Control[iCurrent+7]=this.tab_skids
this.Control[iCurrent+8]=this.dw_prod_order_detail
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.st_title1
this.Control[iCurrent+11]=this.st_title#
this.Control[iCurrent+12]=this.dw_coil_status
end on

on w_office_skid_entry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.cb_reprint_skid_tag)
destroy(this.dw_selected_rows)
destroy(this.dw_abis_ini)
destroy(this.cb_refresh_all)
destroy(this.tab_skids)
destroy(this.dw_prod_order_detail)
destroy(this.cb_close)
destroy(this.st_title1)
destroy(this.st_title#)
destroy(this.dw_coil_status)
end on

event open;call super::open;Long	ll_row, ll_rows //Alex Gerlants. 06/15/2018. Arconic_Package_Num

Open(w_office_entry_open)

il_current_job_num = Message.DoubleParm
IF il_current_job_num < 1 THEN 
	Close(this)
	RETURN 0
END IF
st_title#.Text = String(il_current_job_num)

il_customer_id = wf_get_customer_id(il_current_job_num) //Alex_Gerlants. 1260_Incoming_Customer_Quality

CONNECT USING SQLCA;
SELECT order_abc_num INTO :il_current_order
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;

CONNECT USING SQLCA;
SELECT order_item_num INTO :il_current_order_item
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;


dw_coil_status.Retrieve(il_current_job_num)
dw_prod_order_detail.Event pfc_Retrieve()

tab_skids.tabpage_sheet.dw_skid_list.Event pfc_Retrieve()
tab_skids.tabpage_sheet.dw_skid_list.SetFocus()
IF il_current_job_num > 0 THEN
	ir_theo_pcwt = wf_get_pc_theowt()
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_SetFilter("sheet_skid_ab_job_num = " + String(il_current_job_num))
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_Filter()
ELSE
	ir_theo_pcwt = 0
END IF
tab_skids.tabpage_sheet.dw_skid_editor.Event pfc_Retrieve()
tab_skids.tabpage_sheet.dw_skid_editor.Reset()

dw_coil_status.visible = FALSE

wf_get_partial_skid()

//handling scrap skids tab
tab_skids.tabpage_scrap.dw_scrap_list.of_SetLinkage(TRUE)
tab_skids.tabpage_scrap.dw_scrap_list.inv_Linkage.of_SetStyle(2)
tab_skids.tabpage_scrap.dw_scrap_list.inv_linkage.of_SetConfirmOnRowChange (True)
tab_skids.tabpage_scrap.dw_scrap_list.inv_linkage.of_setUpdateOnRowChange (TRUE)

tab_skids.tabpage_scrap.dw_scrap_item.of_SetLinkage( TRUE ) 
tab_skids.tabpage_scrap.dw_scrap_item.inv_Linkage.of_SetMaster(tab_skids.tabpage_scrap.dw_scrap_list)
IF NOT tab_skids.tabpage_scrap.dw_scrap_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link tab_skids.tabpage_scrap.dw_scrap_list & tab_skids.tabpage_scrap.dw_scrap_item!" )
ELSE
	tab_skids.tabpage_scrap.dw_scrap_item.inv_Linkage.of_Register( "scrap_skid_num", "scrap_skid_detail_scrap_skid_num" ) 
	tab_skids.tabpage_scrap.dw_scrap_item.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_skids.tabpage_scrap.dw_scrap_list.inv_Linkage.of_SetTransObject(sqlca) 
tab_skids.tabpage_scrap.dw_scrap_list.inv_linkage.of_retrieve() 

tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
//wf_display_total_info()

//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
f_get_use_package_num_4job(il_current_job_num, sqlca, ib_use_package_num)

ll_rows = tab_skids.tabpage_sheet.dw_skid_list.RowCount()

If ib_use_package_num Then
	For ll_row = 1 To ll_rows
		tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row] = 1 //Make package_num visible
		tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	Next
Else
	For ll_row = 1 To ll_rows
		tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row] = 0 //Make package_num invisible
		tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	Next
End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
wf_retrieve_skids_4job_coil(il_current_job_num, True) //Retrieve all skids for il_current_job_num
wf_retrieve_coils_4job(il_current_job_num)
wf_populate_abis_ini_variables()
//is_from_name = gnv_app.of_GetUserId() //is_from_name is populated in wf_populate_abis_ini_variables()
tab_skids.tabpage_qa_skid.sle_email_address_from.Text = Lower(is_from_name) + gs_albl_email_address
wf_retrieve_d_qa_email_address()
dw_abis_ini.Visible = False
tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.SetTransObject(sqlca)
tab_skids.tabpage_qa_skid.dw_report_attached.SetTransObject(sqlca)
tab_skids.tabpage_qa_skid.dw_report_attached.Visible = False
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End

dw_selected_rows.Visible = False //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit
tab_skids.tabpage_sheet.cb_group_edit.Enabled = False //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit
tab_skids.tabpage_sheet.dw_skid_list.of_SetRowSelect(False) //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. Turn off inv_rowselect service
il_row_orig = -99 //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit

end event

event pfc_save;Int li_rc
Long ll_skid, ll_item, ll_row, ll_i

Long ll_snet, ll_stare, ll_spc, ll_theo, ll_job
Int li_sstatus 
DateTime ld_sdate

Long ll_inet, ll_icoil, ll_ipc, ll_itheo 
Int li_istatus
DateTime ld_idate
String ls_place

String	ls_coil_org_num, ls_coil_mid_num, ls_lot_num //Alex Gerlants. 03/14/2018
Long		ll_coil_abc_num  //Alex Gerlants. 05/07/2018

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Long		ll_sheet_skid_num, ll_package_num, ll_row_skid, ll_row_item //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Integer	li_onhold_reason_code //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason
Boolean	lb_new_skid //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason
		


IF wf_check_coil() < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF

//Alex Gerlants. 03/23/2022. 1462_Office_Skid_Entry_Group_Edit. Begin
If ii_action = 7 Then
	li_rc = wf_save_group_edit() //save, commit or rollback, tab_skids.tabpage_sheet.dw_scrap_list.ResetUpdate(), and wf_set_action(0) are done in this function
	
	If li_rc = 1 Then //OK in wf_save_group_edit()
		ll_job = Long(st_title#.Text)
		tab_skids.tabpage_sheet.dw_skid_list.Retrieve(ll_job) //Re-retrieve
		
		MessageBox("Info", "Data saved for job " + String(ll_job))
		Return 1
	Else
		Return -1
	End If
End If
//Alex Gerlants. 03/23/2022. 1462_Office_Skid_Entry_Group_Edit. End

tab_skids.tabpage_sheet.dw_skid_editor.AcceptText()
ll_row = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN -2
ll_skid = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_num", Primary!, FALSE)

ll_snet = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_net_wt", Primary!, FALSE)
ll_stare = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_tare_wt", Primary!, FALSE)
ll_spc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_skid_pieces", Primary!, FALSE)
li_sstatus = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
ld_sdate = tab_skids.tabpage_sheet.dw_skid_editor.GetItemDateTime(ll_row, "sheet_skid_skid_date", Primary!, FALSE)
ll_theo = wf_get_skid_theowt()

ll_icoil = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_coil_abc_num", Primary!, FALSE)
ll_job = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE)
li_istatus = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_status", Primary!, FALSE)
ll_ipc = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_inet = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
ll_itheo = tab_skids.tabpage_sheet.dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
ld_idate = tab_skids.tabpage_sheet.dw_skid_editor.GetItemDateTime(ll_row, "production_sheet_item_prod_item_date", Primary!, FALSE)
ls_place = tab_skids.tabpage_sheet.dw_skid_editor.GetItemString(ll_row, "production_sheet_item_prod_item_placemen", Primary!, FALSE)

//Alex Gerlants. 03/14/2018. Begin
wf_coil_info() //First, update coil_org_num, coil_mid_num, and lot_num in dw_skid_editor

//Then, get coil_org_num, coil_mid_num, and lot_num from dw_skid_editor
ls_coil_org_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_org_num[ll_row]
ls_coil_mid_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.coil_mid_num[ll_row]
ls_lot_num = tab_skids.tabpage_sheet.dw_skid_editor.Object.lot_num[ll_row]
//Alex Gerlants. 03/14/2018. End

li_onhold_reason_code = tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code[ll_row] //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason

IF wf_coil_sheet_wt(ll_icoil,ll_item,ll_inet) < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF

CHOOSE CASE ii_action
	CASE 1 //new skid
		//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Begin
		li_rtn = wf_check_tare_wt()
		
		If li_rtn = -1 Then
			Return -5
		End If
		
		li_rtn = wf_check_onhold_reason()
		
		If li_rtn = -1 Then
			Return -6
		End If
		
		lb_new_skid = True
		li_rtn = wf_insert_skid_onhold_reason_track(lb_new_skid)
		//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. End
		IF (li_sstatus <> 7) AND (ll_spc <> ll_ipc) THEN
			IF MessageBox("Question", "Skid pieces do not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
		END IF
	CASE 2 //new item
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -2
	CASE 3 //delete item
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -3
	CASE 4 //modify
		//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Begin
		li_rtn = wf_check_tare_wt()
		
		If li_rtn = -1 Then
			Return -5
		End If
		
		li_rtn = wf_check_onhold_reason()
		
		If li_rtn = -1 Then
			Return -6
		End If
		
		lb_new_skid = False
		li_rtn = wf_insert_skid_onhold_reason_track(lb_new_skid)
		//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. End
		
		If Not wf_check_sheet_skid_status() Then Return -4 //Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -4
END CHOOSE

CONNECT USING SQLCA;
CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		INSERT INTO sheet_skid (sheet_skid_num, ab_job_num, sheet_net_wt , sheet_tare_wt, skid_date, skid_pieces , skid_sheet_status, sheet_theoretical_wt, ref_order_abc_num, ref_order_abc_item, onhold_reason_code)
		VALUES (:ll_skid, :il_current_job_num, :ll_snet, :ll_stare,:ld_sdate,:ll_spc, :li_sstatus, :ll_theo, :il_current_order, :il_current_order_item, :li_onhold_reason_code)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Skid function: skid table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:il_current_job_num,:li_istatus,:ll_inet, SYSDATE,:ll_ipc, :ll_itheo, :ls_place)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Skid function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		
		INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Skid function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		li_rtn = f_insert_sheet_skid_package(il_current_job_num, ll_skid, sqlca)
		
		If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package()
			rollback using sqlca;
			Return -5
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	CASE 2	//item
		UPDATE sheet_skid
		SET sheet_net_wt = :ll_snet, ab_job_num = :il_current_job_num, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo, ref_order_abc_num = :il_current_order, ref_order_abc_item=:il_current_order_item, onhold_reason_code = :li_onhold_reason_code
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			Messagebox("DBError", "add item function" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -4
		END IF			
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:il_current_job_num,:li_istatus,:ll_inet,SYSDATE,:ll_ipc, :ll_itheo, :ls_place)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Item function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Insert Item function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
	CASE 3	//delete item
		DELETE FROM sheet_skid_detail
		WHERE sheet_skid_num = :ll_skid AND prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete item function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		DELETE FROM production_sheet_item
		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete item function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
	CASE 4	//modify
		UPDATE sheet_skid
		SET sheet_net_wt = :ll_snet, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo, onhold_reason_code = :li_onhold_reason_code
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF			
		UPDATE production_sheet_item
		SET coil_abc_num = :ll_icoil, ab_job_num = :il_current_job_num, prod_item_status = :li_istatus, prod_item_net_wt = :ll_inet, prod_item_date = SYSDATE, prod_item_pieces = :ll_ipc, prod_item_theoretical_wt = :ll_itheo, prod_item_placement = :ls_place		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF
	CASE 5	//delete skid
		DELETE FROM sheet_skid_detail
		WHERE sheet_skid_num = :ll_skid AND prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete function: skid detail table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
 		DELETE FROM production_sheet_item
		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete function: skid item table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
		DELETE FROM sheet_skid
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			Messagebox("DBError", "Delete function: skid table" + "~n~r~n~r" + sqlca.sqlerrtext ) //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Added ~n~r~n~r" + sqlca.sqlerrtext
			ROLLBACK USING SQLCA;
			RETURN -5
		END IF
END CHOOSE

dw_coil_status.AcceptText()
li_rc = dw_coil_status.Update()
IF li_rc = 1 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	Messagebox("DBError", "dw_coil_status" )
	RETURN -6
END IF

IF li_rc = 1 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	Messagebox("DBError", "dw_skid_detail during adding" )
	RETURN -7
END IF

MessageBox("Info", "Data had been saved.")

CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		wf_coil_info() //Alex Gerlants. 03/14/2018
		tab_skids.tabpage_sheet.dw_skid_editor.RowsCopy(tab_skids.tabpage_sheet.dw_skid_editor.GetRow(), tab_skids.tabpage_sheet.dw_skid_editor.GetRow(), Primary!, tab_skids.tabpage_sheet.dw_skid_list, (tab_skids.tabpage_sheet.dw_skid_list.RowCount() + 1), Primary!)		
		
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		If ib_use_package_num Then
			ll_row_skid = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
			ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row_skid] //Get sheet_skid_num from the last row
			ll_package_num = wf_get_package_num_4skid(ll_sheet_skid_num, sqlca)
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num[ll_row_skid] = ll_package_num
			
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row_skid] = 1 //Make package_num visible
			tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row_skid, 0, Primary!, NotModified!)
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
		
		
	CASE 2	//item
		ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
		
		ll_row_skid = ll_row //Alex Gerlants. 06/15/2018. Arconic_Package_Num.
		
		IF ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount() THEN
			ll_row = 0
		ELSE
			ll_row = ll_row + 1
		END IF

		ll_row = tab_skids.tabpage_sheet.dw_skid_list.InsertRow(ll_row)
		
		ll_row_item = ll_row //Alex Gerlants. 06/15/2018. Arconic_Package_Num
		
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_net_wt", ll_snet)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_tare_wt",ll_stare)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_skid_pieces",ll_spc)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_skid_sheet_status", li_sstatus)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "sheet_skid_skid_date",ld_sdate) 
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_coil_abc_num", ll_icoil)
		tab_skids.tabpage_sheet.dw_skid_list.setItem(ll_row, "production_sheet_item_ab_job_num", ll_job)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_status", li_istatus)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_ipc)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_net_wt", ll_inet)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_itheo)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_date", ld_idate)
		tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_placemen",ls_place)
		
		//Alex Gerlants. 03/14/2018. Begin
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_org_num[ll_row] = ls_coil_org_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.coil_mid_num[ll_row] = ls_coil_mid_num
		tab_skids.tabpage_sheet.dw_skid_list.Object.lot_num[ll_row] = ls_lot_num
		//Alex Gerlants. 03/14/2018. End
		
		ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate) 
			END IF
		NEXT
		
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		If ib_use_package_num Then
			//ll_row_package = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
			ll_sheet_skid_num = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row_skid] //Get sheet_skid_num from the last row
			ll_package_num = wf_get_package_num_4skid(ll_sheet_skid_num, sqlca)
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num[ll_row_item] = ll_package_num
			
			tab_skids.tabpage_sheet.dw_skid_list.Object.package_num_visible[ll_row_item] = 1 //Make package_num visible
			tab_skids.tabpage_sheet.dw_skid_list.SetItemStatus(ll_row_item, 0, Primary!, NotModified!)
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	CASE 3	//delete item
		IF tab_skids.tabpage_sheet.dw_skid_list.GetRow() > 0 THEN
			tab_skids.tabpage_sheet.dw_skid_list.DeleteRow(tab_skids.tabpage_sheet.dw_skid_list.GetRow() )
		END IF
	CASE 4	//modify
		ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate)
				
				wf_update_skid_list() //Alex Gerlants. 06/07/2018
				
				IF ll_item = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE) THEN
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_coil_abc_num", ll_icoil)
					tab_skids.tabpage_sheet.dw_skid_list.setItem(ll_row, "production_sheet_item_ab_job_num", ll_job)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_status", li_istatus)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_pieces", ll_ipc)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_net_wt", ll_inet)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_theoreti", ll_itheo)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_date", ld_idate)
					tab_skids.tabpage_sheet.dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_placemen",ls_place)
					
					//wf_update_skid_list() //Alex Gerlants. 06/07/2018

				END IF
			END IF
		NEXT
	CASE 5	//delete skid
		IF tab_skids.tabpage_sheet.dw_skid_list.GetRow() > 0 THEN
			tab_skids.tabpage_sheet.dw_skid_list.DeleteRow(tab_skids.tabpage_sheet.dw_skid_list.GetRow() )
		END IF
END CHOOSE
tab_skids.tabpage_sheet.dw_skid_list.ResetUpdate()
tab_skids.tabpage_sheet.dw_skid_list.Event ue_goto_row()

tab_skids.tabpage_sheet.dw_skid_editor.ResetUpdate()
tab_skids.tabpage_sheet.dw_skid_editor.Reset()
wf_set_action(0)

RETURN 1
end event

event pfc_print;OpenwithParm(w_report_skid_entry, il_current_job_num)
RETURN 1
end event

event close;call super::close;f_display_app()
end event

event closequery;call super::closequery;//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
Integer 	li_row, li_rows
String	ls_filename, ls_files_2delete[]

li_rows = tab_skids.tabpage_qa_skid.dw_attached_file_name.RowCount()

If li_rows > 0 Then
	//Collect file names to delete from C:\temp
	For li_row = 1 To li_rows
		ls_filename = tab_skids.tabpage_qa_skid.dw_attached_file_name.Object.attached_file_name[li_row]
		ls_files_2delete[UpperBound(ls_files_2delete[]) + 1] = ls_filename
		//FileDelete(ls_filename)
	Next
	
	wf_email_files_cleanup(ls_files_2delete[])
End If
//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. End

//Accept the last data entered into the datawindow
tab_skids.Tabpage_qa_skid.dw_qa_customer_quality_skid.AcceptText()

//Check to see if any data have changed
If tab_skids.Tabpage_qa_skid.dw_qa_customer_quality_skid.DeletedCount() + tab_skids.Tabpage_qa_skid.dw_qa_customer_quality_skid.ModifiedCount() > 0 Then //User made changes
   If ancestorreturnvalue = 1 Then //User clicked on "Yes" on ancestor generated "Do you want to save your changes?" message
		tab_skids.Tabpage_qa_skid.cb_qa_save.Event Clicked()
      Return 0 //Close the window
	Else //ancestorreturnvalue = 0. User clicked on "No" on ancestor generated "Do you want to save your changes?" message
		Return 0 //Close the window
	End If
Else
   Return 0 //Close the window
End If
end event

type st_11 from statictext within w_office_skid_entry
integer x = 562
integer y = 1772
integer width = 983
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217739
string text = "please save before reprinting"
boolean focusrectangle = false
end type

type st_10 from statictext within w_office_skid_entry
integer x = 562
integer y = 1720
integer width = 983
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217739
string text = "For newly created skids,"
boolean focusrectangle = false
end type

type cb_reprint_skid_tag from commandbutton within w_office_skid_entry
integer x = 142
integer y = 1732
integer width = 393
integer height = 72
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reprint Skid Tag"
end type

event clicked;OpenWithParm(w_reprint_skid_tag2_oe, il_current_job_num) //Alex Gerlants. 12/02/2023. 2045_Add_Reprint_Skid_Tag_To_Office_Skid_Entry
end event

type dw_selected_rows from datawindow within w_office_skid_entry
integer x = 1728
integer y = 1744
integer width = 549
integer height = 60
integer taborder = 40
string title = "none"
string dataobject = "d_number"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_abis_ini from datawindow within w_office_skid_entry
integer x = 2821
integer y = 1724
integer width = 82
integer height = 84
integer taborder = 40
string title = "none"
string dataobject = "d_abis_ini"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_refresh_all from commandbutton within w_office_skid_entry
integer x = 4087
integer y = 1732
integer width = 393
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refresh All Tabs"
end type

event clicked;//Alex Gerlants. Scrap Credit. Begin
tab_skids.tabpage_sheet.dw_skid_list.Retrieve(il_current_job_num)
tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
//Alex Gerlants. Scrap Credit. End
end event

type tab_skids from tab within w_office_skid_entry
event create ( )
event destroy ( )
integer x = 14
integer y = 192
integer width = 4462
integer height = 1504
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_sheet tabpage_sheet
tabpage_scrap tabpage_scrap
tabpage_scrap_credit tabpage_scrap_credit
tabpage_qa_skid tabpage_qa_skid
end type

on tab_skids.create
this.tabpage_sheet=create tabpage_sheet
this.tabpage_scrap=create tabpage_scrap
this.tabpage_scrap_credit=create tabpage_scrap_credit
this.tabpage_qa_skid=create tabpage_qa_skid
this.Control[]={this.tabpage_sheet,&
this.tabpage_scrap,&
this.tabpage_scrap_credit,&
this.tabpage_qa_skid}
end on

on tab_skids.destroy
destroy(this.tabpage_sheet)
destroy(this.tabpage_scrap)
destroy(this.tabpage_scrap_credit)
destroy(this.tabpage_qa_skid)
end on

type tabpage_sheet from userobject within tab_skids
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4425
integer height = 1384
long backcolor = 79741120
string text = "Sheet Skids"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_group_edit cb_group_edit
cb_converttoscrap cb_converttoscrap
cb_refresh cb_refresh
cb_modify cb_modify
cb_delete cb_delete
cb_insert cb_insert
cb_print cb_print
cb_new cb_new
cb_cancel cb_cancel
cb_save cb_save
dw_skid_editor dw_skid_editor
dw_skid_list dw_skid_list
gb_1 gb_1
end type

on tabpage_sheet.create
this.cb_group_edit=create cb_group_edit
this.cb_converttoscrap=create cb_converttoscrap
this.cb_refresh=create cb_refresh
this.cb_modify=create cb_modify
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.cb_print=create cb_print
this.cb_new=create cb_new
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_skid_editor=create dw_skid_editor
this.dw_skid_list=create dw_skid_list
this.gb_1=create gb_1
this.Control[]={this.cb_group_edit,&
this.cb_converttoscrap,&
this.cb_refresh,&
this.cb_modify,&
this.cb_delete,&
this.cb_insert,&
this.cb_print,&
this.cb_new,&
this.cb_cancel,&
this.cb_save,&
this.dw_skid_editor,&
this.dw_skid_list,&
this.gb_1}
end on

on tabpage_sheet.destroy
destroy(this.cb_group_edit)
destroy(this.cb_converttoscrap)
destroy(this.cb_refresh)
destroy(this.cb_modify)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.cb_print)
destroy(this.cb_new)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_skid_editor)
destroy(this.dw_skid_list)
destroy(this.gb_1)
end on

type cb_group_edit from commandbutton within tabpage_sheet
integer x = 3218
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Group Edit"
end type

event clicked;//Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. Begin
w_skid_group_edit	lw_skid_group_edit
Integer				li_skid_sheet_status, li_skid_sheet_status_new
Long					ll_row_selected

Open(lw_skid_group_edit)

li_skid_sheet_status_new = Message.DoubleParm

If li_skid_sheet_status_new = -99 Then //User clicked on Cancel button on w_skid_group_edit
	Return
End If

ll_row_selected = tab_skids.tabpage_sheet.dw_skid_list.GetSelectedRow(0) //Start from the beginning

Do While ll_row_selected > 0
	li_skid_sheet_status = tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_skid_sheet_status[ll_row_selected]
	If IsNull(li_skid_sheet_status) Then li_skid_sheet_status = -99
	
	If li_skid_sheet_status <> -99 Then
		tab_skids.tabpage_sheet.dw_skid_list.Object.sheet_skid_skid_sheet_status[ll_row_selected] = li_skid_sheet_status_new
	End If
	
	ll_row_selected = tab_skids.tabpage_sheet.dw_skid_list.GetSelectedRow(ll_row_selected) //Start after ll_row_selected
Loop

wf_set_action(7) //This is used pfc_save() event for w_office_skid_entry
//Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. End
end event

type cb_converttoscrap from u_cb within tabpage_sheet
integer x = 1879
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Convert to &Scrap"
end type

event clicked;call super::clicked;Long ll_row, ll_skid_num, ll_packing_list
Int li_status, li_rc, li_return

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return 0
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to convert. This skid has been shipped to customer already.", StopSign!)
	RETURN
END IF

ll_skid_num = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
select count(*) into :li_rc from sheet_packing_item
where sheet_skid_num = :ll_skid_num
using SQLCA;
if li_rc > 0 then
	select packing_list into :ll_packing_list from sheet_packing_item
	where sheet_skid_num = :ll_skid_num
	using SQLCA;
	MessageBox("Error","Failed to convert. This skid has been loaded into BOL#" + String(ll_packing_list), StopSign!)
	return 0
end if

//Alex_Skid_Convert_2Scrap_Message. Begin
//Copied from the the same check in Clicked event for cb_modify
//Modified by Victor Huang in 08/05
//Check if the skid has been assigned to a new job. If "yes", force user to remove the skid from the new job.
Long ll_skid, ll_orig_ab_job, ll_current_job_num
ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_current_job_num = il_current_job_num

SetNull(ll_orig_ab_job)
select ab_job_num into :ll_orig_ab_job
from process_partial_skid
where sheet_skid_num = :ll_skid
using SQLCA;

IF not isnull(ll_orig_ab_job) THEN 
	IF (ll_orig_ab_job <> ll_current_job_num) THEN
		MessageBox("Warning","This skid has been assigned to a new job# " + String(ll_orig_ab_job) +". Please remove it from the new job before any modification!", StopSign!)
		RETURN
	END IF	
END IF
//Alex_Skid_Convert_2Scrap_Message. End

li_rc = MessageBox("Confirmation","Please confirm converting skid#" + String(ll_skid_num) +" to scrap.", Question!, YesNo!)
if li_rc = 1 then
	setpointer(hourglass!)
	transaction dboconnect
	dboconnect = create transaction
	dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	dboconnect.LogID = gs_LogID
	dboconnect.LogPass = gs_LogPass
	connect using dboconnect;
	if dboconnect.SQLCode<0 then 
		MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
		return -1
	end if
	
	DECLARE p_convert_to_scrap procedure for f_convert_to_scrap (:ll_skid_num) using dboconnect;
	execute p_convert_to_scrap;
	if dboconnect.SQLCode < 0 then 
		MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
		disconnect using dboconnect;
		destroy dboconnect;
		return 0
	end if
	fetch p_convert_to_scrap INTO :li_return; 
	close p_convert_to_scrap;
	
	disconnect using dboconnect;
	destroy dboconnect;
	
	choose case li_return
	case 1
		Messagebox("Convert","Convert skid successfully. Please click OK then wait while this window is refreshing..." )		
		tab_skids.tabpage_sheet.cb_refresh.event clicked()
		tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	case else
		MessageBox("Convert", "Convert skid failed.", StopSign!)
   end choose
	
else
	return 0
	
end if


end event

type cb_refresh from u_cb within tabpage_sheet
integer x = 2322
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Refresh"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_list.Event pfc_Retrieve()
tab_skids.tabpage_sheet.dw_skid_list.SetFocus()
IF il_current_job_num > 0 THEN
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_SetFilter("sheet_skid_ab_job_num = " + String(il_current_job_num))
	tab_skids.tabpage_sheet.dw_skid_list.inv_filter.of_Filter()
END IF
tab_skids.tabpage_sheet.dw_skid_list.Event ue_goto_row()

end event

type cb_modify from u_cb within tabpage_sheet
integer x = 1435
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;Long ll_row, ll_item
Int li_status
Integer	li_skid_sheet_status, li_null, li_row_editor //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return

il_modified_row = ll_row //Alex Gerlants. 05/07/2018

/*
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN
END IF
*/ 
//by james Ni - 05/18/2015

IF tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN 
	MessageBox("Error","Failed to modify item to this skid because it was created by other job.", StopSign!)
	RETURN
END IF

//Modified by Victor Huang in 08/05
//Check if the skid has been assigned to a new job. If "yes", force user to remove the skid from the new job.
Long ll_skid, ll_orig_ab_job
ll_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

SetNull(ll_orig_ab_job)
select ab_job_num into :ll_orig_ab_job
from process_partial_skid
where sheet_skid_num = :ll_skid
using SQLCA;

IF not isnull(ll_orig_ab_job) THEN 
	IF (ll_orig_ab_job <> il_current_job_num) THEN
		MessageBox("Warning","This skid has been assigned to a new job# " + String(ll_orig_ab_job) +". Please remove it from the new job before any modification!", StopSign!)
		RETURN
	END IF	
END IF
//End

il_cur_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

tab_skids.tabpage_sheet.dw_skid_list.RowsCopy(tab_skids.tabpage_sheet.dw_skid_list.GetRow(), tab_skids.tabpage_sheet.dw_skid_list.GetRow(), Primary!, tab_skids.tabpage_sheet.dw_skid_editor, 1, Primary!)

wf_set_action(4)

//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Begin
li_row_editor = tab_skids.tabpage_sheet.dw_skid_editor.GetRow()

If li_row_editor > 0 Then
	li_skid_sheet_status = tab_skids.tabpage_sheet.dw_skid_editor.Object.sheet_skid_skid_sheet_status[li_row_editor]
		
	If li_skid_sheet_status = 4 Or li_skid_sheet_status = 10 Then
		tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code.protect = 0
	Else
		tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code.protect = 1
		SetNull(li_null)
		tab_skids.tabpage_sheet.dw_skid_editor.Object.onhold_reason_code[li_row_editor] = li_null
	End If
End If
//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. End
end event

type cb_delete from u_cb within tabpage_sheet
integer x = 992
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.Event ue_del_row()
RETURN 1
end event

type cb_insert from u_cb within tabpage_sheet
integer x = 549
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Insert Item"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.Event ue_insertitem()
end event

type cb_print from u_cb within tabpage_sheet
integer x = 2766
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event pfc_print()
end event

type cb_new from u_cb within tabpage_sheet
integer x = 105
integer y = 1252
integer width = 402
integer height = 80
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Skid"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.Event pfc_addrow()


end event

type cb_cancel from u_cb within tabpage_sheet
integer x = 4105
integer y = 1252
integer width = 288
integer height = 76
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;tab_skids.tabpage_sheet.dw_skid_editor.ResetUpdate()
tab_skids.tabpage_sheet.dw_skid_editor.Reset()
wf_set_action(0)
end event

type cb_save from u_cb within tabpage_sheet
integer x = 3785
integer y = 1252
integer width = 288
integer height = 76
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event pfc_save()

end event

type dw_skid_editor from u_dw within tabpage_sheet
event ue_insertitem ( )
event ue_del_row ( )
integer x = 37
integer y = 932
integer width = 4370
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_office_entry_skid_list_input"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_insertitem();Long ll_row, ll_item
Int li_status

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to add item to this skid because it has been shipped to customer already!", StopSign!)
	RETURN
END IF

ib_partial = FALSE
IF tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN ib_partial = TRUE

tab_skids.tabpage_sheet.dw_skid_list.RowsCopy(tab_skids.tabpage_sheet.dw_skid_list.GetRow(), tab_skids.tabpage_sheet.dw_skid_list.GetRow(), Primary!, this, 1, Primary!)
ll_row = this.GetRow()
il_cur_skid = this.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ib_partial THEN
	this.SetItem(ll_row, "sheet_skid_skid_date", Today())
	this.SetItem(ll_row, "production_sheet_item_ab_job_num", il_current_job_num)
	this.SetItem(ll_row, "sheet_skid_ab_job_num",  il_current_job_num)
END IF
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)

wf_set_action(2)
end event

event ue_del_row();Long ll_row, ll_item, ll_i, ll_numitem, ll_skid
Int li_status

ll_row = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_row < 1 THEN Return
li_status = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to delete item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN
END IF

IF tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN 
	MessageBox("Error","Failed to delete item to this skid because it was created by other job.", StopSign!)
	RETURN
END IF
ll_skid =  tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ll_row > 1 THEN
	il_cur_skid = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber((ll_row - 1), "sheet_skid_sheet_skid_num", Primary!, FALSE)
ELSE
	il_cur_skid = 0
END IF

tab_skids.tabpage_sheet.dw_skid_list.RowsCopy(tab_skids.tabpage_sheet.dw_skid_list.GetRow(), tab_skids.tabpage_sheet.dw_skid_list.GetRow(), Primary!, dw_skid_editor, 1, Primary!)

IF MessageBox("Warning","About to delete the item in editor box, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	ll_numitem = 0
	ll_row = tab_skids.tabpage_sheet.dw_skid_list.RowCount()
	FOR ll_i = 1 TO ll_row
		IF  tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) = ll_skid THEN ll_numitem = ll_numitem + 1
	NEXT
	IF ll_numitem > 1 THEN
		wf_set_action(3)
	ELSE
		wf_set_action(5)
	END IF
	cb_save.Event Clicked()
ELSE
	cb_cancel.Event Clicked()
END IF

end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)



end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row, ll_pc, ll_totalpc, ll_totalwt, ll_skid, ll_netwt, ll_item
Integer	li_skid_sheet_status, li_null //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason
Long		ll_ab_job_num, ll_sheet_skid_num //Alex Gerlants. 09/06/2022. 1639_Partial_Skid_Warning_Message 
Integer	li_skid_sheet_status_before //Alex Gerlants. 09/06/2022. 1639_Partial_Skid_Warning_Message

SetNull(li_null) //Alex Gerlants. 04/05/2022. 1516_OnHold_Reason

ls_ColName = this.GetColumnName()

//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Changed to Case
Choose Case ls_ColName
	//IF ls_ColName = "production_sheet_item_prod_item_pieces" THEN
	Case "production_sheet_item_prod_item_pieces"
		this.AcceptText()
		ll_row = this.GetRow()
		ll_skid = this.GetItemNumber(ll_row,"sheet_skid_sheet_skid_num", Primary!, FALSE)
		ll_item = this.GetItemNumber(ll_row, "sheet_skid_detail_prod_item_num", Primary!, FALSE)
		ll_pc = this.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
		ll_totalpc = this.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
		ll_totalwt = this.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)
		this.SetItem(ll_row,"production_sheet_item_prod_item_theoreti", Long(ir_theo_pcwt * ll_pc + 0.5) )
		IF ll_totalpc > 0 THEN
			ll_netwt = wf_item_netwts(ll_skid, ll_item)
			IF ll_netwt = 0 THEN
				this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", Ceiling(ll_totalwt * (ll_pc / ll_totalpc)))
			ELSE
				this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", (ll_totalwt - ll_netwt))
			END IF			
		END IF
	//END IF
	//IF ls_ColName = "sheet_skid_sheet_net_wt" THEN
	Case "sheet_skid_sheet_net_wt"
		this.AcceptText()
		ll_row = this.GetRow()
		ll_skid = this.GetItemNumber(ll_row,"sheet_skid_sheet_skid_num", Primary!, FALSE)
		ll_item = this.GetItemNumber(ll_row, "sheet_skid_detail_prod_item_num", Primary!, FALSE)
		ll_pc = this.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
		ll_totalpc = this.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
		ll_totalwt = this.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)
		this.SetItem(ll_row,"production_sheet_item_prod_item_theoreti", Long(ir_theo_pcwt * ll_pc + 0.5) )
		IF ll_totalpc > 0 THEN
			ll_netwt = wf_item_netwts(ll_skid, ll_item)
			IF ll_netwt = 0 THEN
				this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", Ceiling(ll_totalwt * (ll_pc / ll_totalpc)))
			ELSE
				this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", (ll_totalwt - ll_netwt))
			END IF			
		END IF
	//END IF
	//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. Begin
	Case "sheet_skid_skid_sheet_status"
		li_skid_sheet_status = Integer(data)
		
		If li_skid_sheet_status = 4 Or li_skid_sheet_status = 10 Then //On-Hold
			This.Object.onhold_reason_code.protect = 0
		Else
			This.Object.onhold_reason_code.protect = 1
			ll_row = This.GetRow()
			This.Object.onhold_reason_code[ll_row] = li_null
		End If
	//Alex Gerlants. 04/05/2022. 1516_OnHold_Reason. End
	
	////Alex Gerlants. 09/06/2022. 1639_Partial_Skid_Warning_Message. Begin
	//	li_skid_sheet_status_before = This.GetItemNumber(row, "sheet_skid_skid_sheet_status", Primary!, True)
	//	If IsNull(li_skid_sheet_status_before) Then li_skid_sheet_status_before = -99
	//	
	//	If li_skid_sheet_status_before <> -99 Then
	//		If li_skid_sheet_status_before <> li_skid_sheet_status Then
	//			If li_skid_sheet_status = 7 Or li_skid_sheet_status = 13 Then //7 = Partial, 13 = Partial-Rd
	//				ll_ab_job_num = il_current_job_num
	//				ll_sheet_skid_num = This.Object.sheet_skid_sheet_skid_num[row]
	//				MessageBox("DO NOT FORGET", "This skid " + String(ll_sheet_skid_num) + " must be removed from applied partials for job " + String(ll_ab_job_num) + &
	//						" to be applied to a future job")
	//			End If
	//		End If
	//	End If
	////Alex Gerlants. 09/06/2022. 1639_Partial_Skid_Warning_Message. End
End Choose
end event

event losefocus;this.ResetUpdate()
end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_skid, ll_item, ll_l, ll_job
Int li_i
Long ll_lrow

ll_row = this.GetRow()
IF ll_row < 1 THEN RETURN 0
ib_partial = FALSE

ll_skid = f_get_next_value("sheet_skid_num_seq")
il_cur_skid = ll_skid
this.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
this.SetItem(ll_row, "sheet_skid_detail_sheet_skid_num", ll_skid)
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
this.SetItem(ll_row, "sheet_skid_ab_job_num",  il_current_job_num)
this.SetItem(ll_row, "production_sheet_item_ab_job_num",il_current_job_num)
this.SetItem(ll_row, "sheet_skid_skid_date",Today())
this.SetItem(ll_row, "production_sheet_item_prod_item_date", Today())		
this.SetItem(ll_row, "sheet_skid_skid_sheet_status", 5)  //new

ll_lrow = tab_skids.tabpage_sheet.dw_skid_list.GetRow()
IF ll_lrow > 0 THEN
	li_i = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "sheet_skid_skid_pieces", Primary!, FALSE)
	this.SetItem(ll_row, "sheet_skid_skid_pieces", li_i)

	//production sheet item
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_coil_abc_num", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_coil_abc_num", ll_l)
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_ab_job_num", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_ab_job_num", ll_l)
	//li_i = this.GetItemNumber((ll_row -1), "production_sheet_item_prod_item_status", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_status", 2 ) //new
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_l)
	ll_l = tab_skids.tabpage_sheet.dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_l)
END IF

wf_set_action(1)

RETURN ll_skid

end event

event pfc_retrieve;call super::pfc_retrieve;DataWindowChild ldddw_cni
IF this.GetChild("production_sheet_item_coil_abc_num", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("production_sheet_item_coil_abc_num", ldddw_cni)
END IF

Return this.Retrieve(il_current_job_num)
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE 
	IF il_current_job_num <= 0 THEN RETURN -2
	Return adwc_obj.Retrieve(il_current_job_num)  
END IF
end event

type dw_skid_list from u_dw within tabpage_sheet
event ue_goto_row ( )
integer x = 14
integer y = 20
integer width = 4384
integer height = 832
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_office_entry_skid_list_display"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_goto_row;Long ll_crow, ll_trow, ll_i

IF il_cur_skid <= 0 THEN RETURN

ll_trow = RowCount()
IF ll_trow > 0 THEN
	ll_crow = 0
	FOR ll_i = 1 TO ll_trow
		IF GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) = il_cur_skid THEN
			ll_crow = ll_i
		END IF
	NEXT
	IF ll_crow > 0 THEN
		SelectRow(0, False)
		SelectRow(ll_crow, True)
		SetRow(ll_crow)
		ScrollToRow(ll_crow)
	END IF
END IF


end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
//of_SetRowSelect(TRUE) //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. Comment out 
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 ) //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. Comment out 
of_SetFilter(TRUE)





end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;//this.Event pfc_rowchanged() //Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. Commented out
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_retrieve;call super::pfc_retrieve;DataWindowChild ldddw_cni
IF this.GetChild("production_sheet_item_coil_abc_num", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("production_sheet_item_coil_abc_num", ldddw_cni)
END IF

RETURN this.Retrieve(il_current_job_num)



end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE 
	IF il_current_job_num <= 0 THEN RETURN -2
	Return adwc_obj.Retrieve(il_current_job_num)  
END IF
end event

event clicked;//Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. Begin
Long	ll_row, ll_row_start, ll_row_end, ll_inserted_row

If Not KeyDown(KeyControl!) And Not KeyDown(KeyShift!) Then
	il_row_orig = row
	
	If IsSelected(row) Then
		SelectRow(row, False)
		wf_add_remove_selected_row( row, "delete")
	Else
		SelectRow(0, False) //Unselect all rows
		//dw_selected_rows.Reset() //Delete all rows *****************************************************
		
		SelectRow(row, True) 
		//wf_add_remove_selected_row( row, "delete")
		wf_add_remove_selected_row( row, "add")
	End If
End If

If KeyDown(KeyControl!) Then
	//MessageBox("", "KeyControl pressed")
	
	SelectRow(il_row_orig, True)
	//f_add_remove_selected_row(tab_skids.tabpage_sheet, il_row_orig, "delete")
	wf_add_remove_selected_row(il_row_orig, "add")
	
	SelectRow(row, True)
	//wf_add_remove_selected_row( row, "delete")
	wf_add_remove_selected_row( row, "add")
	
	il_row_orig = row
End If

If KeyDown(KeyShift!) Then
	//MessageBox("", "KeyShift pressed")
	//SelectRow(0, False) //Unselect all rows
	
	ll_row_start = il_row_orig
	ll_row_end = row
	
	If ll_row_start < ll_row_end Then
		For ll_row = ll_row_start To ll_row_end
			SelectRow(ll_row, True)
			//f_add_remove_selected_row(tab_skids.tabpage_sheet, ll_row, "delete")
			wf_add_remove_selected_row(ll_row, "add")
		Next
	Else
		For ll_row = ll_row_end To ll_row_start
			SelectRow(ll_row, True)
			//f_add_remove_selected_row(tab_skids.tabpage_sheet, ll_row, "delete")
			wf_add_remove_selected_row(ll_row, "add")
		Next
	End If
	
	il_row_orig = row
End If

If dw_selected_rows.RowCount() > 0 Then
	cb_group_edit.Enabled = True
Else
	cb_group_edit.Enabled = False
End If
//Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. End
end event

event getfocus;call super::getfocus;//Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. Begin
If il_row_orig = -99 Then //il_row_orig = -99 is populated in Open event for w_office_skid_entry
	This.SelectRow(0, False)
	il_row_orig = 0
End If
//Alex Gerlants. 03/21/2022. 1462_Office_Skid_Entry_Group_Edit. End
end event

type gb_1 from groupbox within tabpage_sheet
integer x = 9
integer y = 880
integer width = 4439
integer height = 316
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Editor"
borderstyle borderstyle = styleraised!
end type

type tabpage_scrap from userobject within tab_skids
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4425
integer height = 1384
long backcolor = 79741120
string text = "Scrap Skids"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_convertback cb_convertback
cb_scrapcredit cb_scrapcredit
dw_report dw_report
cb_ref cb_ref
cb_sort cb_sort
cb_print_scrap cb_print_scrap
cb_edit cb_edit
cb_removeitem cb_removeitem
cb_remove cb_remove
cb_newitem cb_newitem
cb_new_scrap cb_new_scrap
cb_ereset cb_ereset
cb_esave cb_esave
dw_editor dw_editor
st_9 st_9
dw_scrap_item dw_scrap_item
st_6 st_6
st_7 st_7
st_5 st_5
st_3 st_3
st_4 st_4
st_2 st_2
st_8 st_8
dw_scrap_list dw_scrap_list
end type

on tabpage_scrap.create
this.cb_convertback=create cb_convertback
this.cb_scrapcredit=create cb_scrapcredit
this.dw_report=create dw_report
this.cb_ref=create cb_ref
this.cb_sort=create cb_sort
this.cb_print_scrap=create cb_print_scrap
this.cb_edit=create cb_edit
this.cb_removeitem=create cb_removeitem
this.cb_remove=create cb_remove
this.cb_newitem=create cb_newitem
this.cb_new_scrap=create cb_new_scrap
this.cb_ereset=create cb_ereset
this.cb_esave=create cb_esave
this.dw_editor=create dw_editor
this.st_9=create st_9
this.dw_scrap_item=create dw_scrap_item
this.st_6=create st_6
this.st_7=create st_7
this.st_5=create st_5
this.st_3=create st_3
this.st_4=create st_4
this.st_2=create st_2
this.st_8=create st_8
this.dw_scrap_list=create dw_scrap_list
this.Control[]={this.cb_convertback,&
this.cb_scrapcredit,&
this.dw_report,&
this.cb_ref,&
this.cb_sort,&
this.cb_print_scrap,&
this.cb_edit,&
this.cb_removeitem,&
this.cb_remove,&
this.cb_newitem,&
this.cb_new_scrap,&
this.cb_ereset,&
this.cb_esave,&
this.dw_editor,&
this.st_9,&
this.dw_scrap_item,&
this.st_6,&
this.st_7,&
this.st_5,&
this.st_3,&
this.st_4,&
this.st_2,&
this.st_8,&
this.dw_scrap_list}
end on

on tabpage_scrap.destroy
destroy(this.cb_convertback)
destroy(this.cb_scrapcredit)
destroy(this.dw_report)
destroy(this.cb_ref)
destroy(this.cb_sort)
destroy(this.cb_print_scrap)
destroy(this.cb_edit)
destroy(this.cb_removeitem)
destroy(this.cb_remove)
destroy(this.cb_newitem)
destroy(this.cb_new_scrap)
destroy(this.cb_ereset)
destroy(this.cb_esave)
destroy(this.dw_editor)
destroy(this.st_9)
destroy(this.dw_scrap_item)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_8)
destroy(this.dw_scrap_list)
end on

type cb_convertback from u_cb within tabpage_scrap
string tag = "Scarp skid reports"
integer x = 2103
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Convert Back"
end type

event clicked;call super::clicked;Long ll_row, ll_scrap_skid_num, ll_packing_list
Int li_status, li_rc, li_return

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return 0
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to convert back. This scrap skid has been shipped to customer already.", StopSign!)
	RETURN
END IF

ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
select count(*) into :li_rc from scrap_packing_item
where scrap_skid_num = :ll_scrap_skid_num
using SQLCA;
if li_rc > 0 then
	select packing_list into :ll_packing_list from scrap_packing_item
	where scrap_skid_num = :ll_scrap_skid_num
	using SQLCA;
	MessageBox("Error","Failed to convert. This scrap skid has been loaded into BOL#" + String(ll_packing_list), StopSign!)
	return 0
end if

select count(*) into :li_rc from scraped_sheet_skid
where scrap_skid_num = :ll_scrap_skid_num
using SQLCA;
if li_rc <= 0 then
	MessageBox("Error","Failed to convert. The scrap skid#" + String(ll_scrap_skid_num) +" was NOT converted from a sheet skid.", StopSign!)
	return 0
end if

li_rc = MessageBox("Confirmation","Please confirm converting scrap skid#" + String(ll_scrap_skid_num) +" back to sheet skid.", Question!, YesNo!)
if li_rc = 1 then
	setpointer(hourglass!)
	transaction dboconnect
	dboconnect = create transaction
	dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	dboconnect.LogID = gs_LogID
	dboconnect.LogPass = gs_LogPass
	connect using dboconnect;
	if dboconnect.SQLCode<0 then 
		MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
		return -1
	end if
	
	DECLARE p_convert_back_to_sheet procedure for f_convert_back_to_sheet(:ll_scrap_skid_num) using dboconnect;
	execute p_convert_back_to_sheet;
	if dboconnect.SQLCode < 0 then 
		MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
		disconnect using dboconnect;
		destroy dboconnect;
		return 0
	end if
	fetch p_convert_back_to_sheet INTO :li_return; 
	close p_convert_back_to_sheet;
	
	disconnect using dboconnect;
	destroy dboconnect;
	
	choose case li_return
	case 1
		Messagebox("Convert","Convert back to sheet skid successfully. Please click OK then wait while this window refreshing..." )		
		tab_skids.tabpage_sheet.cb_refresh.event clicked()
		tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	case else
		MessageBox("Convert", "Convert skid failed.", StopSign!)
   end choose
	
else
	return 0
	
end if


end event

type cb_scrapcredit from u_cb within tabpage_scrap
integer x = 1765
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Scrap Credit"
end type

event clicked;call super::clicked;Long ll_row, ll_scrap_skid_num
Int li_status,  li_rc

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return -1
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify this scrap skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
ELSE
	ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
END IF

li_rc = MessageBox("Confirmation","Please confirm converting scrap skid #" + String(ll_scrap_skid_num) + " into scrap credit.", Question!, YesNo!)

if li_rc  =  1 then
	  UPDATE "SCRAP_SKID"  
     SET "CUSTOMER_ID" = 1054  
     WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" =  :ll_scrap_skid_num  
	  Using SQLCA;
	  IF SQLCA.SQLCode = -1 THEN 
	        MessageBox("SQL error", SQLCA.SQLErrText)
			  rollback using SQLCA;
	  END IF
	  commit using SQLCA;
	  tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	  tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
else
	return 0
end if	

RETURN ll_row
end event

type dw_report from u_dw within tabpage_scrap
boolean visible = false
integer x = 3415
integer y = 1252
integer width = 105
integer height = 76
integer taborder = 170
boolean bringtotop = true
string dataobject = "d_office_entry_report_scrap_list"
boolean livescroll = false
end type

type cb_ref from u_cb within tabpage_scrap
integer x = 3122
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Re&ference"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_ref_scrap()
RETURN 1
end event

type cb_sort from u_cb within tabpage_scrap
integer x = 2779
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ort"
end type

event clicked;
SetPointer(HourGlass!)
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_sort_scrap()

end event

type cb_print_scrap from u_cb within tabpage_scrap
string tag = "Scarp skid reports"
integer x = 2441
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_scrap_report()

end event

type cb_edit from u_cb within tabpage_scrap
integer x = 1426
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;RETURN	tab_skids.tabpage_scrap.dw_editor.Event ue_modify()
end event

type cb_removeitem from u_cb within tabpage_scrap
integer x = 1088
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "R&emove Item"
end type

event clicked;//Parent.Event ue_deleteitem()
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_delete_scrap_item()
end event

type cb_remove from u_cb within tabpage_scrap
integer x = 750
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Remove Skid"
end type

event clicked;//Parent.Event ue_deleteskid()
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_delete_scrap_skid()
end event

type cb_newitem from u_cb within tabpage_scrap
integer x = 411
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "New &Item"
end type

event clicked;
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.DataObject = "d_return_scrap_item_editor"
tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 

RETURN	tab_skids.tabpage_scrap.dw_editor.Event ue_additem()

end event

type cb_new_scrap from u_cb within tabpage_scrap
integer x = 73
integer y = 1252
integer width = 325
integer height = 84
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Skid"
end type

event clicked;SetPointer(HourGlass!)
//Parent.Event pfc_new()
window lw_parent

lw_parent = tab_skids.GetParent()
lw_parent.dynamic Event ue_new_scrap_skid()
end event

type cb_ereset from u_cb within tabpage_scrap
integer x = 3506
integer y = 1252
integer width = 265
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Cancel"
end type

event clicked;
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.Reset()
wf_set_scrap_action(0)

end event

type cb_esave from u_cb within tabpage_scrap
integer x = 3808
integer y = 1252
integer width = 265
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

event clicked;
SetPointer(HourGlass!)
Int li_rc
Long ll_skid, ll_item, ll_row, ll_i

Long ll_snet, ll_stare, ll_scust, ll_cur_net, item_total_net
Int li_sstatus, li_itype 
DateTime ld_sdate
String ls_stemper, ls_spo, ls_location, ls_salloy, ls_snotes, ls_sjob

Long ll_inet, ll_icoil, ll_ijob
DateTime ld_idate
String ls_inotes

//Added by Victor Huang in 10/05 for tote number handling
Int li_tote_num

String	ls_trailer_name //Alex Gerlants. Tote_Trailer_Name. 06/12/2018

String	ls_scrap_handling_type //Alex Gerlants. Scrap Credit
Integer	li_answer, li_rtn //Alex Gerlants. Scrap Credit
Boolean	lb_display_message, lb_new_skid //Alex Gerlants. Scrap Credit

String	ls_handling //Alex Gerlants. 09/30/2024. 2177_DoNot_Move_2Credit_PreRecap_Skids
Integer	li_scrap_skid_status //Alex Gerlants. 09/30/2024. 2177_DoNot_Move_2Credit_PreRecap_Skids
Long		ll_scrap_skid_num //Alex Gerlants. 09/30/2024. 2177_DoNot_Move_2Credit_PreRecap_Skids

//Alex Gerlants. 09/30/2024. 2177_DoNot_Move_2Credit_PreRecap_Skids. Begin
If ii_action_scrap = 1 Or ii_action_scrap = 4 Then //1 = New skid. 4 = Modify skid
	ll_row = tab_skids.tabpage_scrap.dw_editor.GetRow()
	If (ll_row < 1) Or IsNull(ll_row) Then Return 0
	
	ll_scrap_skid_num = tab_skids.tabpage_scrap.dw_editor.Object.scrap_skid_num[ll_row]
	ls_handling = tab_skids.tabpage_scrap.dw_editor.Object.scrap_handling_type[ll_row]
	li_scrap_skid_status = tab_skids.tabpage_scrap.dw_editor.Object.skid_scrap_status[ll_row]
	
	If lower(ls_handling) = "scrap credit" Then
		If li_scrap_skid_status = 5 Then //PreRecap
			MessageBox("Scrap skid " + String(ll_scrap_skid_num) + ". Wrong status",	"You are trying to convert to credit a scrap skid in status 'PreRecap'." + &
																"~n~rPlease correct the status first.", StopSign!)
			Return 0
		End If
	End If
End If
//Alex Gerlants. 09/30/2024. 2177_DoNot_Move_2Credit_PreRecap_Skids. End

IF wf_check_info() < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF





tab_skids.tabpage_scrap.dw_editor.AcceptText()
ll_row = tab_skids.tabpage_scrap.dw_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN -2

CHOOSE CASE ii_action_scrap
	CASE 1,5,4  //skid
		ll_scust = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
		ll_skid = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
		ll_snet = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)

		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. Begin
		If IsNull(ll_snet) Then ll_snet = 0
		
		If ll_snet = 0 Then
			Messagebox("Error!", "Skid Net Weight must be populated", StopSign!)
			Return 0
		End If
		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. End

		ll_stare = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_tare_wt", Primary!, FALSE)
		ls_sjob = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_ab_job_num", Primary!, FALSE)
		li_sstatus = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
		ld_sdate = tab_skids.tabpage_scrap.dw_editor.GetItemDateTime(ll_row, "scrap_date", Primary!, FALSE)
		li_itype = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "scrap_type", Primary!, FALSE)
		ls_stemper = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_temper", Primary!, FALSE)
		ls_spo = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_cust_po", Primary!, FALSE)
		ls_location = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_location", Primary!, FALSE)
		ls_snotes = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_notes", Primary!, FALSE)
		ls_salloy = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "scrap_alloy2", Primary!, FALSE)
		
		//Added by Victor Huang in 10/05 for tote number handling
		li_tote_num = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "tote_num", Primary!, FALSE)
		
		ls_trailer_name = tab_skids.tabpage_scrap.dw_editor.Object.trailer_name[ll_row] //Alex Gerlants. Tote_Trailer_Name. 06/12/2018
		ls_scrap_handling_type = tab_skids.tabpage_scrap.dw_editor.Object.scrap_handling_type[ll_row] //Alex Gerlants. Scrap Credit
	CASE 2,3,6   //item
		ll_item = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE)
		ll_icoil = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_coil_abc_num", Primary!, FALSE)
		IF ll_icoil = 0 THEN SetNULL(ll_icoil)
		ll_ijob = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_ab_job_num", Primary!, FALSE)
		ll_inet = tab_skids.tabpage_scrap.dw_editor.GetItemNumber(ll_row, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		
		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. Begin
		If IsNull(ll_inet) Then ll_inet = 0
		
		If ll_inet = 0 Then
			Messagebox("Error!", "Item Net Weight must be populated", StopSign!)
			Return 0
		End If
		//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. End
		
		ld_idate = tab_skids.tabpage_scrap.dw_editor.GetItemDateTime(ll_row, "return_scrap_item_return_item_date", Primary!, FALSE)
		ls_snotes = tab_skids.tabpage_scrap.dw_editor.GetItemString(ll_row, "return_scrap_item_return_item_notes", Primary!, FALSE)
END CHOOSE



ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF  (ll_row < 1) AND (ii_action_scrap <> 1) THEN
	Messagebox("You did not select a skid", "Please select a skid!!")
	RETURN -1
END IF

IF ii_action_scrap <> 1 THEN
il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
END IF



//checking values
CHOOSE CASE ii_action_scrap
	CASE 1 //new skid
//		IF ll_snet <> ll_inet THEN
//			IF MessageBox("Question", "Skid net weight does not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
//		END IF
	CASE 2 //new item
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -2
	CASE 3 //delete item
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -3
	CASE 4 //modify skid
		//ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		//ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
		
		li_rc = tab_skids.tabpage_scrap.dw_scrap_item.RowCount()
		IF (li_rc < 1) OR IsNULL(li_rc) THEN 
			Messagebox("Warning!", "No item seleted!")
			RETURN 0
		END IF
		item_total_net = 0
		FOR ll_i = 1 TO li_rc
			item_total_net = item_total_net + tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_i, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		NEXT
		IF ll_snet <> item_total_net THEN
			Messagebox("Net weight did not add up right!!", "Please Modify item net weight first!!")
			RETURN 0
		END IF
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -4
	CASE 5 //del skid
	CASE 6 //modify item
END CHOOSE


CONNECT USING SQLCA;
CHOOSE CASE ii_action_scrap
	CASE 0 	//nothing
	CASE 1 	//new skid
		ll_ijob = Long(ls_sjob)
		ll_item = f_get_next_value("return_scrap_item_id_seq")
		SetNULL(ll_icoil)
		INSERT INTO scrap_skid (scrap_skid_num, customer_id, scrap_type, scrap_temper, scrap_net_wt, scrap_tare_wt, scrap_cust_po, scrap_ab_job_num, scrap_location,scrap_date, skid_scrap_status, scrap_notes, scrap_alloy2, tote_num, trailer_name, scrap_handling_type )
		VALUES (:ll_skid, :ll_scust, :li_itype, :ls_stemper,:ll_snet, :ll_stare, :ls_spo, :ls_sjob, :ls_location, :ld_sdate, :li_sstatus, :ls_snotes, :ls_salloy, :li_tote_num, :ls_trailer_name, :ls_scrap_handling_type)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: scrap skid table" )
			RETURN -5
		END IF
		INSERT INTO return_scrap_item (return_scrap_item_num, coil_abc_num , ab_job_num , return_item_net_wt, return_item_date, return_item_notes)
		VALUES (:ll_item, :ll_icoil, :ll_ijob, :ll_snet, :ld_sdate, :ls_inotes)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function:  scrap skid item table" )
			RETURN -5
		END IF
		INSERT INTO scrap_skid_detail
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid detail table" )
			RETURN -5
		END IF
	CASE 2	//new item
		INSERT INTO return_scrap_item (return_scrap_item_num, coil_abc_num , ab_job_num , return_item_net_wt, return_item_date, return_item_notes)
		VALUES (:ll_item, :ll_icoil, :ll_ijob, :ll_inet, :ld_idate, :ls_inotes)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function:  scrap skid item table" )
			RETURN -5
		END IF
		INSERT INTO scrap_skid_detail
		VALUES (:il_cur_scrap_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function: skid detail table" )
			RETURN -5
		END IF
		
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt + :ll_inet
		WHERE SCRAP_SKID_NUM = :il_cur_scrap_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function: scrap skid table" )
			RETURN -5
		END IF
		
	CASE 3	//delete item
		DELETE FROM scrap_skid_detail
		WHERE scrap_skid_num = :il_cur_scrap_skid AND return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid detail table" )
			RETURN -5
		END IF
		DELETE FROM return_scrap_item
		WHERE return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid item table" )
			RETURN -5
		END IF
		
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt - :ll_inet
		WHERE SCRAP_SKID_NUM = :il_cur_scrap_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: scrap skid table" )
			RETURN -5
		END IF
		
		
		
	CASE 4	//modify skid
		UPDATE scrap_skid
		SET customer_id = :ll_scust, scrap_type = :li_itype, scrap_temper = :ls_stemper, scrap_net_wt = :ll_snet, scrap_tare_wt = :ll_stare, scrap_cust_po = :ls_spo, scrap_ab_job_num = :ls_sjob, scrap_location = :ls_location, scrap_date = :ld_sdate, skid_scrap_status = :li_sstatus, scrap_notes = :ls_snotes, scrap_alloy2 = :ls_salloy, tote_num = :li_tote_num, trailer_name = :ls_trailer_name, scrap_handling_type = :ls_scrap_handling_type
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF			
	CASE 5	//delete skid
		DELETE FROM scrap_skid_detail
		WHERE scrap_skid_num = :ll_skid AND return_scrap_item_num = :il_cur_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: scrap skid detail table" )
			RETURN -5
		END IF
 		DELETE FROM return_scrap_item
		WHERE return_scrap_item_num = :il_cur_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: scrap skid item table" )
			RETURN -5
		END IF
		DELETE FROM scrap_skid
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: skid table" )
			RETURN -5
		END IF
	CASE 6	//modify item
		ll_row = tab_skids.tabpage_scrap.dw_scrap_item.GetRow()
		ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		//Messagebox("current net wt", ll_cur_net)
		ll_cur_net = ll_inet - ll_cur_net
		//Messagebox("net wt diff", ll_cur_net)
		
		UPDATE return_scrap_item
		SET coil_abc_num = :ll_icoil, ab_job_num = :ll_ijob, return_item_net_wt = :ll_inet, return_item_date = :ld_idate, return_item_notes = :ls_inotes
		WHERE return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF
		
		//Messagebox("current skid", il_cur_scrap_skid)
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt + :ll_cur_net
		WHERE SCRAP_SKID_NUM = :il_cur_scrap_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify item function: scrap skid table" )
			RETURN -5
		END IF
		
		//tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet)
		
		
END CHOOSE

//Alex Gerlants. Scrap Credit. Begin
If lower(ls_scrap_handling_type) = "scrap credit" Then
	If ii_action_scrap = 1 Then //New skid
		li_answer =  MessageBox("Confirmation","Please confirm saving scrap skid #" + String(ll_skid) + " as scrap credit.", Question!, YesNo!)
	ElseIf ii_action_scrap = 4 Then //Modify skid
		li_answer =  MessageBox("Confirmation","Please confirm converting scrap skid #" + String(ll_skid) + " into scrap credit.", Question!, YesNo!)
	End If
	
	If li_answer = 1 Then //Yes
		lb_display_message = False
	
		If ii_action_scrap = 1 Then //New skid
			lb_new_skid = True
		ElseIf ii_action_scrap = 4 Then //Modify skid
			lb_new_skid = False
		End If
		
		li_rtn = wf_scrap_credit(lb_display_message, ll_skid, lb_new_skid)
		
		If li_rtn = -1 Then //DB error in wf_scrap_credit()
			rollback using sqlca;
			Return 0
		End If
		
		tab_skids.tabpage_scrap.dw_editor.Reset()
	Else
		rollback using sqlca;
		Return 0
	End if
	
	//If ii_action_scrap = 1 Then //New skid
	//
	//	li_answer =  MessageBox("Confirmation","Please confirm making scrap skid #" + String(ll_skid) + " into scrap credit.", Question!, YesNo!)
	//
	//	If li_answer = 1 Then //Yes
	//		lb_display_message = False
	//		lb_new_skid = True
	//		wf_scrap_credit(lb_display_message, ll_skid, lb_new_skid)
	//		tab_skids.tabpage_scrap.dw_editor.Reset()
	//	Else
	//		rollback using sqlca;
	//		Return 0
	//	End if
	//ElseIf ii_action_scrap = 4 Then //Modify skid
	//	li_answer =  MessageBox("Confirmation","Please confirm making scrap skid #" + String(ll_skid) + " into scrap credit.", Question!, YesNo!)
	//
	//	If li_answer = 1 Then //Yes
	//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(0, False)
	//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(ll_row, True)
	//		tab_skids.tabpage_scrap.dw_scrap_list.SetRow(ll_row) //Make this row current because Clicked event for cb_scrapcredit uses GetRow()
	//		
	//		lb_display_message = False
	//		lb_new_skid = False
	//		wf_scrap_credit(lb_display_message, ll_skid, lb_new_skid)
	//	Else //No
	//		rollback using sqlca;
	//		Return 0
	//	End If
	//End If
End If
//Alex Gerlants. Scrap Credit. End

COMMIT USING SQLCA;

MessageBox("Info", "Data had been saved.")

CHOOSE CASE ii_action_scrap
	CASE 0 	//nothing
	CASE 1 	//new skid
		If lower(ls_scrap_handling_type) <> "scrap credit" Then //Alex Gerlants. Scrap Credit. For scrap credit, tab_skids.tabpage_scrap.dw_editor is reset above
			tab_skids.tabpage_scrap.dw_editor.RowsCopy(tab_skids.tabpage_scrap.dw_editor.GetRow(), tab_skids.tabpage_scrap.dw_editor.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_scrap_list, (tab_skids.tabpage_scrap.dw_scrap_list.RowCount() + 1), Primary!)		
		End If //Alex Gerlants. Scrap Credit
	CASE 2	//new item
		tab_skids.tabpage_scrap.dw_editor.RowsCopy(tab_skids.tabpage_scrap.dw_editor.GetRow(), tab_skids.tabpage_scrap.dw_editor.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_scrap_item, (tab_skids.tabpage_scrap.dw_scrap_item.RowCount() + 1), Primary!)		
			ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
			ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
			tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_cur_net + ll_inet)
	CASE 3	//delete item
		IF tab_skids.tabpage_scrap.dw_scrap_item.GetRow() > 0 THEN
			tab_skids.tabpage_scrap.dw_scrap_item.DeleteRow(tab_skids.tabpage_scrap.dw_scrap_item.GetRow() )
			ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
			ll_cur_net = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
			tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_cur_net - ll_inet)
		END IF
	CASE 4	//modify skid
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		IF ll_row > 0 THEN
			IF ll_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE) THEN		
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_tare_wt",ll_stare)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_ab_job_num",ls_sjob)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "skid_scrap_status", li_sstatus)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_date",ld_sdate) 
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_type", li_itype)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_temper",ls_stemper)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_cust_po",ls_spo)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_location", ls_location)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_notes",ls_snotes)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_alloy2",ls_salloy)
				tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "tote_num",ls_salloy)
				
				tab_skids.tabpage_scrap.dw_scrap_list.Object.trailer_name[ll_row] = ls_trailer_name //Alex Gerlants. Tote_Trailer_Name. 06/12/2018
				tab_skids.tabpage_scrap.dw_scrap_list.Object.scrap_handling_type[ll_row] = ls_scrap_handling_type //Alex Gerlants. Scrap Credit 
			END IF
		END IF
	CASE 5	//delete skid
		IF tab_skids.tabpage_scrap.dw_scrap_list.GetRow() > 0 THEN
			tab_skids.tabpage_scrap.dw_scrap_list.DeleteRow(tab_skids.tabpage_scrap.dw_scrap_list.GetRow() )
		END IF
	CASE 6   //modify item
		ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
		ll_snet = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
		tab_skids.tabpage_scrap.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet + ll_cur_net)
		
		ll_row = tab_skids.tabpage_scrap.dw_scrap_item.GetRow()
		IF ll_row > 0 THEN
			IF ll_item = tab_skids.tabpage_scrap.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE) THEN
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_coil_abc_num", ll_icoil)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_ab_job_num", ll_ijob)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_net_wt",ll_inet)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_date", ld_idate)
				tab_skids.tabpage_scrap.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_notes", ls_snotes)
				
			END IF
		END IF
END CHOOSE
tab_skids.tabpage_scrap.dw_scrap_list.ResetUpdate()
tab_skids.tabpage_scrap.dw_scrap_item.ResetUpdate()
tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)

////Alex Gerlants. Scrap Credit. Begin
//If lower(ls_scrap_handling_type) = "scrap credit" Then
//	If ii_action_scrap = 1 Then //New skid
//		ls_find_string = "scrap_skid_num = " + String(ll_skid)
//		ll_found_row = tab_skids.tabpage_scrap.dw_scrap_list.Find(ls_find_string, 1, tab_skids.tabpage_scrap.dw_scrap_list.RowCount())
//		
//		If ll_found_row > 0 Then
//			ll_row = ll_found_row
//			
//			tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(0, False)
//			tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(ll_row, True)
//			tab_skids.tabpage_scrap.dw_scrap_list.SetRow(ll_row) //Make this row current because Clicked event for cb_scrapcredit uses GetRow()
//		
//			cb_scrapcredit.Event Clicked()
//		End If
//	ElseIf ii_action_scrap = 4 Then //Modify skid	
//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(0, False)
//		tab_skids.tabpage_scrap.dw_scrap_list.SelectRow(ll_row, True)
//		tab_skids.tabpage_scrap.dw_scrap_list.SetRow(ll_row) //Make this row current because Clicked event for cb_scrapcredit uses GetRow()
//		
//		cb_scrapcredit.Event Clicked()
//	End If
//End If
////Alex Gerlants. Scrap Credit. End

wf_display_total_info()
tab_skids.tabpage_scrap.dw_scrap_list.Event ue_goto_row()


tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.Reset()
wf_set_scrap_action(0)

RETURN 1


end event

type dw_editor from u_dw within tabpage_scrap
event type integer ue_additem ( )
event type integer ue_addscrap ( long al_skid )
event type integer ue_del_row ( )
event type integer ue_modify ( )
integer x = 5
integer y = 980
integer width = 4425
integer height = 236
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_office_entry_return_scrap_item_editor"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event type integer ue_additem();
Long ll_item, ll_row
Int li_status

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return 0
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to add item to this skid because it has been shipped to customer already!", StopSign!)
	RETURN 0
END IF
il_cur_scrap_skid = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)

ll_row = this.Insertrow(0)
ll_item = f_get_next_value("return_scrap_item_id_seq")

SetItem(ll_row, "return_scrap_item_return_scrap_item_num", ll_item)
SetItem(ll_row, "return_scrap_item_return_item_date", Today())

wf_set_scrap_action(2)

Return ll_item


end event

event type integer ue_addscrap(long al_skid);
Long ll_row, ll_i, ll_new_skid, ll_row_cut, ll_c_id
Int li_cut_status

IF al_skid < 1 THEN Return 0

SetFilter("")
Filter()

ll_row = this.RowCount()
IF ll_row <= 0 THEN Return 0

FOR ll_i = 1 TO ll_row 
	ll_new_skid = this.GetItemNumber(ll_i, "Scrap_skid_num" )
	IF ll_new_skid = al_skid THEN
		li_cut_status = this.GetItemNumber(ll_i,"skid_scrap_status")
		IF li_cut_status <> 6 THEN 
			this.SetFilter("skid_scrap_status <> 6")
			this.Filter()
			MessageBox("Error","This pallet has been used already!", StopSign!)
			Return 0
		END IF
		this.SetItem(ll_i, "skid_scrap_status", 2)
		
		//ll_row_cut = dw_customer.GetRow()
		//ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
		select orig_customer_id into :ll_c_id
		from customer_order
		where order_abc_num = :il_current_order
		using SQLCA;
		SetItem(ll_i, "customer_id", ll_c_id)
		SetItem(ll_i, "scrap_date", Today() )
		Return 0
	END IF
NEXT

RETURN al_skid
end event

event type integer ue_del_row();
IF MessageBox("Warning","About to delete the item in editor box, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	tab_skids.tabpage_scrap.cb_esave.Event Clicked()
ELSE
	tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
	tab_skids.tabpage_scrap.dw_editor.Reset()
	wf_set_scrap_action(0)
END IF

RETURN 1

end event

event type integer ue_modify();Long ll_row
Int li_status

Integer	li_rtn //Alex Gerlants. Scrap Credit
String	ls_scrap_handling_cust_order //Alex Gerlants. Scrap Credit

DataWindowChild	ldwc //Alex Gerlants. 06/06/2022. 1571_Add_Scrap_Type
Long					ll_rows //Alex Gerlants. 06/06/2022. 1571_Add_Scrap_Type

ll_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return -1
li_status = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	
	//Leave it as it is
	//If Not wf_check_scrap_skid_status() Then Return 0 //Alex Gerlants. 07/10/2019. Skid_Status_Change_Warning
	
	MessageBox("Error","Failed to modify item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
END IF

//Messagebox("info", ii_dw_flag)

CHOOSE CASE ii_dw_flag
	CASE 1  //scrap skid
		li_rtn = tab_skids.tabpage_scrap.dw_scrap_list.RowsCopy(ll_row, ll_row, Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
		
		//Alex Gerlants. 06/06/2022. 1571_Add_Scrap_Type. Begin
		//Re-retrieve scrap type
		If li_rtn = 1 Then //OK
			li_rtn = tab_skids.tabpage_scrap.dw_editor.GetChild("scrap_type", ldwc)
			
			If li_rtn = 1 Then
				ldwc.SetTransObject(sqlca)
				ll_rows = ldwc.Retrieve()
			End If
		End If
		//Alex Gerlants. 06/06/2022. 1571_Add_Scrap_Type. End
		
		ls_scrap_handling_cust_order = tab_skids.tabpage_scrap.dw_scrap_list.Object.scrap_handling_type[ll_row] //Alex Gerlants. Scrap Credit
		wf_retrieve_scrap_handling(ls_scrap_handling_cust_order) //Alex Gerlants. Scrap Credit
		
		wf_set_scrap_action(4)
	CASE 2  //scrap item
		//Alex Gerlants. 06/06/2022. 1571_Add_Scrap_Type. Added "li_rtn = "
		li_rtn = tab_skids.tabpage_scrap.dw_scrap_item.RowsCopy(tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), tab_skids.tabpage_scrap.dw_scrap_item.GetRow(), Primary!, tab_skids.tabpage_scrap.dw_editor, 1, Primary!)
		
		////Alex Gerlants. 06/06/2022. 1571_Add_Scrap_Type. Begin
		////Re-retrieve scrap type
		//If li_rtn = 1 Then //OK
		//	li_rtn = tab_skids.tabpage_scrap.dw_scrap_item.GetChild("scrap_type", ldwc)
		//	
		//	If li_rtn = 1 Then
		//		ldwc.SetTransObject(sqlca)
		//		ll_rows = ldwc.Retrieve()
		//	End If
		//End If
		////Alex Gerlants. 06/06/2022. 1571_Add_Scrap_Type. End
		
		wf_set_scrap_action(6)
END CHOOSE

RETURN ll_row
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event itemchanged;call super::itemchanged;
String ls_colName, ls_po, ls_epo
Long ll_row, ll_job, ll_cust, ll_num, ll_order, ll_custrow, ll_id
DateTime ld_s, ld_e
Int li_item, li_line

SetNull(ll_id)
ls_ColName = this.GetColumnName()
IF ls_ColName = "return_scrap_item_ab_job_num" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_job = this.GetItemNumber(ll_row,"return_scrap_item_ab_job_num" ,Primary!, FALSE)

	ll_num = 0
	CONNECT USING SQLCA;
	SELECT Count(ab_job_num)
	INTO :ll_num
	FROM ab_job
	WHERE ab_job_num = :ll_job
	USING SQLCA;
		IF ll_num <> 1 THEN
		MessageBox("Warning", "Invalid job number!", StopSign!)
		//wf_reset_item_info(ll_row)
		RETURN -1
	END IF

	SELECT order_abc_num, order_item_num, time_date_started, time_date_finished, line_num
	INTO :ll_order, :li_item, :ld_s, :ld_e, :li_line
	FROM ab_job
	WHERE ab_job_num = :ll_job
	USING SQLCA;
	
	SELECT orig_customer_id, enduser_po, orig_customer_po INTO :ll_cust, :ls_epo, :ls_po
	FROM customer_order
	WHERE order_abc_num = :ll_order
	USING SQLCA;
	/*
	ll_custrow = dw_customer.Getrow()
	IF ll_cust <> dw_customer.GetItemNumber(ll_custrow, "customer_id") THEN
		MessageBox("Warning", "This is other customer's job!", StopSign!)
		//wf_reset_item_info(ll_row)
		RETURN -2
	END IF
	*/

	SetItem(ll_row, "ab_job_line_num", li_line)
	SetItem(ll_row, "ab_job_time_date_started", ld_s)
	SetItem(ll_row, "ab_job_time_date_finished", ld_e)
	SetItem(ll_row, "customer_order_orig_customer_id", ll_cust)
	SetItem(ll_row, "customer_order_enduser_po", ls_epo)
	SetItem(ll_row, "customer_order_orig_customer_po", ls_po)


END IF

end event

event rbuttondown;//Override
RETURN 1
end event

event rbuttonup;//Override
RETURN 1
end event

event pfc_addrow;call super::pfc_addrow;
long ll_row_skid, ll_new_id, ll_row_cut, ll_c_id, ll_prev_row
Int li_i
Long ll_long
Int li_int
Real lr_real
String ls_s

select orig_customer_id into :ll_c_id
from customer_order
where order_abc_num = :il_current_order
using SQLCA;

ll_row_skid = this.GetRow()
//ll_row_cut = dw_customer.GetRow()
//ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id")
SetItem(ll_row_skid, "customer_id", ll_c_id)

ll_new_id = f_get_next_value("scrap_skid_num_seq")

SetItem(ll_row_skid, "scrap_skid_num", ll_new_id)
SetItem(ll_row_skid, "skid_scrap_status", 2 )
SetItem(ll_row_skid, "scrap_date", Today() )
SetItem(ll_row_skid, "scrap_tare_wt", 0 )

ll_prev_row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
IF ll_prev_row > 0 THEN
	li_int = tab_skids.tabpage_scrap.dw_scrap_list.GetItemNumber(ll_prev_row, "scrap_type", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_type", li_int)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_ab_job_num", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_ab_job_num", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_alloy2", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_alloy2", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_temper", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_temper", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_cust_po", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_cust_po", ls_s)
	ls_s = tab_skids.tabpage_scrap.dw_scrap_list.GetItemString(ll_prev_row, "scrap_notes", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_notes", ls_s)
ELSE
	String ls_alloy2, ls_temper, ls_cust_po
	
	SELECT CUSTOMER_ORDER.ORIG_CUSTOMER_PO, ORDER_ITEM.ALLOY2, ORDER_ITEM.TEMPER INTO :ls_cust_po, :ls_alloy2, :ls_temper
	FROM CUSTOMER_ORDER, ORDER_ITEM, AB_JOB
	WHERE CUSTOMER_ORDER.ORDER_ABC_NUM = ORDER_ITEM.ORDER_ABC_NUM
	AND ORDER_ITEM.ORDER_ABC_NUM = AB_JOB.ORDER_ABC_NUM
	AND ORDER_ITEM.ORDER_ITEM_NUM = AB_JOB.ORDER_ITEM_NUM
	AND AB_JOB.AB_JOB_NUM = :il_current_job_num
	USING SQLCA;	  
	
	SetItem(ll_row_skid, "scrap_ab_job_num", String(il_current_job_num))
	SetItem(ll_row_skid, "scrap_alloy2", ls_alloy2)
	SetItem(ll_row_skid, "scrap_temper", ls_temper)
	SetItem(ll_row_skid, "scrap_cust_po", ls_cust_po)
END IF

wf_set_scrap_action(1)

Return ll_row_skid

end event

type st_9 from statictext within tabpage_scrap
integer x = 5
integer y = 932
integer width = 251
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Editor:"
boolean focusrectangle = false
end type

type dw_scrap_item from u_dw within tabpage_scrap
integer x = 5
integer y = 612
integer width = 4416
integer height = 324
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_office_entry_return_scrap_item"
boolean hscrollbar = true
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

event getfocus;call super::getfocus;ii_dw_flag = 2
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.DataObject = "d_office_entry_return_scrap_item_editor"
tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 

end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

type st_6 from statictext within tabpage_scrap
integer x = 3305
integer y = 560
integer width = 215
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_scrap
integer x = 3017
integer y = 560
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Canceled"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_scrap
integer x = 2789
integer y = 560
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ready"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_scrap
integer x = 2322
integer y = 560
integer width = 137
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_scrap
integer x = 2505
integer y = 560
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_scrap
integer x = 1970
integer y = 560
integer width = 352
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_scrap
integer y = 556
integer width = 457
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Scrap Skid Item List:"
boolean focusrectangle = false
end type

type dw_scrap_list from u_dw within tabpage_scrap
event ue_resume_where ( )
event type integer ue_search_retrieve ( )
event ue_goto_row ( )
integer y = 12
integer width = 4425
integer height = 556
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_office_entry_scrap_skid_list"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_resume_where();/*
String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_where = "  WHERE ( ~~~"SCRAP_SKID_DETAIL~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" = ~~~"RETURN_SCRAP_ITEM~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" ) and   ( ~~~"SCRAP_SKID~~~".~~~"SCRAP_SKID_NUM~~~" = ~~~"SCRAP_SKID_DETAIL~~~".~~~"SCRAP_SKID_NUM~~~" ) and  ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "
ls_where = "  WHERE ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "

ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	this.of_Retrieve()
	wf_display_total_info()	
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"
*/

end event

event type integer ue_search_retrieve();/*
String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

ls_where = wf_search_terms()

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF
*/
Return 1

end event

event ue_goto_row();Long ll_crow, ll_trow, ll_i

IF il_cur_scrap_skid <= 0 THEN RETURN

ll_trow = RowCount()
IF ll_trow > 0 THEN
	ll_crow = 0
	FOR ll_i = 1 TO ll_trow
		IF GetItemNumber(ll_i, "scrap_skid_num", Primary!, FALSE) = il_cur_scrap_skid THEN
			ll_crow = ll_i
		END IF
	NEXT
	IF ll_crow > 0 THEN
		SelectRow(0, False)
		SelectRow(ll_crow, True)
		SetRow(ll_crow)
		ScrollToRow(ll_crow)
	END IF
END IF


end event

event clicked;//Override pfc's clicked because it is running on wrong sequence
integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

this.SetFilter("skid_scrap_status <> 6")
this.Filter()

end event

event getfocus;call super::getfocus;ii_dw_flag = 1
tab_skids.tabpage_scrap.dw_editor.ResetUpdate()
tab_skids.tabpage_scrap.dw_editor.DataObject = "d_office_entry_scrap_skid_list_editor"
tab_skids.tabpage_scrap.dw_editor.SetTransObject(sqlca) 


end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = tab_skids.tabpage_scrap.dw_scrap_list.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

//il_cur_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(lI_row, "scrap_skid_num", Primary!, FALSE)
	
//tab_scrap.tabpage_skid.dw_scrap_item.Retrieve(il_cur_skid)

Return 

end event

type tabpage_scrap_credit from userobject within tab_skids
integer x = 18
integer y = 104
integer width = 4425
integer height = 1384
long backcolor = 79741120
string text = "Scrap Credit"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_convertbacktoscrap cb_convertbacktoscrap
cb_print_scrap_credit cb_print_scrap_credit
dw_scrap_credit dw_scrap_credit
end type

on tabpage_scrap_credit.create
this.cb_convertbacktoscrap=create cb_convertbacktoscrap
this.cb_print_scrap_credit=create cb_print_scrap_credit
this.dw_scrap_credit=create dw_scrap_credit
this.Control[]={this.cb_convertbacktoscrap,&
this.cb_print_scrap_credit,&
this.dw_scrap_credit}
end on

on tabpage_scrap_credit.destroy
destroy(this.cb_convertbacktoscrap)
destroy(this.cb_print_scrap_credit)
destroy(this.dw_scrap_credit)
end on

type cb_convertbacktoscrap from u_cb within tabpage_scrap_credit
integer x = 1038
integer y = 1212
integer width = 594
integer taborder = 21
string text = "&Convert Back To Scrap"
end type

event clicked;call super::clicked;Long ll_row, ll_scrap_skid_num, ll_customer_id
Int li_status,  li_rc

String					ls_scrap_handling_type //Alex Gerlants. Scrap Credit
str_all_data_types	lstr_all_data_types //Alex Gerlants. Scrap_Credit

ll_row = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetRow()
IF ll_row < 1 THEN Return -1
li_status = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify this scrap skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
ELSE
	ll_scrap_skid_num = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
END IF

li_rc = MessageBox("Confirmation","Please confirm converting scrap skid #" + String(ll_scrap_skid_num) + " back to customer's scrap skid.", Question!, YesNo!)

//Alex Gerlants. Scrap Credit. Begin
If li_rc = 1 Then //Yes
	ls_scrap_handling_type = tab_skids.tabpage_scrap_credit.dw_scrap_credit.Object.scrap_handling_type[ll_row]
	lstr_all_data_types.string_var[1] = ls_scrap_handling_type
	lstr_all_data_types.long_var[1] = ll_scrap_skid_num
	
	If Lower(ls_scrap_handling_type) = "scrap credit" Then
		li_rc  =  1
		
		//Open window so user can specify what scrap handling type to assign to skid when it comes back scrap skid tab
		OpenWithParm(w_change_scrap_handling_type, lstr_all_data_types)
	
		//Error checking is done in w_change_scrap_type
		lstr_all_data_types = Message.PowerObjectParm
		ls_scrap_handling_type = lstr_all_data_types.string_var[1]
		
		If ls_scrap_handling_type = "cancel" Then //User clicked on "Cancel" in w_change_scrap_handling_type
			li_rc = 0 //Just bail out...exit
		End If
	End If //Alex Gerlants. Scrap Credit
End If
//Alex Gerlants. Scrap Credit. End

if li_rc  =  1 then
	  SELECT CUSTOMER_ORDER.ORIG_CUSTOMER_ID INTO :ll_customer_id
	  FROM CUSTOMER_ORDER, ORDER_ITEM, AB_JOB
	  WHERE CUSTOMER_ORDER.ORDER_ABC_NUM = ORDER_ITEM.ORDER_ABC_NUM
	  AND ORDER_ITEM.ORDER_ABC_NUM = AB_JOB.ORDER_ABC_NUM
	  AND ORDER_ITEM.ORDER_ITEM_NUM = AB_JOB.ORDER_ITEM_NUM
	  AND AB_JOB.AB_JOB_NUM = :il_current_job_num
	  USING SQLCA;
	  
	  //Alex Gerlants. Scrap_Credit. Added ", scrap_handling_type = :ls_scrap_handling_type"
	  UPDATE "SCRAP_SKID"  
     SET "CUSTOMER_ID" = :ll_customer_id, scrap_handling_type = :ls_scrap_handling_type 
     WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" =  :ll_scrap_skid_num  
	  Using SQLCA;
	  IF SQLCA.SQLCode = -1 THEN 
	        MessageBox("SQL error", SQLCA.SQLErrText)
			  rollback using SQLCA;
	  END IF
	  commit using SQLCA;
	  tab_skids.tabpage_scrap.dw_scrap_list.Retrieve(il_current_job_num)
	  tab_skids.tabpage_scrap_credit.dw_scrap_credit.Retrieve(il_current_job_num)
else
	return 0
end if	

RETURN ll_row
end event

type cb_print_scrap_credit from u_cb within tabpage_scrap_credit
integer x = 1947
integer y = 1212
integer taborder = 11
string text = "&Print"
end type

event clicked;call super::clicked;tab_skids.tabpage_scrap_credit.dw_scrap_credit.Event pfc_print()
end event

type dw_scrap_credit from u_dw within tabpage_scrap_credit
integer x = 9
integer y = 20
integer width = 3506
integer height = 1084
integer taborder = 11
string dataobject = "d_office_entry_scrap_credit_list"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

//this.SetFilter("skid_scrap_status <> 6")
//this.Filter()

end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = tab_skids.tabpage_scrap_credit.dw_scrap_credit.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rbuttondown;call super::rbuttondown;//Override
RETURN 0
end event

event rbuttonup;call super::rbuttonup;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

type tabpage_qa_skid from userobject within tab_skids
integer x = 18
integer y = 104
integer width = 4425
integer height = 1384
long backcolor = 79741120
string text = "QA Skid"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_3 cb_3
cb_add_group cb_add_group
cb_2 cb_2
cb_1 cb_1
dw_report_attached dw_report_attached
cb_attach_report_2email cb_attach_report_2email
st_rows st_rows
cb_report cb_report
dw_coils_4job dw_coils_4job
st_1 st_1
cb_retrieve_defect cb_retrieve_defect
cb_delete_defect cb_delete_defect
cb_qa_save cb_qa_save
cb_add_defect cb_add_defect
dw_qa_customer_quality_skid dw_qa_customer_quality_skid
st_17 st_17
cb_clear cb_clear
cb_delete_email cb_delete_email
cb_add_email cb_add_email
dw_qa_email_address dw_qa_email_address
cb_clear_attached_files cb_clear_attached_files
st_16 st_16
dw_attached_file_name dw_attached_file_name
st_15 st_15
sle_email_address_from sle_email_address_from
st_email_from st_email_from
mle_email_body mle_email_body
st_13 st_13
sle_email_subject sle_email_subject
cb_email_files cb_email_files
cb_attach_files cb_attach_files
st_12 st_12
dw_skids_4job dw_skids_4job
r_1 r_1
end type

on tabpage_qa_skid.create
this.cb_3=create cb_3
this.cb_add_group=create cb_add_group
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_report_attached=create dw_report_attached
this.cb_attach_report_2email=create cb_attach_report_2email
this.st_rows=create st_rows
this.cb_report=create cb_report
this.dw_coils_4job=create dw_coils_4job
this.st_1=create st_1
this.cb_retrieve_defect=create cb_retrieve_defect
this.cb_delete_defect=create cb_delete_defect
this.cb_qa_save=create cb_qa_save
this.cb_add_defect=create cb_add_defect
this.dw_qa_customer_quality_skid=create dw_qa_customer_quality_skid
this.st_17=create st_17
this.cb_clear=create cb_clear
this.cb_delete_email=create cb_delete_email
this.cb_add_email=create cb_add_email
this.dw_qa_email_address=create dw_qa_email_address
this.cb_clear_attached_files=create cb_clear_attached_files
this.st_16=create st_16
this.dw_attached_file_name=create dw_attached_file_name
this.st_15=create st_15
this.sle_email_address_from=create sle_email_address_from
this.st_email_from=create st_email_from
this.mle_email_body=create mle_email_body
this.st_13=create st_13
this.sle_email_subject=create sle_email_subject
this.cb_email_files=create cb_email_files
this.cb_attach_files=create cb_attach_files
this.st_12=create st_12
this.dw_skids_4job=create dw_skids_4job
this.r_1=create r_1
this.Control[]={this.cb_3,&
this.cb_add_group,&
this.cb_2,&
this.cb_1,&
this.dw_report_attached,&
this.cb_attach_report_2email,&
this.st_rows,&
this.cb_report,&
this.dw_coils_4job,&
this.st_1,&
this.cb_retrieve_defect,&
this.cb_delete_defect,&
this.cb_qa_save,&
this.cb_add_defect,&
this.dw_qa_customer_quality_skid,&
this.st_17,&
this.cb_clear,&
this.cb_delete_email,&
this.cb_add_email,&
this.dw_qa_email_address,&
this.cb_clear_attached_files,&
this.st_16,&
this.dw_attached_file_name,&
this.st_15,&
this.sle_email_address_from,&
this.st_email_from,&
this.mle_email_body,&
this.st_13,&
this.sle_email_subject,&
this.cb_email_files,&
this.cb_attach_files,&
this.st_12,&
this.dw_skids_4job,&
this.r_1}
end on

on tabpage_qa_skid.destroy
destroy(this.cb_3)
destroy(this.cb_add_group)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_report_attached)
destroy(this.cb_attach_report_2email)
destroy(this.st_rows)
destroy(this.cb_report)
destroy(this.dw_coils_4job)
destroy(this.st_1)
destroy(this.cb_retrieve_defect)
destroy(this.cb_delete_defect)
destroy(this.cb_qa_save)
destroy(this.cb_add_defect)
destroy(this.dw_qa_customer_quality_skid)
destroy(this.st_17)
destroy(this.cb_clear)
destroy(this.cb_delete_email)
destroy(this.cb_add_email)
destroy(this.dw_qa_email_address)
destroy(this.cb_clear_attached_files)
destroy(this.st_16)
destroy(this.dw_attached_file_name)
destroy(this.st_15)
destroy(this.sle_email_address_from)
destroy(this.st_email_from)
destroy(this.mle_email_body)
destroy(this.st_13)
destroy(this.sle_email_subject)
destroy(this.cb_email_files)
destroy(this.cb_attach_files)
destroy(this.st_12)
destroy(this.dw_skids_4job)
destroy(this.r_1)
end on

type cb_3 from commandbutton within tabpage_qa_skid
integer x = 2583
integer y = 908
integer width = 261
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Att.Sum"
end type

event clicked;//Integer	li_selected_row
//String	ls_coil_org_num
Long		ll_ab_job_num

//li_selected_row = tab_skids.tabpage_qa_skid.dw_coils_4job.GetSelectedRow(0)
//
//If li_selected_row <= 0 Then
//	ls_coil_org_num = ""
//Else //li_selected_row > 0
//	ls_coil_org_num = tab_skids.tabpage_qa_skid.dw_coils_4job.Object.coil_org_num[li_selected_row]
//End If

ll_ab_job_num = Long(st_title#.Text)

wf_attach_summary_2email(ll_ab_job_num)
end event

type cb_add_group from commandbutton within tabpage_qa_skid
integer x = 2706
integer y = 488
integer width = 320
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add Group"
end type

event clicked;Integer					li_1, li_rows, li_row, li_insertedrow
DataWindow				ldw_qa_email_group_detail
str_all_data_types	lstr_all_data_types
String					ls_email_address

Open(w_qa_email_group)

lstr_all_data_types = Message.PowerObjectParm

li_rows = UpperBound(lstr_all_data_types.string_var[])

For li_row = 1 To li_rows
	ls_email_address = lstr_all_data_types.string_var[li_row]
	li_insertedrow = dw_qa_email_address.InsertRow(0)
	
	IF li_insertedrow > 0 Then
		dw_qa_email_address.Object.email_address[li_insertedrow] = ls_email_address
		dw_qa_email_address.SetItemStatus(li_insertedrow, 0, Primary!, NotModified!)
	End If
Next
end event

type cb_2 from commandbutton within tabpage_qa_skid
integer x = 3319
integer width = 485
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Email Groups"
end type

event clicked;Open(w_qa_email_group)
end event

type cb_1 from commandbutton within tabpage_qa_skid
integer x = 3150
integer y = 908
integer width = 261
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete Att"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Long		ll_row_selected
String	ls_filename, ls_files_2delete[]

ll_row_selected = dw_attached_file_name.GetSelectedRow(0)

If ll_row_selected > 0 Then
	ls_filename = dw_attached_file_name.Object.attached_file_name[ll_row_selected]
	ls_files_2delete[UpperBound(ls_files_2delete[]) + 1] = ls_filename
	wf_email_files_cleanup(ls_files_2delete[])
	
	dw_attached_file_name.DeleteRow(ll_row_selected)
	dw_attached_file_name.ResetUpdate()
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type dw_report_attached from datawindow within tabpage_qa_skid
integer x = 4105
integer y = 1212
integer width = 283
integer height = 156
integer taborder = 50
string title = "none"
string dataobject = "d_qa_skid_report_excel"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_attach_report_2email from commandbutton within tabpage_qa_skid
integer x = 2295
integer y = 908
integer width = 261
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Att.Rpt"
end type

event clicked;Integer	li_selected_row
String	ls_coil_org_num

li_selected_row = tab_skids.tabpage_qa_skid.dw_coils_4job.GetSelectedRow(0)

If li_selected_row <= 0 Then
	ls_coil_org_num = ""
Else //li_selected_row > 0
	ls_coil_org_num = tab_skids.tabpage_qa_skid.dw_coils_4job.Object.coil_org_num[li_selected_row]
End If

wf_attach_report_2email(ls_coil_org_num)
end event

type st_rows from statictext within tabpage_qa_skid
integer x = 3365
integer y = 20
integer width = 1051
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_report from commandbutton within tabpage_qa_skid
integer x = 2811
integer width = 485
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "QA Report"
end type

event clicked;If dw_skids_4job.RowCount() > 0 Then
	OpenSheetWithParm(w_qa_skid_report, il_current_job_num, gnv_app.of_getframe(), 0, Original!)
Else
	MessageBox("Cannot open report", "Job " + String(il_current_job_num) + " has no sheet skids~n~rCannot open report", StopSign!)
End If
end event

type dw_coils_4job from datawindow within tabpage_qa_skid
integer y = 84
integer width = 379
integer height = 396
integer taborder = 40
string title = "none"
string dataobject = "d_dddw_coils_4job"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Long	ll_coil_abc_num

//Allow user to select one row only
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
		ll_coil_abc_num = -99
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
		ll_coil_abc_num = This.Object.coil_abc_num[row]
	End If
	
	wf_retrieve_skids_4job_coil(il_current_job_num, False)
End If	


end event

event constructor;This.InsertRow(0)
end event

event itemchanged;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
//tab_skids.tabpage_qa_skid.st_qa_defect.Visible = True
//tab_skids.tabpage_qa_skid.dw_qa_defect.Visible = True

//Long		ll_sheet_skid_num, ll_rows
//
//This.AcceptText()
//
//ll_sheet_skid_num = This.Object.sheet_skid_num[1]
//tab_skids.tabpage_qa_skid.cb_add_defect.Visible = True
//
////li_rows = dw_qa_customer_quality_skid.Retrieve(il_customer_id, ll_sheet_skid_num)
//ll_rows = wf_retrieve_qa_customer_quality_skid(ll_sheet_skid_num)
////
////If ll_rows <= 0 Then
////	wf_insert_qa_customer_quality_skid(ll_sheet_skid_num)
////End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type st_1 from statictext within tabpage_qa_skid
integer x = 5
integer y = 20
integer width = 357
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cust Coil Num"
boolean focusrectangle = false
end type

type cb_retrieve_defect from commandbutton within tabpage_qa_skid
integer x = 1783
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve Defect"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Long		ll_selected_row, ll_sheet_skid_num, ll_rows, ll_coil_abc_num
Integer	li_rtn
String	ls_skid_string, ls_sql_orig, ls_sql_add, ls_sql_new, ls_coil_org_num

String				ls_note, ls_filter_string, ls_null, ls_disp_code, ls_sql_add_attached, ls_sql_orig_attached, ls_sql_new_attached
Integer				li_disp_code, li_null
Long					ll_row_inserted, ll_rows_attached
DataWindowChild	ldwc

dw_skids_4job.AcceptText()
dw_coils_4job.AcceptText()
ls_sql_orig = dw_qa_customer_quality_skid.GetSqlSelect()
ls_sql_orig_attached = dw_report_attached.GetSqlSelect()
dw_qa_customer_quality_skid.Reset() //Clear data

ls_sql_add = 	"~n~rwhere qa_customer_quality_skid.customer_id = " + String(il_customer_id) + "~n~rand ab_job_num = " + String(il_current_job_num)

ll_selected_row = dw_skids_4job.GetSelectedRow(0) //Get first selected row

If ll_selected_row > 0 Then
	Do While ll_selected_row > 0
		ll_sheet_skid_num = dw_skids_4job.Object.sheet_skid_num[ll_selected_row]
		ls_skid_string = ls_skid_string + String(ll_sheet_skid_num) + ", "
		ll_selected_row = dw_skids_4job.GetSelectedRow(ll_selected_row) //Start after ll_selected_row
	Loop
	
	//Remove the last row
	ls_skid_string = Left(ls_skid_string, Len(ls_skid_string) - 2)
	is_skid_string = ls_skid_string
	
	ls_sql_add = ls_sql_add +	"~n~rand qa_customer_quality_skid.sheet_skid_num in (" + ls_skid_string + ")"
End If

ll_selected_row = dw_coils_4job.GetSelectedRow(0) //Get first selected row

If ll_selected_row > 0 Then
	Do While ll_selected_row > 0
		//ls_coil_org_num = dw_coils_4job.Object.coil_org_num[ll_selected_row]
		ll_coil_abc_num = dw_coils_4job.Object.coil_abc_num[ll_selected_row]
		
		//If Len(ls_sql_add) > 0 Then
			ls_sql_add = ls_sql_add + "~n~rand qa_customer_quality_skid.coil_abc_num = " + String(ll_coil_abc_num)
		//Else //Len(ls_sql_add) <= 0
		//	ls_sql_add = "~n~rwhere coil_abc_num = " + String(ll_coil_abc_num)
		//End If
		
		ll_selected_row = dw_coils_4job.GetSelectedRow(ll_selected_row) //Get next selected row after ll_selected_row
	Loop
End If

If Len(ls_sql_add) > 0 Then
	ls_sql_add_attached = ls_sql_add + "~n~rorder by qa_customer_quality_skid.customer_id, qa_customer_quality_skid.ab_job_num, coil.coil_org_num, qa_customer_quality_skid.sheet_skid_num"
	ls_sql_add = ls_sql_add + "~n~rorder by sheet_skid_num, defect_code"
End If

ls_sql_new = ls_sql_orig + ls_sql_add
li_rtn = dw_qa_customer_quality_skid.SetSqlSelect(ls_sql_new)

ls_sql_new_attached = ls_sql_orig_attached + ls_sql_add_attached
li_rtn = dw_report_attached.SetSqlSelect(ls_sql_new_attached)
ll_rows = dw_report_attached.Retrieve()

ll_rows = dw_qa_customer_quality_skid.Retrieve()

st_rows.Text = String(ll_rows) + " rows retrieved"

If ll_rows < 0 Then //DB error
	//
End If

If ll_rows > 0 Then
	SetNull(li_null)
	SetNull(ls_null)
	
	ls_note = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.Object.note[1]
	//tab_skids.tabpage_qa_skid.mle_email_body.Text = ls_note
	
	//Filter cust_disp_code for il_customer_id
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetChild("cust_disp_code", ldwc)

	If li_rtn = 1 Then
		ls_filter_string = "customer_id = " + String(il_customer_id)
		ldwc.SetFilter(ls_filter_string)
		ldwc.Filter()
		ll_rows = ldwc.RowCount() //Recount after Filter()
		
		If ll_rows > 0 Then
			li_disp_code = ldwc.GetItemNumber(1, "disp_code")
			
			If Not IsNull(li_disp_code) Then
				ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
				
				If ll_row_inserted > 0 Then
					ldwc.SetItem(ll_row_inserted, "customer_id", il_customer_id)
					ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
					ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
				End If
			End If
		End If
	End If
	
	li_rtn = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetChild("albl_disp_code", ldwc)

	If li_rtn = 1 Then
		ldwc.SetTransObject(sqlca)
		ll_rows = ldwc.Retrieve()
		
		If ll_rows > 0 Then
			ls_disp_code = ldwc.GetItemString(1, "disp_code")
			
			If Not IsNull(ls_disp_code) Then
				ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
				
				If ll_row_inserted > 0 Then
					ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
					ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
				End If
			End If
		End If
	End If
End If

//Restore original SQL
dw_qa_customer_quality_skid.SetSqlSelect(ls_sql_orig)
dw_report_attached.SetSqlSelect(ls_sql_orig_attached)
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type cb_delete_defect from commandbutton within tabpage_qa_skid
integer x = 1271
integer width = 485
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete Defect"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Long ll_selected_row

ll_selected_row = tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.GetSelectedRow(0)

If ll_selected_row > 0 Then
	tab_skids.tabpage_qa_skid.dw_qa_customer_quality_skid.DeleteRow(ll_selected_row)
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type cb_qa_save from commandbutton within tabpage_qa_skid
integer x = 2299
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save QA"
end type

event clicked;Long						ll_customer_id, ll_coil_abc_num, ll_sheet_skid_num, ll_skids[], ll_rows, ll_row, ll_selected_row
Integer					li_defect_code, li_albl_disp_code, li_cust_disp_code, li_number_of_skids, li_i
Integer					li_row_inserted, li_rtn
DateTime					ldt_qa_record_date
String					ls_note, ls_user_id
str_all_data_types	lstr_all_data_types[]

dw_qa_customer_quality_skid.AcceptText()
dw_skids_4job.AcceptText()
ls_user_id = is_from_name

li_rtn = dw_qa_customer_quality_skid.Update()

If li_rtn = 1 Then //OK
	commit using sqlca;
	MessageBox("Success", "QA update successful")
Else	//Error
	rollback using sqlca;
	MessageBox("Failure", "QA update failed")
End If

//dw_qa_customer_quality_skid.ResetUpdate()
cb_retrieve_defect.Event Clicked()

Return

////Get selected coil
//ll_selected_row = tab_skids.Tabpage_qa_skid.dw_coils_4job.GetSelectedRow(0)
//
//If ll_selected_row > 0 Then
//	ll_coil_abc_num = tab_skids.Tabpage_qa_skid.dw_coils_4job.Object.coil_abc_num[ll_selected_row]
//Else //Coil not selected
//	MessageBox("Please select", "Please select coil")
//	Return
//End If
//
//ll_selected_row = dw_skids_4job.GetSelectedRow(0) //Get first selected skid row
//
//If ll_selected_row > 0 Then
//	Do While ll_selected_row > 0
//		ll_sheet_skid_num = dw_skids_4job.Object.sheet_skid_num[ll_selected_row]
//		ll_skids[UpperBound(ll_skids[]) + 1] = ll_sheet_skid_num
//		
//		ll_rows = dw_qa_customer_quality_skid.RowCount()
//		
//		//Populate all defect data for ll_sheet_skid_num
//		For ll_row = 1 To ll_rows
//			li_defect_code = dw_qa_customer_quality_skid.Object.defect_code[ll_row]
//			li_albl_disp_code = dw_qa_customer_quality_skid.Object.albl_disp_code[ll_row]
//			li_cust_disp_code = dw_qa_customer_quality_skid.Object.cust_disp_code[ll_row]
//			ls_note = dw_qa_customer_quality_skid.Object.note[ll_row]
//
//			lstr_all_data_types[ll_row].integer_var[1] = li_defect_code
//			lstr_all_data_types[ll_row].integer_var[2] = li_albl_disp_code
//			lstr_all_data_types[ll_row].integer_var[3] = li_cust_disp_code
//			lstr_all_data_types[ll_row].string_var[1] = ls_note
//			lstr_all_data_types[ll_row].string_var[2] = ls_user_id
//		Next
//		
//		ll_selected_row = dw_skids_4job.GetSelectedRow(ll_selected_row) //Start after ll_selected_row
//	Loop
//	
//	li_rtn = wf_save_qa_customer_quality_many_skids(il_customer_id, il_current_job_num, ll_coil_abc_num, ll_skids[], lstr_all_data_types[])
//Else //No skid selected
//	MessageBox("Please select", "Please select skid(s)")
//	Return
//End If
// 
//dw_qa_customer_quality_skid.ResetUpdate()
//
////li_rtn = wf_update_qa_customer_quality_skid()
////li_rtn = wf_save_qa_customer_quality_many_skids()
end event

type cb_add_defect from commandbutton within tabpage_qa_skid
integer x = 759
integer width = 485
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add Defect"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Long						ll_sheet_skid_num, ll_selected_row_skid, ll_selected_row_coil
Long						ll_customer_id, ll_ab_job_num, ll_coil_abc_num, ll_inserted_row
String					ls_coil_org_num, ls_skid_string, ls_defect_4skids_exist, ls_defect_4skids_dont_exist
DataStore				lds_add_defect
Integer					li_rtn, li_count

ll_selected_row_skid = tab_skids.tabpage_qa_skid.dw_skids_4job.GetSelectedRow(0)
ll_selected_row_coil = tab_skids.tabpage_qa_skid.dw_coils_4job.GetSelectedRow(0)

If ll_selected_row_skid > 0 And ll_selected_row_coil > 0 Then
	lds_add_defect = Create DataStore
	lds_add_defect.DataObject = "d_add_defect"
	
	//wf_insert_qa_customer_quality_skid()
	ll_coil_abc_num = tab_skids.tabpage_qa_skid.dw_coils_4job.Object.coil_abc_num[ll_selected_row_coil]
	
			
	
	Do While ll_selected_row_skid > 0
		ll_sheet_skid_num = dw_skids_4job.Object.sheet_skid_num[ll_selected_row_skid]
		
		ll_inserted_row = lds_add_defect.InsertRow(0)
		
		If ll_inserted_row > 0 Then
			lds_add_defect.Object.customer_id[ll_inserted_row] = il_customer_id
			lds_add_defect.Object.ab_job_num[ll_inserted_row] = il_current_job_num
			lds_add_defect.Object.coil_abc_num[ll_inserted_row] = ll_coil_abc_num
			lds_add_defect.Object.sheet_skid_num[ll_inserted_row] = ll_sheet_skid_num
			
			select	count(*)
			into		:li_count
			from		qa_customer_quality_skid
			where		customer_id = :il_customer_id
			and		ab_job_num = :il_current_job_num
			and		coil_abc_num = :ll_coil_abc_num
			and		sheet_skid_num = :ll_sheet_skid_num
			using		sqlca;
			
			If li_count > 0 Then
				ls_defect_4skids_exist = ls_defect_4skids_exist + String(ll_sheet_skid_num) + ","
			Else
				ls_defect_4skids_dont_exist = ls_defect_4skids_dont_exist + String(ll_sheet_skid_num) + ","
			End If
		End If
		
		//ls_skid_string = ls_skid_string + String(ll_sheet_skid_num) + ", "
		ll_selected_row_skid = dw_skids_4job.GetSelectedRow(ll_selected_row_skid) //Start after ll_selected_row
	Loop
	
//	If Len(ls_defect_4skids_exist) > 0 And Len(ls_defect_4skids_dont_exist) > 0 Then
//		MessageBox("Defects exist for some skids", &
//				"Defects exist for the following skids: " + ls_defect_4skids_exist + &
//				"~n~rDefects do not exist for the following skids: " + ls_defect_4skids_dont_exist + &
//				"~n~rPlease use Retrieve Defect button to edit existing defects." + &
//				"~n~rPlease unselect skids with existing defects, and click on Add Defect button again.")
//				
//		Return
//	ElseIf Len(ls_defect_4skids_exist) > 0 Then
//		MessageBox("Defects exist", "Defects exists for the following skids: " + ls_defect_4skids_exist + &
//				"~n~rPlease use Retrieve Defect button to edit defects.")
//				
//		Return
//	Else //Len(ls_defect_4skids_dont_exist) > 0
//		//OK. Do nothing. Fall through
//	End If
	
	//OpenSheetWithParm(w_add_defect, lds_add_defect, gnv_app.of_getframe(), 2, Original!)
	OpenWithParm(w_add_defect, lds_add_defect)
	li_rtn = Message.DoubleParm
	
	If li_rtn = -99 Then Return //User clicked on Cancel button on w_add_defect
	
	If li_rtn = 1 Then
		cb_retrieve_defect.Event Clicked() //Retrieve defect(s) for highlighted skid(s) and coil
	End If
Else
	If ll_selected_row_skid <= 0 And ll_selected_row_coil <= 0 Then
		MessageBox("Please select", "Please select skid(s) and coil")
	ElseIf ll_selected_row_skid <= 0 Then
		MessageBox("Please select", "Please select skid(s)")
	Else
		MessageBox("Please select", "Please select coil")
	End If
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type dw_qa_customer_quality_skid from datawindow within tabpage_qa_skid
integer x = 759
integer y = 92
integer width = 3657
integer height = 388
integer taborder = 20
string title = "none"
string dataobject = "d_qa_customer_quality_skid"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;MessageBox('Database error', "Database error while updating dw_qa_customer_quality_skid" + &
					"~n~rError:~n~r" + sqlerrtext)
end event

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

event itemchanged;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
String	ls_name, ls_find_string
Long		ll_sheet_skid_num, ll_found_row
Integer	li_defect_code, li_null

SetNull(li_null)
ls_name = dwo.name

If ls_name = "defect_code" Then
	li_defect_code = Integer(data)
	ll_sheet_skid_num = This.Object.sheet_skid_num[row]
	
	ls_find_string = "defect_code = " + String(li_defect_code) + " and sheet_skid_num = " + String(ll_sheet_skid_num)
	ll_found_row = This.Find(ls_find_string, 1, This.RowCount())
	
	If ll_found_row > 0 Then //li_defect_code exists on another row for the same skid 
		MessageBox("Data error", "Defect already exists for the same skid.~n~rPlease select another defect for this skid.", StopSign!)
		This.Object.defect_code[row] = li_null
		This.AcceptText()
		Return 1 //Reject the data value and do not allow focus to change
	End If
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

event itemerror;Return 1 //Reject the data value with no message box

end event

type st_17 from statictext within tabpage_qa_skid
integer x = 1947
integer y = 524
integer width = 430
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recipient~'s Emails"
boolean focusrectangle = false
end type

type cb_clear from commandbutton within tabpage_qa_skid
integer x = 3365
integer y = 488
integer width = 320
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear All"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
dw_qa_email_address.Reset()
dw_qa_email_address.ResetUpdate()
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type cb_delete_email from commandbutton within tabpage_qa_skid
integer x = 3035
integer y = 488
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete Email"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Long	ll_row_selected

ll_row_selected = dw_qa_email_address.GetSelectedRow(0)

If ll_row_selected > 0 Then
	dw_qa_email_address.DeleteRow(ll_row_selected)
	dw_qa_email_address.ResetUpdate()
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type cb_add_email from commandbutton within tabpage_qa_skid
integer x = 2373
integer y = 488
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add Email"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Long	ll_row_added

ll_row_added = dw_qa_email_address.InsertRow(1) //Add a row before row 1
dw_qa_email_address.ResetUpdate()
dw_qa_email_address.SetFocus()
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type dw_qa_email_address from datawindow within tabpage_qa_skid
integer x = 1952
integer y = 584
integer width = 1746
integer height = 304
integer taborder = 20
string title = "none"
string dataobject = "d_qa_email_address"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type cb_clear_attached_files from commandbutton within tabpage_qa_skid
integer x = 3429
integer y = 908
integer width = 261
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear All"
end type

event clicked;//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. Begin
Integer 	li_row, li_rows
String	ls_filename, ls_files_2delete[]

li_rows = tab_skids.tabpage_qa_skid.dw_attached_file_name.RowCount()

If li_rows > 0 Then
	//Collect file names to delete from C:\temp
	For li_row = 1 To li_rows
		ls_filename = dw_attached_file_name.Object.attached_file_name[li_row]
		ls_files_2delete[UpperBound(ls_files_2delete[]) + 1] = ls_filename
		//FileDelete(ls_filename)
	Next
	
	wf_email_files_cleanup(ls_files_2delete[])
End If
//Alex_Gerlants. 01/30/2023. 1797_Skid_Summary_Recap_Report. End

dw_attached_file_name.Reset() //Alex_Gerlants. 1260_Incoming_Customer_Quality
dw_attached_file_name.ResetUpdate()
end event

type st_16 from statictext within tabpage_qa_skid
integer x = 1957
integer y = 952
integer width = 347
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Attached Files"
boolean focusrectangle = false
end type

type dw_attached_file_name from datawindow within tabpage_qa_skid
integer x = 1952
integer y = 1008
integer width = 1746
integer height = 380
integer taborder = 60
string title = "none"
string dataobject = "d_attached_file_name"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type st_15 from statictext within tabpage_qa_skid
integer x = 18
integer y = 952
integer width = 347
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Email Body"
boolean focusrectangle = false
end type

type sle_email_address_from from singlelineedit within tabpage_qa_skid
integer x = 14
integer y = 584
integer width = 1024
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_email_from from statictext within tabpage_qa_skid
integer x = 14
integer y = 528
integer width = 361
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sender~'s Email"
boolean focusrectangle = false
end type

type mle_email_body from multilineedit within tabpage_qa_skid
integer x = 18
integer y = 1008
integer width = 1874
integer height = 380
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

event modified;//MessageBox("", "Modified event for tab_skids.tabpage_qa_slids.mle_email_body")
end event

type st_13 from statictext within tabpage_qa_skid
integer x = 14
integer y = 728
integer width = 347
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Email Subject"
boolean focusrectangle = false
end type

type sle_email_subject from singlelineedit within tabpage_qa_skid
integer x = 14
integer y = 788
integer width = 1861
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_email_files from commandbutton within tabpage_qa_skid
integer x = 3831
integer y = 796
integer width = 466
integer height = 300
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Send Email"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Boolean	lb_rtn
String	ls_email_from, ls_email_to, ls_subject, ls_body, ls_attached_file_name[], ls_filename
Integer	li_rows, li_row, li_rtn

SetPointer(HourGlass!)

dw_qa_email_address.AcceptText()
dw_qa_email_address.ResetUpdate()

dw_attached_file_name.AcceptText()

ls_email_from = tab_skids.tabpage_qa_skid.sle_email_address_from.Text
//ls_email_to = tab_skids.tabpage_qa_skid.sle_email_address_to.Text
ls_subject = tab_skids.tabpage_qa_skid.sle_email_subject.Text
ls_body = tab_skids.tabpage_qa_skid.mle_email_body.Text

li_rows = dw_attached_file_name.RowCount()

If li_rows > 0 Then
	For li_row = 1 To li_rows
		ls_filename = dw_attached_file_name.Object.attached_file_name[li_row]
		ls_attached_file_name[UpperBound(ls_attached_file_name[]) + 1] = ls_filename
	Next
	
	li_rows = dw_qa_email_address.RowCount()
	
	If li_rows > 0 Then
		For li_row = 1 To li_rows
			ls_email_to = dw_qa_email_address.Object.email_address[li_row]
			lb_rtn = wf_send_smtp_email(ls_email_from, ls_email_to, ls_subject, ls_body, ls_attached_file_name[])
		Next
		
		If lb_rtn Then
			MessageBox("SendMail", "Mail(s) successfully sent!")
		Else
			MessageBox("SendMail Error", in_smtp.of_GetLastError())
		End If
	End If
Else
	MessageBox("No files to send", "Please attach files to your email")
End If

SetPointer(Arrow!)

//li_rtn = wf_update_qa_customer_quality_skid()
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type cb_attach_files from commandbutton within tabpage_qa_skid
integer x = 2862
integer y = 908
integer width = 261
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Att.Files"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
String	ls_pathname
String	ls_files_selected[]
String	ls_filter, ls_file_string, ls_temp
Integer	li_rtn, li_file_count, li_i, li_rc
Long		ll_row_inserted

pointer oldpointer // Declares a pointer variable

//oldpointer = SetPointer(HourGlass!)
//
//
//
//SetPointer(oldpointer)

//MessageBox( is_folder_base , is_scan_base )
//"PDF files, *.PDF, Picture files, *.BMP"

ls_filter = "All Files (*.*),*.*"
//ls_filter = "All supported files (*.bmp;*.gif;*.jpg;*.jpeg;*.pdf;*.doc;*.eml;*.wav;*.msg;*.avi;*.mov;*.xls;*.xlsx;*.txt)"
//ls_filter = 	"MS Excel Files (*.XLS),*.XLS," + &
//					"MS Excel Files (*.XLSX),*.XLSX," + &
//					"Picture Files (*.BMP),*.BMP," + &
//					"Picture Files (*.JPG),*.JPG," + &
//					"Picture Files (*.JIF),*.JIF," + &
//					"Picture Files (*.JPEG),*.JPEG," + &
//					"PDF Files (*.PDF),*.PDF," + &
//					"Text Files (*.TXT),*.TXT," + &
//					"Doc Files (*.DOC),*.DOC"

li_rtn = GetFileOpenName("Select files to email", ls_pathname, ls_files_selected[], "", ls_filter)

//If there is only one file attached, ls_pathname has path\file.
//If there is more than one file attached, ls_pathname has path, and we have to add "\", and a file from ls_files_selected[]

If li_rtn = 1 Then
	//If Right(ls_pathname, 1) <> "\" Then ls_pathname = ls_pathname + "\"
	li_file_count = Upperbound(ls_files_selected[])
	
	If li_file_count > 0 Then
		If li_file_count = 1 Then
			ll_row_inserted = dw_attached_file_name.InsertRow(0)
				
			If ll_row_inserted > 0 Then
				dw_attached_file_name.Object.attached_file_name[ll_row_inserted] = ls_pathname //ls_pathname has path\file
			End If
		Else //li_file_count > 1
			If Right(ls_pathname, 1) <> "\" Then ls_pathname = ls_pathname + "\"
			
			For li_i = 1 To li_file_count
				
				ls_files_selected[li_i] = ls_pathname + ls_files_selected[li_i]
				
				//Populate is_attached_file_name[] here
				//is_attached_file_name[UpperBound(is_attached_file_name[]) + 1] = ls_pathname + ls_files_selected[li_i]
				
				ll_row_inserted = dw_attached_file_name.InsertRow(0)
				
				If ll_row_inserted > 0 Then
					dw_attached_file_name.Object.attached_file_name[ll_row_inserted] = ls_files_selected[li_i]
				End If

			Next
		End If
	End If
End If

SetPointer(oldpointer)
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type st_12 from statictext within tabpage_qa_skid
integer x = 411
integer y = 20
integer width = 311
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Skids for Job"
boolean focusrectangle = false
end type

type dw_skids_4job from datawindow within tabpage_qa_skid
integer x = 416
integer y = 84
integer width = 302
integer height = 396
integer taborder = 30
string title = "none"
string dataobject = "d_dddw_skids_4job_coil"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

event itemchanged;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
//tab_skids.tabpage_qa_skid.st_qa_defect.Visible = True
//tab_skids.tabpage_qa_skid.dw_qa_defect.Visible = True

//Long		ll_sheet_skid_num, ll_rows
//
//This.AcceptText()
//
//ll_sheet_skid_num = This.Object.sheet_skid_num[1]
//tab_skids.tabpage_qa_skid.cb_add_defect.Visible = True
//
////li_rows = dw_qa_customer_quality_skid.Retrieve(il_customer_id, ll_sheet_skid_num)
//ll_rows = wf_retrieve_qa_customer_quality_skid(ll_sheet_skid_num)
////
////If ll_rows <= 0 Then
////	wf_insert_qa_customer_quality_skid(ll_sheet_skid_num)
////End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

event clicked;String 	ls_old_sort, ls_column, ls_name
//String	ls_name_temp, ls_coltype
Char 		lc_sort
Long		ll_Col, ll_calendar_x
Boolean	lb_dttm_column_clicked

ls_name = dwo.Name

///* Check whether the user clicks on the column header */
//If Right(ls_name, 2) = '_t' Then
//	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)
//
//	/* Get old sort, If any. */
//	ls_old_sort = This.Describe("Datawindow.Table.sort")
//
//	//Check whether previously sorted column and currently clicked column are same or not. 
//	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
//	//If both are not same, simply sort it by Ascending order.
//	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
//		lc_sort = Right(ls_old_sort, 1)
//
//		If lc_sort = 'A' Then
//			lc_sort = 'D'
//		Else
//			lc_sort = 'A'
//		End If
//		  
//		This.SetSort(ls_column + " " + lc_sort)
//	Else
//		This.SetSort(ls_column + " A")
//	End If
//
//	This.Sort()
//End If

//---

If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If	


end event

type r_1 from rectangle within tabpage_qa_skid
long linecolor = 255
integer linethickness = 8
long fillcolor = 255
integer x = 3749
integer y = 716
integer width = 626
integer height = 448
end type

type dw_prod_order_detail from u_dw within w_office_skid_entry
integer x = 869
integer y = 4
integer width = 2706
integer height = 156
integer taborder = 0
string dataobject = "d_office_entry_job_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_current_job_num)
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event constructor;call super::constructor;of_SetTransObject(sqlca) 
end event

type cb_close from u_cb within w_office_skid_entry
integer x = 3205
integer y = 1732
integer width = 370
integer height = 80
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_title1 from u_st within w_office_skid_entry
integer x = 27
integer width = 805
integer height = 60
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Production Order Number"
alignment alignment = center!
boolean border = true
end type

type st_title# from u_st within w_office_skid_entry
integer x = 27
integer y = 60
integer width = 805
integer height = 100
boolean bringtotop = true
integer textsize = -18
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "100001"
alignment alignment = center!
boolean border = true
end type

type dw_coil_status from u_dw within w_office_skid_entry
integer x = 2971
integer y = 1732
integer width = 41
integer height = 36
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_coil_skid_entry_status"
end type

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

