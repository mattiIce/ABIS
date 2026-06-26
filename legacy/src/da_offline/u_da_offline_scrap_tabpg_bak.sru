$PBExportHeader$u_da_offline_scrap_tabpg_bak.sru
forward
global type u_da_offline_scrap_tabpg_bak from u_tabpg
end type
type cb_retrieve from u_cb within u_da_offline_scrap_tabpg_bak
end type
type cb_edit from u_cb within u_da_offline_scrap_tabpg_bak
end type
type st_6 from statictext within u_da_offline_scrap_tabpg_bak
end type
type st_5 from statictext within u_da_offline_scrap_tabpg_bak
end type
type cb_2 from u_cb within u_da_offline_scrap_tabpg_bak
end type
type cb_new from u_cb within u_da_offline_scrap_tabpg_bak
end type
type cb_change_pallet from commandbutton within u_da_offline_scrap_tabpg_bak
end type
type cb_change_type from commandbutton within u_da_offline_scrap_tabpg_bak
end type
type cb_enter_pcs from commandbutton within u_da_offline_scrap_tabpg_bak
end type
type pb_change_pallet from u_pb within u_da_offline_scrap_tabpg_bak
end type
type pb_change_scrap_type from u_pb within u_da_offline_scrap_tabpg_bak
end type
type dw_scrap_type from u_dw within u_da_offline_scrap_tabpg_bak
end type
type st_3 from statictext within u_da_offline_scrap_tabpg_bak
end type
type cbx_od from checkbox within u_da_offline_scrap_tabpg_bak
end type
type st_scrap_skid_num from statictext within u_da_offline_scrap_tabpg_bak
end type
type st_1 from statictext within u_da_offline_scrap_tabpg_bak
end type
type cbx_mill from checkbox within u_da_offline_scrap_tabpg_bak
end type
type pb_scrap_pcs from u_pb within u_da_offline_scrap_tabpg_bak
end type
type em_scrap_pcs from u_em within u_da_offline_scrap_tabpg_bak
end type
type pb_scrap_wt from u_pb within u_da_offline_scrap_tabpg_bak
end type
type em_scrap_wt from u_em within u_da_offline_scrap_tabpg_bak
end type
type st_4 from statictext within u_da_offline_scrap_tabpg_bak
end type
type st_2 from statictext within u_da_offline_scrap_tabpg_bak
end type
type cb_read_scale from commandbutton within u_da_offline_scrap_tabpg_bak
end type
type cb_scrap_print from commandbutton within u_da_offline_scrap_tabpg_bak
end type
type cb_save from commandbutton within u_da_offline_scrap_tabpg_bak
end type
type cb_delete_item from commandbutton within u_da_offline_scrap_tabpg_bak
end type
type gb_1 from groupbox within u_da_offline_scrap_tabpg_bak
end type
type dw_scrap from u_dw within u_da_offline_scrap_tabpg_bak
end type
type dw_edit from u_dw within u_da_offline_scrap_tabpg_bak
end type
end forward

global type u_da_offline_scrap_tabpg_bak from u_tabpg
integer width = 2765
integer height = 1626
long backcolor = 65535
string text = "SCRAP"
long tabbackcolor = 65535
boolean ib_isupdateable = false
cb_retrieve cb_retrieve
cb_edit cb_edit
st_6 st_6
st_5 st_5
cb_2 cb_2
cb_new cb_new
cb_change_pallet cb_change_pallet
cb_change_type cb_change_type
cb_enter_pcs cb_enter_pcs
pb_change_pallet pb_change_pallet
pb_change_scrap_type pb_change_scrap_type
dw_scrap_type dw_scrap_type
st_3 st_3
cbx_od cbx_od
st_scrap_skid_num st_scrap_skid_num
st_1 st_1
cbx_mill cbx_mill
pb_scrap_pcs pb_scrap_pcs
em_scrap_pcs em_scrap_pcs
pb_scrap_wt pb_scrap_wt
em_scrap_wt em_scrap_wt
st_4 st_4
st_2 st_2
cb_read_scale cb_read_scale
cb_scrap_print cb_scrap_print
cb_save cb_save
cb_delete_item cb_delete_item
gb_1 gb_1
dw_scrap dw_scrap
dw_edit dw_edit
end type
global u_da_offline_scrap_tabpg_bak u_da_offline_scrap_tabpg_bak

type variables
string is_title
w_da_sheet iw_sheet
long il_scrap_skid_num, il_edit_row  //, al_sheet_skid_num
//w_tare iw_tare
//w_load_partial iw_load_partial
w_load_scrap_tare iw_load_scrap_tare
w_scrap_type iw_scrap_type
w_da_tabpg_offline_scrap_edit iw_da_tabpg_scrap_edit
s_partial_skid istr_scrap_skid
u_coil iu_coil
int ii_scrap_type
int ii_pre_scrap_type

//char ic_update_criteria //i:insert, d:delete, u:update
SQLPreviewType isql_criteria

string is_RETURN_SCRAP_ITEM_keys[] = {"return_scrap_item_return_scrap_item_num" }
string is_RETURN_SCRAP_ITEM_cols[] = & 
{"return_scrap_item_return_item_net_wt", "return_scrap_item_scrap_item_pieces","return_scrap_item_scrap_item_type", &
"return_scrap_item_return_item_notes","return_scrap_item_od","return_scrap_item_mill",&
"return_scrap_item_coil_abc_num","return_scrap_item_ab_job_num"}
string is_SCRAP_SKID_DETAIL_keys[] ={"scrap_skid_detail_scrap_skid_num", "scrap_skid_detail_return_scrap_item_num"}
string is_SCRAP_SKID_DETAIL_cols[] = &
{"scrap_skid_detail_scrap_skid_num","scrap_skid_detail_return_scrap_item_num"}
string is_SCRAP_SKID_keys[]={"scrap_skid_scrap_skid_num"}
string is_SCRAP_SKID_cols[] = &
{"scrap_skid_scrap_net_wt"}

