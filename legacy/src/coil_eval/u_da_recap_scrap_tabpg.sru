$PBExportHeader$u_da_recap_scrap_tabpg.sru
forward
global type u_da_recap_scrap_tabpg from u_tabpg
end type
type st_8 from statictext within u_da_recap_scrap_tabpg
end type
type st_7 from statictext within u_da_recap_scrap_tabpg
end type
type st_6 from statictext within u_da_recap_scrap_tabpg
end type
type st_5 from statictext within u_da_recap_scrap_tabpg
end type
type st_4 from statictext within u_da_recap_scrap_tabpg
end type
type st_3 from statictext within u_da_recap_scrap_tabpg
end type
type st_2 from statictext within u_da_recap_scrap_tabpg
end type
type cb_cancel from u_cb within u_da_recap_scrap_tabpg
end type
type cb_edit from u_cb within u_da_recap_scrap_tabpg
end type
type st_1 from statictext within u_da_recap_scrap_tabpg
end type
type dw_edit from u_dw within u_da_recap_scrap_tabpg
end type
type cb_retrieve from commandbutton within u_da_recap_scrap_tabpg
end type
type cb_scrap_print from commandbutton within u_da_recap_scrap_tabpg
end type
type cb_save from commandbutton within u_da_recap_scrap_tabpg
end type
type dw_scrap from u_dw within u_da_recap_scrap_tabpg
end type
end forward

global type u_da_recap_scrap_tabpg from u_tabpg
integer width = 2765
integer height = 1232
long backcolor = 65535
string text = "SCRAP"
long tabbackcolor = 65535
boolean ib_isupdateable = false
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_cancel cb_cancel
cb_edit cb_edit
st_1 st_1
dw_edit dw_edit
cb_retrieve cb_retrieve
cb_scrap_print cb_scrap_print
cb_save cb_save
dw_scrap dw_scrap
end type
global u_da_recap_scrap_tabpg u_da_recap_scrap_tabpg

type variables
string is_title
//w_da_sheet iw_sheet
long il_scrap_skid_num, il_edit_row  //, al_sheet_skid_num
//w_tare iw_tare
//w_load_partial iw_load_partial
//w_load_scrap_tare iw_load_scrap_tare
//w_scrap_type iw_scrap_type
s_partial_skid istr_scrap_skid
u_coil iu_coil
u_tabpg_end_coil iu_tabpg_end_coil
int ii_scrap_type
int ii_pre_scrap_type
Datastore ids_copy
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
public subroutine of_add_scrap_item (integer ai_pcs, long al_wt, integer ai_type)
public subroutine of_print_scrap_ticket (long al_skid_num, long al_net, long al_tare)
public function integer of_delete_item (long al_item_num, long al_skid_num, long al_item_nw)
public subroutine of_init (readonly u_coil au_coil, readonly u_tabpg_end_coil au_tabpg)
public function integer of_data_validation (long al_row)
end prototypes

public subroutine of_add_scrap_item (integer ai_pcs, long al_wt, integer ai_type);long ll_scrap_seq, ll_job, ll_coil,ll_rc, ll_cust_id,ll_shift_num
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
	dw_scrap.object.return_scrap_item_return_item_notes[ll_rc] = "Add quality note here"
	dw_scrap.object.return_scrap_item_return_scrap_item_num[ll_rc] = ll_scrap_seq
	dw_scrap.object.return_scrap_item_coil_abc_num[ll_rc] = ll_coil
	dw_scrap.object.return_scrap_item_ab_job_num[ll_rc] = ll_job
	dw_scrap.object.return_scrap_item_scrap_item_type[ll_rc] = ai_type
	dw_scrap.object.return_scrap_item_mill[ll_rc] = li_mill
	dw_scrap.object.return_scrap_item_od[ll_rc] = li_od
	
	//dw_scrap.object.return_scrap_item_return_item_date = DateTime(Today(),Now())
	dw_scrap.setitem( ll_rc, "return_scrap_item_return_item_date", DateTime(Today(),Now()))
	
	dw_scrap.object.scrap_skid_detail_scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num
	dw_scrap.object.scrap_skid_scrap_net_wt[ll_rc] = istr_scrap_skid.partial_skid_net_wt + al_wt
	dw_scrap.object.scrap_skid_detail_return_scrap_item_num[ll_rc] = ll_scrap_seq
	dw_scrap.object.scrap_skid_scrap_skid_num[ll_rc] = istr_scrap_skid.partial_skid_num 
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
//	dw_edit.scrolltorow( ll_rc)
	
	
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

