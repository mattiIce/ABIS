$PBExportHeader$w_recovery_selection.srw
$PBExportComments$select coil/job into recovery report
forward
global type w_recovery_selection from w_sheet
end type
type cbx_all from checkbox within w_recovery_selection
end type
type cb_add from u_cb within w_recovery_selection
end type
type dw_main from u_dw within w_recovery_selection
end type
type cb_close from u_cb within w_recovery_selection
end type
end forward

global type w_recovery_selection from w_sheet
integer width = 4385
integer height = 1654
string title = "Select coil/job into recovery report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cbx_all cbx_all
cb_add cb_add
dw_main dw_main
cb_close cb_close
end type
global w_recovery_selection w_recovery_selection

type variables
Long il_cust
DateTime idt_s, idt_e
Boolean lb_updated
end variables

on w_recovery_selection.create
int iCurrent
call super::create
this.cbx_all=create cbx_all
this.cb_add=create cb_add
this.dw_main=create dw_main
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_all
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.cb_close
end on

on w_recovery_selection.destroy
call super::destroy
destroy(this.cbx_all)
destroy(this.cb_add)
destroy(this.dw_main)
destroy(this.cb_close)
end on

event open;call super::open;s_cust_datetime lds_data

lds_data = message.PowerObjectParm

il_cust = lds_data.customer_id
idt_s = lds_data.start_time
idt_e = lds_data.end_time
THis.Title = "Please select coil/job for recovery report. Customer: " + lds_data.customer_name + " Processing date: " + String(idt_s, "mm/dd/yyyy") + " - " + String(idt_e, "mm/dd/yyyy") 

dw_main.Event pfc_retrieve()

lb_updated = FALSE
end event

type cbx_all from checkbox within w_recovery_selection
integer x = 128
integer width = 413
integer height = 77
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select All"
end type

event clicked;Long ll_row, ll_i

ll_row = dw_main.RowCount()

IF this.Checked THEN
	IF ll_row > 0 THEN
		FOR ll_i = 1 to ll_row
			dw_main.SetItem(ll_i, "selected", 1)
		NEXT
		dw_main.ResetUpdate()
	END IF
ELSE
	IF ll_row > 0 THEN
		FOR ll_i = 1 to ll_row
			dw_main.SetItem(ll_i, "selected", 0)
		NEXT
		dw_main.ResetUpdate()
	END IF
END IF
end event

type cb_add from u_cb within w_recovery_selection
integer x = 3522
integer y = 1459
integer width = 351
integer height = 93
integer taborder = 80
integer weight = 700
string text = "Add"
end type

event clicked;call super::clicked;Long ll_row, ll_i, ll_job, ll_coil
Int li_rc
s_job_and_coil lds_data

dw_main.AcceptText()
ll_row = dw_main.RowCount()

IF ll_row > 0 THEN
	FOR ll_i = 1 to ll_row	
		IF dw_main.GetItemNumber(ll_i, "selected") = 1 THEN
			lds_data.job_num = dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
			lds_data.coil_num = dw_main.GetItemNumber(ll_i, "coil_coil_abc_num") 
			OpenWithParm(w_recovery_coil_details, lds_data)
			li_rc = Message.DoubleParm
			IF li_rc > 0 THEN
						lb_Updated = TRUE
			END IF
		END IF
		
	NEXT
	dw_main.ResetUpdate()
END IF

RETURN 1

end event

type dw_main from u_dw within w_recovery_selection
integer x = 7
integer y = 80
integer width = 4345
integer height = 1354
integer taborder = 70
string dataobject = "d_recovery_info_main_all"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
of_SetBase(TRUE)
SetRowFocusIndicator(Hand!)
SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;Long ll_row, ll_i, ll_exist, ll_coil, ll_job

this.Retrieve(idt_s, idt_e, il_cust)
ll_exist = 0

ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = ll_row to 1 STEP -1
		ll_coil = dw_main.GetItemNumber(ll_i, "coil_coil_abc_num")
		ll_job = dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
		
		SELECT count(*) INTO :ll_exist
		FROM recovery_job_coil
		WHERE coil_abc_num = :ll_coil AND ab_job_num = :ll_job
		USING SQLCA;
		
			IF ll_exist > 0 THEN
				this.deleteRow(ll_i)
         END IF
		
	NEXT
	dw_main.ResetUpdate()
END IF
RETURN 1

end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row
Int li_status

ls_ColName = this.GetColumnName()
IF ls_ColName = "selected" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	li_status = this.GetItemNumber(ll_row,"selected")
	IF li_status = 0 THEN
      IF cbx_all.Checked THEN cbx_all.Checked = FALSE
	END IF
END IF
this.ResetUpdate()


end event

type cb_close from u_cb within w_recovery_selection
integer x = 3953
integer y = 1456
integer width = 351
integer height = 93
integer taborder = 70
integer weight = 700
string text = "Close"
end type

event clicked;call super::clicked;IF lb_updated THEN 
	ClosewithReturn(Parent, 1)
ELSE
	CloseWithReturn(Parent, 0)
END IF
end event

