$PBExportHeader$u_da_skid_tabpg.sru
forward
global type u_da_skid_tabpg from u_tabpg
end type
type cb_quality from u_cb within u_da_skid_tabpg
end type
type dw_nonconf from u_dw within u_da_skid_tabpg
end type
type cb_1 from commandbutton within u_da_skid_tabpg
end type
type cb_restack from u_cb within u_da_skid_tabpg
end type
type st_stacker from statictext within u_da_skid_tabpg
end type
type st_3 from statictext within u_da_skid_tabpg
end type
type cb_reset_pcs from commandbutton within u_da_skid_tabpg
end type
type st_offset from statictext within u_da_skid_tabpg
end type
type em_offset from editmask within u_da_skid_tabpg
end type
type cb_retrieve from u_cb within u_da_skid_tabpg
end type
type cb_ref from u_cb within u_da_skid_tabpg
end type
type cb_edit from u_cb within u_da_skid_tabpg
end type
type cb_delete from u_cb within u_da_skid_tabpg
end type
type cb_print from u_cb within u_da_skid_tabpg
end type
type cb_done_skid from u_cb within u_da_skid_tabpg
end type
type cb_load_partial from u_cb within u_da_skid_tabpg
end type
type cb_new_skid from u_cb within u_da_skid_tabpg
end type
type st_1 from statictext within u_da_skid_tabpg
end type
type dw_current_edit from u_dw within u_da_skid_tabpg
end type
type dw_skid_item from u_dw within u_da_skid_tabpg
end type
type cb_dim_check from commandbutton within u_da_skid_tabpg
end type
type st_2 from statictext within u_da_skid_tabpg
end type
end forward

global type u_da_skid_tabpg from u_tabpg
integer width = 2766
integer height = 1624
long backcolor = 12639424
string text = "GOOD SKID"
long tabbackcolor = 12639424
boolean ib_isupdateable = false
event ue_retrieve_wt ( )
event ue_stack_leaving_conv1 ( )
cb_quality cb_quality
dw_nonconf dw_nonconf
cb_1 cb_1
cb_restack cb_restack
st_stacker st_stacker
st_3 st_3
cb_reset_pcs cb_reset_pcs
st_offset st_offset
em_offset em_offset
cb_retrieve cb_retrieve
cb_ref cb_ref
cb_edit cb_edit
cb_delete cb_delete
cb_print cb_print
cb_done_skid cb_done_skid
cb_load_partial cb_load_partial
cb_new_skid cb_new_skid
st_1 st_1
dw_current_edit dw_current_edit
dw_skid_item dw_skid_item
cb_dim_check cb_dim_check
st_2 st_2
end type
global u_da_skid_tabpg u_da_skid_tabpg

type variables
string is_title
w_da_sheet iw_sheet
//long il_coil_num, il_job_num
long il_scrap_skid_num  //, al_sheet_skid_num
w_tare iw_tare
w_load_partial iw_load_partial
w_restack_bl110 iw_restack_bl110
//w_load_scrap_tare iw_load_scrap_tare
//w_scrap_type iw_scrap_type
//w_dimensional_check iw_dimensional_check
//w_dimensional_check_new_skid iw_dimensional_check_new_skid
s_partial_skid istr_scrap_skid
u_coil iu_coil
//n_ds ids_dim_check
//string is_scrap_defect
//string is_pre_scrap_defect
int ii_scrap_type
int ii_pre_scrap_type
w_da_tabpg_skid_edit iw_da_tabpg_skid_edit
w_da_tabpg_skid_quality iw_da_tabpg_skid_quality

SQLPreviewType isql_criteria

string is_PRODUCTION_SHEET_ITEM_keys[] = {"production_sheet_item_prod_item_num" }
string is_PRODUCTION_SHEET_ITEM_cols[] = & 
{"production_sheet_item_prod_item_pieces", "production_sheet_item_prod_item_net_wt","production_sheet_item_prod_item_num", &
"production_sheet_item_prod_item_theoretical_wt","production_sheet_item_prod_item_status"}
string is_SHEET_SKID_DETAIL_keys[] ={"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
string is_SHEET_SKID_DETAIL_cols[] = &
{"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
string is_SHEET_SKID_keys[]={"sheet_skid_sheet_skid_num"}
string is_SHEET_SKID_cols[] = &
{"sheet_skid_sheet_tare_wt","sheet_skid_sheet_net_wt","sheet_skid_skid_pieces", "sheet_skid_sheet_theoretical_wt","sheet_skid_skid_sheet_status"}


long il_current_row, il_edit_row
int ii_working_stacker

n_tmg itmg_2_sec


//  DECLARE icur_prod_item CURSOR FOR  
//  SELECT "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM",   
//         "PRODUCTION_SHEET_ITEM"."COIL_ABC_NUM",   
//         "PRODUCTION_SHEET_ITEM"."AB_JOB_NUM",   
//         "PRODUCTION_SHEET_ITEM"."PROD_ITEM_PIECES",   
//         "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NET_WT"  
//    FROM "PRODUCTION_SHEET_ITEM",   
//         "SHEET_SKID_DETAIL"  
//   WHERE ( "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" = "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" ) and  
//         ( ( "SHEET_SKID_DETAIL"."SHEET_SKID_NUM" = :al_sheet_skid_num )   
//         )   ;

end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
public subroutine of_add_current_skid_pieces (integer ai_pcs)
public subroutine of_print_scrap_ticket (long al_skid_num, long al_net, long al_tare)
public function integer of_save_current_skid_new (long al_pcs, long al_skid_id, long al_tare, long al_item_id, integer ai_status)
public function integer of_save_current_skid_partial (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt)
public function integer of_save_current_skid_partial_single_item (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt, long al_init_item_pcs)
public function integer of_delete_rows ()
public function integer of_save ()
public function integer of_data_validation (long al_row)
public function integer of_retrieve_skid_net_wt ()
public function integer of_stacker_new_skid (integer ai_stacker)
public function integer of_stacker_complete (integer ai_stacker)
public subroutine of_stacker1_count (integer ai_count)
public subroutine of_stacker2_count (integer ai_count)
public subroutine of_print_skid_ticket (long al_skid_num, long al_net, long al_tare, long al_job)
public function integer of_set_theo_2_partial_at_coil_end ()
public function integer of_add_nonconfirming (integer ai_pcs, long al_wt, integer ai_status)
end prototypes

event ue_retrieve_wt();//messagebox("","")
of_retrieve_skid_net_wt( )
itmg_2_sec.inv_single.of_unregister( )
//destroy itmg_2_sec
end event

event ue_stack_leaving_conv1();if not isValid(itmg_2_sec) then 
	itmg_2_sec = create n_tmg
	itmg_2_sec.of_setsingle( true)
end if
	itmg_2_sec.inv_single.of_register( this, "ue_retrieve_wt", 3)
end event

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
if isValid( iw_sheet.iu_current_coil ) then
	iu_coil = iw_sheet.iu_current_coil
end if
//dw_scrap.of_retrieve( )
dw_skid_item.of_retrieve( )

//dw_current_edit.settaborder( "sheet_skid_sheet_net_wt", 0)

//dw_scrap.inv_base.of_populatedddw( )
//dw_skid_item.sharedata( dw_current_edit )
//long ll_row
//ll_row = dw_skid_item.rowcount( )
//
//dw_current_edit.scrolltorow( ll_row )


end subroutine

public subroutine of_add_current_skid_pieces (integer ai_pcs);long ll_rc, ll_pcs
string ls_pcs
//ll_rc = dw_current_skid.rowcount( )
if dw_current_edit.enabled then
	//ll_pcs = dw_current_skid.object.pieces[1]
	//dw_current_skid.object.pieces[1] = ll_pcs + ai_pcs
	if il_current_row > 0 then
		if dw_current_edit.object.stacker[il_current_row] > 0 then return
		iu_coil.of_select_skid_tabpg( )
		dw_current_edit.setrow( il_current_row )
		dw_current_edit.scrolltorow( il_current_row )
		dw_current_edit.setcolumn( "sheet_skid_skid_pieces")
		ls_pcs = dw_current_edit.gettext( )
		ll_pcs = Long(ls_pcs)
		ll_pcs = ll_pcs + ai_pcs
		dw_current_edit.settext( string(ll_pcs ))
		dw_current_edit.accepttext( )
	end if
end if
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

public function integer of_save_current_skid_new (long al_pcs, long al_skid_id, long al_tare, long al_item_id, integer ai_status);long ll_skid_theo_wt, ll_skid_num, ll_job_num, ll_tare, ll_skid_pieces, ll_item_pieces
long ll_order_num, ll_prod_item_num, ll_coil_num,ll_rc, ll_shift_num, ll_row
int li_order_item, li_status, li_row
string ls_test
//if dw_current_skid.rowcount( ) <> 1 then
//			MessageBox("Current skid not available", "Current skid not available, please load it first!", StopSign!)
//			return 1
//end if
//dw_current_skid.accepttext( )
ll_skid_pieces = al_pcs
if ll_skid_pieces < 1 or ll_skid_pieces > 999 then
	MessageBox("Can not save skid", "Invalid pieces!", StopSign!)
	return 1
end if

ls_test = "DAS"+string(iw_sheet.ii_line_id)
ll_skid_theo_wt = iu_coil.of_get_theo_piece_wt( ) * al_pcs
ll_skid_num = al_skid_id
ll_job_num = iu_coil.get_current_job( )
ll_tare = al_tare
ll_item_pieces = ll_skid_pieces
ll_order_num = iu_coil.of_get_order_num( )
li_order_item = iu_coil.of_get_order_item( )
ll_prod_item_num = al_item_id
ll_coil_num = iu_coil.get_coil_abc_id( )
li_status = ai_status
ll_shift_num = iu_coil.of_get_shift_id( )
//dw_current_skid.print.

//if ids_dim_check.of_validation( ) <> 1 then
//	MessageBox("Dimension check data", "Please update Dimension check data, and try again! ")
//	return 1
//end if

  // 1) Insert prod_sheet_item table
  INSERT INTO "PRODUCTION_SHEET_ITEM"  
         ( "PROD_ITEM_NUM",   
           "COIL_ABC_NUM",   
           "AB_JOB_NUM",   
           "PROD_ITEM_STATUS",   
           "PROD_ITEM_PIECES",   
           "PROD_ITEM_NET_WT",   
           "PROD_ITEM_THEORETICAL_WT",   
           "PROD_ITEM_EDI870_DATE",   
           "PROD_ITEM_DATE",   
           "PROD_ITEM_NOTE",   
           "PROD_ITEM_PLACEMENT",
			  "SHIFT_NUM")  
  VALUES ( :ll_prod_item_num,   
           :ll_coil_num,   
           :ll_job_num,   
           :li_status,   
           :ll_item_pieces,   
           :ll_skid_theo_wt ,   
           :ll_skid_theo_wt ,   
           null,   
           sysdate,   
           :ls_test,   
           null,
			  :ll_shift_num)  ;

// 2) Insert sheet skid table
  
  ll_rc = sqlca.sqlcode
  if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert prod_item!")
		return ll_rc
	end if
	
  	INSERT INTO "SHEET_SKID"  
         ( "SHEET_SKID_NUM",   
           "AB_JOB_NUM",   
           "SHEET_NET_WT",   
           "SHEET_TARE_WT",   
           "SKID_EDI856_DATE",   
           "SKID_LOCATION",   
           "SKID_DATE",   
           "SKID_SHEET_STATUS",   
           "SKID_PIECES",   
           "SHEET_THEORETICAL_WT",   
           "SKID_FROM_IF_WHED",   
           "SKID_TICKET_IF_WHED",   
           "REF_ORDER_ABC_NUM",   
           "SKID_TYPE_IF_WHED",   
           "REF_ORDER_ABC_ITEM",   
           "SKID_SHEET_STATUS_HELD_BY_QC" )  
  VALUES ( :ll_skid_num ,
  			  :ll_job_num ,
			  0,   
           :ll_tare ,   
           null,   
           :ls_test,   
           SYSDATE,   
           6 ,   
           0,   
           0,   
           null,   
           null,   
           :ll_order_num,   
           null,   
           :li_order_item,//);
           null);
	ll_rc = sqlca.sqlcode
 	if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert Sheet_skid!")
		return ll_rc
	end if
	
// 3) Insert sheet_skid_detail
	  INSERT INTO "SHEET_SKID_DETAIL"  
         ( "PROD_ITEM_NUM",   
           "SHEET_SKID_NUM" )  
  		VALUES ( :ll_prod_item_num ,   
           :ll_skid_num )  ;
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert Sheet_skid_detail!")
		return ll_rc
	end if
	
	
	//Update dimensional check data
	
	
//		if ids_dim_check.event pfc_update( true, true) <> 1 then
//			//			//sqlca.of_commit( )
//			//	else
//			sqlca.of_rollback( )
//			MessageBox("Error Saving Dimension check data", "Please update Dimension check data, and try again! ")
//			return 1
//		end if
	
	
	sqlca.of_commit( )
			ll_row = dw_skid_item.insertrow( 0 )
			dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_num
			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare
			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = ll_skid_theo_wt
			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = 0
			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = 0
			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = 0
			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = 6
			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = 0
			dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
			dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job_num
			dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_num
			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = 0
			dw_skid_item.object.compute_0010[ll_row] = 0
			dw_skid_item.object.compute_0014[ll_row] = 0
			dw_skid_item.object.item_status[ll_row] = 1
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_num
			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_num
//			dw_skid_item.object.skid_status[ll_row] = 1
			DWItemStatus ldw_status
			ldw_status = dw_skid_item.getitemstatus( ll_Rc, 0, Primary!)
			dw_skid_item.setitemstatus( ll_rc, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_Rc, 0, Primary!)
			dw_skid_item.setitemstatus( ll_rc, 0, Primary!, DataModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_Rc, 0, Primary!)
			dw_skid_item.setitemstatus( ll_rc, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_Rc, 0, Primary!)

return 0 //retrun sqlca.sqlcode
end function

public function integer of_save_current_skid_partial (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt);long ll_skid_theo_wt, ll_item_theo_wt, ll_prod_item_num, ll_coil_num, ll_job_num, li_status, ll_item_pieces, ll_skid_pieces, ll_skid_nw
string ls_test
long ll_skid_num, ll_order_num, ll_rc, ll_tare, ll_shift_num, ll_row, ll_stacker1_skid, ll_stacker2_skid
int li_order_item, li_row, li_line_id
Double ld_theo_unit_wt

ls_test = "DAS-partial-saved"
//if dw_current_skid.rowcount( ) <> 1 then
//			MessageBox("Current skid not available", "Current skid not available, please load it first!", StopSign!)
//			return 1
//end if
//dw_current_skid.accepttext( )
li_line_id = iu_coil.of_get_sheet_window( ).ii_line_id
ll_skid_theo_wt = al_skid_pcs * iu_coil.of_get_theo_piece_wt( )
ll_skid_num = al_skid_id
ll_job_num = iu_coil.get_current_job( )
ll_tare = al_tare
ll_skid_pieces = al_skid_pcs
ll_item_pieces = ll_skid_pieces - al_init_pcs
ld_theo_unit_wt = iu_coil.of_get_theo_piece_wt( )
If ll_item_pieces < 0 or ll_item_pieces > 999 then
	MessageBox("Can not save skid", "Item pieces error!!"  )
	return -1
end if

ll_shift_num = iu_coil.of_get_shift_id( )
ll_item_theo_wt = ll_item_pieces * iu_coil.of_get_theo_piece_wt( )
ll_order_num = iu_coil.of_get_order_num( )
li_order_item = iu_coil.of_get_order_item( )
ll_prod_item_num = al_item_id
ll_coil_num = iu_coil.get_coil_abc_id( )
li_status = ai_status
ll_skid_nw = al_init_skid_wt + ll_item_theo_wt
// 1) Insert prod_sheet_item table
  INSERT INTO "PRODUCTION_SHEET_ITEM"  
         ( "PROD_ITEM_NUM",   
           "COIL_ABC_NUM",   
           "AB_JOB_NUM",   
           "PROD_ITEM_STATUS",   
           "PROD_ITEM_PIECES",   
           "PROD_ITEM_NET_WT",   
           "PROD_ITEM_THEORETICAL_WT",   
           "PROD_ITEM_EDI870_DATE",   
           "PROD_ITEM_DATE",   
           "PROD_ITEM_NOTE",   
           "PROD_ITEM_PLACEMENT",
			  "SHIFT_NUM")  
  VALUES ( :ll_prod_item_num,   
           :ll_coil_num,   
           :ll_job_num,   
           :li_status,   
           :ll_item_pieces,   
           :ll_item_theo_wt,   
           :ll_item_theo_wt,
			  null,   
           sysdate,   
           :ls_test,   
           null,
			  :ll_shift_num)  ;

	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert production_sheet_item")
		return ll_rc
	end if

//Insert sheet_skid_detail

	  INSERT INTO "SHEET_SKID_DETAIL"  
         ( "PROD_ITEM_NUM",   
           "SHEET_SKID_NUM" )  
  		VALUES ( :ll_prod_item_num ,   
           :ll_skid_num )  ;
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert Sheet_skid_detail!")
		return ll_rc
	end if

//Update sheet_skid table

	  UPDATE "SHEET_SKID"  
     SET "AB_JOB_NUM" = :ll_job_num ,   
         "SHEET_NET_WT" = "SHEET_NET_WT" + :ll_item_theo_wt,
         "SKID_DATE" = SYSDATE,   
         "SKID_SHEET_STATUS" = :li_status ,   
         "SKID_PIECES" = "SKID_PIECES" + :ll_item_pieces,
         "SHEET_THEORETICAL_WT" = "SHEET_THEORETICAL_WT" + :ll_item_theo_wt
   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num   
           ;
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error update Sheet_skid!")
		return ll_rc
	end if
	
	  SELECT "LINE_CURRENT_STATUS"."SHEET_SKID_STACKER_1",   
         "LINE_CURRENT_STATUS"."SHEET_SKID_STACKER_2"  
    INTO :ll_stacker1_skid,   
         :ll_stacker2_skid  
    FROM "LINE_CURRENT_STATUS"  
   WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id   ;

	

	sqlca.of_commit( )

	
			ll_row = dw_skid_item.insertrow( 0 )
			dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_num
			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare
			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = ll_skid_nw
			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = ll_skid_pieces
			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = ll_skid_theo_wt
			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = ll_item_pieces
			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = ai_status
			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = ll_item_theo_wt
			dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
			dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job_num
			dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_num
			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = ll_item_theo_wt
			dw_skid_item.object.production_sheet_item_prod_item_status[ll_row] = li_status
			dw_skid_item.object.compute_0010[ll_row] = ll_skid_nw
			dw_skid_item.object.compute_0014[ll_row] = ll_skid_pieces
			dw_skid_item.object.item_status[ll_row] = 1
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_num
			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_num
         dw_skid_item.object.order_item_theoretical_unit_wt[ll_row] = ld_theo_unit_wt
			
			if not isNull( ll_stacker1_skid ) and ll_stacker1_skid = ll_skid_num then &
				dw_skid_item.object.stacker[ll_row] = 1
			if not isNull( ll_stacker2_skid ) and ll_stacker2_skid = ll_skid_num then &
				dw_skid_item.object.stacker[ll_row] = 2
			
			DWItemStatus ldw_status
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)

						
			ll_row = dw_skid_item.insertrow( 0 )
			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = al_init_pcs
			dw_skid_item.object.item_status[ll_row] = ll_prod_item_num
			dw_skid_item.object.skid_status[ll_row] = ll_skid_num
			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = 99
			
			
			
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			
			dw_current_edit.enabled = true
			dw_current_edit.scrolltorow( ll_row -1 )
			il_current_row = ll_row -1
	
//	li_row = dw_skid_item.insertrow( 0 )
//	dw_skid_item.setitem( li_row, "sheet_skid_sheet_skid_num", ll_skid_num)
//	dw_skid_item.setitem( li_row, "sheet_skid_sheet_tare_wt", ll_tare)
//	dw_skid_item.setitem( li_row, "production_sheet_item_prod_item_net_wt", ll_item_theo_wt )
//	//dw_skid_item.setitem( li_row, "production_sheet_item_prod_item_pieces", ll_skid_pieces )
//	dw_skid_item.object.production_sheet_item_prod_item_pieces[li_row] = ll_item_pieces
//	dw_skid_item.object.production_sheet_item_prod_item_pieces_1[li_row] = ll_item_pieces
//	dw_skid_item.setitem( li_row, "production_sheet_item_prod_item_num", ll_prod_item_num  )
//	dw_skid_item.setitem( li_row, "production_sheet_item_coil_abc_num", ll_coil_num )
//	dw_skid_item.setitem( li_row, "production_sheet_item_ab_job_num", ll_job_num )
//	dw_skid_item.object.sheet_skid_sheet_net_wt[li_row] = 0
//	dw_skid_item.object.sheet_skid_sheet_net_wt_1[li_row] = ll_skid_nw
//	dw_skid_item.object.sheet_skid_skid_pieces[li_row] = ll_skid_pieces	
//	dw_skid_item.object.sheet_skid_skid_sheet_status[li_row] = li_status
//
return 0 //retrun sqlca.sqlcode
end function

public function integer of_save_current_skid_partial_single_item (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt, long al_init_item_pcs);long ll_skid_theo_wt, ll_item_theo_wt, ll_prod_item_num, ll_coil_num, ll_job_num, li_status, ll_item_pieces, ll_skid_pieces, ll_skid_nw
string ls_test
long ll_skid_num, ll_order_num, ll_rc, ll_tare, ll_init_item_pcs, ll_shift_num, ll_row, ll_new_item_pcs, ll_stacker1_skid, ll_stacker2_skid
int li_order_item, li_row, li_line_id
Double ld_theo_unit_wt

ls_test = "DAS-partial-single-item"
//if dw_current_skid.rowcount( ) <> 1 then
//			MessageBox("Current skid not available", "Current skid not available, please load it first!", StopSign!)
//			return 1
//end if

//item_piece and item_nw are for added item pcs and nw

//dw_current_skid.accepttext( )
// dw_current_skid.getitemnumber( 1, "pieces")
li_line_id = iu_coil.of_get_sheet_window( ).ii_line_id
ll_shift_num = iu_coil.of_get_shift_id( )
ll_skid_num = al_skid_id
ll_job_num = iu_coil.get_current_job( )
ll_tare = al_tare
ll_skid_pieces = al_skid_pcs
ll_skid_theo_wt = iu_coil.of_get_theo_piece_wt( ) *ll_skid_pieces
ll_item_pieces = ll_skid_pieces - al_init_pcs
ll_init_item_pcs = al_init_item_pcs
ll_new_item_pcs = ll_init_item_pcs + ll_item_pieces
ld_theo_unit_wt = iu_coil.of_get_theo_piece_wt( )
If ll_item_pieces < 0 or ll_item_pieces > 999 then
	MessageBox("Can not save skid", "Item pieces error!!"  )
	return -1
end if

ll_item_theo_wt = ll_item_pieces * iu_coil.of_get_theo_piece_wt( )
ll_order_num = iu_coil.of_get_order_num( )
li_order_item = iu_coil.of_get_order_item( )
ll_prod_item_num = al_item_id
ll_coil_num = iu_coil.get_coil_abc_id( )
li_status = ai_status

ll_skid_nw = al_init_skid_wt + ll_item_theo_wt
// 1) update prod_sheet_item table
  
    UPDATE "PRODUCTION_SHEET_ITEM"  
     SET "PROD_ITEM_STATUS" = :li_status,   
         "PROD_ITEM_PIECES" = "PROD_ITEM_PIECES" + :ll_item_pieces, //+ :ll_init_item_pcs,   
         "PROD_ITEM_NET_WT" = "PROD_ITEM_NET_WT" + :ll_item_theo_wt,   
         "PROD_ITEM_THEORETICAL_WT" = "PROD_ITEM_THEORETICAL_WT"+ :ll_item_theo_wt,
			"SHIFT_NUM" = :ll_shift_num
   WHERE "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" = :ll_prod_item_num   
           ;

  
//  
//  INSERT INTO "PRODUCTION_SHEET_ITEM"  
//         ( "PROD_ITEM_NUM",   
//           "COIL_ABC_NUM",   
//           "AB_JOB_NUM",   
//           "PROD_ITEM_STATUS",   
//           "PROD_ITEM_PIECES",   
//           "PROD_ITEM_NET_WT",   
//           "PROD_ITEM_THEORETICAL_WT",   
//           "PROD_ITEM_EDI870_DATE",   
//           "PROD_ITEM_DATE",   
//           "PROD_ITEM_NOTE",   
//           "PROD_ITEM_PLACEMENT" )  
//  VALUES ( :ll_prod_item_num,   
//           :ll_coil_num,   
//           :ll_job_num,   
//           :li_status,   
//           :ll_item_pieces,   
//           :ll_item_theo_wt,   
//           :ll_item_theo_wt,
//			  null,   
//           sysdate,   
//           :ls_test,   
//           null )  ;

	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error update production_sheet_item")
		return ll_rc
	end if

////Insert sheet_skid_detail
//
//	  INSERT INTO "SHEET_SKID_DETAIL"  
//         ( "PROD_ITEM_NUM",   
//           "SHEET_SKID_NUM" )  
//  		VALUES ( :ll_prod_item_num ,   
//           :ll_skid_num )  ;
//	ll_rc = sqlca.sqlcode
//	if ll_rc <> 0 then
//		sqlca.of_rollback( )
//		MessageBox("Database error", "Error insert Sheet_skid_detail!")
//		return ll_rc
//	end if
//

//Update sheet_skid table

	  UPDATE "SHEET_SKID"  
     SET "AB_JOB_NUM" = :ll_job_num,   
         "SHEET_NET_WT" = "SHEET_NET_WT" + :ll_item_theo_wt,
         "SKID_DATE" = SYSDATE,   
         "SKID_SHEET_STATUS" = :li_status,   
         "SKID_PIECES" = "SKID_PIECES" + :ll_item_pieces,   
         "SHEET_THEORETICAL_WT" = "SHEET_THEORETICAL_WT" + :ll_item_theo_wt  
   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num   
           ;
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert Sheet_skid_detail!")
		return ll_rc
	end if

	sqlca.of_commit( )

	  SELECT "LINE_CURRENT_STATUS"."SHEET_SKID_STACKER_1",   
         "LINE_CURRENT_STATUS"."SHEET_SKID_STACKER_2"  
    INTO :ll_stacker1_skid,   
         :ll_stacker2_skid  
    FROM "LINE_CURRENT_STATUS"  
   WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id   ;
	
	ll_row = dw_skid_item.find( "production_sheet_item_prod_item_num = " + string( ll_prod_item_num ), 1, dw_skid_item.rowcount( ) )
	if ll_row > 0 then
		
			//dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare
			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = ll_skid_nw
			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = ll_skid_pieces
			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = ll_skid_theo_wt
			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = ll_new_item_pcs
			
			
			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = ai_status
			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = &
				dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] + ll_item_theo_wt
			
			//dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
			//dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job
			//dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = &
				dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] + ll_item_theo_wt
			dw_skid_item.object.production_sheet_item_prod_item_status[ll_row] = li_status
			if not isNull( ll_stacker1_skid ) and ll_stacker1_skid = ll_skid_num then &
				dw_skid_item.object.stacker[ll_row] = 1
			if not isNull( ll_stacker2_skid ) and ll_stacker2_skid = ll_skid_num then &
				dw_skid_item.object.stacker[ll_row] = 2
			
			dw_skid_item.object.compute_0010[ll_row] = ll_skid_nw
			dw_skid_item.object.compute_0014[ll_row] = ll_skid_pieces
			dw_skid_item.object.item_status[ll_row] = 1
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.order_item_theoretical_unit_wt[ll_row] = ld_theo_unit_wt
			
			//dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
			//dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
			
			DWItemStatus ldw_status
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)

			dw_current_edit.enabled = true
			dw_current_edit.scrolltorow( ll_row  )
			il_current_row = ll_row
		
		
		
