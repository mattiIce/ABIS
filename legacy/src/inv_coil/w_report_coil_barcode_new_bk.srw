$PBExportHeader$w_report_coil_barcode_new_bk.srw
$PBExportComments$<popup> print barcode form for each coil
forward
global type w_report_coil_barcode_new_bk from w_sheet
end type
type dw_report from u_dw within w_report_coil_barcode_new_bk
end type
type cb_setzoom from u_cb within w_report_coil_barcode_new_bk
end type
type cb_print from u_cb within w_report_coil_barcode_new_bk
end type
type cbx_setpreview from u_cbx within w_report_coil_barcode_new_bk
end type
type cb_close from u_cb within w_report_coil_barcode_new_bk
end type
type st_1 from statictext within w_report_coil_barcode_new_bk
end type
end forward

global type w_report_coil_barcode_new_bk from w_sheet
integer x = 539
integer y = 188
integer width = 2688
integer height = 1648
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 80269524
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
cb_close cb_close
st_1 st_1
end type
global w_report_coil_barcode_new_bk w_report_coil_barcode_new_bk

on w_report_coil_barcode_new_bk.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.cb_close=create cb_close
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.st_1
end on

on w_report_coil_barcode_new_bk.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
destroy(this.st_1)
end on

event open;call super::open;dw_report.SetTransObject(SQLCA)
dw_report.SetFocus()
dw_report.Retrieve(Message.DoubleParm)
this.title = "Printing coil# :  " + String(message.doubleparm) + "'s barcode ticket"

end event

type dw_report from u_dw within w_report_coil_barcode_new_bk
integer x = 27
integer y = 12
integer width = 2606
integer height = 1328
integer taborder = 40
string dataobject = "d_report_coil_barcode"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

type cb_setzoom from u_cb within w_report_coil_barcode_new_bk
integer x = 599
integer y = 1436
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_coil_barcode_new_bk
integer x = 1202
integer y = 1436
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_report_coil_barcode_new_bk
integer x = 2199
integer y = 1352
integer width = 366
integer height = 68
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_report_coil_barcode_new_bk
string tag = "Close without printing"
integer x = 1801
integer y = 1436
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_1 from statictext within w_report_coil_barcode_new_bk
integer x = 101
integer y = 1356
integer width = 1751
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Note: This report is formated as landscape, please check your printer~'s setup"
boolean focusrectangle = false
end type