end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
public subroutine of_add_current_scrap_pieces (integer ai_pcs)
public subroutine of_print_scrap_ticket (long al_skid_num, long al_net, long al_tare)
public subroutine of_change_scrap_type (integer ai_new_type)
public function integer of_delete_item (long al_item_num, long al_skid_num, long al_item_nw)
public subroutine of_add_scrap_item (integer ai_pcs, long al_wt, integer ai_type)
public function integer of_data_validation (long al_row)
public function integer of_save ()
end prototypes

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
if isValid( iw_sheet.iu_current_coil ) then
	iu_coil = iw_sheet.iu_current_coil
end if
dw_scrap.of_retrieve( )
//dw_skid_item.of_retrieve( )
dw_scrap.inv_base.of_populatedddw( )
is_title = "Scrap item"
long ll_row
//dw_scrap_type.settransobject( sqlca)
//dw_scrap_type.retrieve( )
//dw_scrap.inv_base.of_populatedddw( )

//dw_scrap.sharedata( dw_edit)
ll_row = dw_scrap_type.insertrow( 0 )
dw_scrap_type.object.id[ll_row] = 0
ii_pre_scrap_type = 0
ii_scrap_type = 0
//ll_row = dw_scrap.rowcount( )
//dw_edit.scrolltorow( ll_row )
end subroutine

public subroutine of_add_current_scrap_pieces (integer ai_pcs);int li_pcs
	li_pcs = Long(em_scrap_pcs.text)
	em_scrap_pcs.text = string( li_pcs + ai_pcs )
	//gb_skid.backcolor = 12639424//mint
	//gb_scrap.backcolor = 15780518 //sky


end subroutine

public subroutine of_print_scrap_ticket (long al_skid_num, long al_net, long al_tare);Datastore lds_skid
		lds_skid = create datastore
		lds_skid.dataobject = "d_scrap_skid_ticket"
		lds_skid.settransobject( sqlca)
		lds_skid.retrieve( al_skid_num)
		
		//Set Job and Coil info
		lds_skid.object.t_customer.text = iu_coil.of_get_customer_name( )
		lds_skid.object.t_skid_num_b.text = "*3S" + string(al_skid_num) + "*"
		lds_skid.object.t_skid_num_t.text = string(al_skid_num)
		//lds_skid.object.t_job.text = string(iu_coil.get_current_job( ))
		//lds_skid.object.t_alloy.text = iu_coil.of_get_alloy()
		//lds_skid.object.t_temper.text = iu_coil.of_get_temper()
		//lds_skid.object.t_gage.text = string(iu_coil.of_get_gauge( ))
		//lds_skid.object.t_width.text = string(iu_coil.of_get_part_width( ))
		//lds_skid.object.t_length.text = string(iu_coil.of_get_part_length( ))
		lds_skid.object.t_gross_wt.text = string((al_net + al_tare))
		lds_skid.object.t_net.text = string(al_net)
		lds_skid.object.t_tare.text = string(al_tare)
		lds_skid.print( )

end subroutine

public subroutine of_change_scrap_type (integer ai_new_type);Int li_pcs
long ll_wt
//if ii_pre_scrap_type = ii_scrap_type or ii_pre_scrap_type = 0 then
//	return
//end if

if ii_scrap_type = ai_new_type then
	return
end if
ii_pre_scrap_type = ii_scrap_type
ii_scrap_type = ai_new_type
if ii_pre_scrap_type <> 0 then
	if	MessageBox("scrap type changed"   ,  &
		"Do you want to save scrap type ?", Question!, YesNo!   ) = 1 then //Saving scrap item
		cb_read_scale.event clicked( )
		li_pcs = Integer(em_scrap_pcs.text)
		ll_wt = Long( em_scrap_wt.text )
			if li_pcs < 1 or ll_wt < 1 then
				MessageBox("Can not add scrap item", "Invalid pcs or weight!", StopSign!)
				return
			end if
		
		if istr_scrap_skid.partial_skid_num < 1000  or istr_scrap_skid.partial_skid_net_wt > 9999 then
			MessageBox("Can not add scrap item", "Please select a valid scrap pallet", StopSign!)
			return
		end if
		
		of_add_scrap_item( li_pcs , ll_wt , ii_scrap_type  )
		em_scrap_pcs.text = "0"
		em_scrap_wt.text = "0"
		iw_sheet.wf_zero_scale( )
//	else
//		return
	end if //end of save scrap item
end if
	dw_scrap_type.object.id[1] = ii_scrap_type
end subroutine

public function integer of_delete_item (long al_item_num, long al_skid_num, long al_item_nw);//Return 0 if good. 1 if failed
DELETE FROM "SCRAP_SKID_DETAIL"  
   				WHERE "SCRAP_SKID_DETAIL"."RETURN_SCRAP_ITEM_NUM" = :al_item_num   ;
			if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
			end if
			  DELETE FROM "RETURN_SCRAP_ITEM"  
   			WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :al_item_num   ;
			if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
			end if
			
					UPDATE "SCRAP_SKID"  
     				SET "SCRAP_NET_WT" = "SCRAP_NET_WT" - :al_item_nw
   				WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" = :al_skid_num ;
			
			if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
			end if
//			this.deleterow( row )
			return 0
end function

public subroutine of_add_scrap_item (integer ai_pcs, long al_wt, integer ai_type);long ll_scrap_seq, ll_job, ll_coil,ll_rc, ll_cust_id,ll_shift_num,ll_i
int li_mill, li_od
string ls_alloy, ls_job, ls_temper, ls_note
//if ai_pcs > 999 or ai_pcs < 1 then
//	MessageBox("Save scrap item", "Invalid pieces!", StopSign!)
//	return
//end if
//
//if al_wt > 8998 or al_wt < 1 then
//	MessageBox("Save scrap item", "Invalid weight!", StopSign!)
//	return
//end if
//
//if ai_type > 999 or ai_type < 1 then
//	MessageBox("Save scrap item", "Invalid type", StopSign!)
//	return
//end if