//		dw_skid_item.setitem( ll_row, "sheet_skid_sheet_skid_num", ll_skid_num)
//		dw_skid_item.setitem( ll_row, "sheet_skid_sheet_tare_wt", ll_tare)
//		dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = & 
//			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] + ll_item_theo_wt
//		dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = & 
//		  	dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] + ll_item_pieces
//		dw_skid_item.object.production_sheet_item_prod_item_pieces_1[ll_row] = &
//			dw_skid_item.object.production_sheet_item_prod_item_pieces_1[ll_row] + ll_item_pieces
//		dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = 0
//		dw_skid_item.object.sheet_skid_sheet_net_wt_1[ll_row] = dw_skid_item.object.sheet_skid_sheet_net_wt_1[ll_row] + ll_item_theo_wt
//		dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = dw_skid_item.object.sheet_skid_skid_pieces[ll_row] + ll_item_pieces
//		dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = li_status
	end if
return 0 //retrun sqlca.sqlcode
end function

public function integer of_delete_rows ();//return 1 if sucess
//return -1 error
long ll_prod_item_num, ll_item_pieces		   
long ll_skid_pieces,ll_skid_theo_wt,ll_item_nw,ll_skid_num,row
long ll_item_theo_wt, ll_item_count, ll_rc, ll_i
int li_line_id
ll_rc = dw_skid_item.deletedcount( )
if ll_rc < 1 then
	return 1
end if
//ll_rc = 1
li_line_id = iw_sheet.ii_line_id
for ll_i = 1 to ll_rc
	if dw_skid_item.getitemstatus( ll_i, 0 , Delete!)	= 	New!	then
		CONTINUE
	end if
	
	if dw_skid_item.getitemnumber( ll_i, "item_status", Delete!, false) > 10000 then
		CONTINUE
	end if
	
			ll_prod_item_num=dw_skid_item.getitemnumber(ll_i, "production_sheet_item_prod_item_num", Delete!, false)
			ll_skid_num=dw_skid_item.getitemnumber(ll_i, "sheet_skid_detail_sheet_skid_num", Delete!, false)
			
//			MessageBox(string(ll_prod_item_num), string(ll_skid_num))
			
			  UPDATE "LINE_CURRENT_STATUS"  
     			SET "SHEET_SKID_NUM" = null  
   			WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id
				and "LINE_CURRENT_STATUS"."SHEET_SKID_NUM" = :ll_skid_num
           ;
			if sqlca.sqlcode <> 0 then
					MessageBox("", "Update failed line_current_status" )
					return -1
				end if
			
//			MessageBox("", "update line_current_status" )
			
			DELETE FROM "SHEET_SKID_DETAIL"  
   			WHERE "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" = :ll_prod_item_num   ;
				if sqlca.sqlcode <> 0 then
					//sqlca.of_rollback( )
					MessageBox("", "delete failed sheet_skid_detail" )
					return -1
				//else
				//	sqlca.of_commit( )
				end if
		  
//		  MessageBox("", "delete failed sheet_skid_detail" )
		  
		  DELETE FROM "PRODUCTION_SHEET_ITEM"  
   		WHERE "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" = :ll_prod_item_num   ;
				if sqlca.sqlcode <> 0 then
					//sqlca.of_rollback( )
					MessageBox("", "delete failed production_sheet_item" )
					return -1
				//else
				//	sqlca.of_commit( )
				end if
		
//		  MessageBox("", "delete failed production_sheet_item" )
		  
		  SELECT COUNT(*) 
    INTO :ll_item_count  
    FROM "SHEET_SKID_DETAIL"  
   WHERE "SHEET_SKID_DETAIL"."SHEET_SKID_NUM" = :ll_skid_num   ;
						if sqlca.sqlcode <> 0 then
							//sqlca.of_rollback( )
							MessageBox("", "select failed sheet_skid_detail" )
							return -1
						end if
	
//	MessageBox("", "count" )
	
	if ll_item_count > 0 then
//		MessageBox("", "after count item_count > 0" )
		//ll_skid_pieces = ll_item_pieces - dw_skid_item.object.production_sheet_item_prod_item_pieces_1[row] + dw_skid_item.object.sheet_skid_skid_pieces[row]
		//ll_skid_theo_wt = ll_skid_pieces * iu_coil.of_get_theo_piece_wt( )
		ll_item_pieces = &
			dw_skid_item.getitemnumber( ll_i, "production_sheet_item_prod_item_pieces", Delete!, false)
		ll_item_nw = &
			dw_skid_item.getitemnumber( ll_i, "production_sheet_item_prod_item_net_wt", Delete!, false)
		
		ll_item_theo_wt = ll_item_pieces * dw_skid_item.getitemnumber( ll_i, "order_item_theoretical_unit_wt", Delete!, false)
		
//		MessageBox(string(ll_item_nw), string(ll_item_pieces) + " " + string(ll_item_theo_wt) )
		
		UPDATE "SHEET_SKID"
		SET "SKID_PIECES" = "SKID_PIECES" - :ll_item_pieces ,   
      	   "SHEET_THEORETICAL_WT" = "SHEET_THEORETICAL_WT" - :ll_item_theo_wt,
				"SHEET_NET_WT" = "SHEET_NET_WT" - :ll_item_nw
   		WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num;
				
	  					if sqlca.sqlcode <> 0 then
							//sqlca.of_rollback( )
							return -1
						end if
	else // Delete sheet_skid
//		  DELETE FROM "SHEET_SKID_DIMENSION_CHECK"  
//   			WHERE "SHEET_SKID_DIMENSION_CHECK"."SHEET_SKID_NUM" = :ll_skid_num    ;
//				if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				//else
//				//	sqlca.of_commit( )
//				end if
//				  MessageBox("", "after count count = 0" )
				  DELETE FROM "SHEET_SKID"  
   					WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num ;
						if sqlca.sqlcode <> 0 then
							MessageBox("Delete skid", "sheet_skid table")
							//sqlca.of_rollback( )
							return -1
						end if

				
	end if
next
return 1
end function

public function integer of_save ();int li_rc, li_row,li_i, li_status
Long ll_skid
String ls_notes

of_retrieve_skid_net_wt( )

dw_skid_item.accepttext( )
dw_current_edit.accepttext( )

if of_delete_rows() <> 1 then
	//sqlca.of_commit( )
	//dw_skid_item.resetupdate( )
//else
	sqlca.of_rollback( )
	MessageBox("Delete", "Delete function failed", StopSign!)
	return 1
end if

