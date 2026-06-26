$PBExportHeader$u_default_packinglist.sru
$PBExportComments$default packing list
forward
global type u_default_packinglist from u_report_object
end type
end forward

global type u_default_packinglist from u_report_object
end type
global u_default_packinglist u_default_packinglist

type variables
s_packing_list_job_info istr_job_info[]
s_packing_list_job_info istr_wh_job_info[]

Int ii_index
String is_cust_name
end variables

forward prototypes
public subroutine of_fill_job_details (integer al_items)
public function integer of_fill_header (long al_shipment)
end prototypes

public subroutine of_fill_job_details (integer al_items);Long ll_job_num, ll_order
Real lr_gauge, lr_w, lr_l, lr_s
Int li_item
String ls_temper, ls_desc, ls_shape, ls_alloy
Long ll_i

IF al_items < 1 THEN RETURN

CONNECT USING SQLCA;

FOR ll_i = 1 TO al_items
	ll_job_num = istr_job_info[ll_i].abco_num

	SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
	FROM ab_job 
	WHERE ab_job_num = :ll_job_num
	USING SQLCA;

	SELECT sheet_type, alloy2, temper, order_item_desc, gauge  
	INTO :ls_shape, :ls_alloy, :ls_temper, :ls_desc, :lr_gauge
	FROM order_item
	WHERE order_abc_num = :ll_order AND order_item_num = :li_item
	USING SQLCA;

	IF IsNULL(ls_desc) THEN 
		ls_desc = "  "
	ELSE
		ls_desc = Trim(ls_desc)
	END IF

	//part dimensions should be Width x Length 
	CHOOSE CASE Upper(Trim(ls_shape))
		CASE "RECTANGLE"
			SELECT rt_length, rt_width INTO :lr_l, :lr_w
			FROM rectangle
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "REINFORCEMENT"
			SELECT re_length, re_width INTO :lr_l, :lr_w
			FROM reinforcement
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "LIFTGATE"
			SELECT li_length, li_width INTO :lr_l, :lr_w
			FROM liftgate_shape
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "PARALLELOGRAM"
			SELECT p_length, p_width INTO :lr_l, :lr_w
			FROM parallelogram
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "FENDER"
			SELECT fe_side INTO :lr_l
			FROM fender
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "CHEVRON"
			SELECT ch_length, ch_width INTO :lr_l, :lr_w
			FROM chevron
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "CIRCLE"
			SELECT c_diameter INTO :lr_l
			FROM circle
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "TRAPEZOID"
			SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
			FROM trapezoid
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "L.TRAPEZOID"
			SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
			FROM left_trapezoid
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "R.TRAPEZOID"
			SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
			FROM right_trapezoid
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "OTHER"
			SELECT x_1, x_2 INTO :lr_w, :lr_l
			FROM x1_shape
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE ELSE
			//else
	END CHOOSE	
	
	istr_job_info[ll_i].gauge = lr_gauge
	istr_job_info[ll_i].width = lr_w
	istr_job_info[ll_i].length = lr_l
	istr_job_info[ll_i].alloy = ls_alloy
	istr_job_info[ll_i].temper = ls_temper
NEXT
end subroutine

public function integer of_fill_header (long al_shipment);String ls_modstring
Long ll_bill_lading, ll_des_cust_id, ll_cust_id, ll_carrier_id
DateTime ld_date
String ls_carrier, ls_1, ls_2, ls_3, ls_4, ls_city, ls_state, ls_zip

CONNECT USING SQLCA;
SELECT BILL_OF_LADING, DES_SH_CUST_ID, CUSTOMER_ID, SHIPMENT_ACTUALED_DATE_TIME, Carrier_id
INTO :ll_bill_lading, :ll_des_cust_id, :ll_cust_id, :ld_date, :ll_carrier_id
FROM SHIPMENT  
WHERE PACKING_LIST = :al_shipment    
USING SQLCA;

ls_modstring = "packing_list_t.Text = ~"" + String(al_shipment) + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bar_t.Text = ~"*T" + String(al_shipment) + "*~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bill_lading_t.Text = ~"" + String(ll_bill_lading) + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "date_t.Text = ~"" + String(ld_date, "mm/dd/yyyy hh:mm") + "~""	
idw_requestor.Modify(ls_modstring) 