ll_coil = iu_coil.get_coil_abc_id( )
ll_job = iu_coil.get_current_job( )
ll_cust_id = iu_coil.of_get_customer_id( )
ls_alloy = iu_coil.of_get_alloy( )
ls_temper = iu_coil.of_get_temper( )
ls_job = string(ll_job)
ls_note = "DAS"
ll_shift_num = iu_coil.of_get_shift_id( )
//if cbx_mill.checked then
	li_mill = 1
//else
//	li_mill = 0
//end if

//if cbx_od.checked then
//	li_od = 1
//else
	li_od = 1
//end if

SELECT return_scrap_item_id_seq.NEXTVAL INTO :ll_scrap_seq FROM DUAL;
  INSERT INTO "RETURN_SCRAP_ITEM"  
         ( "RETURN_SCRAP_ITEM_NUM",   
           "COIL_ABC_NUM",   
           "AB_JOB_NUM",   
           "RETURN_ITEM_NET_WT",   
           "RETURN_ITEM_DATE",   
           "RETURN_ITEM_NOTES",   
           "SCRAP_ITEM_PIECES",   
           "SCRAP_ITEM_TYPE",   
           "MILL",
			  "SHIFT_NUM",
			  "OD")  
  VALUES ( :ll_scrap_seq,   
           :ll_coil,   
           :ll_job,   
           :al_wt,   
           sysdate,   
           null,   
           :ai_pcs,   
           :ai_type,   
           :li_mill,
			  :ll_shift_num,
			  :li_od);
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert scrap item")
		return
	end if
//
	if istr_scrap_skid.partial_skid_net_wt = 0 then
		//add to new scrap skid
		  INSERT INTO "SCRAP_SKID"  
         ( "SCRAP_SKID_NUM",   
           "CUSTOMER_ID",   
           "SCRAP_TYPE",   
           "SCRAP_ALLOY",   
           "SCRAP_TEMPER",   
           "SCRAP_NET_WT",   
           "SCRAP_TARE_WT",   
           "SCRAP_CUST_PO",   
           "SCRAP_AB_JOB_NUM",   
           "SCRAP_LOCATION",   
           "SCRAP_DATE",   
           "SKID_SCRAP_STATUS",   
           "SCRAP_NOTES",   
           "SCRAP_ALLOY2",   
           "TOTE_NUM" )  
  VALUES ( :istr_scrap_skid.partial_skid_num,   
           :ll_cust_id,   
           null,   
           null,   
           :ls_temper,   
           :al_wt,   
           :istr_scrap_skid.partial_skid_tare_wt,   
           null,   
           :ls_job,   
           null,   
           sysdate,   
           1,   
           :ls_note,   
           :ls_alloy,   
           null );
				if ll_rc <> 0 then
					sqlca.of_rollback( )
					MessageBox("Database error", "Error insert scrap skid")
					return
				end if
				
			  INSERT INTO "SCRAP_SKID_DETAIL"  
         	( "SCRAP_SKID_NUM", "RETURN_SCRAP_ITEM_NUM" )  
  				VALUES ( :istr_scrap_skid.partial_skid_num,   
           				:ll_scrap_seq )  ;
				if ll_rc <> 0 then
					sqlca.of_rollback( )
					MessageBox("Database error", "Error insert scrap skid detail")
					return
				end if
	else
		//add to existing scrap skid
		    INSERT INTO "SCRAP_SKID_DETAIL"  
         ( "SCRAP_SKID_NUM",   
           "RETURN_SCRAP_ITEM_NUM" )  
  			VALUES ( :istr_scrap_skid.partial_skid_num,   
           :ll_scrap_seq )  ;
				if ll_rc <> 0 then
					sqlca.of_rollback( )
					MessageBox("Database error", "Error insert scrap skid detail")
					return
				end if
			  UPDATE "SCRAP_SKID"  
     				SET "SCRAP_NET_WT" = "SCRAP_NET_WT" + :al_wt 
   				WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" = :istr_scrap_skid.partial_skid_num ;
				if ll_rc <> 0 then
					sqlca.of_rollback( )
					MessageBox("Database error", "Error update scrap skid")
					return
				end if
			
		
	end if
	
	sqlca.of_commit( )
	
	ll_rc = dw_scrap.insertrow( 0 )
		
	dw_scrap.object.return_scrap_item_return_item_net_wt[ll_rc] = al_wt
	dw_scrap.object.compute_0015[ll_rc] = al_wt
	dw_scrap.object.return_scrap_item_scrap_item_pieces[ll_rc] = ai_pcs
	//dw_scrap.object.return_scrap_item_scrap_item_type[ll_rc] = 1
	dw_scrap.object.return_scrap_item_return_item_notes[ll_rc] = ls_note
	dw_scrap.object.return_scrap_item_return_scrap_item_num[ll_rc] = ll_scrap_seq
	dw_scrap.object.return_scrap_item_coil_abc_num[ll_rc] = ll_coil
	dw_scrap.object.return_scrap_item_ab_job_num[ll_rc] = ll_job
	dw_scrap.object.return_scrap_item_scrap_item_type[ll_rc] = ai_type
	dw_scrap.object.return_scrap_item_mill[ll_rc] = li_mill
	dw_scrap.object.return_scrap_item_od[ll_rc] = li_od
	
	//dw_scrap.object.return_scrap_item_return_item_date = DateTime(Today(),Now())
	dw_scrap.setitem( ll_rc, "return_scrap_item_return_item_date", DateTime(Today(),Now()))
	
	dw_scrap.object.scrap_skid_detail_scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num
	dw_scrap.object.scrap_skid_scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num 
		
	for ll_i=1 to ll_rc
		if dw_scrap.object.scrap_skid_scrap_skid_num[ll_i] = istr_scrap_skid.partial_skid_num then
			dw_scrap.object.scrap_skid_scrap_net_wt[ll_i] = istr_scrap_skid.partial_skid_net_wt + al_wt
		end if
	next
	
	
	dw_scrap.object.scrap_skid_detail_return_scrap_item_num[ll_rc] = ll_scrap_seq
//	dw_scrap.object.scrap_skid_scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num 
	istr_scrap_skid.partial_skid_net_wt = istr_scrap_skid.partial_skid_net_wt + al_wt
	istr_scrap_skid.partial_skid_status = 7
	
	DWItemStatus ldw_status
	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
