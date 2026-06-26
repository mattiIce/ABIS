$PBExportHeader$w_stacker_skid_edit.srw
forward
global type w_stacker_skid_edit from w_popup
end type
type st_1 from statictext within w_stacker_skid_edit
end type
type cb_close from u_cb within w_stacker_skid_edit
end type
type cb_cancel from u_cb within w_stacker_skid_edit
end type
type cb_save from u_cb within w_stacker_skid_edit
end type
type dw_edit from u_dw within w_stacker_skid_edit
end type
end forward

global type w_stacker_skid_edit from w_popup
integer width = 2417
integer height = 739
string title = "Skid editor"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean ib_isupdateable = false
st_1 st_1
cb_close cb_close
cb_cancel cb_cancel
cb_save cb_save
dw_edit dw_edit
end type
global w_stacker_skid_edit w_stacker_skid_edit

type variables
//u_coil iu_coil
//u_office_recap_tabpg_bl110 iu_da_skid_tabpg
long il_item
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


long il_current_row
int ii_action

end variables

forward prototypes
public subroutine wf_copy_row ()
public function integer wf_data_validation ()
public function integer of_delete_rows ()
public function integer of_save ()
end prototypes

public subroutine wf_copy_row ();//long ll_row
//ll_row = iu_da_skid_tabpg.il_edit_row
//iu_da_skid_tabpg.dw_skid_list.object.sheet_skid_sheet_tare_wt[ll_row] = dw_edit.object.sheet_skid_sheet_tare_wt[1]
//iu_da_skid_tabpg.dw_skid_list.object.sheet_skid_sheet_net_wt[ll_row] = dw_edit.object.sheet_skid_sheet_net_wt[1]
//iu_da_skid_tabpg.dw_skid_list.object.sheet_skid_skid_pieces[ll_row] = dw_edit.object.sheet_skid_skid_pieces[1]
//iu_da_skid_tabpg.dw_skid_list.object.sheet_skid_sheet_theoretical_wt[ll_row] = dw_edit.object.sheet_skid_sheet_theoretical_wt[1]
//iu_da_skid_tabpg.dw_skid_list.object.production_sheet_item_prod_item_pieces[ll_row] = dw_edit.object.production_sheet_item_prod_item_pieces[1]
//iu_da_skid_tabpg.dw_skid_list.object.sheet_skid_skid_sheet_status[ll_row] = dw_edit.object.sheet_skid_skid_sheet_status[1]
//iu_da_skid_tabpg.dw_skid_list.object.production_sheet_item_prod_item_net_wt[ll_row] = dw_edit.object.production_sheet_item_prod_item_net_wt[1]
//iu_da_skid_tabpg.dw_skid_list.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = dw_edit.object.production_sheet_item_prod_item_theoretical_wt[1]
//iu_da_skid_tabpg.dw_skid_list.object.compute_0010[ll_row] = dw_edit.object.compute_0010[1]
//iu_da_skid_tabpg.dw_skid_list.object.compute_0014[ll_row] = dw_edit.object.compute_0014[1]
//			dw_skid_list.object.item_status[ll_row] = 1
//			dw_skid_list.object.skid_status[ll_row] = 1
//			dw_skid_list.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
//			dw_skid_list.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
//

end subroutine

