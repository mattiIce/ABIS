$PBExportHeader$w_report_coil_ownership_transfer.srw
$PBExportComments$<popup> shipping report tool inherited from pfemain/w_popup
forward
global type w_report_coil_ownership_transfer from w_popup
end type
type cb_close from u_cb within w_report_coil_ownership_transfer
end type
type cb_setzoom from u_cb within w_report_coil_ownership_transfer
end type
type cb_print from u_cb within w_report_coil_ownership_transfer
end type
type cb_reset from u_cb within w_report_coil_ownership_transfer
end type
type st_1 from statictext within w_report_coil_ownership_transfer
end type
type ddlb_type from dropdownlistbox within w_report_coil_ownership_transfer
end type
type dw_type from u_dw within w_report_coil_ownership_transfer
end type
type dw_report from u_report_dw within w_report_coil_ownership_transfer
end type
type cb_setup from u_cb within w_report_coil_ownership_transfer
end type
type cb_custom from u_cb within w_report_coil_ownership_transfer
end type
type dw_detail from u_dw within w_report_coil_ownership_transfer
end type
end forward

global type w_report_coil_ownership_transfer from w_popup
integer x = 55
integer y = 19
integer width = 3602
integer height = 2042
string title = "Print shipping report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cb_close cb_close
cb_setzoom cb_setzoom
cb_print cb_print
cb_reset cb_reset
st_1 st_1
ddlb_type ddlb_type
dw_type dw_type
dw_report dw_report
cb_setup cb_setup
cb_custom cb_custom
dw_detail dw_detail
end type
global w_report_coil_ownership_transfer w_report_coil_ownership_transfer

type variables
Long il_shipment
Int ii_type
Long il_customer
Long il_enduser
string is_typename

DataWindow	idw

end variables

forward prototypes
public function string wf_get_objectname ()
public function integer wf_setreportobject ()
public function long wf_retrieve_barcodes (datawindow adw)
end prototypes

event type string ue_whoami();/*
Event:		ue_whoami
Returns:		String
Arguments:	none
*/

Return "w_report_coil_ownership_transfer"
end event

public function string wf_get_objectname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Get_objectname
//
//	Access:    Public
//
//	Arguments:	None
//
//	Returns:  string
//	  The object name string.
//
//	Description:  
//	Returns report object name base on 
//			il_customer  --  customer_id
//			il_enduser	--	enduser_id
//			ii_type	--	report type
//	IF there is no object specified then return then default one.
//
//////////////////////////////////////////////////////////////////////////////

String ls_name
Int li_template_id

//SetNULL(ls_name)

If Not sqlca.of_IsConnected() Then
	Connect Using sqlca;
End If

select	sh_report_templates.sh_report_template_object
into		:ls_name   
from		sh_report_default_template
			join  	sh_report_templates on sh_report_templates.sh_report_template_id = sh_report_default_template.sh_report_template_id
				  and sh_report_default_template.sh_report_type_id = sh_report_templates.sh_report_type_id
where 	sh_report_default_template.sh_report_type_id = :ii_type
using		sqlca;

If sqlca.sqlcode = 100 Or sqlca.sqlcode < 0 Then
	SetNull(ls_name)
End If

//SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name  
//FROM CUSTOMER_SH_REPORT_TEMPLATES, SH_REPORT_TEMPLATES  
//WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = CUSTOMER_SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID ) and  
//		( ( CUSTOMER_SH_REPORT_TEMPLATES.CUSTOMER_ID = :il_customer ) AND  
//		( CUSTOMER_SH_REPORT_TEMPLATES.SHIPTO_ID = :il_enduser ) AND  
//		( SH_REPORT_TEMPLATES.SH_REPORT_TYPE_ID = :ii_type ) )    
//USING SQLCA;
//
//IF IsNULL(ls_name) OR Len(ls_name) < 2 THEN
//	//CUSTOMER DEFAULT TEMPLATE
//	SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name  
//	FROM CUST_SH_DEFAULT_TEMPLATE, SH_REPORT_TEMPLATES  
//	WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = CUST_SH_DEFAULT_TEMPLATE.SH_REPORT_TEMPLATE_ID ) and  
//			( (CUST_SH_DEFAULT_TEMPLATE.CUSTOMER_ID = :il_customer ) AND  
//			( CUST_SH_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = :ii_type ) )    
//	USING SQLCA;
//END IF

