$PBExportHeader$w_reprint_coil_transfer_certificate.srw
forward
global type w_reprint_coil_transfer_certificate from w_sheet
end type
type dw_coil_owner_transf_certificate_num from datawindow within w_reprint_coil_transfer_certificate
end type
type cb_open from commandbutton within w_reprint_coil_transfer_certificate
end type
type cb_retrieve from commandbutton within w_reprint_coil_transfer_certificate
end type
type cb_close from commandbutton within w_reprint_coil_transfer_certificate
end type
type st_4 from statictext within w_reprint_coil_transfer_certificate
end type
type st_width from statictext within w_reprint_coil_transfer_certificate
end type
type st_5 from statictext within w_reprint_coil_transfer_certificate
end type
type st_height from statictext within w_reprint_coil_transfer_certificate
end type
type st_3 from statictext within w_reprint_coil_transfer_certificate
end type
type st_2 from statictext within w_reprint_coil_transfer_certificate
end type
type st_1 from statictext within w_reprint_coil_transfer_certificate
end type
type em_to from editmask within w_reprint_coil_transfer_certificate
end type
type em_from from editmask within w_reprint_coil_transfer_certificate
end type
type dw_transfer_performed_by from datawindow within w_reprint_coil_transfer_certificate
end type
type dw_transfer_datetime from datawindow within w_reprint_coil_transfer_certificate
end type
type dw_coil_abc_num_new from datawindow within w_reprint_coil_transfer_certificate
end type
type dw_coil_abc_num_orig from datawindow within w_reprint_coil_transfer_certificate
end type
type dw_coil_org_num from datawindow within w_reprint_coil_transfer_certificate
end type
type dw_customer_id_new from datawindow within w_reprint_coil_transfer_certificate
end type
type dw_customer_id_orig from datawindow within w_reprint_coil_transfer_certificate
end type
type dw_coil_ownership_transfer from datawindow within w_reprint_coil_transfer_certificate
end type
end forward

global type w_reprint_coil_transfer_certificate from w_sheet
integer width = 3884
integer height = 1958
string title = "Reprint Coil Transfer Certificate"
event type string ue_whoami ( )
dw_coil_owner_transf_certificate_num dw_coil_owner_transf_certificate_num
cb_open cb_open
cb_retrieve cb_retrieve
cb_close cb_close
st_4 st_4
st_width st_width
st_5 st_5
st_height st_height
st_3 st_3
st_2 st_2
st_1 st_1
em_to em_to
em_from em_from
dw_transfer_performed_by dw_transfer_performed_by
dw_transfer_datetime dw_transfer_datetime
dw_coil_abc_num_new dw_coil_abc_num_new
dw_coil_abc_num_orig dw_coil_abc_num_orig
dw_coil_org_num dw_coil_org_num
dw_customer_id_new dw_customer_id_new
dw_customer_id_orig dw_customer_id_orig
dw_coil_ownership_transfer dw_coil_ownership_transfer
end type
global w_reprint_coil_transfer_certificate w_reprint_coil_transfer_certificate

type variables
String	is_sql_orig
end variables

forward prototypes
public function long wf_retrieve_dwc (n_tr_abc01 atr, ref datawindowchild adwc)
end prototypes

event type string ue_whoami();
/*
Event:		ue_whoami
Returns:		String
Arguments:	none
*/

Return "w_reprint_coil_transfer_certificate"
end event

public function long wf_retrieve_dwc (n_tr_abc01 atr, ref datawindowchild adwc);/*
Function:	wf_retrieve_dwc
Return:		long			<== Number of rows retrieved
Arguments:	value			n_tr_abc01	atr
				reference	datawindowchild	adwc
*/


Long	ll_rows


adwc.SetTransObject(atr)
ll_rows = adwc.Retrieve()

Return ll_rows
end function

