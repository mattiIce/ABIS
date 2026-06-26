$PBExportHeader$u_default_combi_1999_actual.sru
$PBExportComments$default abco packinglist & billoflading combination  form actual wt only
forward
global type u_default_combi_1999_actual from u_report_object
end type
end forward

global type u_default_combi_1999_actual from u_report_object
event ue_multi_jobs ( long al_shipment )
event type integer ue_print_scrap ( long al_shipment )
event type integer ue_print_coil ( long al_shipment )
event type integer ue_print_sheetskid ( long al_shipment )
end type
global u_default_combi_1999_actual u_default_combi_1999_actual

type variables
s_packing_list_job_info istr_job_info[]

Int ii_index
String is_cust_name

Long il_totalgross
Long il_shippc
Long il_shipnet
Long il_shipnet_kg
Long il_shiptheo
Long il_shiptheo_kg
Long il_shiptare
Long il_shiptare_kg

DataStore ids_sheet, ids_scrap, ids_rejcoil

String is_deliver, is_package
String is_ref_1, is_ref_2, is_note_1, is_note_2, is_note_3, is_cust_order
end variables

forward prototypes
public subroutine of_fill_job_details (integer al_items)
public function integer of_fill_header (long al_shipment)
public function integer of_fill_print_header (datastore ads_print, long al_shipment)
public function integer of_reject_return_coil ()
end prototypes

event ue_multi_jobs;Int li_totalrow
Long ll_row
String ls_ref

li_totalrow = ids_sheet.RowCount()
li_totalrow = li_totalrow + ids_scrap.RowCount()
li_totalrow = li_totalrow + ids_rejcoil.RowCount()

ll_row = idw_requestor.GetRow()
IF ll_row > 0 THEN 
	is_deliver = idw_requestor.GetItemString(ll_row, "deliver_t", Primary!, FALSE)
	is_ref_1 = idw_requestor.GetItemString(ll_row, "ref1_t", Primary!, FALSE)	
	is_ref_2 = idw_requestor.GetItemString(ll_row, "ref2_t", Primary!, FALSE)
	is_note_1 = idw_requestor.GetItemString(ll_row, "note1_t", Primary!, FALSE)
	is_note_2 = idw_requestor.GetItemString(ll_row, "note2_t", Primary!, FALSE)
	is_note_3 = idw_requestor.GetItemString(ll_row, "note3_t", Primary!, FALSE)
	is_package = idw_requestor.GetItemString(ll_row, "package_t", Primary!, FALSE)
	is_cust_order = idw_requestor.GetItemString(ll_row, "cust_order", Primary!, FALSE)
	IF ISNULL(is_deliver) THEN is_deliver = " "
	IF ISNULL(is_ref_1) THEN is_ref_1 = " "
	IF ISNULL(is_ref_2) THEN is_ref_2 = " " 
	IF ISNULL(is_note_1) THEN is_note_1 = " " 
	IF ISNULL(is_note_2) THEN is_note_2 = " " 
	IF ISNULL(is_note_3) THEN is_note_3 = " " 
	IF ISNULL(is_package) THEN is_package = " " 
	IF ISNULL(is_cust_order) THEN is_cust_order = " "
	ls_ref = is_deliver + "~v" + is_package + "~v" + is_cust_order + "~v" + is_ref_1 + "~v" + is_ref_2 + "~v" + is_note_1+ "~v" + is_note_2 + "~v" + is_note_3 + "~v"
	CONNECT USING SQLCA;
	UPDATE shipment
	SET shipment_reference_codes = :ls_ref
	WHERE packing_list = :al_shipment
	USING SQLCA;
END IF

IF li_totalrow > 0 THEN

	il_shippc = 0
	il_shipnet = 0
	il_shiptheo = 0
	il_shiptare = 0
	il_shipnet_kg = 0
	il_shiptheo_kg = 0
	il_shiptare_kg = 0

	IF ids_scrap.RowCount() > 0 THEN		
		this.Event ue_print_scrap(al_shipment)
	END IF
	
	IF ids_rejcoil.RowCount() > 0 THEN
		this.Event ue_print_coil(al_shipment)
	END IF

	IF UpperBound(istr_job_info) > 0 THEN
		this.Event ue_print_sheetskid(al_shipment)
	END IF
	
END IF

RETURN 

end event

event type integer ue_print_scrap(long al_shipment);Datastore lds_print
Int li_i, li_totalrow
String ls_temp,ls_modstring
Long ll_jobnet, ll_jobtare, ll_jobnet_kg, ll_jobtare_kg
Int li_shipitem_num, li_skidcount
Long ll_newrow
Long ll_nwt, ll_twt, ll_skid_num
String ls_alloy
String ls_scrap_skid_display_num
String	ls_scrap_notes //Alex Gerlants. 05/02/2022. 1539_Add_Scrap_Notes_2Scrap_BOL

lds_print = CREATE datastore  
lds_print.DataObject = "d_report_abco_combi_form_display"  
lds_print.SetTransObject (SQLCA) 
lds_print.Retrieve(al_shipment)

li_totalrow = ids_sheet.RowCount()
li_totalrow = li_totalrow + ids_scrap.RowCount()
li_totalrow = li_totalrow + ids_rejcoil.RowCount()