li_rc = dw_skid_item.of_update( true, true)
if li_rc <> 1 then
//	sqlca.of_commit( )
//else
	sqlca.of_rollback( )
	MessageBox("Update", "Update failed!", StopSign!)
	return 1
end if
sqlca.of_commit( )
iu_coil.of_update_from_skid_scrap( )

li_row = dw_skid_item.RowCount()
IF li_row > 0 THEN
	FOR li_i = 1 TO li_row
		ll_skid = dw_skid_item.GetItemNumber(li_i, "sheet_skid_sheet_skid_num", Primary!, FALSE)
		li_status = dw_skid_item.GetItemNumber(li_i, "sheet_skid_skid_sheet_status", Primary!, FALSE)
		ls_notes = dw_skid_item.GetItemString(li_i,"sheet_skid_sheet_skid_quality_notes", Primary!, FALSE)
      IF li_status = 4 THEN
			UPDATE sheet_skid SET skid_sheet_status = 4, sheet_skid_quality_notes = :ls_notes
			WHERE sheet_skid_num = :ll_skid
			USING SQLCA;
	   	COMMIT USING SQLCA;
		END IF			
	NEXT
END IF
return 0
end function

public function integer of_data_validation (long al_row);long ll_wt_limit
ll_wt_limit = iu_coil.get_old_nw( ) + iu_coil.get_old_nw( ) * 0.11
if dw_current_edit.object.sheet_skid_sheet_tare_wt[al_row] < 0 or dw_current_edit.object.sheet_skid_sheet_tare_wt[al_row] > 8000 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid tare weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_current_edit.object.production_sheet_item_prod_item_net_wt[al_row] < 0 or dw_current_edit.object.production_sheet_item_prod_item_net_wt[al_row] > ll_wt_limit then
	this.of_messagebox( "id_data_error", "Data error", "Invalid skid weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_current_edit.object.production_sheet_item_prod_item_theoretical_wt[al_row] < 1 or dw_current_edit.object.production_sheet_item_prod_item_theoretical_wt[al_row] > ll_wt_limit then
	this.of_messagebox( "id_data_error", "Data error", "Invalid skid pieces!", Exclamation!, Ok!, 1)
	return 1
end if

return 0 //return 0 if validated
end function

public function integer of_retrieve_skid_net_wt ();//Return 1 if ok
long ll_rows, ll_i, ll_net_wt, ll_skid_id, ll_net_change, ll_item_nw, ll_tare, ll_old_net, ll_job
int li_status
ll_rows = dw_skid_item.rowcount( )
if ll_rows < 1 then return 0

for ll_i=1 to ll_rows
	ll_net_wt = dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_i]
	li_status = dw_skid_item.object.sheet_skid_skid_sheet_status[ll_i]
	ll_job = dw_skid_item.object.production_sheet_item_ab_job_num[ll_i]
	// For testing
	if ll_net_wt = 0  or li_status = 1 then
		ll_skid_id = dw_skid_item.object.sheet_skid_sheet_skid_num[ll_i]
		
		  SELECT "SHEET_SKID"."SHEET_NET_WT", "SHEET_SKID"."SHEET_TARE_WT" 
    		INTO :ll_net_wt, :ll_tare 
    		FROM "SHEET_SKID"  
   		WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_id   ;
		if (not isNull(ll_net_wt)) and ll_net_wt > 3 then
			
			ll_net_change = ll_net_wt -  dw_skid_item.object.compute_0010[ll_i]
			if ll_net_change <> 0 then
				ll_item_nw = dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_i] + ll_net_change
				dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_i] = ll_item_nw
				dw_skid_item.object.sheet_skid_sheet_net_wt[ll_i] = ll_net_wt
				dw_skid_item.object.compute_0010[ll_i] = ll_net_wt
			end if
//			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_i] = ll_tare
//			dw_skid_item.setrow( ll_i )
//			dw_skid_item.setcolumn( "sheet_skid_sheet_net_wt")
//			dw_skid_item.settext( string(ll_net_wt ))
//			dw_skid_item.accepttext( )
		end if
		
		if isNull(ll_tare) then
			  SELECT "AB_JOB"."JOB_TARE_WT"  
    			INTO :ll_tare  
    			FROM "AB_JOB"  
   		WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job;

		end if
		
		if (not isNull(ll_tare)) and ll_tare > 0 and ll_tare <> dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_i] then
			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_i] = ll_tare
		end if
		
	end if
next
return 1
end function

public function integer of_stacker_new_skid (integer ai_stacker);long ll_tare_wt, ll_skid_seq, ll_prod_item_seq, ll_row, ll_job, ll_order_num, ll_rc,ll_coil_num
Int li_order_item, li_status
string ls_test
long ll_item_pieces, ll_skid_theo_wt, ll_shift_num, ll_row_test
Double ld_theo_unit_wt

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num

		//if dw_current_skid.rowcount( ) > 0 then
//		if dw_current_edit.rowcount( ) > 0 then
//			MessageBox("Current skid", "Current skid not done, please done it first!", StopSign!)
//			return 1
//		end if
ll_tare_wt = 0
ll_skid_seq = 0
ll_prod_item_seq = 0
ll_item_pieces = 1
//dw_skid_item.sharedata( dw_current_edit )
ll_job = iu_coil.get_current_job( )

ll_row_test = dw_skid_item.find( "stacker="+ string(ai_stacker ) + " and sheet_skid_skid_sheet_status=1 and sheet_skid_skid_pieces=1", 1, dw_skid_item.rowcount( ) )
//messagebox("", string(ll_row))
if ll_row_test > 0 then return 0


ii_working_stacker = ai_stacker




//  SELECT "AB_JOB"."JOB_TARE_WT"  
//    INTO :ll_tare_wt  
//    FROM "AB_JOB"  
//   WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job;
//
//if isNull( ll_tare_wt ) or ll_tare_wt = 0 then
//	if not isValid( iw_tare ) then
//			OpenWithParm(iw_tare, ll_job )
//		ll_tare_wt = message.doubleparm
//	end if	
//end if

//	if ll_tare_wt > 0 then
		//handle new tare wt
		ll_job = iu_coil.get_current_job( )
		  SELECT NVL("AB_JOB"."JOB_TARE_WT",0)  
    			INTO :ll_tare_wt  
    			FROM "AB_JOB"  
   			WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job   
           	;
				if sqlca.sqlcode <> 0 then
					messagebox("Error", "Error reading job tare!")
					return 1
				end if

		
		if dw_current_edit.rowcount( ) < 1 and (not dw_current_edit.enabled) then dw_skid_item.sharedata( dw_current_edit )
		SELECT sheet_skid_num_seq.NEXTVAL INTO :ll_skid_seq FROM DUAL;
		SELECT prod_item_num_seq.NEXTVAL INTO :ll_prod_item_seq FROM DUAL;
		
		if ll_skid_seq < 1000 or ll_prod_item_seq < 1000 then
			MessageBox("Database error", "Error getting seq numbers", Stopsign!)
			return 1
		end if
		
		
		ls_test = "stacker new-skid"
		ll_order_num = iu_coil.of_get_order_num( )
		li_order_item = iu_coil.of_get_order_item( )
		ll_coil_num = iu_coil.get_coil_abc_id( )
		li_status = 2
		ll_shift_num = iu_coil.of_get_shift_id( )
//		ll_skid_theo_wt = 0
		ld_theo_unit_wt = iu_coil.of_get_theo_piece_wt( )
		ll_skid_theo_wt = round(ld_theo_unit_wt,0)
		
		INSERT INTO "SHEET_SKID"  
         ( "SHEET_SKID_NUM",   
           "AB_JOB_NUM",   
           "SHEET_NET_WT",   
           "SHEET_TARE_WT",   
           "SKID_EDI856_DATE",   
           "SKID_LOCATION",   
           "SKID_DATE",   
           "SKID_SHEET_STATUS",   
           "SKID_PIECES",   
           "SHEET_THEORETICAL_WT",   
           "SKID_FROM_IF_WHED",   
           "SKID_TICKET_IF_WHED",   
           "REF_ORDER_ABC_NUM",   
           "SKID_TYPE_IF_WHED",   
           "REF_ORDER_ABC_ITEM",   
           "SKID_SHEET_STATUS_HELD_BY_QC" )  
  VALUES ( :ll_skid_seq,
  			  :ll_job,
			  0,   
           :ll_tare_wt,   
           null,   
           :ls_test,   
           SYSDATE,   
        		1 ,   
           :ll_item_pieces,   
           :ll_skid_theo_wt,   
           null,   
           null,   
           :ll_order_num,   
           null,   
           :li_order_item,//);
           null);
	ll_rc = sqlca.sqlcode
 	if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert Sheet_skid!")
		return ll_rc
	end if
	
	//Sleep(1)
	
		INSERT INTO "PRODUCTION_SHEET_ITEM"  
         ( "PROD_ITEM_NUM",   
           "COIL_ABC_NUM",   
           "AB_JOB_NUM",   
           "PROD_ITEM_STATUS",   
           "PROD_ITEM_PIECES",   
           "PROD_ITEM_NET_WT",   
           "PROD_ITEM_THEORETICAL_WT",   
           "PROD_ITEM_EDI870_DATE",   
           "PROD_ITEM_DATE",   
           "PROD_ITEM_NOTE",   
           "PROD_ITEM_PLACEMENT",
			  "SHIFT_NUM")  
  VALUES ( :ll_prod_item_seq,   
           :ll_coil_num,   
           :ll_job,   
           :li_status,   
           :ll_item_pieces,   
           0,   
           :ll_skid_theo_wt ,   
           null,   
           sysdate,   
           :ls_test,   
           null,
			  :ll_shift_num)  ;
			  
			  ll_rc = sqlca.sqlcode
 	if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert Production_sheet_item!")
		return ll_rc
	end if

	
	INSERT INTO "SHEET_SKID_DETAIL"  
         ( "PROD_ITEM_NUM",   
           "SHEET_SKID_NUM" )  
  		VALUES ( :ll_prod_item_seq ,   
           :ll_skid_seq )  ;
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert Sheet_skid_detail!")
		return ll_rc
	end if
	
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		li_rtn = f_insert_sheet_skid_package(ll_job, ll_skid_seq, sqlca)
		
		If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package(). Error message is in this function.
			rollback using sqlca;
			Return li_rtn
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
				
			sqlca.of_commit( )
			
			ll_row = dw_skid_item.insertrow( 0 )
			dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare_wt
			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = 0
			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = 1
			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = ll_skid_theo_wt
			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = 1
			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = 1
			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = 0
			dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
			dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job
			dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = ll_skid_theo_wt
			dw_skid_item.object.production_sheet_item_prod_item_status[ll_row] = li_status
			
			dw_skid_item.object.compute_0010[ll_row] = 0
			dw_skid_item.object.compute_0014[ll_row] = 1
			dw_skid_item.object.item_status[ll_row] = 1
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.order_item_theoretical_unit_wt[ll_row] = ld_theo_unit_wt
			dw_skid_item.object.stacker[ll_row] = ai_stacker
			
			DWItemStatus ldw_status
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			
			dw_current_edit.enabled = true
			dw_current_edit.scrolltorow( ll_row)
			il_current_row = ll_row
			dw_skid_item.selectrow( 0, false)
			iu_coil.of_get_sheet_window( ).wf_set_opc_abskid( ll_skid_seq, ai_stacker )
			em_offset.text = "0"
			return 0
//	end if
//end if
end function

public function integer of_stacker_complete (integer ai_stacker);//if not dw_current_edit.enabled or dw_current_edit.rowcount( ) < 1 then
////	MessageBox("Attention", "There is no current skid!", StopSign!)
//	return 1
//end if
int li_rc
long ll_row

//if ai_stacker <> ii_working_stacker then return 1

//ll_row = dw_current_edit.getrow( )
//messagebox("","getrow")

//ll_row = 

choose case ai_stacker
	case 1
	ll_row = dw_skid_item.find( "stacker=1 and sheet_skid_skid_sheet_status=1", 1, dw_skid_item.rowcount( ) )
	case 2
	ll_row = dw_skid_item.find( "stacker=2 and sheet_skid_skid_sheet_status=1", 1, dw_skid_item.rowcount( ) )
end choose


//ll_row = dw_skid_item.find( "stacker=1 and sheet_skid_skid_sheet_status=1", 1, dw_skid_item.rowcount( ) )
if ll_row < 1 then return 1

//if ll_row > 0 then
	if dw_current_edit.rowcount( ) < 1 then &
		dw_skid_item.sharedata( dw_current_edit )
		dw_current_edit.enabled = true
		dw_current_edit.setrow( ll_row )
		dw_current_edit.scrolltorow( ll_row )
//		dw_current_edit.setcolumn( "sheet_skid_skid_pieces")
		//ls_pcs = dw_current_edit.gettext( )
		//ll_pcs = Long(ls_pcs)
		//ll_pcs = ll_pcs + ai_pcs
//		dw_current_edit.settext( string(ai_count ))
//		dw_current_edit.accepttext( )
	if of_data_validation( ll_row ) <> 0 then
		return 1
	end if
//end if


//messagebox("","validation")
//li_rc = this.of_messagebox( "Done skid question", "Finishing skid", "Is this skid a finished skid? Answer No will save as unfinished skid.", Question!, YesNoCancel!, 1)
//if li_rc = 1 then
//if ll_row = il_current_row then &
		dw_current_edit.object.sheet_skid_skid_sheet_status[ll_row] = 5
		dw_current_edit.object.stacker[ll_row] = -1
//elseif li_rc = 2 then
//		dw_current_edit.object.sheet_skid_skid_sheet_status[il_current_row] = 14
//else
//		return 1
//end if
//		
//int li_offset
//li_offset = Integer(em_offset.text)
//
//if li_offset <> 0 and li_offset > -50 and li_offset < 50 then
//	of_add_current_skid_pieces(li_offset)
//end if
//

//dw_current_edit.object.sheet_skid_skid_pieces[il_current_row] = dw_current_edit.object.sheet_skid_skid_pieces[il_current_row] + li_offset
//dw_skid_item.object.skid_status[ll_row] = 0

//dw_skid_item.object.sheet_skid_skid_sheet_status[il_current_row] = 5

of_retrieve_skid_net_wt( )

if dw_skid_item.of_update( true, true) = 1 then
	sqlca.of_commit( )
else
	sqlca.of_rollback( )
	MessageBox("Done skid", "Save failed!")
	return 1
end if
il_current_row = 0

em_offset.text = "0"
dw_current_edit.enabled = false
dw_current_edit.sharedataoff( )

ii_working_stacker = 0
return 0



//if dw_current_skid.rowcount( ) <> 1 then
//			MessageBox("Current skid not available", "Current skid not available, please load it first!", StopSign!)
//			//dw_skid_item.accepttext( ) // Save skids changes
//			//dw_skid_item.of_retrieve( )
//			return 1
//end if
//
//if dw_current_skid.getitemnumber( 1, "init_status") = 1 then
//	of_save_current_skid_new( )
//elseif dw_current_skid.getitemnumber( 1, "init_status") = 15 then
//	of_save_current_skid_partial_single_item( )
//else
//	of_save_current_skid_partial( )
//end if
//

end function

public subroutine of_stacker1_count (integer ai_count);long ll_row
ll_row = dw_skid_item.find( "stacker=1 and sheet_skid_skid_sheet_status=1", 1, dw_skid_item.rowcount( ) )
//messagebox("", string(ll_row))
if ll_row > 0 then
	if dw_current_edit.rowcount( ) < 1 then &
		dw_skid_item.sharedata( dw_current_edit )
		dw_current_edit.enabled = true
		dw_current_edit.setrow( ll_row )
		il_current_row = ll_row
		dw_current_edit.scrolltorow( ll_row )
		dw_current_edit.setcolumn( "sheet_skid_skid_pieces")
		//ls_pcs = dw_current_edit.gettext( )
		//ll_pcs = Long(ls_pcs)
		//ll_pcs = ll_pcs + ai_pcs
		dw_current_edit.settext( string(ai_count ))
		dw_current_edit.accepttext( )
end if
end subroutine

public subroutine of_stacker2_count (integer ai_count);long ll_row
ll_row = dw_skid_item.find( "stacker=2 and sheet_skid_skid_sheet_status=1", 1, dw_skid_item.rowcount( ) )
if ll_row > 0 then
	if dw_current_edit.rowcount( ) < 1 then &
		dw_skid_item.sharedata( dw_current_edit )
		dw_current_edit.enabled = true
		dw_current_edit.setrow( ll_row )
		il_current_row = ll_row
		dw_current_edit.scrolltorow( ll_row )
		dw_current_edit.setcolumn( "sheet_skid_skid_pieces")
		//ls_pcs = dw_current_edit.gettext( )
		//ll_pcs = Long(ls_pcs)
		//ll_pcs = ll_pcs + ai_pcs
		dw_current_edit.settext( string(ai_count ))
		dw_current_edit.accepttext( )
end if
end subroutine

