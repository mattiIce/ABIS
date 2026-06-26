$PBExportHeader$u_tabpg_print_shift_summary.sru
forward
global type u_tabpg_print_shift_summary from u_tabpg
end type
type dw_email from datawindow within u_tabpg_print_shift_summary
end type
type dw_dt_total from u_dw within u_tabpg_print_shift_summary
end type
type cb_end_shift from u_cb within u_tabpg_print_shift_summary
end type
type dw_operator from u_dw within u_tabpg_print_shift_summary
end type
type st_1 from statictext within u_tabpg_print_shift_summary
end type
type dw_shift_coil from u_dw within u_tabpg_print_shift_summary
end type
type dw_downtime_log from u_dw within u_tabpg_print_shift_summary
end type
end forward

global type u_tabpg_print_shift_summary from u_tabpg
integer width = 3599
integer height = 1946
long backcolor = 134217752
boolean ib_isupdateable = false
dw_email dw_email
dw_dt_total dw_dt_total
cb_end_shift cb_end_shift
dw_operator dw_operator
st_1 st_1
dw_shift_coil dw_shift_coil
dw_downtime_log dw_downtime_log
end type
global u_tabpg_print_shift_summary u_tabpg_print_shift_summary

type variables
w_operation_panel iw_operation_panel
long il_current_shift, il_shift_id
end variables

forward prototypes
public function integer of_validate_shift ()
end prototypes

public function integer of_validate_shift ();//return 1 if validate
//MessageBox("",string(dw_operator.rowcount( ) ))

dw_operator.accepttext( )
if dw_operator.rowcount( ) <> 1 then return 0
	
	if (isNull(dw_operator.object.shift_data_status[1]) or dw_operator.object.shift_data_status[1] <> 1) and (isNull(dw_operator.object.note[1]) or dw_operator.object.note[1] = "") then
		MessageBox("Data Error", "Please enter Shift note!")
		return 0
	end if
	
	if isNull(dw_operator.object.operator_initial[1]) or dw_operator.object.operator_initial[1] = "" then
		MessageBox("Data Error", "Please enter operator initial!")
		return 0
	end if
	
	return 1
end function

on u_tabpg_print_shift_summary.create
int iCurrent
call super::create
this.dw_email=create dw_email
this.dw_dt_total=create dw_dt_total
this.cb_end_shift=create cb_end_shift
this.dw_operator=create dw_operator
this.st_1=create st_1
this.dw_shift_coil=create dw_shift_coil
this.dw_downtime_log=create dw_downtime_log
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_email
this.Control[iCurrent+2]=this.dw_dt_total
this.Control[iCurrent+3]=this.cb_end_shift
this.Control[iCurrent+4]=this.dw_operator
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_shift_coil
this.Control[iCurrent+7]=this.dw_downtime_log
end on

on u_tabpg_print_shift_summary.destroy
call super::destroy
destroy(this.dw_email)
destroy(this.dw_dt_total)
destroy(this.cb_end_shift)
destroy(this.dw_operator)
destroy(this.st_1)
destroy(this.dw_shift_coil)
destroy(this.dw_downtime_log)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
//long ll_shift_id
DateTime ldt_now
ldt_now = DateTime(Today(), Now())
Long ll_current_shift_seconds

dw_downtime_log.of_settransobject( sqlca)
dw_dt_total.of_settransobject( sqlca)
dw_operator.of_settransobject( sqlca)
dw_shift_coil.of_settransobject( sqlca)


if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	il_shift_id = iw_operation_panel.iw_da_sheet.il_endshift_summary_shift_id
	cb_end_shift.text = "Save and Print Shift summary"
else //Current shift running
	ll_current_shift_seconds = &
	iw_operation_panel.iw_da_sheet.inv_datetime.of_secondsafter( iw_operation_panel.iw_da_sheet.iuo_shift.idt_shift_start , ldt_now )
	if ll_current_shift_seconds > 3600 then
		il_shift_id = iw_operation_panel.iw_da_sheet.iuo_shift.get_shift_id( )
		cb_end_shift.text = "Print Shift summary and End Shift"
	else
		cb_end_shift.text = "Save and Print Shift summary"
		il_shift_id = iw_operation_panel.iw_da_sheet.il_endshift_summary_shift_id
	end if
end if

if il_shift_id > 1000 then
	dw_shift_coil.of_retrieve( )
	dw_operator.of_retrieve( )
	dw_downtime_log.of_retrieve( )
	dw_dt_total.of_retrieve( )
	cb_end_shift.enabled = true
else
	cb_end_shift.enabled = false
	MessageBox("Invalid shift", "Shift time must be within 2 to 24 hour!")
end if

//dw_downtime_log.SetTransObject(sqlca)
//dw_downtime_log.Retrieve( ll_shift_id )

//close(lw_wait)

end event

type dw_email from datawindow within u_tabpg_print_shift_summary
boolean visible = false
integer x = 1467
integer y = 845
integer width = 549
integer height = 320
integer taborder = 20
string title = "none"
string dataobject = "d_auto_report_emails"
boolean livescroll = true
end type