//DEFAULT TEMPLATE
//IF IsNULL(ls_name) OR Len(ls_name) < 2 THEN
//	SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name   
//   FROM SH_REPORT_DEFAULT_TEMPLATE, SH_REPORT_TEMPLATES  
//   WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TEMPLATE_ID ) and  
//     	   ( SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = SH_REPORT_TEMPLATES.SH_REPORT_TYPE_ID ) and  
//    	   ( ( SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = :ii_type ) )    
//	USING SQLCA;
//END IF


RETURN ls_name
end function

public function integer wf_setreportobject ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_setreportobject
//
//	Access:    Public
//
//	Arguments:	None
//
//	Returns:  Integer
//	  	1	-- success
//		other  -- false
//
//	Description:  setup print object based on the object name
//
//////////////////////////////////////////////////////////////////////////////

String ls_oname
s_dw_info lstr_dw
Long	ll_rows

ls_oname = wf_get_objectname()
dw_report.of_setabcoreport(ls_oname)
IF dw_report.inv_abco_report.Dynamic of_allowsetup() = 1 THEN
	cb_setup.Enabled = TRUE
ELSE
	cb_setup.Enabled = FALSE
END IF

//dw_report.Reset()
//dw_report.DataObject = dw_report.inv_abco_report.Dynamic of_getreportobject()
//dw_report.SetTransObject(sqlca)

ll_rows = dw_report.RowCount()

If ll_rows > 0 Then
	cb_print.Enabled = True
	cb_reset.Enabled = True
	cb_setzoom.Enabled = True
Else
	MessageBox("Info", "Failed to print report.")
	cb_print.Enabled = False
	cb_reset.Enabled = False
	cb_setzoom.Enabled = False
End If

//IF dw_report.inv_abco_report.Dynamic of_retrieve(il_shipment) < 0 THEN
//	MessageBox("Info", "Failed to print report.")
//	cb_print.Enabled = FALSE
//	cb_reset.Enabled = FALSE
//	cb_setzoom.Enabled = FALSE
//ELSE
//	cb_print.Enabled = TRUE
//	cb_reset.Enabled = TRUE
//	cb_setzoom.Enabled = TRUE
//END IF

lstr_dw = dw_report.inv_abco_report.Dynamic Event ue_custom_display()
dw_report.Width = lstr_dw.width
dw_report.Height = lstr_dw.length
dw_report.VScrollBar = lstr_dw.v_bar
dw_report.HScrollBar = lstr_dw.h_bar
dw_report.BringToTop = lstr_dw.front

RETURN 1
end function

public function long wf_retrieve_barcodes (datawindow adw);/*
Function:	wf_retrieve_barcodes
Returns:		long <== ll_rows
Arguments:	value	datawindow	adw
*/

Long 		ll_rows, ll_row, ll_coil_abc_num
Long		ll_rows_retrieved
String 	ls_modstring
Boolean	lb_row_selected

ll_rows = adw.RowCount()

If ll_rows > 0 Then
	dw_report.SetTransObject(SQLCA)
	dw_report.SetFocus()
	This.title = "Printing coil barcodes..."
		
	For ll_row = 1 To ll_rows
		lb_row_selected = adw.IsSelected(ll_row)
		
		If lb_row_selected Then
			Choose Case adw.DataObject
				Case "d_coil_ownership_transfer_certificate"
					ll_coil_abc_num = adw.Object.coil_abc_num_new[ll_row]
				Case "d_coil_ownership_transfer_item"
					ll_coil_abc_num = adw.Object.coil_abc_num[ll_row]
			End Choose
			
			ll_rows_retrieved = dw_report.Retrieve(ll_coil_abc_num)
			
			If ll_rows_retrieved > 0 Then
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
		End If
	Next
End If

Return ll_rows
end function