IF ids_scrap.RowCount() > 0 THEN		
	//fill header
	of_fill_print_header(lds_print, al_shipment)
	ls_modstring = "pack_no_t.Text = ~"" + String(li_totalrow) + "~""	
	lds_print.Modify(ls_modstring) 
	li_skidcount = ids_sheet.rowCount()
	IF li_skidcount > 0 THEN ls_temp = String(li_skidcount) + " Aluminum Blanks  "
	li_skidcount = ids_scrap.rowCount()
	IF li_skidcount > 0 THEN ls_temp = ls_temp + String(li_skidcount) +  " Return Scraps "
	li_skidcount = ids_rejcoil.rowCount() 
	IF li_skidcount > 0 THEN ls_temp = ls_temp +  String(li_skidcount) + " Rejected Coils "
	ls_modstring = "pack_desc_t.Text = ~"" + ls_temp + "~""	
	lds_print.Modify(ls_modstring) 
	ls_modstring = "total_wt_t.Text = ~"" + String(il_totalgross, "###,###,###") + "~""	
	lds_print.Modify(ls_modstring) 
	//end of header

	ll_jobnet = 0
	ll_jobtare = 0
	ll_jobnet_kg = 0
	ll_jobtare_kg = 0
	FOR li_i = 1 TO ids_scrap.RowCount()
		ll_newrow = lds_print.InsertRow(0)
		ll_nwt = 0
		ll_twt = 0
		ll_nwt = ids_scrap.GetItemNumber(li_i, "scrap_skid_scrap_net_wt", Primary!, FALSE)
		ll_twt = ids_scrap.GetItemNumber(li_i, "scrap_skid_scrap_tare_wt", Primary!, FALSE)
		ll_skid_num = ids_scrap.GetItemNumber(li_i, "scrap_packaging_ticket", Primary!, FALSE)
		li_shipitem_num = ids_scrap.GetItemNumber(li_i, "sc_packing_item", Primary!, FALSE)
		ls_alloy = ids_scrap.GetItemString(li_i, "scrap_skid_scrap_alloy2", Primary!, FALSE)
		
		ls_scrap_notes = ids_scrap.Object.scrap_notes[li_i] //Alex Gerlants. 05/02/2022. 1539_Add_Scrap_Notes_2Scrap_BOL
		If IsNull(ls_scrap_notes) Then ls_scrap_notes = "" //Alex Gerlants. 05/02/2022. 1539_Add_Scrap_Notes_2Scrap_BOL
		
		IF IsNULL(ll_twt) THEN ll_twt = 0
		IF IsNULL(ll_nwt) THEN ll_nwt = 0
		ll_jobnet = ll_jobnet + ll_nwt 
		ll_jobtare = ll_jobtare + ll_twt
		il_shipnet = il_shipnet + ll_nwt
		il_shiptare = il_shiptare + ll_twt
		lds_print.SetItem(ll_newrow, "item_t", String(li_shipitem_num))
		
		//Replace Scrap_skid_num with Scrap_skid_display_num
		select scrap_skid_display_num into :ls_scrap_skid_display_num
		from scrap_skid
		where scrap_skid_num = :ll_skid_num
		using SQLCA;							
		
		//lds_print.SetItem(ll_newrow, "ticket_t", String(ll_skid_num))
		lds_print.SetItem(ll_newrow, "ticket_t", ls_scrap_skid_display_num)
		lds_print.SetItem(ll_newrow, "pcs_t", "Scrap")
		lds_print.SetItem(ll_newrow, "ntweight_t", String(ll_nwt, "###,###,###") )
		lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(ll_nwt*0.453592, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_t", String(ll_twt, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_kg_t", String(ll_twt*0.453592, "###,###,###") )
		ll_jobnet_kg = ll_jobnet_kg + Long(String(ll_nwt*0.453592, "###,###,###"))
		il_shipnet_kg = il_shipnet_kg + Long(String(ll_nwt*0.453592, "###,###,###") )
		ll_jobtare_kg = ll_jobtare_kg + Long(String(ll_twt*0.453592, "###,###,###") )
		il_shiptare_kg = il_shiptare_kg + Long(String(ll_twt*0.453592, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_t", String((ll_nwt+ll_twt), "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_kg_t", String((Long(String(ll_nwt*0.453592, "###,###,###")) + Long(String(ll_twt*0.453592, "###,###,###"))),"###,###,###") ) 
		lds_print.SetItem(ll_newrow, "comments_t", ls_alloy ) 
		lds_print.SetItem(ll_newrow, "comments_2", ls_scrap_notes) //Alex Gerlants. 05/02/2022. 1539_Add_Scrap_Notes_2Scrap_BOL
	NEXT

	IF (ids_sheet.rowCount() > 0) OR (ids_rejcoil.rowCount() > 0)  THEN
		ll_newrow = lds_print.InsertRow(0)
		lds_print.SetItem(ll_newrow, "coil_t", "subtotal:")
		lds_print.SetItem(ll_newrow, "ntweight_t", String(ll_jobnet, "###,###,###") )
		lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(ll_jobnet_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_t", String(ll_jobtare, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_kg_t", String(ll_jobtare_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_t", String((ll_jobnet + ll_jobtare), "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_kg_t", String((ll_jobnet_kg + ll_jobtare_kg), "###,###,###") )
	END IF
	IF (ids_sheet.rowCount() = 0)  AND (ids_rejcoil.RowCount() = 0) THEN 
		ll_newrow = lds_print.InsertRow(0)
		ll_newrow = lds_print.InsertRow(0)
		lds_print.SetItem(ll_newrow, "coil_t", "TOTAL:")
		lds_print.SetItem(ll_newrow, "pcs_t",String(il_shippc) )
		lds_print.SetItem(ll_newrow, "ntweight_t", String(il_shipnet, "###,###,###") )
		lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(il_shipnet_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "theowt_t", String(il_shiptheo, "###,###,###") )
		lds_print.SetItem(ll_newrow, "theowt_kg_t", String(il_shiptheo_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_t", String(il_shiptare, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_kg_t", String(il_shiptare_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_t", String((il_shipnet + il_shiptare), "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_kg_t", String((il_shipnet_kg + il_shiptare_kg), "###,###,###") )
	END IF
	
	//Alex Gerlants. 10/21/2019. Rename PDF File. Begin
	Integer li_rc
	
	li_rc = f_rename_and_print_datastore(al_shipment, lds_print)
	
	//lds_print.Print(TRUE) //Alex Gerlants. Comment out
   //Alex Gerlants. 10/21/2019. Rename PDF File. End
END IF

DESTROY lds_print

RETURN 1

end event

event type integer ue_print_coil(long al_shipment);Int li_totalrow, li_i, li_skidcount

Datastore lds_print
String ls_temp, ls_modstring
Long ll_jobnet, ll_jobnet_kg
Int li_s, li_shipitem_num
Long ll_newrow
Long ll_nwt, ll_skid_num
String ls_coil_orig, ls_coil_lot
Long ll_coil
String ls_alloy, ls_temper
Real lr_width, lr_gauge

lds_print = CREATE datastore  
lds_print.DataObject = "d_report_abco_combi_form_display"  
lds_print.SetTransObject (SQLCA)
lds_print.retrieve(al_shipment)

li_totalrow = ids_sheet.RowCount()
li_totalrow = li_totalrow + ids_scrap.RowCount()
li_totalrow = li_totalrow + ids_rejcoil.RowCount()

IF ids_rejcoil.rowCount() > 0 THEN
	//fill header
	of_fill_print_header(lds_print, al_shipment)
	ls_modstring = "pack_no_t.Text = ~"" + String(li_totalrow) + "~""	
	lds_print.Modify(ls_modstring) 
	li_skidcount = ids_sheet.rowCount() 
	IF li_skidcount > 0 THEN ls_temp = String(li_skidcount) + " Aluminum Blanks  "
	li_skidcount = ids_scrap.rowCount()
	IF li_skidcount > 0 THEN ls_temp = ls_temp + String(li_skidcount) +  " Return Scraps "
	li_skidcount = ids_rejcoil.RowCount()
	CHOOSE CASE of_reject_return_coil()
		CASE 0 //nothing
		CASE 1
			ls_temp = ls_temp +  String(li_skidcount) + " Rejected and Return Coils "
		CASE 2
			ls_temp = ls_temp +  String(li_skidcount) + " Rejected Coil(s) "
		CASE 3
			ls_temp = ls_temp +  String(li_skidcount) + "  Return Coil(s) "
	END CHOOSE
	ls_modstring = "pack_desc_t.Text = ~"" + ls_temp + "~""	
	lds_print.Modify(ls_modstring) 
	ls_modstring = "total_wt_t.Text = ~"" + String(il_totalgross, "###,###,###") + "~""	
	lds_print.Modify(ls_modstring) 
	//end of header

	ll_jobnet = 0
	ll_jobnet_kg = 0
	FOR li_i = 1 TO ids_rejcoil.RowCount()
		ll_nwt = 0
		ll_nwt = ids_rejcoil.GetItemNumber(li_i, "coil_net_wt_balance", Primary!, FALSE)
		ll_skid_num = ids_rejcoil.GetItemNumber(li_i, "rej_coil_packaging_ticket", Primary!, FALSE)
		li_shipitem_num = ids_rejcoil.GetItemNumber(li_i, "rej_coil_packing_item", Primary!, FALSE)
		ls_coil_orig = ids_rejcoil.GetItemString(li_i, "coil_coil_org_num", Primary!, FALSE)
		ls_coil_lot = ids_rejcoil.GetItemString(li_i, "coil_lot_num", Primary!, FALSE)
		ll_coil = ids_rejcoil.GetItemNumber(li_i, "coil_abc_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		SELECT coil_alloy2, coil_temper, coil_gauge, coil_width
		INTO :ls_alloy, :ls_temper, :lr_gauge, :lr_width
		FROM coil
		WHERE coil_abc_num = :ll_coil
		USING SQLCA;
		IF IsNULL(ll_nwt) THEN ll_nwt = 0
		ll_jobnet = ll_jobnet + ll_nwt 
		il_shipnet = il_shipnet + ll_nwt
		ll_newrow = lds_print.InsertRow(0)
		lds_print.SetItem(ll_newrow, "item_t", String(li_shipitem_num))
		lds_print.SetItem(ll_newrow, "ticket_t", String(ll_skid_num))
		lds_print.SetItem(ll_newrow, "lot_t", ls_coil_lot )
		lds_print.SetItem(ll_newrow, "coil_t", ls_coil_orig )
		lds_print.SetItem(ll_newrow, "ntweight_t", String(ll_nwt, "###,###,###") )
		lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(ll_nwt*0.453592, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_t", String(ll_nwt, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_kg_t", String(ll_nwt*0.453592, "###,###,###") )
		lds_print.SetItem(ll_newrow, "comments_t", ls_alloy + "-" + ls_temper )
		lds_print.SetItem(ll_newrow, "comments_2", String(lr_gauge, "#.####") + " X " + String(lr_width, "######.###") )
		ll_jobnet_kg = ll_jobnet_kg + Long(String(ll_nwt*0.453592, "###,###,###") )
		il_shipnet_kg = il_shipnet_kg + Long(String(ll_nwt*0.453592, "###,###,###") )
	NEXT
		
	IF (ids_sheet.rowCount() > 0) OR (ids_scrap.rowCount() > 0) THEN
		ll_newrow = lds_print.InsertRow(0)
		lds_print.SetItem(ll_newrow, "coil_t", "subtotal:")
		lds_print.SetItem(ll_newrow, "ntweight_t", String(ll_jobnet, "###,###,###") )
		lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(ll_jobnet_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_t", String(ll_jobnet, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_kg_t", String(ll_jobnet_kg, "###,###,###") )
	END IF
	IF (ids_sheet.rowCount() = 0)  THEN 
		ll_newrow = lds_print.InsertRow(0)
		ll_newrow = lds_print.InsertRow(0)
		lds_print.SetItem(ll_newrow, "coil_t", "TOTAL:")
		lds_print.SetItem(ll_newrow, "pcs_t",String(il_shippc) )
		lds_print.SetItem(ll_newrow, "ntweight_t", String(il_shipnet, "###,###,###") )
		lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(il_shipnet_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "theowt_t", String(il_shiptheo, "###,###,###") )
		lds_print.SetItem(ll_newrow, "theowt_kg_t", String(il_shiptheo_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_t", String(il_shiptare, "###,###,###") )
		lds_print.SetItem(ll_newrow, "tarewt_kg_t", String(il_shiptare_kg, "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_t", String((il_shipnet + il_shiptare), "###,###,###") )
		lds_print.SetItem(ll_newrow, "grosswt_kg_t", String((il_shipnet_kg + il_shiptare_kg), "###,###,###") )
	END IF

	//Alex Gerlants. 10/21/2019. Rename PDF File. Begin
	Integer li_rc
	
	li_rc = f_rename_and_print_datastore(al_shipment, lds_print)
	
	//lds_print.Print(TRUE) //Alex Gerlants. Comment out
   //Alex Gerlants. 10/21/2019. Rename PDF File. End
END IF

DESTROY lds_print

RETURN 1
end event

event type integer ue_print_sheetskid(long al_shipment);Int li_totalrow, li_totaljob, li_i, ref_item

DataStore lds_sheetitem
Datastore lds_print

String ls_temp, ls_modstring

Long ll_jobpc, ll_jobnet,  ll_jobtheo, ll_jobtare
Long ll_jobnet_kg,  ll_jobtheo_kg, ll_jobtare_kg

Int li_s, li_shipitem_num, li_skidcount
Long ll_skid_num, ll_job_num, ll_net_wt, ll_skidpc, ll_tarewt, ref_order
Long ll_itemrow, ll_itemi
Long ll_gross_kg

Long ll_newrow

String ls_sheet_skid_display_num

li_totalrow = ids_sheet.RowCount()
li_totalrow = li_totalrow + ids_scrap.RowCount()
li_totalrow = li_totalrow + ids_rejcoil.RowCount()

lds_print = CREATE datastore  
lds_print.DataObject = "d_report_abco_combi_form_display"  
lds_print.SetTransObject (SQLCA) 

lds_sheetitem = CREATE DataStore
lds_sheetitem.DataObject = "d_shipping_skid_detail_list"
lds_sheetitem.SetTransObject (SQLCA)  

IF ids_sheet.RowCount() > 0 THEN
	li_totaljob = UpperBound(istr_job_info)
	IF li_totaljob > 0 THEN
		FOR li_i = 1 TO li_totaljob
			lds_print.Reset()
			lds_print.Retrieve(al_shipment)
			//fill header
			of_fill_print_header(lds_print, al_shipment)
			ls_modstring = "pack_no_t.Text = ~"" + String(li_totalrow) + "~""	
			lds_print.Modify(ls_modstring) 
			li_skidcount = ids_sheet.rowCount() 
			IF li_skidcount > 0 THEN ls_temp = String(li_skidcount) + " Aluminum Blanks  "
			li_skidcount = ids_scrap.rowCount()
			IF li_skidcount > 0 THEN ls_temp = ls_temp + String(li_skidcount) +  " Return Scraps "
	
			//Alex Gerlants. 03/15/2021. 1127_Return-Rejected_Coil_on_BOL. Begin
			Integer	li_reject_return_coil
			
			li_skidcount = ids_rejcoil.rowCount()
			li_reject_return_coil = of_reject_return_coil()
			
			Choose Case li_reject_return_coil
				Case 0
					//
				Case 1
					ls_temp = ls_temp +  String(li_skidcount) + " Rejected and Return Coil(s) "
				Case 2
					ls_temp = ls_temp +  String(li_skidcount) + " Rejected Coil(s) "
				Case 3
					ls_temp = ls_temp +  String(li_skidcount) + " Return Coil(s) "
			End Choose
			
			//IF li_skidcount > 0 THEN ls_temp = ls_temp +  String(li_skidcount) + " Rejected Coils "
			
			//Alex Gerlants. 03/15/2021. 1127_Return-Rejected_Coil_on_BOL. End
	
			ls_modstring = "pack_desc_t.Text = ~"" + ls_temp + "~""	
			lds_print.Modify(ls_modstring) 
			ls_modstring = "total_wt_t.Text = ~"" + String(il_totalgross, "###,###,###") + "~""	
			lds_print.Modify(ls_modstring) 

			ls_modstring = "t_abco_num.Text = ~"" + String(istr_job_info[li_i].abco_num) + "~""	
			lds_print.Modify(ls_modstring) 
			ls_modstring = "t_orig_po.Text = ~"" + istr_job_info[li_i].orig_po + "~""	
			lds_print.Modify(ls_modstring) 
			ls_modstring = "t_enduser_po.Text = ~"" + istr_job_info[li_i].enduser_po + "~""
			lds_print.Modify(ls_modstring) 
			ls_modstring = "t_part.Text = ~"" + istr_job_info[li_i].part + "~""
			lds_print.Modify(ls_modstring) 
			ls_modstring = "t_suppliy_code.Text = ~"" + istr_job_info[li_i].suppliy_code + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_gauge.Text = ~"" + String(istr_job_info[li_i].gauge, "#.######") + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_width.Text = ~"" + String(istr_job_info[li_i].width, "###,###.###") + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_length.Text = ~"" + String(istr_job_info[li_i].length, "###,###.###") + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_gauge_m.Text = ~"" + String(istr_job_info[li_i].gauge * 25.4, "####.###") + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_width_m.Text = ~"" + String(istr_job_info[li_i].width * 25.4, "###,###.###") + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_length_m.Text = ~"" + String(istr_job_info[li_i].length * 25.4, "###,###.###") + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_alloy.Text = ~"" + istr_job_info[li_i].alloy + "~""
			lds_print.Modify(ls_modstring)
			ls_modstring = "t_temper.Text = ~"" + istr_job_info[li_i].temper + "~""
			lds_print.Modify(ls_modstring)			
			//end of header
			ll_jobpc = 0
			ll_jobnet = 0
			ll_jobtheo = 0
			ll_jobtare = 0
			ll_jobnet_kg = 0
			ll_jobtheo_kg = 0
			ll_jobtare_kg = 0
			//fill data
			FOR li_s = 1 TO ids_sheet.RowCount()
				ll_skid_num = ids_sheet.GetItemNumber( li_s, "sheet_skid_num", Primary!, FALSE) 	
				SELECT ab_job_num, sheet_net_wt, skid_pieces, sheet_tare_wt , ref_order_abc_num, ref_order_abc_item 
				INTO :ll_job_num, :ll_net_wt, :ll_skidpc, :ll_tarewt, :ref_order, :ref_item
				FROM sheet_skid
				WHERE sheet_skid_num = :ll_skid_num
				USING SQLCA;
				IF istr_job_info[li_i].abco_num = ll_job_num and istr_job_info[li_i].ref_order_num = ref_order and istr_job_info[li_i].ref_order_item_num = ref_item THEN
					IF IsNULL(ll_net_wt) THEN ll_net_wt = 0
					IF ISNULL(ll_skidpc) THEN ll_skidpc = 0
					IF ISNULL(ll_tarewt) THEN ll_tarewt = 0	

					ll_jobpc = ll_jobpc + ll_skidpc
					ll_jobtare = ll_jobtare + ll_tarewt
					ll_jobtare_kg = ll_jobtare_kg + Long(String(ll_tarewt * 0.453592, "#,###,###"))

					il_shippc = il_shippc + ll_skidpc
					il_shiptare = il_shiptare + ll_tarewt					
					il_shiptare_kg = il_shiptare_kg + Long(String(ll_tarewt * 0.453592, "#,###,###"))					
				
					li_shipitem_num = ids_sheet.GetItemNumber( li_s, "sh_packing_item", Primary!, FALSE)
					ll_newrow = lds_print.InsertRow(0)
					lds_print.SetItem(ll_newrow, "item_t", String(li_shipitem_num) )
										
					//Replace Sheet_skid_num with Sheet_skid_display_num					
					select sheet_skid_display_num into :ls_sheet_skid_display_num
					from sheet_skid
					where sheet_skid_num = :ll_skid_num
					using SQLCA;					
					//lds_print.SetItem(ll_newrow, "ticket_t", String(ll_skid_num))
					lds_print.SetItem(ll_newrow, "ticket_t", ls_sheet_skid_display_num)
					
					
					//detail
					
					lds_sheetitem.Reset()
					lds_sheetitem.Retrieve(ll_skid_num)
					
					ll_itemrow = lds_sheetitem.RowCount()
					IF ll_itemrow > 0 THEN
						ll_gross_kg = Long(String(ll_tarewt * 0.453592, "#,###,###"))
						FOR ll_itemi = 1 TO ll_itemrow
							ll_gross_kg = ll_gross_kg + Long( String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt")* 0.453592, "#,###,###") )
						NEXT
						lds_print.SetItem(ll_newrow, "lot_t", lds_sheetitem.GetItemString(1, "coil_lot_num"))
						lds_print.SetItem(ll_newrow, "coil_t", lds_sheetitem.GetItemString(1, "coil_coil_org_num"))
						lds_print.SetItem(ll_newrow, "pcs_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_pieces"),"###,###" ))
						lds_print.SetItem(ll_newrow, "ntweight_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt"), "#,###,###"))
						lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt") * 0.453592, "#,###,###"))
						//lds_print.SetItem(ll_newrow, "theowt_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_theoreti"), "#,###,###"))
						//lds_print.SetItem(ll_newrow, "theowt_kg_t", String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_theoreti")*0.453592, "#,###,###"))				
						lds_print.SetItem(ll_newrow, "tarewt_t", String(ll_tarewt, "#,###,###"))
						lds_print.SetItem(ll_newrow, "tarewt_kg_t", String(ll_tarewt * 0.453592, "#,###,###"))
						lds_print.SetItem(ll_newrow, "grosswt_t", String((ll_net_wt + ll_tarewt), "#,###,###"))
						lds_print.SetItem(ll_newrow, "grosswt_kg_t", String(ll_gross_kg, "#,###,###"))
						lds_print.SetItem(ll_newrow, "comments_t", lds_sheetitem.GetItemString(1, "production_sheet_item_prod_item_note"))
						
						//added by Victor Huang on 08/06 for skid "NonConforming" issue.
						Int li_prod_item_status
						li_prod_item_status = lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_status")
						if li_prod_item_status = 11 then
							lds_print.SetItem(ll_newrow, "comments_2", "NonConforming")
						end if
						//added end
				
						ll_jobnet = ll_jobnet + lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt")
						ll_jobnet_kg = ll_jobnet_kg + Long(String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt")* 0.453592, "#,###,###"))
						//ll_jobtheo = ll_jobtheo + lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_theoreti")
						//ll_jobtheo_kg = ll_jobtheo_kg + Long(String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_theoreti")*0.453592, "#,###,###"))
						il_shipnet = il_shipnet + lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt")
						il_shipnet_kg = il_shipnet_kg + Long(String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_net_wt")* 0.453592, "#,###,###"))
						//il_shiptheo = il_shiptheo + lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_theoreti")
						//il_shiptheo_kg = il_shiptheo_kg + Long(String(lds_sheetitem.GetItemNumber(1, "production_sheet_item_prod_item_theoreti")*0.453592, "#,###,###"))

						IF ll_itemrow > 1 THEN
							FOR ll_itemi = 2 TO ll_itemrow
								ll_newrow = lds_print.InsertRow(0)
								lds_print.SetItem(ll_newrow, "lot_t", lds_sheetitem.GetItemString(ll_itemi, "coil_lot_num"))
								lds_print.SetItem(ll_newrow, "coil_t", lds_sheetitem.GetItemString(ll_itemi, "coil_coil_org_num"))
								lds_print.SetItem(ll_newrow, "pcs_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_pieces"),"###,###" ))
								lds_print.SetItem(ll_newrow, "ntweight_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt"), "#,###,###"))
								lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt") * 0.453592, "#,###,###"))
								//lds_print.SetItem(ll_newrow, "theowt_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_theoreti"), "#,###,###"))
								//lds_print.SetItem(ll_newrow, "theowt_kg_t", String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_theoreti")*0.453592, "#,###,###"))				
								lds_print.SetItem(ll_newrow, "comments_t", lds_sheetitem.GetItemString(ll_itemi, "production_sheet_item_prod_item_note"))
								//added by Victor Huang on 08/06 for skid "NonConforming" issue.
								li_prod_item_status = lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_status")
								if li_prod_item_status = 11 then
									lds_print.SetItem(ll_newrow, "comments_2", "NonConforming")
								end if
								//added end
								ll_jobnet = ll_jobnet + lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt")
								ll_jobnet_kg = ll_jobnet_kg + Long(String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt")* 0.453592, "#,###,###"))
								//ll_jobtheo = ll_jobtheo + lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_theoreti")
								//ll_jobtheo_kg = ll_jobtheo_kg + Long(String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_theoreti")*0.453592, "#,###,###"))
								il_shipnet = il_shipnet + lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt")
								il_shipnet_kg = il_shipnet_kg + Long(String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_net_wt")* 0.453592, "#,###,###"))
								//il_shiptheo = il_shiptheo + lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_theoreti")
								//il_shiptheo_kg = il_shiptheo_kg + Long(String(lds_sheetitem.GetItemNumber(ll_itemi, "production_sheet_item_prod_item_theoreti")*0.453592, "#,###,###"))

							NEXT
						END IF
					END IF
					//end of detail
				END IF	
			NEXT
			IF (li_totaljob > 1) OR (ids_rejcoil.RowCount() > 0)  OR (ids_scrap.rowCount() > 0) THEN
				ll_newrow = lds_print.InsertRow(0)
				lds_print.SetItem(ll_newrow, "coil_t", "subtotal:")
				lds_print.SetItem(ll_newrow, "pcs_t",String(ll_jobpc) )
				lds_print.SetItem(ll_newrow, "ntweight_t", String(ll_jobnet, "###,###,###") )
				lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(ll_jobnet_kg, "###,###,###") )
				//lds_print.SetItem(ll_newrow, "theowt_t", String(ll_jobtheo, "###,###,###") )
				//lds_print.SetItem(ll_newrow, "theowt_kg_t", String(ll_jobtheo_kg, "###,###,###") )
				lds_print.SetItem(ll_newrow, "tarewt_t", String(ll_jobtare, "###,###,###") )
				lds_print.SetItem(ll_newrow, "tarewt_kg_t", String(ll_jobtare_kg, "###,###,###") )
				lds_print.SetItem(ll_newrow, "grosswt_t", String((ll_jobnet+ll_jobtare), "###,###,###") )
				lds_print.SetItem(ll_newrow, "grosswt_kg_t", String((ll_jobnet_kg +ll_jobtare_kg), "###,###,###") )
			END IF
			
			IF li_i = li_totaljob THEN 
				ll_newrow = lds_print.InsertRow(0)
				ll_newrow = lds_print.InsertRow(0)
				lds_print.SetItem(ll_newrow, "coil_t", "TOTAL:")
				lds_print.SetItem(ll_newrow, "pcs_t",String(il_shippc) )
				lds_print.SetItem(ll_newrow, "ntweight_t", String(il_shipnet, "###,###,###") )
				lds_print.SetItem(ll_newrow, "ntweight_kg_t", String(il_shipnet_kg, "###,###,###") )
				//lds_print.SetItem(ll_newrow, "theowt_t", String(il_shiptheo, "###,###,###") )
				//lds_print.SetItem(ll_newrow, "theowt_kg_t", String(il_shiptheo_kg, "###,###,###") )
				lds_print.SetItem(ll_newrow, "tarewt_t", String(il_shiptare, "###,###,###") )
				lds_print.SetItem(ll_newrow, "tarewt_kg_t", String(il_shiptare_kg, "###,###,###") )
				lds_print.SetItem(ll_newrow, "grosswt_t", String((il_shipnet + il_shiptare), "###,###,###") )
				lds_print.SetItem(ll_newrow, "grosswt_kg_t", String((il_shipnet_kg + il_shiptare_kg), "###,###,###") )
			END IF				
			//end of data			
			
			//Alex Gerlants. 10/21/2019. Rename PDF File. Begin
      	Integer li_rc
      
      	li_rc = f_rename_and_print_datastore(al_shipment, lds_print)
			
			//lds_print.Print(TRUE) //Alex Gerlants. Comment out
	      //Alex Gerlants. 10/21/2019. Rename PDF File. End
		NEXT
	END IF
END IF

DESTROY lds_print
DESTROY lds_sheetitem						

RETURN 1
end event

public subroutine of_fill_job_details (integer al_items);Long ll_job_num, ll_order
Real lr_gauge, lr_w, lr_l, lr_s
Int li_item
String ls_temper, ls_desc, ls_shape, ls_alloy
Long ll_i

IF al_items < 1 THEN RETURN

CONNECT USING SQLCA;

FOR ll_i = 1 TO al_items
	ll_job_num = istr_job_info[ll_i].abco_num

	//SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
	//FROM ab_job 
	//WHERE ab_job_num = :ll_job_num
	//USING SQLCA;

	ll_order =  istr_job_info[ll_i].ref_order_num
	li_item = istr_job_info[ll_i].ref_order_item_num
	
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
			SELECT fe_side INTO :lr_w
			FROM fender
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
			SetNULL(lr_l)
		CASE "CHEVRON"
			SELECT ch_length, ch_width INTO :lr_l, :lr_w
			FROM chevron
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
		CASE "CIRCLE"
			SELECT c_diameter INTO :lr_w
			FROM circle
			WHERE order_abc_num = :ll_order AND order_item_num = :li_item
			USING SQLCA;
			setNULL(lr_l)
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
Long ll_bill_lading, ll_des_cust_id, ll_cust_id, ll_carrier_id, ll_row
DateTime ld_date
String ls_carrier, ls_1, ls_2, ls_3, ls_4, ls_city, ls_state, ls_zip, ls_refs
Int li_i, li_j
String	ls_equipment_type_desc, ls_trailer_num //Alex Gerlants. 07/12/2016
String	ls_vehicle_id, ls_carrier_initial //Alex Gerlants. 07/12/2016

Integer	li_rtn //Alex Gerlants. 03/29/2021. 1141_Add_Packing_List_To_All_BOLs
String	ls_package //Alex Gerlants. 03/29/2021. 1141_Add_Packing_List_To_All_BOLs

Integer	li_return //Alex Gerlants. 10/02/2024.2159_Add_2BOL_Option_Who_Pays_4Freight
String	ls_billto_text, ls_return //Alex Gerlants. 10/02/2024.2159_Add_2BOL_Option_Who_Pays_4Freight

CONNECT USING SQLCA;
SELECT BILL_OF_LADING, DES_SH_CUST_ID, CUSTOMER_ID, SHIPMENT_ACTUALED_DATE_TIME, Carrier_id, shipment_reference_codes
INTO :ll_bill_lading, :ll_des_cust_id, :ll_cust_id, :ld_date, :ll_carrier_id, :ls_refs
FROM SHIPMENT  
WHERE PACKING_LIST = :al_shipment    
USING SQLCA;

ls_modstring = "packing_list_t.Text = ~"" + String(al_shipment) + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "bill_lading_t.Text = ~"" + String(ll_bill_lading) + "~""	
idw_requestor.Modify(ls_modstring) 
ls_modstring = "date_t.Text = ~"" + String(ld_date, "mm/dd/yyyy hh:mm") + "~""	
idw_requestor.Modify(ls_modstring) 

li_i = Pos(ls_refs, "~v")
is_deliver = Left(ls_refs, (li_i - 1))
li_j = li_i + 1
li_i = Pos(ls_refs, "~v", li_j)
is_package = Mid(ls_refs, li_j, (li_i - li_j))

//Alex Gerlants. 03/29/2021. 1141_Add_Packing_List_To_All_BOLs. Begin
li_rtn = f_get_bol_totals(ll_bill_lading, al_shipment, sqlca, ls_package)

If li_rtn = 1 Then //Multi-stop BOL
	is_package = ls_package
End If
//Alex Gerlants. 03/29/2021. 1141_Add_Packing_List_To_All_BOLs. End

li_j = li_i + 1
li_i = Pos(ls_refs, "~v", li_j)
is_cust_order = Mid(ls_refs, li_j, (li_i - li_j))
li_j = li_i + 1
li_i = Pos(ls_refs, "~v", li_j)
is_ref_1 = Mid(ls_refs, li_j, (li_i - li_j))
li_j = li_i+ 1 
li_i = Pos(ls_refs, "~v", li_j)
is_ref_2 = Mid(ls_refs, li_j, (li_i - li_j))
li_j = li_i + 1
li_i = Pos(ls_refs, "~v", li_j)
is_note_1 = Mid(ls_refs, li_j, (li_i - li_j))
li_j = li_i + 1
li_i = Pos(ls_refs, "~v", li_j)
is_note_2 = Mid(ls_refs, li_j, (li_i - li_j))
li_j = li_i + 1
li_i = Pos(ls_refs, "~v", li_j)
is_note_3 = Mid(ls_refs, li_j, (li_i - li_j))

ll_row = idw_requestor.GetRow()
idw_requestor.SetItem(ll_row, "deliver_t", is_deliver)
idw_requestor.SetItem(ll_row, "ref1_t", is_ref_1)	
idw_requestor.SetItem(ll_row, "ref2_t", is_ref_2)
idw_requestor.SetItem(ll_row, "note1_t", is_note_1)
idw_requestor.SetItem(ll_row, "note2_t", is_note_2)
idw_requestor.SetItem(ll_row, "note3_t", is_note_3)
idw_requestor.SetItem(ll_row, "package_t", is_package)
idw_requestor.SetItem(ll_row, "cust_order", is_cust_order)

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
IF ISNULL(ls_1) THEN ls_1 = " "
IF ISNULL(ls_2) THEN ls_2 = " "
IF ISNULL(ls_city) THEN ls_city = " "
IF ISNULL(ls_state) THEN ls_state = " "
IF ISNULL(ls_zip) THEN ls_zip = " "
ls_1 = ls_1 + ",  " + ls_2 + ",  " + ls_city + ", " + ls_state + ".  " + ls_zip

ls_modstring = "shipto_1.Text = ~"" + ls_1 + "~""	
idw_requestor.Modify(ls_modstring) 

SELECT CUSTOMER_FULL_NAME,CUSTOMER_STREET,CUSTOMER_CITY,CUSTOMER_STATE, CUSTOMER_ZIP  
INTO :ls_1, :ls_2, :ls_city, :ls_state, :ls_zip
FROM CUSTOMER  
WHERE CUSTOMER_ID = :ll_cust_id 
USING SQLCA;
IF ISNULL(ls_1) THEN ls_1 = " "
IF ISNULL(ls_2) THEN ls_2 = " "
IF ISNULL(ls_city) THEN ls_city = ""
IF ISNULL(ls_state) THEN ls_state = ""
IF ISNULL(ls_zip) THEN ls_zip = ""
ls_1 = ls_1 + ",  " + ls_2 + ",  " + ls_city + ", " + ls_state + ".  " + ls_zip

ls_modstring = "soldto_1.Text = ~"" + ls_1 + "~""	
idw_requestor.Modify(ls_modstring) 

SELECT CUSTOMER_FULL_NAME,BILL_TO_STREET,BILL_TO_CITY,BILL_TO_STATE, BILL_TO_ZIP  
INTO :ls_1, :ls_2, :ls_city, :ls_state, :ls_zip
FROM CUSTOMER  
WHERE CUSTOMER_ID = :ll_cust_id 
USING SQLCA;
IF ISNULL(ls_1) THEN ls_1 = " "
IF ISNULL(ls_2) THEN ls_2 = " "
IF ISNULL(ls_city) THEN ls_city = ""
IF ISNULL(ls_state) THEN ls_state = ""
IF ISNULL(ls_zip) THEN ls_zip = ""
ls_1 = ls_1 + ",  " + ls_2 + ",  " + ls_city + ", " + ls_state + ".  " + ls_zip

//Alex Gerlants. 10/02/2024. 2159_Add_2BOL_Option_Who_Pays_4Freight. Begin

//MessageBox("of_fill_header for u_default_combi_1999_actual", "idw_requestor.DataObject = " + idw_requestor.DataObject)

li_return = f_billto_albl(al_shipment, ls_billto_text, sqlca) //ls_billto_text is a reference variable in f_billto_albl

If li_return = 2 Then //OK in f_billto_albl and ALBL pays for freight
	ls_1 = ls_billto_text
  
  	ls_modstring = "t_26.Text = ~"" + "" + "~""	
	ls_return = idw_requestor.Modify(ls_modstring)
	
	ls_modstring = "t_25.Text = ~"" + "PLEASE SUBMIT FREIGHT BILLS VIA EMAIL TO:" + "~""	
	ls_return = idw_requestor.Modify(ls_modstring)
End If
//Alex Gerlants. 10/02/2024. 2159_Add_2BOL_Option_Who_Pays_4Freight. End

ls_modstring = "billto.Text = ~"" + ls_1 + "~""	
idw_requestor.Modify(ls_modstring) 

//Alex Gerlants. 07/12/2016. Begin
String	ls_rtn
//Integer	li_rtn //Alex Gerlants. 03/29/2021. 1141_Add_Packing_List_To_All_BOLs. Comment out

li_rtn = f_get_carrier_info(al_shipment, ls_equipment_type_desc, ls_trailer_num, &
			ls_vehicle_id, ls_carrier_initial)

ls_modstring = 'equipment_type_t.Text = ' + '"' + ls_equipment_type_desc + '"'
ls_rtn = idw_requestor.Modify(ls_modstring) 

ls_modstring = 'trailer_num_t.Text = ' + '"' + ls_trailer_num + '"'
ls_rtn = idw_requestor.Modify(ls_modstring)

ls_modstring = 'vehicle_id_t.Text = ' + '"' + ls_vehicle_id + '"'
ls_rtn = idw_requestor.Modify(ls_modstring)

ls_modstring = 'carrier_initial_t.Text = ' + '"' + ls_carrier_initial + '"'
ls_rtn = idw_requestor.Modify(ls_modstring)
//Alex Gerlants. 07/12/2016. End

RETURN 1
end function

public function integer of_fill_print_header (datastore ads_print, long al_shipment);String ls_modstring
Long ll_bill_lading, ll_des_cust_id, ll_cust_id, ll_carrier_id
DateTime ld_date
String ls_carrier, ls_1, ls_2, ls_3, ls_4, ls_city, ls_state, ls_zip
String	ls_equipment_type_desc, ls_trailer_num //Alex Gerlants. 07/12/2016
String	ls_vehicle_id, ls_carrier_initial //Alex Gerlants. 07/12/2016

Integer	li_return //Alex Gerlants. 10/02/2024.2159_Add_2BOL_Option_Who_Pays_4Freight
String	ls_billto_text, ls_return //Alex Gerlants. 10/02/2024.2159_Add_2BOL_Option_Who_Pays_4Freight

CONNECT USING SQLCA;
SELECT BILL_OF_LADING, DES_SH_CUST_ID, CUSTOMER_ID, SHIPMENT_ACTUALED_DATE_TIME, Carrier_id
INTO :ll_bill_lading, :ll_des_cust_id, :ll_cust_id, :ld_date, :ll_carrier_id
FROM SHIPMENT  
WHERE PACKING_LIST = :al_shipment    
USING SQLCA;

ls_modstring = "shipper_t.Text = ~"" + String(ll_bill_lading) + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "packing_list_t.Text = ~"" + String(al_shipment) + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "bill_lading_t.Text = ~"" + String(ll_bill_lading) + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "date_t.Text = ~"" + String(ld_date, "mm/dd/yyyy hh:mm") + "~""	
ads_print.Modify(ls_modstring) 

SELECT carrier_full_name INTO :ls_carrier
FROM carrier
WHERE carrier_id = :ll_carrier_id
USING SQLCA;

ls_modstring = "ship_via_t.Text = ~"" + ls_carrier + "~""	
ads_print.Modify(ls_modstring) 

SELECT CUSTOMER_FULL_NAME,CUSTOMER_STREET,CUSTOMER_CITY,CUSTOMER_STATE,CUSTOMER_ZIP  
INTO :ls_1, :ls_2, :ls_city, :ls_state, :ls_zip
FROM CUSTOMER  
WHERE CUSTOMER_ID = :ll_des_cust_id
USING SQLCA;
IF ISNULL(ls_1) THEN ls_1 = " "
IF ISNULL(ls_2) THEN ls_2 = " "
IF ISNULL(ls_city) THEN ls_city = ""
IF ISNULL(ls_state) THEN ls_state = ""
IF ISNULL(ls_zip) THEN ls_zip = ""
ls_1 = ls_1 + ",  " + ls_2 + ",  " + ls_city + ", " + ls_state + ".  " + ls_zip

ls_modstring = "shipto_1.Text = ~"" + ls_1 + "~""	
ads_print.Modify(ls_modstring) 

SELECT CUSTOMER_FULL_NAME,CUSTOMER_STREET,CUSTOMER_CITY,CUSTOMER_STATE, CUSTOMER_ZIP  
INTO :ls_1, :ls_2, :ls_city, :ls_state, :ls_zip
FROM CUSTOMER  
WHERE CUSTOMER_ID = :ll_cust_id 
USING SQLCA;
IF ISNULL(ls_1) THEN ls_1 = " "
IF ISNULL(ls_2) THEN ls_2 = " "
IF ISNULL(ls_city) THEN ls_city = ""
IF ISNULL(ls_state) THEN ls_state = ""
IF ISNULL(ls_zip) THEN ls_zip = ""
ls_1 = ls_1 + ",  " + ls_2 + ",  " + ls_city + ", " + ls_state + ".  " + ls_zip

ls_modstring = "soldto_1.Text = ~"" + ls_1 + "~""	
ads_print.Modify(ls_modstring) 

SELECT CUSTOMER_FULL_NAME,BILL_TO_STREET,BILL_TO_CITY,BILL_TO_STATE, BILL_TO_ZIP  
INTO :ls_1, :ls_2, :ls_city, :ls_state, :ls_zip
FROM CUSTOMER  
WHERE CUSTOMER_ID = :ll_cust_id 
USING SQLCA;
IF ISNULL(ls_1) THEN ls_1 = " "
IF ISNULL(ls_2) THEN ls_2 = " "
IF ISNULL(ls_city) THEN ls_city = ""
IF ISNULL(ls_state) THEN ls_state = ""
IF ISNULL(ls_zip) THEN ls_zip = ""
ls_1 = ls_1 + ",  " + ls_2 + ",  " + ls_city + ", " + ls_state + ".  " + ls_zip

//Alex Gerlants. 10/02/2024. 2159_Add_2BOL_Option_Who_Pays_4Freight. Begin

//MessageBox("of_fill_print_header for u_default_combi_1999_actual", "ads_print.DataObject = " + ads_print.DataObject)

li_return = f_billto_albl(al_shipment, ls_billto_text, sqlca) //ls_billto_text is a reference variable in f_billto_albl

If li_return = 2 Then //OK in f_billto_albl and ALBL pays for freight
  	ls_1 = ls_billto_text
  
  	ls_modstring = "t_36.Text = ~"" + "" + "~""	
	ls_return = ads_print.Modify(ls_modstring)
	
	ls_modstring = "t_37.Text = ~"" + "PLEASE SUBMIT FREIGHT BILLS VIA EMAIL TO:" + "~""	
	ls_return = ads_print.Modify(ls_modstring)
End If
//Alex Gerlants. 10/02/2024. 2159_Add_2BOL_Option_Who_Pays_4Freight. End

ls_modstring = "billto.Text = ~"" + ls_1 + "~""	
ads_print.Modify(ls_modstring) 



ls_modstring = "deliver_t.Text = ~"" + is_deliver + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "ref_1_t.Text = ~"" + is_ref_1 + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "ref_2_t.Text = ~"" + is_ref_2 + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "note_1_t.Text = ~"" + is_note_1 + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "note_2_t.Text = ~"" + is_note_2 + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "note_3_t.Text = ~"" + is_note_3 + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "package_t.Text = ~"" + is_package + "~""	
ads_print.Modify(ls_modstring) 
ls_modstring = "cust_order_t.Text = ~"" + is_cust_order + "~""	
ads_print.Modify(ls_modstring) 

//Alex Gerlants. 07/12/2016. Begin
String	ls_rtn
Integer	li_rtn

li_rtn = f_get_carrier_info(al_shipment, ls_equipment_type_desc, ls_trailer_num, &
			ls_vehicle_id, ls_carrier_initial)

ls_modstring = 'equipment_type_t.Text = ' + '"' + ls_equipment_type_desc + '"'
ls_rtn = ads_print.Modify(ls_modstring) 

ls_modstring = 'trailer_num_t.Text = ' + '"' + ls_trailer_num + '"'
ls_rtn = ads_print.Modify(ls_modstring)

ls_modstring = 'vehicle_id_t.Text = ' + '"' + ls_vehicle_id + '"'
ls_rtn = ads_print.Modify(ls_modstring)

ls_modstring = 'carrier_initial_t.Text = ' + '"' + ls_carrier_initial + '"'
ls_rtn = ads_print.Modify(ls_modstring)
//Alex Gerlants. 07/12/2016. End

RETURN 1
end function

public function integer of_reject_return_coil ();Int li_rc, li_i, li_status
Long ll_coil
Boolean lb_rej, lb_ret

IF ids_rejcoil.RowCount() > 0 THEN
	lb_rej = FALSE
	lb_ret = FALSE
	FOR li_i = 1 TO ids_rejcoil.RowCount()
		ll_coil = ids_rejcoil.GetItemNumber(li_i, "coil_abc_num", Primary!, FALSE)
		CONNECT USING SQLCA;
		SELECT coil_status INTO :li_status
		FROM coil
		WHERE coil_abc_num = :ll_coil
		USING SQLCA;
		IF li_status = 3 THEN 
			lb_rej = TRUE
		ELSE
			lb_ret = TRUE
		END IF		
	NEXT
	IF lb_rej and lb_ret THEN li_rc = 1
	IF lb_rej and not(lb_ret) THEN li_rc = 2
	IF lb_ret and not(lb_rej) THEN li_rc = 3
ELSE
	li_rc = 0
END IF

RETURN li_rc
end function

on u_default_combi_1999_actual.create
call super::create
end on

on u_default_combi_1999_actual.destroy
call super::destroy
end on

event constructor;call super::constructor;is_objectname = "d_report_abco_combi_form_input"

istr_dw.width = 3547
istr_dw.length = 1872
istr_dw.v_bar = FALSE
istr_dw.h_bar = TRUE
istr_dw.front = TRUE

RETURN 1

end event

event ue_createreport;call super::ue_createreport;SetPointer(HourGlass!)
integer li_row, li_totalrow, li_int, li_index, li_trow, li_i, li_skidcount
Boolean lb_exist
Long ll_skid_num, ll_custid
Long ll_shipment_wt, ll_shipment_pc, ll_sitem
String ls_custname
Long ll_nwt, ll_twt

String ls_temp, ls_grosswt
String ls_modstring

ids_sheet = CREATE DataStore
ids_sheet.DataObject = "d_sheetandwh_packing_item"
ids_sheet.SetTransObject (SQLCA)  
ids_sheet.Retrieve(al_shipment)

ids_scrap = CREATE DataStore
ids_scrap.DataObject = "d_scrap_packing_item"
ids_scrap.SetTransObject (SQLCA)  
ids_scrap.Retrieve(al_shipment)

ids_rejcoil = CREATE DataStore
ids_rejcoil.DataObject = "d_rej_coil_packing_item"
ids_rejcoil.SetTransObject (SQLCA)  
ids_rejcoil.Retrieve(al_shipment)

li_totalrow = ids_sheet.RowCount()
li_trow = li_totalrow + ids_scrap.RowCount()
li_trow = li_trow + ids_rejcoil.RowCount()

IF li_trow <= 0 THEN 
	MessageBox("Error", "There is nothing to ship in this shipment!", StopSign!)
	Return -1
END IF

idw_requestor.Retrieve(al_shipment)
of_fill_header(al_shipment)
ls_modstring = "pack_no_t.Text = ~"" + String(li_trow) + "~""	
idw_requestor.Modify(ls_modstring) 
li_skidcount = ids_sheet.rowCount()
IF li_skidcount > 0 THEN ls_temp = String(li_skidcount) + " Aluminum Blanks  "
li_skidcount = ids_scrap.rowCount()
IF li_skidcount > 0 THEN ls_temp = ls_temp + String(li_skidcount) +  " Return Scraps "
li_skidcount = ids_rejcoil.rowCount() 
IF li_skidcount > 0 THEN ls_temp = ls_temp +  String(li_skidcount) + " Rejected Coils "
ls_modstring = "pack_desc_t.Text = ~"" + ls_temp + "~""	
idw_requestor.Modify(ls_modstring) 

CONNECT USING SQLCA;
SELECT customer_id INTO :ll_custid
FROM shipment 
WHERE packing_list = :al_shipment
USING SQLCA;
SELECT customer_full_name INTO :ls_custname
FROM customer 
WHERE customer_id = :ll_custid
USING SQLCA;
IF IsNULL(ls_custname) THEN ls_custname = " "

IF li_totalrow > 0 THEN //retrieve order information

	li_index = 0
	FOR li_int = 1 TO li_totalrow
		ll_skid_num = ids_sheet.GetItemNumber( li_int, "sheet_skid_num", Primary!, FALSE)
		//Retrieve related job info about a skid	

		Long ll_job_num, ll_order_num, ll_item_num, ll_orig_cust, ll_enduser, ll_parent_cust, ll_ref_order
		String ls_orig_po, ls_enduser_po, ls_supplier_code, ls_part_num
		real lr_gauge, lr_width, lr_length
		integer  li_skid_items_num
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
				IF istr_job_info[li_i].abco_num = ll_job_num and istr_job_info[li_i].ref_order_num = ll_ref_order and istr_job_info[li_i].ref_order_item_num = ll_item_num THEN
					istr_job_info[li_i].sub_total_net_wt = istr_job_info[li_i].sub_total_net_wt + ll_net_wt
					istr_job_info[li_i].units = istr_job_info[li_i].units + 1
					lb_exist = TRUE
				END IF	
			NEXT
		END IF
	
		IF NOT(lb_exist) THEN
			//New Job
			ll_order_num = 0
			//SELECT order_abc_num  INTO :ll_order_num
			//FROM ab_job
			//WHERE ab_job_num = :ll_job_num
			//USING SQLCA;
			
			ll_order_num = ll_ref_order
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
			istr_job_info[li_index].ref_order_num = ll_ref_order
			istr_job_info[li_index].ref_order_item_num = ll_item_num
		END IF
		//end of current skid
	NEXT
	of_fill_job_details(li_index)
END IF

//for each abco job print out each packaging list
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
	ls_modstring = "t_gauge.Text = ~"" + String(istr_job_info[li_int].gauge, "#.######") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_width.Text = ~"" + String(istr_job_info[li_int].width, "###,###.###") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_length.Text = ~"" + String(istr_job_info[li_int].length, "###,###.###") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_gauge_m.Text = ~"" + String(istr_job_info[li_int].gauge * 25.4, "####.###") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_width_m.Text = ~"" + String(istr_job_info[li_int].width * 25.4, "###,###.###") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_length_m.Text = ~"" + String(istr_job_info[li_int].length * 25.4, "###,###.###") + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_alloy.Text = ~"" + istr_job_info[li_int].alloy + "~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_temper.Text = ~"" + istr_job_info[li_int].temper + "~""
	idw_requestor.Modify(ls_modstring)
	
ELSE   //more than one job
	ls_modstring = "t_abco_num.Text = ~"multiple~""	
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_orig_po.Text = ~"multiple~""	
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_enduser_po.Text = ~"multiple~""
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_part.Text = ~"multiple~""
	idw_requestor.Modify(ls_modstring) 
	ls_modstring = "t_suppliy_code.Text = ~"multiple~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_gauge.Text = ~"multiple~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_width.Text = ~"multiple~""
	idw_requestor.Modify(ls_modstring)
	ls_modstring = "t_length.Text = ~"multiple~""
	idw_requestor.Modify(ls_modstring)
END IF

//total gross wt
ll_shipment_wt = 0

li_totalrow = ids_sheet.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_nwt = 0
		ll_twt = 0
		ll_nwt = ids_sheet.GetItemNumber(li_int, "sheet_skid_sheet_net_wt", Primary!, FALSE)
		ll_twt = ids_sheet.GetItemNumber(li_int, "sheet_skid_sheet_tare_wt", Primary!, FALSE)
		
		IF ISNULL(ll_twt) THEN ll_twt = 0
		IF ISNULL(ll_nwt) THEN ll_nwt = 0
		ll_shipment_wt = ll_shipment_wt + ll_nwt + ll_twt
	NEXT
END IF

li_totalrow = 0
li_totalrow = ids_scrap.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_nwt = 0
		ll_twt = 0
		ll_nwt = ids_scrap.GetItemNumber(li_int, "scrap_skid_scrap_net_wt", Primary!, FALSE)
		ll_twt = ids_scrap.GetItemNumber(li_int, "scrap_skid_scrap_tare_wt", Primary!, FALSE)
		IF ISNULL(ll_twt) THEN ll_twt = 0
		IF ISNULL(ll_nwt) THEN ll_nwt = 0
		ll_shipment_wt = ll_shipment_wt + ll_nwt + ll_twt
	NEXT
END IF

li_totalrow = 0
li_totalrow = ids_rejcoil.RowCount()
IF li_totalrow > 0 THEN 
	FOR li_int = 1 TO li_totalrow
		ll_nwt = 0
		ll_nwt = ids_rejcoil.GetItemNumber(li_int, "coil_net_wt_balance", Primary!, FALSE)
		IF ISNULL(ll_nwt) THEN ll_nwt = 0
		ll_shipment_wt = ll_shipment_wt + ll_nwt
	NEXT
END IF
ls_modstring = "total_wt_t.Text = ~"" + String(ll_shipment_wt, "###,###,###") + "~""	
idw_requestor.Modify(ls_modstring) 

il_totalgross = ll_shipment_wt

Return 1
end event

event ue_groupdwprint;call super::ue_groupdwprint;SetPointer(HourGlass!)
this.Event ue_multi_jobs(al_shipment)
Return 1
end event

event destructor;call super::destructor;IF IsValid(ids_sheet) THEN DESTROY ids_sheet
IF IsValid(ids_scrap) THEN DESTROY ids_scrap
IF IsValid(ids_rejcoil) THEN DESTROY ids_rejcoil

end event