event dberror;MessageBox("Error", "Unable to retrieve infomation from database. Code " + string(sqldbcode) + ": " + sqlerrtext + ".", Exclamation!, OK!)
end event

type dw_dt_total from u_dw within u_tabpg_print_shift_summary
integer x = 2366
integer y = 1587
integer width = 1221
integer height = 122
integer taborder = 20
string dataobject = "d_end_shift_report_dt_total"
boolean vscrollbar = false
boolean resizable = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//this.of_settransobject( sqlca )
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_shift_id )
end event

type cb_end_shift from u_cb within u_tabpg_print_shift_summary
integer x = 2454
integer y = 1741
integer width = 1064
integer height = 144
integer taborder = 21
integer textsize = -10
string text = "Print Shift summary and End Shift"
end type

event clicked;call super::clicked;integer 		audit_insert;
Integer		li_rtn = 1
Long			ll_rows, ll_row
String		ls_from_email, ls_from_name, ls_server, ls_port, ls_send_name, ls_logfile, ls_subject, ls_email_body
String		ls_email_address, ls_email_addresses[]
Integer		li_port
Boolean		lb_debugviewer = False
Integer		sqlcode = 0
String		sqlerrtext = "N/A"

if parent.of_validate_shift( ) <> 1 then 
//	MessageBox("Shift", "No Validated")
	return 1
end if
if this.text = "Print Shift summary and End Shift" then
	
   pointer oldpointer
//	of_validation( ) <> 1 then return 1
	iw_operation_panel.iw_da_sheet.wf_end_shift( )
	
	if dw_operator.of_update(true, true) = 1 then
			audit_insert = f_insert_audit("Shift", "End Time", "Not Ended", String(DateTime( Today( ), Now() ), 'mm/dd/yyyy hh:mm:ss'), gnv_logonattrib.is_userid, datetime(Today(),Now()), sqlcode, sqlerrtext)
			
			//Change pointer to hourglass.
			oldpointer = SetPointer(HourGlass!)
			
			//Get SMTP email varaibles from table abis_ini
			//ls_from_email = gnv_logonattrib.is_userid + "das@albl.com" //Email address "from" //Alex Gerlants. 08/10/2023. 1976_Update_Sender_2Reports
			ls_from_email = "reports@albl.com" //Email address "from" //Alex Gerlants. 08/10/2023. 1976_Update_Sender_2Reports
			
			//ls_from_name = gnv_logonattrib.is_userid + " DAS" //Name "from" //Alex Gerlants. 08/10/2023. 1976_Update_Sender_2Reports
			ls_from_name = "reports" //Name "from" //Alex gerlants. 08/10/2023. 1976_Update_Sender_2Reports
	
			ls_server = f_get_ini_value("das_end_shift_email","smtp_email","server","192.168.3.67") //From table abis_ini
	
			ls_port = f_get_ini_value("das_end_shift_email","smtp_email","port","25")
	
			If IsNumber(ls_port) Then
				li_port = Integer(ls_port)
			Else
				li_port = 25
			End If
	
			ls_send_name = f_get_ini_value("das_end_shift_email","smtp_email","send_name","Management")
			ls_logfile = f_get_ini_value("das_end_shift_email","smtp_email","logfile","V:\Email_Errors_LogFiles\SMTP_Email_LogFile.txt")
			ls_subject = f_get_ini_value("das_end_shift_email","smtp_email","subject","DAS Unavailable - Shift Ended Early")
			//Send email here. **************************************************************************************
	
			//--- Get user emails from table auto_report_emails	
			dw_email.SetTransObject(SQLCA)
  			ll_rows = dw_email.Retrieve('das end shift email', 'all')
			ls_email_body = "Shift ended early on " + gnv_logonattrib.is_userid + " at " + String(DateTime( Today( ), Now() ), 'mm/dd/yyyy hh:mm:ss') + ". DAS will be unavailable until next shift."
			For ll_row = 1 To ll_rows
				ls_email_address = dw_email.Object.email_address[ll_row]
				f_send_smtp_email(li_port, ls_email_body, ls_server, ls_logfile, lb_debugviewer, ls_subject, ls_from_email, ls_from_name, ls_email_address, ls_send_name)
			Next
			
			//Set pointer back from hourglass.
			SetPointer(oldpointer)
			
			if audit_insert = 1 then
				sqlca.of_commit( )
			else
				sqlca.of_rollback( )
				MessageBox("Failed to End Shift", "Unable to end shift: Insert into audit table failed. Code " + String(sqlcode) + ": " + sqlerrtext)
			end if
	else
		sqlca.of_rollback( )
		MessageBox("Shift", "Update failed!")
		return 1
	end if
