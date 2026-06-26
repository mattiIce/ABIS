$PBExportHeader$u_da_scrap_tabpg.sru
forward
global type u_da_scrap_tabpg from u_tabpg
end type
type cb_sample from u_cb within u_da_scrap_tabpg
end type
type cb_nonconf from u_cb within u_da_scrap_tabpg
end type
type cb_reset_scale from commandbutton within u_da_scrap_tabpg
end type
type cb_reset_pcs from commandbutton within u_da_scrap_tabpg
end type
type em_offset from editmask within u_da_scrap_tabpg
end type
type cb_retrieve from u_cb within u_da_scrap_tabpg
end type
type cb_edit from u_cb within u_da_scrap_tabpg
end type
type cb_new from u_cb within u_da_scrap_tabpg
end type
type cb_scrap_print from commandbutton within u_da_scrap_tabpg
end type
type cb_save from commandbutton within u_da_scrap_tabpg
end type
type cb_delete_item from commandbutton within u_da_scrap_tabpg
end type
type cb_pallet from u_cb within u_da_scrap_tabpg
end type
type cb_change_type from commandbutton within u_da_scrap_tabpg
end type
type cb_read_scale from commandbutton within u_da_scrap_tabpg
end type
type dw_scrap from u_dw within u_da_scrap_tabpg
end type
type dw_current_quality_scrap from u_dw within u_da_scrap_tabpg
end type
type st_7 from statictext within u_da_scrap_tabpg
end type
end forward

global type u_da_scrap_tabpg from u_tabpg
integer width = 2766
integer height = 1628
long backcolor = 65535
string text = "SCRAP"
long tabbackcolor = 65535
boolean ib_isupdateable = false
event ue_retrieve_wt ( )
cb_sample cb_sample
cb_nonconf cb_nonconf
cb_reset_scale cb_reset_scale
cb_reset_pcs cb_reset_pcs
em_offset em_offset
cb_retrieve cb_retrieve
cb_edit cb_edit
cb_new cb_new
cb_scrap_print cb_scrap_print
cb_save cb_save
cb_delete_item cb_delete_item
cb_pallet cb_pallet
cb_change_type cb_change_type
cb_read_scale cb_read_scale
dw_scrap dw_scrap
dw_current_quality_scrap dw_current_quality_scrap
st_7 st_7
end type
global u_da_scrap_tabpg u_da_scrap_tabpg

type variables
string is_title
w_da_sheet iw_sheet
long il_scrap_skid_num  //, al_sheet_skid_num
w_load_scrap_tare iw_load_scrap_tare
w_scrap_type iw_scrap_type
w_da_tabpg_scrap_edit iw_da_tabpg_scrap_edit
s_partial_skid istr_scrap_skid
u_coil iu_coil
int ii_scrap_type
int ii_pre_scrap_type
long il_edit_row
SQLPreviewType isql_criteria

n_tmg itmg_1_sec

string is_quality_scrap_worksheet_keys[] = {"COIL_ABC_NUM", "AB_JOB_NUM", "SCRAP_ITEM_TYPE", "SCRAP_ITEM_OD", "SCRAP_ITEM_MILL","SCRAP_SKID_NUM"}
string is_quality_scrap_worksheet_cols[] = {"COIL_ABC_NUM", "AB_JOB_NUM", "SCRAP_ITEM_TYPE", "SCRAP_ITEM_PIECE","SCRAP_ITEM_NET_WT","SCRAP_ITEM_NOTE","SCRAP_ITEM_OD", "SCRAP_ITEM_MILL","SCRAP_SKID_NUM"}

//string is_RETURN_SCRAP_ITEM_keys[] = {"return_scrap_item_return_scrap_item_num" }
//string is_RETURN_SCRAP_ITEM_cols[] = & 
//{"return_scrap_item_return_item_net_wt", "return_scrap_item_scrap_item_pieces","return_scrap_item_scrap_item_type", &
//"return_scrap_item_return_item_notes","return_scrap_item_od","return_scrap_item_mill",&
//"return_scrap_item_coil_abc_num","return_scrap_item_ab_job_num"}
//string is_SCRAP_SKID_DETAIL_keys[] ={"scrap_skid_detail_scrap_skid_num", "scrap_skid_detail_return_scrap_item_num"}
//string is_SCRAP_SKID_DETAIL_cols[] = &
//{"scrap_skid_detail_scrap_skid_num","scrap_skid_detail_return_scrap_item_num"}
//string is_SCRAP_SKID_keys[]={"scrap_skid_scrap_skid_num"}
//string is_SCRAP_SKID_cols[] = &
//{"scrap_skid_scrap_net_wt"}

end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
public subroutine of_add_scrap_item (integer ai_pcs, long al_wt, integer ai_type)
public subroutine of_add_current_scrap_pieces (integer ai_pcs)
public subroutine of_print_scrap_ticket (long al_skid_num, long al_net, long al_tare)
public subroutine of_change_scrap_type (integer ai_new_type)
public function integer of_delete_item (long al_item_num, long al_skid_num, long al_item_nw)
public function integer of_save ()
public function integer of_data_validation ()
public function integer of_update_scrap_skid_item ()
public function long of_read_scale ()
public function long of_get_scale_wt ()
end prototypes

event ue_retrieve_wt();////of_retrieve_skid_net_wt( )
long ll_read
ll_read = of_get_scale_wt( )

	if dw_current_quality_scrap.rowcount( ) = 1 then
		dw_current_quality_scrap.object.scrap_item_net_wt[1] = ll_read
	end if

itmg_1_sec.inv_single.of_unregister( )
end event

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
if isValid( iw_sheet.iu_current_coil ) then
	iu_coil = iw_sheet.iu_current_coil
