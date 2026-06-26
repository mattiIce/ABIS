$PBExportHeader$u_da_coil_job_tabpg.sru
forward
global type u_da_coil_job_tabpg from u_tabpg
end type
type cb_reverse from u_cb within u_da_coil_job_tabpg
end type
type st_1 from statictext within u_da_coil_job_tabpg
end type
type st_job from statictext within u_da_coil_job_tabpg
end type
type dw_coil from u_dw within u_da_coil_job_tabpg
end type
type dw_job from u_dw within u_da_coil_job_tabpg
end type
end forward

global type u_da_coil_job_tabpg from u_tabpg
integer width = 2765
integer height = 1626
long backcolor = 12639424
string text = "Coil"
long tabbackcolor = 12639424
boolean ib_isupdateable = false
cb_reverse cb_reverse
st_1 st_1
st_job st_job
dw_coil dw_coil
dw_job dw_job
end type
global u_da_coil_job_tabpg u_da_coil_job_tabpg

type variables
string is_title
w_da_sheet iw_sheet
u_coil iu_coil
//long il_coil_num, il_job_num
//long il_scrap_skid_num  //, al_sheet_skid_num
//w_tare iw_tare
//w_load_partial iw_load_partial
//w_load_scrap_tare iw_load_scrap_tare
//w_scrap_type iw_scrap_type
//w_dimensional_check iw_dimensional_check
//w_dimensional_check_new_skid iw_dimensional_check_new_skid
//s_partial_skid istr_scrap_skid

//n_ds ids_dim_check
//string is_scrap_defect
//string is_pre_scrap_defect
//int ii_scrap_type
//int ii_pre_scrap_type
//w_da_tabpg_skid_edit iw_da_tabpg_skid_edit
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


//long il_current_row, il_edit_row



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
public subroutine of_print_skid_ticket (long al_skid_num, long al_net, long al_tare)
public subroutine of_print_scrap_ticket (long al_skid_num, long al_net, long al_tare)
public subroutine of_retrieve_job ()
end prototypes

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
if isValid( iw_sheet.iu_current_coil ) then
	iu_coil = iw_sheet.iu_current_coil
end if
//dw_scrap.of_retrieve( )
//dw_skid_item.of_retrieve( )
//dw_current_edit.settaborder( "sheet_skid_sheet_net_wt", 0)
//
dw_coil.of_retrieve( )
dw_job.of_retrieve( )
st_job.text = "Job: " + string( iu_coil.get_current_job( ) )
this.text = "Coil " + iu_coil.get_coil_org_id( )
end subroutine

public subroutine of_add_current_skid_pieces (integer ai_pcs);//long ll_rc, ll_pcs
//string ls_pcs
//if dw_current_edit.enabled then
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

public subroutine of_retrieve_job ();if isValid( iu_coil ) then 
	st_job.text = "Job: " + string( iu_coil.get_current_job( ))
	dw_job.of_retrieve( )
end if
end subroutine

on u_da_coil_job_tabpg.create
int iCurrent
call super::create
this.cb_reverse=create cb_reverse
this.st_1=create st_1
this.st_job=create st_job
this.dw_coil=create dw_coil
this.dw_job=create dw_job
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reverse
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_job
this.Control[iCurrent+4]=this.dw_coil
this.Control[iCurrent+5]=this.dw_job
end on

on u_da_coil_job_tabpg.destroy
call super::destroy
destroy(this.cb_reverse)
destroy(this.st_1)
destroy(this.st_job)
destroy(this.dw_coil)
destroy(this.dw_job)
end on

event constructor;call super::constructor;//iw_sheet = message.powerobjectparm
//if isValid( iw_sheet.iu_current_coil ) then
//	iu_coil = iw_sheet.iu_current_coil
//end if
//dw_skid_item.settransobject( sqlca)
//dw_skid_item.of_retrieve( )
//

dw_coil.settransobject( sqlca)
dw_job.settransobject( sqlca)


end event

type cb_reverse from u_cb within u_da_coil_job_tabpg
boolean visible = false
integer x = 2125
integer y = 1360
integer width = 538
integer height = 115
integer taborder = 30
integer textsize = -12
string text = "Reverse coil"
end type

event clicked;call super::clicked;iw_sheet.iuo_shift.postevent( "ue_drop_current_coil")
end event

type st_1 from statictext within u_da_coil_job_tabpg
boolean visible = false
integer x = 1148
integer y = 1386
integer width = 1247
integer height = 99
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Oops, I loaded the wrong coil."
boolean focusrectangle = false
end type

type st_job from statictext within u_da_coil_job_tabpg
integer x = 358
integer y = 115
integer width = 603
integer height = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Job#"
boolean focusrectangle = false
end type

type dw_coil from u_dw within u_da_coil_job_tabpg
integer x = 88
integer y = 723
integer width = 2582
integer height = 541
integer taborder = 20
string dataobject = "d_daily_prod_coil_detail_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;return retrieve( iu_coil.get_coil_abc_id( ) )
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

type dw_job from u_dw within u_da_coil_job_tabpg
integer x = 358
integer y = 198
integer width = 2077
integer height = 400
integer taborder = 10
string dataobject = "d_das_prod_job_details_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;return retrieve( iu_coil.get_current_job( ) )
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

