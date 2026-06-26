$PBExportHeader$u_johnstown_barcode_scale.sru
$PBExportComments$print johntown barcode from scale
forward
global type u_johnstown_barcode_scale from u_report_object
end type
end forward

global type u_johnstown_barcode_scale from u_report_object
event type integer ue_print_barcode ( long al_shipment,  long al_skid_num )
end type
global u_johnstown_barcode_scale u_johnstown_barcode_scale

type variables
//barcode's initial string
String is_1, is_2, is_3, is_4, is_5, is_6, is_7, is_8

//barcode matrix system
Boolean ib_act_kg
Boolean ib_theo_on
Boolean ib_theo_kg
Boolean ib_size_metric


end variables

forward prototypes
public function long of_get_sh_packing_item_number (long al_shipment, long al_item)
end prototypes

event type integer ue_print_barcode(long al_shipment, long al_skid_num);SetPointer(HourGlass!)

Long ll_job_num, ll_order_num, ll_item_num, ll_orig_cust, ll_enduser, ll_ref_order
String ls_orig_po, ls_enduser_po, ls_supplier_code, ls_part_num
integer  li_skid_items_num
String ls_temper, ls_sheet_type, ls_lot_num, ls_address, ls_name, ls_street
String ls_city, ls_state, ls_zip
Double lr_width, lr_length
integer li_items_this_skid
Double lr_wt, lr_theo_wt, lr_pieces, lr_gauge
String ls_alloy

String ls_place, ls_tplace
DataStore lds_placement
Long ll_prow, ll_p


idw_requestor.Retrieve(al_skid_num)


SELECT a.ab_job_num, a.sheet_theoretical_wt, a.ref_order_abc_num, a.ref_order_abc_item, b.orig_customer_id, b.enduser_id, b.sales_order, b.enduser_po
INTO :ll_job_num, :lr_theo_wt, :ll_ref_order, :ll_item_num, :ll_orig_cust, :ll_enduser, :ls_orig_po, :ls_enduser_po
FROM sheet_skid a, customer_order b
WHERE a.sheet_skid_num = :al_skid_num and a.ref_order_abc_num = b.order_abc_num
USING SQLCA;
IF ll_job_num <= 0 THEN Return -1

//SELECT order_abc_num, order_item_num  INTO :ll_order_num, :ll_item_num
//FROM ab_job
//WHERE ab_job_num = :ll_job_num
//USING SQLCA;
//IF ll_order_num <=  0 THEN Return -2

ll_order_num = ll_ref_order


//MessageBox("ref_order", ll_ref_order)

//SELECT a.orig_customer_id, a.enduser_id, a.orig_customer_po, a.enduser_po 
//INTO :ll_orig_cust, :ll_enduser, :ls_orig_po, :ls_enduser_po
//FROM customer_order a
//WHERE a.order_abc_num = :ll_order_num
//USING SQLCA;




//SELECT customer_full_name, customer_street, customer_city, customer_state, customer_zip
//INTO :ls_name, :ls_street, :ls_city, :ls_state, :ls_zip
//FROM customer
//WHERE customer_id = :ll_orig_cust
//USING SQLCA;
//ls_address = Trim(ls_name) + ",   " + Trim(ls_street) + ",  " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip
//ls_address = Trim(ls_name) + ",   " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip

SELECT customer_full_name, customer_street, customer_city, customer_state, customer_zip
INTO :ls_name, :ls_street, :ls_city, :ls_state, :ls_zip
FROM customer
WHERE customer_id = 
	(SELECT DES_SH_CUST_ID 
	FROM SHIPMENT 
	WHERE PACKING_LIST = :al_shipment)
USING SQLCA;
//ls_address = Trim(ls_name) + ",   " + Trim(ls_street) + ",  " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip
ls_address = Trim(ls_city) + "," + Trim(ls_state) + "  " + ls_zip


SELECT enduser_part_num, alloy2, temper, gauge, sheet_type, supplier_code
INTO :ls_part_num, :ls_alloy, :ls_temper, :lr_gauge, :ls_sheet_type,:ls_supplier_code
FROM order_item
WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
USING SQLCA;


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
		SELECT tr_width INTO :lr_width
		FROM trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 9999 // Trap
	CASE "Right_trapezoid"
		SELECT rtr_width INTO :lr_width
		FROM right_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 9999 // Trap
	CASE "Left_trapezoid"
		SELECT ltr_width INTO :lr_width
		FROM left_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 9999 // Trap
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

lr_wt = 0
lr_pieces = 0
SELECT SUM(production_sheet_item.prod_item_net_wt), SUM(production_sheet_item.prod_item_pieces)
INTO :lr_wt, :lr_pieces
FROM production_sheet_item, sheet_skid_detail
WHERE (sheet_skid_detail.prod_item_num = production_sheet_item.prod_item_num) AND
   	(sheet_skid_detail.sheet_skid_num = :al_skid_num  ) 
