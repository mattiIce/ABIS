$PBExportHeader$u_da_recap_skid_tabpg.sru
forward
global type u_da_recap_skid_tabpg from u_tabpg
end type
type cb_cancel from u_cb within u_da_recap_skid_tabpg
end type
type cb_ref from u_cb within u_da_recap_skid_tabpg
end type
type cb_edit from u_cb within u_da_recap_skid_tabpg
end type
type cb_retrieve from commandbutton within u_da_recap_skid_tabpg
end type
type cb_print from commandbutton within u_da_recap_skid_tabpg
end type
type cb_delete from commandbutton within u_da_recap_skid_tabpg
end type
type st_1 from statictext within u_da_recap_skid_tabpg
end type
type dw_skid_item from u_dw within u_da_recap_skid_tabpg
end type
type dw_edit from u_dw within u_da_recap_skid_tabpg
end type
end forward

global type u_da_recap_skid_tabpg from u_tabpg
integer width = 2765
integer height = 1232
long backcolor = 12639424
string text = "GOOD SKID"
long tabbackcolor = 12639424
boolean ib_isupdateable = false
cb_cancel cb_cancel
cb_ref cb_ref
cb_edit cb_edit
cb_retrieve cb_retrieve
cb_print cb_print
cb_delete cb_delete
st_1 st_1
dw_skid_item dw_skid_item
dw_edit dw_edit
end type
global u_da_recap_skid_tabpg u_da_recap_skid_tabpg

type variables
string is_title
//w_da_sheet iw_sheet
//long il_coil_num, il_job_num
//long il_scrap_skid_num  //, al_sheet_skid_num
//w_tare iw_tare
//w_load_partial iw_load_partial
//w_load_scrap_tare iw_load_scrap_tare
//w_scrap_type iw_scrap_type
//w_dimensional_check iw_dimensional_check
//w_dimensional_check_new_skid iw_dimensional_check_new_skid
s_partial_skid istr_scrap_skid
u_coil iu_coil
u_tabpg_end_coil iu_tabpg_end_coil
//n_ds ids_dim_check
//string is_scrap_defect
//string is_pre_scrap_defect
//int ii_scrap_type
//int ii_pre_scrap_type
Datastore ids_copy
SQLPreviewType isql_criteria

