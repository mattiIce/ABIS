$PBExportHeader$w_stack_queue_edit.srw
forward
global type w_stack_queue_edit from w_popup
end type
type cb_edit from u_cb within w_stack_queue_edit
end type
type cb_print from u_cb within w_stack_queue_edit
end type
type cb_unload_skid from u_cb within w_stack_queue_edit
end type
type cb_dim_chk from u_cb within w_stack_queue_edit
end type
type cb_cancel from u_cb within w_stack_queue_edit
end type
type cb_save from u_cb within w_stack_queue_edit
end type
type dw_edit from u_dw within w_stack_queue_edit
end type
end forward

global type w_stack_queue_edit from w_popup
integer width = 2461
integer height = 954
string title = "Stack queue"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
boolean ib_isupdateable = false
cb_edit cb_edit
cb_print cb_print
cb_unload_skid cb_unload_skid
cb_dim_chk cb_dim_chk
cb_cancel cb_cancel
cb_save cb_save
dw_edit dw_edit
end type
global w_stack_queue_edit w_stack_queue_edit

type variables
//u_coil iu_coil
//u_da_skid_tabpg iu_da_skid_tabpg
//long il_item
//SQLPreviewType isql_criteria
//
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
//

w_da_sheet_110_stacker iw_da_sheet_110_stacker
w_stacker_skid_edit iw_stacker_skid_edit
end variables

on w_stack_queue_edit.create
int iCurrent
call super::create
this.cb_edit=create cb_edit
this.cb_print=create cb_print
this.cb_unload_skid=create cb_unload_skid
this.cb_dim_chk=create cb_dim_chk
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_edit=create dw_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_edit
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_unload_skid
this.Control[iCurrent+4]=this.cb_dim_chk
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.dw_edit
end on

on w_stack_queue_edit.destroy
call super::destroy
destroy(this.cb_edit)
destroy(this.cb_print)
destroy(this.cb_unload_skid)
destroy(this.cb_dim_chk)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_edit)
end on

event clicked;call super::clicked;dw_edit.accepttext( )
end event

type cb_edit from u_cb within w_stack_queue_edit
integer x = 1931
integer y = 451
integer width = 468
integer height = 102
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Edit skid"
end type

event clicked;call super::clicked;long ll_skid_id, ll_row, ll_job, ll_tare, ll_nw, ll_coil, ll_item
int li_location

ll_row = dw_edit.getselectedrow( 0 )
if ll_row < 1 then
	Messagebox("Select skid", "Please select a skid first!")
	return 1
end if


ll_skid_id = dw_edit.object.sheet_skid_num[ll_row]
ll_job = dw_edit.object.ab_job_num[ll_row]
ll_coil = dw_edit.object.coil_abc_num[ll_row]
li_location = dw_edit.object.location_code[ll_row]

if li_location < 5 then
	MessageBox("Can not edit","You can only edit skid after location 4 (idle conveyor 2)!")
	return 0
end if


if ll_skid_id > 1000 and ll_job > 1000 and ll_coil > 1000 then
	
	select production_sheet_item.prod_item_num into :ll_item
	from production_sheet_item, sheet_skid_detail
	where production_sheet_item.ab_job_num = :ll_job and
      production_sheet_item.coil_abc_num = :ll_coil and
      sheet_skid_detail.prod_item_num = production_sheet_item.prod_item_num and
      sheet_skid_detail.sheet_skid_num = :ll_skid_id;
//		MessageBox("item",string(ll_item))
		OpenWithParm( iw_stacker_skid_edit, ll_item)
		ll_nw = message.doubleparm
		if ll_nw > 0 then
			dw_edit.object.sheet_net_wt[ ll_row ] = ll_nw
			iw_da_sheet_110_stacker.event ue_refresh_display_insert_delete( )
		end if
else
	Messagebox("Error","Invalid skid/job/coil")		
	return 1
end if


	
	
	
end event

type cb_print from u_cb within w_stack_queue_edit
integer x = 1931
integer y = 314
integer width = 468
integer height = 102
integer taborder = 60
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Print Ticket"
end type

event clicked;call super::clicked;long ll_skid_id, ll_row, ll_job, ll_tare, ll_nw
int li_location

ll_row = dw_edit.getselectedrow( 0 )
if ll_row < 1 then return 1