end if
dw_scrap.of_retrieve( )
dw_scrap.inv_base.of_populatedddw( )
is_title = "Scrap item"
long ll_row
//dw_scrap.sharedata( dw_edit)
//ll_row = dw_scrap_type.insertrow( 0 )
//dw_scrap_type.object.id[ll_row] = 0
ii_pre_scrap_type = 0
ii_scrap_type = 0
ll_row = dw_current_quality_scrap.insertrow( 0 )
dw_current_quality_scrap.inv_base.of_populatedddw( )
dw_current_quality_scrap.object.scrap_item_type[ll_row] = 0
dw_current_quality_scrap.object.scrap_item_od[ll_row] = 1
dw_current_quality_scrap.object.scrap_item_mill[ll_row] = 1
dw_current_quality_scrap.object.scrap_item_piece[ll_row] = 0
dw_current_quality_scrap.object.scrap_item_net_wt[ll_row] = 0
cb_read_scale.enabled = iw_sheet.ib_scrap_scale_connected
cb_reset_scale.enabled = iw_sheet.ib_scrap_scale_connected
cb_retrieve.enabled = not iw_sheet.ib_scrap_scale_connected

end subroutine

public subroutine of_add_scrap_item (integer ai_pcs, long al_wt, integer ai_type);long ll_scrap_seq, ll_job, ll_coil,ll_rc, ll_cust_id,ll_shift_num, ll_i
int li_mill, li_od, li_scrap_type
string ls_alloy, ls_job, ls_temper, ls_note, ls_find, ls_scrap_type, ls_orig_cust_po

ll_coil = iu_coil.get_coil_abc_id( )
ll_job = iu_coil.get_current_job( )
ll_cust_id = iu_coil.of_get_customer_id( )
ls_alloy = iu_coil.of_get_alloy( )
ls_temper = iu_coil.of_get_temper( )
ls_job = string(ll_job)
ll_shift_num = iu_coil.of_get_shift_id( )
li_scrap_type = iu_coil.of_get_scrap_type( )
ls_orig_cust_po = iu_coil.of_get_orig_cust_po( )


if dw_current_quality_scrap.rowcount( ) = 1 then
	li_mill = dw_current_quality_scrap.object.scrap_item_mill[1]
	li_od = dw_current_quality_scrap.object.scrap_item_od[1]
	ls_note = dw_current_quality_scrap.object.scrap_item_note[1]
else
	li_mill = 0
	li_od = 0
	ls_note = ""
end if

if istr_scrap_skid.partial_skid_net_wt = 0 and istr_scrap_skid.partial_skid_status < 7 then
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
           :li_scrap_type,   
           null,   
           :ls_temper,   
           :al_wt,   
           :istr_scrap_skid.partial_skid_tare_wt,   
           :ls_orig_cust_po,   
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
				else
					sqlca.of_commit( )
				end if
end if //end if new scrap skid


//find in dw_scrap for matching items
ls_find = "ab_job_num=" + string(ll_job) + " and scrap_item_type=" + string(ai_type)+ " and scrap_item_od=" + string(li_od) + &
			" and scrap_item_mill=" + string(li_mill) + " and scrap_skid_num=" + string(istr_scrap_skid.partial_skid_num)
ll_rc = dw_scrap.find( ls_find ,1, dw_scrap.rowcount( ) )

	if ll_rc > 0 then
		//add
		dw_scrap.object.scrap_item_piece[ll_rc] = dw_scrap.object.scrap_item_piece[ll_rc] + ai_pcs
		dw_scrap.object.scrap_item_net_wt[ll_rc] = dw_scrap.object.scrap_item_net_wt[ll_rc] + al_wt
	else
		//insert
		ll_rc = dw_scrap.insertrow( 0 )
		dw_scrap.object.ab_job_num[ll_rc] = ll_job
		dw_scrap.object.scrap_item_type[ll_rc] = ai_type
		dw_scrap.object.scrap_item_piece[ll_rc] = ai_pcs
		dw_scrap.object.scrap_item_net_wt[ll_rc] = al_wt
		dw_scrap.object.scrap_item_od[ll_rc] = li_od
		dw_scrap.object.scrap_item_mill[ll_rc] = li_mill
		dw_scrap.object.scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num
		dw_scrap.object.scrap_item_note[ll_rc] = dw_current_quality_scrap.object.scrap_item_note[1]
		dw_scrap.object.coil_abc_num[ll_rc] = ll_coil
	end if

//Clear pcs wt and note
	dw_current_quality_scrap.object.scrap_item_net_wt[1] = 0
	dw_current_quality_scrap.object.scrap_item_note[1] = ""
	dw_current_quality_scrap.object.scrap_item_piece[1] = 0
	cb_reset_pcs.event clicked( )
//end of clear current scrap


	istr_scrap_skid.partial_skid_net_wt = istr_scrap_skid.partial_skid_net_wt + al_wt
	istr_scrap_skid.partial_skid_status = 7


	dw_scrap.setrow( ll_rc)
	dw_scrap.selectrow( 0, false)
	dw_scrap.selectrow( ll_rc, true)




//ll_coil = iu_coil.get_coil_abc_id( )
//ll_job = iu_coil.get_current_job( )
//ll_cust_id = iu_coil.of_get_customer_id( )
//ls_alloy = iu_coil.of_get_alloy( )
//ls_temper = iu_coil.of_get_temper( )
//ls_job = string(ll_job)
//ll_shift_num = iu_coil.of_get_shift_id( )
//


//if cbx_mill.checked then
//	li_mill = 1
//else
//	li_mill = 0
//end if
//
//if cbx_od.checked then
//	li_od = 1
//else
//	li_od = 1
//end if

