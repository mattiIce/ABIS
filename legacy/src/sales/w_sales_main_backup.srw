$PBExportHeader$w_sales_main_backup.srw
$PBExportComments$Main sales app window inherited from w_sheet
forward
global type w_sales_main_backup from w_sheet
end type
type st_10 from statictext within w_sales_main_backup
end type
type pb_10 from u_pb within w_sales_main_backup
end type
type st_9 from statictext within w_sales_main_backup
end type
type pb_9 from u_pb within w_sales_main_backup
end type
type st_8 from statictext within w_sales_main_backup
end type
type st_7 from statictext within w_sales_main_backup
end type
type st_6 from statictext within w_sales_main_backup
end type
type st_5 from statictext within w_sales_main_backup
end type
type st_4 from statictext within w_sales_main_backup
end type
type st_3 from statictext within w_sales_main_backup
end type
type st_2 from statictext within w_sales_main_backup
end type
type st_1 from statictext within w_sales_main_backup
end type
type pb_8 from u_pb within w_sales_main_backup
end type
type pb_7 from u_pb within w_sales_main_backup
end type
type pb_6 from u_pb within w_sales_main_backup
end type
type pb_5 from u_pb within w_sales_main_backup
end type
type pb_4 from u_pb within w_sales_main_backup
end type
type pb_3 from u_pb within w_sales_main_backup
end type
type pb_2 from u_pb within w_sales_main_backup
end type
type pb_1 from u_pb within w_sales_main_backup
end type
end forward

global type w_sales_main_backup from w_sheet
integer x = 214
integer width = 4509
integer height = 195
string title = "Sales Application"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 16777215
event type string ue_whoami ( )
st_10 st_10
pb_10 pb_10
st_9 st_9
pb_9 pb_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
end type
global w_sales_main_backup w_sales_main_backup

event type string ue_whoami();RETURN "w_sales_main"
end event

on w_sales_main_backup.create
int iCurrent
call super::create
this.st_10=create st_10
this.pb_10=create pb_10
this.st_9=create st_9
this.pb_9=create pb_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_10
this.Control[iCurrent+2]=this.pb_10
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.pb_9
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.pb_8
this.Control[iCurrent+14]=this.pb_7
this.Control[iCurrent+15]=this.pb_6
this.Control[iCurrent+16]=this.pb_5
this.Control[iCurrent+17]=this.pb_4
this.Control[iCurrent+18]=this.pb_3
this.Control[iCurrent+19]=this.pb_2
this.Control[iCurrent+20]=this.pb_1
end on

on w_sales_main_backup.destroy
call super::destroy
destroy(this.st_10)
destroy(this.pb_10)
destroy(this.st_9)
destroy(this.pb_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event close;call super::close;f_display_app()
end event

type st_10 from statictext within w_sales_main_backup
integer x = 2465
integer y = 29
integer width = 285
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "ToDo"
boolean focusrectangle = false
end type

type pb_10 from u_pb within w_sales_main_backup
integer x = 2322
integer y = 19
integer width = 121
integer height = 99
integer taborder = 40
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "EditStops5!"
end type

event clicked;call super::clicked;Open(w_sales_reminder)
end event

type st_9 from statictext within w_sales_main_backup
integer x = 545
integer y = 29
integer width = 252
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Quote"
boolean focusrectangle = false
end type

type pb_9 from u_pb within w_sales_main_backup
integer x = 406
integer y = 19
integer width = 121
integer height = 99
integer taborder = 60
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Compute!"
end type

event clicked;call super::clicked;Open(w_sales_quotes_list)
end event

type st_8 from statictext within w_sales_main_backup
integer x = 4315
integer y = 29
integer width = 165
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Exit"
boolean focusrectangle = false
end type

type st_7 from statictext within w_sales_main_backup
integer x = 3866
integer y = 29
integer width = 267
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Report"
boolean focusrectangle = false
end type

type st_6 from statictext within w_sales_main_backup
integer x = 3372
integer y = 29
integer width = 325
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Calendar"
boolean focusrectangle = false
end type

type st_5 from statictext within w_sales_main_backup
integer x = 2926
integer y = 29
integer width = 216
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Email"
boolean focusrectangle = false
end type

type st_4 from statictext within w_sales_main_backup
integer x = 1989
integer y = 29
integer width = 322
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Catalog"
boolean focusrectangle = false
end type

type st_3 from statictext within w_sales_main_backup
integer x = 1441
integer y = 29
integer width = 329
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Contacts"
boolean focusrectangle = false
end type

type st_2 from statictext within w_sales_main_backup
integer x = 1039
integer y = 29
integer width = 201
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Find"
boolean focusrectangle = false
end type

type st_1 from statictext within w_sales_main_backup
integer x = 179
integer y = 29
integer width = 172
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "New"
boolean focusrectangle = false
end type

type pb_8 from u_pb within w_sales_main_backup
string tag = "Exit"
integer x = 4158
integer y = 19
integer width = 121
integer height = 99
integer taborder = 50
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Exit!"
boolean map3dcolors = true
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_7 from u_pb within w_sales_main_backup
integer x = 3730
integer y = 19
integer width = 121
integer height = 99
integer taborder = 50
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "CrossTab!"
end type

type pb_6 from u_pb within w_sales_main_backup
integer x = 3229
integer y = 19
integer width = 121
integer height = 99
integer taborder = 40
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "ArrangeIcons!"
end type

event clicked;call super::clicked;Open(w_sales_calendar)
end event

type pb_5 from u_pb within w_sales_main_backup
integer x = 2776
integer y = 19
integer width = 121
integer height = 99
integer taborder = 30
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom025!"
end type

type pb_4 from u_pb within w_sales_main_backup
integer x = 1836
integer y = 19
integer width = 121
integer height = 99
integer taborder = 30
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "UserObject!"
end type

event clicked;call super::clicked;Open(w_sales_catalog)
end event

type pb_3 from u_pb within w_sales_main_backup
integer x = 1295
integer y = 19
integer width = 121
integer height = 99
integer taborder = 30
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Properties!"
end type

event clicked;call super::clicked;Open(w_sales_contact_details)
end event

type pb_2 from u_pb within w_sales_main_backup
integer x = 889
integer y = 19
integer width = 121
integer height = 99
integer taborder = 20
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Browse!"
alignment htextalign = right!
string powertiptext = "F"
end type

type pb_1 from u_pb within w_sales_main_backup
integer x = 44
integer y = 19
integer width = 120
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "SetVariable!"
end type

event clicked;call super::clicked;String ls_w
Open(w_sales_new)
ls_w = Message.StringParm
CHOOSE CASE ls_w
	CASE ""
		RETURN 0
	CASE "w_new_quote"
		s_quote_data lds_q
		lds_q.customer_id = 0
		lds_q.contact_id = 0
		OpenwithParm(w_new_quote, lds_q)
END CHOOSE
RETURN 1
end event