ll_job = dw_edit.object.ab_job_num[ll_row]
ll_nw = dw_edit.object.sheet_net_wt[ll_row]
ll_skid_id = dw_edit.object.sheet_skid_num[ll_row]
		  
		  SELECT "AB_JOB"."JOB_TARE_WT"  
    		INTO :ll_tare  
    		FROM "AB_JOB"  
   		WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job;
		
		if isNull(ll_tare ) or ll_tare < 0 then
//			if not isValid( iw_tare ) then
//				OpenWithParm(iw_tare, ll_job )
//				ll_tare_wt = message.doubleparm
//				if ll_tare_wt >= 0 then
//					ll_tare = ll_tare_wt
//					
//					  UPDATE "AB_JOB"  
//     					SET "TARE" = :ll_tare  
//   					WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job   
//           			;
//					if sqlca.sqlcode<>0 then
//						messagebox("Error", "Error update tare on job table!")
//						return 0
//					else
//						sqlca.of_commit( )
//					end if
//				end if
//				//
//			end if
			ll_tare = 0
		end if


iw_da_sheet_110_stacker.wf_print_skid_ticket( ll_skid_id , ll_job , ll_nw , ll_tare )
end event

type cb_unload_skid from u_cb within w_stack_queue_edit
integer x = 1931
integer y = 176
integer width = 468
integer height = 102
integer taborder = 50
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Unload Skid"
end type

event clicked;call super::clicked;long ll_skid_id, ll_row
int li_location

ll_row = dw_edit.getselectedrow( 0 )
if ll_row < 1 then return 1

ll_skid_id = dw_edit.object.sheet_skid_num[ll_row ]
li_location = dw_edit.object.location_code[ll_row]
	
IF messagebox("Unload stack", "Do you want to unload skid# " + string(ll_skid_id ) +" ?", Question!, YesNo!, 2 ) = 1 then
	iw_da_sheet_110_stacker.wf_unload_stack( li_location )
end if


end event

type cb_dim_chk from u_cb within w_stack_queue_edit
integer x = 1931
integer y = 38
integer width = 468
integer height = 102
integer taborder = 40
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Dimenstion Chk"
end type

event clicked;call super::clicked;long ll_skid_id, ll_row
ll_row = dw_edit.getselectedrow( 0 )
if ll_row < 1 then return 1
ll_skid_id = dw_edit.object.sheet_skid_num[ll_row ]
IF messagebox("Dimensional check", "Do you want enter Dimensional check data for skid# " + string(ll_skid_id ) +" ?", Question!, YesNo!, 2 ) = 1 then
	openwithparm(iw_da_sheet_110_stacker.iw_qc_sheet_selected, ll_skid_id , parent)
end if

end event

type cb_cancel from u_cb within w_stack_queue_edit
integer x = 1931
integer y = 726
integer width = 468
integer height = 102
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Close"
end type

event clicked;call super::clicked;dw_edit.accepttext( )
dw_edit.resetupdate( )
iw_da_sheet_110_stacker.event ue_refresh_display_insert_delete( )
close( parent )
end event

type cb_save from u_cb within w_stack_queue_edit
integer x = 1931
integer y = 589
integer width = 468
integer height = 102
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Save"
end type

event clicked;call super::clicked;iw_da_sheet_110_stacker.wf_update_line_current_status( )
iw_da_sheet_110_stacker.event ue_refresh_display_insert_delete( )
dw_edit.resetupdate( )

//	long ll_row
//	ll_row = iu_da_skid_tabpg.il_edit_row
//	dw_edit.accepttext( )
//	if wf_data_validation() <> 0 then
//		return 1
//	end if
//	
//	if MessageBox("Save skid", "Do you want to save the changes?", Question!, YesNo!, 2) = 1 then
////		dw_edit.rowscopy( 1, 1, Primary!, iu_da_skid_tabpg.dw_skid_item, ll_row - 1 , Primary!)
//		wf_copy_row()
//		iu_da_skid_tabpg.of_save( )
//		close( parent )
//	end if
//	
////end if
//		
end event

