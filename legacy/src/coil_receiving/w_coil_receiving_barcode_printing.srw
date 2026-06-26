$PBExportHeader$w_coil_receiving_barcode_printing.srw
$PBExportComments$<Sheet> receive coil and print out barcode_abc_coil_form inherited froam pfemain/w_sheet
forward
global type w_coil_receiving_barcode_printing from w_sheet
end type
type st_bol from statictext within w_coil_receiving_barcode_printing
end type
type st_3 from statictext within w_coil_receiving_barcode_printing
end type
type cb_close from u_cb within w_coil_receiving_barcode_printing
end type
type cb_print from u_cb within w_coil_receiving_barcode_printing
end type
type dw_coil_list from u_dw within w_coil_receiving_barcode_printing
end type
type gb_1 from groupbox within w_coil_receiving_barcode_printing
end type
end forward

global type w_coil_receiving_barcode_printing from w_sheet
integer x = 214
integer width = 3361
integer height = 1443
string title = "Coil Barcode Printing"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 67108864
event type integer ue_print_barcode ( )
event type integer ue_print_barcode_to_handheld ( )
event type long ue_print_barcode_coil_abc_num ( long al_coil_abc_num )
st_bol st_bol
st_3 st_3
cb_close cb_close
cb_print cb_print
dw_coil_list dw_coil_list
gb_1 gb_1
end type
global w_coil_receiving_barcode_printing w_coil_receiving_barcode_printing

event type integer ue_print_barcode();datastore lds_print
Int i, li_rc
string ls_modstring
Long ll_coil_abc_num

lds_print = create datastore
lds_print.DataObject = "d_coil_barcode"
lds_print.SetTransObject(SQLCA)

PrintSetup()
lds_print.object.datawindow.print.orientation = 2
//lds_print.object.datawindow.print.copies = 2

li_rc = dw_coil_list.RowCount()
for i=1 to li_rc
	if (dw_coil_list.GetItemNumber(i, "selected") = 1) then
		ll_coil_abc_num = dw_coil_list.GetItemNumber(i, "coil_coil_abc_num")
		lds_print.Retrieve(ll_coil_abc_num)	
		ls_modstring = "t_coil_abc_num_1.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		ls_modstring = "t_coil_abc_num_2.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		ls_modstring = "t_coil_abc_num_3.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		ls_modstring = "t_coil_abc_num_4.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		ls_modstring = "t_coil_abc_num_5.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		ls_modstring = "t_coil_abc_num_6.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		ls_modstring = "t_coil_abc_num_7.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		ls_modstring = "t_coil_abc_num_8.Text = ~"*2S" + String(ll_coil_abc_num) +"*~""
		lds_print.Modify(ls_modstring)
		lds_print.Print()
	end if
next

return 1
end event

event type integer ue_print_barcode_to_handheld();Int i, li_rc
string ls_modstring
Long ll_coil_abc_num

li_rc = dw_coil_list.RowCount()

if li_rc < 1 then return 0

for i=1 to li_rc
		if (dw_coil_list.GetItemNumber(i, "selected") = 1) then
			ll_coil_abc_num = dw_coil_list.GetItemNumber(i, "coil_coil_abc_num")
			this.event ue_print_barcode_coil_abc_num(ll_coil_abc_num)
		end if
next


return 1
end event

event type long ue_print_barcode_coil_abc_num(long al_coil_abc_num);string httprequest,ls_header
String ls_url,ls_headers
long ll_rc
long ll_length
Blob lblb_args
inet linet
n_ir lir_data	//n_ir  internet request object


linet = CREATE inet

lir_data = CREATE n_ir

ls_url = "http://db02new.albl.com/cgi-bin/coil_receiving.pl?"
lblb_args = blob("print_label_for_coil_abc_num=" + string(al_coil_abc_num))
ll_length = Len(lblb_args)
ls_headers = "Content-Type: " + &
       "application/x-www-form-urlencoded~n" + &
       "Content-Length: " + String( ll_length ) + "~n~n"
ll_rc = linet.PostURL(ls_url,lblb_args,ls_headers,80,lir_data)

return ll_rc
end event

on w_coil_receiving_barcode_printing.create
int iCurrent
call super::create
this.st_bol=create st_bol
this.st_3=create st_3
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_coil_list=create dw_coil_list
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_bol
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.dw_coil_list
this.Control[iCurrent+6]=this.gb_1
end on

on w_coil_receiving_barcode_printing.destroy
call super::destroy
destroy(this.st_bol)
destroy(this.st_3)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_coil_list)
destroy(this.gb_1)
end on