on w_report_coil_ownership_transfer.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cb_reset=create cb_reset
this.st_1=create st_1
this.ddlb_type=create ddlb_type
this.dw_type=create dw_type
this.dw_report=create dw_report
this.cb_setup=create cb_setup
this.cb_custom=create cb_custom
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_reset
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.ddlb_type
this.Control[iCurrent+7]=this.dw_type
this.Control[iCurrent+8]=this.dw_report
this.Control[iCurrent+9]=this.cb_setup
this.Control[iCurrent+10]=this.cb_custom
this.Control[iCurrent+11]=this.dw_detail
end on

on w_report_coil_ownership_transfer.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cb_reset)
destroy(this.st_1)
destroy(this.ddlb_type)
destroy(this.dw_type)
destroy(this.dw_report)
destroy(this.cb_setup)
destroy(this.cb_custom)
destroy(this.dw_detail)
end on

event pfc_print;wf_setreportobject()

PrintSetup()
dw_report.inv_abco_report.Dynamic of_printshippingreport(il_shipment)
MessageBox("Info", "Done!")
RETURN 1
end event

event pfc_open;//il_shipment = Message.DoubleParm
//
//Long ll_row, ll_i
//ll_row = dw_type.RowCount()
//IF ll_row > 0 THEN 
//	FOR ll_i = 1 TO ll_row
//		ddlb_type.AddItem(dw_type.GetItemString(ll_i, "sh_report_type_name"))
//	NEXT
//END IF
//
//CONNECT USING SQLCA;
//SELECT customer_id, des_sh_cust_id INTO :il_customer, :il_enduser
//FROM shipment
//WHERE packing_list = :il_shipment
//USING SQLCA;
//
//ddlb_type.SelectItem(1)

end event

event pfc_saveas;dw_report.inv_abco_report.Dynamic of_savereport()


end event

event open;call super::open;Long 								ll_rows, ll_row, ll_coil_abc_num
Long								ll_rows_retrieved
String 							ls_modstring
s_coil_owneship_transfer	lstr_coil_owneship_transfer
DataWindow						ldw
Boolean							lb_row_selected

ddlb_type.AddItem("Coil Barcode")
ii_type = 10 //Coil Barcode

lstr_coil_owneship_transfer = Message.PowerObjectParm
idw = lstr_coil_owneship_transfer.coil_owneship_transfer

wf_retrieve_barcodes(idw)

//ll_rows = ldw.RowCount()
//
//If ll_rows > 0 Then
//	dw_report.SetTransObject(SQLCA)
//	dw_report.SetFocus()
//	This.title = "Printing coil barcodes..."
//		
//	For ll_row = 1 To ll_rows
//		lb_row_selected = ldw.IsSelected(ll_row)
//		
//		If lb_row_selected Then
//			Choose Case ldw.DataObject
//				Case "d_coil_ownership_transfer_certificate"
//					ll_coil_abc_num = ldw.Object.coil_abc_num_new[ll_row]
//				Case "d_coil_ownership_transfer_item"
//					ll_coil_abc_num = ldw.Object.coil_abc_num[ll_row]
//			End Choose
//			
//			ll_rows_retrieved = dw_report.Retrieve(ll_coil_abc_num)
//			
//			If ll_rows_retrieved > 0 Then
//				ls_modstring = "t_coil_abc_num_1.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
//				dw_report.Modify(ls_modstring)
//				ls_modstring = "t_coil_abc_num_2.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
//				dw_report.Modify(ls_modstring)
//				ls_modstring = "t_coil_abc_num_3.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
//				dw_report.Modify(ls_modstring)
//				ls_modstring = "t_coil_abc_num_4.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
//				dw_report.Modify(ls_modstring)
//				ls_modstring = "t_coil_abc_num_5.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
//				dw_report.Modify(ls_modstring)
//				ls_modstring = "t_coil_abc_num_6.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
//				dw_report.Modify(ls_modstring)
//				ls_modstring = "t_coil_abc_num_7.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
//				dw_report.Modify(ls_modstring)
//			End If
//		End If
//
//	Next
//End If

//-----------------------------------------------------------

//il_shipment = Message.DoubleParm

//Long ll_row
//dw_type.SetTransObject(SQLCA)
//dw_type.Retrieve()
//dw_type.SelectRow(1,TRUE)
//ll_row = dw_type.RowCount()