string is_PRODUCTION_SHEET_ITEM_keys[] = {"production_sheet_item_prod_item_num" }
string is_PRODUCTION_SHEET_ITEM_cols[] = & 
{"production_sheet_item_prod_item_pieces", "production_sheet_item_prod_item_net_wt","production_sheet_item_prod_item_num", &
"production_sheet_item_prod_item_theoretical_wt"}
string is_SHEET_SKID_DETAIL_keys[] ={"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
string is_SHEET_SKID_DETAIL_cols[] = &
{"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
string is_SHEET_SKID_keys[]={"sheet_skid_sheet_skid_num"}
string is_SHEET_SKID_cols[] = &
{"sheet_skid_sheet_tare_wt","sheet_skid_sheet_net_wt","sheet_skid_skid_pieces", "sheet_skid_sheet_theoretical_wt","sheet_skid_skid_sheet_status"}


long il_current_row, il_edit_row
//w_da_tabpg_skid_edit iw_da_tabpg_skid_edit
//w_da_tabpg_offline_skid_edit iw_da_tabpg_offline_skid_edit

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
public subroutine of_add_current_skid_pieces (integer ai_pcs)
public subroutine of_print_skid_ticket (long al_skid_num, long al_net, long al_tare)
public subroutine of_print_scrap_ticket (long al_skid_num, long al_net, long al_tare)
public function integer of_save_current_skid_partial (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt)
public function integer of_save_current_skid_partial_single_item (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt, long al_init_item_pcs)
public function integer of_delete_rows ()
public subroutine of_init (readonly u_coil au_coil, readonly u_tabpg_end_coil au_tabpg)
public subroutine of_total_wt_changed ()
public function integer of_data_validation (long al_row)
end prototypes

public subroutine of_add_current_skid_pieces (integer ai_pcs);//long ll_rc, ll_pcs
//string ls_pcs
////ll_rc = dw_current_skid.rowcount( )
//if dw_current_edit.enabled then
//	//ll_pcs = dw_current_skid.object.pieces[1]
//	//dw_current_skid.object.pieces[1] = ll_pcs + ai_pcs
//	if il_current_row > 0 then
//		dw_current_edit.setrow( il_current_row )
//		dw_current_edit.setcolumn( "sheet_skid_skid_pieces")
//		ls_pcs = dw_current_edit.gettext( )
//		ll_pcs = Long(ls_pcs)
//		ll_pcs = ll_pcs + ai_pcs
//		dw_current_edit.settext( string(ll_pcs ))
//		dw_current_edit.accepttext( )
//	end if
//end if
end subroutine

public subroutine of_print_skid_ticket (long al_skid_num, long al_net, long al_tare);Datastore lds_skid
		lds_skid = create datastore
		lds_skid.dataobject = "d_skid_ticket"
		lds_skid.settransobject( sqlca)
		lds_skid.retrieve( al_skid_num)
		
		//Set Job and Coil info
		lds_skid.object.t_customer.text = iu_coil.of_get_customer_name( )
		lds_skid.object.t_skid_num_b.text = "*S" + string(al_skid_num) + "*"
		lds_skid.object.t_skid_num_t.text = string(al_skid_num)
		lds_skid.object.t_job.text = string(iu_coil.get_current_job( ))
		lds_skid.object.t_alloy.text = iu_coil.of_get_alloy()
		lds_skid.object.t_temper.text = iu_coil.of_get_temper()
		lds_skid.object.t_gage.text = string(iu_coil.of_get_gauge( ))
		lds_skid.object.t_width.text = string(iu_coil.of_get_part_width( ))
		lds_skid.object.t_length.text = string(iu_coil.of_get_part_length( ))
		lds_skid.object.t_gross_wt.text = string((al_net + al_tare))
		lds_skid.object.t_net.text = string(al_net)
		lds_skid.object.t_tare.text = string(al_tare)
		lds_skid.print( )
		
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

public function integer of_save_current_skid_partial (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt);return 0
//long ll_skid_theo_wt, ll_item_theo_wt, ll_prod_item_num, ll_coil_num, ll_job_num, li_status, ll_item_pieces, ll_skid_pieces, ll_skid_nw
//string ls_test
//long ll_skid_num, ll_order_num, ll_rc, ll_tare, ll_shift_num, ll_row
//int li_order_item, li_row
//ls_test = "DAS-partial-saved"
//ll_skid_theo_wt = al_skid_pcs * iu_coil.of_get_theo_piece_wt( )
//ll_skid_num = al_skid_id
//ll_job_num = iu_coil.get_current_job( )
//ll_tare = al_tare
//ll_skid_pieces = al_skid_pcs
//ll_item_pieces = ll_skid_pieces - al_init_pcs
//
//If ll_item_pieces < 0 or ll_item_pieces > 999 then
//	MessageBox("Can not save skid", "Item pieces error!!"  )
//	return -1
//end if
//
//ll_shift_num = iu_coil.of_get_shift_id( )
//ll_item_theo_wt = ll_item_pieces * iu_coil.of_get_theo_piece_wt( )
//ll_order_num = iu_coil.of_get_order_num( )
//li_order_item = iu_coil.of_get_order_item( )
//ll_prod_item_num = al_item_id
//ll_coil_num = iu_coil.get_coil_abc_id( )
//li_status = ai_status
//ll_skid_nw = al_init_skid_wt + ll_item_theo_wt
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
//           "PROD_ITEM_PLACEMENT",
//			  "SHIFT_NUM")  
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
//           null,
//			  :ll_shift_num)  ;
//
//	ll_rc = sqlca.sqlcode
//	if ll_rc <> 0 then
//		sqlca.of_rollback( )
//		MessageBox("Database error", "Error insert production_sheet_item")
//		return ll_rc
//	end if
//
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
////Update sheet_skid table
//
//	  UPDATE "SHEET_SKID"  
//     SET "AB_JOB_NUM" = :ll_job_num ,   
//         "SHEET_NET_WT" = "SHEET_NET_WT" + :ll_item_theo_wt,
//         "SKID_DATE" = SYSDATE,   
//         "SKID_SHEET_STATUS" = :li_status ,   
//         "SKID_PIECES" = "SKID_PIECES" + :ll_item_pieces,
//         "SHEET_THEORETICAL_WT" = "SHEET_THEORETICAL_WT" + :ll_item_theo_wt
//   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num   
//           ;
//	ll_rc = sqlca.sqlcode
//	if ll_rc <> 0 then
//		sqlca.of_rollback( )
//		MessageBox("Database error", "Error update Sheet_skid!")
//		return ll_rc
//	end if
//
//	sqlca.of_commit( )
//
//	
//			ll_row = dw_skid_item.insertrow( 0 )
//			dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_num
//			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare
//			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = ll_skid_nw
//			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = ll_skid_pieces
//			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = ll_skid_theo_wt
//			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = ll_item_pieces
//			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = ai_status
//			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = ll_item_theo_wt
//			dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
//			dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job_num
//			dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_num
//			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = ll_item_theo_wt
//			dw_skid_item.object.compute_0010[ll_row] = ll_skid_nw
//			dw_skid_item.object.compute_0014[ll_row] = ll_skid_pieces
//			dw_skid_item.object.item_status[ll_row] = 1
//			dw_skid_item.object.skid_status[ll_row] = 7
//			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_num
//			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_num
//			
//			DWItemStatus ldw_status
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//
//						
//			ll_row = dw_skid_item.insertrow( 0 )
//			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = al_init_pcs
//			dw_skid_item.object.item_status[ll_row] = ll_prod_item_num
//			dw_skid_item.object.skid_status[ll_row] = ll_skid_num
//			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = 99
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			
//			dw_current_edit.enabled = true
//			dw_current_edit.scrolltorow( ll_row -1 )
//			il_current_row = ll_row -1
//	
//return 0 //retrun sqlca.sqlcode
end function

public function integer of_save_current_skid_partial_single_item (long al_skid_pcs, long al_skid_id, long al_tare, long al_init_pcs, long al_item_id, integer ai_status, long al_init_skid_wt, long al_init_item_pcs);return 0
//long ll_skid_theo_wt, ll_item_theo_wt, ll_prod_item_num, ll_coil_num, ll_job_num, li_status, ll_item_pieces, ll_skid_pieces, ll_skid_nw
//string ls_test
//long ll_skid_num, ll_order_num, ll_rc, ll_tare, ll_init_item_pcs, ll_shift_num, ll_row, ll_new_item_pcs
//int li_order_item, li_row
//ls_test = "DAS-partial-single-item"
////if dw_current_skid.rowcount( ) <> 1 then
////			MessageBox("Current skid not available", "Current skid not available, please load it first!", StopSign!)
////			return 1
////end if
//
////item_piece and item_nw are for added item pcs and nw
//
////dw_current_skid.accepttext( )
//// dw_current_skid.getitemnumber( 1, "pieces")
//ll_shift_num = iu_coil.of_get_shift_id( )
//ll_skid_num = al_skid_id
//ll_job_num = iu_coil.get_current_job( )
//ll_tare = al_tare
//ll_skid_pieces = al_skid_pcs
//ll_skid_theo_wt = iu_coil.of_get_theo_piece_wt( ) *ll_skid_pieces
//ll_item_pieces = ll_skid_pieces - al_init_pcs
//ll_init_item_pcs = al_init_item_pcs
//ll_new_item_pcs = ll_init_item_pcs + ll_item_pieces
//
//If ll_item_pieces < 0 or ll_item_pieces > 999 then
//	MessageBox("Can not save skid", "Item pieces error!!"  )
//	return -1
//end if
//
//ll_item_theo_wt = ll_item_pieces * iu_coil.of_get_theo_piece_wt( )
//ll_order_num = iu_coil.of_get_order_num( )
//li_order_item = iu_coil.of_get_order_item( )
//ll_prod_item_num = al_item_id
//ll_coil_num = iu_coil.get_coil_abc_id( )
//li_status = ai_status
//
//ll_skid_nw = al_init_skid_wt + ll_item_theo_wt
//// 1) update prod_sheet_item table
//  
//    UPDATE "PRODUCTION_SHEET_ITEM"  
//     SET "PROD_ITEM_STATUS" = :li_status,   
//         "PROD_ITEM_PIECES" = "PROD_ITEM_PIECES" + :ll_item_pieces, //+ :ll_init_item_pcs,   
//         "PROD_ITEM_NET_WT" = "PROD_ITEM_NET_WT" + :ll_item_theo_wt,   
//         "PROD_ITEM_THEORETICAL_WT" = "PROD_ITEM_THEORETICAL_WT"+ :ll_item_theo_wt,
//			"SHIFT_NUM" = :ll_shift_num
//   WHERE "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" = :ll_prod_item_num   
//           ;
//
//  
////  
////  INSERT INTO "PRODUCTION_SHEET_ITEM"  
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
////           "PROD_ITEM_PLACEMENT" )  
////  VALUES ( :ll_prod_item_num,   
////           :ll_coil_num,   
////           :ll_job_num,   
////           :li_status,   
////           :ll_item_pieces,   
////           :ll_item_theo_wt,   
////           :ll_item_theo_wt,
////			  null,   
////           sysdate,   
////           :ls_test,   
////           null )  ;
//
//	ll_rc = sqlca.sqlcode
//	if ll_rc <> 0 then
//		sqlca.of_rollback( )
//		MessageBox("Database error", "Error update production_sheet_item")
//		return ll_rc
//	end if
//
//////Insert sheet_skid_detail
////
////	  INSERT INTO "SHEET_SKID_DETAIL"  
////         ( "PROD_ITEM_NUM",   
////           "SHEET_SKID_NUM" )  
////  		VALUES ( :ll_prod_item_num ,   
////           :ll_skid_num )  ;
////	ll_rc = sqlca.sqlcode
////	if ll_rc <> 0 then
////		sqlca.of_rollback( )
////		MessageBox("Database error", "Error insert Sheet_skid_detail!")
////		return ll_rc
////	end if
////
//
////Update sheet_skid table
//
//	  UPDATE "SHEET_SKID"  
//     SET "AB_JOB_NUM" = :ll_job_num,   
//         "SHEET_NET_WT" = "SHEET_NET_WT" + :ll_item_theo_wt,
//         "SKID_DATE" = SYSDATE,   
//         "SKID_SHEET_STATUS" = :li_status,   
//         "SKID_PIECES" = "SKID_PIECES" + :ll_item_pieces,   
//         "SHEET_THEORETICAL_WT" = "SHEET_THEORETICAL_WT" + :ll_item_theo_wt  
//   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num   
//           ;
//	ll_rc = sqlca.sqlcode
//	if ll_rc <> 0 then
//		sqlca.of_rollback( )
//		MessageBox("Database error", "Error insert Sheet_skid_detail!")
//		return ll_rc
//	end if
//
//	sqlca.of_commit( )
//
//	ll_row = dw_skid_item.find( "production_sheet_item_prod_item_num = " + string( ll_prod_item_num ), 1, dw_skid_item.rowcount( ) )
//	if ll_row > 0 then
//		
//			//dw_skid_item.object.sheet_skid_sheet_skid_num[ll_row] = ll_skid_seq
//			dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = ll_tare
//			dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = ll_skid_nw
//			dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = ll_skid_pieces
//			dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = ll_skid_theo_wt
//			dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = ll_new_item_pcs
//			
//			
//			dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = ai_status
//			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = &
//				dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] + ll_item_theo_wt
//			
//			//dw_skid_item.object.production_sheet_item_coil_abc_num[ll_row] = ll_coil_num
//			//dw_skid_item.object.production_sheet_item_ab_job_num[ll_row] = ll_job
//			//dw_skid_item.object.production_sheet_item_prod_item_num[ll_row] = ll_prod_item_seq
//			dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = &
//				dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] + ll_item_theo_wt
//			
//			dw_skid_item.object.compute_0010[ll_row] = ll_skid_nw
//			dw_skid_item.object.compute_0014[ll_row] = ll_skid_pieces
//			dw_skid_item.object.item_status[ll_row] = 1
//			dw_skid_item.object.skid_status[ll_row] = 1
//			//dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
//			//dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
//			
//			DWItemStatus ldw_status
////			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
////			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
////			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
////			dw_skid_item.setitemstatus( ll_row, 0, Primary!, DataModified!)
////			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_item.setitemstatus( ll_row, 0, Primary!, NotModified!)
//			ldw_status = dw_skid_item.getitemstatus( ll_row, 0, Primary!)
//
//			dw_current_edit.enabled = true
//			dw_current_edit.scrolltorow( ll_row  )
//			il_current_row = ll_row
//		
//		
//		
////		dw_skid_item.setitem( ll_row, "sheet_skid_sheet_skid_num", ll_skid_num)
////		dw_skid_item.setitem( ll_row, "sheet_skid_sheet_tare_wt", ll_tare)
////		dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = & 
////			dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] + ll_item_theo_wt
////		dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = & 
////		  	dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] + ll_item_pieces
////		dw_skid_item.object.production_sheet_item_prod_item_pieces_1[ll_row] = &
////			dw_skid_item.object.production_sheet_item_prod_item_pieces_1[ll_row] + ll_item_pieces
////		dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = 0
////		dw_skid_item.object.sheet_skid_sheet_net_wt_1[ll_row] = dw_skid_item.object.sheet_skid_sheet_net_wt_1[ll_row] + ll_item_theo_wt
////		dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = dw_skid_item.object.sheet_skid_skid_pieces[ll_row] + ll_item_pieces
////		dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = li_status
//	end if
//return 0 //retrun sqlca.sqlcode
end function

public function integer of_delete_rows ();//return 1 if sucess
//return -1 error
long ll_prod_item_num, ll_item_pieces,ll_skid_pieces,ll_skid_theo_wt,ll_item_nw,ll_skid_num,row		   
long ll_item_theo_wt, ll_item_count, ll_rc, ll_i

ll_rc = dw_skid_item.deletedcount( )
if ll_rc < 1 then
	return 1
end if
//ll_rc = 1

for ll_i = 1 to ll_rc
	if dw_skid_item.getitemstatus( ll_i, 0 , Delete!)	= 	New!	then
		CONTINUE
	end if
	
	if dw_skid_item.getitemnumber( ll_i, "item_status", Delete!, false) > 10000 then
		CONTINUE
	end if
	
			ll_prod_item_num = &
			dw_skid_item.getitemnumber( ll_i, "production_sheet_item_prod_item_num", Delete!, false)
			ll_skid_num = &
			dw_skid_item.getitemnumber( ll_i, "sheet_skid_sheet_skid_num", Delete!, false)
			
			DELETE FROM "SHEET_SKID_DETAIL"  
   			WHERE "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" = :ll_prod_item_num   ;
				if sqlca.sqlcode <> 0 then
					//sqlca.of_rollback( )
					return -1
				//else
				//	sqlca.of_commit( )
				end if
		  
		  DELETE FROM "PRODUCTION_SHEET_ITEM"  
   		WHERE "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" = :ll_prod_item_num   ;
				if sqlca.sqlcode <> 0 then
					//sqlca.of_rollback( )
					return -1
				//else
				//	sqlca.of_commit( )
				end if
		
		  SELECT COUNT(*) 
    INTO :ll_item_count  
    FROM "SHEET_SKID_DETAIL"  
   WHERE "SHEET_SKID_DETAIL"."SHEET_SKID_NUM" = :ll_skid_num   ;
						if sqlca.sqlcode <> 0 then
							//sqlca.of_rollback( )
							return -1
						end if
	if ll_item_count > 0 then
		
		//ll_skid_pieces = ll_item_pieces - dw_skid_item.object.production_sheet_item_prod_item_pieces_1[row] + dw_skid_item.object.sheet_skid_skid_pieces[row]
		//ll_skid_theo_wt = ll_skid_pieces * iu_coil.of_get_theo_piece_wt( )
		ll_item_pieces = &
			dw_skid_item.getitemnumber( ll_i, "production_sheet_item_prod_item_pieces", Delete!, false)
		ll_item_nw = &
			dw_skid_item.getitemnumber( ll_i, "production_sheet_item_prod_item_net_wt", Delete!, false)
		
		ll_item_theo_wt = ll_item_pieces *iu_coil.of_get_theo_piece_wt( )
		
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
				  DELETE FROM "SHEET_SKID"  
   					WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_num ;
						if sqlca.sqlcode <> 0 then
							//sqlca.of_rollback( )
							return -1
						end if

				
	end if
next
return 1
end function

public subroutine of_init (readonly u_coil au_coil, readonly u_tabpg_end_coil au_tabpg);//iw_sheet = aw_1
if isValid( au_coil ) then
	iu_coil = au_coil
end if
if isValid( au_tabpg ) then
	iu_tabpg_end_coil = au_tabpg
end if
//dw_scrap.of_retrieve( )
//dw_skid_item.of_retrieve( )

if isValid(iu_coil.of_get_skid_tab_page( )) then
	//online mode
	iu_coil.of_get_skid_tab_page( ).dw_skid_item.sharedata( dw_skid_item )
else
//	iu_coil.of_get_skid_offline_tab_page( ).dw_skid_item.sharedata( dw_skid_item )
end if


//dw_scrap.inv_base.of_populatedddw( )
//dw_skid_item.sharedata( dw_current_edit )
long ll_row
ll_row = dw_skid_item.rowcount( )

//dw_current_edit.scrolltorow( ll_row )

//dw_scrap_type.settransobject( sqlca)
//dw_scrap_type.retrieve( )
//dw_scrap.inv_base.of_populatedddw( )
//ll_row = dw_scrap_type.insertrow( 0 )
//dw_scrap_type.object.id[ll_row] = 0
//ii_pre_scrap_type = 0
//ii_scrap_type = 0
end subroutine

public subroutine of_total_wt_changed ();
end subroutine

public function integer of_data_validation (long al_row);long ll_wt_limit
ll_wt_limit = iu_coil.get_old_nw( ) + iu_coil.get_old_nw( ) * 0.11
if dw_edit.object.sheet_skid_sheet_tare_wt[al_row] < 1 or dw_edit.object.sheet_skid_sheet_tare_wt[al_row] > 8000 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid tare weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_edit.object.production_sheet_item_prod_item_net_wt[al_row] < 1 or dw_edit.object.production_sheet_item_prod_item_net_wt[al_row] > ll_wt_limit then
	this.of_messagebox( "id_data_error", "Data error", "Invalid skid weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_edit.object.production_sheet_item_prod_item_theoretical_wt[al_row] < 1 or dw_edit.object.production_sheet_item_prod_item_theoretical_wt[al_row] > ll_wt_limit then
	this.of_messagebox( "id_data_error", "Data error", "Invalid skid pieces!", Exclamation!, Ok!, 1)
	return 1
end if

return 0 //return 0 if validated
end function

on u_da_recap_skid_tabpg.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ref=create cb_ref
this.cb_edit=create cb_edit
this.cb_retrieve=create cb_retrieve
this.cb_print=create cb_print
this.cb_delete=create cb_delete
this.st_1=create st_1
this.dw_skid_item=create dw_skid_item
this.dw_edit=create dw_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ref
this.Control[iCurrent+3]=this.cb_edit
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.dw_skid_item
this.Control[iCurrent+9]=this.dw_edit
end on

on u_da_recap_skid_tabpg.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ref)
destroy(this.cb_edit)
destroy(this.cb_retrieve)
destroy(this.cb_print)
destroy(this.cb_delete)
destroy(this.st_1)
destroy(this.dw_skid_item)
destroy(this.dw_edit)
end on

event destructor;call super::destructor;//if isValid( iw_tare ) then
//	Close(iw_tare)
//end if
//
//if isValid(iw_load_partial) then
//	Close( iw_load_partial )
//end if

if dw_skid_item.of_updatespending( ) = 1 then
	if MessageBox("Downtime", "Data changed, Save it?", Exclamation!, YesNo!, 2) = 2 then
				dw_skid_item.resetupdate( )
				return 0
	end if
	cb_ref.event clicked( )
end if
return 0
//dw_current_edit.resetupdate( )
//dw_skid_item.resetupdate( )

//if isValid(iw_load_scrap_tare) then
//	Close( iw_load_scrap_tare )
//end if
//
//if isValid(iw_scrap_type) then
//	Close( iw_scrap_type )
//end if

//if isValid(iw_dimensional_check ) then
//	Close( iw_dimensional_check )
//end if

//if isValid(iw_dimensional_check_new_skid) then
//	Close( iw_dimensional_check_new_skid )
//end if

end event

event constructor;call super::constructor;ids_copy = create Datastore
ids_copy.dataobject = "d_skid_item_display"
//iw_sheet = message.powerobjectparm
//if isValid( iw_sheet.iu_current_coil ) then
//	iu_coil = iw_sheet.iu_current_coil
//end if
//dw_skid_item.settransobject( sqlca)
//dw_skid_item.of_retrieve( )
//
end event

type cb_cancel from u_cb within u_da_recap_skid_tabpg
integer x = 1214
integer y = 1120
integer width = 351
integer height = 99
integer taborder = 180
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "Cancel"
end type

event clicked;call super::clicked;if dw_edit.rowcount( ) < 1 then
	return 1
end if
long ll_row
ll_row = dw_edit.getrow( )

if ll_row <> il_edit_row then
	dw_edit.sharedataoff( )
	return 1
end if
//MessageBox("",string(il_edit_row ))
dw_edit.object.Data[ il_edit_row ] = ids_copy.object.Data[ 1 ]
ids_copy.reset()
dw_edit.sharedataoff( )
this.enabled = false
cb_ref.enabled = false
cb_edit.enabled = true
end event

type cb_ref from u_cb within u_da_recap_skid_tabpg
integer x = 1730
integer y = 1120
integer width = 351
integer height = 99
integer taborder = 170
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "Save"
end type

event clicked;call super::clicked;int li_rc, ll_row

if dw_edit.rowcount( ) < 1 then
	return 1
end if

//dw_skid_item.accepttext( )
dw_edit.accepttext( )
dw_skid_item.accepttext( )
//if dw_edit.rowcount( ) < 1 then
//	return 1
//end if

ll_row = dw_edit.getrow( )

if ll_row <> il_edit_row then
	dw_edit.sharedataoff( )
	return 1
end if

if of_data_validation( il_edit_row ) <> 0 then
	return 1
end if



if isValid(iu_coil.of_get_skid_tab_page( )) then
	iu_coil.of_get_skid_tab_page( ).of_save( )
else
//	iu_coil.of_get_skid_offline_tab_page( ).of_save( )
end if

dw_edit.sharedataoff( )
cb_cancel.enabled = false
this.enabled = false
cb_edit.enabled = true

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

type cb_edit from u_cb within u_da_recap_skid_tabpg
integer x = 699
integer y = 1120
integer width = 351
integer height = 99
integer taborder = 160
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Edit"
end type

event clicked;call super::clicked;//To do list open dim_check_for selected skid
//MessageBox("Dimensional check data", "Coming soon...")
long ll_row
//ll_item = dw_skid_item.object.production_sheet_item_prod_item_num[dw_skid_item.getselectedrow(0)] 

if dw_edit.rowcount( ) > 0 then
	MessageBox("Edit skid", "Please save or cancel current edit skid first!")
	return 1
end if

ll_row = dw_skid_item.getselectedrow(0)
if ll_row < 1 then
	MessageBox("Edit skid", "Please select a skid to edit!")
	return 1
end if

il_edit_row = ll_row

dw_skid_item.sharedata( dw_edit )
dw_edit.scrolltorow( il_edit_row )
dw_edit.setrow( il_edit_row )
dw_edit.rowscopy( ll_row, ll_row, Primary!, ids_copy , 1, Primary!)
this.enabled = false
cb_cancel.enabled = true
cb_ref.enabled = true

//if Not isValid( iw_da_tabpg_skid_edit ) then
//	OpenWithParm(iw_da_tabpg_skid_edit, parent)
//end if
end event

type cb_retrieve from commandbutton within u_da_recap_skid_tabpg
boolean visible = false
integer x = 395
integer y = 1117
integer width = 351
integer height = 102
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

type cb_print from commandbutton within u_da_recap_skid_tabpg
integer x = 2245
integer y = 1120
integer width = 351
integer height = 99
integer taborder = 130
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
ll_row = dw_skid_item.getselectedrow( 0 )  //getrow( )
if ll_row > 0 then
	ll_skid_num = dw_skid_item.object.sheet_skid_sheet_skid_num[ ll_row ]
	ll_net = dw_skid_item.object.sheet_skid_sheet_net_wt[ ll_row ]
	ll_tare = dw_skid_item.object.sheet_skid_sheet_tare_wt[ ll_row ]
	if ll_skid_num > 100000 then
		of_print_skid_ticket( ll_skid_num, ll_net, ll_tare )
	end if
end if
	
end event

type cb_delete from commandbutton within u_da_recap_skid_tabpg
boolean visible = false
integer x = 44
integer y = 1114
integer width = 351
integer height = 102
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;////long ll_prod_item_num, ll_item_pieces,ll_skid_pieces,ll_skid_theo_wt,ll_item_nw,ll_skid_num,row		   
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
			
			if row = il_current_row then
				MessageBox("Delete skid", "You can not delete current item!!", StopSign!)
				return 1
			end if
			
			if MessageBox("Delete item", "Do you want to delete selected item?", Exclamation!, OKCancel!, 2) = 2 then
				return 0
			end if
			ll_item_num = dw_skid_item.object.production_sheet_item_prod_item_num[row]
		  dw_skid_item.deleterow( row )
		  ll_row = dw_skid_item.find( "item_status = " + string(ll_item_num ), 1, dw_skid_item.rowcount( ) )
		  if ll_row > 0 then
			dw_skid_item.deleterow( ll_row)
			end if
		  
		  
		  
//		  dw_skid_item.event pfc_deleterow( )
end event

type st_1 from statictext within u_da_recap_skid_tabpg
integer x = 48
integer y = 861
integer width = 1598
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Editor (Enter theo weight to Skid Wt for unfinished partial split skid.)"
boolean focusrectangle = false
end type

type dw_skid_item from u_dw within u_da_recap_skid_tabpg
integer x = 44
integer y = 10
integer width = 2677
integer height = 848
integer taborder = 10
string dataobject = "d_skid_item_display"
boolean hscrollbar = true
end type

event clicked;call super::clicked;this.accepttext( )
if row > 0 then //and dwo.Name = "sheet_skid_sheet_skid_num" then
	
	if this.object.item_status[row] > 10000 then
		return 1
	end if
	
	this.selectrow( 0, false)
	this.selectrow( row, true)
end if
	
end event

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

event doubleclicked;call super::doubleclicked;if dw_edit.rowcount( ) > 0 then
	MessageBox("Edit skid", "Please save or cancel current edit skid first!")
	return 1
end if

if row > 0 then
	if this.object.item_status[row] < 1000 /*and this.object.skid_status[row] <>1*/ then
		il_edit_row = row

		dw_skid_item.sharedata( dw_edit )
		dw_edit.scrolltorow( il_edit_row )
		dw_edit.setrow( il_edit_row )
		dw_edit.rowscopy( row, row, Primary!, ids_copy , 1, Primary!)
		cb_edit.enabled = false
		cb_cancel.enabled = true
		cb_ref.enabled = true
	end if
end if
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

event losefocus;call super::losefocus;this.accepttext( )
end event

event sqlpreview;call super::sqlpreview;if sqltype <> PreviewSelect!	then
	if sqltype <> isql_criteria then
		return 2
	end if
end if
end event

event pfc_retrieve;call super::pfc_retrieve;long ll_job, ll_coil, ll_rc, ll_rows, ll_i, ll_row, ll_skid_id
ll_job = iu_coil.get_current_job( )
ll_coil = iu_coil.get_coil_abc_id( )
DataStore lds_prod_item

ll_rc = this.retrieve(ll_coil)
		lds_prod_item = create DataStore
		lds_prod_item.dataobject = "d_prod_item_for_skid"
		lds_prod_item.settransobject( sqlca)
		//lds_prod_item.retrieve( ll_skid_num )

ll_rows = this.rowcount( )

for ll_i = 1 to ll_rows
	ll_skid_id = this.object.sheet_skid_sheet_skid_num[ll_i]
	//To do list	
next




return ll_rc

end event

type dw_edit from u_dw within u_da_recap_skid_tabpg
integer x = 48
integer y = 915
integer width = 2677
integer height = 192
integer taborder = 20
string dataobject = "d_skid_item_current_recap_editor"
boolean vscrollbar = false
boolean livescroll = false
end type

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
	iu_tabpg_end_coil.postevent("ue_refresh")
//	of_total_wt_changed()
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

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_register("sheet_skid_sheet_net_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_register("production_sheet_item_prod_item_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_sheet_tare_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_skid_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
end event

event losefocus;call super::losefocus;this.accepttext( )
end event

event clicked;call super::clicked;//MessageBox(string(row), string(dwo.Name))
this.accepttext( )
end event