//	MessageBox("itemstatus", string(1))
	dw_scrap.setitemstatus( ll_rc, 0, Primary!, NotModified!)
	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
	dw_scrap.setitemstatus( ll_rc, 0, Primary!, DataModified!)
	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
	dw_scrap.setitemstatus( ll_rc, 0, Primary!, NotModified!)
	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
	
	dw_scrap.setrow( ll_rc)
	dw_scrap.selectrow( 0, false)
	dw_scrap.selectrow( ll_rc, true)
	dw_edit.scrolltorow( ll_rc)
	
	
end subroutine

public function integer of_data_validation (long al_row);if dw_edit.object.return_scrap_item_return_item_net_wt[al_row] < 0 or dw_edit.object.return_scrap_item_return_item_net_wt[al_row] > 8000 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid net weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_edit.object.return_scrap_item_scrap_item_pieces[al_row] < 1 or dw_edit.object.return_scrap_item_scrap_item_pieces[al_row] > 999 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid scrap pieces!", Exclamation!, Ok!, 1)
	return 1
end if


return 0 //return 0 if validated
end function

public function integer of_save ();long ll_rc

//Update function
dw_scrap.inv_multitable.of_unregister( )
ll_rc = dw_scrap.inv_multitable.of_register( "return_scrap_item",  is_return_scrap_item_keys, is_return_scrap_item_cols, false, 0 )
if ll_rc <> 1 then
	Messagebox("register", "return_scrap_item register failed")
	return 1
end if
ll_rc = dw_scrap.inv_multitable.of_register( "scrap_skid", is_scrap_skid_keys, is_scrap_skid_cols, false, 0 )
if ll_rc <> 1 then
	Messagebox("register", "scrap skid register failed")
	return 1
end if
ll_rc = dw_scrap.inv_multitable.of_register( "scrap_skid_detail", is_scrap_skid_detail_keys, is_scrap_skid_detail_cols, false, 0 )
if ll_rc <> 1 then
	Messagebox("register", "scrap_skid_detail register failed")
	return 1
end if

isql_criteria = PreviewUpdate!
if dw_scrap.of_update( true, true) = 1 then
	sqlca.of_commit( )
else
	sqlca.of_rollback( )
	MessageBox("save","failed")
	return 1
end if
iu_coil.of_update_from_skid_scrap( )
return 0
end function

on u_da_offline_scrap_tabpg_bak.create
int iCurrent
call super::create
this.cb_retrieve=create cb_retrieve
this.cb_edit=create cb_edit
this.st_6=create st_6
this.st_5=create st_5
this.cb_2=create cb_2
this.cb_new=create cb_new
this.cb_change_pallet=create cb_change_pallet
this.cb_change_type=create cb_change_type
this.cb_enter_pcs=create cb_enter_pcs
this.pb_change_pallet=create pb_change_pallet
this.pb_change_scrap_type=create pb_change_scrap_type
this.dw_scrap_type=create dw_scrap_type
this.st_3=create st_3
this.cbx_od=create cbx_od
this.st_scrap_skid_num=create st_scrap_skid_num
this.st_1=create st_1
this.cbx_mill=create cbx_mill
this.pb_scrap_pcs=create pb_scrap_pcs
this.em_scrap_pcs=create em_scrap_pcs
this.pb_scrap_wt=create pb_scrap_wt
this.em_scrap_wt=create em_scrap_wt
this.st_4=create st_4
this.st_2=create st_2
this.cb_read_scale=create cb_read_scale
this.cb_scrap_print=create cb_scrap_print
this.cb_save=create cb_save
this.cb_delete_item=create cb_delete_item
this.gb_1=create gb_1
this.dw_scrap=create dw_scrap
this.dw_edit=create dw_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_retrieve
this.Control[iCurrent+2]=this.cb_edit
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_new
this.Control[iCurrent+7]=this.cb_change_pallet
this.Control[iCurrent+8]=this.cb_change_type
this.Control[iCurrent+9]=this.cb_enter_pcs
this.Control[iCurrent+10]=this.pb_change_pallet
this.Control[iCurrent+11]=this.pb_change_scrap_type
this.Control[iCurrent+12]=this.dw_scrap_type
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.cbx_od
this.Control[iCurrent+15]=this.st_scrap_skid_num
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.cbx_mill
this.Control[iCurrent+18]=this.pb_scrap_pcs
this.Control[iCurrent+19]=this.em_scrap_pcs
this.Control[iCurrent+20]=this.pb_scrap_wt
this.Control[iCurrent+21]=this.em_scrap_wt
this.Control[iCurrent+22]=this.st_4
this.Control[iCurrent+23]=this.st_2
this.Control[iCurrent+24]=this.cb_read_scale
this.Control[iCurrent+25]=this.cb_scrap_print
this.Control[iCurrent+26]=this.cb_save
this.Control[iCurrent+27]=this.cb_delete_item
this.Control[iCurrent+28]=this.gb_1
this.Control[iCurrent+29]=this.dw_scrap
this.Control[iCurrent+30]=this.dw_edit
end on

on u_da_offline_scrap_tabpg_bak.destroy
call super::destroy
destroy(this.cb_retrieve)
destroy(this.cb_edit)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.cb_2)
destroy(this.cb_new)
destroy(this.cb_change_pallet)
destroy(this.cb_change_type)
destroy(this.cb_enter_pcs)
destroy(this.pb_change_pallet)
destroy(this.pb_change_scrap_type)
destroy(this.dw_scrap_type)
destroy(this.st_3)
destroy(this.cbx_od)
destroy(this.st_scrap_skid_num)
destroy(this.st_1)
destroy(this.cbx_mill)
destroy(this.pb_scrap_pcs)
destroy(this.em_scrap_pcs)
destroy(this.pb_scrap_wt)
destroy(this.em_scrap_wt)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.cb_read_scale)
destroy(this.cb_scrap_print)
destroy(this.cb_save)
destroy(this.cb_delete_item)
destroy(this.gb_1)
destroy(this.dw_scrap)
destroy(this.dw_edit)
end on