on w_reprint_coil_transfer_certificate.create
int iCurrent
call super::create
this.dw_coil_owner_transf_certificate_num=create dw_coil_owner_transf_certificate_num
this.cb_open=create cb_open
this.cb_retrieve=create cb_retrieve
this.cb_close=create cb_close
this.st_4=create st_4
this.st_width=create st_width
this.st_5=create st_5
this.st_height=create st_height
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.em_to=create em_to
this.em_from=create em_from
this.dw_transfer_performed_by=create dw_transfer_performed_by
this.dw_transfer_datetime=create dw_transfer_datetime
this.dw_coil_abc_num_new=create dw_coil_abc_num_new
this.dw_coil_abc_num_orig=create dw_coil_abc_num_orig
this.dw_coil_org_num=create dw_coil_org_num
this.dw_customer_id_new=create dw_customer_id_new
this.dw_customer_id_orig=create dw_customer_id_orig
this.dw_coil_ownership_transfer=create dw_coil_ownership_transfer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_owner_transf_certificate_num
this.Control[iCurrent+2]=this.cb_open
this.Control[iCurrent+3]=this.cb_retrieve
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_width
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_height
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.em_to
this.Control[iCurrent+13]=this.em_from
this.Control[iCurrent+14]=this.dw_transfer_performed_by
this.Control[iCurrent+15]=this.dw_transfer_datetime
this.Control[iCurrent+16]=this.dw_coil_abc_num_new
this.Control[iCurrent+17]=this.dw_coil_abc_num_orig
this.Control[iCurrent+18]=this.dw_coil_org_num
this.Control[iCurrent+19]=this.dw_customer_id_new
this.Control[iCurrent+20]=this.dw_customer_id_orig
this.Control[iCurrent+21]=this.dw_coil_ownership_transfer
end on

on w_reprint_coil_transfer_certificate.destroy
call super::destroy
destroy(this.dw_coil_owner_transf_certificate_num)
destroy(this.cb_open)
destroy(this.cb_retrieve)
destroy(this.cb_close)
destroy(this.st_4)
destroy(this.st_width)
destroy(this.st_5)
destroy(this.st_height)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.dw_transfer_performed_by)
destroy(this.dw_transfer_datetime)
destroy(this.dw_coil_abc_num_new)
destroy(this.dw_coil_abc_num_orig)
destroy(this.dw_coil_org_num)
destroy(this.dw_customer_id_new)
destroy(this.dw_customer_id_orig)
destroy(this.dw_coil_ownership_transfer)
end on

event open;call super::open;
DataWindowChild	ldwc
Integer				li_rtn
Long					ll_rows, ll_row, ll_inserted_row, ll_null
Boolean				lb_this_window_open

//Check if this window is already open.
lb_this_window_open = f_window_open(This.Title)

If lb_this_window_open Then //Window open
	Close(This) //Close this window
	Return
End If

dw_coil_ownership_transfer.SetTransObject(sqlca)
is_sql_orig = dw_coil_ownership_transfer.GetSqlSelect()

