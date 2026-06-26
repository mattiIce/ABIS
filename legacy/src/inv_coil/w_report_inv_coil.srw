$PBExportHeader$w_report_inv_coil.srw
$PBExportComments$<popup> print coil list
forward
global type w_report_inv_coil from w_sheet
end type
type dw_report from u_dw within w_report_inv_coil
end type
type cb_setzoom from u_cb within w_report_inv_coil
end type
type cb_print from u_cb within w_report_inv_coil
end type
type cbx_setpreview from u_cbx within w_report_inv_coil
end type
type p_1 from u_p within w_report_inv_coil
end type
type cb_close from u_cb within w_report_inv_coil
end type
type st_1 from statictext within w_report_inv_coil
end type
end forward

global type w_report_inv_coil from w_sheet
integer x = 592
integer y = 416
integer width = 2480
integer height = 1178
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
p_1 p_1
cb_close cb_close
st_1 st_1
end type
global w_report_inv_coil w_report_inv_coil

on w_report_inv_coil.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.p_1=create p_1
this.cb_close=create cb_close
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.st_1
end on

on w_report_inv_coil.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.st_1)
end on

event open;call super::open;String	ls_dataobject //Alex Gerlants. 07/11/2023. Fixing All Customers search result printing

dw_report.SetTransObject(SQLCA)
Datawindow lds_temp
lds_temp = Message.PowerObjectParm
lds_temp.ShareData( dw_report )

ls_dataobject = lds_temp.DataObject //Alex Gerlants. 07/11/2023. Fixing All Customers search result printing

Long ll_rc, ll_coil_abc_num
String ls_cust, ls_mod

ll_rc = dw_report.RowCount()
if ll_rc > 0 then
	ll_coil_abc_num = dw_report.GetItemNumber(1, "coil_abc_num")
	select customer.customer_short_name into :ls_cust
	from customer, coil
	where customer.customer_id = coil.customer_id
	and coil.coil_abc_num = :ll_coil_abc_num
	using SQLCA;
	
end if

//Alex Gerlants. 07/11/2023. Fixing All Customers search result printing. Begin
If ls_dataobject <> "d_coil_list_allcust_2" Then
	ls_mod = "cust_t.Text = ~"" + ls_cust + "~""
Else
	ls_mod = "cust_t.Text = ~"" + "All customers" + "~""
End If
//Alex Gerlants. 07/11/2023. Fixing All Customers search result printing. End

dw_report.Modify(ls_mod) 

dw_report.SetFocus()
end event

type dw_report from u_dw within w_report_inv_coil
integer x = 26
integer y = 13
integer width = 2011
integer height = 992
integer taborder = 40
string dataobject = "d_report_coil_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

type cb_setzoom from u_cb within w_report_inv_coil
integer x = 2066
integer y = 237
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_inv_coil
integer x = 2066
integer y = 346
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
//dw_report.SaveAs("P:\inv_coil_sample.xls", Excel!, TRUE)
//dw_report.SaveAs("P:\inv_coil_sample.csv", CSV!, TRUE)
end event

type cbx_setpreview from u_cbx within w_report_inv_coil
integer x = 2085
integer y = 64
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type p_1 from u_p within w_report_inv_coil
integer x = 2202
integer y = 586
integer width = 69
integer height = 58
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_inv_coil
string tag = "Close without printing"
integer x = 2070
integer y = 458
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_1 from statictext within w_report_inv_coil
integer x = 33
integer y = 1018
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

