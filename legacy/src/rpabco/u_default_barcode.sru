$PBExportHeader$u_default_barcode.sru
$PBExportComments$default barcode form
forward
global type u_default_barcode from u_report_object
end type
end forward

global type u_default_barcode from u_report_object
event type integer ue_print_barcode ( long al_shipment,  long al_skid_num )
end type
global u_default_barcode u_default_barcode

type variables
//barcode's initial string
String is_1, is_2, is_3, is_4, is_5, is_6, is_7, is_8

//barcode matrix system
Boolean ib_act_on
Boolean ib_act_kg
Boolean ib_theo_on
Boolean ib_theo_kg
Boolean ib_size_metric

Long	il_skids_without_package_num[] //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Boolean	ib_coil_cert_label_req //Alex Gerlants. 09/19/2018. Print cert label
Long		il_delay_ms //Alex Gerlants. 06/12/2019. Ship_Print_Delay
Boolean	ib_suppress_barcode_print //Alex Gerlants. 01/31/2022. 1447_Suppress_Barcode_Printing


end variables

forward prototypes
public function long of_get_sh_packing_item_number (long al_shipment, long al_item)
protected function long uf_set_package_num (long al_ab_job_num, long al_sheet_skid_num, ref u_dw adw)
public function integer of_groupdwprint_4skid (long al_shipment, long al_sheet_skid_num)
end prototypes

event type integer ue_print_barcode(long al_shipment, long al_skid_num);SetPointer(HourGlass!)

Long ll_job_num, ll_order_num, ll_item_num, ll_orig_cust, ll_enduser, ll_ref_order
String ls_orig_po, ls_enduser_po, ls_supplier_code, ls_part_num
integer  li_skid_items_num
String ls_temper, ls_sheet_type, ls_lot_num, ls_address, ls_name, ls_street
String ls_city, ls_state, ls_zip
Real lr_width, lr_length
integer li_items_this_skid
Real lr_pieces,  lr_gauge
Long ll_wt, ll_theo_wt
String ls_alloy
Datetime ld_actual_shipping_date //Alex Gerlants. 06/27/2016
Integer	li_font_size //Alex Gerlants. 06/27/2016

//Alex Gerlants. 02/09/2017. Begin
//Long			ll_special_part_count
//String		ls_part_num_lower
String		ls_customer_full_name, ls_customer_street, ls_customer_city
String		ls_customer_state, ls_customer_zip, ls_print_tier1_address, ls_orig_cust
DataStore	lds_tier1_customer
Long			ll_rows, ll_row, ll_tier1_customer_id
//Alex Gerlants. 02/09/2017. end

String ls_place, ls_tplace
DataStore lds_placement
Long ll_prow, ll_p

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num

idw_requestor.Retrieve(al_skid_num)

SELECT ab_job_num, sheet_theoretical_wt, ref_order_abc_num, ref_order_abc_item
INTO :ll_job_num, :ll_theo_wt, :ll_ref_order, :ll_item_num
FROM sheet_skid
WHERE sheet_skid_num = :al_skid_num
USING SQLCA;
IF ll_job_num <= 0 THEN Return -1

//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
li_rtn = uf_set_package_num(ll_job_num, al_skid_num, idw_requestor)

//If UpperBound(il_skids_without_package_num[]) > 0 Then
//	Return 1 //Do not print this barcode. ue_groupdwprint will display error message.
//End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

SELECT order_abc_num  INTO :ll_order_num
FROM ab_job
WHERE ab_job_num = :ll_job_num
USING SQLCA;
IF ll_order_num <=  0 THEN Return -2

SELECT orig_customer_id, enduser_id, orig_customer_po, enduser_po 
INTO :ll_orig_cust, :ll_enduser, :ls_orig_po, :ls_enduser_po
FROM customer_order
WHERE order_abc_num = :ll_ref_order
USING SQLCA;

SELECT customer_full_name, customer_street, customer_city, customer_state, customer_zip
INTO :ls_name, :ls_street, :ls_city, :ls_state, :ls_zip
FROM customer
WHERE customer_id = :ll_orig_cust
USING SQLCA;
//ls_address = Trim(ls_name) + ",   " + Trim(ls_street) + ",  " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip
ls_address = Trim(ls_name) + ",   " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip

SELECT enduser_part_num, alloy2, temper, gauge, sheet_type, supplier_code
INTO :ls_part_num, :ls_alloy, :ls_temper, :lr_gauge, :ls_sheet_type,:ls_supplier_code
FROM order_item
WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_ref_order)
USING SQLCA;

//Alex Gerlants. 02/09/2017. Begin
ls_orig_cust = String(ll_orig_cust)

select	lower(nvl(value, 'n')) 
into		:ls_print_tier1_address
from		dbo.abis_ini
where		process = 'barcode_tier1_address'
and		section = :ls_orig_cust
and		key = 'print_y_n'
using		sqlca;

If IsNull(ls_print_tier1_address) Then ls_print_tier1_address = "n"

If ls_print_tier1_address = "y" Then
	lds_tier1_customer = Create DataStore
	lds_tier1_customer.DataObject = "d_tier1_customer"
	lds_tier1_customer.SetTransObject(sqlca)
	
	ll_rows = lds_tier1_customer.Retrieve(al_shipment)
	
	For ll_row = 1 To ll_rows
		ll_tier1_customer_id = lds_tier1_customer.Object.tier1_customer_id[ll_row]
		If ll_tier1_customer_id > 0 Then Exit
	Next
	
	If IsValid(lds_tier1_customer) Then Destroy lds_tier1_customer
	
	If ll_tier1_customer_id > 0 Then
		select	ltrim(rtrim(customer.customer_full_name)),
					ltrim(rtrim(customer.customer_street)),
					ltrim(rtrim(customer.customer_city)),
					ltrim(rtrim(customer.customer_state)),
					ltrim(rtrim(customer.customer_zip))
		into		:ls_customer_full_name,
					:ls_customer_street,
					:ls_customer_city,
					:ls_customer_state,
					:ls_customer_zip
		from 		customer
		where 	customer.customer_id = :ll_tier1_customer_id
		using		sqlca;
		
		If sqlca.sqlcode = 0 Then //Row found
			ls_address =	ls_customer_full_name + ", " + &
								ls_customer_city + ", " + &
								ls_customer_state + " " + &
								ls_customer_zip
		End If
	End If
End If
//Alex Gerlants. 02/09/2017. End