//SELECT return_scrap_item_id_seq.NEXTVAL INTO :ll_scrap_seq FROM DUAL;
//  INSERT INTO "RETURN_SCRAP_ITEM"  
//         ( "RETURN_SCRAP_ITEM_NUM",   
//           "COIL_ABC_NUM",   
//           "AB_JOB_NUM",   
//           "RETURN_ITEM_NET_WT",   
//           "RETURN_ITEM_DATE",   
//           "RETURN_ITEM_NOTES",   
//           "SCRAP_ITEM_PIECES",   
//           "SCRAP_ITEM_TYPE",   
//           "MILL",
//			  "SHIFT_NUM",
//			  "OD")  
//  VALUES ( :ll_scrap_seq,   
//           :ll_coil,   
//           :ll_job,   
//           :al_wt,   
//           sysdate,   
//           :ls_note,   
//           :ai_pcs,   
//           :ai_type,   
//           :li_mill,
//			  :ll_shift_num,
//			  :li_od);
//	ll_rc = sqlca.sqlcode
//	if ll_rc <> 0 then
//		sqlca.of_rollback( )
//		MessageBox("Database error", "Error insert scrap item")
//		return
//	end if
////
//	if istr_scrap_skid.partial_skid_net_wt = 0 then
//		//add to new scrap skid
//		  INSERT INTO "SCRAP_SKID"  
//         ( "SCRAP_SKID_NUM",   
//           "CUSTOMER_ID",   
//           "SCRAP_TYPE",   
//           "SCRAP_ALLOY",   
//           "SCRAP_TEMPER",   
//           "SCRAP_NET_WT",   
//           "SCRAP_TARE_WT",   
//           "SCRAP_CUST_PO",   
//           "SCRAP_AB_JOB_NUM",   
//           "SCRAP_LOCATION",   
//           "SCRAP_DATE",   
//           "SKID_SCRAP_STATUS",   
//           "SCRAP_NOTES",   
//           "SCRAP_ALLOY2",   
//           "TOTE_NUM" )  
//  VALUES ( :istr_scrap_skid.partial_skid_num,   
//           :ll_cust_id,   
//           null,   
//           null,   
//           :ls_temper,   
//           :al_wt,   
//           :istr_scrap_skid.partial_skid_tare_wt,   
//           null,   
//           :ls_job,   
//           null,   
//           sysdate,   
//           1,   
//           :ls_note,   
//           :ls_alloy,   
//           null );
//				if ll_rc <> 0 then
//					sqlca.of_rollback( )
//					MessageBox("Database error", "Error insert scrap skid")
//					return
//				end if
//				
//			  INSERT INTO "SCRAP_SKID_DETAIL"  
//         	( "SCRAP_SKID_NUM", "RETURN_SCRAP_ITEM_NUM" )  
//  				VALUES ( :istr_scrap_skid.partial_skid_num,   
//           				:ll_scrap_seq )  ;
//				if ll_rc <> 0 then
//					sqlca.of_rollback( )
//					MessageBox("Database error", "Error insert scrap skid detail")
//					return
//				end if
//	else
//		//add to existing scrap skid
//		    INSERT INTO "SCRAP_SKID_DETAIL"  
//         ( "SCRAP_SKID_NUM",   
//           "RETURN_SCRAP_ITEM_NUM" )  
//  			VALUES ( :istr_scrap_skid.partial_skid_num,   
//           :ll_scrap_seq )  ;
//				if ll_rc <> 0 then
//					sqlca.of_rollback( )
//					MessageBox("Database error", "Error insert scrap skid detail")
//					return
//				end if
//			  UPDATE "SCRAP_SKID"  
//     				SET "SCRAP_NET_WT" = "SCRAP_NET_WT" + :al_wt 
//   				WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" = :istr_scrap_skid.partial_skid_num ;
//				if ll_rc <> 0 then
//					sqlca.of_rollback( )
//					MessageBox("Database error", "Error update scrap skid")
//					return
//				end if
//			
//		
//	end if
//	
//	sqlca.of_commit( )
//	
//	ll_rc = dw_scrap.insertrow( 0 )
//		
//	dw_scrap.object.return_scrap_item_return_item_net_wt[ll_rc] = al_wt
//	dw_scrap.object.compute_0015[ll_rc] = al_wt
//	dw_scrap.object.return_scrap_item_scrap_item_pieces[ll_rc] = ai_pcs
//	dw_scrap.object.return_scrap_item_return_item_notes[ll_rc] = ls_note
//	dw_scrap.object.return_scrap_item_return_scrap_item_num[ll_rc] = ll_scrap_seq
//	dw_scrap.object.return_scrap_item_coil_abc_num[ll_rc] = ll_coil
//	dw_scrap.object.return_scrap_item_ab_job_num[ll_rc] = ll_job
//	dw_scrap.object.return_scrap_item_scrap_item_type[ll_rc] = ai_type
//	dw_scrap.object.return_scrap_item_mill[ll_rc] = li_mill
//	dw_scrap.object.return_scrap_item_od[ll_rc] = li_od
//	
//	dw_scrap.setitem( ll_rc, "return_scrap_item_return_item_date", DateTime(Today(),Now()))
//	
//	dw_scrap.object.scrap_skid_detail_scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num
//	dw_scrap.object.scrap_skid_scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num 
//		
//	for ll_i=1 to ll_rc
//		if dw_scrap.object.scrap_skid_scrap_skid_num[ll_i] = istr_scrap_skid.partial_skid_num then
//			dw_scrap.object.scrap_skid_scrap_net_wt[ll_i] = istr_scrap_skid.partial_skid_net_wt + al_wt
//		end if
//	next
//	
//	
//	dw_scrap.object.scrap_skid_detail_return_scrap_item_num[ll_rc] = ll_scrap_seq
//	
//	istr_scrap_skid.partial_skid_net_wt = istr_scrap_skid.partial_skid_net_wt + al_wt
//	istr_scrap_skid.partial_skid_status = 7
//	
//	DWItemStatus ldw_status
//	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
//	dw_scrap.setitemstatus( ll_rc, 0, Primary!, NotModified!)
//	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
//	dw_scrap.setitemstatus( ll_rc, 0, Primary!, DataModified!)
//	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
//	dw_scrap.setitemstatus( ll_rc, 0, Primary!, NotModified!)
//	ldw_status = dw_scrap.getitemstatus( ll_Rc, 0, Primary!)
//	
//	dw_scrap.setrow( ll_rc)
//	dw_scrap.selectrow( 0, false)
//	dw_scrap.selectrow( ll_rc, true)
//	
//	
end subroutine

public subroutine of_add_current_scrap_pieces (integer ai_pcs);int li_pcs
//	li_pcs = Long(em_scrap_pcs.text)
//	em_scrap_pcs.text = string( li_pcs + ai_pcs )
if dw_current_quality_scrap.rowcount( ) = 1 then
	iu_coil.of_select_scrap_tabpg( )
	li_pcs = dw_current_quality_scrap.object.scrap_item_piece[1]
	dw_current_quality_scrap.object.scrap_item_piece[1] = li_pcs + ai_pcs
