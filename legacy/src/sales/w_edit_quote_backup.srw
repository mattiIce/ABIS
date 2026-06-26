$PBExportHeader$w_edit_quote_backup.srw
$PBExportComments$<Child> Open an exist quote and edit it
forward
global type w_edit_quote_backup from w_child
end type
type st_9 from statictext within w_edit_quote_backup
end type
type pb_9 from u_pb within w_edit_quote_backup
end type
type st_8 from statictext within w_edit_quote_backup
end type
type pb_8 from u_pb within w_edit_quote_backup
end type
type st_7 from statictext within w_edit_quote_backup
end type
type pb_7 from u_pb within w_edit_quote_backup
end type
type st_6 from statictext within w_edit_quote_backup
end type
type pb_6 from u_pb within w_edit_quote_backup
end type
type st_1 from statictext within w_edit_quote_backup
end type
type pb_5 from u_pb within w_edit_quote_backup
end type
type pb_1 from u_pb within w_edit_quote_backup
end type
type st_5 from statictext within w_edit_quote_backup
end type
type pb_4 from u_pb within w_edit_quote_backup
end type
type st_4 from statictext within w_edit_quote_backup
end type
type st_3 from statictext within w_edit_quote_backup
end type
type pb_3 from u_pb within w_edit_quote_backup
end type
type pb_2 from u_pb within w_edit_quote_backup
end type
type st_2 from statictext within w_edit_quote_backup
end type
type dw_quote from u_dw within w_edit_quote_backup
end type
type gb_5 from groupbox within w_edit_quote_backup
end type
type gb_4 from groupbox within w_edit_quote_backup
end type
type gb_1 from groupbox within w_edit_quote_backup
end type
type gb_2 from groupbox within w_edit_quote_backup
end type
type gb_3 from groupbox within w_edit_quote_backup
end type
end forward

global type w_edit_quote_backup from w_child
integer width = 4447
integer height = 2045
string title = "Quote Editor"
st_9 st_9
pb_9 pb_9
st_8 st_8
pb_8 pb_8
st_7 st_7
pb_7 pb_7
st_6 st_6
pb_6 pb_6
st_1 st_1
pb_5 pb_5
pb_1 pb_1
st_5 st_5
pb_4 pb_4
st_4 st_4
st_3 st_3
pb_3 pb_3
pb_2 pb_2
st_2 st_2
dw_quote dw_quote
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_edit_quote_backup w_edit_quote_backup

type variables
s_quote_data ids_q
end variables

on w_edit_quote_backup.create
int iCurrent
call super::create
this.st_9=create st_9
this.pb_9=create pb_9
this.st_8=create st_8
this.pb_8=create pb_8
this.st_7=create st_7
this.pb_7=create pb_7
this.st_6=create st_6
this.pb_6=create pb_6
this.st_1=create st_1
this.pb_5=create pb_5
this.pb_1=create pb_1
this.st_5=create st_5
this.pb_4=create pb_4
this.st_4=create st_4
this.st_3=create st_3
this.pb_3=create pb_3
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_quote=create dw_quote
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_9
this.Control[iCurrent+2]=this.pb_9
this.Control[iCurrent+3]=this.st_8
this.Control[iCurrent+4]=this.pb_8
this.Control[iCurrent+5]=this.st_7
this.Control[iCurrent+6]=this.pb_7
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.pb_6
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.pb_5
this.Control[iCurrent+11]=this.pb_1
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.pb_4
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.pb_3
this.Control[iCurrent+17]=this.pb_2
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.dw_quote
this.Control[iCurrent+20]=this.gb_5
this.Control[iCurrent+21]=this.gb_4
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.gb_2
this.Control[iCurrent+24]=this.gb_3
end on

on w_edit_quote_backup.destroy
call super::destroy
destroy(this.st_9)
destroy(this.pb_9)
destroy(this.st_8)
destroy(this.pb_8)
destroy(this.st_7)
destroy(this.pb_7)
destroy(this.st_6)
destroy(this.pb_6)
destroy(this.st_1)
destroy(this.pb_5)
destroy(this.pb_1)
destroy(this.st_5)
destroy(this.pb_4)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_quote)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;ids_q = Message.PowerObjectParm

