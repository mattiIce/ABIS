$PBExportHeader$w_new_quote_selection.srw
$PBExportComments$<Popup> Select customer/contact/catalog item for a new quote
forward
global type w_new_quote_selection from w_response
end type
type ddlb_2 from u_ddlb within w_new_quote_selection
end type
type rb_15 from radiobutton within w_new_quote_selection
end type
type rb_14 from radiobutton within w_new_quote_selection
end type
type rb_13 from radiobutton within w_new_quote_selection
end type
type rb_12 from radiobutton within w_new_quote_selection
end type
type rb_11 from radiobutton within w_new_quote_selection
end type
type ddlb_1 from u_ddlb within w_new_quote_selection
end type
type rb_10 from radiobutton within w_new_quote_selection
end type
type rb_9 from radiobutton within w_new_quote_selection
end type
type rb_8 from radiobutton within w_new_quote_selection
end type
type rb_7 from radiobutton within w_new_quote_selection
end type
type rb_6 from radiobutton within w_new_quote_selection
end type
type rb_5 from radiobutton within w_new_quote_selection
end type
type rb_4 from radiobutton within w_new_quote_selection
end type
type rb_3 from radiobutton within w_new_quote_selection
end type
type rb_2 from radiobutton within w_new_quote_selection
end type
type rb_1 from radiobutton within w_new_quote_selection
end type
type ddlb_cust from u_ddlb within w_new_quote_selection
end type
type cb_ok from u_cb within w_new_quote_selection
end type
type gb_1 from groupbox within w_new_quote_selection
end type
type gb_2 from groupbox within w_new_quote_selection
end type
type gb_3 from groupbox within w_new_quote_selection
end type
end forward

global type w_new_quote_selection from w_response
integer width = 2527
integer height = 1629
string title = "Select a new customer"
boolean controlmenu = false
long backcolor = 15780518
ddlb_2 ddlb_2
rb_15 rb_15
rb_14 rb_14
rb_13 rb_13
rb_12 rb_12
rb_11 rb_11
ddlb_1 ddlb_1
rb_10 rb_10
rb_9 rb_9
rb_8 rb_8
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
ddlb_cust ddlb_cust
cb_ok cb_ok
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_new_quote_selection w_new_quote_selection

on w_new_quote_selection.create
int iCurrent
call super::create
this.ddlb_2=create ddlb_2
this.rb_15=create rb_15
this.rb_14=create rb_14
this.rb_13=create rb_13
this.rb_12=create rb_12
this.rb_11=create rb_11
this.ddlb_1=create ddlb_1
this.rb_10=create rb_10
this.rb_9=create rb_9
this.rb_8=create rb_8
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_cust=create ddlb_cust
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_2
this.Control[iCurrent+2]=this.rb_15
this.Control[iCurrent+3]=this.rb_14
this.Control[iCurrent+4]=this.rb_13
this.Control[iCurrent+5]=this.rb_12
this.Control[iCurrent+6]=this.rb_11
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.rb_10
this.Control[iCurrent+9]=this.rb_9
this.Control[iCurrent+10]=this.rb_8
this.Control[iCurrent+11]=this.rb_7
this.Control[iCurrent+12]=this.rb_6
this.Control[iCurrent+13]=this.rb_5
this.Control[iCurrent+14]=this.rb_4
this.Control[iCurrent+15]=this.rb_3
this.Control[iCurrent+16]=this.rb_2
this.Control[iCurrent+17]=this.rb_1
this.Control[iCurrent+18]=this.ddlb_cust
this.Control[iCurrent+19]=this.cb_ok
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.gb_3
end on

on w_new_quote_selection.destroy
call super::destroy
destroy(this.ddlb_2)
destroy(this.rb_15)
destroy(this.rb_14)
destroy(this.rb_13)
destroy(this.rb_12)
destroy(this.rb_11)
destroy(this.ddlb_1)
destroy(this.rb_10)
destroy(this.rb_9)
destroy(this.rb_8)
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_cust)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type ddlb_2 from u_ddlb within w_new_quote_selection
integer x = 1602
integer y = 1062
integer width = 878
integer height = 317
integer taborder = 40
long backcolor = 15780518
end type

type rb_15 from radiobutton within w_new_quote_selection
integer x = 837
integer y = 1062
integer width = 735
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Or select a part from list"
end type

type rb_14 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 1302
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Part # 4"
end type

type rb_13 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 1222
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Part # 3"
end type

type rb_12 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 1142
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Part # 2"
end type

type rb_11 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 1062
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Part # 1"
end type

type ddlb_1 from u_ddlb within w_new_quote_selection
integer x = 1602
integer y = 586
integer width = 878
integer height = 608
integer taborder = 30
long backcolor = 15780518
end type

type rb_10 from radiobutton within w_new_quote_selection
integer x = 837
integer y = 586
integer width = 768
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Or select a contact from list"
end type

type rb_9 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 826
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Contact 4"
end type

type rb_8 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 746
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Contact 3"
end type

type rb_7 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 666
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Contact 2"
end type

type rb_6 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 586
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Contact 1"
end type

type rb_5 from radiobutton within w_new_quote_selection
integer x = 837
integer y = 102
integer width = 746
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "Or select a customer from list"
end type

type rb_4 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 342
integer width = 618
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "ALCOA - DAVENPORT"
end type

type rb_3 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 262
integer width = 578
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "NOVELIS - OSWEGO"
end type

type rb_2 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 182
integer width = 600
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "ALCOA - LANCASTER"
end type

type rb_1 from radiobutton within w_new_quote_selection
integer x = 146
integer y = 102
integer width = 655
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "NOVELIS - KINGSTON"
end type

type ddlb_cust from u_ddlb within w_new_quote_selection
integer x = 1602
integer y = 102
integer width = 878
integer height = 608
integer taborder = 20
long backcolor = 15780518
end type

type cb_ok from u_cb within w_new_quote_selection
integer x = 1028
integer y = 1450
integer width = 351
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "&Ok"
end type

event clicked;call super::clicked;s_quote_data lds_q
ClosewithReturn(Parent, lds_q)
end event

type gb_1 from groupbox within w_new_quote_selection
integer x = 7
integer y = 10
integer width = 2498
integer height = 461
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "Step 1. Select a customer"
end type

type gb_2 from groupbox within w_new_quote_selection
integer x = 7
integer y = 486
integer width = 2498
integer height = 461
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Step 2 (Optional) Pick a contact person"
end type

type gb_3 from groupbox within w_new_quote_selection
integer x = 7
integer y = 963
integer width = 2498
integer height = 461
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Step 3 (Optional) Pick an item from our catalog"
end type