public subroutine of_print_skid_ticket (long al_skid_num, long al_net, long al_tare, long al_job);String lstr_customer_name, lstr_end_user ,lstr_alloy, lstr_temper,lstr_sheet_type, ls_shift
double ld_gauge, ld_length, ld_width
long ll_order_num, ll_shift
int li_order_item_num, li_skid_seq
DateTime ldt_t
Datastore lds_skid
		lds_skid = create datastore
		lds_skid.dataobject = "d_skid_ticket_new"
		lds_skid.settransobject( sqlca)
		lds_skid.retrieve( al_skid_num)
		
	ldt_t = DateTime(Today(),Now())	
		
  SELECT "CUSTOMER_A"."CUSTOMER_SHORT_NAME", "CUSTOMER_B"."CUSTOMER_SHORT_NAME", "ORDER_ITEM"."ALLOY2","ORDER_ITEM"."TEMPER","ORDER_ITEM"."GAUGE","ORDER_ITEM"."SHEET_TYPE","AB_JOB"."ORDER_ITEM_NUM","AB_JOB"."ORDER_ABC_NUM" 
    INTO :lstr_customer_name  , :lstr_end_user,:lstr_alloy, :lstr_temper, :ld_gauge, :lstr_sheet_type, :li_order_item_num, :ll_order_num
    FROM "AB_JOB",   
         "CUSTOMER" "CUSTOMER_A",
			"CUSTOMER" "CUSTOMER_B",
         "CUSTOMER_ORDER",   
         "ORDER_ITEM"  
   WHERE ( "ORDER_ITEM"."ORDER_ABC_NUM" = "CUSTOMER_ORDER"."ORDER_ABC_NUM" ) and  
         ( "ORDER_ITEM"."ORDER_ITEM_NUM" = "AB_JOB"."ORDER_ITEM_NUM" ) and  
         ( "ORDER_ITEM"."ORDER_ABC_NUM" = "AB_JOB"."ORDER_ABC_NUM" ) and
			( "CUSTOMER_A"."CUSTOMER_ID" = "CUSTOMER_ORDER"."ORIG_CUSTOMER_ID" ) and  
         ( "CUSTOMER_B"."CUSTOMER_ID" = "CUSTOMER_ORDER"."ENDUSER_ID" ) and
			( "AB_JOB"."AB_JOB_NUM" = :al_job )   ;
		
		choose case UPPER(trim(lstr_sheet_type))
//	case "CHEVRON"
//		SELECT "CHEVRON"."CH_LENGTH",
//         	"CHEVRON"."CH_WIDTH",
//    	INTO :ld_length,
//         	:ld_width
//    	FROM "CHEVRON"  
//   	WHERE ( "CHEVRON"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
//         ( "CHEVRON"."ORDER_ABC_NUM" = :ll_order_num ) 
//			;
	case "CIRCLE"
		SELECT "CIRCLE"."C_DIAMETER",   
         "CIRCLE"."C_DIAMETER"
    	INTO :ld_length,
         	:ld_width
    	FROM "CIRCLE"  
   	WHERE ( "CIRCLE"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
         ( "CIRCLE"."ORDER_ABC_NUM" = :ll_order_num )   
           ;
	case "FENDER"
			SELECT "FENDER"."FE_LENGTH", 
        			 "FENDER"."FE_SIDE"
    	INTO :ld_length,
         	:ld_width
    		FROM "FENDER"  
   		WHERE ( "FENDER"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
         	( "FENDER"."ORDER_ABC_NUM" = :ll_order_num ) ;
	
	case "LIFTGATE"
		SELECT "LIFTGATE_SHAPE"."LI_LENGTH",
         	"LIFTGATE_SHAPE"."LI_WIDTH"
    	INTO :ld_length,
         	:ld_width
    		FROM "LIFTGATE_SHAPE"  
   		WHERE ( "LIFTGATE_SHAPE"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
         	( "LIFTGATE_SHAPE"."ORDER_ABC_NUM" = :ll_order_num ) ;
	case "OTHER"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO :ld_length,   
         	:ld_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :ll_order_num );
	case "PARALLELOGRAM"
		SELECT "PARALLELOGRAM"."P_LENGTH",
         	"PARALLELOGRAM"."P_WIDTH"
    	INTO :ld_length,
         	:ld_width
    		FROM "PARALLELOGRAM"  
   		WHERE ( "PARALLELOGRAM"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
         	( "PARALLELOGRAM"."ORDER_ABC_NUM" = :ll_order_num ) ;
	case "RECTANGLE"
		SELECT "RECTANGLE"."RT_LENGTH",
         	"RECTANGLE"."RT_WIDTH"
    	INTO :ld_length,
         	:ld_width
    		FROM "RECTANGLE"  
   		WHERE ( "RECTANGLE"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
         	( "RECTANGLE"."ORDER_ABC_NUM" = :ll_order_num ) ;
//	case "REINFORCEMENT"
//		SELECT "REINFORCEMENT"."RE_LENGTH",
//        		 "REINFORCEMENT"."RE_WIDTH",
//    	INTO :ld_length,
//         	:ld_width
//    		FROM "REINFORCEMENT"  
//   		WHERE ( "REINFORCEMENT"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
//         	( "REINFORCEMENT"."ORDER_ABC_NUM" = :ll_order_num ) ;
//	case "TRAPEZOID"
//		SELECT "TRAPEZOID"."TR_LONG_LENGTH",
//         	"TRAPEZOID"."TR_WIDTH",
//    	INTO :ld_length,
//         	:ld_width
//    		FROM "TRAPEZOID"  
//   		WHERE ( "TRAPEZOID"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
//         	( "TRAPEZOID"."ORDER_ABC_NUM" = :ll_order_num ) ;
	case "X SHAPE"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO :ld_length,   
         	:ld_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :li_order_item_num ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :ll_order_num ) ;
	case else
		//
end choose

		SELECT  "SHIFT"."SCHEDULE_TYPE"
		INTO :ll_shift
		FROM "SHIFT","PRODUCTION_SHEET_ITEM"
		where ("SHIFT"."SHIFT_NUM" =  "PRODUCTION_SHEET_ITEM"."SHIFT_NUM") and
                              "PRODUCTION_SHEET_ITEM"."PROD_ITEM_DATE" = ( select MAX("PRODUCTION_SHEET_ITEM"."PROD_ITEM_DATE") 
                                                                                                         FROM "PRODUCTION_SHEET_ITEM",  "SHEET_SKID_DETAIL"  
                                                                                                          WHERE ( "SHEET_SKID_DETAIL"."SHEET_SKID_NUM" = :al_skid_num ) and  
                                              ( "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" = "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" ) )
		USING SQLCA;

CHOOSE CASE ll_shift
               CASE 1
                              ls_shift = "1st Shift"
               CASE 2
                              ls_shift = "2nd Shift"
               CASE 3
                              ls_shift = "3rd Shift"
               CASE ELSE
                              ls_shift = " - "
END CHOOSE
		
		SELECT "SHEET_SKID"."SKID_SEQ_FOR_JOB" 
    		INTO :li_skid_seq  
    	FROM "SHEET_SKID"  
   	WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :al_skid_num;
	
			
			lds_skid.object.t_skid_seq.text = string(li_skid_seq)
	
		
		//Set Job and Coil info
		lds_skid.object.t_customer.text = lstr_customer_name
		lds_skid.object.t_enduser.text = "End User: " + lstr_end_user
		lds_skid.object.t_skid_num_b.text = "*S" + string(al_skid_num) + "*"
		lds_skid.object.t_skid_num_t.text = string(al_skid_num)
		lds_skid.object.t_job.text = string(al_job )
		lds_skid.object.t_alloy.text = lstr_alloy
		lds_skid.object.t_temper.text = lstr_temper
		lds_skid.object.t_gage.text = string(ld_gauge )
		lds_skid.object.t_width.text = string(ld_width )
		lds_skid.object.t_length.text = string(ld_length )
		lds_skid.object.t_gross_wt.text = string((al_net + al_tare))
		lds_skid.object.t_net.text = string(al_net)
		lds_skid.object.t_tare.text = string(al_tare)
		lds_skid.object.t_date.text = "Date: " + string(ldt_t, "MM/DD/YYYY")
		lds_skid.object.t_shift.text = ls_shift
		lds_skid.print( )

////Old print ticket function no working when job changed same coil
//Datastore lds_skid
//		lds_skid = create datastore
//		lds_skid.dataobject = "d_skid_ticket"
//		lds_skid.settransobject( sqlca)
//		lds_skid.retrieve( al_skid_num)
//		
//		//Set Job and Coil info
//		lds_skid.object.t_customer.text = iu_coil.of_get_customer_name( )
//		lds_skid.object.t_skid_num_b.text = "*S" + string(al_skid_num) + "*"
//		lds_skid.object.t_skid_num_t.text = string(al_skid_num)
//		lds_skid.object.t_job.text = string(al_job)
//		lds_skid.object.t_alloy.text = iu_coil.of_get_alloy()
//		lds_skid.object.t_temper.text = iu_coil.of_get_temper()
//		lds_skid.object.t_gage.text = string(iu_coil.of_get_gauge( ))
//		lds_skid.object.t_width.text = string(iu_coil.of_get_part_width( ))
//		lds_skid.object.t_length.text = string(iu_coil.of_get_part_length( ))
//		lds_skid.object.t_gross_wt.text = string((al_net + al_tare))
//		lds_skid.object.t_net.text = string(al_net)
//		lds_skid.object.t_tare.text = string(al_tare)
//		lds_skid.print( )
////		End of old print function	
end subroutine

public function integer of_set_theo_2_partial_at_coil_end ();//Return 1 if ok
long ll_rows, ll_i, ll_net_wt, ll_skid_id, ll_net_change, ll_item_nw, ll_tare, ll_old_net
int li_status
ll_rows = dw_skid_item.rowcount( )
if ll_rows < 1 then return 0

for ll_i=1 to ll_rows
	ll_net_wt = dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_i]
	li_status = dw_skid_item.object.sheet_skid_skid_sheet_status[ll_i]
	if ll_net_wt = 0 and li_status = 1 then
		ll_skid_id = dw_skid_item.object.sheet_skid_sheet_skid_num[ll_i]
		
//		  SELECT "SHEET_SKID"."SHEET_NET_WT", "SHEET_SKID"."SHEET_TARE_WT" 
//    		INTO :ll_net_wt, :ll_tare 
//    		FROM "SHEET_SKID"  
//   		WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_id   ;
			ll_net_wt = dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_i]
		if (not isNull(ll_net_wt)) and ll_net_wt > 0 then
			
			ll_net_change = ll_net_wt -  dw_skid_item.object.compute_0010[ll_i]
			ll_item_nw = dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_i] + ll_net_change
			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_i] = ll_item_nw
			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_i] = ll_net_wt
			dw_skid_item.object.compute_0010[ll_i] = ll_net_wt
//			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_i] = ll_tare
//			dw_skid_item.setrow( ll_i )
//			dw_skid_item.setcolumn( "sheet_skid_sheet_net_wt")
//			dw_skid_item.settext( string(ll_net_wt ))
//			dw_skid_item.accepttext( )
		end if
		
//		if (not isNull(ll_tare)) and ll_tare > 0 then
//			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_i] = ll_tare
//		end if
		
	end if
next
return 1
end function

public function integer of_add_nonconfirming (integer ai_pcs, long al_wt, integer ai_status);Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num

//

dw_nonconf.of_retrieve( )

long ll_tare_wt, ll_skid_seq, ll_prod_item_seq, ll_row, ll_job, ll_order_num, ll_rc,ll_coil_num
Int li_order_item, li_status
string ls_test
long ll_item_pieces, ll_skid_theo_wt, ll_shift_num
Double ld_theo_unit_wt

ll_tare_wt = 0
ll_skid_seq = 0
ll_prod_item_seq = 0
ll_item_pieces = 0
ll_job = iu_coil.get_current_job( )
ii_working_stacker = 0


	if ll_tare_wt >= 0 then
		
		SELECT sheet_skid_num_seq.NEXTVAL INTO :ll_skid_seq FROM DUAL;
		SELECT prod_item_num_seq.NEXTVAL INTO :ll_prod_item_seq FROM DUAL;
		
		if ll_skid_seq < 1000 or ll_prod_item_seq < 1000 then
			MessageBox("Database error", "Error getting seq numbers", Stopsign!)
			return 1
		end if
		
		ll_job = iu_coil.get_current_job( )
		ll_order_num = iu_coil.of_get_order_num( )
		li_order_item = iu_coil.of_get_order_item( )

		
		int li_nonconf_rc, li_j
		li_nonconf_rc = dw_nonconf.rowcount( )
		
		for li_j=1 to li_nonconf_rc
			if dw_nonconf.object.ab_job_nonconforming[li_j] = 1 then
				ll_job = dw_nonconf.object.process_coil_ab_job_num[li_j]
				ll_order_num = dw_nonconf.object.ab_job_order_abc_num[li_j]
				li_order_item = dw_nonconf.object.ab_job_order_item_num[li_j]
				EXIT
			end if
		next

		ls_test = "Nonconf-skid"
		ll_coil_num = iu_coil.get_coil_abc_id( )
		li_status = ai_status
		ll_shift_num = iu_coil.of_get_shift_id( )
		ll_skid_theo_wt = al_wt
		ld_theo_unit_wt = iu_coil.of_get_theo_piece_wt( )
		
		INSERT INTO "SHEET_SKID"  
         ( "SHEET_SKID_NUM",   
           "AB_JOB_NUM",   
           "SHEET_NET_WT",   
           "SHEET_TARE_WT",   
           "SKID_EDI856_DATE",   
           "SKID_LOCATION",   
           "SKID_DATE",   
           "SKID_SHEET_STATUS",   
           "SKID_PIECES",   
           "SHEET_THEORETICAL_WT",   
           "SKID_FROM_IF_WHED",   
           "SKID_TICKET_IF_WHED",   
           "REF_ORDER_ABC_NUM",   
           "SKID_TYPE_IF_WHED",   
           "REF_ORDER_ABC_ITEM",   
           "SKID_SHEET_STATUS_HELD_BY_QC" )  
  VALUES ( :ll_skid_seq,
  			  :ll_job,
			  :al_wt,   
           :ll_tare_wt,   
           null,   
           :ls_test,   
           SYSDATE,   
        		5 ,   
           :ai_pcs,   
           :al_wt ,   
           null,   
           null,   
           :ll_order_num,   
           null,   
           :li_order_item,//);
           null);
	ll_rc = sqlca.sqlcode
 	if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert Sheet_skid!")
		return ll_rc
	end if
	
	//Sleep(1)
	
		INSERT INTO "PRODUCTION_SHEET_ITEM"  
         ( "PROD_ITEM_NUM",   
           "COIL_ABC_NUM",   
           "AB_JOB_NUM",   
           "PROD_ITEM_STATUS",   
           "PROD_ITEM_PIECES",   
           "PROD_ITEM_NET_WT",   
           "PROD_ITEM_THEORETICAL_WT",   
           "PROD_ITEM_EDI870_DATE",   
           "PROD_ITEM_DATE",   
           "PROD_ITEM_NOTE",   
           "PROD_ITEM_PLACEMENT",
			  "SHIFT_NUM")  
  VALUES ( :ll_prod_item_seq,   
           :ll_coil_num,   
           :ll_job,   
           :li_status,   
           :ai_pcs,   
           :ll_skid_theo_wt ,   
           :ll_skid_theo_wt ,   
           null,   
           sysdate,   
           :ls_test,   
           null,
			  :ll_shift_num)  ;
			  
			  ll_rc = sqlca.sqlcode
 	if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert Production_sheet_item!")
		return ll_rc
	end if

	
	INSERT INTO "SHEET_SKID_DETAIL"  
         ( "PROD_ITEM_NUM",   
           "SHEET_SKID_NUM" )  
  		VALUES ( :ll_prod_item_seq ,   
           :ll_skid_seq )  ;
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert Sheet_skid_detail!")
		return ll_rc
	end if
	
	
			//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
			li_rtn = f_insert_sheet_skid_package(ll_job, ll_skid_seq, sqlca)
			
			If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package(). Error message is in this function.
				rollback using sqlca;
				Return li_rtn
			End If
			//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

		
			
			
			sqlca.of_commit( )
			
			ll_row = dw_skid_item.insertrow( 0 )
			dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare_wt
			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = al_wt
			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = ai_pcs
			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = al_wt
			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = ai_pcs
			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = 5
			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = al_wt
			dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
			dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job
			dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = al_wt
			dw_skid_item.object.production_sheet_item_prod_item_status[ll_row] = ai_status
			dw_skid_item.object.compute_0010[ll_row] = al_wt
			dw_skid_item.object.compute_0014[ll_row] = ai_pcs
			dw_skid_item.object.item_status[ll_row] = 1
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
			dw_skid_item.object.skid_status[ll_row] = 5
			dw_skid_item.object.order_item_theoretical_unit_wt[ll_row] = ld_theo_unit_wt
			dw_skid_item.object.stacker[ll_row] = 0
			DWItemStatus ldw_status
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			
//			dw_current_edit.enabled = true
//			dw_current_edit.scrolltorow( ll_row)
//			il_current_row = ll_row
//			dw_skid_item.selectrow( 0, false)
//			ll_row = dw_current_skid.insertrow( 0 )
//			dw_current_skid.setitem( ll_row, "serialno", ll_skid_seq)
//			dw_current_skid.setitem( ll_row, "pieces", 0)
//			dw_current_skid.setitem( ll_row, "theowgt", iu_coil.of_get_theo_piece_wt() )
//			dw_current_skid.setitem( ll_row, "prod_item_num", ll_prod_item_seq )
//			dw_current_skid.setitem( ll_row, "prod_item_pieces", 0 )
//			dw_current_skid.setitem( ll_row, "tare", ll_tare_wt )
//			dw_current_skid.setitem( ll_row, "status", 7 )
//			dw_current_skid.setitem( ll_row, "init_status", 1)
//			dw_current_skid.object.init_skid_nw[ll_row] = 0
//			if not isValid( ids_dim_check ) then
//				//long ll_dim_row
//				ids_dim_check = create n_ds
//				ids_dim_check.DataObject = "d_skid_dim_check"
//				ids_dim_check.of_SetTransObject(SQLCA)
//				ll_dim_row = ids_dim_check.insertrow( 0 )
//				ids_dim_check.object.sheet_skid_num[ ll_dim_row ] = ll_skid_seq 
//			else
//				destroy ids_dim_check
//				ids_dim_check = create n_ds
//				ids_dim_check.DataObject = "d_skid_dim_check"
//				ids_dim_check.of_SetTransObject(SQLCA)
//				ll_dim_row = ids_dim_check.insertrow( 0 )
//				ids_dim_check.object.sheet_skid_num[ ll_dim_row ] = ll_skid_seq
//			end if
//			iu_coil.of_get_sheet_window( ).wf_set_opc_abskid( ll_skid_seq, ii_working_stacker )
			//em_offset.text = "0"
	end if
