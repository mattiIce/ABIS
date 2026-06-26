$PBExportHeader$w_edge_trim_tolearance.srw
forward
global type w_edge_trim_tolearance from w_sheet
end type
type cb_1 from commandbutton within w_edge_trim_tolearance
end type
type cb_close from commandbutton within w_edge_trim_tolearance
end type
type cb_save from commandbutton within w_edge_trim_tolearance
end type
type dw_edge_trim_tolearance from u_dw within w_edge_trim_tolearance
end type
end forward

global type w_edge_trim_tolearance from w_sheet
integer x = 214
integer width = 837
integer height = 483
string title = "Edge Trimmer Tolerance Limits"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean toolbarvisible = false
event type string ue_whoami ( )
cb_1 cb_1
cb_close cb_close
cb_save cb_save
dw_edge_trim_tolearance dw_edge_trim_tolearance
end type
global w_edge_trim_tolearance w_edge_trim_tolearance

forward prototypes
public function boolean wf_data_modified ()
end prototypes

event type string ue_whoami();Return "w_edge_trim_tolearance"
end event

public function boolean wf_data_modified ();Long	ll_modified_rows

dw_edge_trim_tolearance.AcceptText()

ll_modified_rows = dw_edge_trim_tolearance.ModifiedCount()

If ll_modified_rows > 0 Then
	Return True
Else
	Return False
End If
end function

on w_edge_trim_tolearance.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_edge_trim_tolearance=create dw_edge_trim_tolearance
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.dw_edge_trim_tolearance
end on

on w_edge_trim_tolearance.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_edge_trim_tolearance)
end on

event pfc_postopen;call super::pfc_postopen;This.Width = 874
This.Height = 541
end event

event open;call super::open;dw_edge_trim_tolearance.SetTransObject(sqlca)
dw_edge_trim_tolearance.Retrieve()
end event

event closequery;Integer	ll_answer

If wf_data_modified() Then
	ll_answer = MessageBox("CloseQuery. Data Modified", "Data Modified. ~n~rWould you like to save changes?", Question!, YesNo!, 1)
	
	If ll_answer = 1 Then
		cb_save.Event Clicked()	
	Else
		Return 0 //Allow the window to be closed
	End If
End If
end event

type cb_1 from commandbutton within w_edge_trim_tolearance
boolean visible = false
integer x = 66
integer y = 3
integer width = 91
integer height = 90
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;MessageBox("", "Parent.Width = " + String(Parent.Width) + "~n~rParent.Height" + String(Parent.Height))
end event

type cb_close from commandbutton within w_edge_trim_tolearance
integer x = 497
integer y = 224
integer width = 241
integer height = 106
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close (Parent)
end event

type cb_save from commandbutton within w_edge_trim_tolearance
integer x = 69
integer y = 224
integer width = 241
integer height = 106
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;Integer		li_rtn, li_row
Decimal{2}	ld_lower_limit, ld_upper_limit
Boolean		lb_lower_limit_error, lb_upper_limit_error

//Validate input
dw_edge_trim_tolearance.AcceptText()
lb_lower_limit_error = False
lb_upper_limit_error = False
li_row = dw_edge_trim_tolearance.GetRow()

ld_lower_limit = dw_edge_trim_tolearance.Object.lower_limit[li_row]
ld_upper_limit = dw_edge_trim_tolearance.Object.upper_limit[li_row]

If ld_lower_limit < 0 Or ld_lower_limit > 99 Then
	lb_lower_limit_error = True
End If

If ld_upper_limit < 0 Or ld_upper_limit > 999.99 Then
	lb_upper_limit_error = True
End If

If lb_lower_limit_error Or lb_upper_limit_error Then
	If lb_lower_limit_error And lb_upper_limit_error Then
		MessageBox("Upper and Lower Limits Data Entry Error", &
			"Lower limit must not be less then 0, and not greater than 99." + &
			"~n~rUpper limit must not be less then 0, and not greater than 999." + &
			"~n~rPlease correct.", StopSign!)
	ElseIf lb_lower_limit_error Then
		MessageBox("Lower Limit Data Entry Error", &
			"Lower limit must not be less then 0, and not greater than 99." + &
			"~n~rPlease correct.", StopSign!)
	Else //lb_upper_limit_error = True
		MessageBox("Upper Limit Data Entry Error", &
			"Upper limit must not be less then 0, and not greater than 999.99." + &
			"~n~rPlease correct.", StopSign!)
	End If
	
	Return
End If

li_rtn = dw_edge_trim_tolearance.Update() //Error message is in dberror event for dw_edge_trim_tolearance

If li_rtn = 1 Then //OK
	Commit using sqlca;
	MessageBox("Successful Update", "Data saved successfully.")
Else
	Rollback using sqlca;
End If
end event

type dw_edge_trim_tolearance from u_dw within w_edge_trim_tolearance
integer x = 69
integer y = 48
integer width = 677
integer height = 147
integer taborder = 10
string dataobject = "d_edge_trim_tolearance"
boolean vscrollbar = false
boolean livescroll = false
end type

event dberror;call super::dberror;MessageBox("DB Error", "Error updating table edge_trim_tolearance~n~rError:~n~r" + sqlerrtext)
end event

