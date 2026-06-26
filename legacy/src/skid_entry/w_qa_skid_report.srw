$PBExportHeader$w_qa_skid_report.srw
forward
global type w_qa_skid_report from w_sheet
end type
type st_4 from statictext within w_qa_skid_report
end type
type cbx_lot_num from checkbox within w_qa_skid_report
end type
type st_6 from statictext within w_qa_skid_report
end type
type cb_getsize from commandbutton within w_qa_skid_report
end type
type st_enduser_part from statictext within w_qa_skid_report
end type
type st_customer from statictext within w_qa_skid_report
end type
type st_5 from statictext within w_qa_skid_report
end type
type st_coil_lot from statictext within w_qa_skid_report
end type
type cb_get from commandbutton within w_qa_skid_report
end type
type dw_skids_4job from datawindow within w_qa_skid_report
end type
type st_1 from statictext within w_qa_skid_report
end type
type cbx_all_dates from checkbox within w_qa_skid_report
end type
type dw_coils_4job from datawindow within w_qa_skid_report
end type
type st_3 from statictext within w_qa_skid_report
end type
type dw_job_qa from datawindow within w_qa_skid_report
end type
type st_2 from statictext within w_qa_skid_report
end type
type dw_enduser_part_num_4job from datawindow within w_qa_skid_report
end type
type cb_export from u_cb within w_qa_skid_report
end type
type dw_rebanded_list from datawindow within w_qa_skid_report
end type
type dw_rejcoil_list from datawindow within w_qa_skid_report
end type
type st_rowcount from statictext within w_qa_skid_report
end type
type cb_1 from commandbutton within w_qa_skid_report
end type
type st_all_dates from statictext within w_qa_skid_report
end type
type cb_retrieve from commandbutton within w_qa_skid_report
end type
type em_from from editmask within w_qa_skid_report
end type
type em_to from editmask within w_qa_skid_report
end type
type st_from from statictext within w_qa_skid_report
end type
type st_to from statictext within w_qa_skid_report
end type
type dw_report from u_dw within w_qa_skid_report
end type
type cb_close from u_cb within w_qa_skid_report
end type
type cb_print from u_cb within w_qa_skid_report
end type
type dw_coil_lots_4job from datawindow within w_qa_skid_report
end type
end forward

global type w_qa_skid_report from w_sheet
integer width = 5756
integer height = 2717
string title = "Customer Quality Report"
event type string ue_whoami ( )
st_4 st_4
cbx_lot_num cbx_lot_num
st_6 st_6
cb_getsize cb_getsize
st_enduser_part st_enduser_part
st_customer st_customer
st_5 st_5
st_coil_lot st_coil_lot
cb_get cb_get
dw_skids_4job dw_skids_4job
st_1 st_1
cbx_all_dates cbx_all_dates
dw_coils_4job dw_coils_4job
st_3 st_3
dw_job_qa dw_job_qa
st_2 st_2
dw_enduser_part_num_4job dw_enduser_part_num_4job
cb_export cb_export
dw_rebanded_list dw_rebanded_list
dw_rejcoil_list dw_rejcoil_list
st_rowcount st_rowcount
cb_1 cb_1
st_all_dates st_all_dates
cb_retrieve cb_retrieve
em_from em_from
em_to em_to
st_from st_from
st_to st_to
dw_report dw_report
cb_close cb_close
cb_print cb_print
dw_coil_lots_4job dw_coil_lots_4job
end type
global w_qa_skid_report w_qa_skid_report

type variables
String	is_add_2sql_prev_month

String	is_sql_orig
String	is_date_from_to

String	is_run_date_t, is_date_range_head_t, is_process_date_head_t, is_customer_head_t, is_handling_codes_head_t
String	is_coil_num_head_t, is_material_num_head_t, is_payoff_direction_head_t, is_flaw_reason_head_t
String	is_enduser_part_num_head_t, is_ab_job_num_head_t, is_customer_name_head_t
String	is_handling_code_arg_save, is_flaw_reason_arg_save, is_date_from, is_date_to, is_customer_name, is_coil_or_lot, is_coil_or_lot_head_t, is_skids, is_skids_head_t
Long		il_customer_id, il_ab_job_num
Boolean	ib_ok_2report
end variables

forward prototypes
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
public subroutine wf_add_2sql (long al_die_id, datetime adt_date_from, datetime adt_date_to)
public function long wf_rejected_coil_wt (long al_job, long al_coil_num)
public subroutine wf_set_display_values (long al_job, long al_row)
public function integer wf_calc_prev_month ()
public function integer wf_retrieve_data_4job (long al_ab_job_num)
public function integer wf_get_customer_name_4job (long al_ab_job_num)
public function integer wf_get_enduser_part_4job (long al_ab_job_num)
public function long wf_retrieve_skids_4job_coil (boolean ab_initial_retrieve)
end prototypes

event type string ue_whoami();Return "w_report_qr"
end event

public subroutine exporttoexcel (datawindow adw_dw, long al_rows);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	exporttoexcel
Returns:		none
Arguments:	value		datawindow	adw_dw
				value		long			al_rows	

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols
String		ls_range 
String		ls_sum_processed, ls_sum_scrap_net
String		ls_sum_net_wt, ls_sum_tare_wt, ls_sum_theo_wt
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder, ls_run_date
Date 			ld_today
Time 			ld_now
Integer		li_answer

//Return //Disable this function for now ...

uo_save_as_excel	luo_save_as_excel

luo_save_as_excel = Create uo_save_as_excel

ll_report_rows = adw_dw.RowCount()

If ll_report_rows <= 0 Then Return

ls_run_date = is_run_date_t

lole_OLE = Create OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

luo_save_as_excel.GetColumns( adw_DW, ls_Columns )

ll_Cols = UpperBound( ls_Columns )

FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		luo_save_as_excel.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( luo_save_as_excel.inttocolumn( 1 ) + "1:" + luo_save_as_excel.inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( luo_save_as_excel.inttocolumn( 1 ) + ":" + luo_save_as_excel.inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
lole_OLE.cells[1,1] = "Customer"
lole_OLE.cells[1,2] = "Job Number"
lole_OLE.cells[1,3] = "Job Recap Date/Time"
lole_OLE.cells[1,4] = "Part Description"
lole_OLE.cells[1,5] = "ALBL Coil Number"
lole_OLE.cells[1,6] = "Customer Coil Number"
lole_OLE.cells[1,7] = "Coil Lot"
lole_OLE.cells[1,8] = "Coil Received Date"
lole_OLE.cells[1,9] = "Sheet Skid Number"
lole_OLE.cells[1,10] = "Defect"
lole_OLE.cells[1,11] = "ALBL Defect Disposition"
lole_OLE.cells[1,12] = "Suggested Cust.Defect Disposition"
lole_OLE.cells[1,13] = "Record Date/Time"
lole_OLE.cells[1,14] = "Note"

//Insert Lines for Header & Miscellaneous Details (5 lines above columnar data)
lole_Sheet.Range("A1:N8").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

//lole_OLE.cells[1,1] = "QR Report"
//lole_Sheet.Range("A1:A1").Select
//lole_OLE.Selection.Font.Bold = True
//lole_OLE.Selection.Font.Size = 24 //Change font size
//lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,5] = is_run_date_t
lole_Sheet.Range("E1:E1").Select
lole_OLE.Selection.Font.Bold = True




//----------------------------------------------------------------------------------------------------

lole_OLE.cells[2,1] = is_customer_name_head_t
lole_Sheet.Range("A2:A2").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[3,1] = is_date_range_head_t
lole_Sheet.Range("A3:A3").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[4,1] = "Job: " + is_ab_job_num_head_t
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[5,1] = is_coil_or_lot_head_t
lole_Sheet.Range("A5:A5").Select
lole_OLE.Selection.Font.Bold = True

lole_OLE.cells[6,1] = is_skids_head_t
lole_Sheet.Range("A6:A6").Select
lole_OLE.Selection.Font.Bold = True

//lole_OLE.cells[7,1] = is_flaw_reason_head_t
//lole_Sheet.Range("A7:A7").Select
//lole_OLE.Selection.Font.Bold = True
//
//lole_OLE.cells[8,1] = is_handling_codes_head_t
//lole_Sheet.Range("A8:A8").Select
//lole_OLE.Selection.Font.Bold = True

//---

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

//Delete extra columns	
lole_Sheet.Columns("O:P").Select
lole_OLE.Selection.Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:P" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

//lole_Sheet.Range("F4:F" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
//
//lole_Sheet.Range("G4:H" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//
//lole_Sheet.Range("I4:K" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
//
//lole_Sheet.Range("L4:L" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

//Change date format for a column
lole_Sheet.Range("H9:H" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

lole_Sheet.Range("M9:M" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.NumberFormat = "mm/dd/yyyy hh:mm:ss"

//Change number format for a column
//lole_Sheet.Range("H9:I" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.NumberFormat = "###,###,###.###"

//lole_Sheet.Range("E9:E" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.NumberFormat = "###,###,###.00"

//Underline column headers
lole_Sheet.Range("A9:L9").Select
lole_OLE.Selection.Font.Underline = True

////Underline the 3 totals columns
//lole_OLE.Application.range ("E" + String(ll_report_rows + 9) + ":G" + String(ll_report_rows + 9)).borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.ColumnWidth = 24.3

lole_Sheet.Range("B4:B4").Select
lole_OLE.Selection.ColumnWidth = 10.7

lole_Sheet.Range("C4:C4").Select
lole_OLE.Selection.ColumnWidth = 19.7

lole_Sheet.Range("D4:D4").Select
lole_OLE.Selection.ColumnWidth = 26.4

lole_Sheet.Range("E4:E4").Select
lole_OLE.Selection.ColumnWidth = 18.3

lole_Sheet.Range("F4:F4").Select
lole_OLE.Selection.ColumnWidth = 20.9

lole_Sheet.Range("G4:G4").Select
lole_OLE.Selection.ColumnWidth = 10.5

lole_Sheet.Range("H4:H4").Select
lole_OLE.Selection.ColumnWidth = 18.5

lole_Sheet.Range("I4:I4").Select
lole_OLE.Selection.ColumnWidth = 18.0

lole_Sheet.Range("J4:K4").Select
lole_OLE.Selection.ColumnWidth = 30.9

lole_Sheet.Range("K4:K4").Select
lole_OLE.Selection.ColumnWidth = 30.9

lole_Sheet.Range("L4:L4").Select
lole_OLE.Selection.ColumnWidth = 34.1

lole_Sheet.Range("M4:M4").Select
lole_OLE.Selection.ColumnWidth = 30.9

lole_Sheet.Range("N4:N4").Select
lole_OLE.Selection.ColumnWidth = 30.9

//---

lole_OLE.cells[1,1] = "Customer Quality Report"
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

//---

ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "QR Report" + "_" + ls_today + ls_now + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

lole_sheet.SaveAs(ls_file, Excel8!)

//Open the worksheet for user to veiw
li_answer = MessageBox("Open Worksheet?", "Would you like to open worksheet " + ls_file + "?", Question!, YesNo!, 1)

If li_answer = 1 Then //Yes
	lole_OLE.Application.Visible = True
Else
	lole_OLE.Application.Visible = False
End If
	
lole_OLE.DisconnectObject()
DESTROY lole_OLE
//Alex Gerlants. 05/02/2016. End
end subroutine

public subroutine wf_add_2sql (long al_die_id, datetime adt_date_from, datetime adt_date_to);/*
Function:	wf_add_2sql
Returns:		none
Arguments:	value		long		al_die_id
				value		datetime	adt_date_from
				value		datetime	adt_date_to
				
where ab_job.time_date_finished between to_date( '08/20/2016 00:00:00', 'mm/dd/yyyy hh24:mi:ss' ) and to_date( '08/24/2016 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )

*/

String		ls_add_2sql_die, ls_die_id, ls_die_id_string
String		ls_sql, ls_sql_1, ls_sql_2, ls_sql_new
String		ls_date_from, ls_date_to
String		ls_sql_dates_from, ls_sql_dates_to, ls_add_2sql_dates_where
Long			ll_die_id, ll_rows, ll_row, ll_pos_group_by
Integer		li_rtn
DataStore	lds_die_by_name

li_rtn = dw_report.SetSqlSelect(is_sql_orig) //To start, restore the original SQL

ls_date_from = String(adt_date_from, "mm/dd/yyyy")
ls_date_to = String(adt_date_to, "mm/dd/yyyy")

ls_add_2sql_dates_where = " where order_item.theoretical_unit_wt > 0 and dbo.f_get_die_id(ab_job.ab_job_num) is not null " + &
							" and ab_job.job_status = 0 " + &
							" and ab_job.time_date_finished between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
							" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "

//ls_add_2sql_dates_where = ls_add_2sql_dates_where + " and dbo.f_get_die_name_ab_job(ab_job.ab_job_num) is not null and dbo.f_get_die_name_ab_job(ab_job.ab_job_num) <> ' ' "

ls_sql = dw_report.GetSqlSelect()

If ls_sql <> "" Then
	ll_pos_group_by = Pos(ls_sql, "group by", 1)
	
	If ll_pos_group_by > 0 Then
		ls_sql_1 = Mid(ls_sql, 1, ll_pos_group_by - 1) + "  "
		ls_sql_2 = "  " + Mid(ls_sql, ll_pos_group_by, Len(ls_sql))
	End If
End If

If al_die_id <= 0 Then //All dies
	//Add date arguments only
	ls_sql_new = ls_sql_1 + ls_add_2sql_dates_where + ls_sql_2
Else //al_die_id > 0 <== One die selected
	ls_add_2sql_die = "  and dbo.f_get_die_id(ab_job.ab_job_num) = " + String(al_die_id)
	ls_sql_new = ls_sql_1 + ls_add_2sql_dates_where + ls_add_2sql_die + ls_sql_2
End If

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

end subroutine

public function long wf_rejected_coil_wt (long al_job, long al_coil_num);/*
Function:	wf_rejected_coil_wt
Returns:		long
Arguments:	value	long	al_job
				value	long	al_col_num
*/

Long ll_wt1, ll_wt2, ll_wt, ll_shift_end_wt

CONNECT USING SQLCA;

SELECT process_quantity, process_end_wt INTO :ll_wt, :ll_shift_end_wt
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (ab_job_num = :al_job)
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

public subroutine wf_set_display_values (long al_job, long al_row);///*
//Function:	wf_set_display_values
//Returns:		none
//Arguments:	value	long	al_jobString
//				value	long	al_row
//*/
//
//String	ls_modstring, ls_processed_wt, ls_scrap_net
//Long 		ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_rejnet, ll_t, ll_l1, ll_l2
//Long		ll_rebandedwt, ll_unprocessed_num, ll_unprocessednet
//Long		ll_rows, ll_row, ll_coil_abc_num
//
//
//ll_rows = dw_rejcoil_list.Retrieve(al_job)
//ll_rows = dw_rebanded_list.Retrieve(al_job)
//
//SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
//FROM process_coil
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
////Modified by Victor Huang in 04/05
//SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
//FROM process_coil
//WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
//USING SQLCA;
//
//ll_l = ll_unprocessed_num
//ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
//FROM process_coil
//WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
//USING SQLCA;
//
//ll_l = ll_unprocessednet
//ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//ll_l1 = dw_rejcoil_list.RowCount()
//ll_l2 = dw_rebanded_list.RowCount()
//ll_l = ll_l1 + ll_l2
//ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//ll_rejnet = 0
//
//IF ll_l1 > 0 THEN
//	FOR ll_t = 1 TO ll_l1
//		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(al_job, dw_rejcoil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
//	NEXT
//	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
//	dw_rejcoil_list.Modify(ls_modstring) 
//END IF
//ll_rebandedwt = 0
//IF ll_l2 > 0 THEN
//	FOR ll_t = 1 TO ll_l2
//		ll_rebandedwt = ll_rebandedwt + wf_rejected_coil_wt(al_job, dw_rebanded_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
//	NEXT
//	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rebandedwt, "###,###,###") + "~""
//	dw_rebanded_list.Modify(ls_modstring) 
//END IF
//ll_rejnet = ll_rejnet + ll_rebandedwt
//ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//
//SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
//FROM sheet_skid
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
//FROM return_scrap_item
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(SUM(process_quantity),0) INTO :ll_l
//FROM process_coil
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//ll_coilnet = ll_l
//
//If ll_coilnet <= 0 Then is_test = is_test + ", " + String(al_job)
//
//SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_l
//FROM production_sheet_item
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//ll_sheetnet = ll_l
//
//		SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_l
//		FROM return_scrap_item
//		WHERE ab_job_num = :al_job
//		USING SQLCA;
//		ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
//		//dw_report.Modify(ls_modstring) 
//		
//		ls_scrap_net = String(ll_l, "###,###,###")
//		dw_report.Object.scrap_net_t[al_row] = ls_scrap_net
//		
//		//il_scrap_net = il_scrap_net + ll_l //Accumulate scrap weight
//		
//		ll_scrapnet = ll_l
//
//SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
//FROM production_sheet_item
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT SUM(sheet_tare_wt) INTO :ll_l
//FROM sheet_skid
//WHERE ab_job_num = :al_job
//USING SQLCA;
//ll_l = ll_l + ll_sheetnet
//ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//SELECT NVL(SUM(scrap_tare_wt),0) INTO :ll_l
//FROM scrap_skid
//WHERE scrap_ab_job_num = :al_job
//USING SQLCA;
//ll_l = ll_l + ll_scrapnet
//ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
////dw_report.Modify(ls_modstring) 
//
//
//ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet 
//ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
////dw_report.Modify(ls_modstring) 
////ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
////dw_report.Modify(ls_modstring) 
//
//		//BEGIN Modified by Victor Huang in 04/06
//		ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
//		dw_report.Modify(ls_modstring)
//		
//		ls_processed_wt = String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###")
//		dw_report.Object.processed_t[al_row] = ls_processed_wt
//		
//		//il_sum_processed = il_sum_processed + ll_coilnet - ll_unprocessednet - ll_rejnet //Accumulate total processed weight
//		
//		//If al_job = 98504 Then
//		//	MessageBox("", "ab_job_num = " + String(al_job) + &
//		//						"~n~rll_coilnet = " + String(ll_coilnet) + &
//		//						"~n~rll_unprocessednet = " + String(ll_unprocessednet) + &
//		//						"~n~rll_rejnet = " + String(ll_rejnet) + &
//		//						"~n~ril_sum_processed = " + String(il_sum_processed))
//		//End If
//		
//		//END Modified by Victor Huang in 04/06
//
//dw_report.SetItemStatus(al_row, 0, Primary!, NotModified!)
end subroutine

public function integer wf_calc_prev_month ();//Alex Gerlants. QR_Report. Begin
/*
Function:	wf_calc_prev_month
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]							
*/

Integer					li_rtn = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_date_from, ld_date_to
String					ls_today, ls_month, ls_day, ls_year, ls_month_2select, ls_year_2select
String					ls_day_from = "01", ls_day_to, ls_add_2sql
String					ls_days_leap[] = {"31","29","31","30","31","30","31","31","30","31","30","31"}
String					ls_days_not_leap[] = {"31","28","31","30","31","30","31","31","30","31","30","31"}
String					ls_key, ls_date_from, ls_date_to, ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
String					ls_sql, ls_sql_new
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_row, ll_i
//w_inventory_reports	lw_inventory_reports
//DataStore				lds_qr_report
//
//ls_run_message = "QR report run started."
//li_rtn = wf_insert_auto_run_log(ls_run_message)
//
//If IsValid(lds_qr_report) Then Destroy lds_qr_report
//lds_qr_report = Create DataStore
//lds_qr_report.DataObject = "d_qr_report"
//lds_qr_report.SetTransObject(sqlca)

//This report has to run on the first of every month.
//The data are from the first day of the previous month to the last day of the previous month.

ls_today = String(Today(), "mm/dd/yyyy")

//ls_today = "03/01/2018" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ls_month = Left(ls_today, 2)
ls_day = Mid(ls_today, 4, 2)
ls_year = Right(ls_today, 4)

If Mod(Integer(ls_year), 4) = 0 Then
	lb_leap_year_2select = True
Else
	lb_leap_year_2select = False
End If

If ls_month = "01" Then
	ls_month_2select = "12" //December of previous year
	ls_year_2select = String(Integer(ls_year) - 1, "00") //Previous year
Else
	ls_month_2select = String(Integer(ls_month) - 1, "00") //Previous month of current year
	ls_year_2select = ls_year //Current year
End If

If lb_leap_year_2select Then
	ls_day_to = ls_days_leap[Integer(ls_month_2select)]
Else
	ls_day_to = ls_days_not_leap[Integer(ls_month_2select)]
End If

ls_date_from = ls_month_2select + "/" + ls_day_from + "/" + ls_year_2select
ls_date_to = ls_month_2select + "/" + ls_day_to + "/" + ls_year_2select

em_from.Text = ls_date_from
em_to.Text = ls_date_to

is_add_2sql_prev_month = " where coil.date_received between " + &
						"to_date('" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + &
						" and to_date('" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + &
						" order by coil.coil_abc_num, coil.coil_org_num, coil_quality_flaw_mapping.starting_position, coil_quality_flaw_mapping.ending_position"

Return li_rtn
end function

public function integer wf_retrieve_data_4job (long al_ab_job_num);/*
Function:	wf_retrieve_data_4job
Returns:		integer
Arguments:	value	long al_ab_job_num
*/

Long		ll_rows
String	ls_sort_string

If al_ab_job_num > 0 Then
	dw_skids_4job.SetTransObject(sqlca)
	dw_coils_4job.SetTransObject(sqlca)
	dw_coil_lots_4job.SetTransObject(sqlca)
	dw_enduser_part_num_4job.SetTransObject(sqlca)
	
	//ll_rows = dw_skids_4job.Retrieve(al_ab_job_num)
	ll_rows = wf_retrieve_skids_4job_coil(True)
	
	If ll_rows > 0 Then
		ib_ok_2report = True
	Else
		ib_ok_2report = False
	End If
	
	ll_rows = dw_coils_4job.Retrieve(al_ab_job_num)
	ls_sort_string = "coil_org_num"
	dw_coil_lots_4job.SetSort(ls_sort_string)
	dw_coil_lots_4job.Sort()
	
	ll_rows = dw_coil_lots_4job.Retrieve(al_ab_job_num)
	ls_sort_string = "lot_num"
	dw_coil_lots_4job.SetSort(ls_sort_string)
	dw_coil_lots_4job.Sort()
	
	ll_rows = dw_enduser_part_num_4job.Retrieve(al_ab_job_num)
End If

Return 1
end function

public function integer wf_get_customer_name_4job (long al_ab_job_num);/*
Function:	wf_get_customer_name_4job
Return:		integer
Arguments:	value	long	al_ab_job_num
*/

String	ls_customer_name, ls_modstring, ls_rtn

select	customer.customer_short_name
into		:ls_customer_name
from		ab_job
			join customer_order on customer_order.order_abc_num = ab_job.order_abc_num
			join customer on customer.customer_id = customer_order.orig_customer_id
where		ab_job.ab_job_num = :al_ab_job_num
using		sqlca;

st_customer.Text = "Customer: " + ls_customer_name
is_customer_name = ls_customer_name

Return 1
end function

public function integer wf_get_enduser_part_4job (long al_ab_job_num);/*
Function:	wf_get_enduser_part_4job
Return:		integer
Arguments:	value	long	al_ab_job_num
*/

String	ls_enduser_part_num

select   order_item.enduser_part_num
into		:ls_enduser_part_num
from     ab_job
         join order_item on order_item.order_abc_num = ab_job.order_abc_num and order_item.order_item_num = ab_job.order_item_num
where    ab_job.ab_job_num = :al_ab_job_num
using		sqlca;

st_enduser_part.Text = "Enduser Part: " + ls_enduser_part_num

Return 1
end function

public function long wf_retrieve_skids_4job_coil (boolean ab_initial_retrieve);//Alex_Gerlants. 1260_Incoming_Customer_Quality2. Begin
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

ls_sql_orig = dw_skids_4job.GetSqlSelect()
ll_ab_job_num = il_ab_job_num

If ab_initial_retrieve Then
	ls_sql_add_1 = " where production_sheet_item.ab_job_num = " + String(ll_ab_job_num)
	ls_sql_add_2 = " where scraped_sheet_skid.ab_job_num = " + String(ll_ab_job_num)
Else
	li_selected_row = dw_coils_4job.GetSelectedRow(0)
	
	If li_selected_row > 0 Then
		Do While li_selected_row > 0
			ll_coil_abc_num = dw_coils_4job.Object.coil_abc_num[li_selected_row]
			ll_coil_abc_num_arr[UpperBound(ll_coil_abc_num_arr[]) + 1] = ll_coil_abc_num
			li_selected_row = dw_coils_4job.GetSelectedRow(li_selected_row) //Start after li_selected_row
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
dw_skids_4job.SetSqlSelect(ls_sql_new)
dw_skids_4job.SetTransObject(sqlca)
ll_rows = dw_skids_4job.Retrieve()

//MessageBox("wf_retrieve_skids_4job_coil", "ll_rows = " + String(ll_rows))

//Restore original SQL
dw_skids_4job.SetSqlSelect(ls_sql_orig)

Return ll_rows
//Alex_Gerlants. 1260_Incoming_Customer_Quality2. End
end function

on w_qa_skid_report.create
int iCurrent
call super::create
this.st_4=create st_4
this.cbx_lot_num=create cbx_lot_num
this.st_6=create st_6
this.cb_getsize=create cb_getsize
this.st_enduser_part=create st_enduser_part
this.st_customer=create st_customer
this.st_5=create st_5
this.st_coil_lot=create st_coil_lot
this.cb_get=create cb_get
this.dw_skids_4job=create dw_skids_4job
this.st_1=create st_1
this.cbx_all_dates=create cbx_all_dates
this.dw_coils_4job=create dw_coils_4job
this.st_3=create st_3
this.dw_job_qa=create dw_job_qa
this.st_2=create st_2
this.dw_enduser_part_num_4job=create dw_enduser_part_num_4job
this.cb_export=create cb_export
this.dw_rebanded_list=create dw_rebanded_list
this.dw_rejcoil_list=create dw_rejcoil_list
this.st_rowcount=create st_rowcount
this.cb_1=create cb_1
this.st_all_dates=create st_all_dates
this.cb_retrieve=create cb_retrieve
this.em_from=create em_from
this.em_to=create em_to
this.st_from=create st_from
this.st_to=create st_to
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_coil_lots_4job=create dw_coil_lots_4job
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.cbx_lot_num
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.cb_getsize
this.Control[iCurrent+5]=this.st_enduser_part
this.Control[iCurrent+6]=this.st_customer
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_coil_lot
this.Control[iCurrent+9]=this.cb_get
this.Control[iCurrent+10]=this.dw_skids_4job
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.cbx_all_dates
this.Control[iCurrent+13]=this.dw_coils_4job
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.dw_job_qa
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.dw_enduser_part_num_4job
this.Control[iCurrent+18]=this.cb_export
this.Control[iCurrent+19]=this.dw_rebanded_list
this.Control[iCurrent+20]=this.dw_rejcoil_list
this.Control[iCurrent+21]=this.st_rowcount
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.st_all_dates
this.Control[iCurrent+24]=this.cb_retrieve
this.Control[iCurrent+25]=this.em_from
this.Control[iCurrent+26]=this.em_to
this.Control[iCurrent+27]=this.st_from
this.Control[iCurrent+28]=this.st_to
this.Control[iCurrent+29]=this.dw_report
this.Control[iCurrent+30]=this.cb_close
this.Control[iCurrent+31]=this.cb_print
this.Control[iCurrent+32]=this.dw_coil_lots_4job
end on

on w_qa_skid_report.destroy
call super::destroy
destroy(this.st_4)
destroy(this.cbx_lot_num)
destroy(this.st_6)
destroy(this.cb_getsize)
destroy(this.st_enduser_part)
destroy(this.st_customer)
destroy(this.st_5)
destroy(this.st_coil_lot)
destroy(this.cb_get)
destroy(this.dw_skids_4job)
destroy(this.st_1)
destroy(this.cbx_all_dates)
destroy(this.dw_coils_4job)
destroy(this.st_3)
destroy(this.dw_job_qa)
destroy(this.st_2)
destroy(this.dw_enduser_part_num_4job)
destroy(this.cb_export)
destroy(this.dw_rebanded_list)
destroy(this.dw_rejcoil_list)
destroy(this.st_rowcount)
destroy(this.cb_1)
destroy(this.st_all_dates)
destroy(this.cb_retrieve)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_from)
destroy(this.st_to)
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_coil_lots_4job)
end on

event open;call super::open;Integer				li_rtn
Long					ll_rows, ll_row_inserted
DataWindowChild	ldwc
Date					ld_from_default

il_ab_job_num = Message.DoubleParm

cbx_lot_num.Checked = False
cbx_all_dates.Checked = True

dw_job_qa.InsertRow(0)
dw_job_qa.Object.ab_job_num[1] = il_ab_job_num
wf_retrieve_data_4job(il_ab_job_num)
wf_get_customer_name_4job(il_ab_job_num)
wf_get_enduser_part_4job(il_ab_job_num)

st_from.Enabled = False
em_from.Enabled = False

st_to.Enabled = False
em_to.Enabled = False

dw_rejcoil_list.SetTransObject(sqlca)
dw_rebanded_list.SetTransObject(sqlca)


dw_report.SetTransObject(sqlca)
is_sql_orig = dw_report.GetSqlSelect() //Save the original SQL
cb_getsize.Visible = False

//ld_from_default = RelativeDate(Today(), -7) //7 days into the past
//em_from.Text = String(ld_from_default)

wf_calc_prev_month()

//cb_retrieve.Event Clicked()
dw_report.SetFocus()



end event

event pfc_postopen;call super::pfc_postopen;This.Width = 5683
This.Height = 2544
This.X = 0
This.Y = 09

dw_report.Width = 5471
dw_report.Height = 1597
dw_report.X = 0
dw_report.Y = 474
end event

event pfc_preopen;call super::pfc_preopen;This.Width = 4650
This.Height = 2800


//This.of_SetResize(True)
//
//If IsValid(This.inv_resize) THEN
//   This.inv_resize.of_SetOrigSize(4650, 3500)
//
//	This.inv_resize.of_Register(st_rowcount, "FixedToBottom")
//
//	This.inv_resize.of_Register(cb_print, "FixedToBottom")
//	This.inv_resize.of_Register(cb_export, "FixedToBottom")
//	This.inv_resize.of_Register(cb_1, "FixedToBottom")
//	This.inv_resize.of_Register(cb_retrieve, "FixedToBottom")
//	This.inv_resize.of_Register(cb_close, "FixedToBottom")
//	This.inv_resize.of_Register(cb_getsize, "FixedToBottom")
//End If
end event

type st_4 from statictext within w_qa_skid_report
integer x = 40
integer y = 51
integer width = 322
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Coil Received"
boolean focusrectangle = false
end type

type cbx_lot_num from checkbox within w_qa_skid_report
integer x = 2256
integer y = 29
integer width = 183
integer height = 58
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Lot"
end type

event clicked;Long	ll_rows

String	ls_sort_string

If This.Checked Then
	dw_coils_4job.Visible = False
	dw_coil_lots_4job.Visible = True
	st_coil_lot.Text = "Cust.Lot #"
//	ls_sort_string = "coil_lot_num"
//	dw_coil_lots_4job.SetSort(ls_sort_string)
//	dw_coil_lots_4job.Sort()
Else
	dw_coils_4job.Visible = True
	dw_coil_lots_4job.Visible = False
	st_coil_lot.Text = "Cust.Coil #"
//	ls_sort_string = "coil_org_num"
//	dw_coil_lots_4job.SetSort(ls_sort_string)
//	dw_coil_lots_4job.Sort()
End If
	
end event

type st_6 from statictext within w_qa_skid_report
boolean visible = false
integer x = 3332
integer y = 29
integer width = 461
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Enduser Part For Job"
boolean focusrectangle = false
end type

type cb_getsize from commandbutton within w_qa_skid_report
integer x = 4634
integer y = 83
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Get Size"
end type

event clicked;MessageBox("", "Window Width: " + String(Parent.Width) + &
					"~n~rWindow Height: " + String(Parent.Height) + &
					"~n~rWindow X: " + String(Parent.X) + &
					"~n~rWindow Y: " + String(Parent.Y) + &
					"~n~r~n~rdw_report.Width: " + String(dw_report.Width) + &
					"~n~rdw_report.Height: " + String(dw_report.Height) + &
					"~n~rdw_report X: " + String(dw_report.X) + &
					"~n~rdw_report Y: " + String(dw_report.Y))
end event

type st_enduser_part from statictext within w_qa_skid_report
integer x = 37
integer y = 390
integer width = 1920
integer height = 58
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean focusrectangle = false
end type

type st_customer from statictext within w_qa_skid_report
integer x = 37
integer y = 330
integer width = 1920
integer height = 58
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean focusrectangle = false
end type

type st_5 from statictext within w_qa_skid_report
boolean visible = false
integer x = 3803
integer y = 45
integer width = 402
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cust.Lots For Job"
boolean focusrectangle = false
end type

type st_coil_lot from statictext within w_qa_skid_report
integer x = 1986
integer y = 29
integer width = 289
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cust.Coil #"
boolean focusrectangle = false
end type

type cb_get from commandbutton within w_qa_skid_report
integer x = 1638
integer y = 80
integer width = 197
integer height = 90
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Get"
end type

event clicked;Long		ll_ab_job_num, ll_rows
String	ls_modstring, ls_rtn

dw_job_qa.AcceptText()
st_coil_lot.Text = "Cust.Coil # For Job"
cbx_lot_num.Checked = False
dw_report.Reset()
st_rowcount.Text = ""

ls_modstring = "qa_customer_head_t.Text = ''"
ls_rtn = dw_report.Modify(ls_modstring)

ls_modstring = "qa_date_from_to_head_t.Text = ''"
ls_rtn = dw_report.Modify(ls_modstring)

ls_modstring = "ab_job_num_head_t.Text = ''"
ls_rtn = dw_report.Modify(ls_modstring)

ls_modstring = "coil_or_lot_head_t.Text = ''"
ls_rtn = dw_report.Modify(ls_modstring)

ls_modstring = "sheet_skid_num_head_t.Text = ''"
ls_rtn = dw_report.Modify(ls_modstring)

ll_ab_job_num = dw_job_qa.Object.ab_job_num[1]
If IsNull(ll_ab_job_num) Then ll_ab_job_num = 0

If ll_ab_job_num > 0 Then
	il_ab_job_num = ll_ab_job_num

	wf_retrieve_data_4job(ll_ab_job_num)
	wf_get_customer_name_4job(ll_ab_job_num)
	wf_get_enduser_part_4job(ll_ab_job_num)
End If

end event

type dw_skids_4job from datawindow within w_qa_skid_report
integer x = 2717
integer y = 86
integer width = 300
integer height = 342
integer taborder = 10
string title = "none"
string dataobject = "d_dddw_skids_4job_coil"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//String 	ls_old_sort, ls_column, ls_name
////String	ls_name_temp, ls_coltype
//Char 		lc_sort
//Long		ll_Col, ll_calendar_x
//Boolean	lb_dttm_column_clicked
//
//ls_name = dwo.Name
//
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
//
//---

//
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
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

type st_1 from statictext within w_qa_skid_report
integer x = 2706
integer y = 29
integer width = 143
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Skids"
boolean focusrectangle = false
end type

type cbx_all_dates from checkbox within w_qa_skid_report
integer x = 673
integer y = 182
integer width = 322
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "All Dates"
end type

event clicked;
If Not This.Checked Then
	st_from.Enabled = True
	em_from.Enabled = True
	
	st_to.Enabled = True
	em_to.Enabled = True
Else
	st_from.Enabled = False
	em_from.Enabled = False
	
	st_to.Enabled = False
	em_to.Enabled = False
End If
end event

type dw_coils_4job from datawindow within w_qa_skid_report
integer x = 1986
integer y = 86
integer width = 413
integer height = 352
integer taborder = 110
string title = "none"
string dataobject = "d_coils_4job_qa"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Integer	li_selected_row
Long		ll_ab_job_num, ll_coil_abc_num, ll_coil_abc_num_arr[], ll_found_row
String	ls_find_string

//ll_ab_job_num = dw_job_qa.Object.ab_job_num[1]

//Allow user to select multiple rows
If row > 0 Then
	
	ll_coil_abc_num = This.Object.coil_abc_num[row]
	ls_find_string ="coil_abc_num = " + String(ll_coil_abc_num)
	ll_found_row = dw_coil_lots_4job.Find(ls_find_string, 1, dw_coil_lots_4job.RowCount())
	
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
		
		If ll_found_row > 0 Then
			dw_coil_lots_4job.SelectRow(ll_found_row, False)
		End If
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
		
		If ll_found_row > 0 Then
			dw_coil_lots_4job.SelectRow(ll_found_row, True)
		End If
	End If
End If

wf_retrieve_skids_4job_coil(False)

end event

type st_3 from statictext within w_qa_skid_report
integer x = 1309
integer y = 29
integer width = 194
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job"
boolean focusrectangle = false
end type

type dw_job_qa from datawindow within w_qa_skid_report
integer x = 1313
integer y = 86
integer width = 307
integer height = 77
integer taborder = 90
string title = "none"
string dataobject = "d_job_qa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//cb_get.Event Clicked()
end event

event losefocus;cb_get.Event Clicked()
end event

type st_2 from statictext within w_qa_skid_report
boolean visible = false
integer x = 3321
integer y = 32
integer width = 508
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "End User Parts For Job"
boolean focusrectangle = false
end type

type dw_enduser_part_num_4job from datawindow within w_qa_skid_report
boolean visible = false
integer x = 3332
integer y = 86
integer width = 505
integer height = 352
integer taborder = 80
string title = "none"
string dataobject = "d_enduser_part_num_4job"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
end event

type cb_export from u_cb within w_qa_skid_report
integer x = 1375
integer y = 2272
integer width = 406
integer height = 93
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Export to Excel"
end type

event clicked;call super::clicked;String	ls_date_from, ls_date_to, ls_file

ls_date_from = em_from.Text
ls_date_from = Replace(ls_date_from, 3, 1, "")
ls_date_from = Replace(ls_date_from, 5, 1, "")

ls_date_to = em_to.Text
ls_date_to = Replace(ls_date_to, 3, 1, "")
ls_date_to = Replace(ls_date_to, 5, 1, "")

ls_file = "c:\temp\QR Report " + ls_date_from + "-" + ls_date_to + ".xls"

If dw_report.SaveAs(ls_file, Excel8!, True) = -1 Then
   MessageBox("Data SaveAs", "Error")
	Return -1
Else
	MessageBox("Success", "Data have been successfully exported to " + ls_file)
End If

Return 1
end event

type dw_rebanded_list from datawindow within w_qa_skid_report
boolean visible = false
integer x = 3562
integer y = 2163
integer width = 549
integer height = 320
integer taborder = 120
string title = "none"
string dataobject = "d_ab_job_reband_coil_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_rejcoil_list from datawindow within w_qa_skid_report
boolean visible = false
integer x = 2970
integer y = 2147
integer width = 549
integer height = 320
integer taborder = 70
string title = "none"
string dataobject = "d_ab_job_rej_coil_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_rowcount from statictext within w_qa_skid_report
integer x = 22
integer y = 2186
integer width = 2900
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_qa_skid_report
integer x = 940
integer y = 2272
integer width = 344
integer height = 93
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open in Excel"
end type

event clicked;Parent.ExportToExcel( dw_report, dw_report.RowCount() )
end event

type st_all_dates from statictext within w_qa_skid_report
boolean visible = false
integer x = 702
integer y = 205
integer width = 410
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Starting 1/1/2015"
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_qa_skid_report
integer x = 18
integer y = 2272
integer width = 351
integer height = 93
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
boolean default = true
end type

event clicked;//String				ls_line, ls_alloy, ls_temper, ls_scrap_type, ls_sheet_type_desc, ls_coil_org_num_2, ls_coil_abc_num_2
//String				ls_date_from, ls_date_to, ls_add_2sql_where, ls_sql_new, ls_customer_name, ls_flaw_reason, ls_flaw_reason_desc
//String				ls_find_string, ls_coil_abc_num, ls_coil_org_num, ls_material_num, ls_payoff_direction, ls_payoff_direction_desc
//String				ls_handling_code, ls_handling_code_name, ls_enduser_part_num
//Integer				li_rtn
//Long					ll_rows, ll_found_row, ll_customer_id, ll_coil_abc_num
//DataWindowChild	ldwc

Integer	li_rtn
Long		ll_selected_row, ll_rows
String	ls_date_from, ls_date_to, ls_add_2sql_where, ls_sql_new
String	ls_skids_4job_string, ls_coils_4job_string, ls_coils_4job_string_no_quotes, ls_lots_4job_string, ls_lots_4job_string_no_quotes
String	ls_sheet_skid_num, ls_coil_org_num, ls_coil_lot_num, ls_modstring, ls_rtn

If Not ib_ok_2report Then
	dw_report.Reset()
	Return
End If

dw_report.AcceptText()

ls_date_from = em_from.Text
ls_date_to = em_to.Text

If ls_date_from = "00/00/0000" Or ls_date_to = "00/00/0000" Then Return

li_rtn = dw_report.SetSqlSelect(is_sql_orig) //To start, restore the original SQL

//---

ls_add_2sql_where = "~n~rwhere qa_customer_quality_skid.ab_job_num = " + String(il_ab_job_num)

//Retrieval argument sheet_skid_num
ls_skids_4job_string = ""
ll_selected_row = dw_skids_4job.GetSelectedRow(0)

If ll_selected_row > 0 Then
	Do While ll_selected_row > 0
		ls_sheet_skid_num = String(dw_skids_4job.Object.sheet_skid_num[ll_selected_row])
		ls_skids_4job_string = ls_skids_4job_string + ls_sheet_skid_num + ","
		ll_selected_row = dw_skids_4job.GetSelectedRow(ll_selected_row) //Start search after ll_selected_row
	Loop
	
	ls_skids_4job_string = Left(ls_skids_4job_string, Len(ls_skids_4job_string) - 1) //Remove the last comma
	
	If Len(ls_add_2sql_where) > 0 Then
		ls_add_2sql_where = ls_add_2sql_where + "~n~rand qa_customer_quality_skid.sheet_skid_num in (" + ls_skids_4job_string + ")"
	Else
		ls_add_2sql_where = ls_add_2sql_where + "~n~rwhere qa_customer_quality_skid.sheet_skid_num in (" + ls_skids_4job_string + ")"
	End If
	
	is_skids_head_t = "Skids: " + ls_skids_4job_string
Else
	is_skids_head_t = "All Skids"
End If

//Retrieval argument coils
is_coil_or_lot_head_t = ""

//If dw_coils_4job.DataObject = "d_coil_lots_4job" Then
If cbx_lot_num.Checked Then
	//Retrieval argument lot_num
	ll_selected_row = dw_coils_4job.GetSelectedRow(0)
	
	If ll_selected_row > 0 Then
		Do While ll_selected_row > 0
			ls_coil_lot_num = dw_coil_lots_4job.Object.coil_lot_num[ll_selected_row]
			ls_lots_4job_string = ls_lots_4job_string + "'" + ls_coil_lot_num + "',"
			ls_lots_4job_string_no_quotes = ls_lots_4job_string_no_quotes + ls_coil_lot_num + ","
			ll_selected_row = dw_coil_lots_4job.GetSelectedRow(ll_selected_row) //Start search after ll_selected_row
		Loop
		
		ls_lots_4job_string = Left(ls_lots_4job_string, Len(ls_lots_4job_string) - 1) //Remove the last comma
		ls_lots_4job_string_no_quotes = Left(ls_lots_4job_string_no_quotes, Len(ls_lots_4job_string_no_quotes) - 1) //Remove the last comma
		
		If Len(ls_add_2sql_where) > 0 Then
			ls_add_2sql_where = ls_add_2sql_where + "~n~rand coil.lot_num in (" + ls_lots_4job_string + ")"
		Else
			ls_add_2sql_where = ls_add_2sql_where + "~n~rwhere coil.lot_num in (" + ls_lots_4job_string + ")"
		End If
		
		is_coil_or_lot_head_t = "Coil Lots: " + ls_lots_4job_string_no_quotes
	Else
		is_coil_or_lot_head_t = "All Coil Lots"
	End If
Else //dw_coils_4job.DataObject = "d_coils_4job"
	//Retrieval argument coil_org_num
	ll_selected_row = dw_coils_4job.GetSelectedRow(0)
	
	If ll_selected_row > 0 Then
		Do While ll_selected_row > 0
			ls_coil_org_num = dw_coils_4job.Object.coil_org_num[ll_selected_row]
			ls_coils_4job_string = ls_coils_4job_string + "'" + ls_coil_org_num + "',"
			ls_coils_4job_string_no_quotes = ls_coils_4job_string_no_quotes + ls_coil_org_num + ","
			ll_selected_row = dw_coils_4job.GetSelectedRow(ll_selected_row) //Start search after ll_selected_row
		Loop
		
		ls_coils_4job_string = Left(ls_coils_4job_string, Len(ls_coils_4job_string) - 1) //Remove the last comma
		ls_coils_4job_string_no_quotes = Left(ls_coils_4job_string_no_quotes, Len(ls_coils_4job_string_no_quotes) - 1) //Remove the last comma
			
		If Len(ls_add_2sql_where) > 0 Then
			ls_add_2sql_where = ls_add_2sql_where + "~n~rand coil.coil_org_num in (" + ls_coils_4job_string + ")"
		Else
			ls_add_2sql_where = ls_add_2sql_where + "~n~rwhere coil.coil_org_num in (" + ls_coils_4job_string + ")"
		End If
		
		is_coil_or_lot_head_t = "Customer Coil #s: " + ls_coils_4job_string_no_quotes
	Else
		is_coil_or_lot_head_t = "All Coils"
	End If
End If	
	
//---
//Retrieval argument  Dates
If cbx_all_dates.Checked Then
	is_date_range_head_t = "All Dates"
Else
	ls_date_from = em_from.Text
	ls_date_to = em_to.Text
	
	If ls_date_from = ls_date_to Then
		is_date_range_head_t = "Coils Received on: " + ls_date_from
	Else
		is_date_range_head_t = "Coils Received between " + ls_date_from + " and " + ls_date_to
	End If
	
	If ls_add_2sql_where = "" Then
		ls_add_2sql_where = ls_add_2sql_where + "~n~rwhere coil.date_received between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
								" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "
	Else
		ls_add_2sql_where = ls_add_2sql_where + "~n~rand coil.date_received between to_date( '" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' )" + &
								" and to_date( '" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )  "
	End if
End If
							

//---

ls_sql_new = is_sql_orig + ls_add_2sql_where
ls_sql_new = ls_sql_new + "~n~rorder by customer, qa_customer_quality_skid.ab_job_num, coil.coil_org_num, qa_customer_quality_skid.sheet_skid_num"

li_rtn = dw_report.SetSqlSelect(ls_sql_new)

ll_rows = dw_report.Retrieve()
dw_report.SetFocus()
end event

type em_from from editmask within w_qa_skid_report
integer x = 44
integer y = 179
integer width = 282
integer height = 77
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event getfocus;String	ls_null

SetNull(ls_null)

This.Text = ls_null
end event

type em_to from editmask within w_qa_skid_report
integer x = 336
integer y = 179
integer width = 322
integer height = 77
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event getfocus;String	ls_null

SetNull(ls_null)

This.Text = ls_null
end event

type st_from from statictext within w_qa_skid_report
integer x = 44
integer y = 115
integer width = 234
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Date From"
boolean focusrectangle = false
end type

type st_to from statictext within w_qa_skid_report
integer x = 336
integer y = 115
integer width = 234
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Date To"
boolean focusrectangle = false
end type

type dw_report from u_dw within w_qa_skid_report
integer x = 26
integer y = 451
integer width = 5453
integer height = 1645
integer taborder = 0
string dataobject = "d_qa_skid_report_excel"
boolean hscrollbar = true
boolean resizable = true
end type

event clicked;call super::clicked;String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

//If row > 0 Then
//	If This.IsSelected(row) Then
//		This.SelectRow(row, False)
//	Else
//		This.SelectRow(0, False)
//		This.SelectRow(row, True)
//	End If
//End If

ls_name = dwo.Name

If ls_name = "die_id_t" Then ls_name = "die_name_t" 	//Column die_id is not on the screen.
																		//Column die_name is.

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	This.SelectRow(0, False) //Unselect all rows
	
	ls_column = Left(ls_name, Len(String(ls_name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		  
		This.SetSort(ls_column + " " + lc_sort)
	Else
		This.SetSort(ls_column + " A")
	End If

	This.Sort()
End If
end event

event sqlpreview;call super::sqlpreview;String	ls_sqlsyntax

ls_sqlsyntax = sqlsyntax
end event

event retrieveend;call super::retrieveend;Long		ll_rows, ll_row, ll_ab_job_num
String	ls_modstring, ls_rtn
Pointer 	oldpointer

oldpointer = SetPointer(HourGlass!)

If Left(is_customer_name, 9) <> "Customer:" Then
	is_customer_name = "Customer: " + is_customer_name
End If

ls_modstring = "qa_customer_head_t.Text = '" + is_customer_name + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "qa_date_from_to_head_t.Text = '" + is_date_range_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

is_ab_job_num_head_t = String(il_ab_job_num)
ls_modstring = "ab_job_num_head_t.Text = 'Job: " + is_ab_job_num_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "coil_or_lot_head_t.Text = '" + is_coil_or_lot_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "sheet_skid_num_head_t.Text = '" + is_skids_head_t + "'"
ls_rtn = This.Modify(ls_modstring)

ll_rows = This.RowCount()

If ll_rows = 1 Then
	st_rowcount.Text = "1 row retrieved"
Else
	st_rowcount.Text = String(rowcount) + " rows retrieved"
End If

If ll_rows > 0 Then
	is_run_date_t = This.Object.rundate_t[1]
End If

SetPointer(oldpointer)
end event

type cb_close from u_cb within w_qa_skid_report
string tag = "Close without printing"
integer x = 2575
integer y = 2272
integer width = 351
integer height = 93
integer taborder = 130
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_qa_skid_report
integer x = 479
integer y = 2272
integer width = 351
integer height = 93
integer taborder = 90
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type dw_coil_lots_4job from datawindow within w_qa_skid_report
integer x = 1986
integer y = 86
integer width = 413
integer height = 352
integer taborder = 20
string title = "none"
string dataobject = "d_coil_lots_4job"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Long		ll_coil_abc_num, ll_found_row
String	ls_find_string

//Allow user to select multiple rows
If row > 0 Then
	
	ll_coil_abc_num = This.Object.coil_abc_num[row]
	ls_find_string ="coil_abc_num = " + String(ll_coil_abc_num)
	ll_found_row = dw_coils_4job.Find(ls_find_string, 1, dw_coils_4job.RowCount())
	
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
		
		If ll_found_row > 0 Then
			dw_coils_4job.SelectRow(ll_found_row, False)
		End If
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
		
		If ll_found_row > 0 Then
			dw_coils_4job.SelectRow(ll_found_row, True)
		End If
	End If
End If

wf_retrieve_skids_4job_coil(False)
end event