event open;call super::open;//datastore lds_coil_to_be_created
//Int li_rc, li_row_1, li_row_2, li_row_3, li_rc_checked, i, li_checked
//Long ll_damage_fault, ll_damage_code, ll_net_wt, ll_gross_wt
//Long ll_edi_file_id, ll_coil_abc_num
//Real lr_lineal_feed, lr_width, lr_gauge, lr_density
//Int li_coil_incoming_status, li_item_num
//String ls_coil_orig_num, ls_alloy, ls_temper, ls_lot, ls_pack_id, ls_bol
//Long ll_cust
//String ls_user
s_bol_cust ls_bol_cust
String ls_bol
Long ll_cust_id, ll_receiving_bol_id

dw_coil_list.SetTransObject(SQLCA)
//dw_coil_qa_create.SetTransObject(SQLCA)

ls_bol_cust = Message.PowerObjectParm
ls_bol = ls_bol_cust.bol
ll_cust_id = ls_bol_cust.cust

st_bol.text = ls_bol

SELECT "RECEIVING_BOL"."RECEIVING_BOL_ID"  
INTO :ll_receiving_bol_id  
FROM "RECEIVING_BOL"  
WHERE ( "RECEIVING_BOL"."BOL" = :ls_bol ) AND  
      ( "RECEIVING_BOL"."CUSTOMER_ID" = :ll_cust_id )   
      ;

dw_coil_list.Retrieve(ll_receiving_bol_id)

////get data from each coil in lds_coil_to_be_created
//li_rc = lds_coil_to_be_created.RowCount()
//for i = 1 to li_rc
//		//get data from each coil in lds_coil_to_be_created
//		ll_cust = lds_coil_to_be_created.GetItemNumber(i, "customer_id")
//		ls_coil_orig_num = lds_coil_to_be_created.GetItemString(i, "coil_orig_num")
//		li_coil_incoming_status = lds_coil_to_be_created.GetitemNumber(i, "inbound_coil_status")
//		ll_damage_fault = lds_coil_to_be_created.GetItemNumber(i, "damage_fault")
//		ll_damage_code = lds_coil_to_be_created.GetItemNumber(i, "damage_code")
//		ls_alloy = lds_coil_to_be_created.GetItemString(i, "alloy")
//		ls_temper = lds_coil_to_be_created.GetItemString(i, "temper")
//		ll_net_wt = lds_coil_to_be_created.GetItemNumber(i, "net_wt")
//		ll_gross_wt = lds_coil_to_be_created.GetItemNumber(i, "gross_wt")
//		lr_lineal_feed = lds_coil_to_be_created.GetItemNumber(i, "lineal_feed")
//		lr_width = lds_coil_to_be_created.GetItemNumber(i, "width")
//		lr_gauge = lds_coil_to_be_created.GetItemNumber(i, "gauge")
//		lr_density = lds_coil_to_be_created.GetItemNumber(i, "density")
//		ls_lot = lds_coil_to_be_created.GetItemString(i, "lot")
//		ls_pack_id = lds_coil_to_be_created.GetItemString(i, "pack_id")
//		li_item_num = lds_coil_to_be_created.GetItemNumber(i, "item_num")
//		ll_edi_file_id = lds_coil_to_be_created.GetItemNumber(i, "edi_file_id")
//		ls_bol = lds_coil_to_be_created.GetItemString(i, "bol")
//		
//		//insert data in dw_coil_list
//		li_row_1 = dw_coil_list.InsertRow(0)
//		ll_coil_abc_num = f_get_next_value("coil_abc_num_seq")
//		dw_coil_list.SetItem(li_row_1, "COIL_ABC_NUM", ll_coil_abc_num )
//      dw_coil_list.SetItem(li_row_1, "COIL_ORG_NUM",  ls_coil_orig_num) 
//      
//		if (ll_damage_fault=0) and (ll_damage_code=0) then
//			dw_coil_list.SetItem(li_row_1, "COIL_STATUS", 2)	//coil_status: new
//		else
//			dw_coil_list.SetItem(li_row_1, "COIL_STATUS", 11)	//coil_status: qa_onhold
//			li_row_3 = dw_coil_qa_create.InsertRow(0)
//			dw_coil_qa_create.SetItem(li_row_3, "COIL_ABC_NUM", ll_coil_abc_num)
//			dw_coil_qa_create.SetItem(li_row_3, "COIL_TRACK_DATE", Today()) 
//         dw_coil_qa_create.SetItem(li_row_3, "COIL_CUR_STATUS", 11)	//status : 11 qa_onhold  
//         ls_user = gnv_app.of_GetUserId() 
//			dw_coil_qa_create.SetItem(li_row_3, "COIL_MODIFIED_BY", ls_user) 			
//		end if
//
//		dw_coil_list.SetItem(li_row_1, "NET_WT", ll_net_wt)  
//      dw_coil_list.SetItem(li_row_1, "COIL_ALLOY2", ls_alloy) 
//      dw_coil_list.SetItem(li_row_1, "COIL_TEMPER", ls_temper)   
//      dw_coil_list.SetItem(li_row_1, "COIL_GAUGE",  lr_gauge) 
//      dw_coil_list.SetItem(li_row_1, "COIL_WIDTH",  lr_width)
//      dw_coil_list.SetItem(li_row_1, "DATE_RECEIVED", Today())
//      dw_coil_list.SetItem(li_row_1, "NET_WT_BALANCE", ll_net_wt) 
//      dw_coil_list.SetItem(li_row_1, "LOT_NUM", ls_lot)  
//      dw_coil_list.SetItem(li_row_1, "CUSTOMER_ID", ll_cust)  
//      dw_coil_list.SetItem(li_row_1, "COIL_ENTRY_DATE",  Today()) 
//      dw_coil_list.SetItem(li_row_1, "COIL_FROM_CUST_ID", ll_cust) 		
//		dw_coil_list.SetItem(li_row_1, "DAMAGE_CODE", ll_damage_code)  
//      dw_coil_list.SetItem(li_row_1, "DAMAGE_FAULT", ll_damage_fault)  
//		dw_coil_list.SetItem(li_row_1, "COIL_MID_NUM", ls_pack_id)
//		
//		//insert data in dw_inbound_coil_status_update
//		li_row_2 = dw_inbound_coil_status_update.InsertRow(0)		
//		dw_inbound_coil_status_update.SetItem(li_row_2, "EDI_FILE_ID",  ll_edi_file_id) 
//      dw_inbound_coil_status_update.SetItem(li_row_2, "BOL", ls_bol)  
//      dw_inbound_coil_status_update.SetItem(li_row_2, "ITEM_NUM", li_item_num)  
//      dw_inbound_coil_status_update.SetItem(li_row_2, "DAMAGED_CODE", ll_damage_code)  
//      dw_inbound_coil_status_update.SetItem(li_row_2, "DAMAGED_FAULT", ll_damage_fault)  
//      dw_inbound_coil_status_update.SetItem(li_row_2, "STATUS", 1)	//Status: 1 coil created in coil table 
//		
//next
//
//destroy lds_coil_to_be_created
//
//st_bol.Text = ls_bol
//
//dw_coil_list.SelectRow(0, false)
//
//
//
//
//
end event