SELECT carrier_full_name INTO :ls_carrier
FROM carrier
WHERE carrier_id = :ll_carrier_id
USING SQLCA;

ls_modstring = "ship_via_t.Text = ~"" + ls_carrier + "~""	
idw_requestor.Modify(ls_modstring) 

SELECT CUSTOMER_FULL_NAME,CUSTOMER_STREET,CUSTOMER_CITY,CUSTOMER_STATE,CUSTOMER_ZIP  
INTO :ls_1, :ls_2, :ls_city, :ls_state, :ls_zip
FROM CUSTOMER  
WHERE CUSTOMER_ID = :ll_des_cust_id
USING SQLCA;
IF ISNULL(ls_city) THEN ls_city = ""
IF ISNULL(ls_state) THEN ls_state = ""
IF ISNULL(ls_zip) THEN ls_zip = ""
ls_3 = ls_city + ", " + ls_state + "  " + ls_zip

ls_modstring = "shipto_1.Text = ~"" + ls_1 + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "shipto_2.Text = ~"" + ls_2 + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "shipto_3.Text = ~"" + ls_3 + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "shipto_4.Text = ~"" + ls_4 + "~""	
idw_requestor.Modify(ls_modstring) 

SELECT CUSTOMER_FULL_NAME,BILL_TO_STREET,BILL_TO_CITY,BILL_TO_STATE, BILL_TO_ZIP  
INTO :ls_1, :ls_2, :ls_city, :ls_state, :ls_zip
FROM CUSTOMER  
WHERE CUSTOMER_ID = :ll_cust_id 
USING SQLCA;
IF ISNULL(ls_city) THEN ls_city = ""
IF ISNULL(ls_state) THEN ls_state = ""
IF ISNULL(ls_zip) THEN ls_zip = ""
ls_3 = ls_city + ", " + ls_state + "  " + ls_zip

ls_modstring = "soldto_1.Text = ~"" + ls_1 + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "soldto_2.Text = ~"" + ls_2 + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "soldto_3.Text = ~"" + ls_3 + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "soldto_4.Text = ~"" + ls_4 + "~""	
idw_requestor.Modify(ls_modstring) 


RETURN 1
end function

on u_default_packinglist.create
call super::create
end on

on u_default_packinglist.destroy
call super::destroy
end on

event constructor;call super::constructor;is_objectname = "d_report_packing_list_new"

istr_dw.width = 3547
istr_dw.length = 2150
istr_dw.v_bar = TRUE
istr_dw.h_bar = TRUE
istr_dw.front = TRUE

RETURN 1

end event

event ue_createreport;call super::ue_createreport;SetPointer(HourGlass!)
integer li_row, li_totalrow, li_int, li_index, li_trow, li_i
Boolean lb_exist
Long ll_skid_num, ll_custid, ll_jobpc, ll_jobwt, ll_skidpc
Long ll_newrow
Long ll_total_wt, ll_nwt, ll_twt, ll_shipment_wt, ll_shipment_pc, ll_sitem, ll_tnt, ll_tp, ll_p
Int li_prow, li_shipitem_num
String ls_custname, ls_auth_code
Long ll_itempc, ll_itemrow, ll_itemi, ll_itemcoil, ll_itemlot
String ls_coil_orig, ls_coil_lot 

DataStore lds_sheet, lds_scrap, lds_rejcoil, lds_sheetitem

String ls_sheet_skid_display_num, ls_scrap_skid_display_num

lds_sheet = CREATE DataStore
lds_sheet.DataObject = "d_sheetandwh_packing_item"
lds_sheet.SetTransObject (SQLCA)  
lds_sheet.Retrieve(al_shipment)

lds_scrap = CREATE DataStore
lds_scrap.DataObject = "d_scrap_packing_item"
lds_scrap.SetTransObject (SQLCA)  
lds_scrap.Retrieve(al_shipment)

lds_rejcoil = CREATE DataStore
lds_rejcoil.DataObject = "d_rej_coil_packing_item"
lds_rejcoil.SetTransObject (SQLCA)  
lds_rejcoil.Retrieve(al_shipment)

li_totalrow = lds_sheet.RowCount()
li_trow = li_totalrow + lds_scrap.RowCount()
li_trow = li_trow + lds_rejcoil.RowCount()