dw_quote.Retrieve(ids_q.quote_id, ids_q.revision_id)

end event

type st_9 from statictext within w_edit_quote_backup
integer x = 2520
integer y = 1840
integer width = 274
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8388736
string text = "As Order"
boolean focusrectangle = false
end type

type pb_9 from u_pb within w_edit_quote_backup
integer x = 2384
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 70
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom026!"
end type

type st_8 from statictext within w_edit_quote_backup
integer x = 1573
integer y = 1840
integer width = 289
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8388736
string text = "As Revision"
boolean focusrectangle = false
end type

type pb_8 from u_pb within w_edit_quote_backup
integer x = 1434
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 110
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom023!"
end type

type st_7 from statictext within w_edit_quote_backup
integer x = 2022
integer y = 1840
integer width = 380
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8388736
string text = "As New Quote"
boolean focusrectangle = false
end type

type pb_7 from u_pb within w_edit_quote_backup
integer x = 1887
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 110
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Copy!"
end type

type st_6 from statictext within w_edit_quote_backup
integer x = 4016
integer y = 1840
integer width = 304
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Exit"
boolean focusrectangle = false
end type

type pb_6 from u_pb within w_edit_quote_backup
integer x = 3873
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 100
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Exit!"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_1 from statictext within w_edit_quote_backup
integer x = 647
integer y = 1840
integer width = 260
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65280
string text = "Reminder"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_5 from u_pb within w_edit_quote_backup
integer x = 508
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 100
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Query!"
end type

event clicked;call super::clicked;OpenWithParm(w_sales_quote_reminder, ids_q)
end event

type pb_1 from u_pb within w_edit_quote_backup
integer x = 37
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 90
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Preview!"
end type

event clicked;call super::clicked;OpenWithParm(w_sales_quote_review, ids_q)
end event

type st_5 from statictext within w_edit_quote_backup
integer x = 1232
integer y = 1840
integer width = 168
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8388736
string text = "Save"
boolean focusrectangle = false
end type

type pb_4 from u_pb within w_edit_quote_backup
integer x = 1090
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 80
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom008!"
end type

type st_4 from statictext within w_edit_quote_backup
integer x = 3445
integer y = 1840
integer width = 260
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
string text = "Email to .."
boolean focusrectangle = false
end type

type st_3 from statictext within w_edit_quote_backup
integer x = 3120
integer y = 1840
integer width = 150
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
string text = "Print"
boolean focusrectangle = false
end type

type pb_3 from u_pb within w_edit_quote_backup
integer x = 3317
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 70
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom025!"
end type

event clicked;call super::clicked;OpenWithParm(w_sales_quote_to_cust_email, ids_q)
end event

type pb_2 from u_pb within w_edit_quote_backup
integer x = 2988
integer y = 1821
integer width = 121
integer height = 96
integer taborder = 60
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Print!"
end type

event clicked;call super::clicked;OpenWithParm(w_sales_printout, ids_q)
end event

type st_2 from statictext within w_edit_quote_backup
integer x = 154
integer y = 1840
integer width = 278
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Review"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_quote from u_dw within w_edit_quote_backup
integer x = 7
integer y = 6
integer width = 4381
integer height = 1741
integer taborder = 10
string dataobject = "d_sales_quote_modify"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

type gb_5 from groupbox within w_edit_quote_backup
integer x = 2893
integer y = 1757
integer width = 885
integer height = 176
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
string text = "Step 4: Distribute"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_edit_quote_backup
integer x = 11
integer y = 1757
integer width = 439
integer height = 176
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Step 1: Review"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_edit_quote_backup
integer x = 457
integer y = 1757
integer width = 541
integer height = 176
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65280
string text = "Step 2: Remind Me.."
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_edit_quote_backup
integer x = 3785
integer y = 1757
integer width = 585
integer height = 176
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Step 5: Exit"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_edit_quote_backup
integer x = 1006
integer y = 1754
integer width = 1880
integer height = 179
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8388736
string text = "Step 3. Save"
borderstyle borderstyle = styleraised!
end type

