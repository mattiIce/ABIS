$PBExportHeader$w_sales_quote_to_cust_email.srw
$PBExportComments$Email a quote to customer
forward
global type w_sales_quote_to_cust_email from w_child
end type
type sle_subject from u_sle within w_sales_quote_to_cust_email
end type
type sle_cc from u_sle within w_sales_quote_to_cust_email
end type
type sle_to from u_sle within w_sales_quote_to_cust_email
end type
type mle_note from u_mle within w_sales_quote_to_cust_email
end type
type st_5 from statictext within w_sales_quote_to_cust_email
end type
type st_4 from statictext within w_sales_quote_to_cust_email
end type
type st_3 from statictext within w_sales_quote_to_cust_email
end type
type st_2 from statictext within w_sales_quote_to_cust_email
end type
type cb_close from u_cb within w_sales_quote_to_cust_email
end type
type cb_send from u_cb within w_sales_quote_to_cust_email
end type
type st_1 from statictext within w_sales_quote_to_cust_email
end type
type dw_report from u_dw within w_sales_quote_to_cust_email
end type
end forward

global type w_sales_quote_to_cust_email from w_child
integer width = 3028
integer height = 1760
string title = "Email Sales Quote to Customer"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217752
sle_subject sle_subject
sle_cc sle_cc
sle_to sle_to
mle_note mle_note
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_close cb_close
cb_send cb_send
st_1 st_1
dw_report dw_report
end type
global w_sales_quote_to_cust_email w_sales_quote_to_cust_email

type variables
s_quote_data ids_q
end variables

on w_sales_quote_to_cust_email.create
int iCurrent
call super::create
this.sle_subject=create sle_subject
this.sle_cc=create sle_cc
this.sle_to=create sle_to
this.mle_note=create mle_note
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_close=create cb_close
this.cb_send=create cb_send
this.st_1=create st_1
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_subject
this.Control[iCurrent+2]=this.sle_cc
this.Control[iCurrent+3]=this.sle_to
this.Control[iCurrent+4]=this.mle_note
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_send
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.dw_report
end on

on w_sales_quote_to_cust_email.destroy
call super::destroy
destroy(this.sle_subject)
destroy(this.sle_cc)
destroy(this.sle_to)
destroy(this.mle_note)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.cb_send)
destroy(this.st_1)
destroy(this.dw_report)
end on

event open;call super::open;ids_q = Message.PowerObjectParm

dw_report.Retrieve(ids_q.quote_id, ids_q.revision_id)

String ls_email
SELECT email1 INTO :ls_email
FROM Customer_contact
WHERE contact_id = :ids_q.contact_id
USING SQLCA;

sle_to.Text = ls_email
sle_subject.Text = "Quote # " + String(ids_q.quote_id)
mle_note.Text = "Thank you for your business."



end event

type sle_subject from u_sle within w_sales_quote_to_cust_email
integer x = 293
integer y = 195
integer width = 2684
integer taborder = 30
string facename = "Arial"
end type

type sle_cc from u_sle within w_sales_quote_to_cust_email
integer x = 293
integer y = 102
integer width = 2684
integer taborder = 20
string facename = "Arial"
end type

type sle_to from u_sle within w_sales_quote_to_cust_email
integer x = 293
integer y = 10
integer width = 2684
integer taborder = 10
string facename = "Arial"
end type

type mle_note from u_mle within w_sales_quote_to_cust_email
integer x = 208
integer y = 285
integer width = 2772
integer height = 237
integer taborder = 10
end type

type st_5 from statictext within w_sales_quote_to_cust_email
integer x = 7
integer y = 259
integer width = 252
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Note:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_sales_quote_to_cust_email
integer x = 7
integer y = 179
integer width = 252
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Subject:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_sales_quote_to_cust_email
integer x = 7
integer y = 99
integer width = 172
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "CC:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_sales_quote_to_cust_email
integer x = 7
integer y = 19
integer width = 172
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "TO:"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_sales_quote_to_cust_email
integer x = 1657
integer y = 1584
integer width = 351
integer height = 93
integer taborder = 20
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_send from u_cb within w_sales_quote_to_cust_email
integer x = 757
integer y = 1584
integer width = 351
integer height = 93
integer taborder = 10
string facename = "Arial"
string text = "&Send"
end type

type st_1 from statictext within w_sales_quote_to_cust_email
integer x = 15
integer y = 518
integer width = 391
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Attachment:"
boolean focusrectangle = false
end type

type dw_report from u_dw within w_sales_quote_to_cust_email
integer x = 11
integer y = 595
integer width = 2984
integer height = 960
integer taborder = 120
string dataobject = "d_sales_quote_customer"
boolean hscrollbar = true
end type

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