end if
	
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

if ii_scrap_type = ai_new_type then
	return
end if
ii_pre_scrap_type = ii_scrap_type
ii_scrap_type = ai_new_type
if ii_pre_scrap_type <> 0 then
	if	MessageBox("scrap type changed"   ,  &
		"Do you want to save scrap type ?", Question!, YesNo!   ) = 1 then //Saving scrap item
		if iw_sheet.ib_scrap_scale_connected then	
			cb_read_scale.event clicked( )
		end if
			
			li_pcs = dw_current_quality_scrap.object.scrap_item_piece[1] + Integer(em_offset.text)
			ll_wt = dw_current_quality_scrap.object.scrap_item_net_wt[1]
			if li_pcs < 1 or ll_wt < 0 then
				MessageBox("Can not add scrap item", "Invalid pcs " + string(li_pcs)+ " or weight "+ string(ll_wt) +"!", StopSign!)
				return
			end if
		
		if istr_scrap_skid.partial_skid_num < 1000  or istr_scrap_skid.partial_skid_net_wt > 9999 then
			MessageBox("Can not add scrap item", "Please select a valid scrap pallet", StopSign!)
			return
		end if
		
		of_add_scrap_item( li_pcs , ll_wt , ii_scrap_type  )
		if iw_sheet.ib_scrap_scale_connected then
			iw_sheet.wf_zero_scale( )
		end if
	end if //end of save scrap item
end if
//	dw_current_quality_scrap.object.scrap_item_type[1] = ii_scrap_type
	
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

public function integer of_save ();long ll_rc

if dw_scrap.of_updatespending( ) <> 1 then
	return 0
end if

//Update function
dw_scrap.inv_multitable.of_unregister( )
ll_rc = dw_scrap.inv_multitable.of_register( "quality_scrap_worksheet",  is_quality_scrap_worksheet_keys, is_quality_scrap_worksheet_cols, false, 0 )
if ll_rc <> 1 then
	Messagebox("register", "return_scrap_item register failed")
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

public function integer of_data_validation ();return 0
end function

public function integer of_update_scrap_skid_item ();//long ll_row, ll_i, ll_j, ll_skid_id, ll_skid_count
int li_rc
long ll_coil, ll_shift_num
//string ls_find
if of_save( ) <> 0 then
	MessageBox("DB error", "Can not save scrap item!" )
	return 1
end if

ll_coil = iu_coil.get_coil_abc_id( )
ll_shift_num = iu_coil.of_get_shift_id( )

sqlca.update_scrap_skid_from_quality( ll_coil, ll_shift_num)
if sqlca.sqlcode <> 0 then
	messageBox("Error", sqlca.sqlerrtext )
end if
return sqlca.sqlcode //return 0 if all ok


//ll_row = dw_scrap.rowcount( )
//
//if ll_row < 1 then
//	return 0
//end if
//
//li_rc = dw_scrap.setsort( "scrap_skid_num a")
//if li_rc <> 1 then
//	Messagebox("Error", "Error setsort")
//	return 1
//end if
//li_rc = dw_scrap.sort( )
//
//if li_rc <> 1 then
//	Messagebox("Error", "Error sort")
//	return 1
//end if
//
//ll_skid_id = dw_scrap.object.scrap_skid_num[1]
//ls_find = "scrap_skid_num<>" + string(ll_skid_id)
//
//long ll_find = 1, ll_end
//long ll_all_skid_id[]
//ll_end = dw_scrap.RowCount()
//ll_j = 1
//ll_all_skid_id[ll_j] = ll_skid_id
//ll_find = dw_scrap.Find(ls_find , ll_find, ll_end)
//DO WHILE ll_find > 0
//        // Collect found row
//        //ll_skid_end = ll_find - 1
//		  ll_j++
//		  ll_skid_id = dw_scrap.object.scrap_skid_num[ll_find]
//		  ll_all_skid_id[ll_j] = ll_skid_id
//		  ls_find = "scrap_skid_num<>" + string(ll_skid_id)
//		  ll_find++
//        // Prevent endless loop
//        IF ll_find > ll_end THEN EXIT
//        ll_find = dw_scrap.Find(ls_find, ll_find, ll_end)
//LOOP
//
//
//ll_skid_count = ll_j
//
//
//for ll_i=1 to ll_skid_count
//	// Update scrap_skid, scrap_skid_detail, scrap_item table
//next
//
//



end function

public function long of_read_scale ();long ll_rc
//li_rc = SioKeycode(0)
String ls_put, ls_get//, ls_msg
ls_put = "HELLO"
//ls_get = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
//ls_get = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
//ls_msg =                                                                                                    "                                                           "

if not iw_sheet.ib_scrap_scale_connected then
	return -1
end if

string(SioKeycode(WSC_KEY_CODE))
ll_rc = SioReset( iw_sheet.ii_com_port,512, 512)
	if ll_rc < 0 then
		SioWinError(ls_get,128)
		MessageBox("System error", "Can not open serial port! " + ls_get)
		return -1
	end if
	SioParms(iw_sheet.ii_com_port, WSC_NoParity, WSC_OneStopBit, WSC_WordLength8)
	SioBaud( iw_sheet.ii_com_port,WSC_Baud9600)
SioPutc( iw_sheet.ii_com_port, 'b') //'a' for ZERO, 'b' for Print
//sleep(1) //wait for data coming back

if not isValid(itmg_1_sec) then 
	itmg_1_sec = create n_tmg
	itmg_1_sec.of_setsingle( true)
end if
	itmg_1_sec.inv_single.of_register( this, "ue_retrieve_wt", 1)

return -1

//SioGets( iw_sheet.ii_com_port,ls_get, 128)
////MessageBox("back", ls_get)
//ls_get = Trim(Mid(ls_get, 3, 9)) //Trim non numaric char
////MessageBox("back", ls_get)
//if isNumber(ls_get)  then
//	ll_rc = Long( ls_get )
//else
//	ll_rc = 0
//end if
//
//SioDone(iw_sheet.ii_com_port)
//return ll_rc

end function

