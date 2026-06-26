$PBExportHeader$w_sales_main.srw
$PBExportComments$Main sales app window inherited from w_sheet
forward
global type w_sales_main from w_sheet
end type
type pb_perf from u_pb within w_sales_main
end type
type pb_todo from u_pb within w_sales_main
end type
type pb_quote from u_pb within w_sales_main
end type
type pb_exit from u_pb within w_sales_main
end type
type pb_report from u_pb within w_sales_main
end type
type pb_calendar from u_pb within w_sales_main
end type
type pb_email from u_pb within w_sales_main
end type
type pb_catalog from u_pb within w_sales_main
end type
type pb_contact from u_pb within w_sales_main
end type
type pb_find from u_pb within w_sales_main
end type
type pb_new from u_pb within w_sales_main
end type
end forward

global type w_sales_main from w_sheet
integer width = 1207
integer height = 163
string title = "Sales Application"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 16777215
event type string ue_whoami ( )
pb_perf pb_perf
pb_todo pb_todo
pb_quote pb_quote
pb_exit pb_exit
pb_report pb_report
pb_calendar pb_calendar
pb_email pb_email
pb_catalog pb_catalog
pb_contact pb_contact
pb_find pb_find
pb_new pb_new
end type
global w_sales_main w_sales_main

event type string ue_whoami();RETURN "w_sales_main"
end event

on w_sales_main.create
int iCurrent
call super::create
this.pb_perf=create pb_perf
this.pb_todo=create pb_todo
this.pb_quote=create pb_quote
this.pb_exit=create pb_exit
this.pb_report=create pb_report
this.pb_calendar=create pb_calendar
this.pb_email=create pb_email
this.pb_catalog=create pb_catalog
this.pb_contact=create pb_contact
this.pb_find=create pb_find
this.pb_new=create pb_new
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_perf
this.Control[iCurrent+2]=this.pb_todo
this.Control[iCurrent+3]=this.pb_quote
this.Control[iCurrent+4]=this.pb_exit
this.Control[iCurrent+5]=this.pb_report
this.Control[iCurrent+6]=this.pb_calendar
this.Control[iCurrent+7]=this.pb_email
this.Control[iCurrent+8]=this.pb_catalog
this.Control[iCurrent+9]=this.pb_contact
this.Control[iCurrent+10]=this.pb_find
this.Control[iCurrent+11]=this.pb_new
end on

on w_sales_main.destroy
call super::destroy
destroy(this.pb_perf)
destroy(this.pb_todo)
destroy(this.pb_quote)
destroy(this.pb_exit)
destroy(this.pb_report)
destroy(this.pb_calendar)
destroy(this.pb_email)
destroy(this.pb_catalog)
destroy(this.pb_contact)
destroy(this.pb_find)
destroy(this.pb_new)
end on

event close;call super::close;f_display_app()
end event

type pb_perf from u_pb within w_sales_main
integer x = 973
integer y = 3
integer width = 99
integer height = 86
integer taborder = 100
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom032!"
string powertiptext = "Perference"
end type

event clicked;call super::clicked;Open(w_sales_preferences)
end event

type pb_todo from u_pb within w_sales_main
integer x = 549
integer y = 3
integer width = 99
integer height = 86
integer taborder = 60
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "EditStops5!"
string powertiptext = "To Do List"
end type

event clicked;call super::clicked;Open(w_sales_reminder)
end event

type pb_quote from u_pb within w_sales_main
integer x = 124
integer y = 3
integer width = 99
integer height = 86
integer taborder = 20
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Compute!"
string powertiptext = "Quote"
end type

event clicked;call super::clicked;Open(w_sales_quotes_list)
end event

type pb_exit from u_pb within w_sales_main
string tag = "Exit"
integer x = 1079
integer y = 3
integer width = 99
integer height = 86
integer taborder = 110
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Exit!"
boolean map3dcolors = true
string powertiptext = "Exit"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_report from u_pb within w_sales_main
integer x = 867
integer y = 3
integer width = 99
integer height = 86
integer taborder = 90
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "CrossTab!"
string powertiptext = "Report"
end type

type pb_calendar from u_pb within w_sales_main
integer x = 761
integer y = 3
integer width = 99
integer height = 86
integer taborder = 80
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "ArrangeIcons!"
string powertiptext = "Calender"
end type

event clicked;call super::clicked;Open(w_sales_calendar)
end event

type pb_email from u_pb within w_sales_main
integer x = 655
integer y = 3
integer width = 99
integer height = 86
integer taborder = 70
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom025!"
string powertiptext = "Email"
end type

type pb_catalog from u_pb within w_sales_main
integer x = 443
integer y = 3
integer width = 99
integer height = 86
integer taborder = 50
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "UserObject!"
string powertiptext = "Catalog"
end type

event clicked;call super::clicked;Open(w_sales_catalog)
end event

type pb_contact from u_pb within w_sales_main
integer x = 336
integer y = 3
integer width = 99
integer height = 86
integer taborder = 40
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Properties!"
string powertiptext = "Contacts"
end type

event clicked;call super::clicked;Open(w_sales_contact_details)
end event

type pb_find from u_pb within w_sales_main
integer x = 230
integer y = 3
integer width = 99
integer height = 86
integer taborder = 30
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Browse!"
alignment htextalign = right!
string powertiptext = "Find"
end type

type pb_new from u_pb within w_sales_main
integer x = 18
integer y = 3
integer width = 99
integer height = 86
integer taborder = 10
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "SetVariable!"
string powertiptext = "New"
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

