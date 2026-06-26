$PBExportHeader$w_report_inv_skid.srw
$PBExportComments$<popup>print skid list for each customer
forward
global type w_report_inv_skid from w_sheet
end type
type dw_report from u_dw within w_report_inv_skid
end type
type cb_setzoom from u_cb within w_report_inv_skid
end type
type cb_print from u_cb within w_report_inv_skid
end type
type cbx_setpreview from u_cbx within w_report_inv_skid
end type
type cb_close from u_cb within w_report_inv_skid
end type
end forward

global type w_report_inv_skid from w_sheet
integer x = 576
integer y = 221
integer height = 1380
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
cb_close cb_close
end type
global w_report_inv_skid w_report_inv_skid

on w_report_inv_skid.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.cb_close
end on

on w_report_inv_skid.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
end on

event open;call super::open;dw_report.SetTransObject(SQLCA)
Datawindow lds_temp
lds_temp = Message.PowerObjectParm
lds_temp.ShareData( dw_report )

Long ll_rc, ll_ab_job_num, ll_cust_id
String ls_cust, ls_mod

ll_rc = dw_report.RowCount()

if ll_rc > 0 then
	ll_ab_job_num = dw_report.GetItemNumber(1, "sheet_skid_ab_job_num")
	
	select customer.customer_short_name into :ls_cust
	from customer, customer_order, sheet_skid
	where sheet_skid.ref_order_abc_num = customer_order.order_abc_num
	and customer_order.orig_customer_id = customer.customer_id
	and sheet_skid.ab_job_num = :ll_ab_job_num
	using SQLCA;
	
end if

ls_mod = "cust_t.Text = ~"" + ls_cust + "~""
dw_report.Modify(ls_mod) 

dw_report.SetFocus()




/*
Window lw_parent
String ls_mod, ls_cust
Long ll_cust

ll_cust = Message.DoubleParm

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	ls_mod = lw_Parent.Dynamic Event ue_cur_retrieve()
	IF Len(ls_mod) > 0 THEN
		dw_report.Modify(ls_mod)
	END IF
END IF	

dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(ll_cust)

SELECT customer_full_name INTO :ls_cust
FROM customer
WHERE customer_id = :ll_cust
USING SQLCA;

ls_mod = "cust_t.Text = ~"" + ls_cust + "~""
dw_report.Modify(ls_mod) 

dw_report.SetFocus()

*/
end event

type dw_report from u_dw within w_report_inv_skid
integer x = 9
integer y = 12
integer width = 2039
integer height = 1256
integer taborder = 40
string dataobject = "d_report_skid_list_per_cust"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

type cb_setzoom from u_cb within w_report_inv_skid
integer x = 2066
integer y = 236
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_inv_skid
integer x = 2066
integer y = 344
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_report_inv_skid
integer x = 2085
integer y = 64
integer width = 366
integer height = 68
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_report_inv_skid
string tag = "Close without printing"
integer x = 2071
integer y = 456
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