IF li_trow <= 0 THEN 
	MessageBox("Error", "There is nothing to ship in this shipment!", StopSign!)
	Return -1
END IF

of_fill_header(al_shipment)

CONNECT USING SQLCA;
SELECT customer_id, shipment_athorization_code INTO :ll_custid, :ls_auth_code
FROM shipment 
WHERE packing_list = :al_shipment
USING SQLCA;
SELECT customer_full_name INTO :ls_custname
FROM customer 
WHERE customer_id = :ll_custid
USING SQLCA;
IF IsNULL(ls_custname) THEN ls_custname = " "

IF li_totalrow > 0 THEN //retrieve order information
	ll_newrow = idw_requestor.InsertRow(0)
	idw_requestor.SetItem(ll_newrow, "g_t", Trim(ls_custname) + " Material  Processed" )

	li_index = 0
	FOR li_int = 1 TO li_totalrow
		ll_skid_num = lds_sheet.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		//Retrieve related job info about a skid	

		Long ll_job_num, ll_order_num, ll_item_num, ll_orig_cust, ll_enduser, ll_parent_cust, ll_ref_order
		String ls_orig_po, ls_enduser_po, ls_supplier_code, ls_part_num
		real lr_gauge, lr_width, lr_length
		integer li_skid_items_num
		String ls_temper, ls_sheet_type, ls_cust_name, ls_alloy
		Long ll_net_wt	

		ll_job_num = 0
		SELECT ab_job_num, sheet_net_wt, ref_order_abc_num, ref_order_abc_item INTO :ll_job_num, :ll_net_wt, :ll_ref_order, :ll_item_num
		FROM sheet_skid
		WHERE sheet_skid_num = :ll_skid_num
		USING SQLCA;
		IF ll_job_num <= 0 THEN Return -2

		lb_exist = FALSE
		IF li_index > 0 THEN
			FOR li_i = 1 TO li_index 
				IF istr_job_info[li_i].abco_num = ll_job_num THEN
					istr_job_info[li_i].sub_total_net_wt = istr_job_info[li_i].sub_total_net_wt + ll_net_wt
					istr_job_info[li_i].units = istr_job_info[li_i].units + 1
					lb_exist = TRUE
				END IF	
			NEXT
		END IF
	
		IF NOT(lb_exist) THEN
			//New Job
			ll_order_num = 0
			SELECT order_abc_num  INTO :ll_order_num
			FROM ab_job
			WHERE ab_job_num = :ll_job_num
			USING SQLCA;
			IF ll_order_num <=  0 THEN Return -2	

			SELECT  orig_customer_po, enduser_po 
			INTO  :ls_orig_po, :ls_enduser_po
			FROM customer_order
			WHERE order_abc_num = :ll_ref_order
			USING SQLCA;

			SELECT enduser_part_num,supplier_code 
			INTO :ls_part_num, :ls_supplier_code
			FROM order_item
			WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_ref_order)
			USING SQLCA;

			//packing_list_report table
			li_index = li_index + 1

			istr_job_info[li_index].abco_num = ll_job_num
			istr_job_info[li_index].orig_po = ls_orig_po
			istr_job_info[li_index].enduser_po = ls_enduser_po
			istr_job_info[li_index].part = ls_part_num
			istr_job_info[li_index].suppliy_code = ls_supplier_code
			istr_job_info[li_index].gauge = lr_gauge
			istr_job_info[li_index].width = lr_width
			istr_job_info[li_index].length = lr_length
			istr_job_info[li_index].alloy = ls_alloy
			istr_job_info[li_index].temper = ls_temper
			istr_job_info[li_index].sub_total_net_wt = ll_net_wt
			istr_job_info[li_index].units = 1
		END IF
		//end of current skid
	NEXT
	of_fill_job_details(li_index)
END IF

//for each abco job print out each packaging list
String ls_modstring
ll_shipment_wt = 0		//total wt
ll_shipment_pc = 0
ll_sitem = 0				//total items