//IF ll_row > 0 THEN 
//	FOR ll_i = 1 TO ll_row
//		ddlb_type.AddItem(dw_type.GetItemString(ll_i, "sh_report_type_name"))
//	NEXT
//END IF

//CONNECT USING SQLCA;
//SELECT customer_id, des_sh_cust_id INTO :il_customer, :il_enduser
//FROM shipment
//WHERE packing_list = :il_shipment
//USING SQLCA;
//
//ddlb_type.SelectItem(1)
//ddlb_type.Event SelectionChanged(1)
//
//dw_detail.Retrieve(il_shipment)

end event

type cb_close from u_cb within w_report_coil_ownership_transfer
integer x = 2823
integer y = 1885
integer width = 428
integer height = 74
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_coil_ownership_transfer
integer x = 845
integer y = 1885
integer width = 432
integer height = 74
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_coil_ownership_transfer
integer x = 1342
integer y = 1885
integer width = 428
integer height = 74
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print..."
end type

event clicked;Parent.Event pfc_print()


end event

type cb_reset from u_cb within w_report_coil_ownership_transfer
boolean visible = false
integer x = 351
integer y = 1885
integer width = 432
integer height = 74
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;String ls_text, ls_modstring
Long ll_row, ll_i

IF IsNULL(ii_type) OR ii_type < 1 THEN RETURN 0

CONNECT USING SQLCA;
SELECT sh_report_type_id INTO :ii_type
FROM sh_report_type
WHERE sh_report_type_name = :is_typename
USING SQLCA;

RETURN wf_setreportobject()


end event

type st_1 from statictext within w_report_coil_ownership_transfer
boolean visible = false
integer x = 29
integer y = 6
integer width = 461
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Select report type:"
boolean focusrectangle = false
end type

type ddlb_type from dropdownlistbox within w_report_coil_ownership_transfer
boolean visible = false
integer x = 479
integer y = 3
integer width = 823
integer height = 675
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Coil Barcode"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;SetPointer(HourGlass!)

String ls_text, ls_modstring
Long ll_row, ll_i

ls_text = Text(index)
is_typename = ls_text
IF Len(is_typename) < 2 THEN Return 0

CONNECT USING SQLCA;
SELECT sh_report_type_id INTO :ii_type
FROM sh_report_type
WHERE sh_report_type_name = :ls_text
USING SQLCA;


RETURN wf_setreportobject()
end event

type dw_type from u_dw within w_report_coil_ownership_transfer
boolean visible = false
integer x = 1401
integer y = 26
integer width = 128
integer height = 45
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_shipping_report_type"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_report from u_report_dw within w_report_coil_ownership_transfer
integer x = 22
integer y = 6
integer width = 3547
integer height = 1859
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_coil_barcode"
boolean hscrollbar = true
boolean livescroll = false
end type

event losefocus;this.AcceptText()
This.ResetUpdate()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event retrievestart;call super::retrievestart;Return 2 //Don't discard existing rows in dw_report
end event

type cb_setup from u_cb within w_report_coil_ownership_transfer
boolean visible = false
integer x = 1836
integer y = 1885
integer width = 428
integer height = 74
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "Set&up"
end type

event clicked;IF IsValid (dw_report.inv_abco_report) THEN
	dw_report.inv_abco_report.Dynamic of_setupreport()
END IF

end event

type cb_custom from u_cb within w_report_coil_ownership_transfer
boolean visible = false
integer x = 2330
integer y = 1885
integer width = 428
integer height = 74
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "U.S./CAN C&ustom"
end type

event clicked;OpenWithParm(w_report_customs, il_shipment)
end event

type dw_detail from u_dw within w_report_coil_ownership_transfer
boolean visible = false
integer x = 22
integer y = 1949
integer width = 3547
integer height = 288
integer taborder = 11
string dataobject = "d_report_combi_sheet"
end type

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;call super::rbuttonup;//Override
RETURN 0
end event

event constructor;of_SetRowManager(TRUE)
of_SetSort(TRUE)
of_SetPrintPreview(FALSE)
SetTransObject(SQLCA)

end event

