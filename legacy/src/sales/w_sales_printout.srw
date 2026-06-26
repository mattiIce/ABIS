$PBExportHeader$w_sales_printout.srw
$PBExportComments$print all sales reports
forward
global type w_sales_printout from w_child
end type
type rb_4 from radiobutton within w_sales_printout
end type
type rb_3 from radiobutton within w_sales_printout
end type
type rb_2 from radiobutton within w_sales_printout
end type
type rb_1 from radiobutton within w_sales_printout
end type
type dw_report from u_dw within w_sales_printout
end type
type pb_6 from u_pb within w_sales_printout
end type
type pb_5 from u_pb within w_sales_printout
end type
type gb_1 from groupbox within w_sales_printout
end type
end forward

global type w_sales_printout from w_child
integer x = 214
integer width = 3028
integer height = 1760
string title = "Print Sales Reports"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217752
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_report dw_report
pb_6 pb_6
pb_5 pb_5
gb_1 gb_1
end type
global w_sales_printout w_sales_printout

type variables
s_quote_data ids_q
end variables

on w_sales_printout.create
int iCurrent
call super::create
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_report=create dw_report
this.pb_6=create pb_6
this.pb_5=create pb_5
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_4
this.Control[iCurrent+2]=this.rb_3
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.dw_report
this.Control[iCurrent+6]=this.pb_6
this.Control[iCurrent+7]=this.pb_5
this.Control[iCurrent+8]=this.gb_1
end on

on w_sales_printout.destroy
call super::destroy
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_report)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.gb_1)
end on

event open;call super::open;ids_q = Message.PowerObjectParm

dw_report.Retrieve(ids_q.quote_id, ids_q.revision_id)

end event

type rb_4 from radiobutton within w_sales_printout
integer x = 2377
integer y = 61
integer width = 311
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "All"
end type

type rb_3 from radiobutton within w_sales_printout
integer x = 1591
integer y = 61
integer width = 779
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Internal Quotation Review"
end type

event clicked;dw_report.DataObject = "d_sales_quote_internal_review"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ids_q.quote_id, ids_q.revision_id)
end event

type rb_2 from radiobutton within w_sales_printout
integer x = 859
integer y = 61
integer width = 779
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Customer Quotation Form"
end type

event clicked;dw_report.DataObject = "d_sales_quote_customer"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ids_q.quote_id, ids_q.revision_id)
end event

type rb_1 from radiobutton within w_sales_printout
integer x = 84
integer y = 61
integer width = 779
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Quote Process Work Sheet"
end type

event clicked;dw_report.DataObject = "d_sales_quote_report"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ids_q.quote_id, ids_q.revision_id)
end event

type dw_report from u_dw within w_sales_printout
integer x = 11
integer y = 170
integer width = 2984
integer height = 1498
integer taborder = 120
string dataobject = "d_sales_quote_report"
boolean hscrollbar = true
end type

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

type pb_6 from u_pb within w_sales_printout
integer x = 2900
integer y = 77
integer width = 99
integer height = 80
integer taborder = 60
string text = ""
boolean originalsize = false
string picturename = "Exit!"
string powertiptext = "Exit"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_5 from u_pb within w_sales_printout
integer x = 2790
integer y = 77
integer width = 99
integer height = 80
integer taborder = 50
string text = ""
boolean originalsize = false
string picturename = "Custom074!"
string powertiptext = "Print"
end type

type gb_1 from groupbox within w_sales_printout
integer x = 11
integer y = 6
integer width = 2743
integer height = 141
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Select report to print"
borderstyle borderstyle = styleraised!
end type

