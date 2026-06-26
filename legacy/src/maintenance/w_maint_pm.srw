$PBExportHeader$w_maint_pm.srw
$PBExportComments$<main>main maintenance PMs, inherited from  pfemain.pbl
forward
global type w_maint_pm from w_sheet
end type
type cb_report from u_cb within w_maint_pm
end type
type cb_pm from u_cb within w_maint_pm
end type
type cb_close from u_cb within w_maint_pm
end type
end forward

global type w_maint_pm from w_sheet
integer x = 4
integer y = 3
integer width = 1083
integer height = 995
string title = "PM"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 65535
event type string ue_whoami ( )
event ue_read_only ( )
cb_report cb_report
cb_pm cb_pm
cb_close cb_close
end type
global w_maint_pm w_maint_pm

type variables
integer ii_contact_new_flag
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_pm"
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

on w_maint_pm.create
int iCurrent
call super::create
this.cb_report=create cb_report
this.cb_pm=create cb_pm
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_report
this.Control[iCurrent+2]=this.cb_pm
this.Control[iCurrent+3]=this.cb_close
end on

on w_maint_pm.destroy
call super::destroy
destroy(this.cb_report)
destroy(this.cb_pm)
destroy(this.cb_close)
end on

event activate;call super::activate;IF f_security_door("Maintenance_pms") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type cb_report from u_cb within w_maint_pm
integer x = 29
integer y = 371
integer width = 1009
integer height = 330
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "PM Reports"
end type

type cb_pm from u_cb within w_maint_pm
integer x = 29
integer y = 16
integer width = 1009
integer height = 330
integer taborder = 10
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Preventive Maintenance"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_pm_management" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_close from u_cb within w_maint_pm
string tag = "Exit"
integer x = 271
integer y = 755
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