//end if













return 0

//long ll_tare_wt, ll_skid_seq, ll_prod_item_seq, ll_row, ll_job, ll_order_num, ll_rc,ll_coil_num
//Int li_order_item, li_status,li_i_status
//string ls_test
//long ll_item_pieces, ll_skid_theo_wt, ll_shift_num
//Double ld_theo_unit_wt
//long ll_skid_nw, ll_skid_pieces, ll_item_nw, ll_item_theo
//ll_tare_wt = 0
//ll_skid_seq = 0
//ll_prod_item_seq = 0
//ll_item_pieces = 0
//ll_job = il_job
//	ll_tare_wt = 0
//
//dw_skid_edit.accepttext( )
//if dw_skid_edit.rowcount( ) <> 1 then return 1
//if of_skid_validation( ) <> 0 then return 1
//		SELECT sheet_skid_num_seq.NEXTVAL INTO :ll_skid_seq FROM DUAL;
//		SELECT prod_item_num_seq.NEXTVAL INTO :ll_prod_item_seq FROM DUAL;
//		
//		if ll_skid_seq < 1000 or ll_prod_item_seq < 1000 then
//			MessageBox("Database error", "Error getting seq numbers", Stopsign!)
//			return 1
//		end if
//		ls_test = "new-skid"
//		ll_order_num = il_order_num
//		li_order_item = ii_order_item
//		ll_coil_num = il_coil
//		ll_skid_nw = dw_skid_edit.object.sheet_skid_sheet_net_wt[1]
//			li_status = dw_skid_edit.object.sheet_skid_skid_sheet_status[1]
//			li_i_status = dw_skid_edit.object.production_sheet_item_prod_item_status[1]
//			ll_skid_pieces = dw_skid_edit.object.sheet_skid_skid_pieces[1]
//			ll_skid_theo_wt = dw_skid_edit.object.sheet_skid_sheet_theoretical_wt[1]
//			ll_item_pieces = dw_skid_edit.object.production_sheet_item_prod_item_pieces[1]
//			ll_item_nw = dw_skid_edit.object.production_sheet_item_prod_item_net_wt[1]
//			ll_item_theo = dw_skid_edit.object.production_sheet_item_prod_item_theoretical_wt[1]
//			ll_tare_wt = dw_skid_edit.object.sheet_skid_sheet_tare_wt[1]
//		
//			ll_skid_nw = dw_skid_edit.object.sheet_skid_sheet_net_wt[1]
//			li_status = dw_skid_edit.object.sheet_skid_skid_sheet_status[1]
//			ll_skid_pieces = dw_skid_edit.object.sheet_skid_skid_pieces[1]
//			ll_skid_theo_wt = dw_skid_edit.object.sheet_skid_sheet_theoretical_wt[1]
//			ll_item_pieces = dw_skid_edit.object.production_sheet_item_prod_item_pieces[1]
//			ll_item_nw = dw_skid_edit.object.production_sheet_item_prod_item_net_wt[1]
//			ll_item_theo = dw_skid_edit.object.production_sheet_item_prod_item_theoretical_wt[1]
//			ll_tare_wt = dw_skid_edit.object.sheet_skid_sheet_tare_wt[1]
//			INSERT INTO "SHEET_SKID"  
//         ( "SHEET_SKID_NUM",   
//           "AB_JOB_NUM",   
//           "SHEET_NET_WT",   
//           "SHEET_TARE_WT",   
//           "SKID_EDI856_DATE",   
//           "SKID_LOCATION",   
//           "SKID_DATE",   
//           "SKID_SHEET_STATUS",   
//           "SKID_PIECES",   
//           "SHEET_THEORETICAL_WT",   
//           "SKID_FROM_IF_WHED",   
//           "SKID_TICKET_IF_WHED",   
//           "REF_ORDER_ABC_NUM",   
//           "SKID_TYPE_IF_WHED",   
//           "REF_ORDER_ABC_ITEM",   
//           "SKID_SHEET_STATUS_HELD_BY_QC" )  
//  VALUES ( :ll_skid_seq,
//  			  :ll_job,
//			  :ll_skid_nw,   
//           :ll_tare_wt,   
//           null,   
//           :ls_test,   
//           SYSDATE,   
//        		:li_status,   
//           :ll_skid_pieces,   
//           :ll_skid_theo_wt,   
//           null,   
//           null,   
//           :ll_order_num,   
//           null,   
//           :li_order_item,//);
//           null);
//	ll_rc = sqlca.sqlcode
// 	if ll_rc <> 0 then
//		sqlca.of_rollback( ) ;
//		MessageBox("Database error", "Error insert Sheet_skid!")
//		return ll_rc
//	end if
//	
//	
//		INSERT INTO "PRODUCTION_SHEET_ITEM"  
//         ( "PROD_ITEM_NUM",   
//           "COIL_ABC_NUM",   
//           "AB_JOB_NUM",   
//           "PROD_ITEM_STATUS",   
//           "PROD_ITEM_PIECES",   
//           "PROD_ITEM_NET_WT",   
//           "PROD_ITEM_THEORETICAL_WT",   
//           "PROD_ITEM_EDI870_DATE",   
//           "PROD_ITEM_DATE",   
//           "PROD_ITEM_NOTE",   
//           "PROD_ITEM_PLACEMENT",
//			  "SHIFT_NUM")  
//  VALUES ( :ll_prod_item_seq,   
//           :ll_coil_num,   
//           :ll_job,   
//           :li_i_status,   
//           :ll_item_pieces,   
//           :ll_item_nw ,   
//           :ll_item_theo ,   
//           null,   
//           sysdate,   
//           :ls_test,   
//           null,
//			  null )  ;
//			  
//			  ll_rc = sqlca.sqlcode
// 	if ll_rc <> 0 then
//		sqlca.of_rollback( ) ;
//		MessageBox("Database error", "Error insert Production_sheet_item!")
//		return ll_rc
//	end if
//
//	
//	INSERT INTO "SHEET_SKID_DETAIL"  
//         ( "PROD_ITEM_NUM",   
//           "SHEET_SKID_NUM" )  
//  		VALUES ( :ll_prod_item_seq ,   
//           :ll_skid_seq )  ;
//	ll_rc = sqlca.sqlcode
//	if ll_rc <> 0 then
//		sqlca.of_rollback( )
//		MessageBox("Database error", "Error insert Sheet_skid_detail!")
//		return ll_rc
//	end if
//			sqlca.of_commit( )
//	
//	ll_row = dw_skid_list.rowcount( ) + 1
//	dw_skid_edit.rowscopy( 1, 1, Primary!, dw_skid_list, ll_row , Primary!)
//	dw_skid_list.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
//	dw_skid_list.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
//	
//			dw_skid_list.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
//			dw_skid_list.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
//	DWItemStatus ldw_status
//	
//	ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
////	MessageBox("ldw_status",string(ldw_status) )
//	dw_skid_list.setitemstatus( ll_row, 0, Primary!, NotModified!)
//	ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
//	dw_skid_list.setitemstatus( ll_row, 0, Primary!, DataModified!)
//	ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
//	dw_skid_list.setitemstatus( ll_row, 0, Primary!, NotModified!)
//	ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
//	
////	MessageBox("ldw_status", string(dw_skid_list.of_updatespending( )) )//string(ldw_status) )
//
//////		else //return cancel
////			dw_skid_list.deleterow( ll_row )
////		end if
//		
//		parent.postevent( "ue_refresh")
//	dw_skid_edit.reset( )
//	cb_skid_add.enabled = false
//	ll_row = dw_skid_edit.insertrow( 0 )
//
////			dw_skid_edit.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
//			dw_skid_edit.object.sheet_skid_sheet_tare_wt[ll_row] = 0
//			dw_skid_edit.object.sheet_skid_sheet_net_wt[ll_row] = 0
//			dw_skid_edit.object.sheet_skid_skid_pieces[ll_row] = 0
//			dw_skid_edit.object.sheet_skid_sheet_theoretical_wt[ll_row] = 0
//			dw_skid_edit.object.production_sheet_item_prod_item_pieces[ll_row] = 0
//			dw_skid_edit.object.sheet_skid_skid_sheet_status[ll_row] = 5
//			dw_skid_edit.object.production_sheet_item_prod_item_net_wt[ll_row] = 0
//			dw_skid_edit.object.production_sheet_item_coil_abc_num[ll_row] = il_coil
//			dw_skid_edit.object.production_sheet_item_ab_job_num[ll_row] = il_job
////			dw_skid_edit.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
//			dw_skid_edit.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = 0
//			dw_skid_edit.object.compute_0010[ll_row] = 0
//			dw_skid_edit.object.compute_0014[ll_row] = 0
//			dw_skid_edit.object.item_status[ll_row] = 1
//			dw_skid_edit.object.skid_status[ll_row] = 1
////			dw_skid_edit.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
////			dw_skid_edit.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
////			dw_skid_edit.object.skid_status[ll_row] = 1
//			dw_skid_edit.object.order_item_theoretical_unit_wt[ll_row] = id_theo_unit_wt
////	end if
////end if
//
//
////=========================================Old add skid==================================
////long ll_tare_wt, ll_skid_seq, ll_prod_item_seq, ll_row, ll_job, ll_order_num, ll_rc,ll_coil_num
////Int li_order_item, li_status
////string ls_test
////long ll_item_pieces, ll_skid_theo_wt, ll_shift_num
////Double ld_theo_unit_wt
////long ll_skid_nw, ll_skid_pieces, ll_item_nw, ll_item_theo
////ll_tare_wt = 0
////ll_skid_seq = 0
////ll_prod_item_seq = 0
////ll_item_pieces = 0
////ll_job = il_job
////if not isValid( iw_tare ) then
////	ll_tare_wt = 0
////	if ll_tare_wt >= 0 then
////		SELECT sheet_skid_num_seq.NEXTVAL INTO :ll_skid_seq FROM DUAL;
////		SELECT prod_item_num_seq.NEXTVAL INTO :ll_prod_item_seq FROM DUAL;
////		
////		if ll_skid_seq < 1000 or ll_prod_item_seq < 1000 then
////			MessageBox("Database error", "Error getting seq numbers", Stopsign!)
////			return 1
////		end if
////		ls_test = "new-skid"
////		ll_order_num = il_order_num
////		li_order_item = ii_order_item
////		ll_coil_num = il_coil
////		li_status = 5
////		ll_skid_theo_wt = 0
////		ld_theo_unit_wt = id_theo_unit_wt
////		
////			ll_row = dw_skid_list.insertrow( 0 )
////			dw_skid_list.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
////			dw_skid_list.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare_wt
////			dw_skid_list.object.sheet_skid_sheet_net_wt[ll_row] = 0
////			dw_skid_list.object.sheet_skid_skid_pieces[ll_row] = 0
////			dw_skid_list.object.sheet_skid_sheet_theoretical_wt[ll_row] = 0
////			dw_skid_list.object.production_sheet_item_prod_item_pieces[ll_row] = 0
////			dw_skid_list.object.sheet_skid_skid_sheet_status[ll_row] = li_status
////			dw_skid_list.object.production_sheet_item_prod_item_net_wt[ll_row] = 0
////			dw_skid_list.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
////			dw_skid_list.object.production_sheet_item_ab_job_num[ll_row] = ll_job
////			dw_skid_list.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
////			dw_skid_list.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = 0
////			dw_skid_list.object.compute_0010[ll_row] = 0
////			dw_skid_list.object.compute_0014[ll_row] = 0
////			dw_skid_list.object.item_status[ll_row] = 1
////			dw_skid_list.object.skid_status[ll_row] = 1
////			dw_skid_list.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
////			dw_skid_list.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
////			dw_skid_list.object.skid_status[ll_row] = 1
////			dw_skid_list.object.order_item_theoretical_unit_wt[ll_row] = ld_theo_unit_wt
////			
////			il_edit_row = ll_row
////		ii_skid_edit_action = 1
////		OpenWithParm(iw_da_tabpg_skid_edit, parent)
////		if message.doubleparm = 1 then // Return ok
////			ll_skid_nw = dw_skid_list.object.sheet_skid_sheet_net_wt[ll_row]
////			li_status = dw_skid_list.object.sheet_skid_skid_sheet_status[ll_row]
////			ll_skid_pieces = dw_skid_list.object.sheet_skid_skid_pieces[ll_row]
////			ll_skid_theo_wt = dw_skid_list.object.sheet_skid_sheet_theoretical_wt[ll_row]
////			ll_item_pieces = dw_skid_list.object.production_sheet_item_prod_item_pieces[ll_row]
////			ll_item_nw = dw_skid_list.object.production_sheet_item_prod_item_net_wt[ll_row]
////			ll_item_theo = dw_skid_list.object.production_sheet_item_prod_item_theoretical_wt[ll_row]
////			ll_tare_wt = dw_skid_list.object.sheet_skid_sheet_tare_wt[ll_row]
////			INSERT INTO "SHEET_SKID"  
////         ( "SHEET_SKID_NUM",   
////           "AB_JOB_NUM",   
////           "SHEET_NET_WT",   
////           "SHEET_TARE_WT",   
////           "SKID_EDI856_DATE",   
////           "SKID_LOCATION",   
////           "SKID_DATE",   
////           "SKID_SHEET_STATUS",   
////           "SKID_PIECES",   
////           "SHEET_THEORETICAL_WT",   
////           "SKID_FROM_IF_WHED",   
////           "SKID_TICKET_IF_WHED",   
////           "REF_ORDER_ABC_NUM",   
////           "SKID_TYPE_IF_WHED",   
////           "REF_ORDER_ABC_ITEM",   
////           "SKID_SHEET_STATUS_HELD_BY_QC" )  
////  VALUES ( :ll_skid_seq,
////  			  :ll_job,
////			  :ll_skid_nw,   
////           :ll_tare_wt,   
////           null,   
////           :ls_test,   
////           SYSDATE,   
////        		:li_status,   
////           :ll_skid_pieces,   
////           :ll_skid_theo_wt,   
////           null,   
////           null,   
////           :ll_order_num,   
////           null,   
////           :li_order_item,//);
////           null);
////	ll_rc = sqlca.sqlcode
//// 	if ll_rc <> 0 then
////		sqlca.of_rollback( ) ;
////		dw_skid_list.deleterow( ll_row )
////		MessageBox("Database error", "Error insert Sheet_skid!")
////		return ll_rc
////	end if
////	
////	//Sleep(1)
////	
////		INSERT INTO "PRODUCTION_SHEET_ITEM"  
////         ( "PROD_ITEM_NUM",   
////           "COIL_ABC_NUM",   
////           "AB_JOB_NUM",   
////           "PROD_ITEM_STATUS",   
////           "PROD_ITEM_PIECES",   
////           "PROD_ITEM_NET_WT",   
////           "PROD_ITEM_THEORETICAL_WT",   
////           "PROD_ITEM_EDI870_DATE",   
////           "PROD_ITEM_DATE",   
////           "PROD_ITEM_NOTE",   
////           "PROD_ITEM_PLACEMENT",
////			  "SHIFT_NUM")  
////  VALUES ( :ll_prod_item_seq,   
////           :ll_coil_num,   
////           :ll_job,   
////           :li_status,   
////           :ll_item_pieces,   
////           :ll_item_nw ,   
////           :ll_item_theo ,   
////           null,   
////           sysdate,   
////           :ls_test,   
////           null,
////			  null )  ;
////			  
////			  ll_rc = sqlca.sqlcode
//// 	if ll_rc <> 0 then
////		sqlca.of_rollback( ) ;
////		dw_skid_list.deleterow( ll_row )
////		MessageBox("Database error", "Error insert Production_sheet_item!")
////		return ll_rc
////	end if
////
////	
////	INSERT INTO "SHEET_SKID_DETAIL"  
////         ( "PROD_ITEM_NUM",   
////           "SHEET_SKID_NUM" )  
////  		VALUES ( :ll_prod_item_seq ,   
////           :ll_skid_seq )  ;
////	ll_rc = sqlca.sqlcode
////	if ll_rc <> 0 then
////		sqlca.of_rollback( )
////		dw_skid_list.deleterow( ll_row )
////		MessageBox("Database error", "Error insert Sheet_skid_detail!")
////		return ll_rc
////	end if
////			sqlca.of_commit( )
////			DWItemStatus ldw_status
////			ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
////			dw_skid_list.setitemstatus( ll_row, 0, Primary!, NotModified!)
////			ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
////			dw_skid_list.setitemstatus( ll_row, 0, Primary!, DataModified!)
////			ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
////			dw_skid_list.setitemstatus( ll_row, 0, Primary!, NotModified!)
////			ldw_status = dw_skid_list.getitemstatus( ll_row, 0, Primary!)
////
////
////		else //return cancel
////			dw_skid_list.deleterow( ll_row )
////		end if
////		
////		parent.postevent( "ue_refresh")
////		
////	end if
////end if
end function