public function long of_get_scale_wt ();long ll_rc
String ls_get
int li_start, li_end
ls_get = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"

SioGets( iw_sheet.ii_com_port,ls_get, 128)
//MessageBox("back", ls_get)
//ls_get = Trim(Mid(ls_get, 3, 9)) //Trim non numaric char
//MessageBox("back", ls_get)
ls_get = Upper(ls_get)


FOR li_start = 1 TO Len(ls_get)
	IF isNumber(Mid(ls_get, li_start, 1)) THEN
		EXIT
	END IF
NEXT

FOR li_end = li_start TO Len(ls_get)
	IF Not(isNumber(Mid(ls_get, li_end, 1)))  THEN
		EXIT
	END IF
NEXT
ls_get = Trim(Mid(ls_get, li_start, (li_end - li_start))) //Trim non numaric char



if isNumber(ls_get)  then
	ll_rc = Long( ls_get )
else
	ll_rc = 0
end if

SioDone(iw_sheet.ii_com_port)
return ll_rc
end function

on u_da_scrap_tabpg.create
int iCurrent
call super::create
this.cb_sample=create cb_sample
this.cb_nonconf=create cb_nonconf
this.cb_reset_scale=create cb_reset_scale
this.cb_reset_pcs=create cb_reset_pcs
this.em_offset=create em_offset
this.cb_retrieve=create cb_retrieve
this.cb_edit=create cb_edit
this.cb_new=create cb_new
this.cb_scrap_print=create cb_scrap_print
this.cb_save=create cb_save
this.cb_delete_item=create cb_delete_item
this.cb_pallet=create cb_pallet
this.cb_change_type=create cb_change_type
this.cb_read_scale=create cb_read_scale
this.dw_scrap=create dw_scrap
this.dw_current_quality_scrap=create dw_current_quality_scrap
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_sample
this.Control[iCurrent+2]=this.cb_nonconf
this.Control[iCurrent+3]=this.cb_reset_scale
this.Control[iCurrent+4]=this.cb_reset_pcs
this.Control[iCurrent+5]=this.em_offset
this.Control[iCurrent+6]=this.cb_retrieve
this.Control[iCurrent+7]=this.cb_edit
this.Control[iCurrent+8]=this.cb_new
this.Control[iCurrent+9]=this.cb_scrap_print
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.cb_delete_item
this.Control[iCurrent+12]=this.cb_pallet
this.Control[iCurrent+13]=this.cb_change_type
this.Control[iCurrent+14]=this.cb_read_scale
this.Control[iCurrent+15]=this.dw_scrap
this.Control[iCurrent+16]=this.dw_current_quality_scrap
this.Control[iCurrent+17]=this.st_7
end on

on u_da_scrap_tabpg.destroy
call super::destroy
destroy(this.cb_sample)
destroy(this.cb_nonconf)
destroy(this.cb_reset_scale)
destroy(this.cb_reset_pcs)
destroy(this.em_offset)
destroy(this.cb_retrieve)
destroy(this.cb_edit)
destroy(this.cb_new)
destroy(this.cb_scrap_print)
destroy(this.cb_save)
destroy(this.cb_delete_item)
destroy(this.cb_pallet)
destroy(this.cb_change_type)
destroy(this.cb_read_scale)
destroy(this.dw_scrap)
destroy(this.dw_current_quality_scrap)
destroy(this.st_7)
end on

event destructor;call super::destructor;//if isValid( iw_tare ) then
//	Close(iw_tare)
//end if
//
//if isValid(iw_load_partial) then
//	Close( iw_load_partial )
//end if
//
if isValid(iw_load_scrap_tare) then
	Close( iw_load_scrap_tare )
end if

if isValid(iw_scrap_type) then
	Close( iw_scrap_type )
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
istr_scrap_skid.partial_skid_net_wt = 0
istr_scrap_skid.partial_skid_num = 0
//istr_scrap_skid
end event

type cb_sample from u_cb within u_da_scrap_tabpg
integer x = 1262
integer y = 1504
integer width = 329
integer height = 112
integer taborder = 140
integer textsize = -10
string facename = "Arial"
string text = "Sample"
end type

event clicked;call super::clicked;int li_rc, li_i, li_pcs, li_mr
long ll_wt, ll_item_nw, ll_skid_num
dw_scrap.accepttext( )
li_rc = dw_scrap.rowcount( )
if  li_rc < 1 then return 1
ll_wt = 0
li_pcs = 0
for li_i=1 to li_rc
	if dw_scrap.object.scrap_item_type[li_i] = 45 then
		ll_wt= ll_wt + dw_scrap.object.scrap_item_net_wt[li_i]
		li_pcs = li_pcs + dw_scrap.object.scrap_item_piece[li_i]
	end if
next

if ll_wt = 0 or li_pcs = 0 then
	messagebox("item not found","Sample item not found!")
	return 1
else
	//call skid tabpage add nonconfirming skid
	li_mr = this.of_messagebox( "Sample", "Sample skid", "This will transfer sample scrap item to skid. Continue?", Question!, YesNoCancel!, 1)
	if li_mr = 1 then
		iu_coil.of_get_skid_tab_page( ).of_add_nonconfirming( li_pcs , ll_wt , 12 )
		//delete row
		
		li_rc = dw_scrap.find( "scrap_item_type=45", 1, dw_scrap.rowcount( ) )
		do while li_rc > 0
			ll_item_nw = dw_scrap.object.scrap_item_net_wt[li_rc]
			ll_skid_num = dw_scrap.object.scrap_skid_num[li_rc]
			if istr_scrap_skid.partial_skid_num = ll_skid_num then
				istr_scrap_skid.partial_skid_net_wt = istr_scrap_skid.partial_skid_net_wt - ll_item_nw
			end if
			dw_scrap.deleterow( li_rc )
			li_rc = dw_scrap.find( "scrap_item_type=45", 1, dw_scrap.rowcount( ) )
		loop

		
		
//		for li_i=1 to li_rc
//			if dw_scrap.object.scrap_item_type[li_i] = 50 then
//				ll_nw = dw_scrap.object.scrap_item_net_wt[li_i]
//				ll_skid_id = dw_scrap.object.scrap_skid_num[li_i]
//				
//				
//				
//			end if
//		next
	else
		return 1
	end if