else
	if dw_operator.of_update(true, true) = 1 then
			audit_insert = f_insert_audit("Shift", "End Time", "Not Ended", String(DateTime( Today( ), Now() ), 'mm/dd/yyyy hh:mm:ss'), gnv_logonattrib.is_userid, datetime(Today(),Now()), sqlcode, sqlerrtext)
			
			//Change pointer to hourglass.
			oldpointer = SetPointer(HourGlass!)
			
			//Get SMTP email varaibles from table abis_ini
			//ls_from_email = gnv_logonattrib.is_userid + "das@albl.com" //Email address "from" //Alex Gerlants. 08/10/2023. 1976_Update_Sender_2Reports
			ls_from_email = "reports@albl.com" //Email address "from" //Alex Gerlants. 08/10/2023. 1976_Update_Sender_2Reports
			
			//ls_from_name = gnv_logonattrib.is_userid + " DAS" //Name "from"	//Alex Gerlants. 08/10/2023. 1976_Update_Sender_2Reports
			ls_from_name = "reports" //Name "from" //Alex gerlants. 08/10/2023. 1976_Update_Sender_2Reports
	
			ls_server = f_get_ini_value("das_end_shift_email","smtp_email","server","192.168.3.67") //From table abis_ini
	
			ls_port = f_get_ini_value("das_end_shift_email","smtp_email","port","25")
	
			If IsNumber(ls_port) Then
				li_port = Integer(ls_port)
			Else
				li_port = 25
			End If
	
			ls_send_name = f_get_ini_value("das_end_shift_email","smtp_email","send_name","Management")
			ls_logfile = f_get_ini_value("das_end_shift_email","smtp_email","logfile","V:\Email_Errors_LogFiles\SMTP_Email_LogFile.txt")
			ls_subject = f_get_ini_value("das_end_shift_email","smtp_email","subject","DAS Unavailable - Shift Ended Early")
			//Send email here. **************************************************************************************
	
			//--- Get user emails from table auto_report_emails	
			dw_email.SetTransObject(SQLCA)
  			ll_rows = dw_email.Retrieve('das end shift email', 'all')
			ls_email_body = "Shift ended early on " + gnv_logonattrib.is_userid + " at " + String(DateTime( Today( ), Now() ), 'mm/dd/yyyy hh:mm:ss') + ". DAS will be unavailable until next shift."
			For ll_row = 1 To ll_rows
				ls_email_address = dw_email.Object.email_address[ll_row]
				f_send_smtp_email(li_port, ls_email_body, ls_server, ls_logfile, lb_debugviewer, ls_subject, ls_from_email, ls_from_name, ls_email_address, ls_send_name)
			Next
			
			//Set pointer back from hourglass.
			SetPointer(oldpointer)
			
			if audit_insert = 1 then
				sqlca.of_commit( )
			else
				sqlca.of_rollback( )
				MessageBox("Failed to End Shift", "Unable to end shift: Insert into audit table failed. Code " + String(sqlcode) + ": " + sqlerrtext)
			end if
	else
		sqlca.of_rollback( )
		MessageBox("Shift", "Update failed!")
		return 1
	end if
	
end if

iw_operation_panel.iw_da_sheet.wf_print_shift_summary( il_shift_id )
iw_operation_panel.iw_da_sheet.il_endshift_summary_shift_id = 0
iw_operation_panel.iw_da_sheet.idt_endshift_summary_print_shift_end_time = DateTime(Today(), Now())
iw_operation_panel.postevent( "ue_operation_finish")
end event

type dw_operator from u_dw within u_tabpg_print_shift_summary
integer x = 29
integer y = 13
integer width = 2330
integer height = 1878
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_end_shift_operator_signing_sheet"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_shift_id )
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event constructor;call super::constructor;//this.of_settransobject( sqlca )
end event

event pfc_preupdate;call super::pfc_preupdate;if this.rowcount( ) = 1 then
	this.object.operator_sign_time[1] = DateTime(Today(), Now())
	return 1
else
	return -1
end if
end event

type st_1 from statictext within u_tabpg_print_shift_summary
integer x = 1755
integer y = 38
integer width = 322
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "End Shift"
boolean focusrectangle = false
end type

type dw_shift_coil from u_dw within u_tabpg_print_shift_summary
integer x = 29
integer y = 205
integer width = 2322
integer height = 1491
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_end_shift_shift_coil"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;of_retrieve( )
return 1
//if row > 0 then
//	this.selectrow( 0, false)
//	this.selectrow( row, true)
//end if
end event

event constructor;call super::constructor;//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_register("shift_coil_coil_end_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_setcloseonclick( true)
//this.iuo_calculator.of_setinitialvalue( true)
//this.of_settransobject( sqlca )

end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_shift_id )
end event

type dw_downtime_log from u_dw within u_tabpg_print_shift_summary
integer x = 2366
integer y = 13
integer width = 1221
integer height = 1574
integer taborder = 10
string dataobject = "d_end_shift_report_downtime_log"
boolean resizable = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_shift_id )
end event

event clicked;return 1
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event constructor;call super::constructor;//this.of_settransobject( sqlca )
end event