IF (li_index = 1) THEN
	li_int = 1
	ls_modstring = "t_abco_num.Text = ~"" + String(istr_job_info[li_int].abco_num) + "~""	
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_orig_po.Text = ~"" + istr_job_info[li_int].orig_po + "~""	
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_enduser_po.Text = ~"" + istr_job_info[li_int].enduser_po + "~""
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_part.Text = ~"" + istr_job_info[li_int].part + "~""
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_suppliy_code.Text = ~"" + istr_job_info[li_int].suppliy_code + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_auth_code.Text = ~"" + ls_auth_code + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_gauge.Text = ~"" + String(istr_job_info[li_int].gauge, "#.######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_width.Text = ~"" + String(istr_job_info[li_int].width, "###,###.###") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_length.Text = ~"" + String(istr_job_info[li_int].length, "###,###.######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_alloy.Text = ~"" + istr_job_info[li_int].alloy + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_temper.Text = ~"" + istr_job_info[li_int].temper + "~""
	idw_requestor.Modify(ls_modstring)
	
	//calculate sheet wt
	li_totalrow = lds_sheet.RowCount()
	ll_sitem = ll_sitem + li_totalrow 
	ll_total_wt = 0
	ll_tnt = 0
	ll_tp = 0
	IF li_totalrow > 0 THEN 
		FOR li_i = 1 TO li_totalrow
			ll_newrow = idw_requestor.InsertRow(0)
			ll_skid_num = lds_sheet.GetItemNumber( li_i, "sheet_skid_num", Primary!, FALSE)
			li_shipitem_num = lds_sheet.GetItemNumber( li_i, "sh_packing_item", Primary!, FALSE)
			idw_requestor.SetItem(ll_newrow, "item_t", String(li_shipitem_num) )
			
			//Replace Sheet_skid_num with Sheet_skid_display_num					
			select sheet_skid_display_num into :ls_sheet_skid_display_num
			from sheet_skid
			where sheet_skid_num = :ll_skid_num
			using SQLCA;			
			idw_requestor.SetItem(ll_newrow, "ticket_t", ls_sheet_skid_display_num)
			//idw_requestor.SetItem(ll_newrow, "ticket_t", String(ll_skid_num))
	
			ll_nwt = 0
			ll_twt = 0
			ll_p = 0
			SELECT sheet_net_wt, sheet_tare_wt, skid_pieces
			INTO :ll_nwt, :ll_twt, :ll_p
			FROM sheet_skid
			WHERE sheet_skid_num = :ll_skid_num
			USING SQLCA;
			
			ll_total_wt = ll_total_wt + ll_nwt + ll_twt
			ll_tp = ll_tp + ll_p
			ll_tnt = ll_tnt + ll_nwt
			
			lds_sheetitem = CREATE DataStore
			lds_sheetitem.DataObject = "d_report_packinglist_sheet_info"
			lds_sheetitem.SetTransObject (SQLCA)  
			lds_sheetitem.Retrieve(ll_skid_num)
			ll_itemrow = lds_sheetitem.RowCount()
			IF ll_itemrow > 0 THEN
				idw_requestor.SetItem(ll_newrow, "lot_t", lds_sheetitem.GetItemString(1, "coil_lot_num"))
				idw_requestor.SetItem(ll_newrow, "coil_t", lds_sheetitem.GetItemString(1, "coil_coil_org_num"))
				idw_requestor.SetItem(ll_newrow, "pcs_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_pieces"),"###,###" ))
				idw_requestor.SetItem(ll_newrow, "ntweight_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt"), "#,###,###"))
				idw_requestor.SetItem(ll_newrow, "comments_t", lds_sheetitem.GetItemString(1, "production_sheet_item_prod_item_note"))
				IF ll_itemrow > 1 THEN
					FOR ll_itemi = 2 TO ll_itemrow
						ll_newrow = idw_requestor.InsertRow(0)
						idw_requestor.SetItem(ll_newrow, "lot_t", lds_sheetitem.GetItemString(ll_itemi, "coil_lot_num"))
						idw_requestor.SetItem(ll_newrow, "coil_t", lds_sheetitem.GetItemString(ll_itemi, "coil_coil_org_num"))
						idw_requestor.SetItem(ll_newrow, "pcs_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_pieces"),"###,###" ))
						idw_requestor.SetItem(ll_newrow, "ntweight_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt"), "#,###,###"))
						idw_requestor.SetItem(ll_newrow, "comments_t", lds_sheetitem.GetItemString(ll_itemi, "production_sheet_item_prod_item_note"))
					NEXT
				END IF
			END IF
			DESTROY lds_sheetitem		
		NEXT

	END IF
	ll_shipment_wt = ll_shipment_wt + ll_tnt
	ll_shipment_pc = ll_shipment_pc + ll_tp
	
	//end sheet wt
	ll_newrow = idw_requestor.InsertRow(0)
	idw_requestor.SetItem(ll_newrow, "coil_t", "subtotal:")
	idw_requestor.SetItem(ll_newrow, "pcs_t",String(ll_tp) )
	idw_requestor.SetItem(ll_newrow, "ntweight_t", String(ll_tnt, "###,###,###") )
	