end if

 
end event

type cb_nonconf from u_cb within u_da_scrap_tabpg
integer x = 786
integer y = 1504
integer width = 421
integer height = 112
integer taborder = 130
integer textsize = -10
string facename = "Arial"
string text = "NonConformin~'"
end type

event clicked;call super::clicked;int li_rc, li_i, li_pcs, li_mr
long ll_wt, ll_item_nw, ll_skid_num
dw_scrap.accepttext( )
li_rc = dw_scrap.rowcount( )
if  li_rc < 1 then return 1
ll_wt = 0
li_pcs = 0
for li_i=1 to li_rc
	if dw_scrap.object.scrap_item_type[li_i] = 50 then
		ll_wt= ll_wt + dw_scrap.object.scrap_item_net_wt[li_i]
		li_pcs = li_pcs + dw_scrap.object.scrap_item_piece[li_i]
	end if
next

if ll_wt = 0 or li_pcs = 0 then
	messagebox("item not found","Nonconfirming item not found!")
	return 1
else
	//call skid tabpage add nonconfirming skid
	li_mr = this.of_messagebox( "NonConfirming", "NonConfirming skid", "This will transfer nonconfirming scrap item to skid. Continue?", Question!, YesNoCancel!, 1)
	if li_mr = 1 then
		iu_coil.of_get_skid_tab_page( ).of_add_nonconfirming( li_pcs , ll_wt , 11 )
		//delete row
		
		li_rc = dw_scrap.find( "scrap_item_type=50", 1, dw_scrap.rowcount( ) )
		do while li_rc > 0
			ll_item_nw = dw_scrap.object.scrap_item_net_wt[li_rc]
			ll_skid_num = dw_scrap.object.scrap_skid_num[li_rc]
			if istr_scrap_skid.partial_skid_num = ll_skid_num then
				istr_scrap_skid.partial_skid_net_wt = istr_scrap_skid.partial_skid_net_wt - ll_item_nw
			end if
			dw_scrap.deleterow( li_rc )
			li_rc = dw_scrap.find( "scrap_item_type=50", 1, dw_scrap.rowcount( ) )
		loop

		
		
//		for li_i=1 to li_rc
//			if dw_scrap.object.scrap_item_type[li_i] = 50 then
//				ll_nw = dw_scrap.object.scrap_item_net_wt[li_i]
//				ll_skid_id = dw_scrap.object.scrap_skid_num[li_i]
//				
//				
//				
//			end if
//		next
	else
		return 1
	end if
end if

 
end event

type cb_reset_scale from commandbutton within u_da_scrap_tabpg
integer x = 777
integer y = 1228
integer width = 206
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zero"
end type

event clicked;long ll_wt
if iw_sheet.ib_scrap_scale_connected then
	iw_sheet.wf_zero_scale( )
	sleep(1)
	ll_wt = iw_sheet.wf_read_scale( )
else
	ll_wt = 0
end if
if dw_current_quality_scrap.rowcount( ) = 1 then
	dw_current_quality_scrap.object.scrap_item_net_wt[1] = ll_wt
end if
end event

type cb_reset_pcs from commandbutton within u_da_scrap_tabpg
boolean visible = false
integer x = 1929
integer y = 1228
integer width = 206
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset"
end type

event clicked;//dw_current_quality_scrap.object.scrap_item_piece[1] = 0
em_offset.text = "0"
end event

type em_offset from editmask within u_da_scrap_tabpg
integer x = 1737
integer y = 1228
integer width = 197
integer height = 84
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "-99~~99"
end type

type cb_retrieve from u_cb within u_da_scrap_tabpg
boolean visible = false
integer x = 1481
integer y = 1152
integer width = 219
integer height = 96
integer taborder = 120
integer textsize = -11
string facename = "Arial"
boolean enabled = false
string text = "Retrieve"
end type

event clicked;call super::clicked;dw_scrap.of_retrieve( )
end event

type cb_edit from u_cb within u_da_scrap_tabpg
integer x = 402
integer y = 1504
integer width = 329
integer height = 112
integer taborder = 120
integer textsize = -10
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

type cb_new from u_cb within u_da_scrap_tabpg
integer x = 18
integer y = 1504
integer width = 329
integer height = 112
integer taborder = 200
integer textsize = -10
string facename = "Arial"
string text = "Add"
end type

event clicked;call super::clicked;Int li_pcs, li_type
long ll_wt, ll_offset
if istr_scrap_skid.partial_skid_num < 1000 then
	MessageBox("Warning", "Please select pallet first", StopSign!)
	return 1
end if
dw_current_quality_scrap.accepttext( )

ll_offset = Long(em_offset.text)
//messagebox("",string(dw_current_quality_scrap.rowcount( )))
if dw_current_quality_scrap.rowcount( ) = 1 then
	li_pcs = dw_current_quality_scrap.object.scrap_item_piece[1]
	li_pcs = li_pcs + ll_offset
else
	
	li_pcs = 0
end if

//ll_wt = Long( em_scrap_wt.text )

ll_wt = dw_current_quality_scrap.object.scrap_item_net_wt[1]
//messagebox(string(li_pcs),string(ll_wt))
if li_pcs < 1 or ll_wt < 0 or li_pcs > 999 or ll_wt > 9000 or isNull(li_pcs) or isNull(ll_wt)  then
	MessageBox("Can not add scrap item", "Invalid pcs "+string(li_pcs) +" or weight " + string(ll_wt) + " !", StopSign!)
	return 0
end if
// Scrap skid weight not more then 8999 LB.
if istr_scrap_skid.partial_skid_num < 1000  or istr_scrap_skid.partial_skid_net_wt > 9999 then
	MessageBox("Can not add scrap item", "Please select a valid scrap pallet", StopSign!)
	return 0
end if

li_type =  dw_current_quality_scrap.object.scrap_item_type[1]