event destructor;call super::destructor;//if isValid( iw_tare ) then
//	Close(iw_tare)
//end if
//
//if isValid(iw_load_partial) then
//	Close( iw_load_partial )
//end if
//
//dw_edit.resetupdate( )
//dw_scrap.resetupdate( )
//dw_scrap_type.resetupdate( )
if isValid(iw_load_scrap_tare) then
	Close( iw_load_scrap_tare )
end if

if isValid(iw_scrap_type) then
	Close( iw_scrap_type )
end if

if isValid(iw_da_tabpg_scrap_edit ) then
	Close( iw_da_tabpg_scrap_edit )
end if


if dw_scrap.of_updatespending( ) = 1 then
	if MessageBox("Downtime", "Data changed, Save it?", Exclamation!, YesNo!, 2) = 2 then
				dw_scrap.resetupdate( )
				return 0
	end if
	of_save( )
end if
return 0
end event

event constructor;call super::constructor;//iw_sheet = message.powerobjectparm
//if isValid( iw_sheet.iu_current_coil ) then
//	iu_coil = iw_sheet.iu_current_coil
//end if
//dw_scrap.settransobject( sqlca)
//dw_scrap.of_retrieve( )
//dw_scrap.inv_base.of_populatedddw( )
//
//long ll_row
//ll_row = dw_scrap_type.insertrow( 0 )
//dw_scrap_type.object.id[ll_row] = 0
//ii_pre_scrap_type = 0
//ii_scrap_type = 0
end event

type cb_retrieve from u_cb within u_da_offline_scrap_tabpg_bak
integer x = 936
integer y = 1485
integer width = 399
integer height = 102
integer taborder = 120
integer textsize = -11
string facename = "Arial"
string text = "Retrieve wt"
end type

event clicked;call super::clicked;dw_scrap.of_retrieve( )
end event

type cb_edit from u_cb within u_da_offline_scrap_tabpg_bak
integer x = 475
integer y = 1485
integer width = 399
integer height = 102
integer taborder = 120
integer textsize = -11
string facename = "Arial"
string text = "Edit"
end type

event clicked;call super::clicked;long ll_row
ll_row = dw_scrap.getselectedrow(0)
if ll_row < 1 then
	MessageBox("Edit scrap", "Please select a scrap to edit!")
	return 1
end if

il_edit_row = ll_row
if Not isValid( iw_da_tabpg_scrap_edit ) then
	OpenWithParm(iw_da_tabpg_scrap_edit, parent)
end if
end event

type st_6 from statictext within u_da_offline_scrap_tabpg_bak
integer x = 29
integer y = 13
integer width = 538
integer height = 67
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Scrap item for coil"
boolean focusrectangle = false
end type

type st_5 from statictext within u_da_offline_scrap_tabpg_bak
integer x = 15
integer y = 1101
integer width = 552
integer height = 67
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Current scrap item"
boolean focusrectangle = false
end type

type cb_2 from u_cb within u_da_offline_scrap_tabpg_bak
integer x = 483
integer y = 1357
integer width = 497
integer height = 90
integer taborder = 210
integer textsize = -11
string facename = "Arial"
string text = "Change Pallet"
end type

event clicked;call super::clicked;s_partial_skid lstr_scrap_skid
long ll_cust_id, ll_rc
if not isValid( iw_load_scrap_tare ) then
	ll_cust_id = iu_coil.of_get_customer_id( )
	gl_message = ll_cust_id
	ll_rc = Open( iw_load_scrap_tare )
	
	lstr_scrap_skid = message.powerobjectparm
	if lstr_scrap_skid.partial_skid_num > 1000 then
		istr_scrap_skid = lstr_scrap_skid
		st_scrap_skid_num.text = string( istr_scrap_skid.partial_skid_num )
	else
//		st_scrap_skid_num.text = "none"
	end if
end if
end event

type cb_new from u_cb within u_da_offline_scrap_tabpg_bak
integer x = 15
integer y = 1485
integer width = 399
integer height = 102
integer taborder = 200
integer textsize = -11
string facename = "Arial"
string text = "New"
end type

event clicked;call super::clicked;if istr_scrap_skid.partial_skid_num < 1000 then
	MessageBox("Warning", "Please select pallet first", StopSign!)
	return 1
end if

dw_scrap.sharedata( dw_edit )
parent.of_add_scrap_item( 0, 0, 0)
end event

type cb_change_pallet from commandbutton within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 1126
integer y = 717
integer width = 464
integer height = 102
integer taborder = 200
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change pallet"
end type

event clicked;s_partial_skid lstr_scrap_skid
if not isValid( iw_load_scrap_tare ) then
	OpenWithParm( iw_load_scrap_tare , iu_coil.of_get_customer_id( )  )
	lstr_scrap_skid = message.powerobjectparm
	if lstr_scrap_skid.partial_skid_num > 1000 then
		istr_scrap_skid = lstr_scrap_skid
		st_scrap_skid_num.text = string( istr_scrap_skid.partial_skid_num )
	//else
		//st_scrap_skid_num.text = "none"
	end if
end if
end event

type cb_change_type from commandbutton within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 2037
integer y = 883
integer width = 464
integer height = 102
integer taborder = 190
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change type"
end type

event clicked;Int li_type
if dw_scrap_type.rowcount( ) = 1 then
	//li_type = dw_scrap_type.object.id[1]
	OpenWithParm( iw_scrap_type, parent )
else
	MessageBox("Error", "Scrap type error!")
	return 1
end if

end event

type cb_enter_pcs from commandbutton within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 2194
integer y = 550
integer width = 307
integer height = 102
integer taborder = 190
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Number"
end type

event clicked;em_scrap_pcs.Event pfc_DDCalculator( )
end event

type pb_change_pallet from u_pb within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 2531
integer y = 717
integer width = 121
integer height = 96
integer taborder = 130
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;s_partial_skid lstr_scrap_skid
if not isValid( iw_load_scrap_tare ) then
	OpenWithParm( iw_load_scrap_tare , iu_coil.of_get_customer_id( )  )
	lstr_scrap_skid = message.powerobjectparm
	if lstr_scrap_skid.partial_skid_num > 1000 then
		istr_scrap_skid = lstr_scrap_skid
		st_scrap_skid_num.text = string( istr_scrap_skid.partial_skid_num )
	//else
		//st_scrap_skid_num.text = "none"
	end if