on u_da_skid_tabpg.create
int iCurrent
call super::create
this.cb_quality=create cb_quality
this.dw_nonconf=create dw_nonconf
this.cb_1=create cb_1
this.cb_restack=create cb_restack
this.st_stacker=create st_stacker
this.st_3=create st_3
this.cb_reset_pcs=create cb_reset_pcs
this.st_offset=create st_offset
this.em_offset=create em_offset
this.cb_retrieve=create cb_retrieve
this.cb_ref=create cb_ref
this.cb_edit=create cb_edit
this.cb_delete=create cb_delete
this.cb_print=create cb_print
this.cb_done_skid=create cb_done_skid
this.cb_load_partial=create cb_load_partial
this.cb_new_skid=create cb_new_skid
this.st_1=create st_1
this.dw_current_edit=create dw_current_edit
this.dw_skid_item=create dw_skid_item
this.cb_dim_check=create cb_dim_check
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_quality
this.Control[iCurrent+2]=this.dw_nonconf
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_restack
this.Control[iCurrent+5]=this.st_stacker
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.cb_reset_pcs
this.Control[iCurrent+8]=this.st_offset
this.Control[iCurrent+9]=this.em_offset
this.Control[iCurrent+10]=this.cb_retrieve
this.Control[iCurrent+11]=this.cb_ref
this.Control[iCurrent+12]=this.cb_edit
this.Control[iCurrent+13]=this.cb_delete
this.Control[iCurrent+14]=this.cb_print
this.Control[iCurrent+15]=this.cb_done_skid
this.Control[iCurrent+16]=this.cb_load_partial
this.Control[iCurrent+17]=this.cb_new_skid
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.dw_current_edit
this.Control[iCurrent+20]=this.dw_skid_item
this.Control[iCurrent+21]=this.cb_dim_check
this.Control[iCurrent+22]=this.st_2
end on

on u_da_skid_tabpg.destroy
call super::destroy
destroy(this.cb_quality)
destroy(this.dw_nonconf)
destroy(this.cb_1)
destroy(this.cb_restack)
destroy(this.st_stacker)
destroy(this.st_3)
destroy(this.cb_reset_pcs)
destroy(this.st_offset)
destroy(this.em_offset)
destroy(this.cb_retrieve)
destroy(this.cb_ref)
destroy(this.cb_edit)
destroy(this.cb_delete)
destroy(this.cb_print)
destroy(this.cb_done_skid)
destroy(this.cb_load_partial)
destroy(this.cb_new_skid)
destroy(this.st_1)
destroy(this.dw_current_edit)
destroy(this.dw_skid_item)
destroy(this.cb_dim_check)
destroy(this.st_2)
end on

event destructor;call super::destructor;if isValid( iw_tare ) then
	Close(iw_tare)
end if

if isValid(iw_load_partial) then
	Close( iw_load_partial )
end if

if isValid(iw_da_tabpg_skid_edit) then
	Close( iw_da_tabpg_skid_edit )
end if

if dw_skid_item.of_updatespending( ) = 1 then
	if MessageBox("Skid", "Data changed, Save it?", Exclamation!, YesNo!, 2) = 2 then
				dw_skid_item.resetupdate( )
				return 0
	end if
	of_save( )
end if
return 0
//if isValid(iw_load_scrap_tare) then
//	Close( iw_load_scrap_tare )
//end if
//
//if isValid(iw_scrap_type) then
//	Close( iw_scrap_type )
//end if
//
//if isValid(iw_dimensional_check ) then
//	Close( iw_dimensional_check )
//end if

//if isValid(iw_dimensional_check_new_skid) then
//	Close( iw_dimensional_check_new_skid )
//end if

end event

event constructor;call super::constructor;//iw_sheet = message.powerobjectparm
//if isValid( iw_sheet.iu_current_coil ) then
//	iu_coil = iw_sheet.iu_current_coil
//end if
//dw_skid_item.settransobject( sqlca)
//dw_skid_item.of_retrieve( )
//
end event

type cb_quality from u_cb within u_da_skid_tabpg
integer x = 2491
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 170
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Quality"
end type

event clicked;call super::clicked;if Not isValid( iw_da_tabpg_skid_quality ) then
	OpenWithParm(iw_da_tabpg_skid_quality, parent)
end if
end event

type dw_nonconf from u_dw within u_da_skid_tabpg
boolean visible = false
integer x = 1408
integer y = 864
integer width = 1317
integer height = 336
integer taborder = 70
boolean enabled = false
string dataobject = "d_process_coil_nonconf_job"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_setbase( true)
this.of_settransobject( sqlca)

end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( iu_coil.get_coil_abc_id( ) )
end event

type cb_1 from commandbutton within u_da_skid_tabpg
boolean visible = false
integer x = 1490
integer y = 20
integer width = 366
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "test"
end type

event clicked;//sleep(30)
//messagebox("sleep","done")
//messagebox(string( iu_coil.get_old_nw( ) ),"")

//of_add_nonconfirming( )
end event

type cb_restack from u_cb within u_da_skid_tabpg
integer x = 846
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 110
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "ReStack"
end type

event clicked;call super::clicked;s_partial_skid lstr_skid
long ll_row
int li_stacker
ll_row = dw_skid_item.getselectedrow(0)
if ll_row < 1 then
	MessageBox("ReStack skid", "Please select a skid to restack!")
	return 1
end if

lstr_skid.partial_skid_num = dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row]
lstr_skid.partial_skid_pieces = dw_skid_item.object.sheet_skid_skid_pieces[ll_row]

OpenWithParm( iw_restack_bl110, lstr_skid )
li_stacker = message.doubleparm

if li_stacker < 0 or li_stacker > 2 then return 1

if ll_row > 0 then
	if dw_current_edit.rowcount( ) < 1 then &
		dw_skid_item.sharedata( dw_current_edit )
		dw_current_edit.enabled = true
		dw_current_edit.setrow( ll_row )
		il_current_row = ll_row
		dw_current_edit.scrolltorow( ll_row )
		dw_current_edit.object.sheet_skid_skid_sheet_status[ll_row ] = 1
		dw_current_edit.object.stacker[ll_row] = li_stacker
		//dw_current_edit.setcolumn( "sheet_skid_skid_pieces")
		//ls_pcs = dw_current_edit.gettext( )
		//ll_pcs = Long(ls_pcs)
		//ll_pcs = ll_pcs + ai_pcs
		//dw_current_edit.settext( string(ai_count ))
		//dw_current_edit.accepttext( )
end if

int li_line
li_line = iu_coil.of_get_sheet_window( ).ii_line_id
choose case li_stacker
	case 1
		  UPDATE "LINE_CURRENT_STATUS"  
     		SET "SHEET_SKID_STACKER_1" = :lstr_skid.partial_skid_num
  		 WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line   
           ;
	case 2
		  UPDATE "LINE_CURRENT_STATUS"  
     		SET "SHEET_SKID_STACKER_2" = :lstr_skid.partial_skid_num
  		 WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line   
           ;
	case 0
		  UPDATE "LINE_CURRENT_STATUS"  
     		SET "SHEET_SKID_NUM" = :lstr_skid.partial_skid_num
  		 WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line   
           ;
end choose
	if sqlca.sqlcode <> 0 then
		sqlca.of_rollback( )
	else
		sqlca.of_commit( )
	end if


end event

type st_stacker from statictext within u_da_skid_tabpg
integer x = 731
integer y = 1216
integer width = 247
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean focusrectangle = false
end type

type st_3 from statictext within u_da_skid_tabpg
boolean visible = false
integer x = 485
integer y = 1216
integer width = 247
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Stacker:"
boolean focusrectangle = false
end type

type cb_reset_pcs from commandbutton within u_da_skid_tabpg
boolean visible = false
integer x = 2514
integer y = 1292
integer width = 192
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset"
end type

event clicked;//if dw_current_edit.enabled = true and dw_current_edit.rowcount( ) > 0 then
//	dw_current_edit.object.sheet_skid_skid_pieces[1] = 0
	em_offset.text = "0"
//end if


end event

type st_offset from statictext within u_da_skid_tabpg
integer x = 2071
integer y = 1292
integer width = 206
integer height = 84
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Offset"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_offset from editmask within u_da_skid_tabpg
integer x = 2277
integer y = 1292
integer width = 233
integer height = 84
integer taborder = 60
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

type cb_retrieve from u_cb within u_da_skid_tabpg
integer x = 1394
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 120
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Update wt"
end type

event clicked;call super::clicked;parent.of_retrieve_skid_net_wt( )

//if dw_skid_item.of_updatespending( ) = 1 then
//	if MessageBox("Skid edit", "Data changed, Save it?", Exclamation!, YesNo!, 2) = 2 then
//				dw_skid_item.resetupdate( )
//				//return 0
//	else
//		of_save( )
//	end if
//end if
//	dw_skid_item.of_retrieve( )
end event

type cb_ref from u_cb within u_da_skid_tabpg
integer x = 2217
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 160
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Save"
end type

event clicked;call super::clicked;//if dw_current_edit.rowcount( ) > 0 then
//	cb_done_skid.event clicked( )
//	return 1
//end if

of_save( )

//int li_rc
//
//dw_skid_item.accepttext( )
//
//if of_delete_rows() <> 1 then
//	sqlca.of_rollback( )
//	MessageBox("Delete", "Delete function failed", StopSign!)
//	return 1
//end if
//
//li_rc = dw_skid_item.of_update( true, true)
//if li_rc = 1 then
//	sqlca.of_commit( )
//else
//	sqlca.of_rollback( )
//	MessageBox("Update", "Update failed!", StopSign!)
//	return 1
//end if
//iu_coil.of_update_from_skid_scrap( )
end event

type cb_edit from u_cb within u_da_skid_tabpg
integer x = 1943
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 150
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Edit"
end type

event clicked;call super::clicked;//To do list open dim_check_for selected skid
//MessageBox("Dimensional check data", "Coming soon...")
long ll_row, ll_current_row
//ll_item = dw_skid_item.object.production_sheet_item_prod_item_num[dw_skid_item.getselectedrow(0)] 
ll_row = dw_skid_item.getselectedrow(0)
if ll_row < 1 then
	MessageBox("Edit skid", "Please select a skid to edit!")
	return 1
end if

ll_current_row = 0
//if dw_skid_item.object.skid_status[ll_row] = 1 then
if dw_current_edit.rowcount( ) > 0 then
	ll_current_row = dw_current_edit.getrow( )
end if
if ll_current_row = ll_row  then

	MessageBox("Edit skid", "Please edit data in current skid box!", Stopsign!)
	return 1
end if

il_edit_row = ll_row
if Not isValid( iw_da_tabpg_skid_edit ) then
	OpenWithParm(iw_da_tabpg_skid_edit, parent)
end if
end event

type cb_delete from u_cb within u_da_skid_tabpg
integer x = 1669
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 140
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Delete"
end type

event clicked;call super::clicked;////long ll_prod_item_num, ll_item_pieces,ll_skid_pieces,ll_skid_theo_wt,ll_item_nw,ll_skid_num,row		   
////long ll_item_theo_wt, ll_item_count
////
//			
//			
//			
//			ll_prod_item_num = dw_skid_item.object.production_sheet_item_prod_item_num[ row ]
//			ll_skid_num = dw_skid_item.object.sheet_skid_sheet_skid_num[ row ]
//			
//			DELETE FROM "SHEET_SKID_DETAIL"  
//   			WHERE "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" = :ll_prod_item_num   ;
//				if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				//else
//				//	sqlca.of_commit( )
//				end if
//		  
//		  DELETE FROM "PRODUCTION_SHEET_ITEM"  
//   		WHERE "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" = :ll_prod_item_num   ;
//				if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				//else
//				//	sqlca.of_commit( )
//				end if
//		
//		  SELECT COUNT(*) 
//    INTO :ll_item_count  
//    FROM "SHEET_SKID_DETAIL"  
//   WHERE "SHEET_SKID_DETAIL"."SHEET_SKID_NUM" = :ll_skid_num   ;
//
//	if ll_item_count > 0 then
//		
//		//ll_skid_pieces = ll_item_pieces - dw_skid_item.object.production_sheet_item_prod_item_pieces_1[row] + dw_skid_item.object.sheet_skid_skid_pieces[row]
//		//ll_skid_theo_wt = ll_skid_pieces * iu_coil.of_get_theo_piece_wt( )
//		ll_item_pieces = dw_skid_item.object.production_sheet_item_prod_item_pieces[row]
//		ll_item_nw = dw_skid_item.object.production_sheet_item_prod_item_net_wt[row]
//		ll_item_theo_wt = ll_item_pieces *iu_coil.of_get_theo_piece_wt( )
//		UPDATE "SHEET_SKID"
//		SET "SKID_PIECES" = "SKID_PIECES" - :ll_item_pieces ,   
//      	   "SHEET_THEORETICAL_WT" = "SHEET_THEORETICAL_WT" - :ll_item_theo_wt,
//				"SHEET_NET_WT" = "SHEET_NET_WT" - :ll_item_nw
//   		WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num;
//				
//	  	
//	else // Delete sheet_skid
//		  DELETE FROM "SHEET_SKID_DIMENSION_CHECK"  
//   			WHERE "SHEET_SKID_DIMENSION_CHECK"."SHEET_SKID_NUM" = :ll_skid_num    ;
//				if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				//else
//				//	sqlca.of_commit( )
//				end if
//				  DELETE FROM "SHEET_SKID"  
//   					WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num ;
//
//				
//	end if
//		  
//		  if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				else
//					sqlca.of_commit( )
//				end if
//		  
long row, ll_item_num, ll_row
		  row = dw_skid_item.getselectedrow( 0 )
			if row < 1 then
				MessageBox("Delete item", "No item selected!")
				return 1
			end if
			
//			if row = il_current_row then
//				MessageBox("Delete skid", "You can not delete current item!!", StopSign!)
//				return 1
//			end if
			
//			Testing
//			if dw_skid_item.object.stacker[row] > 0 then return 1
			
			if MessageBox("Delete item", "Do you want to delete selected item?", Exclamation!, OKCancel!, 2) = 2 then
				return 0
			end if
			ll_item_num = dw_skid_item.object.production_sheet_item_prod_item_num[row]
		  dw_skid_item.deleterow( row )
		  ll_row = dw_skid_item.find( "item_status = " + string(ll_item_num ), 1, dw_skid_item.rowcount( ) )
		  if ll_row > 0 then
			dw_skid_item.deleterow( ll_row)
			end if
		if dw_current_edit.rowcount( ) > 0 then
		  		ll_row = dw_skid_item.find( "skid_status = 1" , 1, dw_skid_item.rowcount( ))
			  		if ll_row > 0 then
						dw_current_edit.setrow( ll_row)
						dw_current_edit.scrolltorow( ll_row)
						il_current_row = ll_row
					else
						MessageBox("Delete skid", "Current skid deleted!")
						il_current_row = 0

						dw_current_edit.enabled = false
						dw_current_edit.sharedataoff( )

					end if
					
		end if

		of_save( )

//		  dw_skid_item.event pfc_deleterow( )
end event

type cb_print from u_cb within u_da_skid_tabpg
integer x = 1120
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 130
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Print"
end type

event clicked;call super::clicked;//int li_rc
//li_rc = dw_skid_item.event pfc_update( true, true)
//if li_rc = 1 then
//	sqlca.of_commit( )
//else
//	sqlca.of_rollback( )
//end if
//

//MessageBox("test", string( dw_skid_item.object.sheet_skid_sheet_net_wt_1[ dw_skid_item.rowcount( ) ] ))
long ll_skid_num, ll_row, ll_net, ll_tare, ll_job//, ll_pcs
ll_row = dw_skid_item.getselectedrow( 0 )  //getrow( )
if ll_row > 0 then
	ll_skid_num = dw_skid_item.object.sheet_skid_sheet_skid_num[ ll_row ]
	ll_net = dw_skid_item.object.sheet_skid_sheet_net_wt[ ll_row ]
	ll_tare = dw_skid_item.object.sheet_skid_sheet_tare_wt[ ll_row ]
	//ll_pcs = dw_skid_item.object.sheet_skid_skid_pieces[ ll_row ]
	ll_job = dw_skid_item.object.production_sheet_item_ab_job_num[ll_row]
	if ll_skid_num > 100000 then
		of_print_skid_ticket( ll_skid_num, ll_net, ll_tare, ll_job  )
	end if