CHOOSE CASE Trim(ls_sheet_type)
	CASE "Rectangle"
		SELECT rt_length, rt_width INTO :lr_length, :lr_width
		FROM rectangle
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Reinforcement"
		SELECT re_length, re_width INTO :lr_length, :lr_width
		FROM reinforcement
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Liftgate"
		SELECT li_length, li_width INTO :lr_length, :lr_width
		FROM liftgate_shape
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Parallelogram"
		SELECT p_length, p_width INTO :lr_length, :lr_width
		FROM parallelogram
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Fender"
		SELECT fe_side INTO :lr_width
		FROM fender
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Chevron"
		SELECT ch_length, ch_width INTO :lr_length, :lr_width
		FROM chevron
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Trapezoid"
		SELECT tr_width, tr_long_length INTO :lr_width, :lr_length
		FROM trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		//lr_length = 9999 // Trap
	CASE "Right_trapezoid"
		SELECT rtr_width, rtr_long_length INTO :lr_width, :lr_length
		FROM right_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		//lr_length = 9999 // Trap
	CASE "Left_trapezoid"
		SELECT ltr_width, ltr_long_length INTO :lr_width, :lr_length
		FROM left_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		//lr_length = 9999 // Trap
	CASE "Circle"
		SELECT c_diameter INTO :lr_width
		FROM circle
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 0 
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_width, :lr_length
		FROM x1_shape
		WHERE order_abc_num = :ll_order_num AND order_item_num = :ll_item_num
		USING SQLCA;
	CASE ELSE
		lr_width = 0
		lr_length = 0
END CHOOSE

li_skid_items_num = of_get_sh_packing_item_number(al_shipment, al_skid_num) 

ll_wt = 0
lr_pieces = 0
SELECT SUM(production_sheet_item.prod_item_net_wt), SUM(production_sheet_item.prod_item_pieces)
INTO :ll_wt, :lr_pieces
FROM production_sheet_item, sheet_skid_detail
WHERE (sheet_skid_detail.prod_item_num = production_sheet_item.prod_item_num) AND
   	(sheet_skid_detail.sheet_skid_num = :al_skid_num  ) 
USING SQLCA;


SELECT COUNT(prod_item_num) INTO :li_items_this_skid
FROM sheet_skid_detail
WHERE sheet_skid_num = :al_skid_num
USING SQLCA;

//Alex Gerlants. 06/27/2016. Begin
SELECT shipment_actualed_date_time INTO :ld_actual_shipping_date
FROM shipment
WHERE packing_list = :al_shipment
USING SQLCA;
//Alex Gerlants. 06/27/2016. End

//barcode_report
//1st form
String ls_modstring

//Alex Gerlants. 06/27/2016. Begin
ls_modstring = "shipping_date_t.Text = ~"" + String(ld_actual_shipping_date,"MM/DD/YYYY")  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "shipping_date_large_t.Text = ~"" + String(ld_actual_shipping_date,"MM/DD/YYYY")  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "part_num_large_t.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring)

If Not IsNull(ls_part_num) Then
	li_font_size = f_get_font_size(ls_part_num) //Font: Consolas (Fixed width font)
	
	If li_font_size = -1 Then //Number of characters in ls_part_num is >= 26
		MessageBox("Customer part number longer than expected", &
		"Customer part number " + ls_part_num + " is longer than 25 characters." + &
				"~n~rIt might print on the label smaller than expected.")
		li_font_size = 10
	End If
End If

ls_modstring = "part_num_large_t.font.height='-" + String(li_font_size) + "'"
idw_requestor.Modify(ls_modstring)
//Alex Gerlants. 06/27/2016. End