public subroutine of_init (readonly u_coil au_coil, readonly u_tabpg_end_coil au_tabpg);//iw_sheet = aw_1
if isValid( au_coil ) then
	iu_coil = au_coil
end if

if isValid( au_tabpg) then
	iu_tabpg_end_coil = au_tabpg
end if

//dw_scrap.of_retrieve( )
//dw_skid_item.of_retrieve( )
dw_scrap.inv_base.of_populatedddw( )
is_title = "Scrap item"

if isValid(iu_coil.of_get_scrap_tab_page( )) then
	//online mode
	iu_coil.of_get_scrap_tab_page( ).dw_scrap.sharedata( dw_scrap )
else //offline mode
//	iu_coil.of_get_scrap_offline_tab_page( ).dw_scrap.sharedata( dw_scrap )
end if



//dw_scrap

//long ll_row
//dw_scrap_type.settransobject( sqlca)
//dw_scrap_type.retrieve( )
//dw_scrap.inv_base.of_populatedddw( )
//dw_scrap.sharedata( dw_edit)
//ll_row = dw_scrap_type.insertrow( 0 )
//dw_scrap_type.object.id[ll_row] = 0
ii_pre_scrap_type = 0
ii_scrap_type = 0
end subroutine

public function integer of_data_validation (long al_row);if dw_edit.object.scrap_item_net_wt[al_row] < 1 or dw_edit.object.scrap_item_net_wt[al_row] > 8000 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid net weight!", Exclamation!, Ok!, 1)
	return 1
end if

if dw_edit.object.scrap_item_piece[al_row] < 1 or dw_edit.object.scrap_item_piece[al_row] > 999 then
	this.of_messagebox( "id_data_error", "Data error", "Invalid scrap pieces!", Exclamation!, Ok!, 1)
	return 1
end if


return 0 //return 0 if validated
end function

on u_da_recap_scrap_tabpg.create
int iCurrent
call super::create
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.cb_edit=create cb_edit
this.st_1=create st_1
this.dw_edit=create dw_edit
this.cb_retrieve=create cb_retrieve
this.cb_scrap_print=create cb_scrap_print
this.cb_save=create cb_save
this.dw_scrap=create dw_scrap
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_8
this.Control[iCurrent+2]=this.st_7
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.cb_edit
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_edit
this.Control[iCurrent+12]=this.cb_retrieve
this.Control[iCurrent+13]=this.cb_scrap_print
this.Control[iCurrent+14]=this.cb_save
this.Control[iCurrent+15]=this.dw_scrap
end on

on u_da_recap_scrap_tabpg.destroy
call super::destroy
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.cb_edit)
destroy(this.st_1)
destroy(this.dw_edit)
destroy(this.cb_retrieve)
destroy(this.cb_scrap_print)
destroy(this.cb_save)
destroy(this.dw_scrap)
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
//if isValid(iw_load_scrap_tare) then
//	Close( iw_load_scrap_tare )
//end if
//
//if isValid(iw_scrap_type) then
//	Close( iw_scrap_type )
//end if

if dw_scrap.of_updatespending( ) = 1 then
	if MessageBox("Downtime", "Data changed, Save it?", Exclamation!, YesNo!, 2) = 2 then
				dw_scrap.resetupdate( )
				return 0
	end if
	cb_save.event clicked( )
end if
return 0
end event

event constructor;call super::constructor;ids_copy = create Datastore
ids_copy.dataobject = "d_quality_scrap_work_sheet"
//iw_sheet = message.powerobjectparm
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

type st_8 from statictext within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 995
integer y = 614
integer width = 380
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Defect Code"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_7 from statictext within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 91
integer y = 614
integer width = 362
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pallet ID"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 91
integer y = 528
integer width = 366
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Note"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 2231
integer y = 442
integer width = 183
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "OD"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 2531
integer y = 442
integer width = 150
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mill"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 918
integer y = 442
integer width = 238
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pieces"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 88
integer y = 442
integer width = 234
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Net Wt"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_cancel from u_cb within u_da_recap_scrap_tabpg
integer x = 1192
integer y = 1130
integer width = 351
integer height = 93
integer taborder = 110
integer textsize = -10
string facename = "Arial"
boolean enabled = false
string text = "Cancel"
end type

event clicked;call super::clicked;if dw_edit.rowcount( ) < 1 then
	return 1
end if
long ll_row, ll_rc, ll_i
ll_row = dw_edit.getrow( )