end if
	
end event

type cb_done_skid from u_cb within u_da_skid_tabpg
integer x = 571
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Done Skid"
end type

event clicked;call super::clicked;if not dw_current_edit.enabled or dw_current_edit.rowcount( ) < 1 then
	MessageBox("Attention", "There is no current skid!", StopSign!)
	return 1
end if
int li_rc, li_seq_job
long ll_row, ll_job, ll_skid_id
ll_row = dw_current_edit.getrow( )

if dw_current_edit.object.stacker[ll_row] > 0 then
	MessageBox("Can not end an auto stacker skid", "Please complete stacking in auto stacker!")
	return 1
end if

of_retrieve_skid_net_wt( )

if of_data_validation( ll_row ) <> 0 then
	return 1
end if

li_rc = this.of_messagebox( "Done skid question", "Finishing skid", "Is this skid a finished skid? Answer No will save as unfinished skid.", Question!, YesNoCancel!, 1)
if li_rc = 1 then
		dw_current_edit.object.sheet_skid_skid_sheet_status[ll_row] = 5
elseif li_rc = 2 then
		dw_current_edit.object.sheet_skid_skid_sheet_status[ll_row] = 14
else
		return 1
end if
	dw_current_edit.object.stacker[ll_row]	= -1
int li_offset
li_offset = Integer(em_offset.text)

if li_offset <> 0 and li_offset > -50 and li_offset < 50 then
	parent.of_add_current_skid_pieces(li_offset)
end if


//dw_current_edit.object.sheet_skid_skid_pieces[il_current_row] = dw_current_edit.object.sheet_skid_skid_pieces[il_current_row] + li_offset
//dw_skid_item.object.skid_status[ll_row] = 0

//dw_skid_item.object.sheet_skid_skid_sheet_status[il_current_row] = 5

ll_job = iu_coil.get_current_job( )
ll_skid_id = dw_current_edit.object.sheet_skid_sheet_skid_num[ ll_row ]

if dw_skid_item.of_update( true, true) = 1 then
	sqlca.of_commit( )
	
//	SELECT COUNT(*)
//		INTO :li_seq_job
//		FROM SHEET_SKID
//		WHERE AB_JOB_NUM = :ll_job;
		
		SELECT //"SHEET_SKID"."SHEET_SKID_NUM",   
         //"SHEET_SKID"."AB_JOB_NUM",   
         //"SHEET_SKID"."SHEET_NET_WT",   
         "SHEET_SKID"."SKID_SEQ_FOR_JOB"  
    INTO //:skid_id,   
         //:ll_job ,   
         //:ll_nw ,   
         :li_seq_job  
    FROM "SHEET_SKID"  
   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_id   
           ;
	
		
	if isNull(li_seq_job) or li_seq_job = 0 then
		
		
		SELECT NVL(MAX("SHEET_SKID"."SKID_SEQ_FOR_JOB"),0)
		INTO :li_seq_job
		FROM "SHEET_SKID"
		WHERE "SHEET_SKID"."AB_JOB_NUM" = :ll_job;
		
		li_seq_job = li_seq_job + 1
		
		UPDATE "SHEET_SKID"  
     	SET "SKID_SEQ_FOR_JOB" = :li_seq_job 
   	WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_id 
           ;
			  if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					MessageBox("Done skid", "Failed to update SKID_SEQ_FOR_JOB!")
					return
				end if
				sqlca.of_commit( )
	end if
//		sqlca.of_commit( )
	iw_sheet.wf_set_opc_abskid( -1, 0)
else
	sqlca.of_rollback( )
	MessageBox("Done skid", "Save failed!")
	return 1
end if
il_current_row = 0

parent.em_offset.text = "0"
dw_current_edit.enabled = false
dw_current_edit.sharedataoff( )





//if dw_current_skid.rowcount( ) <> 1 then
//			MessageBox("Current skid not available", "Current skid not available, please load it first!", StopSign!)
//			//dw_skid_item.accepttext( ) // Save skids changes
//			//dw_skid_item.of_retrieve( )
//			return 1
//end if
//
//if dw_current_skid.getitemnumber( 1, "init_status") = 1 then
//	of_save_current_skid_new( )
//elseif dw_current_skid.getitemnumber( 1, "init_status") = 15 then
//	of_save_current_skid_partial_single_item( )
//else
//	of_save_current_skid_partial( )
//end if
//

end event

type cb_load_partial from u_cb within u_da_skid_tabpg
integer x = 279
integer y = 1500
integer width = 288
integer height = 108
integer taborder = 90
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Load Partial"
end type

event clicked;call super::clicked;s_partial_skid lstr_partail
long ll_skid_num, ll_prod_item_seq, ll_row, ll_tare, ll_item_pcs
int li_i, li_init_status
DataStore lds_prod_item
//	if dw_current_edit.rowcount( ) > 0 then
//			MessageBox("Current skid", "Current skid not done, please done it first!", StopSign!)
//			return 1
//	end if

if not isValid( iw_load_partial ) then
	OpenWithParm( iw_load_partial, iu_coil.get_current_job() )
	lstr_partail = message.powerobjectparm
	if lstr_partail.partial_skid_num > 1000 then
		//MessageBox("Partial skid", string( lstr_partail.partial_skid_num ))
		ll_skid_num = 	lstr_partail.partial_skid_num
		ll_tare = lstr_partail.partial_skid_tare_wt
		//SELECT sheet_skid_num_seq.NEXTVAL INTO :ll_skid_seq FROM DUAL;
		dw_skid_item.sharedata( dw_current_edit )
		lds_prod_item = Create datastore
		lds_prod_item.dataobject = "d_prod_item_for_skid"
		lds_prod_item.settransobject( sqlca)
		lds_prod_item.retrieve( ll_skid_num )
		
		ll_row = lds_prod_item.rowcount( )
		if ll_row < 1 then
			MessageBox("Error", "Invalid Partial skid!", StopSign!  )
			return 1
		//elseif ll_row = 1 then
			//
		else
			for li_i = 1 to ll_row
				if lds_prod_item.object.production_sheet_item_coil_abc_num[li_i] = iu_coil.get_coil_abc_id( ) &
					and lds_prod_item.object.production_sheet_item_ab_job_num[li_i] = iu_coil.get_current_job( ) then
					// process found same coil and job item
					li_init_status = 15
					ll_prod_item_seq = lds_prod_item.object.production_sheet_item_prod_item_num[li_i]
					ll_item_pcs = lds_prod_item.object.production_sheet_item_prod_item_pieces[li_i]
					exit
				end if
			next

		end if
		
		
	
		if li_init_status <> 15 then //Normal partial skid from other job or coil
			li_init_status = 7
			ll_item_pcs = 0
			SELECT prod_item_num_seq.NEXTVAL INTO :ll_prod_item_seq FROM DUAL;
			if sqlca.sqlcode <> 0 then
				MessageBox("Database Error", "Error getting item number!" )
				return 1
			end if
		end if
		
//		MessageBox("", string(lstr_partail.partial_skid_net_wt))
		
		if li_init_status = 15 then //Load partial with same coil and job --> to single item
			parent.of_save_current_skid_partial_single_item( lstr_partail.partial_skid_pieces, ll_skid_num, ll_tare, lstr_partail.partial_skid_pieces, ll_prod_item_seq, 1, lstr_partail.partial_skid_net_wt, ll_item_pcs )
		else // Load Partial
			parent.of_save_current_skid_partial( lstr_partail.partial_skid_pieces, ll_skid_num, ll_tare, lstr_partail.partial_skid_pieces,ll_prod_item_seq , 1, lstr_partail.partial_skid_net_wt)
		end if
		
		
			
//			ll_row = dw_current_skid.insertrow( 0 )
//			dw_current_skid.setitem( ll_row, "serialno", ll_skid_num)
//			dw_current_skid.setitem( ll_row, "pieces", lstr_partail.partial_skid_pieces )
//			dw_current_skid.setitem( ll_row, "theowgt", iu_coil.of_get_theo_piece_wt() )
//			dw_current_skid.setitem( ll_row, "prod_item_num", ll_prod_item_seq )
//			dw_current_skid.setitem( ll_row, "prod_item_pieces", ll_item_pcs )
//			dw_current_skid.setitem( ll_row, "status", 7)
//			dw_current_skid.setitem( ll_row, "init_status", li_init_status )
//			dw_current_skid.setitem( ll_row, "init_pieces", lstr_partail.partial_skid_pieces)
//			dw_current_skid.setitem( ll_row, "tare", ll_tare)
//			dw_current_skid.object.init_skid_nw[ll_row] = lstr_partail.partial_skid_net_wt
//			if not isValid( ids_dim_check ) then
//				ids_dim_check = create n_ds
//				ids_dim_check.DataObject = "d_skid_dim_check"
//				ids_dim_check.of_SetTransObject(SQLCA)
//			end if
//				ids_dim_check.retrieve( ll_skid_num )
//				if ids_dim_check.rowcount( ) < 1 then
//					ids_dim_check.insertrow( 0 )
//					ids_dim_check.object.sheet_skid_num[ 1 ] = ll_skid_num
//				end if
			ii_working_stacker = 0
			dw_skid_item.selectrow( 0, false)
			iu_coil.of_get_sheet_window( ).wf_set_opc_abskid( ll_skid_num, ii_working_stacker )
			parent.em_offset.text = "0"
	end if

end if
end event

type cb_new_skid from u_cb within u_da_skid_tabpg
integer x = 9
integer y = 1500
integer width = 270
integer height = 108
integer taborder = 80
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "New Skid"
end type

event clicked;call super::clicked;long ll_tare_wt, ll_skid_seq, ll_prod_item_seq, ll_row, ll_job, ll_order_num, ll_rc,ll_coil_num
Int li_order_item, li_status
string ls_test
long ll_item_pieces, ll_skid_theo_wt, ll_shift_num
Double ld_theo_unit_wt

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num
Integer	li_ok_2create_skids //Alex Gerlants. 09/26/2024. 2228_BL110_Disallow_Skid_Create_If_Job_Done
String	ls_job_status_desc //Alex Gerlants. 09/26/2024. 2228_BL110_Disallow_Skid_Create_If_Job_Done

//		if dw_current_edit.rowcount( ) > 0 then
////		if dw_current_edit.enabled then
//			MessageBox("Current skid", "Current skid not done, please done it first!", StopSign!)
//			return 1
//		end if
ll_tare_wt = 0
ll_skid_seq = 0
ll_prod_item_seq = 0
ll_item_pieces = 0
//dw_skid_item.sharedata( dw_current_edit )
ll_job = iu_coil.get_current_job( )

//Alex Gerlants. 09/26/2024. 2228_BL110_Disallow_Skid_Create_If_Job_Done. Begin
li_ok_2create_skids = f_ok_2create_skids(ll_job, sqlca, ls_job_status_desc)

If li_ok_2create_skids <> 1 Then
	MessageBox("Skid creation error", "Not allowed to create skids.~n~rJob status = " + ls_job_status_desc, StopSign!)
	Return 0
End If
//Alex Gerlants. 09/26/2024. 2228_BL110_Disallow_Skid_Create_If_Job_Done. End


ii_working_stacker = 0
  SELECT "AB_JOB"."JOB_TARE_WT"  
    INTO :ll_tare_wt  
    FROM "AB_JOB"  
   WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job;

if isNull( ll_tare_wt ) or ll_tare_wt = 0 then
	if not isValid( iw_tare ) then
			OpenWithParm(iw_tare, ll_job )
		ll_tare_wt = message.doubleparm
		if ll_tare_wt > 0 and ll_tare_wt < 7000 then
			if messagebox("Question", "Do you want to save " + string(ll_tare_wt) + " as default job tare weight?", Question!, YesNo!) = 1 then
					  UPDATE "AB_JOB"  
     					SET "JOB_TARE_WT" = :ll_tare_wt  
   					WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job   
           			;
						if sqlca.sqlcode<>0 then
							messagebox("Error", "Error update tare on job table!")
							return 0
						else
							sqlca.of_commit( )
						end if
			end if
		end if
		
	end if	
end if

	if ll_tare_wt > 0 then
		//handle new tare wt
		
//		if messagebox("Question", "Do you want to save " + string(ll_tare_wt) + " as default job tare weight?", Question!, YesNo!) = 1 then
//					  UPDATE "AB_JOB"  
//     					SET "JOB_TARE_WT" = :ll_tare_wt  
//   					WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job   
//           			;
//						if sqlca.sqlcode<>0 then
//							messagebox("Error", "Error update tare on job table!")
//							return 0
//						else
//							sqlca.of_commit( )
//						end if
//		end if
		
		if dw_current_edit.rowcount( ) < 1 then dw_skid_item.sharedata( dw_current_edit )
		SELECT sheet_skid_num_seq.NEXTVAL INTO :ll_skid_seq FROM DUAL;
		SELECT prod_item_num_seq.NEXTVAL INTO :ll_prod_item_seq FROM DUAL;
		
		if ll_skid_seq < 1000 or ll_prod_item_seq < 1000 then
			MessageBox("Database error", "Error getting seq numbers", Stopsign!)
			return 1
		end if
		
		ll_job = iu_coil.get_current_job( )
		ls_test = "new-skid"
		ll_order_num = iu_coil.of_get_order_num( )
		li_order_item = iu_coil.of_get_order_item( )
		ll_coil_num = iu_coil.get_coil_abc_id( )
		li_status = 2
		ll_shift_num = iu_coil.of_get_shift_id( )
		ll_skid_theo_wt = 0
		ld_theo_unit_wt = iu_coil.of_get_theo_piece_wt( )
		
		INSERT INTO "SHEET_SKID"  
         ( "SHEET_SKID_NUM",   
           "AB_JOB_NUM",   
           "SHEET_NET_WT",   
           "SHEET_TARE_WT",   
           "SKID_EDI856_DATE",   
           "SKID_LOCATION",   
           "SKID_DATE",   
           "SKID_SHEET_STATUS",   
           "SKID_PIECES",   
           "SHEET_THEORETICAL_WT",   
           "SKID_FROM_IF_WHED",   
           "SKID_TICKET_IF_WHED",   
           "REF_ORDER_ABC_NUM",   
           "SKID_TYPE_IF_WHED",   
           "REF_ORDER_ABC_ITEM",   
           "SKID_SHEET_STATUS_HELD_BY_QC" )  
  VALUES ( :ll_skid_seq,
  			  :ll_job,
			  0,   
           :ll_tare_wt,   
           null,   
           :ls_test,   
           SYSDATE,   
        		1 ,   
           0,   
           0,   
           null,   
           null,   
           :ll_order_num,   
           null,   
           :li_order_item,//);
           null);
	ll_rc = sqlca.sqlcode
 	if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert Sheet_skid!")
		return ll_rc
	end if
	
	//Sleep(1)
	
		INSERT INTO "PRODUCTION_SHEET_ITEM"  
         ( "PROD_ITEM_NUM",   
           "COIL_ABC_NUM",   
           "AB_JOB_NUM",   
           "PROD_ITEM_STATUS",   
           "PROD_ITEM_PIECES",   
           "PROD_ITEM_NET_WT",   
           "PROD_ITEM_THEORETICAL_WT",   
           "PROD_ITEM_EDI870_DATE",   
           "PROD_ITEM_DATE",   
           "PROD_ITEM_NOTE",   
           "PROD_ITEM_PLACEMENT",
			  "SHIFT_NUM")  
  VALUES ( :ll_prod_item_seq,   
           :ll_coil_num,   
           :ll_job,   
           :li_status,   
           :ll_item_pieces,   
           :ll_skid_theo_wt ,   
           :ll_skid_theo_wt ,   
           null,   
           sysdate,   
           :ls_test,   
           null,
			  :ll_shift_num)  ;
			  
			  ll_rc = sqlca.sqlcode
 	if ll_rc <> 0 then
		sqlca.of_rollback( ) ;
		MessageBox("Database error", "Error insert Production_sheet_item!")
		return ll_rc
	end if

	
	INSERT INTO "SHEET_SKID_DETAIL"  
         ( "PROD_ITEM_NUM",   
           "SHEET_SKID_NUM" )  
  		VALUES ( :ll_prod_item_seq ,   
           :ll_skid_seq )  ;
	ll_rc = sqlca.sqlcode
	if ll_rc <> 0 then
		sqlca.of_rollback( )
		MessageBox("Database error", "Error insert Sheet_skid_detail!")
		return ll_rc
	end if
	
	
			//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
			li_rtn = f_insert_sheet_skid_package(ll_job, ll_skid_seq, sqlca)
			
			If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package(). Error message is in this function.
				rollback using sqlca;
				Return li_rtn
			End If
			//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

		
			
			
			sqlca.of_commit( )
			
			ll_row = dw_skid_item.insertrow( 0 )
			dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare_wt
			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = 0
			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = 0
			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = 0
			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = 0
			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = 1
			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = 0
			dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
			dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job
			dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = 0
			dw_skid_item.object.production_sheet_item_prod_item_status[ll_row] = 2
			dw_skid_item.object.compute_0010[ll_row] = 0
			dw_skid_item.object.compute_0014[ll_row] = 0
			dw_skid_item.object.item_status[ll_row] = 1
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
			dw_skid_item.object.skid_status[ll_row] = 1
			dw_skid_item.object.order_item_theoretical_unit_wt[ll_row] = ld_theo_unit_wt
			dw_skid_item.object.stacker[ll_row] = 0
			DWItemStatus ldw_status
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
			
			dw_current_edit.enabled = true
			dw_current_edit.scrolltorow( ll_row)
			il_current_row = ll_row
			dw_skid_item.selectrow( 0, false)