USING SQLCA;


SELECT COUNT(prod_item_num) INTO :li_items_this_skid
FROM sheet_skid_detail
WHERE sheet_skid_num = :al_skid_num
USING SQLCA;

//barcode_report
//1st form
String ls_modstring

ls_modstring = "address_1.Text = ~"" + ls_name + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_1_.Text = ~"" + ls_name + "~""
idw_requestor.Modify(ls_modstring)


ls_modstring = "address_2.Text = ~"" + ls_street + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_2_.Text = ~"" + ls_street + "~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "address_3.Text = ~"" + ls_address + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_3_.Text = ~"" + ls_address + "~""
idw_requestor.Modify(ls_modstring)


ls_modstring = "part_num_t.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bar_part_num_t.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
//ls_modstring = "is_2_t.Text = ~"(" + is_2 + ")~"" 
//idw_requestor.Modify(ls_modstring)

ls_modstring = "enduser_po_t.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t_up.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
//ls_modstring = "is_2_t.Text = ~"(" + is_2 + ")~"" 
//idw_requestor.Modify(ls_modstring)

ls_modstring = "serial_t.Text = ~"" + Trim(String(al_skid_num)) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t.Text = ~"*" +  is_6 + Trim(String(al_skid_num)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up.Text = ~"*" + is_6 + Trim(String(al_skid_num)) + "*~""
idw_requestor.Modify(ls_modstring)
//ls_modstring = "is_3_t.Text = ~"(" + is_3 + ")~"" 
//idw_requestor.Modify(ls_modstring)

ls_modstring = "cust_order_t.Text = ~"" + ls_orig_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t.Text = ~"*" + is_4 + ls_orig_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up.Text = ~"*" + is_4 + ls_orig_po + "*~""
idw_requestor.Modify(ls_modstring)
//ls_modstring = "is_4_t.Text = ~"(" + is_4 + ")~"" 
//idw_requestor.Modify(ls_modstring)

/*
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

*/


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
ls_modstring = "bar_actual_t.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_up.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
//ls_modstring = "is_6_t.Text = ~"(" + is_6 + ")~"" 
//idw_requestor.Modify(ls_modstring)

//ls_modstring = "is_7_t.Text = ~"(" + is_7 + ")~"" 
//idw_requestor.Modify(ls_modstring)

/*
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

*/

ls_modstring = "pieces_t.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
//ls_modstring = "is_8_t.Text = ~"(" + is_8 + ")~"" 
//idw_requestor.Modify(ls_modstring)


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
//ls_modstring = "address_t.Text = ~"" + ls_address  + "~""
//idw_requestor.Modify(ls_modstring)

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
ls_modstring = "bar_part_num_t_2.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up_2.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "enduser_po_t_2.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t_2.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t_up_2.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "serial_t_2.Text = ~"" + Trim(String(al_skid_num)) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_2.Text = ~"*" + is_6 + Trim(String(al_skid_num)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up_2.Text = ~"*"  + is_6 + Trim(String(al_skid_num)) + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "cust_order_t_2.Text = ~"" + ls_orig_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_2.Text = ~"*" + is_4 + ls_orig_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up_2.Text = ~"*" + is_4 + ls_orig_po + "*~""
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
ls_modstring = "bar_actual_t_2.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_up_2.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "pieces_t_2.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_2.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up_2.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
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
ls_modstring = "place_t_2.Text = ~"" + ls_place  + "~""
idw_requestor.Modify(ls_modstring)

//ending 2nd barcode form

*/
idw_requestor.Print(TRUE)
idw_requestor.Print(TRUE)

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

on u_johnstown_barcode_scale.create
call super::create
end on

on u_johnstown_barcode_scale.destroy
call super::destroy
end on

event constructor;call super::constructor;is_objectname = "d_report_barcode_johnstown"
li_allowsetup = 1

is_1 = "14K"
is_2 = "P"
is_3 = "Q"
is_4 = "W"
is_5 = "2Q"
is_6 = "S"
is_7 = "1Q"
is_8 = "Q"

ib_act_kg = FALSE
ib_theo_on = FALSE
ib_theo_kg = FALSE
ib_size_metric = FALSE

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
//return 0

Long ll_job_num, ll_order_num, ll_item_num, ll_orig_cust, ll_enduser, ll_ref_order
String ls_orig_po, ls_enduser_po, ls_supplier_code, ls_part_num
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

SELECT a.ab_job_num, a.sheet_theoretical_wt, a.ref_order_abc_num, a.ref_order_abc_item, b.orig_customer_id, b.enduser_id, b.sales_order, b.enduser_po
INTO :ll_job_num, :lr_theo_wt, :ll_ref_order, :ll_item_num, :ll_orig_cust, :ll_enduser, :ls_orig_po, :ls_enduser_po
FROM sheet_skid a, customer_order b
WHERE a.sheet_skid_num = :al_item and a.ref_order_abc_num = b.order_abc_num
USING SQLCA;
IF ll_job_num <= 0 THEN Return -1