ls_modstring = "part_num_t.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bar_part_num_t.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_1_t.Text = ~"(" + is_1 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "supplier_t.Text = ~"" + ls_supplier_code + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t_up.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_2_t.Text = ~"(" + is_2 + ")~"" 
idw_requestor.Modify(ls_modstring)

String ls_sheet_skid_display_num
select sheet_skid_display_num into :ls_sheet_skid_display_num
from sheet_skid
where sheet_skid_num = :al_skid_num
using SQLCA;
//ls_modstring = "serial_t.Text = ~"" + Trim(String(al_skid_num)) + "~""
ls_modstring = "serial_t.Text = ~"" + Trim(ls_sheet_skid_display_num) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t.Text = ~"*" + is_3 + Trim(ls_sheet_skid_display_num) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up.Text = ~"*" + is_3 + Trim(ls_sheet_skid_display_num) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_3_t.Text = ~"(" + is_3 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "cust_order_t.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_4_t.Text = ~"(" + is_4 + ")~"" 
idw_requestor.Modify(ls_modstring)

IF li_items_this_skid > 1 THEN
	//skid has mpre than one item on it
	ls_modstring = "heat_t.Text = ~"MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
ELSE
	// single item
	SELECT coil.lot_num INTO :ls_lot_num
	FROM coil, sheet_skid_detail, production_sheet_item
	WHERE ( SHEET_SKID_DETAIL.PROD_ITEM_NUM = PRODUCTION_SHEET_ITEM.PROD_ITEM_NUM ) and  
         ( PRODUCTION_SHEET_ITEM.COIL_ABC_NUM = COIL.COIL_ABC_NUM ) and  
         ( SHEET_SKID_DETAIL.SHEET_SKID_NUM = :al_skid_num )
	USING SQLCA;

	ls_modstring = "heat_t.Text = ~"" + ls_lot_num + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
END IF
ls_modstring = "is_5_t.Text = ~"(" + is_5 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_6_t.Text = ~"(" + is_6 + ")~"" 
idw_requestor.Modify(ls_modstring)
IF ib_act_on THEN
	IF ib_act_kg THEN 
		ll_wt = ll_wt * 0.45359 //if print as KG instead of LB
		ls_modstring = "act_m_t.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "act_m_t_2.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
	ELSE
		ls_modstring = "act_m_t.Text = ~"lbs~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "act_m_t_2.Text = ~"lbs~""
		idw_requestor.Modify(ls_modstring)
	END IF
	ls_modstring = "actual_t.Text = ~"" + String(ll_wt, "######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_actual_t.Text = ~"*" + is_6 + String(ll_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_actual_t_up.Text = ~"*" + is_6 + String(ll_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "actual_t.Text = ~"" + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_actual_t.Text = ~"" + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_actual_t_up.Text = ~"" + "~""
	idw_requestor.Modify(ls_modstring)	
END IF

ls_modstring = "is_7_t.Text = ~"(" + is_7 + ")~"" 
idw_requestor.Modify(ls_modstring)
IF ib_theo_on THEN
	IF ib_theo_kg THEN 
		ll_theo_wt = ll_theo_wt * 0.45359 //KG instead of LB
		ls_modstring = "theo_m_t.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "theo_m_t_2.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
	ELSE
		ls_modstring = "theo_m_t.Text = ~"lbs~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "theo_m_t_2.Text = ~"lbs~""
		idw_requestor.Modify(ls_modstring)
	END IF	
	ls_modstring = "theo_t.Text = ~"" + String(ll_theo_wt, "######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t.Text = ~"*" + is_7 + String(ll_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t_up.Text = ~"*" + is_7 + String(ll_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "theo_t.Text = ~"" + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t.Text = ~"" + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t_up.Text = ~"" + "~""
	idw_requestor.Modify(ls_modstring)	
END IF

//Alex Gerlants. 06/13/2017. Begin
If ib_act_on Then
	If ll_orig_cust = 2802 Then
		ll_theo_wt = ll_theo_wt * 0.45359 //Alex Gerlants. 11/08/2018. Toyota_Tsusho_Barcode_Change. Convert to kg
		ls_modstring = "actual_t.Text = ~"" + String(ll_theo_wt, "######") + "~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "bar_actual_t.Text = ~"*" + is_6 + String(ll_theo_wt, "######" ) + "*~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "bar_actual_t_up.Text = ~"*" + is_6 + String(ll_theo_wt, "######" ) + "*~""
		idw_requestor.Modify(ls_modstring)
		
		//Alex Gerlants. 11/08/2018. Toyota_Tsusho_Barcode_Change. Begin
		ls_modstring = "act_m_t.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "act_m_t_2.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
		//Alex Gerlants. 11/08/2018. Toyota_Tsusho_Barcode_Change. End
	End If
End If
//Alex Gerlants. 06/13/2017. End


ls_modstring = "pieces_t.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_8_t.Text = ~"(" + is_8 + ")~"" 
idw_requestor.Modify(ls_modstring)


ls_modstring = "job_t.Text = ~"" + String(ll_job_num) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "sk_t.Text = ~"" + String(li_skid_items_num) + "~""
idw_requestor.Modify(ls_modstring)
IF NOT(ib_size_metric) THEN
	ls_modstring = "gauge_t.Text = ~"" + String(lr_gauge, "#.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t.Text = ~"" + String(lr_width, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t.Text = ~"" + String(lr_length, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "gauge_t.Text = ~"" + String((lr_gauge * 25.4), "#####.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t.Text = ~"" + String((lr_width * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t.Text = ~"" + String((lr_length * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
END IF	
ls_modstring = "alloy_t.Text = ~"" + ls_alloy + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "temper_t.Text = ~"" + ls_temper  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_t.Text = ~"" + ls_address  + "~""
idw_requestor.Modify(ls_modstring)

IF li_items_this_skid = 1 THEN
	SELECT production_sheet_item.prod_item_placement
	INTO :ls_place
	FROM production_sheet_item, sheet_skid_detail
	WHERE (sheet_skid_detail.prod_item_num = production_sheet_item.prod_item_num) AND
	   	(sheet_skid_detail.sheet_skid_num = :al_skid_num  ) 
	USING SQLCA;
ELSE
	lds_placement = CREATE datastore  
	lds_placement.DataObject = "d_report_barcode_placement"  
	lds_placement.SetTransObject (SQLCA)  
	lds_placement.Retrieve(al_skid_num)
	ll_prow = lds_placement.RowCount()
	SetNULL(ls_place)
	IF ll_prow > 0 THEN
		FOR ll_p = 1 TO ll_prow
			ls_tplace = lds_placement.getItemString(ll_p, "production_sheet_item_prod_item_placemen")
			IF Pos(ls_tplace, ls_place) > 0 OR IsNULL(ls_place) THEN
				ls_place = Trim(ls_tplace)
			ELSE
				IF Pos(ls_place, ls_tplace) = 0 THEN ls_place = ls_place + '/' + Trim(ls_tplace)
			END IF
		NEXT
	END IF
	DESTROY lds_placement
END IF
ls_modstring = "place_t.Text = ~"" + ls_place  + "~""
idw_requestor.Modify(ls_modstring)
	

//end 1st form
/*
//print second barcode from on the same page
ls_modstring = "part_num_t_2.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bar_part_num_t_2.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up_2.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_1_t_2.Text = ~"(" + is_1 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "supplier_t_2.Text = ~"" + ls_supplier_code + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t_2.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t_up_2.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_2_t_2.Text = ~"(" + is_2 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "serial_t_2.Text = ~"" + Trim(String(al_skid_num)) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_2.Text = ~"*" + is_3 + Trim(String(al_skid_num)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up_2.Text = ~"*" + is_3 + Trim(String(al_skid_num)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_3_t_2.Text = ~"(" + is_3 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "cust_order_t_2.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_2.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up_2.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_4_t_2.Text = ~"(" + is_4 + ")~"" 
idw_requestor.Modify(ls_modstring)

IF li_items_this_skid > 1 THEN
	//skid has mpre than one item on it
	ls_modstring = "heat_t_2.Text = ~"MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_2.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up_2.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
ELSE
	// single item
	ls_modstring = "heat_t_2.Text = ~"" + ls_lot_num + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_2.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up_2.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
END IF
ls_modstring = "is_5_t_2.Text = ~"(" + is_5 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "actual_t_2.Text = ~"" + String(ll_wt, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_2.Text = ~"*" + is_6 + String(ll_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_up_2.Text = ~"*" + is_6 + String(ll_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_6_t_2.Text = ~"(" + is_6 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_7_t_2.Text = ~"(" + is_7 + ")~"" 
idw_requestor.Modify(ls_modstring)
IF ib_theo_on THEN
	ls_modstring = "theo_t_2.Text = ~"" + String(ll_theo_wt, "######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t_2.Text = ~"*" + is_7 + String(ll_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t_up_2.Text = ~"*" + is_7 + String(ll_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
END IF


ls_modstring = "pieces_t_2.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_2.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up_2.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_8_t_2.Text = ~"(" + is_8 + ")~"" 
idw_requestor.Modify(ls_modstring)


ls_modstring = "job_t_2.Text = ~"" + String(ll_job_num) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "sk_t_2.Text = ~"" + String(li_skid_items_num) + "~""
idw_requestor.Modify(ls_modstring)
IF NOT(ib_size_metric) THEN
	ls_modstring = "gauge_t_2.Text = ~"" + String(lr_gauge, "#.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t_2.Text = ~"" + String(lr_width, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t_2.Text = ~"" + String(lr_length, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "gauge_t_2.Text = ~"" + String((lr_gauge * 25.4), "####.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t_2.Text = ~"" + String((lr_width * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t_2.Text = ~"" + String((lr_length * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
END IF	
ls_modstring = "alloy_t_2.Text = ~"" + ls_alloy + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "temper_t_2.Text = ~"" + ls_temper  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_t_2.Text = ~"" + ls_address  + "~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "place_t_2.Text = ~"" + ls_place  + "~""
idw_requestor.Modify(ls_modstring)

//ending 2nd barcode form
*/

If Not ib_suppress_barcode_print Then //Alex Gerlants. 01/31/2022. 1447_Suppress_Barcode_Printing
	sleep_ms(il_delay_ms) //Alex Gerlants. 06/12/2019. Ship_Print_Delay
	idw_requestor.Print(TRUE)
End If //Alex Gerlants. 01/31/2022. 1447_Suppress_Barcode_Printing

sleep_ms(il_delay_ms) //Alex Gerlants. 06/12/2019. Ship_Print_Delay
idw_requestor.Print(FALSE)

//Alex Gerlants. 09/19/2018. Print cert label. Begin
If ib_coil_cert_label_req Then
	sleep_ms(il_delay_ms) //Alex Gerlants. 06/12/2019. Ship_Print_Delay
	li_rtn = f_print_cert_label(ll_orig_cust, al_skid_num, ll_order_num, sqlca)
End If
//Alex Gerlants. 09/19/2018. Print cert label. End

Return 1

end event

public function long of_get_sh_packing_item_number (long al_shipment, long al_item);Long ll_item_num

CONNECT USING SQLCA;
SELECT sh_packing_item INTO :ll_item_num
FROM sheet_packing_item
WHERE packing_list = :al_shipment AND sheet_skid_num = :al_item
USING SQLCA;

RETURN ll_item_num
end function

protected function long uf_set_package_num (long al_ab_job_num, long al_sheet_skid_num, ref u_dw adw);//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
/*
Function:	uf_set_package_num
Returns:		integer
Arguments:	value			long	al_ab_job_num
				value			long	al_sheet_skid_num
				reference	u_dw	adw
				
il_skids_without_package_num[] is interrogated in ue_groupdwprint for u_default_barcode to print an error
message if there is a problem with Customer Package Number for any of the skids in a shipment.
*/

Integer	li_rtn = 1
Long		ll_package_num
Boolean	lb_use_package_num
String	ls_modstring

li_rtn = f_get_use_package_num_4job(al_ab_job_num, sqlca, lb_use_package_num)

If li_rtn = 0 Then //OK in f_get_use_package_num_4job(). li_rtn = sqlca.sqlcode in f_get_use_package_num_4job().
	If IsNull(lb_use_package_num) Then lb_use_package_num = False
Else //DB error in f_get_use_package_num_4job(). Error message is in this function.
	lb_use_package_num = False
End If

If lb_use_package_num Then
	select 	nvl(package_num, 0)
	into		:ll_package_num
	from		dbo.sheet_skid_package
	where 	sheet_skid_num = :al_sheet_skid_num
	using		sqlca;
	
	Choose Case sqlca.sqlcode
		Case 0 //Good
			If sqlca.sqlcode = 0 And sqlca.sqlnrows = 1 And Not IsNull(ll_package_num) Then //OK. There is one row in table dbo.sheet_skid_package for sheet_skid_num = :al_sheet_skid_num
				ls_modstring = "package_num_t.Text = ~"Customer Package #: " + String(ll_package_num) + "~""
				adw.Modify(ls_modstring)
			Else //Customer Package Number for this skid number is not populated. Should not happen though
				li_rtn = -1
		
				//Put empty string into package_num_t
				ls_modstring = "package_num_t.Text = ~"" + "" + "~""
				adw.Modify(ls_modstring)
				
				//Collect skid numbers for error message in ue_groupdwprint for u_default_barcode
				il_skids_without_package_num[UpperBound(il_skids_without_package_num[]) + 1] = al_sheet_skid_num
			End If
		Case 100 //Row not found
			li_rtn = -1
		
			//Put empty string into package_num_t
			ls_modstring = "package_num_t.Text = ~"" + "" + "~""
			adw.Modify(ls_modstring)
			
			//Collect skid numbers for error message in ue_groupdwprint for u_default_barcode
			il_skids_without_package_num[UpperBound(il_skids_without_package_num[]) + 1] = al_sheet_skid_num
		Case Else //DB error
			li_rtn = -1
		
			//Put empty string into package_num_t
			ls_modstring = "package_num_t.Text = ~"" + "" + "~""
			adw.Modify(ls_modstring)
			
			//Collect skid numbers for error message in ue_groupdwprint for u_default_barcode
			il_skids_without_package_num[UpperBound(il_skids_without_package_num[]) + 1] = al_sheet_skid_num
	End Choose
End If

Return li_rtn
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
end function

public function integer of_groupdwprint_4skid (long al_shipment, long al_sheet_skid_num);//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. Begin
/*
Function:	of_groupdwprint_4skid
				Print barcode label for one skid
Returns:		integer
Arguments:	value	long	al_shipment
				value	long	al_sheet_skid_num
*/

int li_count, li_row, li_rtn
Long ll_skid_num

li_rtn = PrintSetup()

If li_rtn = -1 Then //User clicked on "Cancel"
	Return 1
End If

ib_coil_cert_label_req = f_coil_cert_label_req(al_shipment, sqlca)

If ib_coil_cert_label_req Then
	li_rtn = f_all_coils_have_863(al_shipment, sqlca)
	
	Choose Case li_rtn
		Case 1 //Good
			//Fall through
		Case 2 //Not all coils in this shipment have EDI 863 information; and user doesn't want to print barcodes
			Return 1
		Case -1 //DB error in f_all_coils_have_863()
			Return -1
	End Choose
End If
//Alex Gerlants. 09/19/2018. Print cert label. End

//Alex Gerlants. 03/25/2025. 2341_Always_Reprint_2Labels. Commented out next line
//ib_suppress_barcode_print = f_suppress_barcode_print(al_shipment, sqlca) //Alex Gerlants. 01/31/2022. 1447_Suppress_Barcode_Printing
ib_suppress_barcode_print = False //Alex Gerlants. 03/25/2025. 2341_Always_Reprint_2Labels

//datastore lds_skid
//lds_skid = CREATE datastore  
//lds_skid.DataObject = "d_shipment_sheet_skid_list"  
//lds_skid.SetTransObject (SQLCA)  
//lds_skid.Retrieve(al_shipment)
//
//li_count = lds_skid.RowCount()
//IF li_count > 0 THEN
// 	FOR li_row = 1 TO li_count
//		ll_skid_num = lds_skid.GetItemNumber(li_row, "sheet_skid_num") 
		li_rtn = this.Event ue_print_barcode(al_shipment, al_sheet_skid_num)
		
		If li_rtn  <> 1 Then
			RETURN -1
		End If
//	NEXT
//	Return 1
//END IF

RETURN 0
//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. End
end function

on u_default_barcode.create
call super::create
end on

on u_default_barcode.destroy
call super::destroy
end on

event constructor;call super::constructor;is_objectname = "d_report_barcode_multiple"
li_allowsetup = 1

is_1 = "P"
is_2 = "V"
is_3 = "S"
is_4 = "A"
is_5 = "1T"
is_6 = "2Q"
is_7 = "1Q"
is_8 = "Q"

ib_act_on = TRUE
ib_act_kg = True //Alex Gerlants. 04/22/2021. 1159_Change_Checkmarks_On_Barcode_Printing_Screen. Changed from FALSE to True
ib_theo_on = FALSE
ib_theo_kg = FALSE
ib_size_metric = True //Alex Gerlants. 04/22/2021. 1159_Change_Checkmarks_On_Barcode_Printing_Screen. Changed from FALSE to True

li_argumenttype = 2 //item

istr_dw.width = 3547
istr_dw.length = 2150
istr_dw.v_bar = TRUE
istr_dw.h_bar = TRUE
istr_dw.front = TRUE

RETURN 1
end event

event ue_setupreport;call super::ue_setupreport;s_barcode_initial lstr_rc

lstr_rc.is_1 = is_1
lstr_rc.is_2 = is_2
lstr_rc.is_3 = is_3
lstr_rc.is_4 = is_4
lstr_rc.is_5 = is_5
lstr_rc.is_6 = is_6
lstr_rc.is_7 = is_7
lstr_rc.is_8 = is_8
lstr_rc.ib_act_kg = ib_act_kg
lstr_rc.ib_theo_on = ib_theo_on
lstr_rc.ib_theo_kg = ib_theo_kg
lstr_rc.ib_act_on = ib_act_on
lstr_rc.ib_size_metric = ib_size_metric

Openwithparm(w_barcode_item_setup, lstr_rc)
lstr_rc = Message.PowerObjectParm

IF IsNULL(lstr_rc) THEN RETURN 0

is_1 = lstr_rc.is_1
is_2 = lstr_rc.is_2
is_3 = lstr_rc.is_3
is_4 = lstr_rc.is_4
is_5 = lstr_rc.is_5
is_6 = lstr_rc.is_6
is_7 = lstr_rc.is_7
is_8 = lstr_rc.is_8
ib_act_kg = lstr_rc.ib_act_kg
ib_theo_on = lstr_rc.ib_theo_on
ib_theo_kg = lstr_rc.ib_theo_kg
ib_act_on = lstr_rc.ib_act_on
ib_size_metric = lstr_rc.ib_size_metric

String ls_modstring
ls_modstring = "is_1_t.Text = ~"( " + is_1 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_1_t_2.Text = ~"( " + is_1 + " )~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_2_t.Text = ~"( " + is_2 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_2_t_2.Text = ~"( " + is_2 + " )~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_3_t.Text = ~"( " + is_3 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_3_t_2.Text = ~"( " + is_3 + " )~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_4_t.Text = ~"( " + is_4 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_4_t_2.Text = ~"( " + is_4 + " )~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_5_t.Text = ~"( " + is_5 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_5_t_2.Text = ~"( " + is_5 + " )~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_6_t.Text = ~"( " + is_6 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_6_t_2.Text = ~"( " + is_6 + " )~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_7_t.Text = ~"( " + is_7 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_7_t_2.Text = ~"( " + is_7 + " )~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_8_t.Text = ~"( " + is_8 + " )~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_8_t_2.Text = ~"( " + is_8 + " )~""
idw_requestor.Modify(ls_modstring)

RETURN 1


end event

event ue_createreport;call super::ue_createreport;SetPointer(HourGlass!)

Long ll_job_num, ll_order_num, ll_item_num, ll_orig_cust, ll_enduser, ll_ref_order
String ls_orig_po, ls_enduser_po, ls_supplier_code, ls_part_num, ls_finished_goods
integer  li_skid_items_num
String ls_temper, ls_sheet_type, ls_lot_num, ls_address, ls_name, ls_street
String ls_city, ls_state, ls_zip
Real lr_width, lr_length
integer li_items_this_skid
Real lr_wt, lr_theo_wt, lr_pieces, lr_gauge
String ls_alloy

String ls_place, ls_tplace
DataStore lds_placement
Long ll_prow, ll_p
Datetime ld_actual_shipping_date //Alex Gerlants. 06/27/2016
Integer	li_font_size //Alex Gerlants. 06/27/2016

//Alex Gerlants. 02/09/2017. Begin
//Long			ll_special_part_count
//String		ls_part_num_lower
String		ls_customer_full_name, ls_customer_street, ls_customer_city
String		ls_customer_state, ls_customer_zip, ls_print_tier1_address, ls_orig_cust
DataStore	lds_tier1_customer
Long			ll_rows, ll_row, ll_tier1_customer_id
//Alex Gerlants. 02/09/2017. end

String	ls_rtn //Alex Gerlants. 06/13/2017

SELECT ab_job_num, sheet_theoretical_wt, ref_order_abc_num, ref_order_abc_item
INTO :ll_job_num, :lr_theo_wt, :ll_ref_order, :ll_item_num
FROM sheet_skid
WHERE sheet_skid_num = :al_item
USING SQLCA;
IF ll_job_num <= 0 THEN Return -1

uf_set_package_num(ll_job_num, al_item, idw_requestor) //Alex Gerlants. 06/15/2018. Arconic_Package_Num


SELECT order_abc_num  INTO :ll_order_num
FROM ab_job
WHERE ab_job_num = :ll_job_num
USING SQLCA;
IF ll_order_num <=  0 THEN Return -2

SELECT orig_customer_id, enduser_id, orig_customer_po, enduser_po 
INTO :ll_orig_cust, :ll_enduser, :ls_orig_po, :ls_enduser_po
FROM customer_order
WHERE order_abc_num = :ll_ref_order
USING SQLCA;

SELECT customer_full_name, customer_street, customer_city, customer_state, customer_zip
INTO :ls_name, :ls_street, :ls_city, :ls_state, :ls_zip
FROM customer
WHERE customer_id = :ll_orig_cust
USING SQLCA;
//ls_address = Trim(ls_name) + ",   " + Trim(ls_street) + ",  " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip
ls_address = Trim(ls_name) + ",   " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip

SELECT enduser_part_num, alloy2, temper, gauge, sheet_type, supplier_code, finished_goods_material_num
INTO :ls_part_num, :ls_alloy, :ls_temper, :lr_gauge, :ls_sheet_type,:ls_supplier_code, :ls_finished_goods
FROM order_item
WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_ref_order)
USING SQLCA;

//Alex Gerlants. 02/09/2017. Begin
ls_orig_cust = String(ll_orig_cust)

select	lower(nvl(value, 'n')) 
into		:ls_print_tier1_address
from		dbo.abis_ini
where		process = 'barcode_tier1_address'
and		section = :ls_orig_cust
and		key = 'print_y_n'
using		sqlca;

If IsNull(ls_print_tier1_address) Then ls_print_tier1_address = "n"

If ls_print_tier1_address = "y" Then
	lds_tier1_customer = Create DataStore
	lds_tier1_customer.DataObject = "d_tier1_customer"
	lds_tier1_customer.SetTransObject(sqlca)
	
	ll_rows = lds_tier1_customer.Retrieve(al_shipment)
	
	For ll_row = 1 To ll_rows
		ll_tier1_customer_id = lds_tier1_customer.Object.tier1_customer_id[ll_row]
		If ll_tier1_customer_id > 0 Then Exit
	Next
	
	If IsValid(lds_tier1_customer) Then Destroy lds_tier1_customer
	
	If ll_tier1_customer_id > 0 Then
		select	ltrim(rtrim(customer.customer_full_name)),
					ltrim(rtrim(customer.customer_street)),
					ltrim(rtrim(customer.customer_city)),
					ltrim(rtrim(customer.customer_state)),
					ltrim(rtrim(customer.customer_zip))
		into		:ls_customer_full_name,
					:ls_customer_street,
					:ls_customer_city,
					:ls_customer_state,
					:ls_customer_zip
		from 		customer
		where 	customer.customer_id = :ll_tier1_customer_id
		using		sqlca;
		
		If sqlca.sqlcode = 0 Then //Row found
			ls_address =	ls_customer_full_name + ", " + &
								ls_customer_city + ", " + &
								ls_customer_state + " " + &
								ls_customer_zip
		End If
	End If
End If
//Alex Gerlants. 02/09/2017. End


CHOOSE CASE Trim(ls_sheet_type)
	CASE "Rectangle"
		SELECT rt_length, rt_width INTO :lr_length, :lr_width
		FROM rectangle
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Reinforcement"
		SELECT re_length, re_width INTO :lr_length, :lr_width
		FROM reinforcement
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Liftgate"
		SELECT li_length, li_width INTO :lr_length, :lr_width
		FROM liftgate_shape
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Parallelogram"
		SELECT p_length, p_width INTO :lr_length, :lr_width
		FROM parallelogram
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Fender"
		SELECT fe_side INTO :lr_width
		FROM fender
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Chevron"
		SELECT ch_length, ch_width INTO :lr_length, :lr_width
		FROM chevron
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
	CASE "Trapezoid"
		SELECT tr_width, tr_long_length INTO :lr_width, :lr_length
		FROM trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		//lr_length = 9999 // Trap
	CASE "Right_trapezoid"
		SELECT rtr_width, rtr_long_length INTO :lr_width, :lr_length
		FROM right_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		//lr_length = 9999 // Trap
	CASE "Left_trapezoid"
		SELECT ltr_width, ltr_long_length INTO :lr_width, :lr_length
		FROM left_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		//lr_length = 9999 // Trap
	CASE "Circle"
		SELECT c_diameter INTO :lr_width
		FROM circle
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 0 
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_width, :lr_length
		FROM x1_shape
		WHERE order_abc_num = :ll_order_num AND order_item_num = :ll_item_num
		USING SQLCA;
	CASE ELSE
		lr_width = 0
		lr_length = 0
END CHOOSE

li_skid_items_num = of_get_sh_packing_item_number(al_shipment, al_item) 

lr_wt = 0
lr_pieces = 0

SELECT SUM(production_sheet_item.prod_item_net_wt), SUM(production_sheet_item.prod_item_pieces)
INTO :lr_wt, :lr_pieces
FROM production_sheet_item, sheet_skid_detail
WHERE (sheet_skid_detail.prod_item_num = production_sheet_item.prod_item_num) AND
   	(sheet_skid_detail.sheet_skid_num = :al_item  ) 
USING SQLCA;


SELECT COUNT(prod_item_num) INTO :li_items_this_skid
FROM sheet_skid_detail
WHERE sheet_skid_num = :al_item
USING SQLCA;

//Alex Gerlants. 06/27/2016. Begin
SELECT shipment_actualed_date_time INTO :ld_actual_shipping_date
FROM shipment
WHERE packing_list = :al_shipment
USING SQLCA;
//Alex Gerlants. 06/27/2016. End

//barcode_report
//1st form
String ls_modstring

//Alex Gerlants. 06/27/2016. Begin
ls_modstring = "shipping_date_t.Text = ~"" + String(ld_actual_shipping_date,"MM/DD/YYYY")  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "shipping_date_large_t.Text = ~"" + String(ld_actual_shipping_date,"MM/DD/YYYY")  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "part_num_large_t.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring)

If Not IsNull(ls_part_num) Then
	li_font_size = f_get_font_size(ls_part_num) //Font: Consolas (Fixed width font)
	
	If li_font_size = -1 Then //Number of characters in ls_part_num is >= 26
		MessageBox("Customer part number longer than expected", &
		"Customer part number " + ls_part_num + " is longer than 25 characters." + &
				"~n~rIt might print on the label smaller than expected.")
		li_font_size = 10
	End If
End If

ls_modstring = "part_num_large_t.font.height='-" + String(li_font_size) + "'"
idw_requestor.Modify(ls_modstring)
//Alex Gerlants. 06/27/2016. End

ls_modstring = "part_num_t.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bar_part_num_t.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_1_t.Text = ~"(" + is_1 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "supplier_t.Text = ~"" + ls_supplier_code + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t_up.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_2_t.Text = ~"(" + is_2 + ")~"" 
idw_requestor.Modify(ls_modstring)

//ls_modstring = "serial_t.Text = ~"" + Trim(String(al_item)) + "~""
//idw_requestor.Modify(ls_modstring)
//ls_modstring = "bar_serial_t.Text = ~"*" + is_3 + Trim(String(al_item)) + "*~""
//idw_requestor.Modify(ls_modstring)
//ls_modstring = "bar_serial_t_up.Text = ~"*" + is_3 + Trim(String(al_item)) + "*~""
//idw_requestor.Modify(ls_modstring)
//ls_modstring = "is_3_t.Text = ~"(" + is_3 + ")~"" 
//idw_requestor.Modify(ls_modstring)
String ls_sheet_skid_display_num
select sheet_skid_display_num into :ls_sheet_skid_display_num
from sheet_skid
where sheet_skid_num = :al_item
using SQLCA;
ls_modstring = "serial_t.Text = ~"" + Trim(ls_sheet_skid_display_num) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t.Text = ~"*" + is_3 + Trim(ls_sheet_skid_display_num) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up.Text = ~"*" + is_3 + Trim(ls_sheet_skid_display_num) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_3_t.Text = ~"(" + is_3 + ")~"" 
idw_requestor.Modify(ls_modstring)


ls_modstring = "cust_order_t.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_4_t.Text = ~"(" + is_4 + ")~"" 
idw_requestor.Modify(ls_modstring)

IF li_items_this_skid > 1 THEN
	//skid has mpre than one item on it
	ls_modstring = "heat_t.Text = ~"MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
ELSE
	// single item
	SELECT coil.lot_num INTO :ls_lot_num
	FROM coil, sheet_skid_detail, production_sheet_item
	WHERE ( SHEET_SKID_DETAIL.PROD_ITEM_NUM = PRODUCTION_SHEET_ITEM.PROD_ITEM_NUM ) and  
         ( PRODUCTION_SHEET_ITEM.COIL_ABC_NUM = COIL.COIL_ABC_NUM ) and  
         ( SHEET_SKID_DETAIL.SHEET_SKID_NUM = :al_item )
	USING SQLCA;

	ls_modstring = "heat_t.Text = ~"" + ls_lot_num + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
END IF
ls_modstring = "is_5_t.Text = ~"(" + is_5 + ")~"" 
idw_requestor.Modify(ls_modstring)

IF ib_act_kg THEN 
	lr_wt = lr_wt * 0.45359 //if print as KG instead of LB
	ls_modstring = "act_m_t.Text = ~"kg~" "
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "act_m_t.Text = ~"lbs~" "
	idw_requestor.Modify(ls_modstring)
END IF
ls_modstring = "actual_t.Text = ~"" + String(lr_wt, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t.Text = ~"*" + is_6 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_up.Text = ~"*" + is_6 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_6_t.Text = ~"(" + is_6 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_7_t.Text = ~"(" + is_7 + ")~"" 
idw_requestor.Modify(ls_modstring)
IF ib_theo_on THEN
	IF ib_theo_kg THEN 
		lr_theo_wt = lr_theo_wt * 0.45359 //KG instead of LB
		ls_modstring = "theo_m_t.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
	ELSE
		ls_modstring = "theo_m_t.Text = ~"lb~""
		idw_requestor.Modify(ls_modstring)
	END IF	
	ls_modstring = "theo_t.Text = ~"" + String(lr_theo_wt, "######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t.Text = ~"*" + is_7 + String(lr_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t_up.Text = ~"*" + is_7 + String(lr_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
END IF

//Alex Gerlants. 06/13/2017. Begin
If ll_orig_cust = 2802 Then
	ls_modstring = "actual_t.Text = ~"" + String(lr_theo_wt, "######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_actual_t.Text = ~"*" + is_6 + String(lr_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_actual_t_up.Text = ~"*" + is_6 + String(lr_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
End If
//Alex Gerlants. 06/13/2017. End


ls_modstring = "pieces_t.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_8_t.Text = ~"(" + is_8 + ")~"" 
idw_requestor.Modify(ls_modstring)


ls_modstring = "job_t.Text = ~"" + String(ll_job_num) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "finished_goods_material_t.Text = ~"" + ls_finished_goods + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "sk_t.Text = ~"" + String(li_skid_items_num) + "~""
idw_requestor.Modify(ls_modstring)
IF NOT(ib_size_metric) THEN
	ls_modstring = "gauge_t.Text = ~"" + String(lr_gauge, "#.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t.Text = ~"" + String(lr_width, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t.Text = ~"" + String(lr_length, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "gauge_t.Text = ~"" + String((lr_gauge * 25.4), "#####.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t.Text = ~"" + String((lr_width * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t.Text = ~"" + String((lr_length * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
END IF	
ls_modstring = "alloy_t.Text = ~"" + ls_alloy + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "temper_t.Text = ~"" + ls_temper  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_t.Text = ~"" + ls_address  + "~""
idw_requestor.Modify(ls_modstring)

IF li_items_this_skid = 1 THEN
	SELECT production_sheet_item.prod_item_placement
	INTO :ls_place
	FROM production_sheet_item, sheet_skid_detail
	WHERE (sheet_skid_detail.prod_item_num = production_sheet_item.prod_item_num) AND
	   	(sheet_skid_detail.sheet_skid_num = :al_item  ) 
	USING SQLCA;
ELSE
	lds_placement = CREATE datastore  
	lds_placement.DataObject = "d_report_barcode_placement"  
	lds_placement.SetTransObject (SQLCA)  
	lds_placement.Retrieve(al_item)
	ll_prow = lds_placement.RowCount()
	SetNULL(ls_place)
	IF ll_prow > 0 THEN
		FOR ll_p = 1 TO ll_prow
			ls_tplace = lds_placement.getItemString(ll_p, "production_sheet_item_prod_item_placemen")
			IF Pos(ls_tplace, ls_place) > 0 OR IsNULL(ls_place) THEN
				ls_place = Trim(ls_tplace)
			ELSE
				IF Pos(ls_place, ls_tplace) = 0 THEN ls_place = ls_place + '/' + Trim(ls_tplace)
			END IF
		NEXT
	END IF
	DESTROY lds_placement
END IF
ls_modstring = "place_t.Text = ~"" + ls_place  + "~""
idw_requestor.Modify(ls_modstring)
	

//end 1st form
/*
//print second barcode from on the same page
ls_modstring = "part_num_t_2.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bar_part_num_t_2.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up_2.Text = ~"*" + is_1 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_1_t_2.Text = ~"(" + is_1 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "supplier_t_2.Text = ~"" + ls_supplier_code + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t_2.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_supplier_t_up_2.Text = ~"*" + is_2 + ls_supplier_code + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_2_t_2.Text = ~"(" + is_2 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "serial_t_2.Text = ~"" + Trim(String(al_item)) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_2.Text = ~"*" + is_3 + Trim(String(al_item)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up_2.Text = ~"*" + is_3 + Trim(String(al_item)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_3_t_2.Text = ~"(" + is_3 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "cust_order_t_2.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_2.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up_2.Text = ~"*" + is_4 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_4_t_2.Text = ~"(" + is_4 + ")~"" 
idw_requestor.Modify(ls_modstring)

IF li_items_this_skid > 1 THEN
	//skid has mpre than one item on it
	ls_modstring = "heat_t_2.Text = ~"MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_2.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up_2.Text = ~"*" + is_5 + "MULTIPLE~""
	idw_requestor.Modify(ls_modstring)
ELSE
	// single item
	ls_modstring = "heat_t_2.Text = ~"" + ls_lot_num + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_2.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_heat_t_up_2.Text = ~"*" + is_5 + ls_lot_num + "*~""
	idw_requestor.Modify(ls_modstring)
END IF
ls_modstring = "is_5_t_2.Text = ~"(" + is_5 + ")~"" 
idw_requestor.Modify(ls_modstring)

IF ib_act_kg THEN 
	lr_wt = lr_wt * 0.45359 //if print as KG instead of LB
	ls_modstring = "act_m_t_2.Text = ~"kg~""
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "act_m_t_2.Text = ~"lbs~""
	idw_requestor.Modify(ls_modstring)
END IF
ls_modstring = "actual_t_2.Text = ~"" + String(lr_wt, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_2.Text = ~"*" + is_6 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_up_2.Text = ~"*" + is_6 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_6_t_2.Text = ~"(" + is_6 + ")~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "is_7_t_2.Text = ~"(" + is_7 + ")~"" 
idw_requestor.Modify(ls_modstring)
IF ib_theo_on THEN
	IF ib_theo_kg THEN 
		lr_theo_wt = lr_theo_wt * 0.45359 //KG instead of LB
		ls_modstring = "theo_m_t_2.Text = ~"kg~""
		idw_requestor.Modify(ls_modstring)
	ELSE
		ls_modstring = "theo_m_t_2.Text = ~"lbs~""
		idw_requestor.Modify(ls_modstring)
	END IF	
	ls_modstring = "theo_t_2.Text = ~"" + String(lr_theo_wt, "######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t_2.Text = ~"*" + is_7 + String(lr_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "bar_theo_t_up_2.Text = ~"*" + is_7 + String(lr_theo_wt, "######" ) + "*~""
	idw_requestor.Modify(ls_modstring)
END IF


ls_modstring = "pieces_t_2.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_2.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up_2.Text = ~"*" + is_8 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "is_8_t_2.Text = ~"(" + is_8 + ")~"" 
idw_requestor.Modify(ls_modstring)


ls_modstring = "job_t_2.Text = ~"" + String(ll_job_num) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "sk_t_2.Text = ~"" + String(li_skid_items_num) + "~""
idw_requestor.Modify(ls_modstring)
IF NOT(ib_size_metric) THEN
	ls_modstring = "gauge_t_2.Text = ~"" + String(lr_gauge, "#.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t_2.Text = ~"" + String(lr_width, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t_2.Text = ~"" + String(lr_length, "#####.####") + "~""
	idw_requestor.Modify(ls_modstring)
ELSE
	ls_modstring = "gauge_t_2.Text = ~"" + String((lr_gauge * 25.4), "####.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "width_t_2.Text = ~"" + String((lr_width * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "length_t_2.Text = ~"" + String((lr_length * 25.4), "########.#") + "~""
	idw_requestor.Modify(ls_modstring)
END IF	
ls_modstring = "alloy_t_2.Text = ~"" + ls_alloy + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "temper_t_2.Text = ~"" + ls_temper  + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_t_2.Text = ~"" + ls_address  + "~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "place_t_2.Text = ~"" + ls_place  + "~""
idw_requestor.Modify(ls_modstring)

//ending 2nd barcode form
*/
Return 1

end event

event ue_groupdwprint;call super::ue_groupdwprint;int li_count, li_row
Long ll_skid_num
Long		ll_empty[], ll_i, ll_sheet_skid_num_temp //Alex Gerlants. 06/15/2018. Arconic_Package_Num
String	ls_sheet_skid_num_string //Alex Gerlants. 06/15/2018. Arconic_Package_Num

//Alex Gerlants. 09/19/2018. Print cert label. Begin
Integer	li_rtn

ib_coil_cert_label_req = f_coil_cert_label_req(al_shipment, sqlca)

If ib_coil_cert_label_req Then
	li_rtn = f_all_coils_have_863(al_shipment, sqlca)
	
	Choose Case li_rtn
		Case 1 //Good
			//Fall through
		Case 2 //Not all coils in this shipment have EDI 863 information; and user doesn't want to print barcodes
			Return 1
		Case -1 //DB error in f_all_coils_have_863()
			Return -1
	End Choose
End If
//Alex Gerlants. 09/19/2018. Print cert label. End

datastore lds_skid
lds_skid = CREATE datastore  
lds_skid.DataObject = "d_shipment_sheet_skid_list"  
lds_skid.SetTransObject (SQLCA)  
lds_skid.Retrieve(al_shipment)

li_count = lds_skid.RowCount()
IF li_count > 0 THEN
	il_skids_without_package_num[] = ll_empty[] //Alex Gerlants. 06/15/2018. Arconic_Package_Num. Initialize il_skids_without_package_num[]
	
	il_delay_ms = f_get_ship_print_delay() //Alex Gerlants. 06/12/2019. Ship_Print_Delay
	
	ib_suppress_barcode_print = f_suppress_barcode_print(al_shipment, sqlca) //Alex Gerlants. 01/31/2022. 1447_Suppress_Barcode_Printing
	
 	FOR li_row = 1 TO li_count
		ll_skid_num = lds_skid.GetItemNumber(li_row, "sheet_skid_num") 
		IF this.Event ue_print_barcode(al_shipment, ll_skid_num) <> 1 THEN RETURN -1
	NEXT
	
	////Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
	////il_skids_without_package_num[] is populated in uf_set_package_num
	//If UpperBound(il_skids_without_package_num[]) > 0 Then
	//	For ll_i = 1 To UpperBound(il_skids_without_package_num[])
	//		ll_sheet_skid_num_temp = il_skids_without_package_num[ll_i]
	//		ls_sheet_skid_num_string = ls_sheet_skid_num_string + String(ll_sheet_skid_num_temp) + ", "
	//	Next
	//	
	//	//Remove the last comma
	//	ls_sheet_skid_num_string = Left(ls_sheet_skid_num_string, Len(ls_sheet_skid_num_string) - 2)
	//	
	//	MessageBox("Problem with Customer Package Number", "There is a problem with Customer Package Number for the following skids " + ls_sheet_skid_num_string + &
	//										"~n~rPlease contact abis support" + &
	//										"~n~r~n~rPlease assign Customer Package Numbers using 'Management/Display/Update Customer Package Number'.", &
	//										Information!)
	//End If
	////Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	
	Return 1
END IF

RETURN 0

end event

event ue_groupdwprint_4skid;call super::ue_groupdwprint_4skid;//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. Begin
/*
Event:		ue_groupdwprint_4skid
Returns:		integer
Arguments:	value	long	al_shipment	
				value	long	al_sheet_skid_num
*/

Integer	li_rtn

li_rtn = of_groupdwprint_4skid(al_shipment, al_sheet_skid_num)

Return li_rtn
//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. End
end event

