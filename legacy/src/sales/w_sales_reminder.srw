$PBExportHeader$w_sales_reminder.srw
$PBExportComments$<Child>Schedule sales events based on today
forward
global type w_sales_reminder from w_child
end type
type dw_schedule from u_dw within w_sales_reminder
end type
type pb_1 from u_pb within w_sales_reminder
end type
type pb_8 from u_pb within w_sales_reminder
end type
type pb_2 from u_pb within w_sales_reminder
end type
type pb_5 from u_pb within w_sales_reminder
end type
type pb_6 from u_pb within w_sales_reminder
end type
end forward

global type w_sales_reminder from w_child
integer width = 1320
integer height = 1763
string title = "Things to do today"
dw_schedule dw_schedule
pb_1 pb_1
pb_8 pb_8
pb_2 pb_2
pb_5 pb_5
pb_6 pb_6
end type
global w_sales_reminder w_sales_reminder

on w_sales_reminder.create
int iCurrent
call super::create
this.dw_schedule=create dw_schedule
this.pb_1=create pb_1
this.pb_8=create pb_8
this.pb_2=create pb_2
this.pb_5=create pb_5
this.pb_6=create pb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_schedule
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_8
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.pb_5
this.Control[iCurrent+6]=this.pb_6
end on

on w_sales_reminder.destroy
call super::destroy
destroy(this.dw_schedule)
destroy(this.pb_1)
destroy(this.pb_8)
destroy(this.pb_2)
destroy(this.pb_5)
destroy(this.pb_6)
end on

type dw_schedule from u_dw within w_sales_reminder
integer x = 7
integer y = 77
integer width = 1273
integer height = 1578
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sales_scheduled_event_list"
end type

event constructor;of_SetRowManager(TRUE)
of_SetBase(TRUE)
SetTransObject(SQLCA)
Retrieve(Today())

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type pb_1 from u_pb within w_sales_reminder
integer x = 790
integer width = 80
integer height = 70
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "AddWatch5!"
string powertiptext = "New"
end type

type pb_8 from u_pb within w_sales_reminder
integer x = 889
integer width = 80
integer height = 70
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "Custom091!"
string powertiptext = "Delete"
end type

type pb_2 from u_pb within w_sales_reminder
integer x = 987
integer width = 80
integer height = 70
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "Custom072!"
string powertiptext = "Edit"
end type

type pb_5 from u_pb within w_sales_reminder
integer x = 1086
integer width = 80
integer height = 70
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "Custom074!"
string powertiptext = "Print"
end type

type pb_6 from u_pb within w_sales_reminder
integer x = 1185
integer width = 80
integer height = 70
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "Exit!"
string powertiptext = "Exit"
end type

event clicked;call super::clicked;Close(Parent)
end event