end if
end event

type pb_change_scrap_type from u_pb within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 2531
integer y = 883
integer width = 121
integer height = 96
integer taborder = 90
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;Int li_type
if dw_scrap_type.rowcount( ) = 1 then
	//li_type = dw_scrap_type.object.id[1]
	OpenWithParm( iw_scrap_type, parent )
else
	MessageBox("Error", "Scrap type error!")
	return 1
end if

end event

type dw_scrap_type from u_dw within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 600
integer y = 883
integer width = 1287
integer height = 102
integer taborder = 80
string dataobject = "d_scrap_type_display"
boolean vscrollbar = false
end type

event pfc_populatedddw;call super::pfc_populatedddw;IF as_colname = "id" THEN
	adwc_obj.SetTransObject(SQLCA)
	Return adwc_obj.Retrieve()
ELSE
	Return 0
END IF
end event

event constructor;call super::constructor;this.of_setbase( true)
this.of_settransobject( sqlca)
end event

event itemchanged;call super::itemchanged;//MessageBox("dw_scrap_type", "item changed -" + data)
//ii_pre_scrap_type = ii_scrap_type
//ii_scrap_type = Integer( data )
of_change_scrap_type( Integer( data ) )

end event

type st_3 from statictext within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 234
integer y = 896
integer width = 380
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "Scrap type:"
boolean focusrectangle = false
end type

event clicked;//long ll_row
//dw_scrap_type.settransobject( sqlca)
//dw_scrap_type.retrieve( )
//ll_row = dw_scrap_type.insertrow( 0 )
//
//dw_scrap_type.object.id[ll_row] = 0
//
MessageBox("fdfd",string( dw_scrap_type.object.id[1] ))
end event

type cbx_od from checkbox within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 2194
integer y = 717
integer width = 230
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "OD"
boolean checked = true
end type

type st_scrap_skid_num from statictext within u_da_offline_scrap_tabpg_bak
integer x = 234
integer y = 1357
integer width = 249
integer height = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within u_da_offline_scrap_tabpg_bak
integer x = 29
integer y = 1370
integer width = 219
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 65535
string text = "Pallet:"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cbx_mill from checkbox within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 1858
integer y = 717
integer width = 230
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "Mill"
boolean checked = true
end type

type pb_scrap_pcs from u_pb within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 2531
integer y = 550
integer width = 121
integer height = 96
integer taborder = 180
string text = "Number"
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;em_scrap_pcs.Event pfc_DDCalculator( )
end event

type em_scrap_pcs from u_em within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 1858
integer y = 550
integer width = 336
integer height = 102
integer taborder = 40
integer textsize = -12
string text = "000"
string mask = "####"
boolean spin = true
string minmax = "0~~999"
end type

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
end event

type pb_scrap_wt from u_pb within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 936
integer y = 550
integer width = 121
integer height = 102
integer taborder = 160
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;em_scrap_wt.Event pfc_DDCalculator( )
end event

type em_scrap_wt from u_em within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 600
integer y = 550
integer width = 336
integer height = 102
integer taborder = 170
integer textsize = -12
string text = "0000"
string mask = "####"
string minmax = "0~~9999"
end type

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
end event

type st_4 from statictext within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 1682
integer y = 563
integer width = 157
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "Pcs:"
boolean focusrectangle = false
end type

type st_2 from statictext within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 234
integer y = 563
integer width = 267
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "Weight:"
boolean focusrectangle = false
end type

type cb_read_scale from commandbutton within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 1068
integer y = 550
integer width = 439
integer height = 102
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Read Scale"
end type

event clicked;long ll_read
ll_read = iw_sheet.wf_read_scale( )
em_scrap_wt.text = string( ll_read )

//MessageBox("test", String(Integer(em_scrap_wt.text)))
end event

type cb_scrap_print from commandbutton within u_da_offline_scrap_tabpg_bak
integer x = 1397
integer y = 1485
integer width = 399
integer height = 102
integer taborder = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;long ll_skid_num, ll_row, ll_net, ll_tare//, ll_pcs
ll_row = dw_scrap.getselectedrow( 0 ) //getrow( )

if ll_row > 0 then
	ll_skid_num = dw_scrap.object.scrap_skid_detail_scrap_skid_num[ ll_row ]
	//ll_net = dw_scrap.object.sheet_skid_sheet_net_wt[ ll_row ]
	//ll_tare = dw_scrap.object.sheet_skid_sheet_tare_wt[ ll_row ]
	//ll_pcs = dw_skid_item.object.sheet_skid_skid_pieces[ ll_row ]
	
	  SELECT "SCRAP_SKID"."SCRAP_NET_WT",   
         "SCRAP_SKID"."SCRAP_TARE_WT"  
    INTO :ll_net,   
         :ll_tare  
    FROM "SCRAP_SKID"  
   WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" = :ll_skid_num   ;

	
	if ll_skid_num > 10000 then
		of_print_scrap_ticket( ll_skid_num, ll_net, ll_tare )
	end if
end if

end event

type cb_save from commandbutton within u_da_offline_scrap_tabpg_bak
integer x = 2319
integer y = 1485
integer width = 399
integer height = 102
integer taborder = 110
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;long ll_rc, ll_row



if dw_edit.rowcount( ) > 0 then
	ll_row = dw_edit.getrow( )
	if ll_row > 0 then
		if of_data_validation( ll_row ) <> 0 then
			return 1
		end if
	end if
end if


of_save( )
dw_edit.sharedataoff( )


end event