if ll_row <> il_edit_row then
	dw_edit.sharedataoff( )
	return 1
end if

ll_rc = dw_edit.rowcount( )

For ll_i = 1 to ll_rc
	dw_edit.object.Data[ll_i] = ids_copy.object.Data[ll_i]
next


//  istr_scrap_skid

if isValid(iu_coil.of_get_scrap_tab_page( )) then
	iu_coil.of_get_scrap_tab_page( ).istr_scrap_skid = istr_scrap_skid
else
//	iu_coil.of_get_scrap_offline_tab_page( ).istr_scrap_skid =istr_scrap_skid
end if

ids_copy.reset()
dw_edit.sharedataoff( )
this.enabled = false
cb_save.enabled = false
cb_edit.enabled = true
end event

type cb_edit from u_cb within u_da_recap_scrap_tabpg
integer x = 695
integer y = 1130
integer width = 351
integer height = 93
integer taborder = 120
integer textsize = -10
string facename = "Arial"
string text = "Edit"
end type

event clicked;call super::clicked;long ll_row, ll_rc

if dw_edit.rowcount( ) > 0 then
	MessageBox("Edit skid", "Please save or cancel current edit skid first!")
	return 1
end if

ll_row = dw_scrap.getselectedrow(0)
if ll_row < 1 then
	MessageBox("Edit skid", "Please select a skid to edit!")
	return 1
end if

il_edit_row = ll_row
ll_rc = dw_scrap.rowcount( )
dw_scrap.sharedata( dw_edit )
dw_edit.scrolltorow( il_edit_row )
dw_edit.setrow( il_edit_row )
dw_edit.rowscopy( 1, ll_rc, Primary!, ids_copy , 1, Primary!)
//MessageBox(string(ll_rc), string( ids_copy.rowcount()) )
cb_cancel.enabled = true
cb_save.enabled = true
this.enabled = false
if isValid(iu_coil.of_get_scrap_tab_page( )) then
	istr_scrap_skid = iu_coil.of_get_scrap_tab_page( ).istr_scrap_skid
else
//	istr_scrap_skid = iu_coil.of_get_scrap_offline_tab_page( ).istr_scrap_skid
end if
end event

type st_1 from statictext within u_da_recap_scrap_tabpg
integer x = 22
integer y = 880
integer width = 135
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Edtor"
boolean focusrectangle = false
end type

type dw_edit from u_dw within u_da_recap_scrap_tabpg
integer x = 15
integer y = 931
integer width = 2721
integer height = 189
integer taborder = 160
string dataobject = "d_recap_ed_scrap_work_sheet"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_register("scrap_item_net_wt", this.iuo_calculator.none )
this.iuo_calculator.of_register("scrap_item_piece", this.iuo_calculator.none )
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
this.of_setbase( true)
this.of_settransobject( sqlca)
end event

event itemchanged;call super::itemchanged;//long ll_item_num, ll_item_nw, ll_diff, ll_scrap_skid_wt, ll_scrap_skid_id, ll_i, ll_rc
if dwo.Name = "scrap_item_net_wt" then
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
//	
//	if isValid(iu_coil.of_get_scrap_tab_page( )) then
//		if iu_coil.of_get_scrap_tab_page( ).istr_scrap_skid.partial_skid_num = ll_scrap_skid_id then
//			iu_coil.of_get_scrap_tab_page( ).istr_scrap_skid.partial_skid_net_wt = ll_scrap_skid_wt
//		end if
//	else
//		if iu_coil.of_get_scrap_offline_tab_page( ).istr_scrap_skid.partial_skid_num = ll_scrap_skid_id then
//			iu_coil.of_get_scrap_offline_tab_page( ).istr_scrap_skid.partial_skid_net_wt = ll_scrap_skid_wt
//		end if
//	end if
//	
//	
//	this.object.compute_0015[row] = ll_item_nw
	iu_tabpg_end_coil.postevent( "ue_refresh")
	
end if
return 0
end event

event losefocus;call super::losefocus;this.of_accepttext( true)
end event

event clicked;call super::clicked;this.of_accepttext( true)
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF as_colname = "scrap_item_type" THEN
	adwc_obj.SetTransObject(SQLCA)
	Return adwc_obj.Retrieve()
ELSE
	Return 0
END IF

end event

type cb_retrieve from commandbutton within u_da_recap_scrap_tabpg
boolean visible = false
integer x = 1404
integer y = 1117
integer width = 395
integer height = 102
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

type cb_scrap_print from commandbutton within u_da_recap_scrap_tabpg
integer x = 1690
integer y = 1130
integer width = 395
integer height = 93
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
	
