$PBExportHeader$w_da_tabpg_offline_skid_edit.srw
forward
global type w_da_tabpg_offline_skid_edit from w_popup
end type
type cb_close from u_cb within w_da_tabpg_offline_skid_edit
end type
type cb_cancel from u_cb within w_da_tabpg_offline_skid_edit
end type
type cb_save from u_cb within w_da_tabpg_offline_skid_edit
end type
type dw_edit from u_dw within w_da_tabpg_offline_skid_edit
end type
end forward

global type w_da_tabpg_offline_skid_edit from w_popup
integer width = 2417
integer height = 739
string title = "Skid editor"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean center = true
boolean ib_isupdateable = false
cb_close cb_close
cb_cancel cb_cancel
cb_save cb_save
dw_edit dw_edit
end type
global w_da_tabpg_offline_skid_edit w_da_tabpg_offline_skid_edit

type variables
u_coil iu_coil
u_da_offline_skid_tabpg iu_da_skid_tabpg
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

end variables

forward prototypes
public subroutine wf_copy_row ()
end prototypes

public subroutine wf_copy_row ();long ll_row
ll_row = iu_da_skid_tabpg.il_edit_row
iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = dw_edit.object.sheet_skid_sheet_tare_wt[1]
iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = dw_edit.object.sheet_skid_sheet_net_wt[1]
iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = dw_edit.object.sheet_skid_skid_pieces[1]
iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = dw_edit.object.sheet_skid_sheet_theoretical_wt[1]
iu_da_skid_tabpg.dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = dw_edit.object.production_sheet_item_prod_item_pieces[1]
iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = dw_edit.object.sheet_skid_skid_sheet_status[1]
iu_da_skid_tabpg.dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = dw_edit.object.production_sheet_item_prod_item_net_wt[1]
iu_da_skid_tabpg.dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = dw_edit.object.production_sheet_item_prod_item_theoretical_wt[1]
iu_da_skid_tabpg.dw_skid_item.object.compute_0010[ll_row] = dw_edit.object.compute_0010[1]
iu_da_skid_tabpg.dw_skid_item.object.compute_0014[ll_row] = dw_edit.object.compute_0014[1]
//			dw_skid_item.object.item_status[ll_row] = 1
//			dw_skid_item.object.skid_status[ll_row] = 1
//			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
//			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
//

end subroutine

on w_da_tabpg_offline_skid_edit.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_edit=create dw_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.dw_edit
end on

on w_da_tabpg_offline_skid_edit.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_edit)
end on

type cb_close from u_cb within w_da_tabpg_offline_skid_edit
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

type cb_cancel from u_cb within w_da_tabpg_offline_skid_edit
integer x = 1463
integer y = 422
integer width = 512
integer height = 141
integer taborder = 30
integer textsize = -12
string facename = "Arial"
string text = "Cancel"
end type

event clicked;call super::clicked;dw_edit.resetupdate( )
close( parent )
end event

type cb_save from u_cb within w_da_tabpg_offline_skid_edit
integer x = 380
integer y = 422
integer width = 571
integer height = 141
integer taborder = 20
integer textsize = -12
string facename = "Arial"
string text = "Save"
end type

event clicked;call super::clicked;//if dw_edit.of_updatespending( ) = 1 then
//		if dw_edit.of_update( true, true) = 1 then
//			sqlca.of_commit( )
//		else
//			sqlca.of_rollback( )
//			MessageBox("Save skid", "Failded to save skid changes")
//			//sqlca.of_rollback( )
//			return 1
//		end if
	long ll_row
	ll_row = iu_da_skid_tabpg.il_edit_row
	dw_edit.accepttext( )
	if MessageBox("Save skid", "Do you want to save the changes?", Question!, YesNo!, 2) = 1 then
//		dw_edit.rowscopy( 1, 1, Primary!, iu_da_skid_tabpg.dw_skid_item, ll_row - 1 , Primary!)
		wf_copy_row()
		iu_da_skid_tabpg.of_save( )
		close( parent )
	end if
	
//end if
		
end event

type dw_edit from u_dw within w_da_tabpg_offline_skid_edit
integer x = 44
integer y = 38
integer width = 2311
integer height = 205
integer taborder = 10
string dataobject = "d_skid_item_editor"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//il_item = message.doubleparm
iu_da_skid_tabpg = message.powerobjectparm
iu_coil = iu_da_skid_tabpg.iu_coil
//il_item = gl_message
//string ls_tem[], ls_tem2[], ls_tem3[], ls_keys[]
long ll_rc
this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_register("sheet_skid_sheet_net_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_register("production_sheet_item_prod_item_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_sheet_tare_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("sheet_skid_skid_pieces", this.iuo_calculator.none )
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
this.of_setbase( true)
ll_rc = iu_da_skid_tabpg.il_edit_row
iu_da_skid_tabpg.dw_skid_item.rowscopy( ll_rc, ll_rc, Primary!, this, 1, Primary!)

//this.of_settransobject( sqlca)
//this.of_setmultitable( true)
//this.inv_multitable.of_getregisterable( ls_tem )
//this.inv_multitable.of_getregisterabletable( ls_tem3)
//this.inv_multitable.of_getregisterablecolumn( "production_sheet_item",ls_tem2  )
//this.inv_multitable.of_getregisterablecolumn( "sheet_skid",ls_tem2  )
//this.inv_multitable.of_getregisterablecolumn( "sheet_skid_detail",ls_tem2  )
//
//ll_rc = this.inv_multitable.of_register( "production_sheet_item", is_production_sheet_item_keys, &
//        is_production_sheet_item_cols, false, 0 )
//if ll_rc <> 1 then
//	MessageBox("dw_skid_item", "register failed")
//	return 0
//end if
//
//ll_rc = this.inv_multitable.of_register( "sheet_skid", is_sheet_skid_keys, is_sheet_skid_cols, false, 0 )
//
//if ll_rc <> 1 then
//	MessageBox("dw_skid_item", "register failed")
//	return 0
//end if
//
//ll_rc = this.inv_multitable.of_register( "sheet_skid_detail", is_sheet_skid_detail_keys )
//
//if ll_rc <> 1 then
//	MessageBox("dw_skid_item", "register failed")
//	return 0
//end if
//
//isql_criteria = PreviewUpdate!
//this.of_retrieve( )
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_item )
end event

event itemchanged;call super::itemchanged;long ll_skid_theo_wt, ll_item_theo_wt,ll_item_nw, ll_item_pieces,  ll_skid_nw, ll_skid_pieces

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
	ll_skid_theo_wt = ll_skid_pieces * iu_coil.of_get_theo_piece_wt( )
	ll_item_pieces = ll_skid_pieces - this.object.compute_0014[row]
	ll_item_pieces = this.object.production_sheet_item_prod_item_pieces[row] + ll_item_pieces
	ll_item_theo_wt = ll_item_pieces * iu_coil.of_get_theo_piece_wt( )
	if ll_item_pieces < 0 then
		return 1
	end if
	this.settext( string( ll_skid_pieces ))
	this.object.sheet_skid_sheet_theoretical_wt[row] = ll_skid_theo_wt
	this.object.production_sheet_item_prod_item_pieces[row] = ll_item_pieces
	this.object.production_sheet_item_prod_item_theoretical_wt[row] = ll_item_theo_wt
	this.object.compute_0014[row] = ll_skid_pieces
	return 0
else
	return 0
end if

return 1
end event