//			ll_row = dw_current_skid.insertrow( 0 )
//			dw_current_skid.setitem( ll_row, "serialno", ll_skid_seq)
//			dw_current_skid.setitem( ll_row, "pieces", 0)
//			dw_current_skid.setitem( ll_row, "theowgt", iu_coil.of_get_theo_piece_wt() )
//			dw_current_skid.setitem( ll_row, "prod_item_num", ll_prod_item_seq )
//			dw_current_skid.setitem( ll_row, "prod_item_pieces", 0 )
//			dw_current_skid.setitem( ll_row, "tare", ll_tare_wt )
//			dw_current_skid.setitem( ll_row, "status", 7 )
//			dw_current_skid.setitem( ll_row, "init_status", 1)
//			dw_current_skid.object.init_skid_nw[ll_row] = 0
//			if not isValid( ids_dim_check ) then
//				//long ll_dim_row
//				ids_dim_check = create n_ds
//				ids_dim_check.DataObject = "d_skid_dim_check"
//				ids_dim_check.of_SetTransObject(SQLCA)
//				ll_dim_row = ids_dim_check.insertrow( 0 )
//				ids_dim_check.object.sheet_skid_num[ ll_dim_row ] = ll_skid_seq 
//			else
//				destroy ids_dim_check
//				ids_dim_check = create n_ds
//				ids_dim_check.DataObject = "d_skid_dim_check"
//				ids_dim_check.of_SetTransObject(SQLCA)
//				ll_dim_row = ids_dim_check.insertrow( 0 )
//				ids_dim_check.object.sheet_skid_num[ ll_dim_row ] = ll_skid_seq
//			end if
			iu_coil.of_get_sheet_window( ).wf_set_opc_abskid( ll_skid_seq, ii_working_stacker )
			parent.em_offset.text = "0"
	end if
//end if
end event

type st_1 from statictext within u_da_skid_tabpg
integer x = 50
integer y = 1216
integer width = 411
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Current Skid"
boolean focusrectangle = false
end type

type dw_current_edit from u_dw within u_da_skid_tabpg
integer x = 50
integer y = 1280
integer width = 2679
integer height = 192
integer taborder = 20
boolean enabled = false
string dataobject = "d_skid_item_current_free_form"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_register("sheet_skid_sheet_net_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_register("production_sheet_item_prod_item_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_sheet_tare_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_skid_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)

end event

event itemchanged;call super::itemchanged;long ll_skid_theo_wt, ll_item_theo_wt,ll_item_nw, ll_item_pieces,  ll_skid_nw, ll_skid_pieces//, ll_theo_unit_wt

Double ld_theo_unit_wt

if dwo.Name = "sheet_skid_sheet_net_wt" then
	ll_skid_nw = Long( data )
	if ll_skid_nw <= 0 then
		return 1
	end if
	ll_item_nw = ll_skid_nw	- this.object.compute_0010[row]
	ll_item_nw = this.object.production_sheet_item_prod_item_net_wt[row] + ll_item_nw
	if ll_item_nw < 0 then
		return 1
	end if
	
	this.settext( string(ll_skid_nw ))
	this.object.production_sheet_item_prod_item_net_wt[row] = ll_item_nw
	this.object.compute_0010[row] = ll_skid_nw
	return 0
elseif dwo.Name = "sheet_skid_skid_pieces" then
	ll_skid_pieces = Long(data)
	if ll_skid_nw < 0 then
		return 1
	end if
	ld_theo_unit_wt = this.object.order_item_theoretical_unit_wt[row]
	ll_skid_theo_wt = ll_skid_pieces * ld_theo_unit_wt
	ll_item_pieces = ll_skid_pieces - this.object.compute_0014[row]
	ll_item_pieces = this.object.production_sheet_item_prod_item_pieces[row] + ll_item_pieces
	ll_item_theo_wt = ll_item_pieces * ld_theo_unit_wt
	if ll_item_pieces < 0 then
		return 1
	end if
	this.settext( string( ll_skid_pieces ))
	this.object.sheet_skid_sheet_theoretical_wt[row] = ll_skid_theo_wt
	this.object.production_sheet_item_prod_item_pieces[row] = ll_item_pieces
	this.object.production_sheet_item_prod_item_theoretical_wt[row] = ll_item_theo_wt
	this.object.compute_0014[row] = ll_skid_pieces
	return 0

elseif dwo.Name = "sheet_skid_skid_sheet_status" then
	if Integer(data) = 5 or Integer(data) = 14 then
		return 0
	else
		return 1
	end if

else
	return 0
end if

return 1

end event

event clicked;call super::clicked;this.accepttext( )
if row > 0 then	
	if this.object.item_status[row] > 10000 then
		return 1
	end if
end if
end event

event losefocus;call super::losefocus;this.accepttext( )
end event

event other;call super::other;constant integer LCI_MOUSEWHEEL = 522
if message.number = LCI_MOUSEWHEEL then return 1
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

type dw_skid_item from u_dw within u_da_skid_tabpg
integer x = 50
integer y = 108
integer width = 2679
integer height = 1104
integer taborder = 30
string dataobject = "d_skid_item_display"
end type

event constructor;call super::constructor;string ls_tem[], ls_tem2[], ls_tem3[], ls_keys[]
long ll_rc
this.of_setdropdowncalculator( true)
this.iuo_calculator.of_register("sheet_skid_sheet_net_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_register("production_sheet_item_prod_item_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_sheet_tare_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_skid_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
this.of_setbase( true)
this.of_settransobject( sqlca)
this.of_setmultitable( true)
this.inv_multitable.of_getregisterable( ls_tem )
this.inv_multitable.of_getregisterabletable( ls_tem3)
this.inv_multitable.of_getregisterablecolumn( "production_sheet_item",ls_tem2  )
this.inv_multitable.of_getregisterablecolumn( "sheet_skid",ls_tem2  )
this.inv_multitable.of_getregisterablecolumn( "sheet_skid_detail",ls_tem2  )

ll_rc = this.inv_multitable.of_register( "production_sheet_item", is_production_sheet_item_keys, &
        is_production_sheet_item_cols, false, 0 )
if ll_rc <> 1 then
	MessageBox("dw_skid_item", "register failed")
	return 0
end if

ll_rc = this.inv_multitable.of_register( "sheet_skid", is_sheet_skid_keys, is_sheet_skid_cols, false, 0 )

if ll_rc <> 1 then
	MessageBox("dw_skid_item", "register failed")
	return 0
end if

ll_rc = this.inv_multitable.of_register( "sheet_skid_detail", is_sheet_skid_detail_keys )

if ll_rc <> 1 then
	MessageBox("dw_skid_item", "register failed")
	return 0
end if

isql_criteria = PreviewUpdate!

end event

event pfc_retrieve;call super::pfc_retrieve;long ll_coil, ll_rows, ll_rc, ll_i, ll_other_job, ll_current_job
long ll_skid_id, ll_prod_item_num, ll_row, ll_init_pcs, ll_stacker1_skid, ll_stacker2_skid, ll_manual_skid
int li_j, li_line_id
ll_coil = iu_coil.get_coil_abc_id( )
DataStore lds_prod_item
li_line_id = iu_coil.of_get_sheet_window( ).ii_line_id
ll_current_job = iu_coil.get_current_job( )
ll_rc = this.retrieve(ll_coil )
	  SELECT "LINE_CURRENT_STATUS"."SHEET_SKID_STACKER_1",   
         "LINE_CURRENT_STATUS"."SHEET_SKID_STACKER_2", "LINE_CURRENT_STATUS"."SHEET_SKID_NUM"
    INTO :ll_stacker1_skid,   
         :ll_stacker2_skid,
			:ll_manual_skid
    FROM "LINE_CURRENT_STATUS"  
   WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id   ;
	
	long ll_current_skid_job
	
	if not isNull(ll_stacker2_skid) and ll_stacker2_skid > 1000 then
		ll_row = this.find( "sheet_skid_sheet_skid_num="+string( ll_stacker2_skid ), 1, this.rowcount( ) )
		SELECT "SHEET_SKID"."AB_JOB_NUM"  
    INTO :ll_current_skid_job  
    FROM "SHEET_SKID"  
   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_stacker2_skid   
           ;
		if ll_row > 0 then
			this.object.stacker[ll_row] = 2
			if dw_current_edit.rowcount( ) < 1 then &
				this.sharedata( dw_current_edit )
			dw_current_edit.enabled = true
			dw_current_edit.setrow( ll_row )
			il_current_row = ll_row
			dw_current_edit.scrolltorow( ll_row )
		elseif ll_current_job = ll_current_skid_job then
		
		end if
	end if

	
	
	
	if not isNull(ll_stacker1_skid) and ll_stacker1_skid > 1000 then
		ll_row = this.find( "sheet_skid_sheet_skid_num="+string( ll_stacker1_skid ), 1, this.rowcount( ) )
		
	SELECT "SHEET_SKID"."AB_JOB_NUM"  
    INTO :ll_current_skid_job  
    FROM "SHEET_SKID"  
   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_stacker1_skid   
           ;

		
		if ll_row > 0 then
			this.object.stacker[ll_row] = 1
			
			if dw_current_edit.rowcount( ) < 1 then &
				this.sharedata( dw_current_edit )
			dw_current_edit.enabled = true
			dw_current_edit.setrow( ll_row )
			il_current_row = ll_row
			dw_current_edit.scrolltorow( ll_row )
			
			
		elseif ll_current_job = ll_current_skid_job then
			//
			
		end if
	end if
	

	
	if not isNull(ll_manual_skid) and ll_manual_skid > 1000 then
		ll_row = this.find( "sheet_skid_sheet_skid_num="+string( ll_manual_skid ), 1, this.rowcount( ) )
		
		if ll_row > 0 then
			this.object.stacker[ll_row] = 0
			if dw_current_edit.rowcount( ) < 1 then &
				this.sharedata( dw_current_edit )
			dw_current_edit.enabled = true
			dw_current_edit.setrow( ll_row )
			il_current_row = ll_row
			dw_current_edit.scrolltorow( ll_row )
		end if
		
		SELECT "SHEET_SKID"."AB_JOB_NUM"  
    		INTO :ll_current_skid_job  
    		FROM "SHEET_SKID"  
   	WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_manual_skid   
           ;
			  
		if ll_current_job = ll_current_skid_job then
			//
		end if
	end if


//!!The following code handle display of other item, but affect performance. Not using for now
/*
		lds_prod_item = create DataStore
		lds_prod_item.dataobject = "d_prod_item_for_skid"
		lds_prod_item.settransobject( sqlca)

ll_rows = this.rowcount( )

for ll_i = 1 to ll_rows
	ll_skid_id = this.object.sheet_skid_sheet_skid_num[ll_i]
	ll_prod_item_num = this.object.production_sheet_item_prod_item_num[ll_i]
	lds_prod_item.retrieve( ll_skid_id )
	if lds_prod_item.rowcount( ) > 1 then
		for li_j = 1 to lds_prod_item.rowcount( )
			if ll_prod_item_num <> lds_prod_item.object.production_sheet_item_prod_item_num[li_j] then
				ll_init_pcs = lds_prod_item.object.production_sheet_item_prod_item_pieces[li_j]
				ll_other_job = lds_prod_item.object.production_sheet_item_ab_job_num[li_j]
				ll_row = this.insertrow( ll_i + 1)
				this.object.production_sheet_item_prod_item_pieces[ll_row] = ll_init_pcs
				this.object.item_status[ll_row] = ll_prod_item_num
				this.object.production_sheet_item_ab_job_num[ll_row] = ll_other_job
				this.object.skid_status[ll_row] = ll_skid_id
				this.object.sheet_skid_skid_sheet_status[ll_row] = 99
				this.setitemstatus( ll_row, 0, Primary!, NotModified!)
				this.setitemstatus( ll_row, 0, Primary!, DataModified!)
				this.setitemstatus( ll_row, 0, Primary!, NotModified!)
			end if
		next
	end if
next
*/
//!!------------------------------------- end of other item handling--------------------
return ll_rc

end event

event itemchanged;call super::itemchanged;long ll_skid_theo_wt, ll_item_theo_wt,ll_item_nw, ll_item_pieces,  ll_skid_nw, ll_skid_pieces//, ll_theo_unit_wt

Double ld_theo_unit_wt

if dwo.Name = "sheet_skid_sheet_net_wt" then
	ll_skid_nw = Long( data )
	if ll_skid_nw <= 0 then
		return 1
	end if
	ll_item_nw = ll_skid_nw	- this.object.compute_0010[row]
	ll_item_nw = this.object.production_sheet_item_prod_item_net_wt[row] + ll_item_nw
	if ll_item_nw < 0 then
		return 1
	end if
	
	this.settext( string(ll_skid_nw ))
	this.object.production_sheet_item_prod_item_net_wt[row] = ll_item_nw
	this.object.compute_0010[row] = ll_skid_nw
	return 0
elseif dwo.Name = "sheet_skid_skid_pieces" then
	ll_skid_pieces = Long(data)
	if ll_skid_nw < 0 then
		return 1
	end if
	ld_theo_unit_wt = this.object.order_item_theoretical_unit_wt[row]
	ll_skid_theo_wt = ll_skid_pieces * ld_theo_unit_wt
	ll_item_pieces = ll_skid_pieces - this.object.compute_0014[row]
	ll_item_pieces = this.object.production_sheet_item_prod_item_pieces[row] + ll_item_pieces
	ll_item_theo_wt = ll_item_pieces * ld_theo_unit_wt
	if ll_item_pieces < 0 then
		return 1
	end if
	this.settext( string( ll_skid_pieces ))
	this.object.sheet_skid_sheet_theoretical_wt[row] = ll_skid_theo_wt
	this.object.production_sheet_item_prod_item_pieces[row] = ll_item_pieces
	this.object.production_sheet_item_prod_item_theoretical_wt[row] = ll_item_theo_wt
	this.object.compute_0014[row] = ll_skid_pieces
	return 0

elseif dwo.Name = "sheet_skid_skid_sheet_status" then
	if Integer(data) = 5 or Integer(data) = 14 then
		return 0
	else
		return 1
	end if

else
	return 0
end if

return 1

end event

event clicked;call super::clicked;this.accepttext( )
if row > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num" then
	if this.object.item_status[row] > 10000 then
		return 1
	end if
	this.selectrow( 0, false)
	this.selectrow( row, true)
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

event doubleclicked;call super::doubleclicked;long ll_row
if row > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num" then
	if dw_current_edit.rowcount( ) > 0 then
		ll_row = dw_current_edit.getrow( )
	end if
//	if this.object.item_status[row] < 1000 /*and this.object.skid_status[row] <>1 */  then
//		long ll_item
//		ll_item = this.object.production_sheet_item_prod_item_num[row]
//		gl_message = ll_item
		
	if this.object.item_status[row] < 1000 and row <>ll_row  then

		il_edit_row = row
		openwithparm(iw_da_tabpg_skid_edit, parent ) 
	end if
//	openwithparm(iw_skid_edit,   )
end if
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

type cb_dim_check from commandbutton within u_da_skid_tabpg
boolean visible = false
integer x = 2610
integer y = 396
integer width = 119
integer height = 92
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Dimension Check"
end type

event clicked;//long ll_skid_num, ll_row
//if dw_current_skid.rowcount( ) = 1 then // current skid unsaved
////			MessageBox("Current skid not available", "Current skid not available, please load it first!", StopSign!)
////			//dw_skid_item.accepttext( ) // Save skids changes
////			dw_skid_item.of_retrieve( )
////			return 1
//	if dw_current_skid.getitemnumber( 1, "init_status") = 1 then // new skid
//		OpenWithParm( iw_dimensional_check_new_skid, parent  )
//	else //old skid
//		ll_skid_num = dw_current_skid.object. serialno[1]
//		OpenWithParm(  iw_dimensional_check, ll_skid_num  )
//	end if
//
//else // no current skid
//	ll_row = dw_skid_item.getselectedrow( 0 )  //getrow( )
//	if ll_row > 0 then
//		ll_skid_num = dw_skid_item.object.sheet_skid_sheet_skid_num[ ll_row ]
//		//Open( iw_dimensional_check )
//		//MessageBox( "dfd", string( ll_skid_num )  )
//		OpenWithParm(  iw_dimensional_check, ll_skid_num  )
//	end if
//end if

//if Not isValid(iw_dimensional_check) then
//	Open( iw_dimensional_check )
//end if
//
//if dw_current_skid.getitemnumber( 1, "init_status") = 1 then
//	of_save_current_skid_new( )
//elseif dw_current_skid.getitemnumber( 1, "init_status") = 15 then
//	of_save_current_skid_partial_single_item( )
//else
//	of_save_current_skid_partial( )
//end if
end event

type st_2 from statictext within u_da_skid_tabpg
integer x = 73
integer y = 28
integer width = 846
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Skid(s) for current job and coil:"
boolean focusrectangle = false
end type