li_rtn = dw_customer_id_orig.GetChild("customer_id", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then li_rtn = ldwc.SetItem(ll_inserted_row, "customer_short_name", "All")
ll_row = dw_customer_id_orig.GetRow()
dw_customer_id_orig.Object.customer_id[ll_row] = "All"

li_rtn = dw_customer_id_new.GetChild("customer_id", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then ldwc.SetItem(ll_inserted_row, "customer_short_name", "All")
ll_row = dw_customer_id_new.GetRow()
dw_customer_id_new.Object.customer_id[ll_row] = "All"

li_rtn = dw_coil_org_num.GetChild("coil_org_num", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then ldwc.SetItem(ll_inserted_row, "coil_org_num", "All")
ll_row = dw_coil_org_num.GetRow()
dw_coil_org_num.Object.coil_org_num[ll_row] = "All"

li_rtn = dw_coil_abc_num_orig.GetChild("coil_abc_num_orig", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then ldwc.SetItem(ll_inserted_row, "coil_abc_num_orig", "All")
ll_row = dw_coil_abc_num_orig.GetRow()
dw_coil_abc_num_orig.Object.coil_abc_num_orig[ll_row] = "All"

li_rtn = dw_coil_abc_num_new.GetChild("coil_abc_num_new", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then ldwc.SetItem(ll_inserted_row, "coil_abc_num_new", "All")
ll_row = dw_coil_abc_num_new.GetRow()
dw_coil_abc_num_new.Object.coil_abc_num_new[ll_row] = "All"

li_rtn = dw_transfer_datetime.GetChild("transfer_datetime", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then ldwc.SetItem(ll_inserted_row, "transfer_datetime", "All")
ll_row = dw_transfer_datetime.GetRow()
dw_transfer_datetime.Object.transfer_datetime[ll_row] = "All"

li_rtn = dw_transfer_performed_by.GetChild("transfer_performed_by", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then ldwc.SetItem(ll_inserted_row, "transfer_performed_by", "All")
ll_row = dw_transfer_performed_by.GetRow()
dw_transfer_performed_by.Object.transfer_performed_by[ll_row] = "All"

li_rtn = dw_coil_owner_transf_certificate_num.GetChild("certificate_num", ldwc)
If li_rtn = 1 Then ll_rows = f_retrieve_dwc(sqlca, ldwc)
ll_inserted_row = ldwc.InsertRow(1) //Insert before row 1
If ll_inserted_row > 0 Then ldwc.SetItem(ll_inserted_row, "certificate_num", "All")
ll_row = dw_coil_owner_transf_certificate_num.GetRow()
dw_coil_owner_transf_certificate_num.Object.certificate_num[ll_row] = "All"

dw_customer_id_orig.SetFocus()
end event

type dw_coil_owner_transf_certificate_num from datawindow within w_reprint_coil_transfer_certificate
integer x = 29
integer y = 330
integer width = 300
integer height = 77
integer taborder = 10
string title = "none"
string dataobject = "d_coil_owner_transf_certificate_num"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type cb_open from commandbutton within w_reprint_coil_transfer_certificate
integer x = 461
integer y = 1741
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open"
end type

event clicked;Long		ll_selected_row, ll_certificate_num
Integer	li_rtn
w_coil_ownership_transfer_certificate	lw_coil_ownership_transfer_certificate

ll_selected_row = dw_coil_ownership_transfer.GetSelectedRow(0)

If ll_selected_row > 0 Then
	ll_certificate_num = dw_coil_ownership_transfer.Object.certificate_num[ll_selected_row]
	
	//Open certificate window
	li_rtn = OpenSheetWithParm(lw_coil_ownership_transfer_certificate, ll_certificate_num, &
																						gnv_app.of_getframe(), 0, Original!)
End If																						
end event

type cb_retrieve from commandbutton within w_reprint_coil_transfer_certificate
integer x = 29
integer y = 1741
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;/*
DataWindow							Column
------------------------		---------------------
dw_customer_id_orig				customer_id
dw_customer_id_new				customer_id
dw_coil_org_num					coil_org_num
dw_coil_abc_num_orig				coil_abc_num_orig
dw_coil_abc_num_new				coil_abc_num_new
dw_transfer_datetime				transfer_datetime
dw_transfer_performed_by		transfer_performed_by

dw_coil_ownership_transfer.Retrieve()

*/

String	ls_certificate_num
String	ls_customer_id_orig
String	ls_customer_id_new
String	ls_coil_org_num
String	ls_coil_abc_num_orig
String	ls_coil_abc_num_new
String	ls_transfer_datetime_from
String	ls_transfer_datetime_to
String	ls_transfer_performed_by

String	ls_sql_add, ls_sql_new
Long		ll_rows, ll_certificate_num
Integer	li_rtn

dw_coil_ownership_transfer.SetSqlSelect(is_sql_orig)

//ll_certificate_num = dw_coil_owner_transf_certificate_num.Object.certificate_num[dw_coil_owner_transf_certificate_num.GetRow()]
//If IsNull(ll_certificate_num) Then ll_certificate_num = 0

ls_certificate_num = dw_coil_owner_transf_certificate_num.Object.certificate_num[dw_coil_owner_transf_certificate_num.GetRow()]
ls_customer_id_orig = dw_customer_id_orig.Object.customer_id[dw_customer_id_orig.GetRow()]
ls_customer_id_new = dw_customer_id_new.Object.customer_id[dw_customer_id_new.GetRow()]
ls_coil_org_num = dw_coil_org_num.Object.coil_org_num[dw_coil_org_num.GetRow()]
ls_coil_abc_num_orig = dw_coil_abc_num_orig.Object.coil_abc_num_orig[dw_coil_abc_num_orig.GetRow()]
ls_coil_abc_num_new = dw_coil_abc_num_new.Object.coil_abc_num_new[dw_coil_abc_num_new.GetRow()]
ls_transfer_datetime_from = em_from.Text
ls_transfer_datetime_to = em_to.Text
ls_transfer_performed_by = dw_transfer_performed_by.Object.transfer_performed_by[dw_transfer_performed_by.GetRow()]

//Build new SQL with only dates. Dates from and to are always there
ls_sql_add = "  where transfer_datetime between to_date('" + ls_transfer_datetime_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss' ) and to_date( '" + ls_transfer_datetime_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )"
ls_sql_new = is_sql_orig + ls_sql_add

If	ls_certificate_num = "All" And &
	ls_customer_id_orig = "All" And &
	ls_customer_id_new = "All" And &
	ls_coil_org_num = "All" And &
	ls_coil_abc_num_orig = "All" And &
	ls_coil_abc_num_new = "All" And &
	ls_transfer_performed_by= "All" Then
		li_rtn = dw_coil_ownership_transfer.SetSqlSelect(ls_sql_new)
		
		If li_rtn = 1 Then
			ll_rows = dw_coil_ownership_transfer.Retrieve()
		End if
Else
	If ls_certificate_num <> "All" Then
		ls_sql_new = ls_sql_new + "  and certificate_num = " + ls_certificate_num
	End If
	
	If ls_customer_id_orig <> "All" Then
		ls_sql_new = ls_sql_new + "  and customer_id_orig = " + ls_customer_id_orig
	End If
	
	If ls_customer_id_new <> "All" Then
		ls_sql_new = ls_sql_new + "  and customer_id_new = " + ls_customer_id_new
	End If
	
	If ls_coil_org_num <> "All" Then
		ls_sql_new = ls_sql_new + "  and coil_org_num = '" + ls_coil_org_num + "'"
	End If
	
	If ls_coil_abc_num_orig <> "All" Then
		ls_sql_new = ls_sql_new + "  and coil_abc_num_orig = " + ls_coil_abc_num_orig
	End If
	
	If ls_coil_abc_num_new <> "All" Then
		ls_sql_new = ls_sql_new + "  and coil_abc_num_new = " + ls_coil_abc_num_new
	End If
	
	If ls_transfer_performed_by <> "All" Then
		ls_sql_new = ls_sql_new + "  and transfer_performed_by = '" + ls_transfer_performed_by + "'"
	End If
	
	li_rtn = dw_coil_ownership_transfer.SetSqlSelect(ls_sql_new)
		
		If li_rtn = 1 Then
			ll_rows = dw_coil_ownership_transfer.Retrieve()
			
			If ll_rows = 1 Then
				dw_coil_ownership_transfer.SelectRow(1, True) //Select row 1 so user doesn't have to
			End If
		End if
End If

end event

type cb_close from commandbutton within w_reprint_coil_transfer_certificate
integer x = 3511
integer y = 1741
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type st_4 from statictext within w_reprint_coil_transfer_certificate
boolean visible = false
integer x = 11
integer y = 10
integer width = 176
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Width"
boolean focusrectangle = false
end type

type st_width from statictext within w_reprint_coil_transfer_certificate
boolean visible = false
integer x = 216
integer y = 10
integer width = 322
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

event clicked;This.Text = String(Parent.Width)
end event

type st_5 from statictext within w_reprint_coil_transfer_certificate
boolean visible = false
integer x = 11
integer y = 86
integer width = 176
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Height"
boolean focusrectangle = false
end type

type st_height from statictext within w_reprint_coil_transfer_certificate
boolean visible = false
integer x = 216
integer y = 86
integer width = 322
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

event clicked;This.Text = String(Parent.Height)
end event

type st_3 from statictext within w_reprint_coil_transfer_certificate
integer x = 1170
integer width = 1638
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reprint Coil Transfer Certificate"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_reprint_coil_transfer_certificate
integer x = 2725
integer y = 394
integer width = 117
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "To"
boolean focusrectangle = false
end type

type st_1 from statictext within w_reprint_coil_transfer_certificate
integer x = 2721
integer y = 307
integer width = 117
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "From"
boolean focusrectangle = false
end type

type em_to from editmask within w_reprint_coil_transfer_certificate
integer x = 2926
integer y = 384
integer width = 285
integer height = 74
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event constructor;//This.Text = String(Today(), "mm/dd/yyyy")
This.Text = "12/31/2100"

end event

type em_from from editmask within w_reprint_coil_transfer_certificate
integer x = 2926
integer y = 307
integer width = 285
integer height = 74
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event constructor;//This.Text = String(Today(), "mm/dd/yyyy")
This.Text = "01/01/1980"

end event

type dw_transfer_performed_by from datawindow within w_reprint_coil_transfer_certificate
integer x = 3207
integer y = 330
integer width = 571
integer height = 77
integer taborder = 60
string dataobject = "d_transfer_performed_by"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type dw_transfer_datetime from datawindow within w_reprint_coil_transfer_certificate
boolean visible = false
integer x = 2651
integer y = 333
integer width = 512
integer height = 77
integer taborder = 50
string dataobject = "d_transfer_datetime"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type dw_coil_abc_num_new from datawindow within w_reprint_coil_transfer_certificate
integer x = 2337
integer y = 330
integer width = 388
integer height = 77
integer taborder = 40
string dataobject = "d_coil_abc_num_new_transfer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type dw_coil_abc_num_orig from datawindow within w_reprint_coil_transfer_certificate
integer x = 1964
integer y = 330
integer width = 380
integer height = 77
integer taborder = 30
string dataobject = "d_coil_abc_num_orig_transfer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type dw_coil_org_num from datawindow within w_reprint_coil_transfer_certificate
integer x = 1584
integer y = 330
integer width = 384
integer height = 77
integer taborder = 20
string dataobject = "d_coil_org_num_transfer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type dw_customer_id_new from datawindow within w_reprint_coil_transfer_certificate
integer x = 955
integer y = 330
integer width = 658
integer height = 77
integer taborder = 10
string dataobject = "d_customer_id_arg"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type dw_customer_id_orig from datawindow within w_reprint_coil_transfer_certificate
integer x = 322
integer y = 330
integer width = 666
integer height = 77
integer taborder = 10
string dataobject = "d_customer_id_arg"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

type dw_coil_ownership_transfer from datawindow within w_reprint_coil_transfer_certificate
integer x = 29
integer y = 486
integer width = 3803
integer height = 1203
integer taborder = 10
string title = "none"
string dataobject = "d_coil_ownership_transfer"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String 	ls_old_sort, ls_column, ls_name
//String	ls_name_temp, ls_coltype
Char 		lc_sort
Long		ll_Col, ll_calendar_x
Boolean	lb_dttm_column_clicked

ls_name = dwo.Name

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		  
		This.SetSort(ls_column + " " + lc_sort)
	Else
		This.SetSort(ls_column + " A")
	End If

	This.Sort()
End If

//---

If row > 0 Then
	This.SelectRow(0, False)
	
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(row, True)
	End If
End If
end event

event doubleclicked;cb_open.Event Clicked()
end event

