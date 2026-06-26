$PBExportHeader$w_report_part_num.srw
$PBExportComments$<popup> print customer part items
forward
global type w_report_part_num from w_sheet
end type
type dw_report from u_dw within w_report_part_num
end type
type cb_setzoom from u_cb within w_report_part_num
end type
type cb_print from u_cb within w_report_part_num
end type
type cbx_setpreview from u_cbx within w_report_part_num
end type
type p_1 from u_p within w_report_part_num
end type
type cb_close from u_cb within w_report_part_num
end type
end forward

global type w_report_part_num from w_sheet
integer x = 592
integer y = 643
integer width = 3335
integer height = 1683
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
p_1 p_1
cb_close cb_close
end type
global w_report_part_num w_report_part_num

on w_report_part_num.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.p_1=create p_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.cb_close
end on

on w_report_part_num.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.p_1)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_id
dw_report.SetTransObject(SQLCA)
ll_id = Message.DoubleParm
dw_report.Retrieve(ll_id)
dw_report.SetFocus()
end event

type dw_report from u_dw within w_report_part_num
integer x = 7
integer y = 13
integer width = 2853
integer height = 1568
integer taborder = 40
string dataobject = "d_report_pn_item"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetTransObject(SQLCA)
This.Event pfc_Retrieve()
This.of_SetPrintPreview(TRUE)


end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(message.DoubleParm)
end event

type cb_setzoom from u_cb within w_report_part_num
integer x = 2904
integer y = 211
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_part_num
integer x = 2904
integer y = 317
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_report_part_num
integer x = 2922
integer y = 38
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type p_1 from u_p within w_report_part_num
integer x = 3043
integer y = 557
integer width = 69
integer height = 54
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_part_num
string tag = "Close without printing"
integer x = 2907
integer y = 429
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