of_add_scrap_item( li_pcs , ll_wt , li_type  )
//		dw_current_quality_scrap.object.scrap_item_net_wt[1] = 0
//		dw_current_quality_scrap.object.scrap_item_note[1] = ""
//		cb_reset_pcs.event clicked( )
if iw_sheet.ib_scrap_scale_connected then
		iw_sheet.wf_zero_scale( )
end if
end event

type cb_scrap_print from commandbutton within u_da_scrap_tabpg
integer x = 1646
integer y = 1504
integer width = 329
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
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
	ll_skid_num = dw_scrap.object.SCRAP_SKID_NUM[ ll_row ]
	//ll_net = dw_scrap.object.sheet_skid_sheet_net_wt[ ll_row ]
	//ll_tare = dw_scrap.object.sheet_skid_sheet_tare_wt[ ll_row ]
	//ll_pcs = dw_skid_item.object.sheet_skid_skid_pieces[ ll_row ]
	
	if of_update_scrap_skid_item( ) <> 0 then
		MessageBox("DB Error", "Can not update scrap skid!")
		return 1
	end if
	
	  SELECT "SCRAP_SKID"."SCRAP_NET_WT",   
         "SCRAP_SKID"."SCRAP_TARE_WT"  
    INTO :ll_net,   
         :ll_tare  
    FROM "SCRAP_SKID"  
   WHERE "SCRAP_SKID"."SCRAP_SKID_NUM" = :ll_skid_num   ;

	if sqlca.sqlcode <> 0 then
		MessageBox("DB error", "Can not retrieve scrap skid data!")
		return 1
	end if
	
	if ll_skid_num > 10000 then
		of_print_scrap_ticket( ll_skid_num, ll_net, ll_tare )
	end if
else
	MessageBox("Printing scrap ticket", "Please select a scrap pallet!")
end if

end event

type cb_save from commandbutton within u_da_scrap_tabpg
integer x = 2414
integer y = 1504
integer width = 329
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;of_save( )

end event

type cb_delete_item from commandbutton within u_da_scrap_tabpg
integer x = 2030
integer y = 1504
integer width = 329
integer height = 112
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;//Delete function
long row, ll_item_num, ll_skid_num, ll_item_nw,ll_i,ll_rc
		  row = dw_scrap.getselectedrow( 0 )
			if row < 1 then
				MessageBox("Delete item", "No item selected!")
				return 1
			end if
			
			if MessageBox("Delete item", "Do you want to delete selected item?", Exclamation!, OKCancel!, 2) = 2 then
				return 0
			end if
		ll_item_nw = dw_scrap.object.scrap_item_net_wt[row]
		ll_skid_num = dw_scrap.object.scrap_skid_num[row]
		if istr_scrap_skid.partial_skid_num = ll_skid_num then
			istr_scrap_skid.partial_skid_net_wt = istr_scrap_skid.partial_skid_net_wt - ll_item_nw
		end if
		dw_scrap.deleterow( row )
		
		
//		ll_item_num = dw_scrap.object.return_scrap_item_return_scrap_item_num[row]
//		ll_skid_num = dw_scrap.object.scrap_skid_detail_scrap_skid_num[row]
//		ll_item_nw = dw_scrap.object.return_scrap_item_return_item_net_wt[row]
//		if of_delete_item( ll_item_num, ll_skid_num, ll_item_nw) = 0 then
//			dw_scrap.deleterow( row )
//			ll_rc = dw_scrap.rowcount( )
//			for ll_i=1 to ll_rc
//				if dw_scrap.object.scrap_skid_scrap_skid_num[ll_i] = ll_skid_num then
//					dw_scrap.object.scrap_skid_scrap_net_wt[ll_i] = dw_scrap.object.scrap_skid_scrap_net_wt[ll_i] - ll_item_nw
//				end if
//			next
//		end if

end event

type cb_pallet from u_cb within u_da_scrap_tabpg
integer x = 645
integer y = 1400
integer width = 434
integer height = 84
integer taborder = 210
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
string text = "Change Skid"
end type

event clicked;call super::clicked;s_partial_skid lstr_scrap_skid
string ls_alloy
long ll_cust_id, ll_rc
if not isValid( iw_load_scrap_tare ) then
	ll_cust_id = iu_coil.of_get_customer_id( )
//	message.doubleparm = 55
//	message.longparm = 55
//	message.wordparm = 55
	ls_alloy = iu_coil.of_get_alloy( )
	gl_message = ll_cust_id
	ll_rc = OpenWithParm( iw_load_scrap_tare, ls_alloy )
	//MessageBox("Rc", string(ll_rc))
	
	lstr_scrap_skid = message.powerobjectparm
	if lstr_scrap_skid.partial_skid_num > 1000 then
		
		if istr_scrap_skid.partial_skid_num >1000 and istr_scrap_skid.partial_skid_num <> lstr_scrap_skid.partial_skid_num then
			//scrap skid changed
//			if	MessageBox("scrap skid changed"   ,  &
//			"Do you want to save scrap type ?", Question!, YesNo!   ) = 1 then //Saving scrap item
//				cb_new.event clicked( )
//			end if
			MessageBox("Change Scrap Skid", "Scrap Skid New ticker #" + string(lstr_scrap_skid.partial_skid_num)+".")
		end if
		
		istr_scrap_skid = lstr_scrap_skid
		dw_current_quality_scrap.object.scrap_skid_num[1] = istr_scrap_skid.partial_skid_num
		

	else
		dw_current_quality_scrap.object.scrap_skid_num[1] = 0
	end if
end if
end event

type cb_change_type from commandbutton within u_da_scrap_tabpg
integer x = 2304
integer y = 1400
integer width = 411
integer height = 84
integer taborder = 190
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change Code"
end type

event clicked;OpenWithParm( iw_scrap_type, parent )
//Int li_type
//if dw_scrap_type.rowcount( ) = 1 then
//	OpenWithParm( iw_scrap_type, parent )
//else
//	MessageBox("Error", "Scrap type error!")
//	return 1
//end if

end event

type cb_read_scale from commandbutton within u_da_scrap_tabpg
integer x = 530
integer y = 1228
integer width = 238
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scale"
end type

event clicked;long ll_read
if iw_sheet.ib_scrap_scale_connected then
	//ll_read = iw_sheet.wf_read_scale( )
	
	parent.of_read_scale( )
	