public function integer wf_data_validation ();long ll_wt_limit
//ll_wt_limit = iu_coil.get_old_nw( ) + iu_coil.get_old_nw( ) * 0.11
ll_wt_limit = 30000
if dw_edit.object.sheet_skid_sheet_tare_wt[1] < 0 or dw_edit.object.sheet_skid_sheet_tare_wt[1] > 8000 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid tare weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_edit.object.production_sheet_item_prod_item_net_wt[1] < 0 or dw_edit.object.production_sheet_item_prod_item_net_wt[1] > ll_wt_limit then
	this.of_messagebox( "id_data_error", "Data error", "Invalid skid weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_edit.object.production_sheet_item_prod_item_theoretical_wt[1] < 1 or dw_edit.object.production_sheet_item_prod_item_theoretical_wt[1] > ll_wt_limit then
	this.of_messagebox( "id_data_error", "Data error", "Invalid skid pieces!", Exclamation!, Ok!, 1)
	return 1
end if

return 0 //return 0 if validated
end function

public function integer of_delete_rows ();//return 1 if sucess
//return -1 error
long ll_prod_item_num, ll_item_pieces		   
long ll_skid_pieces,ll_skid_theo_wt,ll_item_nw,ll_skid_num,row
long ll_item_theo_wt, ll_item_count, ll_rc, ll_i
//int li_line_id
ll_rc = dw_edit.deletedcount( )
if ll_rc < 1 then
	return 1
end if
//ll_rc = 1
//li_line_id = iw_sheet.ii_line_id
for ll_i = 1 to ll_rc
	if dw_edit.getitemstatus( ll_i, 0 , Delete!)	= 	New!	then
		CONTINUE
	end if
	
	if dw_edit.getitemnumber( ll_i, "item_status", Delete!, false) > 10000 then
		CONTINUE
	end if
	
			ll_prod_item_num=dw_edit.getitemnumber(ll_i, "production_sheet_item_prod_item_num", Delete!, false)
			ll_skid_num=dw_edit.getitemnumber(ll_i, "sheet_skid_detail_sheet_skid_num", Delete!, false)
			
//			MessageBox(string(ll_prod_item_num), string(ll_skid_num))
			
//			  UPDATE "LINE_CURRENT_STATUS"  
//     			SET "SHEET_SKID_NUM" = null  
//   			WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id
//				and "LINE_CURRENT_STATUS"."SHEET_SKID_NUM" = :ll_skid_num
//           ;
//			if sqlca.sqlcode <> 0 then
//					MessageBox("", "Update failed line_current_status" )
//					return -1
//				end if
			
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
		//ll_skid_pieces = ll_item_pieces - dw_skid_item.object.production_sheet_item_prod_item_pieces_1[row] + dw_edit.object.sheet_skid_skid_pieces[row]
		//ll_skid_theo_wt = ll_skid_pieces * iu_coil.of_get_theo_piece_wt( )
		ll_item_pieces = &
			dw_edit.getitemnumber( ll_i, "production_sheet_item_prod_item_pieces", Delete!, false)
		ll_item_nw = &
			dw_edit.getitemnumber( ll_i, "production_sheet_item_prod_item_net_wt", Delete!, false)
		
		ll_item_theo_wt = ll_item_pieces * dw_edit.getitemnumber( ll_i, "order_item_theoretical_unit_wt", Delete!, false)
		
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

public function integer of_save ();int li_rc

dw_edit.accepttext( )
//dw_current_edit.accepttext( )

//if of_delete_rows() <> 1 then
//	//sqlca.of_commit( )
//	//dw_edit.resetupdate( )
////else
//	sqlca.of_rollback( )
//	MessageBox("Delete", "Delete function failed", StopSign!)
//	return 1
//end if

li_rc = dw_edit.of_update( true, true)
if li_rc <> 1 then
//	sqlca.of_commit( )
//else
	sqlca.of_rollback( )
	MessageBox("Update", "Update failed!", StopSign!)
	return 1
end if
sqlca.of_commit( )
//iu_coil.of_update_from_skid_scrap( )
return 0
end function

on w_stacker_skid_edit.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_edit=create dw_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_edit
end on

on w_stacker_skid_edit.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_edit)
end on

event clicked;call super::clicked;dw_edit.accepttext( )
end event

event open;call super::open;if gi_screen = 2 then
	if gi_dual_mode = 2 then
		this.x = 1200
		this.y = 4000
	else
		this.x = 7000
		this.y = 600
	end if
else
	this.x = 1200
	this.y = 600
end if

end event

type st_1 from statictext within w_stacker_skid_edit
boolean visible = false
integer x = 55
integer y = 307
integer width = 329
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_stacker_skid_edit
boolean visible = false
integer x = 980
integer y = 435
integer width = 351
integer height = 102
integer taborder = 30
integer textsize = -12
string facename = "Arial"
boolean enabled = false
string text = "Close"
end type

event clicked;call super::clicked;//if dw_edit.of_updatespending( ) = 1 then
//	if MessageBox("skid edit", "Do you want to save changes?", Question!, YesNo!, 1) = 1 then
//		parent.cb_save.event clicked( )
//	end if
//end if
Close( parent )
end event

type cb_cancel from u_cb within w_stacker_skid_edit
integer x = 1463
integer y = 422
integer width = 512
integer height = 141
integer taborder = 40
integer textsize = -12
string facename = "Arial"
string text = "Cancel"
end type

event clicked;call super::clicked;dw_edit.resetupdate( )
CloseWithReturn(parent, -1)
//if ii_action = 1 then
//	CloseWithReturn(parent, 2)
//elseif ii_action = 2 then
//	close( parent )
//else
//	//
//end if
end event

