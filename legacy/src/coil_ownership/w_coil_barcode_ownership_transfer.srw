$PBExportHeader$w_coil_barcode_ownership_transfer.srw
$PBExportComments$<popup> print barcode form for each coil
forward
global type w_coil_barcode_ownership_transfer from w_sheet
end type
type dw_report from u_dw within w_coil_barcode_ownership_transfer
end type
type cb_setzoom from u_cb within w_coil_barcode_ownership_transfer
end type
type cb_print from u_cb within w_coil_barcode_ownership_transfer
end type
type cbx_setpreview from u_cbx within w_coil_barcode_ownership_transfer
end type
type cb_close from u_cb within w_coil_barcode_ownership_transfer
end type
type st_1 from statictext within w_coil_barcode_ownership_transfer
end type
end forward

global type w_coil_barcode_ownership_transfer from w_sheet
integer x = 538
integer y = 189
integer width = 2688
integer height = 1648
string title = "Print Coil Barcode"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 80269524
event type string ue_whoami ( )
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
cb_close cb_close
st_1 st_1
end type
global w_coil_barcode_ownership_transfer w_coil_barcode_ownership_transfer

event type string ue_whoami();/*
Event:		ue_whoami
Returns:		String
Arguments:	none
*/

Return "w_coil_barcode_ownership_transfer"
end event

on w_coil_barcode_ownership_transfer.create
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

on w_coil_barcode_ownership_transfer.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
destroy(this.st_1)
end on

event open;call super::open;Long 								ll_rows, ll_row, ll_coil_abc_num
String 							ls_modstring
s_coil_owneship_transfer	lstr_coil_owneship_transfer
DataWindow						ldw
Boolean							lb_row_selected

lstr_coil_owneship_transfer = Message.PowerObjectParm
ldw = lstr_coil_owneship_transfer.coil_owneship_transfer

ll_rows = ldw.RowCount()

If ll_rows > 0 Then
	dw_report.SetTransObject(SQLCA)
	dw_report.SetFocus()
	This.title = "Printing coil barcodes..."
		
	For ll_row = 1 To ll_rows
		lb_row_selected = ldw.IsSelected(ll_row)
		
		If lb_row_selected Then
			Choose Case ldw.DataObject
				Case "d_coil_ownership_transfer_certificate"
					ll_coil_abc_num = ldw.Object.coil_abc_num_new[ll_row]
				Case "d_coil_ownership_transfer_item"
					ll_coil_abc_num = ldw.Object.coil_abc_num[ll_row]
			End Choose
			
			dw_report.Retrieve(ll_coil_abc_num)
			
			ls_modstring = "t_coil_abc_num_1.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
			dw_report.Modify(ls_modstring)
			ls_modstring = "t_coil_abc_num_2.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
			dw_report.Modify(ls_modstring)
			ls_modstring = "t_coil_abc_num_3.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
			dw_report.Modify(ls_modstring)
			ls_modstring = "t_coil_abc_num_4.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
			dw_report.Modify(ls_modstring)
			ls_modstring = "t_coil_abc_num_5.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
			dw_report.Modify(ls_modstring)
			ls_modstring = "t_coil_abc_num_6.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
			dw_report.Modify(ls_modstring)
			ls_modstring = "t_coil_abc_num_7.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
			dw_report.Modify(ls_modstring)
		End If

	Next
End If

end event

type dw_report from u_dw within w_coil_barcode_ownership_transfer
integer x = 26
integer y = 13
integer width = 2608
integer height = 1328
integer taborder = 40
string dataobject = "d_coil_barcode"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

event retrievestart;call super::retrievestart;Return 2 //Don't discard existing rows in dw_report
end event

type cb_setzoom from u_cb within w_coil_barcode_ownership_transfer
integer x = 600
integer y = 1437
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_coil_barcode_ownership_transfer
integer x = 1203
integer y = 1437
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.object.datawindow.print.orientation = 2
//dw_report.object.datawindow.print.copies = 2
dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_coil_barcode_ownership_transfer
integer x = 2198
integer y = 1354
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_coil_barcode_ownership_transfer
string tag = "Close without printing"
integer x = 1799
integer y = 1437
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_1 from statictext within w_coil_barcode_ownership_transfer
integer x = 102
integer y = 1357
integer width = 1752
integer height = 61
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

