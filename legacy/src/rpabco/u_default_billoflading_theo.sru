$PBExportHeader$u_default_billoflading_theo.sru
$PBExportComments$default bill of lading w/ theo WT
forward
global type u_default_billoflading_theo from u_report_object
end type
end forward

global type u_default_billoflading_theo from u_report_object
end type
global u_default_billoflading_theo u_default_billoflading_theo

on u_default_billoflading_theo.create
call super::create
end on

on u_default_billoflading_theo.destroy
call super::destroy
end on

event constructor;call super::constructor;is_objectname = "d_report_bill_lading_display"

istr_dw.width = 3547
istr_dw.length = 2150
istr_dw.v_bar = TRUE
istr_dw.h_bar = TRUE
istr_dw.front = TRUE

RETURN 1
end event

event ue_createreport;call super::ue_createreport;integer li_row, li_totalrow, li_int, li_index, li_detail, li_trow
Boolean lb_exist
Long ll_skid_num
Long ll_total_wt, ll_nwt, ll_twt, ll_shipment_wt, ll_sitem, ll_tnt, ll_tp, ll_p
Int li_prow
s_packing_list_job_info lstr_job_info[]

DataStore lds_sheet, lds_scrap, lds_rejcoil

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

//MessageBox("Warning", "This report is using theo wt")
//li_detail = MessageBox("Question", "Do you want to print descriptions and other details?", Question!, YesNo!, 1)
li_detail = 1

IF li_totalrow > 0 THEN //retrieve order information
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
		SELECT ab_job_num, sheet_theoretical_wt, ref_order_abc_num, ref_order_abc_item INTO :ll_job_num, :ll_net_wt, :ll_ref_order ,:ll_item_num
		FROM sheet_skid
		WHERE sheet_skid_num = :ll_skid_num
		USING SQLCA;
		IF ll_job_num <= 0 THEN Return -2
		IF isNULL(ll_net_wt) THEN ll_net_wt = 0

		int li_i
		lb_exist = FALSE
		IF li_index > 0 THEN
			FOR li_i = 1 TO li_index 
				IF lstr_job_info[li_i].abco_num = ll_job_num THEN
					lstr_job_info[li_i].sub_total_net_wt = lstr_job_info[li_i].sub_total_net_wt + ll_net_wt
					lstr_job_info[li_i].units = lstr_job_info[li_i].units + 1
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

			lstr_job_info[li_index].abco_num = ll_job_num
			lstr_job_info[li_index].orig_po = ls_orig_po
			lstr_job_info[li_index].enduser_po = ls_enduser_po
			lstr_job_info[li_index].part = ls_part_num
			lstr_job_info[li_index].suppliy_code = ls_supplier_code
			lstr_job_info[li_index].gauge = lr_gauge
			lstr_job_info[li_index].width = lr_width
			lstr_job_info[li_index].length = lr_length
			lstr_job_info[li_index].alloy = ls_alloy
			lstr_job_info[li_index].temper = ls_temper
			lstr_job_info[li_index].sub_total_net_wt = ll_net_wt
			lstr_job_info[li_index].units = 1
		END IF
		//end of current skid
	NEXT
END IF

//for each abco job print out each packaging list
String ls_modstring
ll_shipment_wt = 0		//total wt
ll_sitem = 0				//total items

