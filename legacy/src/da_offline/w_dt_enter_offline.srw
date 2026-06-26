$PBExportHeader$w_dt_enter_offline.srw
$PBExportComments$<Response> create new downtime record, inherited from pfemain/w_sheet
forward
global type w_dt_enter_offline from w_sheet
end type
type st_1 from statictext within w_dt_enter_offline
end type
type sle_note from u_sle within w_dt_enter_offline
end type
type st_cause from statictext within w_dt_enter_offline
end type
type cb_end from u_cb within w_dt_enter_offline
end type
type dw_cause from u_dw within w_dt_enter_offline
end type
type cb_cancel from u_cb within w_dt_enter_offline
end type
end forward

global type w_dt_enter_offline from w_sheet
integer x = 318
integer y = 144
integer width = 2918
integer height = 1750
string title = "DownTime Details"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
st_1 st_1
sle_note sle_note
st_cause st_cause
cb_end cb_end
dw_cause dw_cause
cb_cancel cb_cancel
end type
global w_dt_enter_offline w_dt_enter_offline

type variables
s_shift_job_coil_skid istr_t
datetime idt_s
Int ii_id
end variables

on w_dt_enter_offline.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_note=create sle_note
this.st_cause=create st_cause
this.cb_end=create cb_end
this.dw_cause=create dw_cause
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_note
this.Control[iCurrent+3]=this.st_cause
this.Control[iCurrent+4]=this.cb_end
this.Control[iCurrent+5]=this.dw_cause
this.Control[iCurrent+6]=this.cb_cancel
end on

on w_dt_enter_offline.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_note)
destroy(this.st_cause)
destroy(this.cb_end)
destroy(this.dw_cause)
destroy(this.cb_cancel)
end on

event open;call super::open;istr_t = message.PowerobjectParm

dw_cause.SetTransObject(sqlca)
dw_cause.retrieve()
dw_cause.SetFocus()

idt_s = DateTime(Today(), Now())
st_cause.Text = "Starting: " + String(idt_s, "MM/DD/YYYY HH:MM")

ii_id = 0

UPDATE "LINE_CURRENT_STATUS"  
SET "LINE_STATUS" = 1  
WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :istr_t.line_num  
USING SQLCA;
		
if sqlca.sqlcode <> 0 then
	sqlca.of_rollback( )
	MessageBox("Update line status", "Fail to update line status table!")
	return sqlca.sqlcode
end if
 
sqlca.of_commit( )
return 1


end event

type st_1 from statictext within w_dt_enter_offline
integer x = 37
integer y = 266
integer width = 256
integer height = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "NOTE:"
boolean focusrectangle = false
end type

type sle_note from u_sle within w_dt_enter_offline
integer x = 304
integer y = 269
integer width = 2560
integer taborder = 40
integer textsize = -9
string facename = "Arial"
string text = "please enter downtime notes here"
boolean hideselection = false
end type

type st_cause from statictext within w_dt_enter_offline
integer x = 37
integer y = 67
integer width = 2081
integer height = 115
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_end from u_cb within w_dt_enter_offline
string tag = "End"
integer x = 2158
integer y = 54
integer width = 706
integer height = 141
integer taborder = 30
integer textsize = -12
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&End this downtime"
end type

event clicked;call super::clicked;IF ii_id = 0 THEN
	Messagebox("Warning", "No downtime event selected.")
END IF

DateTime ldt_e
Long ll_seq, ll_min
String ls_note
Int li_i

ldt_e = DateTime(Today(), Now())
ls_note = sle_note.Text

SELECT dt_instance_seq.NEXTVAL INTO :ll_seq FROM DUAL;
INSERT INTO "DT_INSTANCE"  
		( "INSTANCE_NUM",   
           "AB_JOB_NUM",   
           "LINE_NUM",   
           "STARTING_TIME",   
           "ENDING_TIME",   
           "NOTE",
			  "SHIFT_NUM")  
VALUES ( :ll_seq,   
           :istr_t.job_num,   
           :istr_t.line_num,   
           :idt_s,   
           :ldt_e,   
           :ls_note,
			  :istr_t.shift_num);
			  
if sqlca.sqlcode = 0 then
	
	if not isNull( istr_t.job_num ) then
		  	UPDATE "DT_INSTANCE"  
     			SET "AB_JOB_NUM" = :istr_t.job_num  
   		WHERE "DT_INSTANCE"."SHIFT_NUM" = :istr_t.shift_num and
			      "AB_JOB_NUM" IS NULL;
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				return sqlca.sqlcode
			end if
	end if
	
	ll_min = secondsafter(Time(idt_s), Time(ldt_e))
	if ll_min < 0 then ll_min = 86400 + ll_min
	
	li_i = 1
	INSERT INTO "DT_INSTANCE_DETAIL"  
         ( "INSTANCE_NUM",   
           "INSTANCE_ITEM",   
           "ID",   
           "DURATION",   
           "NOTE" )  
   VALUES ( :ll_seq,   
           :li_i,
           :ii_id,
           :ll_min,
			  :ls_note )
	USING SQLCA;
	
	if sqlca.sqlcode <> 0 then
		SQLCA.of_rollback( );
		return sqlca.sqlcode
	end if


	UPDATE "LINE_CURRENT_STATUS"  
   SET "LINE_STATUS" = 0  
   WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :istr_t.line_num;
		
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			MessageBox("Update line status", "Fail to update line status table!")
			return sqlca.sqlcode
		end if
else
		SQLCA.of_rollback( ) ;
		return sqlca.sqlcode	
end if
 
sqlca.of_commit( )

CloseWithReturn(Parent, 1)
end event

type dw_cause from u_dw within w_dt_enter_offline
event ue_lbuttonup pbm_dwnlbuttonup
integer x = 4
integer y = 355
integer width = 2896
integer height = 1168
integer taborder = 30
string dataobject = "d_dt_cause_offline"
boolean hscrollbar = true
end type

event ue_lbuttonup;Long ll_row

ll_row = This.GetRow()
IF ll_row > 0 THEN
	st_cause.Text = this.GetItemString(ll_row, "cause_name") + " starting " + String(idt_s, "MM/DD/YYYY HH:MM")
	ii_id = this.GetItemNumber(ll_row, "id")
	
	UPDATE "LINE_CURRENT_STATUS"  
	SET "LINE_STATUS" = :ii_id  
	WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :istr_t.line_num  
	USING SQLCA;
		
	if sqlca.sqlcode <> 0 then
		sqlca.of_rollback( )
		MessageBox("Update line status", "Fail to update line status table!")
		return sqlca.sqlcode
	end if
 
	sqlca.of_commit( )
END IF




end event

type cb_cancel from u_cb within w_dt_enter_offline
string tag = "Close without saving"
integer x = 1200
integer y = 1539
integer width = 475
integer height = 118
integer taborder = 20
integer textsize = -12
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;ClosewithReturn(Parent, 0)
end event