type cb_delete_item from commandbutton within u_da_offline_scrap_tabpg_bak
integer x = 1858
integer y = 1485
integer width = 399
integer height = 102
integer taborder = 120
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;//Delete function
long row, ll_item_num, ll_skid_num, ll_item_nw, ll_rc, ll_i
		  row = dw_scrap.getselectedrow( 0 )
			if row < 1 then
				MessageBox("Delete item", "No item selected!")
				return 1
			end if
			
			if dw_edit.rowcount( ) > 0 then
				MessageBox("Delete item", "Can not delete item. Please save current scrap item first!!")
				return 1
			end if
				
			
			
			if MessageBox("Delete item", "Do you want to delete selected item?", Exclamation!, OKCancel!, 2) = 2 then
				return 0
			end if
		ll_item_num = dw_scrap.object.return_scrap_item_return_scrap_item_num[row]
		ll_skid_num = dw_scrap.object.scrap_skid_detail_scrap_skid_num[row]
		ll_item_nw = dw_scrap.object.return_scrap_item_return_item_net_wt[row]
		if of_delete_item( ll_item_num, ll_skid_num, ll_item_nw) = 0 then
			dw_scrap.deleterow( row )
//			cb_save.event clicked( )
			
			//ll_scrap_skid_id = this.object.scrap_skid_scrap_skid_num[row]
			ll_rc = dw_scrap.rowcount( )
	
			for ll_i=1 to ll_rc
				if dw_scrap.object.scrap_skid_scrap_skid_num[ll_i] = ll_skid_num then
					dw_scrap.object.scrap_skid_scrap_net_wt[ll_i] = dw_scrap.object.scrap_skid_scrap_net_wt[ll_i] - ll_item_nw
				end if
			next

		end if
		

end event

type gb_1 from groupbox within u_da_offline_scrap_tabpg_bak
boolean visible = false
integer x = 102
integer y = 461
integer width = 2575
integer height = 576
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "current scrap item"
end type

type dw_scrap from u_dw within u_da_offline_scrap_tabpg_bak
integer x = 15
integer y = 77
integer width = 2721
integer height = 1024
integer taborder = 150
string dataobject = "d_scrap_display"
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;//return this.retrieve( il_coil_num, il_job_num )
long ll_job, ll_coil
ll_job = iu_coil.get_current_job( )
ll_coil = iu_coil.get_coil_abc_id( )
return this.retrieve(ll_coil , ll_job )
end event