ELSE   //more than one job
	ls_modstring = "t_abco_num.Text = ~"See below~""	
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_orig_po.Text = ~"See below~""	
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_enduser_po.Text = ~"See below~""
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_part.Text = ~"See below~""
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_suppliy_code.Text = ~"See below~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_auth_code.Text = ~"" + ls_auth_code + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_gauge.Text = ~"See below~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_width.Text = ~"See below~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_length.Text = ~"See below~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_alloy.Text = ~" See~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_temper.Text = ~" below~""
	idw_requestor.Modify(ls_modstring)
	FOR li_int = 1 TO li_index
		ll_newrow = idw_requestor.Insertrow(0)
		ls_modstring = "ABCO No:  " + String(istr_job_info[li_int].abco_num)
		ls_modstring = ls_modstring + "   CUST PO# " + istr_job_info[li_int].orig_po + "   PO# " + istr_job_info[li_int].enduser_po + "   PART# " + istr_job_info[li_int].part + "   Supplier Code: " + istr_job_info[li_int].suppliy_code
		idw_requestor.SetItem(ll_newrow, "g_t", ls_modstring)
		
		idw_requestor.SetItem(ll_newrow,  "item_t", "gauge:")
		idw_requestor.SetItem(ll_newrow, "ticket_t", String(istr_job_info[li_int].gauge, "#.######") )
		idw_requestor.SetItem(ll_newrow, "lot_t", "Width:" + String(istr_job_info[li_int].width, "###,###.###") )
		idw_requestor.SetItem(ll_newrow, "coil_t", "Length:" + String(istr_job_info[li_int].length, "###,###.###") )
		idw_requestor.SetItem(ll_newrow, "pcs_t", "Alloy/temp" )
		idw_requestor.SetItem(ll_newrow, "ntweight_t", istr_job_info[li_int].alloy + "-" + istr_job_info[li_int].temper)
		ll_jobpc = 0
		ll_jobwt = 0
		idw_requestor.InsertRow(0)
		FOR li_i = 1 TO li_totalrow
			ll_skid_num = lds_sheet.GetItemNumber( li_i, "sheet_skid_num", Primary!, FALSE) 	
			SELECT ab_job_num, sheet_net_wt, skid_pieces, sheet_tare_wt INTO :ll_job_num, :ll_net_wt, :ll_skidpc, :ll_twt
			FROM sheet_skid
			WHERE sheet_skid_num = :ll_skid_num
			USING SQLCA;
			IF istr_job_info[li_int].abco_num = ll_job_num THEN
				IF IsNULL(ll_net_wt) THEN ll_net_wt = 0
				IF ISNULL(ll_skidpc) THEN ll_skidpc = 0
				IF ISNULL(ll_twt) THEN ll_twt = 0

				ll_total_wt = ll_total_wt + ll_net_wt + ll_twt
				ll_tp = ll_tp + ll_skidpc
				ll_tnt = ll_tnt + ll_net_wt

				ll_jobpc = ll_jobpc + ll_skidpc
				ll_jobwt = ll_jobwt + ll_net_wt
				
				li_shipitem_num = lds_sheet.GetItemNumber( li_i, "sh_packing_item", Primary!, FALSE)
				ll_newrow = idw_requestor.InsertRow(0)
				idw_requestor.SetItem(ll_newrow, "item_t", String(li_shipitem_num) )
				
				//Replace Sheet_skid_num with Sheet_skid_display_num					
				select sheet_skid_display_num into :ls_sheet_skid_display_num
				from sheet_skid
				where sheet_skid_num = :ll_skid_num
				using SQLCA;			
				idw_requestor.SetItem(ll_newrow, "ticket_t", ls_sheet_skid_display_num)
				
				//idw_requestor.SetItem(ll_newrow, "ticket_t", String(ll_skid_num))
				
				//detail
				lds_sheetitem = CREATE DataStore
				lds_sheetitem.DataObject = "d_report_packinglist_sheet_info"
				lds_sheetitem.SetTransObject (SQLCA)  
				lds_sheetitem.Retrieve(ll_skid_num)
				ll_itemrow = lds_sheetitem.RowCount()
				IF ll_itemrow > 0 THEN
					idw_requestor.SetItem(ll_newrow, "lot_t", lds_sheetitem.GetItemString(1, "coil_lot_num"))
					idw_requestor.SetItem(ll_newrow, "coil_t", lds_sheetitem.GetItemString(1, "coil_coil_org_num"))
					idw_requestor.SetItem(ll_newrow, "pcs_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_pieces"),"###,###" ))
					idw_requestor.SetItem(ll_newrow, "ntweight_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt"), "#,###,###"))
					idw_requestor.SetItem(ll_newrow, "comments_t", lds_sheetitem.GetItemString(1, "production_sheet_item_prod_item_note"))
					IF ll_itemrow > 1 THEN
						FOR ll_itemi = 2 TO ll_itemrow
							ll_newrow = idw_requestor.InsertRow(0)
							idw_requestor.SetItem(ll_newrow, "lot_t", lds_sheetitem.GetItemString(ll_itemi, "coil_lot_num"))
							idw_requestor.SetItem(ll_newrow, "coil_t", lds_sheetitem.GetItemString(ll_itemi, "coil_coil_org_num"))
							idw_requestor.SetItem(ll_newrow, "pcs_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_pieces"),"###,###" ))
							idw_requestor.SetItem(ll_newrow, "ntweight_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt"), "#,###,###"))
							idw_requestor.SetItem(ll_newrow, "comments_t", lds_sheetitem.GetItemString(ll_itemi, "production_sheet_item_prod_item_note"))
						NEXT
					END IF
				END IF
				DESTROY lds_sheetitem						
				//end of detail
			END IF	
		NEXT
		ll_newrow = idw_requestor.InsertRow(0)
		idw_requestor.SetItem(ll_newrow, "coil_t", "subtotal:")
		idw_requestor.SetItem(ll_newrow, "pcs_t",String(ll_jobpc) )
		idw_requestor.SetItem(ll_newrow, "ntweight_t", String(ll_jobwt, "###,###,###") )
		ll_newrow = idw_requestor.InsertRow(0)		
		
		ll_shipment_wt = ll_shipment_wt + ll_jobwt
		ll_shipment_pc = ll_shipment_pc + ll_jobpc
	NEXT