event pfc_preclose;call super::pfc_preclose;Int li_rc

dw_coil_list.ResetUpdate()

return 1
end event

type st_bol from statictext within w_coil_receiving_barcode_printing
integer x = 644
integer y = 16
integer width = 691
integer height = 77
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_3 from statictext within w_coil_receiving_barcode_printing
integer x = 37
integer y = 16
integer width = 603
integer height = 58
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "ABC Coil(s) from BOL# "
boolean focusrectangle = false
end type

type cb_close from u_cb within w_coil_receiving_barcode_printing
string tag = "Exit"
integer x = 1993
integer y = 1219
integer width = 567
integer height = 96
integer taborder = 20
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)


end event

type cb_print from u_cb within w_coil_receiving_barcode_printing
integer x = 863
integer y = 1219
integer width = 567
integer height = 96
integer taborder = 20
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Print &BarCode"
end type

event clicked;//Parent.Event ue_print_barcode()
Parent.Event ue_print_barcode_to_handheld()
end event

type dw_coil_list from u_dw within w_coil_receiving_barcode_printing
integer x = 40
integer y = 128
integer width = 3226
integer height = 1008
integer taborder = 10
string dataobject = "d_coil_abc_list_by_bol_printing"
boolean hscrollbar = true
end type

event clicked;integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

//IF IsValid (inv_linkage) THEN
//	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
//		inv_linkage.CONTINUE_ACTION Then
//		// The user or a service action prevents from going to the clicked row.
//		Return 1
//	End If
//END IF
//
//
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//disable
Return 0
end event

event pfc_deleterow;call super::pfc_deleterow;Return 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

type gb_1 from groupbox within w_coil_receiving_barcode_printing
integer x = 15
integer y = 80
integer width = 3280
integer height = 1088
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