if isValid(iu_coil.of_get_scrap_tab_page( )) then
		if iu_coil.of_get_scrap_tab_page( ).of_update_scrap_skid_item( ) <> 0 then
			MessageBox("DB Error", "Can not update scrap skid!")
			return 1
		end if

else
//	iu_coil.of_get_scrap_offline_tab_page( ).of_save( )
end if


//	if of_update_scrap_skid_item( ) <> 0 then
//		MessageBox("DB Error", "Can not update scrap skid!")
//		return 1
//	end if
	
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

type cb_save from commandbutton within u_da_recap_scrap_tabpg
integer x = 2231
integer y = 1130
integer width = 395
integer height = 93
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Save"
end type

event clicked;long ll_row
//int li_rc
//

if dw_edit.rowcount( ) < 1 then
	return 1
end if

dw_scrap.accepttext( )
dw_edit.accepttext( )

ll_row = dw_edit.getrow( )

if ll_row <> il_edit_row then
	return 1
end if

if of_data_validation( il_edit_row ) <> 0 then
	return 1
end if

if isValid(iu_coil.of_get_scrap_tab_page( )) then
	iu_coil.of_get_scrap_tab_page( ).of_save( )
else
//	iu_coil.of_get_scrap_offline_tab_page( ).of_save( )
end if
dw_edit.sharedataoff( )
this.enabled = false
cb_cancel.enabled = false
cb_edit.enabled = true
end event

type dw_scrap from u_dw within u_da_recap_scrap_tabpg
integer x = 7
integer y = 13
integer width = 2747
integer height = 861
integer taborder = 150
string dataobject = "d_quality_scrap_work_sheet"
boolean hscrollbar = true
boolean livescroll = false
boolean ib_isupdateable = false
end type

event pfc_retrieve;call super::pfc_retrieve;//return this.retrieve( il_coil_num, il_job_num )
long ll_job, ll_coil
ll_job = iu_coil.get_current_job( )
ll_coil = iu_coil.get_coil_abc_id( )
return this.retrieve(ll_coil , ll_job )
end event

event constructor;call super::constructor;long ll_rc
//string ls_tem[], ls_tem2[], ls_tem3[], ls_keys[]
//ls_keys[] = {"return_scrap_item_return_scrap_item_num" }
//this.of_SetDropDownCalculator(TRUE)
//this.iuo_calculator.of_Register("return_scrap_item_return_item_net_wt", &
//this.iuo_calculator.NONE)
//this.iuo_calculator.of_Register("return_scrap_item_scrap_item_pieces", &
//this.iuo_calculator.NONE)
//
//this.iuo_calculator.of_SetCloseOnClick(True)
//this.iuo_calculator.of_SetInitialValue(TRUE)
this.of_setbase( true)
//this.of_settransobject( sqlca)
//this.of_setmultitable( true)
//this.inv_multitable.of_getregisterable( ls_tem )
//this.inv_multitable.of_getregisterabletable( ls_tem3)
//this.inv_multitable.of_getregisterablecolumn( "return_scrap_item",ls_tem2  )
//this.inv_multitable.of_getregisterablecolumn( "scrap_skid",ls_tem2  )
//this.inv_multitable.of_getregisterablecolumn( "scrap_skid_detail",ls_tem2  )
//
//ll_rc = this.inv_multitable.of_register( "return_scrap_item", is_return_scrap_item_keys, is_return_scrap_item_cols, false, 0 )
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
//
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

event doubleclicked;call super::doubleclicked;long ll_row, ll_rc

if dw_edit.rowcount( ) > 0 then
	MessageBox("Edit skid", "Please save or cancel current edit skid first!")
	return 1
end if

if row > 0 then

	il_edit_row = row
	ll_rc = dw_scrap.rowcount( )
	dw_scrap.sharedata( dw_edit )
	dw_edit.scrolltorow( il_edit_row )
	dw_edit.setrow( il_edit_row )
	dw_edit.rowscopy( 1, ll_rc, Primary!, ids_copy , 1, Primary!)
	cb_cancel.enabled = true
	cb_save.enabled = true
	cb_edit.enabled = false

	if isValid(iu_coil.of_get_scrap_tab_page( )) then
		istr_scrap_skid = iu_coil.of_get_scrap_tab_page( ).istr_scrap_skid
	else
//		istr_scrap_skid = iu_coil.of_get_scrap_offline_tab_page( ).istr_scrap_skid
	end if

end if
end event