type cb_save from u_cb within w_stacker_skid_edit
integer x = 380
integer y = 422
integer width = 571
integer height = 141
integer taborder = 20
integer textsize = -12
string facename = "Arial"
string text = "Ok"
end type

event clicked;call super::clicked;long ll_skid_wt
	if wf_data_validation() <> 0 then
		return 1
	end if
if of_save() = 0 then
	ll_skid_wt = dw_edit.object.sheet_skid_sheet_net_wt[1]
	Closewithreturn(parent, ll_skid_wt )
else
	return 1
end if
////if dw_edit.of_updatespending( ) = 1 then
////		if dw_edit.of_update( true, true) = 1 then
////			sqlca.of_commit( )
////		else
////			sqlca.of_rollback( )
////			MessageBox("Save skid", "Failded to save skid changes")
////			//sqlca.of_rollback( )
////			return 1
////		end if
//	long ll_row
//	ll_row = iu_da_skid_tabpg.il_edit_row
//	dw_edit.accepttext( )
//	if wf_data_validation() <> 0 then
//		return 1
//	end if
//	
////	if MessageBox("Save skid", "Do you want to save the changes?", Question!, YesNo!, 2) = 1 then
////		wf_copy_row()
////		iu_da_skid_tabpg.of_save_skid_item( )
////		close( parent )
////	end if
//	
	
//	if ii_action = 1 then
//		wf_copy_row( )
//		CloseWithReturn(parent, 1)
//	elseif ii_action = 2 then
//		wf_copy_row()
//		close( parent )
//	else
//	end if
//	
	
		
end event

type dw_edit from u_dw within w_stacker_skid_edit
integer x = 44
integer y = 38
integer width = 2304
integer height = 202
integer taborder = 10
string dataobject = "d_stacker_skid_item_editor"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//il_item = message.doubleparm
//iu_da_skid_tabpg = message.powerobjectparm
//iu_coil = iu_da_skid_tabpg.iu_coil

//if gi_screen = 2 then
//	if gi_dual_mode = 2 then
//		parent.x = 1200
//		parent.y = 4000
//	else
//		parent.x = 7000
//		parent.y = 600
//	end if
//else
//	parent.x = 1200
//	parent.y = 600
//end if


//il_item = gl_message
string ls_tem[], ls_tem2[], ls_tem3[], ls_keys[]
long ll_rc
il_item = message.doubleparm
//st_1.text = string( il_item )
this.of_setdropdowncalculator( true)
this.iuo_calculator.of_register("sheet_skid_sheet_net_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("production_sheet_item_prod_item_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_sheet_tare_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_skid_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
this.of_setbase( true)

//ll_rc = iu_da_skid_tabpg.il_edit_row
//ii_action = iu_da_skid_tabpg.ii_skid_edit_action
////if ii_action = 2 then &
//	iu_da_skid_tabpg.dw_skid_list.rowscopy( ll_rc, ll_rc, Primary!, this, 1, Primary!)

//if this.object.production_sheet_item_prod_item_net_wt[1] < 1 then
//	if iu_da_skid_tabpg.iw_sheet.ib_skid_scale_connected then
//		this.object.sheet_skid_sheet_net_wt.Protect = 1
//	end if
//else
//	this.object.sheet_skid_sheet_net_wt.Protect = 0
//end if
	
	
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
this.of_retrieve( )
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_item )
end event

event itemchanged;call super::itemchanged;long ll_skid_theo_wt, ll_item_theo_wt,ll_item_nw, ll_item_pieces,  ll_skid_nw, ll_skid_pieces//, ll_theo_unit_wt

Double ld_theo_unit_wt

if dwo.Name = "sheet_skid_sheet_net_wt" then
	ll_skid_nw = Long( data )
	if ll_skid_nw < 0 then
		return 1
	end if
	ll_item_nw = ll_skid_nw	- this.object.compute_0010[row]
	ll_item_nw = this.object.production_sheet_item_prod_item_net_wt[row] + ll_item_nw
//	if ll_item_nw < 0 then
//		return 1
//	end if
	
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
//	if ll_item_pieces < 0 then
//		return 1
//	end if
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
		return 0
	end if

else
	return 0
end if

return 1

end event

event clicked;call super::clicked;this.accepttext( )
end event

event sqlpreview;call super::sqlpreview;if sqltype <> PreviewSelect!	then
	if sqltype <> isql_criteria then
		return 2
	end if
end if
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