END IF
		
li_prow = lds_scrap.RowCount()
IF li_prow > 0 THEN
	idw_requestor.Insertrow(0)
	ll_newrow = idw_requestor.InsertRow(0)
	idw_requestor.SetItem(ll_newrow, "g_t", Trim(ls_custname) + " Scrap Return" )

	//calculate scrap wt
	li_totalrow = 0
	li_totalrow = lds_scrap.RowCount()
	ll_sitem = ll_sitem + li_totalrow 
	ll_total_wt = 0
	ll_tnt = 0
	ll_tp = 0
	IF li_totalrow > 0 THEN 
		FOR li_i = 1 TO li_totalrow
			ll_newrow = idw_requestor.InsertRow(0)
			ll_nwt = 0
			ll_twt = 0
			ll_nwt = lds_scrap.GetItemNumber(li_i, "scrap_skid_scrap_net_wt", Primary!, FALSE)
			ll_twt = lds_scrap.GetItemNumber(li_i, "scrap_skid_scrap_tare_wt", Primary!, FALSE)
			ll_skid_num = lds_scrap.GetItemNumber(li_i, "scrap_packaging_ticket", Primary!, FALSE)
			li_shipitem_num = lds_scrap.GetItemNumber(li_i, "sc_packing_item", Primary!, FALSE)
			IF IsNULL(ll_twt) THEN ll_twt = 0
			IF IsNULL(ll_nwt) THEN ll_nwt = 0
			ll_total_wt = ll_total_wt + ll_nwt + ll_twt
			ll_tnt = ll_tnt + ll_nwt
			idw_requestor.SetItem(ll_newrow, "item_t", String(li_shipitem_num))
			
			//Replace Scrap_skid_num with Scrap_skid_display_num
			select scrap_skid_display_num into :ls_scrap_skid_display_num
			from scrap_skid
			where scrap_skid_num = :ll_skid_num
			using SQLCA;
			
			idw_requestor.SetItem(ll_newrow, "ticket_t", ls_scrap_skid_display_num)			
			//idw_requestor.SetItem(ll_newrow, "ticket_t", String(ll_skid_num) )
			idw_requestor.SetItem(ll_newrow, "pcs_t", "Scrap")
			idw_requestor.SetItem(ll_newrow, "ntweight_t", String(ll_nwt, "###,###,###") )
		NEXT
	END IF
	ll_shipment_wt = ll_shipment_wt + ll_tnt
			
	ll_newrow = idw_requestor.InsertRow(0)
	idw_requestor.SetItem(ll_newrow, "coil_t", "subtotal:")
	idw_requestor.SetItem(ll_newrow, "ntweight_t", String(ll_tnt, "###,###,###") )
	ll_newrow = idw_requestor.InsertRow(0)		
