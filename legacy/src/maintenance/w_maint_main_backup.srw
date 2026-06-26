$PBExportHeader$w_maint_main_backup.srw
$PBExportComments$<main>main maintenance application, inherited from  pfemain.pbl
forward
global type w_maint_main_backup from w_sheet
end type
type cb_today from u_cb within w_maint_main_backup
end type
type cb_perf from u_cb within w_maint_main_backup
end type
type cb_parts from u_cb within w_maint_main_backup
end type
type cb_log from u_cb within w_maint_main_backup
end type
type cb_pm from u_cb within w_maint_main_backup
end type
type cb_close from u_cb within w_maint_main_backup
end type
end forward

global type w_maint_main_backup from w_sheet
integer x = 4
integer y = 3
integer width = 1401
integer height = 1754
string title = "Maintenance"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 15780518
event type string ue_whoami ( )
event ue_read_only ( )
cb_today cb_today
cb_perf cb_perf
cb_parts cb_parts
cb_log cb_log
cb_pm cb_pm
cb_close cb_close
end type
global w_maint_main_backup w_maint_main_backup

type variables
integer ii_contact_new_flag
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_main"
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

on w_maint_main_backup.create
int iCurrent
call super::create
this.cb_today=create cb_today
this.cb_perf=create cb_perf
this.cb_parts=create cb_parts
this.cb_log=create cb_log
this.cb_pm=create cb_pm
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_today
this.Control[iCurrent+2]=this.cb_perf
this.Control[iCurrent+3]=this.cb_parts
this.Control[iCurrent+4]=this.cb_log
this.Control[iCurrent+5]=this.cb_pm
this.Control[iCurrent+6]=this.cb_close
end on

on w_maint_main_backup.destroy
call super::destroy
destroy(this.cb_today)
destroy(this.cb_perf)
destroy(this.cb_parts)
destroy(this.cb_log)
destroy(this.cb_pm)
destroy(this.cb_close)
end on

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Maintenance") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type cb_today from u_cb within w_maint_main_backup
integer x = 197
integer y = 883
integer width = 1009
integer height = 256
integer taborder = 40
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Today~'s Tasks"
end type

type cb_perf from u_cb within w_maint_main_backup
integer x = 197
integer y = 1165
integer width = 1009
integer height = 256
integer taborder = 50
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Perference"
end type

type cb_parts from u_cb within w_maint_main_backup
integer x = 197
integer y = 602
integer width = 1009
integer height = 256
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Parts"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_parts" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_log from u_cb within w_maint_main_backup
integer x = 197
integer y = 320
integer width = 1009
integer height = 256
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Maintenance Requests && Log"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_logs" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_pm from u_cb within w_maint_main_backup
integer x = 197
integer y = 38
integer width = 1009
integer height = 256
integer taborder = 10
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Preventive Maintenance"
end type

type cb_close from u_cb within w_maint_main_backup
string tag = "Exit"
integer x = 402
integer y = 1510
integer width = 541
integer height = 115
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean italic = true
string text = "&Close"
end type

event clicked;call super::clicked;Close(parent)
end event