ll_order_num = ll_ref_order



SELECT customer_full_name, customer_street, customer_city, customer_state, customer_zip
INTO :ls_name, :ls_street, :ls_city, :ls_state, :ls_zip
FROM customer
WHERE customer_id = 
	(SELECT DES_SH_CUST_ID 
	FROM SHIPMENT 
	WHERE PACKING_LIST = :al_shipment)
USING SQLCA;
//ls_address = Trim(ls_name) + ",   " + Trim(ls_street) + ",  " + Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip
ls_address = Trim(ls_city) + ",  "  + Trim(ls_state) + "  " + ls_zip


SELECT enduser_part_num, alloy2, temper, gauge, sheet_type, supplier_code
INTO :ls_part_num, :ls_alloy, :ls_temper, :lr_gauge, :ls_sheet_type,:ls_supplier_code
FROM order_item
WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
USING SQLCA;


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
		SELECT tr_width INTO :lr_width
		FROM trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 9999 // Trap
	CASE "Right_trapezoid"
		SELECT rtr_width INTO :lr_width
		FROM right_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 9999 // Trap
	CASE "Left_trapezoid"
		SELECT ltr_width INTO :lr_width
		FROM left_trapezoid
		WHERE (order_item_num = :ll_item_num) AND (order_abc_num = :ll_order_num)
		USING SQLCA;
		lr_length = 9999 // Trap
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

//barcode_report
//1st form
String ls_modstring

ls_modstring = "address_1.Text = ~"" + ls_name + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_1_.Text = ~"" + ls_name + "~""
idw_requestor.Modify(ls_modstring)


ls_modstring = "address_2.Text = ~"" + ls_street + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_2_.Text = ~"" + ls_street + "~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "address_3.Text = ~"" + ls_address + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "address_3_.Text = ~"" + ls_address + "~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "part_num_t.Text = ~"" + ls_part_num + "~""
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bar_part_num_t.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "enduser_po_t.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t_up.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "serial_t.Text = ~"" + Trim(String(al_item)) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t.Text = ~"*" + is_6 + Trim(String(al_item)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up.Text = ~"*" + is_6 + Trim(String(al_item)) + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "cust_order_t.Text = ~"" + ls_orig_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t.Text = ~"*" + is_4 + ls_orig_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up.Text = ~"*" + is_4 + ls_orig_po + "*~""
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
ls_modstring = "bar_actual_t.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_up.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "pieces_t.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
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
ls_modstring = "bar_part_num_t_2.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_part_num_t_up_2.Text = ~"*" + is_2 + ls_part_num +"*~"" 
idw_requestor.Modify(ls_modstring)

ls_modstring = "enduser_po_t_2.Text = ~"" + ls_enduser_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t_2.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_enduser_po_t_up_2.Text = ~"*" + is_1 + ls_enduser_po + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "serial_t_2.Text = ~"" + Trim(String(al_item)) + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_2.Text = ~"*" + is_6 + Trim(String(al_item)) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_serial_t_up_2.Text = ~"*"  + is_6 + Trim(String(al_item)) + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "cust_order_t_2.Text = ~"" + ls_orig_po + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_2.Text = ~"*" + is_4 + ls_orig_po + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_cust_order_t_up_2.Text = ~"*" + is_4 + ls_orig_po + "*~""
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
ls_modstring = "bar_actual_t_2.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_actual_t_up_2.Text = ~"*" + is_5 + String(lr_wt, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)

ls_modstring = "pieces_t_2.Text = ~"" + String(lr_pieces, "######") + "~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_2.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
idw_requestor.Modify(ls_modstring)
ls_modstring = "bar_pieces_t_up_2.Text = ~"*" + is_3 + String(lr_pieces, "######" ) + "*~""
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
ls_modstring = "place_t_2.Text = ~"" + ls_place  + "~""
idw_requestor.Modify(ls_modstring)
*/


//ending 2nd barcode form

Return 1

end event

event ue_groupdwprint;call super::ue_groupdwprint;int li_count, li_row
Long ll_skid_num

datastore lds_skid
lds_skid = CREATE datastore  
lds_skid.DataObject = "d_shipment_sheet_skid_list"  
lds_skid.SetTransObject (SQLCA)  
lds_skid.Retrieve(al_shipment)

li_count = lds_skid.RowCount()
IF li_count > 0 THEN
 	FOR li_row = 1 TO li_count
		ll_skid_num = lds_skid.GetItemNumber(li_row, "sheet_skid_num") 
		IF this.Event ue_print_barcode(al_shipment, ll_skid_num) <> 1 THEN RETURN -1
	NEXT
	Return 1
END IF

RETURN 0

end event