//	if dw_current_quality_scrap.rowcount( ) = 1 then
//		dw_current_quality_scrap.object.scrap_item_net_wt[1] = ll_read
//	end if
end if

//MessageBox("test", String(Integer(em_scrap_wt.text)))
end event

type dw_scrap from u_dw within u_da_scrap_tabpg
integer x = 9
integer y = 16
integer width = 2738
integer height = 1148
integer taborder = 150
string dataobject = "d_quality_scrap_work_sheet"
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;//return this.retrieve( il_coil_num, il_job_num )
long ll_coil
//ll_job = iu_coil.get_current_job( )
ll_coil = iu_coil.get_coil_abc_id( )
return this.retrieve(ll_coil)
end event

event constructor;call super::constructor;long ll_rc
//string ls_tem[], ls_tem2[], ls_tem3[], ls_keys[]
//this.of_SetDropDownCalculator(TRUE)
//this.iuo_calculator.of_Register("return_scrap_item_return_item_net_wt", &
//this.iuo_calculator.NONE)
//this.iuo_calculator.of_Register("return_scrap_item_scrap_item_pieces", &
//this.iuo_calculator.NONE)
//
//this.iuo_calculator.of_SetCloseOnClick(True)
//this.iuo_calculator.of_SetInitialValue(TRUE)
this.of_setbase( true)
this.of_settransobject( sqlca)
this.of_setmultitable( true)
//this.inv_multitable.of_getregisterable( ls_tem )
//this.inv_multitable.of_getregisterabletable( ls_tem3)
//this.inv_multitable.of_getregisterablecolumn( "return_scrap_item",ls_tem2  )
//this.inv_multitable.of_getregisterablecolumn( "scrap_skid",ls_tem2  )
//this.inv_multitable.of_getregisterablecolumn( "scrap_skid_detail",ls_tem2  )

//ll_rc = this.inv_multitable.of_register( "quality_scrap_worksheet", is_quality_scrap_worksheet_keys , is_quality_scrap_worksheet_cols, false, 0 )
//if ll_rc <> 1 then
//	MessageBox("dw_skid_item", "register failed")
//	return 0
//end if
//ll_rc = this.inv_multitable.of_register( "scrap_skid", is_scrap_skid_keys, is_scrap_skid_cols, false,0 )
//if ll_rc <> 1 then
//	MessageBox("dw_skid_item", "register failed")
//	return 0
//end if
//ls_keys = {"scrap_skid_detail_scrap_skid_num", "scrap_skid_detail_return_scrap_item_num"}
//ll_rc = this.inv_multitable.of_register( "scrap_skid_detail", is_scrap_skid_detail_keys, is_scrap_skid_detail_cols,false,0 )
//if ll_rc <> 1 then
//	MessageBox("dw_skid_item", "register failed")
//	return 0
//end if

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF as_colname = "scrap_item_type" THEN
	adwc_obj.SetTransObject(SQLCA)
	Return adwc_obj.Retrieve()
ELSE
	Return 0
END IF


//return 0


//
end event

event itemchanged;call super::itemchanged;//long ll_item_num, ll_item_nw, ll_diff, ll_scrap_skid_wt, ll_scrap_skid_id, ll_i, ll_rc
//if dwo.Name = "return_scrap_item_return_item_net_wt" then
//	ll_item_nw = Long( data )
//	ll_diff = ll_item_nw - this.object.compute_0015[row]
//	ll_scrap_skid_wt = &
//	this.object.scrap_skid_scrap_net_wt[row] + ll_diff
//	ll_scrap_skid_id = this.object.scrap_skid_scrap_skid_num[row]
//	ll_rc = this.rowcount( )
//	
//	for ll_i=1 to ll_rc
//		if this.object.scrap_skid_scrap_skid_num[ll_i] = ll_scrap_skid_id then
//			this.object.scrap_skid_scrap_net_wt[ll_i] = ll_scrap_skid_wt
//		end if
//	next
//	if istr_scrap_skid.partial_skid_num = ll_scrap_skid_id then
//		istr_scrap_skid.partial_skid_net_wt = ll_scrap_skid_wt
//	end if
//	this.object.compute_0015[row] = ll_item_nw
//end if
//return 0
end event

event clicked;call super::clicked;this.accepttext( )
//if row > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num " then
//	this.selectrow( 0, false)
//	this.selectrow( row, true)
//	dw_scrap.setrow( row)
//end if
//
end event

event sqlpreview;call super::sqlpreview;//if sqltype <> PreviewSelect!	then
//	if sqltype <> isql_criteria then
//		return 2
//	end if
//end if
end event

event losefocus;call super::losefocus;this.accepttext( )
end event

event doubleclicked;call super::doubleclicked;if row > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num" then
		il_edit_row = row
		openwithparm(iw_da_tabpg_scrap_edit, parent ) 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num " then
	this.selectrow( 0, false)
	this.selectrow( currentrow, true)
//	dw_scrap.setrow( row)
end if
end event

type dw_current_quality_scrap from u_dw within u_da_scrap_tabpg
integer x = 14
integer y = 1216
integer width = 2720
integer height = 272
integer taborder = 100
string dataobject = "d_current_scrap_work_sheet"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_populatedddw;call super::pfc_populatedddw;IF as_colname = "scrap_item_type" THEN
	adwc_obj.SetTransObject(SQLCA)
	Return adwc_obj.Retrieve()
ELSE
	Return 0
END IF


end event

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_register("scrap_item_net_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("scrap_item_piece", this.iuo_calculator.none )
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
this.of_setbase( true)
this.of_settransobject( sqlca)
//this.inv_base.of_populatedddw( )
end event

event itemchanged;call super::itemchanged;int li_scrap_type
if dwo.Name = "scrap_item_type" then
	li_scrap_type = Integer( data )
//	parent.of_change_scrap_type( li_scrap_type )
	ii_pre_scrap_type = ii_scrap_type
	ii_scrap_type = li_scrap_type
end if
return 0
end event

type st_7 from statictext within u_da_scrap_tabpg
integer x = 14
integer y = 1160
integer width = 370
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Current Scrap:"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