IF li_detail = 1 THEN
	IF li_index = 1 THEN
		li_int = 1
		ls_modstring = "t_orig_po.Text = ~"" + lstr_job_info[li_int].orig_po + "~""	
		idw_requestor.Modify(ls_modstring) 
		ls_modstring = "t_enduser_po.Text = ~"" + lstr_job_info[li_int].enduser_po + "~""
		idw_requestor.Modify(ls_modstring) 
		ls_modstring = "t_part.Text = ~"" + lstr_job_info[li_int].part + "~""
		idw_requestor.Modify(ls_modstring) 
		ls_modstring = "t_suppliy_code.Text = ~"" + lstr_job_info[li_int].suppliy_code + "~""
		idw_requestor.Modify(ls_modstring)
		
		ls_modstring = "t_1_header.Text = ~" Skids of Aluminum Sheets ~""
		idw_requestor.Modify(ls_modstring)	
		//calculate sheet wt
		li_totalrow = lds_sheet.RowCount()
		ll_sitem = ll_sitem + li_totalrow 
		ll_total_wt = 0
		ll_tnt = 0
		ll_tp = 0
		IF li_totalrow > 0 THEN 
			FOR li_int = 1 TO li_totalrow
				ll_nwt = 0
				ll_twt = 0
				ll_p = 0
				ll_skid_num = lds_sheet.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
				
				SELECT sheet_net_wt, sheet_tare_wt, skid_pieces
				INTO :ll_nwt, :ll_twt, :ll_p
				FROM sheet_skid
				WHERE sheet_skid_num = :ll_skid_num
				USING SQLCA;
				
				ll_total_wt = ll_total_wt + ll_nwt + ll_twt
				ll_tp = ll_tp + ll_p
				ll_tnt = ll_tnt + ll_nwt
			NEXT
			//gross wt = String(ll_total_wt, "###,###,###")+ " lbs"	
			//net wt = String(ll_tnt, "###,###,###")+ " lbs"	
			//pieces = String(ll_tp, "###,###,###")
		END IF
		ll_shipment_wt = ll_shipment_wt + ll_total_wt
		
		//end sheet wt
		ls_modstring = "t_1_units.Text = ~"" + String(li_totalrow) + "~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "t_1_skid_wt.Text = ~"" + String(ll_total_wt, "###,###,###")+ " lbs" + "~""
		idw_requestor.Modify(ls_modstring)
		
	ELSE
		IF li_index <= 3 THEN
			ls_modstring = "t_orig_po.Text = ~" Below ~""	
			idw_requestor.Modify(ls_modstring) 
			ls_modstring = "t_enduser_po.Text = ~" Below ~""
			idw_requestor.Modify(ls_modstring) 
			ls_modstring = "t_part.Text = ~" Below ~""
			idw_requestor.Modify(ls_modstring) 
			ls_modstring = "t_suppliy_code.Text = ~" Below ~""
			idw_requestor.Modify(ls_modstring)
			FOR li_int = 1 TO li_index
				ls_modstring = "t_" + String(li_int,"#") + "_note1.Text = ~"CUST PO# " + lstr_job_info[li_int].orig_po + " PART# " + lstr_job_info[li_int].part + "~""	
				idw_requestor.Modify(ls_modstring) 
				ls_modstring = "t_" + String(li_int,"#") + "_note2.Text = ~"PO# " + lstr_job_info[li_int].enduser_po + "SUPPLIER CODE# " + lstr_job_info[li_int].suppliy_code + "~""
				idw_requestor.Modify(ls_modstring) 
		
				ls_modstring = "t_" + String(li_int,"#") + "_header.Text = ~" Skids of Aluminum Sheets ~""
				idw_requestor.Modify(ls_modstring)			
				ls_modstring = "t_" + String(li_int,"#") +"_units.Text = ~"" + String(lstr_job_info[li_int].units) + "~""
				idw_requestor.Modify(ls_modstring)
				ls_modstring = "t_" + String(li_int,"#") +"_skid_wt.Text = ~"" + String(lstr_job_info[li_int].sub_total_net_wt, "###,###,###") + "lbs ~""
				idw_requestor.Modify(ls_modstring)				
			NEXT
		ELSE
			MessageBox("Warning", "This shipment contains more than 3 jobs, select not print details instead" )
			idw_requestor.Reset()
			Return -2
		END IF
		
	END IF
		
	li_prow = lds_scrap.RowCount()
	IF li_prow > 0 THEN
		ls_modstring = "t_scrap_header.Text = ~" Accumulated Scrap Return ~""
		idw_requestor.Modify(ls_modstring)
		//calculate scrap wt
		li_totalrow = 0
		li_totalrow = lds_scrap.RowCount()
		ll_sitem = ll_sitem + li_totalrow 
		ll_total_wt = 0
		ll_tnt = 0
		ll_tp = 0
		IF li_totalrow > 0 THEN 
			FOR li_int = 1 TO li_totalrow
				ll_nwt = 0
				ll_twt = 0
				ll_nwt = lds_scrap.GetItemNumber(li_int, "scrap_skid_scrap_net_wt", Primary!, FALSE)
				ll_twt = lds_scrap.GetItemNumber(li_int, "scrap_skid_scrap_tare_wt", Primary!, FALSE)
				IF IsNULL(ll_twt) THEN ll_twt = 0
				ll_total_wt = ll_total_wt + ll_nwt + ll_twt
				ll_tnt = ll_tnt + ll_twt
			NEXT
		//	String(ll_total_wt, "###,###,###")+ " lbs"	
		//	String(ll_tnt, "###,###,###")+ " lbs"	
		END IF
		ll_shipment_wt = ll_shipment_wt + ll_total_wt
				
		//end of scrap wt
		ls_modstring = "t_scrap_units.Text = ~"" + String(li_totalrow) + "~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "t_scrap_wt.Text = ~"" + String(ll_total_wt, "###,###,###")+ " lbs" + "~""
		idw_requestor.Modify(ls_modstring)
	END IF
	
	li_prow = lds_rejcoil.RowCount()
	IF li_prow > 0 THEN
		ls_modstring = "t_rej_header.Text = ~" Rejected Coil Return ~""
		idw_requestor.Modify(ls_modstring)
		//calculate rejcoil wt
		li_totalrow = 0
		li_totalrow = lds_rejcoil.RowCount()
		ll_sitem = ll_sitem + li_totalrow 
		ll_total_wt = 0
		ll_tnt = 0
		ll_tp = 0
		IF li_totalrow > 0 THEN 
			FOR li_int = 1 TO li_totalrow
				ll_nwt = 0
				ll_nwt = lds_rejcoil.GetItemNumber(li_int, "coil_net_wt_balance", Primary!, FALSE)
				IF IsNULL(ll_nwt) THEN ll_nwt = 0
				ll_total_wt = ll_total_wt + ll_nwt 
			NEXT
		//	net = String(ll_total_wt, "###,###,###")+ " lbs"	
		END IF
		ll_shipment_wt = ll_shipment_wt + ll_total_wt
		
		//end of rejcoil wt
		ls_modstring = "t_rej_units.Text = ~"" + string(li_totalrow) + "~""
		idw_requestor.Modify(ls_modstring)
		ls_modstring = "t_rej_wt.Text = ~"" + String(ll_total_wt, "###,###,###")+ " lbs" + "~""
		idw_requestor.Modify(ls_modstring)
	END IF
	
	ls_modstring = "t_total_wt.Text = ~"" + String(ll_shipment_wt, "###,###,###") + " lbs" + "~""
	idw_requestor.Modify(ls_modstring)
		
END IF

DESTROY lds_sheet
DESTROY lds_scrap
DESTROY lds_rejcoil

Return 1


end event

event ue_groupdwprint;call super::ue_groupdwprint;IF MessageBox("Question", "Print data without frame?", Question!, YesNo!, 1) = 1 THEN
	idw_requestor.Modify("destroy b_lading")
END IF
idw_requestor.Print()

RETURN 1
end event