event constructor;call super::constructor;long ll_rc
string ls_tem[], ls_tem2[], ls_tem3[], ls_keys[]
//ls_keys[] = {"return_scrap_item_return_scrap_item_num" }
this.of_SetDropDownCalculator(TRUE)
this.iuo_calculator.of_Register("return_scrap_item_return_item_net_wt", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("return_scrap_item_scrap_item_pieces", &
this.iuo_calculator.NONE)

this.iuo_calculator.of_SetCloseOnClick(True)
this.iuo_calculator.of_SetInitialValue(TRUE)
this.of_setbase( true)
this.of_settransobject( sqlca)
this.of_setmultitable( true)
this.inv_multitable.of_getregisterable( ls_tem )
this.inv_multitable.of_getregisterabletable( ls_tem3)
this.inv_multitable.of_getregisterablecolumn( "return_scrap_item",ls_tem2  )
this.inv_multitable.of_getregisterablecolumn( "scrap_skid",ls_tem2  )
this.inv_multitable.of_getregisterablecolumn( "scrap_skid_detail",ls_tem2  )

ll_rc = this.inv_multitable.of_register( "return_scrap_item", is_return_scrap_item_keys, is_return_scrap_item_cols, false, 0 )
if ll_rc <> 1 then
	MessageBox("dw_skid_item", "register failed")
	return 0
end if
//ls_keys = {"scrap_skid_scrap_skid_num"}
ll_rc = this.inv_multitable.of_register( "scrap_skid", is_scrap_skid_keys, is_scrap_skid_cols, false,0 )
if ll_rc <> 1 then
	MessageBox("dw_skid_item", "register failed")
	return 0
end if
ls_keys = {"scrap_skid_detail_scrap_skid_num", "scrap_skid_detail_return_scrap_item_num"}
ll_rc = this.inv_multitable.of_register( "scrap_skid_detail", is_scrap_skid_detail_keys, is_scrap_skid_detail_cols,false,0 )
if ll_rc <> 1 then
	MessageBox("dw_skid_item", "register failed")
	return 0
end if

//sleep(1)
//
//this.of_retrieve( )
//return_scrap_item_return_item_net_wt
//return_scrap_item_return_item_net_wt
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF as_colname = "return_scrap_item_scrap_item_type" THEN
	adwc_obj.SetTransObject(SQLCA)
	Return adwc_obj.Retrieve()
ELSE
	Return 0
END IF


//return 0


//
end event

event itemchanged;call super::itemchanged;long ll_item_num, ll_item_nw, ll_diff, ll_scrap_skid_wt, ll_scrap_skid_id, ll_i, ll_rc
if dwo.Name = "return_scrap_item_return_item_net_wt" then
	ll_item_nw = Long( data )
	ll_diff = ll_item_nw - this.object.compute_0015[row]
	ll_scrap_skid_wt = &
	this.object.scrap_skid_scrap_net_wt[row] + ll_diff
//	this.object.compute_0015[row] = ll_item_nw
	//this.object.scrap_skid_scrap_net_wt[row] = ll_scrap_skid_wt
	ll_scrap_skid_id = this.object.scrap_skid_scrap_skid_num[row]
	ll_rc = this.rowcount( )
	
	for ll_i=1 to ll_rc
		if this.object.scrap_skid_scrap_skid_num[ll_i] = ll_scrap_skid_id then
			this.object.scrap_skid_scrap_net_wt[ll_i] = ll_scrap_skid_wt
		end if
	next
	if istr_scrap_skid.partial_skid_num = ll_scrap_skid_id then
		istr_scrap_skid.partial_skid_net_wt = ll_scrap_skid_wt
	end if
//	messageBox("", string(istr_scrap_skid.partial_skid_net_wt))
	this.object.compute_0015[row] = ll_item_nw
end if
return 0



//return 0
//long ll_item_num, ll_item_nw, ll_item_pieces, ll_change, ll_skid_num
//int li_mill,li_type,li_od
//string ls_note
//if row < 1 then
//	return 1
//end if
//ll_item_num = this.object.return_scrap_item_return_scrap_item_num[row]
//ll_skid_num = this.object.scrap_skid_detail_scrap_skid_num[row]
//if dwo.Name = "return_scrap_item_return_item_net_wt" then
//	  ll_item_nw = Long( data )
//	  UPDATE "RETURN_SCRAP_ITEM"  
//     	SET "RETURN_ITEM_NET_WT" = :ll_item_nw  
//   	WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num;
//		
//		if sqlca.sqlcode <> 0 then
//				sqlca.of_rollback( )
//				return 1
//		end if
//		//Update scrap skid too
//		ll_change = ll_item_nw - this.object.return_scrap_item_return_item_net_wt_1[row]
//		UPDATE "SCRAP_SKID"  
//     				SET "SCRAP_NET_WT" = "SCRAP_NET_WT" + :ll_change 
//   				WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" = :ll_skid_num ;
//		this.object.return_scrap_item_return_item_net_wt_1[row] = ll_item_nw
//		
//		
//elseif dwo.Name = "return_scrap_item_scrap_item_pieces" then
//	ll_item_pieces = Long(data)
//	ll_item_nw = this.object.return_scrap_item_return_item_net_wt[row]
//	  if ll_item_pieces > 0 then
//	  		UPDATE "RETURN_SCRAP_ITEM"  
//     		SET "SCRAP_ITEM_PIECES" = :ll_item_pieces  
//   		WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num   ;
//		else
//			    DELETE FROM "SCRAP_SKID_DETAIL"  
//   				WHERE "SCRAP_SKID_DETAIL"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num   ;
//			if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//			end if
//			  DELETE FROM "RETURN_SCRAP_ITEM"  
//   			WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num   ;
//			if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//			end if
//			
//					UPDATE "SCRAP_SKID"  
//     				SET "SCRAP_NET_WT" = "SCRAP_NET_WT" - :ll_item_nw
//   				WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" = :ll_skid_num ;
//			
//			
//			this.deleterow( row )
//			
//		end if
//
//elseif dwo.Name = "return_scrap_item_return_item_notes" then
//	ls_note = data
//	  UPDATE "RETURN_SCRAP_ITEM"  
//     	SET "RETURN_ITEM_NOTES" = :ls_note
//   	WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num   ;
//elseif dwo.Name = "return_scrap_item_scrap_item_type" then
//	li_type = Integer( data )
//  UPDATE "RETURN_SCRAP_ITEM"  
//     	SET "SCRAP_ITEM_TYPE" = :li_type
//   	WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num   ;
//elseif dwo.Name = "return_scrap_item_mill" then
//	li_mill = Integer( data )
//  UPDATE "RETURN_SCRAP_ITEM"  
//     	SET "MILL" = :li_mill
//   	WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num   ;
//elseif dwo.Name = "return_scrap_item_od" then
//	li_od = Integer(data)
//	UPDATE "RETURN_SCRAP_ITEM"  
//     	SET "OD" = :li_od
//   	WHERE "RETURN_SCRAP_ITEM"."RETURN_SCRAP_ITEM_NUM" = :ll_item_num   ;
//else
//	return 1
//end if
//			if sqlca.sqlcode <> 0 then
//				sqlca.of_rollback( )
//				MessageBox("Update scrap item", "Failed to update scrap item"     )
//				return 1
//			else
//				sqlca.of_commit( )
//			end if
//return 0
//

end event

event clicked;call super::clicked;this.accepttext( )
if row > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num " then
	this.selectrow( 0, false)
	this.selectrow( row, true)
//	dw_edit.scrolltorow( row)
	dw_scrap.setrow( row)
//	dw_edit.setrow( row)
end if

end event

event sqlpreview;call super::sqlpreview;if sqltype <> PreviewSelect!	then
	if sqltype <> isql_criteria then
		return 2
	end if
end if
end event

event losefocus;call super::losefocus;this.accepttext( )
end event

event doubleclicked;call super::doubleclicked;if row > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num" then
	
		il_edit_row = row
		openwithparm(iw_da_tabpg_scrap_edit, parent ) 
end if
end event

type dw_edit from u_dw within u_da_offline_scrap_tabpg_bak
integer x = 15
integer y = 1165
integer width = 2721
integer height = 294
integer taborder = 10
string dataobject = "d_scrap_edit_free_form_"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalculator(TRUE)
this.iuo_calculator.of_Register("return_scrap_item_return_item_net_wt", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("return_scrap_item_scrap_item_pieces", &
this.iuo_calculator.NONE)

end event

event itemchanged;call super::itemchanged;long ll_item_num, ll_item_nw, ll_diff, ll_scrap_skid_wt, ll_scrap_skid_id, ll_i, ll_rc
if dwo.Name = "return_scrap_item_return_item_net_wt" then
	ll_item_nw = Long( data )
	ll_diff = ll_item_nw - this.object.compute_0015[row]
	ll_scrap_skid_wt = &
	this.object.scrap_skid_scrap_net_wt[row] + ll_diff
//	this.object.compute_0015[row] = ll_item_nw
	//this.object.scrap_skid_scrap_net_wt[row] = ll_scrap_skid_wt
	ll_scrap_skid_id = this.object.scrap_skid_scrap_skid_num[row]
	ll_rc = this.rowcount( )
	
	for ll_i=1 to ll_rc
		if this.object.scrap_skid_scrap_skid_num[ll_i] = ll_scrap_skid_id then
			this.object.scrap_skid_scrap_net_wt[ll_i] = ll_scrap_skid_wt
		end if
	next
	if istr_scrap_skid.partial_skid_num = ll_scrap_skid_id then
		istr_scrap_skid.partial_skid_net_wt = ll_scrap_skid_wt
	end if
//	messageBox("", string(istr_scrap_skid.partial_skid_net_wt))
	this.object.compute_0015[row] = ll_item_nw
end if
return 0

end event

event losefocus;call super::losefocus;this.of_accepttext( true)
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF as_colname = "return_scrap_item_scrap_item_type" THEN
	adwc_obj.SetTransObject(SQLCA)
	Return adwc_obj.Retrieve()
ELSE
	Return 0
END IF
end event

