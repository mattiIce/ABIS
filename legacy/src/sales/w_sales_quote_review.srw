$PBExportHeader$w_sales_quote_review.srw
$PBExportComments$<Repsonse> screen for reviewing a quote
forward
global type w_sales_quote_review from w_response
end type
type st_3 from statictext within w_sales_quote_review
end type
type htb_1 from u_htb within w_sales_quote_review
end type
type mle_1 from u_mle within w_sales_quote_review
end type
type st_2 from statictext within w_sales_quote_review
end type
type st_1 from statictext within w_sales_quote_review
end type
type cb_close from u_cb within w_sales_quote_review
end type
type cb_save from u_cb within w_sales_quote_review
end type
type dw_history from u_dw within w_sales_quote_review
end type
type gb_1 from groupbox within w_sales_quote_review
end type
type gb_today from groupbox within w_sales_quote_review
end type
end forward

global type w_sales_quote_review from w_response
integer x = 214
integer width = 2070
integer height = 1760
string title = "Sales Quote Review"
st_3 st_3
htb_1 htb_1
mle_1 mle_1
st_2 st_2
st_1 st_1
cb_close cb_close
cb_save cb_save
dw_history dw_history
gb_1 gb_1
gb_today gb_today
end type
global w_sales_quote_review w_sales_quote_review

on w_sales_quote_review.create
int iCurrent
call super::create
this.st_3=create st_3
this.htb_1=create htb_1
this.mle_1=create mle_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_history=create dw_history
this.gb_1=create gb_1
this.gb_today=create gb_today
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.htb_1
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.dw_history
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_today
end on

on w_sales_quote_review.destroy
call super::destroy
destroy(this.st_3)
destroy(this.htb_1)
destroy(this.mle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_history)
destroy(this.gb_1)
destroy(this.gb_today)
end on

event open;call super::open;s_quote_data lds_q

lds_q = Message.PowerObjectParm

dw_history.Retrieve(lds_q.quote_id, lds_q.revision_id)

gb_today.Text = "Quote Review " + String(Today(), "MM/DD/YYYY")

end event

type st_3 from statictext within w_sales_quote_review
integer x = 1865
integer y = 1347
integer width = 143
integer height = 58
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "60%"
alignment alignment = Right!
boolean focusrectangle = false
end type

type htb_1 from u_htb within w_sales_quote_review
integer x = 267
integer y = 1341
integer width = 1595
integer height = 77
integer position = 60
integer tickfrequency = 5
htickmarks tickmarks = hticksontop!
end type

event moved;call super::moved;st_3.Text = String(this.Position) + "%"
end event

type mle_1 from u_mle within w_sales_quote_review
integer x = 230
integer y = 1421
integer width = 1792
integer height = 134
integer taborder = 30
string facename = "Arial"
end type

type st_2 from statictext within w_sales_quote_review
integer x = 26
integer y = 1421
integer width = 234
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Because:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_sales_quote_review
integer x = 26
integer y = 1344
integer width = 263
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Probability:"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_sales_quote_review
integer x = 1115
integer y = 1587
integer width = 351
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_save from u_cb within w_sales_quote_review
integer x = 475
integer y = 1587
integer width = 351
integer height = 93
integer taborder = 30
string facename = "Arial"
string text = "&Save"
end type

type dw_history from u_dw within w_sales_quote_review
integer x = 11
integer y = 61
integer width = 2030
integer height = 1194
integer taborder = 10
string dataobject = "d_quote_review_probability_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)

end event

type gb_1 from groupbox within w_sales_quote_review
integer y = 3
integer width = 2055
integer height = 1270
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quote Review History"
borderstyle borderstyle = styleraised!
end type

type gb_today from groupbox within w_sales_quote_review
integer y = 1283
integer width = 2055
integer height = 291
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Quote Review "
borderstyle borderstyle = styleraised!
end type

