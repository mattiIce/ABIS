$PBExportHeader$w_skid_group_edit.srw
forward
global type w_skid_group_edit from w_response
end type
type st_1 from statictext within w_skid_group_edit
end type
type cb_cancel from commandbutton within w_skid_group_edit
end type
type cb_ok from commandbutton within w_skid_group_edit
end type
type dw_skid_status_group_edit from datawindow within w_skid_group_edit
end type
end forward

global type w_skid_group_edit from w_response
integer width = 1627
integer height = 621
string title = "Skid Status Selection"
boolean controlmenu = false
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_skid_status_group_edit dw_skid_status_group_edit
end type
global w_skid_group_edit w_skid_group_edit

type variables

end variables

on w_skid_group_edit.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_skid_status_group_edit=create dw_skid_status_group_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_skid_status_group_edit
end on

on w_skid_group_edit.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_skid_status_group_edit)
end on

event open;call super::open;DataWindowChild		ldwc
Integer					li_rtn, li_rows

dw_skid_status_group_edit.InsertRow(0)
li_rtn = dw_skid_status_group_edit.GetChild("skid_status", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	li_rows = ldwc.Retrieve()
End If
end event

event closequery;call super::closequery;//cb_cancel.Event Clicked()
end event

type st_1 from statictext within w_skid_group_edit
integer x = 282
integer y = 48
integer width = 1024
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please select skid status"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_skid_group_edit
integer x = 1042
integer y = 339
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;CloseWithReturn(Parent, -99)
end event

type cb_ok from commandbutton within w_skid_group_edit
integer x = 223
integer y = 333
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;Integer	li_skid_status

dw_skid_status_group_edit.AcceptText()

li_skid_status = dw_skid_status_group_edit.Object.skid_status[1]

If IsNull(li_skid_status) Then
	MessageBox("No Skid Status Selected", "Please select skid status", StopSign!)
	Return
End If

CloseWithReturn(Parent, li_skid_status)
end event

type dw_skid_status_group_edit from datawindow within w_skid_group_edit
integer x = 461
integer y = 166
integer width = 596
integer height = 77
integer taborder = 10
string title = "none"
string dataobject = "d_skid_status_group_edit"
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

