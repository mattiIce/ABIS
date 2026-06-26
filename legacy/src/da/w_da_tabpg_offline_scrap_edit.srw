$PBExportHeader$w_da_tabpg_offline_scrap_edit.srw
forward
global type w_da_tabpg_offline_scrap_edit from w_popup
end type
type cb_close from u_cb within w_da_tabpg_offline_scrap_edit
end type
type cb_cancel from u_cb within w_da_tabpg_offline_scrap_edit
end type
type cb_save from u_cb within w_da_tabpg_offline_scrap_edit
end type
type dw_edit from u_dw within w_da_tabpg_offline_scrap_edit
end type
end forward

global type w_da_tabpg_offline_scrap_edit from w_popup
integer width = 2834
integer height = 739
string title = "Scrap editor"
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
global w_da_tabpg_offline_scrap_edit w_da_tabpg_offline_scrap_edit

type variables
//u_coil iu_coil
u_da_offline_scrap_tabpg iu_da_scrap_tabpg
long il_scrap_skid_wt, il_scrap_id
//SQLPreviewType isql_criteria

//string is_PRODUCTION_SHEET_ITEM_keys[] = {"production_sheet_item_prod_item_num" }
//string is_PRODUCTION_SHEET_ITEM_cols[] = & 
//{"production_sheet_item_prod_item_pieces", "production_sheet_item_prod_item_net_wt","production_sheet_item_prod_item_num", &
//"production_sheet_item_prod_item_theoretical_wt"}
//string is_SHEET_SKID_DETAIL_keys[] ={"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
//string is_SHEET_SKID_DETAIL_cols[] = &
//{"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
//string is_SHEET_SKID_keys[]={"sheet_skid_sheet_skid_num"}
//string is_SHEET_SKID_cols[] = &
//{"sheet_skid_sheet_tare_wt","sheet_skid_sheet_net_wt","sheet_skid_skid_pieces", "sheet_skid_sheet_theoretical_wt","sheet_skid_skid_sheet_status"}
//
//
//long il_current_row

end variables

forward prototypes
public subroutine wf_copy_row ()
public function integer wf_data_validation ()
end prototypes

public subroutine wf_copy_row ();long ll_row, ll_scrap_nw, ll_i, ll_rc, ll_scrap_id
ll_row = iu_da_scrap_tabpg.il_edit_row
iu_da_scrap_tabpg.dw_scrap.object.return_scrap_item_return_item_net_wt[ll_row] = dw_edit.object.return_scrap_item_return_item_net_wt[1]
iu_da_scrap_tabpg.dw_scrap.object.compute_0015[ll_row] = dw_edit.object.compute_0015[1]
iu_da_scrap_tabpg.dw_scrap.object.return_scrap_item_scrap_item_pieces[ll_row] = dw_edit.object.return_scrap_item_scrap_item_pieces[1]
iu_da_scrap_tabpg.dw_scrap.object.return_scrap_item_return_item_notes[ll_row] = dw_edit.object.return_scrap_item_return_item_notes[1]
iu_da_scrap_tabpg.dw_scrap.object.return_scrap_item_scrap_item_type[ll_row] = dw_edit.object.return_scrap_item_scrap_item_type[1]
iu_da_scrap_tabpg.dw_scrap.object.return_scrap_item_mill[ll_row] = dw_edit.object.return_scrap_item_mill[1]
iu_da_scrap_tabpg.dw_scrap.object.return_scrap_item_od[ll_row] = dw_edit.object.return_scrap_item_od[1]
ll_scrap_nw = dw_edit.object.scrap_skid_scrap_net_wt[1]
if il_scrap_skid_wt <> ll_scrap_nw then
	ll_scrap_id = dw_edit.object.scrap_skid_scrap_skid_num[1]
	ll_rc = iu_da_scrap_tabpg.dw_scrap.rowcount( )
	for ll_i=1 to ll_rc
		if iu_da_scrap_tabpg.dw_scrap.object.scrap_skid_scrap_skid_num[ll_i] = ll_scrap_id then
			iu_da_scrap_tabpg.dw_scrap.object.scrap_skid_scrap_net_wt[ll_i] = ll_scrap_nw
		end if
	next
	if iu_da_scrap_tabpg.istr_scrap_skid.partial_skid_num = ll_scrap_id then
		iu_da_scrap_tabpg.istr_scrap_skid.partial_skid_net_wt = ll_scrap_nw
	end if
end if


iu_da_scrap_tabpg.dw_scrap.object.scrap_skid_scrap_net_wt[ll_row] = dw_edit.object.scrap_skid_scrap_net_wt[1]
	





//iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_tare_wt[ll_row] = dw_edit.object.sheet_skid_sheet_tare_wt[1]
//iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_net_wt[ll_row] = dw_edit.object.sheet_skid_sheet_net_wt[1]
//iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_skid_pieces[ll_row] = dw_edit.object.sheet_skid_skid_pieces[1]
//iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_theoretical_wt[ll_row] = dw_edit.object.sheet_skid_sheet_theoretical_wt[1]
//iu_da_skid_tabpg.dw_skid_item.object.production_sheet_item_prod_item_pieces[ll_row] = dw_edit.object.production_sheet_item_prod_item_pieces[1]
//iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_skid_sheet_status[ll_row] = dw_edit.object.sheet_skid_skid_sheet_status[1]
//iu_da_skid_tabpg.dw_skid_item.object.production_sheet_item_prod_item_net_wt[ll_row] = dw_edit.object.production_sheet_item_prod_item_net_wt[1]
//iu_da_skid_tabpg.dw_skid_item.object.production_sheet_item_prod_item_theoretical_wt[ll_row] = dw_edit.object.production_sheet_item_prod_item_theoretical_wt[1]
//iu_da_skid_tabpg.dw_skid_item.object.compute_0010[ll_row] = dw_edit.object.compute_0010[1]
//iu_da_skid_tabpg.dw_skid_item.object.compute_0014[ll_row] = dw_edit.object.compute_0014[1]
//			dw_skid_item.object.item_status[ll_row] = 1
//			dw_skid_item.object.skid_status[ll_row] = 1
//			dw_skid_item.object.sheet_skid_detail_prod_item_num[ll_row] = ll_prod_item_seq
//			dw_skid_item.object.sheet_skid_detail_sheet_skid_num[ll_row] = ll_skid_seq
//

end subroutine

public function integer wf_data_validation ();//long ll_wt_limit
//ll_wt_limit = 9000
if dw_edit.object.return_scrap_item_return_item_net_wt[1] < 1 or dw_edit.object.return_scrap_item_return_item_net_wt[1] > 8000 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid net weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_edit.object.return_scrap_item_scrap_item_pieces[1] < 1 or dw_edit.object.return_scrap_item_scrap_item_pieces[1] > 999 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid scrap pieces!", Exclamation!, Ok!, 1)
	return 1
end if


return 0 //return 0 if validated
end function

on w_da_tabpg_offline_scrap_edit.create
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

on w_da_tabpg_offline_scrap_edit.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_edit)
end on

event clicked;call super::clicked;dw_edit.accepttext( )
end event

type cb_close from u_cb within w_da_tabpg_offline_scrap_edit
boolean visible = false
integer x = 161
integer y = 461
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

type cb_cancel from u_cb within w_da_tabpg_offline_scrap_edit
integer x = 1755
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

type cb_save from u_cb within w_da_tabpg_offline_scrap_edit
integer x = 673
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
	dw_edit.accepttext( )
//	ll_row = iu_da_skid_tabpg.il_edit_row
	
	if wf_data_validation() <> 0 then
		return 1
	end if
	
	if MessageBox("Save skid", "Do you want to save the changes?", Question!, YesNo!, 2) = 1 then
//		dw_edit.rowscopy( 1, 1, Primary!, iu_da_skid_tabpg.dw_skid_item, ll_row - 1 , Primary!)
		wf_copy_row()
		iu_da_scrap_tabpg.of_save( )
		close( parent )
	end if
	
//end if
		
end event

type dw_edit from u_dw within w_da_tabpg_offline_scrap_edit
integer x = 15
integer y = 38
integer width = 2794
integer height = 179
integer taborder = 10
string dataobject = "d_scrap_edit"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//il_item = message.doubleparm
iu_da_scrap_tabpg = message.powerobjectparm
//iu_coil = iu_da_scrap_tabpg.iu_coil
this.of_setbase( true)
this.of_SetDropDownCalculator(TRUE)
this.iuo_calculator.of_Register("return_scrap_item_return_item_net_wt", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("return_scrap_item_scrap_item_pieces", &
this.iuo_calculator.NONE)
this.inv_base.of_populatedddw( )
long ll_rc
ll_rc = iu_da_scrap_tabpg.il_edit_row
iu_da_scrap_tabpg.dw_scrap.rowscopy( ll_rc, ll_rc, Primary!, this, 1, Primary!)
il_scrap_skid_wt = this.object.scrap_skid_scrap_net_wt[1]

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
//	if iu_da_scrap_tabpg.istr_scrap_skid.partial_skid_num = ll_scrap_skid_id then
//		iu_da_scrap_tabpg.istr_scrap_skid.partial_skid_net_wt = ll_scrap_skid_wt
//	end if
	this.object.compute_0015[row] = ll_item_nw
end if
return 0

end event

event sqlpreview;call super::sqlpreview;//if sqltype <> PreviewSelect!	then
//	if sqltype <> isql_criteria then
//		return 2
//	end if
//end if
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF as_colname = "return_scrap_item_scrap_item_type" THEN
	adwc_obj.SetTransObject(SQLCA)
	Return adwc_obj.Retrieve()
ELSE
	Return 0
END IF
end event

event losefocus;return 0
end event

event itemfocuschanged;//dwo.
return 0
end event