type dw_edit from u_dw within w_stack_queue_edit
integer x = 73
integer y = 38
integer width = 1814
integer height = 790
integer taborder = 10
string dataobject = "d_conveyor_skid"
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;
//iu_da_skid_tabpg = message.powerobjectparm
//iu_coil = iu_da_skid_tabpg.iu_coil
//il_item = gl_message
//string ls_tem[], ls_tem2[], ls_tem3[], ls_keys[]
long ll_rc
//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_register("sheet_skid_sheet_net_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_register("production_sheet_item_prod_item_pieces", this.iuo_calculator.none )
//this.iuo_calculator.of_register("sheet_skid_sheet_tare_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_register("sheet_skid_skid_pieces", this.iuo_calculator.none )
//this.iuo_calculator.of_setcloseonclick( true)
//this.iuo_calculator.of_setinitialvalue( true)
this.of_setbase( true)
iw_da_sheet_110_stacker = message.powerobjectparm
iw_da_sheet_110_stacker.dw_stack_queue.sharedata( this)
//ll_rc = iu_da_skid_tabpg.il_edit_row
//iu_da_skid_tabpg.dw_skid_item.rowscopy( ll_rc, ll_rc, Primary!, this, 1, Primary!)
//
//if this.object.production_sheet_item_prod_item_net_wt[1] < 1 then
//	if iu_da_skid_tabpg.iw_sheet.ib_skid_scale_connected then
//		this.object.sheet_skid_sheet_net_wt.Protect = 1
//	end if
//else
//	this.object.sheet_skid_sheet_net_wt.Protect = 0
//end if
	
	

end event

event itemchanged;call super::itemchanged;int li_rows, li_rc, li_i
long ll_data
if dwo.Name = "location_code" then
	li_rows = this.rowcount( )
	ll_data = Long(data)
	for li_i=1 to li_rows
		if this.object.location_code[li_i] = ll_data and li_i <> row then
			return 1
		end if
	next
	choose case ll_data
	case 1
		this.object.conveyor[row] = 0
	case 2
		this.object.conveyor[row] = 0
	case 3
		this.object.conveyor[row] = 1
	case 4
		this.object.conveyor[row] = 1
	case 5
		this.object.conveyor[row] = 2
	case 6
		this.object.conveyor[row] = 2
	case 7
		this.object.conveyor[row] = 3
	case 8
		this.object.conveyor[row] = 3
	case 9
		this.object.conveyor[row] = 3
	case 10
		this.object.conveyor[row] = 3
	case 11
		this.object.conveyor[row] = 4
	case 12
		this.object.conveyor[row] = 4
	case 13
		this.object.conveyor[row] = 7
	case 14
		this.object.conveyor[row] = 5
	case 15
		this.object.conveyor[row] = 5
	case 16
		this.object.conveyor[row] = 6
	case 17
		this.object.conveyor[row] = 6
	case 18
		this.object.conveyor[row] = 6
	case 0
		this.object.conveyor[row] = 0
	end choose
iw_da_sheet_110_stacker.postevent( "ue_refresh_display" )

end if



return 0
end event

event clicked;call super::clicked;this.accepttext( )
if row > 0 then
		if dwo.Name <> "location_code" then
			this.selectrow( 0, false)
			this.selectrow( row, true)
		end if
		return 0
end if

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;long ll_skid_id, ll_job,ll_nw
int li_seq_job, li_line_id

li_seq_job = 0
li_line_id = iw_da_sheet_110_stacker.ii_line_id

  SELECT "LINE_CURRENT_STATUS"."SHEET_SKID_NUM"  
    INTO :ll_skid_id  
    FROM "LINE_CURRENT_STATUS"  
   WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id ;
	
	  SELECT //"SHEET_SKID"."SHEET_SKID_NUM",   
         "SHEET_SKID"."AB_JOB_NUM",   
         "SHEET_SKID"."SHEET_NET_WT",   
         "SHEET_SKID"."SKID_SEQ_FOR_JOB"  
    INTO //:skid_id,   
         :ll_job ,   
         :ll_nw ,   
         :li_seq_job  
    FROM "SHEET_SKID"  
   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :ll_skid_id   
           ;
	
	if isNull(li_seq_job) or li_seq_job = 0 then
		SELECT COUNT(*)
		INTO :li_seq_job
		FROM SHEET_SKID
		WHERE AB_JOB_NUM = :ll_job;
	end if
	
//	ll_row = dw_stack_queue.insertrow( 1 )
	
	
	this.object.sheet_skid_num[al_row] = ll_skid_id
	this.object.ab_job_num[al_row] = ll_job
	this.object.skid_seq_for_job[al_row] = li_seq_job
	this.object.sheet_net_wt[al_row] = ll_nw
	this.object.location_code[al_row] = 0
	this.object.conveyor[al_row] = 0
	this.object.stacker[al_row] = 1
	
//	event ue_refresh_display_insert_delete( )
iw_da_sheet_110_stacker.event ue_refresh_display_insert_delete( )
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

