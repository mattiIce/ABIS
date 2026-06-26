$PBExportHeader$w_maint_logs.srw
$PBExportComments$<main>main maintenance logs, inherited from  pfemain.pbl
forward
global type w_maint_logs from w_sheet
end type
type cb_report from u_cb within w_maint_logs
end type
type cb_log from u_cb within w_maint_logs
end type
type cb_close from u_cb within w_maint_logs
end type
end forward

global type w_maint_logs from w_sheet
integer x = 4
integer y = 3
integer width = 1401
integer height = 995
string title = "Logs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 15780518
event type string ue_whoami ( )
event ue_read_only ( )
cb_report cb_report
cb_log cb_log
cb_close cb_close
end type
global w_maint_logs w_maint_logs

type variables
integer ii_contact_new_flag
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_logs"
end event

public function long wf_getnew_id (string id_name);Long ll_int_next_id
String ls_col_name

CHOOSE CASE id_name
CASE "Customer"
	ls_col_name = 'customer_id_seq'
	SELECT customer_id_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;
CASE "Customer_Contact"
	ls_Col_name = 'customer_contact_id_seq'
	SELECT customer_contact_id_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;
CASE ELSE
	Return -1
END CHOOSE

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

on w_maint_logs.create
int iCurrent
call super::create
this.cb_report=create cb_report
this.cb_log=create cb_log
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_report
this.Control[iCurrent+2]=this.cb_log
this.Control[iCurrent+3]=this.cb_close
end on

on w_maint_logs.destroy
call super::destroy
destroy(this.cb_report)
destroy(this.cb_log)
destroy(this.cb_close)
end on

event activate;call super::activate;IF f_security_door("Maintenance_parts") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type cb_report from u_cb within w_maint_logs
integer x = 197
integer y = 365
integer width = 1009
integer height = 330
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Logs Reports"
end type

type cb_log from u_cb within w_maint_logs
integer x = 197
integer y = 10
integer width = 1009
integer height = 330
integer taborder = 10
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Maintenance Requests && Logs"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_logs_management" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_close from u_cb within w_maint_logs
string tag = "Exit"
integer x = 439
integer y = 749
integer width = 541
integer height = 115
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean italic = true
string text = "&Close"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_main" 
gnv_app.of_getFrame().Event pfc_open()

end event