END IF

li_prow = lds_rejcoil.RowCount()
IF li_prow > 0 THEN
	idw_requestor.Insertrow(0)
	ll_newrow = idw_requestor.InsertRow(0)
	idw_requestor.SetItem(ll_newrow, "g_t", Trim(ls_custname) + " Rejected Coil Return" )

	li_totalrow = 0
	li_totalrow = lds_rejcoil.RowCount()
	ll_sitem = ll_sitem + li_totalrow 
	ll_total_wt = 0
	ll_tnt = 0
	ll_tp = 0
	IF li_totalrow > 0 THEN 
		FOR li_i = 1 TO li_totalrow
			ll_nwt = 0
			ll_nwt = lds_rejcoil.GetItemNumber(li_i, "coil_net_wt_balance", Primary!, FALSE)
			ll_skid_num = lds_rejcoil.GetItemNumber(li_i, "rej_coil_packaging_ticket", Primary!, FALSE)
			li_shipitem_num = lds_rejcoil.GetItemNumber(li_i, "rej_coil_packing_item", Primary!, FALSE)
			ls_coil_orig = lds_rejcoil.GetItemString(li_i, "coil_coil_org_num", Primary!, FALSE)
			ls_coil_lot = lds_rejcoil.GetItemString(li_i, "coil_lot_num", Primary!, FALSE)
			IF IsNULL(ll_nwt) THEN ll_nwt = 0
			ll_total_wt = ll_total_wt + ll_nwt 
			ll_newrow = idw_requestor.InsertRow(0)
			idw_requestor.SetItem(ll_newrow, "item_t", String(li_shipitem_num))
			idw_requestor.SetItem(ll_newrow, "ticket_t", String(ll_skid_num))
			idw_requestor.SetItem(ll_newrow, "lot_t", ls_coil_lot )
			idw_requestor.SetItem(ll_newrow, "coil_t", ls_coil_orig )
			idw_requestor.SetItem(ll_newrow, "ntweight_t", String(ll_nwt, "###,###,###") )
		NEXT
	END IF
	ll_shipment_wt = ll_shipment_wt + ll_total_wt
	
	ll_newrow = idw_requestor.InsertRow(0)
	idw_requestor.SetItem(ll_newrow, "coil_t", "subtotal:")
	idw_requestor.SetItem(ll_newrow, "ntweight_t", String(ll_total_wt, "###,###,###") )
	ll_newrow = idw_requestor.InsertRow(0)		
END IF
	
ll_newrow = idw_requestor.InsertRow(0)
idw_requestor.SetItem(ll_newrow, "pcs_t", "-------------" )
idw_requestor.SetItem(ll_newrow, "ntweight_t", "---------------" )

ll_newrow = idw_requestor.InsertRow(0)
idw_requestor.SetItem(ll_newrow, "coil_t", "TOTAL:")
idw_requestor.SetItem(ll_newrow, "pcs_t", String(ll_shipment_pc) )
idw_requestor.SetItem(ll_newrow, "ntweight_t", String(ll_shipment_wt, "###,###,###") )

DESTROY lds_sheet
DESTROY lds_scrap
DESTROY lds_rejcoil


Return 1
end event

event ue_groupdwprint;call super::ue_groupdwprint;SetPointer(HourGlass!)
idw_requestor.Print()
Return 1
end event

