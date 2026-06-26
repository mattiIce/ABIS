$PBExportHeader$u_tabpg_end_coil.sru
forward
global type u_tabpg_end_coil from u_tabpg
end type
type cb_next_coil from commandbutton within u_tabpg_end_coil
end type
type st_not_balance from statictext within u_tabpg_end_coil
end type
type cb_override from commandbutton within u_tabpg_end_coil
end type
type dw_2 from datawindow within u_tabpg_end_coil
end type
type cb_refresh_job from commandbutton within u_tabpg_end_coil
end type
type dw_1 from datawindow within u_tabpg_end_coil
end type
type tab_recap from u_tab within u_tabpg_end_coil
end type
type tab_recap from u_tab within u_tabpg_end_coil
end type
type cb_ok from commandbutton within u_tabpg_end_coil
end type
type cb_refresh from commandbutton within u_tabpg_end_coil
end type
type st_9 from statictext within u_tabpg_end_coil
end type
type st_percent from statictext within u_tabpg_end_coil
end type
type st_hl from statictext within u_tabpg_end_coil
end type
type st_scrap_wt from statictext within u_tabpg_end_coil
end type
type st_skid_wt from statictext within u_tabpg_end_coil
end type
type st_8 from statictext within u_tabpg_end_coil
end type
type st_7 from statictext within u_tabpg_end_coil
end type
type st_6 from statictext within u_tabpg_end_coil
end type
type st_coil_org_num from statictext within u_tabpg_end_coil
end type
type st_4 from statictext within u_tabpg_end_coil
end type
type st_3 from statictext within u_tabpg_end_coil
end type
type st_5 from statictext within u_tabpg_end_coil
end type
type em_coil_wt from u_em within u_tabpg_end_coil
end type
type pb_coil_wt from u_pb within u_tabpg_end_coil
end type
type st_2 from statictext within u_tabpg_end_coil
end type
type cb_cancel from commandbutton within u_tabpg_end_coil
end type
type cb_print from commandbutton within u_tabpg_end_coil
end type
type gb_recap from groupbox within u_tabpg_end_coil
end type
type st_wt_prompt from statictext within u_tabpg_end_coil
end type
type rb_reject from radiobutton within u_tabpg_end_coil
end type
type rb_inprocess from radiobutton within u_tabpg_end_coil
end type
type rb_onhold from radiobutton within u_tabpg_end_coil
end type
type rb_rebanded from radiobutton within u_tabpg_end_coil
end type
type rb_done from radiobutton within u_tabpg_end_coil
end type
type em_new_coil_wt from u_em within u_tabpg_end_coil
end type
type pb_new_coil_wt from u_pb within u_tabpg_end_coil
end type
type gb_3 from groupbox within u_tabpg_end_coil
end type
type gb_4 from groupbox within u_tabpg_end_coil
end type
type gb_status from groupbox within u_tabpg_end_coil
end type
end forward

global type u_tabpg_end_coil from u_tabpg
integer width = 3602
integer height = 1946
long backcolor = 134217752
boolean ib_isupdateable = false
event ue_refresh ( )
cb_next_coil cb_next_coil
st_not_balance st_not_balance
cb_override cb_override
dw_2 dw_2
cb_refresh_job cb_refresh_job
dw_1 dw_1
tab_recap tab_recap
cb_ok cb_ok
cb_refresh cb_refresh
st_9 st_9
st_percent st_percent
st_hl st_hl
st_scrap_wt st_scrap_wt
st_skid_wt st_skid_wt
st_8 st_8
st_7 st_7
st_6 st_6
st_coil_org_num st_coil_org_num
st_4 st_4
st_3 st_3
st_5 st_5
em_coil_wt em_coil_wt
pb_coil_wt pb_coil_wt
st_2 st_2
cb_cancel cb_cancel
cb_print cb_print
gb_recap gb_recap
st_wt_prompt st_wt_prompt
rb_reject rb_reject
rb_inprocess rb_inprocess
rb_onhold rb_onhold
rb_rebanded rb_rebanded
rb_done rb_done
em_new_coil_wt em_new_coil_wt
pb_new_coil_wt pb_new_coil_wt
gb_3 gb_3
gb_4 gb_4
gb_status gb_status
end type
global u_tabpg_end_coil u_tabpg_end_coil

type variables
w_operation_panel  iw_operation_panel
long il_old_nt
long il_new_nt
int ii_old_status
int ii_new_status
w_enter_num iw_enter_num
u_coil iu_coil
long il_skid_total, il_scrap_total, il_hl
Real ir_hl_percent
int ii_super = 0
int ii_apple_mode = 0
//w_production_control_validation iw_production_control_validation
u_da_recap_scrap_tabpg iu_da_recap_scrap_tabpg
u_da_recap_skid_tabpg iu_da_recap_skid_tabpg
w_report_eval iw_report_eval
end variables

forward prototypes
public function double of_get_coil_yield ()
public function long of_get_reject_wt ()
public function long of_get_reband_wt ()
public subroutine of_print_eval ()
public function integer of_update_process_coil ()
public function integer of_transfer_worksheet_2_eval ()
public function string of_get_line_desc (long ab_job_num)
end prototypes

event ue_refresh();cb_refresh.event clicked()
end event

public function double of_get_coil_yield ();double ld_yield

ld_yield = (1- (this.il_scrap_total / iu_coil.get_old_nw ())) * 100
//ld_yield = ( 1- il )
ld_yield = Round(ld_yield, 2 )
//if ld_yield >= 99.99 then
//	ld_yield = 99.99
//end if
return ld_yield
end function

public function long of_get_reject_wt ();long ll_reject_wt

if this.rb_reject.checked then
	ll_reject_wt = Long( this.em_new_coil_wt.text )
else
	ll_reject_wt = 0
end if

return ll_reject_wt

end function

public function long of_get_reband_wt ();long ll_reband_wt

if this.rb_rebanded.checked then
	ll_reband_wt = Long( this.em_new_coil_wt.text )
else
	ll_reband_wt = 0
end if

return ll_reband_wt

end function

public subroutine of_print_eval ();n_ds lds_eval
//long ll_job, ll_coil, ll_shift
cb_refresh.event clicked( )
//OpenwithParm(iw_report_eval, parent,iw_operation_panel )

long ll_job, ll_coil, ll_shift,ll_reband_wt,ll_reject_wt
double ld_yield
		lds_eval = create n_ds
		
		lds_eval.dataobject = "d_coil_evaluation"
		lds_eval.of_settransobject( sqlca )
//		lds_eval.of_setprintpreview( true )
		ll_job = iu_coil.get_current_job( )
		ll_coil = iu_coil.get_coil_abc_id( )
		ll_shift = iu_coil.of_get_shift_id( )
		
		ll_reband_wt = of_get_reband_wt( )
		ll_reject_wt = of_get_reject_wt( )
		ld_yield = of_get_coil_yield( )
		
		lds_eval.retrieve(ll_shift, ll_coil, ll_job )
		
		//Set reject reband info
		lds_eval.object.t_reject_wt.text = string( ll_reject_wt )
		lds_eval.object.t_reband_wt.text = string( ll_reband_wt )
		lds_eval.object.t_coil_yield.text = string( ld_yield ) + "%"
		lds_eval.object.t_skid_total.text = st_skid_wt.text
		lds_eval.object.t_scrap_total.text = st_scrap_wt.text
//		OpenwithParm(w_report_eval, lds_eval )
//		lds_eval.print( )
//		lds_eval.event pfc_printpreview( )

		//MessageBox("of_print_eval for u_tabpg_end_coil in coil_eval.pbl", "gs_print_coil_eval = " + gs_print_coil_eval) //Alex Gerlants. 09/06/2023. 1990_Disable_Reports_BL78_BL84

		If gs_print_coil_eval = "Y" Then //Alex Gerlants. 09/06/2023. 1990_Disable_Reports_BL78_BL84
			lds_eval.event pfc_PrintImmediate( )
		End If //Alex Gerlants. 09/06/2023. 1990_Disable_Reports_BL78_BL84
end subroutine

public function integer of_update_process_coil ();long ll_rc, ll_row, ll_i, ll_coil_id, ll_job_id, ll_begin_wt1, ll_begin_wt2,ll_end_wt1, ll_end_wt2
int li_new_status
cb_refresh_job.event clicked( )
ll_rc = dw_2.rowcount( )

if isValid(iu_coil ) then
	ll_coil_id = iu_coil.get_coil_abc_id( )
else
	
	//Alex Gerlants. 12/06/2018. Begin
	MessageBox("Inside Else of 'isValid(iu_coil )'", "iu_coil is invalid")
	//Alex Gerlants. 12/06/2018. End
	
	return -1
end if

if ll_rc < 1 then
	return 1
elseif ll_rc = 1 then
	//update process coil table for single job
	  ll_job_id = dw_2.object.ab_job[1]
	  UPDATE "PROCESS_COIL"  
     SET "PROCESS_COIL_STATUS" = :ii_new_status,   
         "PROCESS_QUANTITY" = :il_old_nt,   
         "PROCESS_DATE" = sysdate,   
         "SHIFT_PROCESS_STATUS" = :ii_new_status ,   
         "CURRENT_WT" = :il_new_nt ,   
         "PROCESS_END_WT" = :il_new_nt  
   WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :ll_coil_id ) AND  
         ( "PROCESS_COIL"."AB_JOB_NUM" = :ll_job_id )   
           ;
	if sqlca.sqlcode <> 0 then
		
		//Alex Gerlants. 12/06/2018. Begin
		If IsNull(ii_new_status) Then ii_new_status = -99
		If IsNull(il_old_nt) Then il_old_nt = -99
		If IsNull(il_new_nt) Then il_new_nt = -99
		
		MessageBox("Error updating process_coil (single job)", &
			"Coil ABC Num = " + String(ll_coil_id) + "  AB Job Num = " + String(ll_job_id) + "~n~r" + &
			"ii_new_status = " + String(ii_new_status) + "~n~r" + &
			"il_old_nt = " + String(il_old_nt) + "  il_new_nt = " + String(il_new_nt) + "~n~rError:~n~r" + &
			"sqlca.sqlcode = " + String(sqlca.sqlcode) + "~n~r" + &
			sqlca.sqlerrtext)
		//Alex Gerlants. 12/06/2018. End
		
		sqlca.of_rollback( )
		return -1
	else
		sqlca.of_commit( )
		return 0
	end if
else
	//Update process coil table for multiple jobs
	
	for ll_i=1 to ll_rc
		ll_job_id = dw_2.object.ab_job[ll_i]
	  	if ll_i = 1 then
			//first job
			ll_begin_wt2 = il_old_nt
			ll_end_wt2 = ll_begin_wt2 - dw_2.object.wt[ll_i]
			li_new_status = 7
			
			////Alex Gerlants. 04/29/2019. Alex_Last_Job_4Coil_Weight_Zeroed_Out. Begin
			////dw_2.object.wt[ll_i] comes from init event for u_coil <== il_init_wt for u_coil
			////or Clicked event for cb_refresh_job for u_tabpg_end_coil in coil_eval.pbl
			//
			//String	ls_line_desc
			//Long		ll_dw_2_object_wt
			//
			//ls_line_desc = of_get_line_desc(ll_job_id)
			//ll_dw_2_object_wt = dw_2.object.wt[ll_i]
			//
			////If ll_end_wt2 = 0 Then //For a rebanded coil, end weight should not be 0.
			//		insert into dbo.first_job_coil_wt_0ed_out
			//				(coil_abc_num, ab_job_num, seq_num,                                  curr_date_time,                                            line_desc,      begin_wt,     dw_2_object_wt,     end_wt,        new_status,                          notes                    )
			//		values 
			//				(:ll_coil_id, :ll_job_id,  :ll_i,  to_timestamp(to_char(systimestamp, 'dd-mon-rr hh24:mi:ss.ff'), 'dd-mon-rr hh24:mi:ss.ff'), :ls_line_desc, :ll_begin_wt2, :ll_dw_2_object_wt, :ll_end_wt2,   :li_new_status,  'First job in ' || to_char(:ll_rc) || '-jobs set')
			//		using  sqlca;
			////End If
			////Alex Gerlants. 04/29/2019. Alex_Last_Job_4Coil_Weight_Zeroed_Out. End
		elseif ll_i = ll_rc then
			//last job
			ll_begin_wt2 = ll_end_wt1
			ll_end_wt2 = il_new_nt
			li_new_status = ii_new_status
		else
	  		ll_begin_wt2 = ll_end_wt1
	  		ll_end_wt2 = ll_begin_wt2 - dw_2.object.wt[ll_i]
	  		li_new_status = 7
		end if
		
	  
	  	if ll_begin_wt2 < 0 or ll_end_wt2 < 0 then
			
			//Alex Gerlants. 12/06/2018. Begin
			MessageBox("Inside 'if ll_begin_wt2 < 0 or ll_end_wt2 < 0 then'", &
				"ll_begin_wt2 < 0 or ll_end_wt2 < 0" + "~n~r" + &
				"ll_begin_wt2 = " + String(ll_begin_wt2) + "~n~r" + &
				"ll_end_wt2 = " + String(ll_end_wt2))
			//Alex Gerlants. 12/06/2018. End
			
	  		return -1
		end if
	  
	  UPDATE "PROCESS_COIL"  
     	SET "PROCESS_COIL_STATUS" = :li_new_status,   
         "PROCESS_QUANTITY" = :ll_begin_wt2,   
         "PROCESS_DATE" = sysdate,   
         "SHIFT_PROCESS_STATUS" = :li_new_status ,   
         "CURRENT_WT" = :ll_end_wt2,   
         "PROCESS_END_WT" = :ll_end_wt2  
   	WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :ll_coil_id ) AND  
         ( "PROCESS_COIL"."AB_JOB_NUM" = :ll_job_id )   
           ;
			  
		if sqlca.sqlcode <> 0 then 
			
			//Alex Gerlants. 12/06/2018. Begin
			If IsNull(li_new_status) Then li_new_status = -99
			If IsNull(ll_begin_wt2) Then ll_begin_wt2 = -99
			If IsNull(ll_end_wt2) Then ll_end_wt2 = -99
			
			MessageBox("Error updating process_coil (multiple job)", &
				"Coil ABC Num = " + String(ll_coil_id) + "  AB Job Num = " + String(ll_job_id) + "~n~r" + &
				"li_new_status = " + String(li_new_status) + "~n~r" + &
				"ll_begin_wt2 = " + String(ll_begin_wt2) + "  ll_end_wt2 = " + String(ll_end_wt2) + "~n~rError:~n~r" + &
				"sqlca.sqlcode = " + String(sqlca.sqlcode) + "~n~r" + &
				sqlca.sqlerrtext)
			//Alex Gerlants. 12/06/2018. End
			
			sqlca.of_rollback( )
			return -1
		end if
		ll_end_wt1 = ll_end_wt2
		
	next
		sqlca.of_commit( )
	return 0
end if


return 0
end function

public function integer of_transfer_worksheet_2_eval ();
sqlca.update_scrap_from_worksheet( iu_coil.get_coil_abc_id( ) )
return sqlca.sqlcode
end function

public function string of_get_line_desc (long ab_job_num);//Alex Gerlants. 04/29/2019. Alex_Last_Job_4Coil_Weight_Zeroed_Out. Begin
/*
Function:	of_get_line_desc
Returns:		string <== Line description
Arguments:	value	long	ab_job_num
*/
String	ls_line_desc

select	line.line_desc
Into		:ls_line_desc
from		ab_job
         join line on line.line_num = ab_job.line_num
where		ab_job.ab_job_num = :ab_job_num
using		sqlca;

If sqlca.sqlcode <> 0 Then
	ls_line_desc = "0"
End If

Return ls_line_desc
//Alex Gerlants. 04/29/2019. Alex_Last_Job_4Coil_Weight_Zeroed_Out. End
end function

on u_tabpg_end_coil.create
int iCurrent
call super::create
this.cb_next_coil=create cb_next_coil
this.st_not_balance=create st_not_balance
this.cb_override=create cb_override
this.dw_2=create dw_2
this.cb_refresh_job=create cb_refresh_job
this.dw_1=create dw_1
this.tab_recap=create tab_recap
this.cb_ok=create cb_ok
this.cb_refresh=create cb_refresh
this.st_9=create st_9
this.st_percent=create st_percent
this.st_hl=create st_hl
this.st_scrap_wt=create st_scrap_wt
this.st_skid_wt=create st_skid_wt
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_coil_org_num=create st_coil_org_num
this.st_4=create st_4
this.st_3=create st_3
this.st_5=create st_5
this.em_coil_wt=create em_coil_wt
this.pb_coil_wt=create pb_coil_wt
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.gb_recap=create gb_recap
this.st_wt_prompt=create st_wt_prompt
this.rb_reject=create rb_reject
this.rb_inprocess=create rb_inprocess
this.rb_onhold=create rb_onhold
this.rb_rebanded=create rb_rebanded
this.rb_done=create rb_done
this.em_new_coil_wt=create em_new_coil_wt
this.pb_new_coil_wt=create pb_new_coil_wt
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_status=create gb_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_next_coil
this.Control[iCurrent+2]=this.st_not_balance
this.Control[iCurrent+3]=this.cb_override
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_refresh_job
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.tab_recap
this.Control[iCurrent+8]=this.cb_ok
this.Control[iCurrent+9]=this.cb_refresh
this.Control[iCurrent+10]=this.st_9
this.Control[iCurrent+11]=this.st_percent
this.Control[iCurrent+12]=this.st_hl
this.Control[iCurrent+13]=this.st_scrap_wt
this.Control[iCurrent+14]=this.st_skid_wt
this.Control[iCurrent+15]=this.st_8
this.Control[iCurrent+16]=this.st_7
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.st_coil_org_num
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.em_coil_wt
this.Control[iCurrent+23]=this.pb_coil_wt
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.cb_cancel
this.Control[iCurrent+26]=this.cb_print
this.Control[iCurrent+27]=this.gb_recap
this.Control[iCurrent+28]=this.st_wt_prompt
this.Control[iCurrent+29]=this.rb_reject
this.Control[iCurrent+30]=this.rb_inprocess
this.Control[iCurrent+31]=this.rb_onhold
this.Control[iCurrent+32]=this.rb_rebanded
this.Control[iCurrent+33]=this.rb_done
this.Control[iCurrent+34]=this.em_new_coil_wt
this.Control[iCurrent+35]=this.pb_new_coil_wt
this.Control[iCurrent+36]=this.gb_3
this.Control[iCurrent+37]=this.gb_4
this.Control[iCurrent+38]=this.gb_status
end on

on u_tabpg_end_coil.destroy
call super::destroy
destroy(this.cb_next_coil)
destroy(this.st_not_balance)
destroy(this.cb_override)
destroy(this.dw_2)
destroy(this.cb_refresh_job)
destroy(this.dw_1)
destroy(this.tab_recap)
destroy(this.cb_ok)
destroy(this.cb_refresh)
destroy(this.st_9)
destroy(this.st_percent)
destroy(this.st_hl)
destroy(this.st_scrap_wt)
destroy(this.st_skid_wt)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_coil_org_num)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.em_coil_wt)
destroy(this.pb_coil_wt)
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.gb_recap)
destroy(this.st_wt_prompt)
destroy(this.rb_reject)
destroy(this.rb_inprocess)
destroy(this.rb_onhold)
destroy(this.rb_rebanded)
destroy(this.rb_done)
destroy(this.em_new_coil_wt)
destroy(this.pb_new_coil_wt)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_status)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm

if isValid( iw_operation_panel.iw_da_sheet.iu_current_coil ) then
	iu_coil = iw_operation_panel.iw_da_sheet.iu_current_coil
	if isValid( iu_coil.of_get_skid_tab_page( )) then
		iu_coil.of_get_skid_tab_page( ).of_set_theo_2_partial_at_coil_end( )
	end if
	iu_coil.of_update_from_skid_scrap( )
end if
//this.title = "Coil " + iu_coil.get_coil_org_id( )
st_coil_org_num.text = iu_coil.get_coil_org_id( )
//il_old_nt = iu_coil.of_get_init_wt( )
il_old_nt = iu_coil.get_old_nw( )
em_coil_wt.text = string(il_old_nt )
gb_status.text = "1) Change Coil (" + string(il_old_nt) + "LB) Status/Weight to"
em_new_coil_wt.text = "0"
em_new_coil_wt.enabled = false
il_new_nt = 0
ii_new_status = 0
il_hl =  il_skid_total + il_scrap_total + il_new_nt - il_old_nt
ir_hl_percent = Round(ABS(il_hl / il_old_nt ),4) * 100
st_skid_wt.text = string( il_skid_total  )
st_scrap_wt.text = string( il_scrap_total )
st_hl.text = string( il_hl )
st_percent.text = string( ir_hl_percent )

tab_recap.opentab( iu_da_recap_skid_tabpg , 0)
tab_recap.opentab( iu_da_recap_scrap_tabpg , 0)
iu_da_recap_skid_tabpg.of_init( iu_coil, this )
iu_da_recap_scrap_tabpg.of_init( iu_coil, this )
dw_1.settransobject(sqlca)
//dw_1.retrieve(iu_coil.get_coil_abc_id( ))
cb_refresh_job.event clicked( )
this.postevent( "ue_refresh")
//cb_refresh.event clicked( )
//
end event

event destructor;call super::destructor;//if isValid( iw_enter_num ) then
//	close(iw_enter_num)
//end if
//
//if isValid( iw_production_control_validation  ) then
//	close(iw_production_control_validation)
//end if
end event

type cb_next_coil from commandbutton within u_tabpg_end_coil
integer x = 779
integer y = 1766
integer width = 571
integer height = 138
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Load next coil"
end type

type st_not_balance from statictext within u_tabpg_end_coil
integer x = 2926
integer y = 486
integer width = 571
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12639424
string text = "Weight not balance"
boolean focusrectangle = false
end type

type cb_override from commandbutton within u_tabpg_end_coil
integer x = 2684
integer y = 1766
integer width = 571
integer height = 138
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Override Login"
end type

event clicked;//parent.iw_operation_panel.cb_login.event clicked( )
if not isValid( iw_operation_panel.iw_da_sheet.iu_current_coil ) then
	return
end if
if iw_operation_panel.iw_da_sheet.wf_super_validation( ) = 1 then
	cb_ok.enabled = true
	ii_super = 1
end if
end event

type dw_2 from datawindow within u_tabpg_end_coil
integer x = 2918
integer y = 909
integer width = 571
integer height = 352
integer taborder = 60
string title = "none"
string dataobject = "d_job_recap_ext"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_refresh_job from commandbutton within u_tabpg_end_coil
integer x = 2915
integer y = 1270
integer width = 571
integer height = 102
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recal Job total"
end type

event clicked;
long ll_rc, ll_row
boolean lb_found
long ll_breakrow

lb_found = false
ll_breakrow = 0

//ll_rc = dw_1.rowcount( )
dw_1.retrieve( iu_coil.get_coil_abc_id( ) )
//ll_rc = dw_1.rowcount( )
dw_2.reset( )
//ll_jobs = dw_1.object.compute_job.Primary
//ll_pcs = dw_1.object.compute_pieces.Primary
//ll_wt = dw_1.object.compute_wt.Primary
//messagebox("", String(Upperbound(ll_jobs)))

DO WHILE NOT (lb_found)

	ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 1)
 // If no breaks are found, exit.
    IF ll_breakrow <= 0 THEN EXIT
		ll_row = dw_2.insertrow( 0 )
		dw_2.object.ab_job[ll_row] = dw_1.object.process_coil_ab_job_num[ll_breakrow]
		dw_2.object.wt[ll_row] = dw_1.object.compute_wt[ll_breakrow]
		
		ll_breakrow = ll_breakrow + 1
LOOP


return
end event

type dw_1 from datawindow within u_tabpg_end_coil
boolean visible = false
integer x = 3131
integer y = 16
integer width = 380
integer height = 189
integer taborder = 50
string title = "none"
string dataobject = "d_process_coil_skid_scrap_union_4_recap"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tab_recap from u_tab within u_tabpg_end_coil
integer x = 88
integer y = 310
integer width = 2779
integer height = 1338
integer taborder = 50
integer textsize = -9
string facename = "Arial"
boolean ib_isupdateable = false
end type

type cb_ok from commandbutton within u_tabpg_end_coil
integer x = 1865
integer y = 1766
integer width = 571
integer height = 138
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "End Coil"
end type

event clicked;long ll_coil_id, ll_reject_wt, ll_reband_wt, ll_i, ll_row, ll_skid
double ld_yield
int li_rc2
int li_rc3
Datastore lds_coil, lds_skid

//Alex Gerlants. 10/19/2020. End_Coil_Weight_Warning. Begin
Integer	li_answer
Long		ll_new_nt

ll_new_nt = Long(em_new_coil_wt.Text)
If IsNull(ll_new_nt) Then ll_new_nt = 0

li_answer = MessageBox("Are you sure?", "Are you sure that coil weight " + String(ll_new_nt) + " is correct?", Question!, YesNo!, 2)
If li_answer <> 1 Then Return //"No"
//Alex Gerlants. 10/19/2020. End_Coil_Weight_Warning. End


cb_refresh.event clicked( )
if ir_hl_percent > 0.5 and ii_super = 0  and ii_apple_mode = 0 then
		//not balance
		MessageBox("Coil discrepancy", "Please re-check and change skid or scrap weight, and try again! Or ask your shift supervisor override it!", StopSign!)
		return 1
end if

ll_coil_id = iu_coil.get_coil_abc_id( )
if isValid(iu_coil.of_get_scrap_tab_page( )) then
	li_rc2 = iu_coil.of_get_scrap_tab_page( ).of_update_scrap_skid_item()
	
else
//	li_rc2 = iu_coil.of_get_scrap_offline_tab_page( ).of_update_scrap_skid_item()
end if

if li_rc2 <> 0 then
	MessageBox("Save failed", "Failed at saving scrap. Try again later!", StopSign!)
	return 1
end if


if isValid(iu_coil.of_get_skid_tab_page( )) then
	li_rc2 = iu_coil.of_get_skid_tab_page( ).of_save()
else
//	li_rc2 = iu_coil.of_get_skid_offline_tab_page( ).of_save( )
end if

if li_rc2 <> 0 then
	MessageBox("Save failed", "Failed at saving skids, Try again later!", StopSign!)
	return 1
end if

parent.of_transfer_worksheet_2_eval( )
//parent.cb_print.event clicked( )
of_print_eval()
if ii_new_status <> 1 then
		iu_coil.finish( ii_new_status , il_new_nt )
		int li_rc
		ll_reband_wt = of_get_reband_wt( )
		ll_reject_wt = of_get_reject_wt( )
		ld_yield = of_get_coil_yield( )
		
		if ld_yield > 99.99 then
			ld_yield = 99.99
		end if
		
		if of_update_process_coil( ) = -1 then
			MessageBox("Update process coil" , "Error in update process!" )
			return 1
		end if
		li_rc = iu_coil.of_get_sheet_window( ).wf_done_coil( )
		
		
		
		if li_rc = 0 then
			//update coil yield
			
			UPDATE "COIL"  
     		SET "REBAND_WT" = :ll_reband_wt,   
         	"REJECT_WT" = :ll_reject_wt,   
         	"RECOVERY_RATE" = :ld_yield  
   		WHERE "COIL"."COIL_ABC_NUM" = :ll_coil_id
           ;
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				MessageBox("DB Error", "Can not update coil!")
			else
				sqlca.of_commit( )
			end if
		end if
		
		
		if ii_new_status <> 0 then
			lds_coil = create datastore
			lds_coil.dataobject = "d_report_coil_barcode_zebra_new"
			lds_coil.settransobject( sqlca)
			lds_coil.retrieve( ll_coil_id )
			
			//MessageBox("Clicked event for cb_ok of u_tabpg_end_coil in coil_eval.pbl", "gs_print_coil_tag = " + gs_print_coil_tag) //Alex Gerlants. 09/06/2023. 1990_Disable_Reports_BL78_BL84
	
			If gs_print_coil_tag = "Y" Then //Alex Gerlants. 09/06/2023. 1990_Disable_Reports_BL78_BL84
				lds_coil.print( )
			End If //Alex Gerlants. 09/06/2023. 1990_Disable_Reports_BL78_BL84
				
			destroy lds_coil
		end if
		
			lds_skid = create datastore
			lds_skid.dataobject = "d_skid_list_per_coil"
			lds_skid.settransobject( sqlca)
			lds_skid.retrieve( ll_coil_id )
         ll_row = lds_skid.rowCount()
			IF ll_row > 0 THEN
				
				FOR ll_i = 1 TO ll_row
					 ll_skid = lds_skid.GetItemNumber(ll_i, "sheet_skid_detail_sheet_skid_num", Primary!, FALSE)
     				 
						//CHOOSE CASE f_check_skid_item_info(ll_skid)
						SELECT F_CHECK_SKID_ITEM_INFO(:ll_skid) INTO :li_rc3 FROM DUAL;
	
						if sqlca.sqlcode <> 0 then
							MessageBox("Error", "Invalid skid number!!", Stopsign!)
							return 1
						end if

						
						CHOOSE CASE li_rc3
						CASE 1
							INSERT INTO sheet_skid_error_log(sheet_skid_num, log_date, Enter_by, log_desc) 
							values(:ll_skid, sysdate, USER, "skid pieces and item pieces not match.")
							USING SQLCA;
							COMMIT;
						CASE 2
							INSERT INTO sheet_skid_error_log(sheet_skid_num, log_date, Enter_by, log_desc) 
							values(:ll_skid, sysdate, USER, "skid net WT and item net WT not match.")
							USING SQLCA;
							COMMIT;
						CASE 3
							INSERT INTO sheet_skid_error_log(sheet_skid_num, log_date, Enter_by, log_desc) 
							values(:ll_skid, sysdate, USER, " skid theo WT and item theo WT not match.")
							USING SQLCA;
							COMMIT;
					
						END CHOOSE
						
				NEXT
				
			END IF
			destroy lds_skid
				
		iw_operation_panel.postevent("ue_operation_finish")
else //Same coil change job
	iu_coil.finish( ii_new_status , il_new_nt )
	//iu_coil.of_get_sheet_window( ).wf_change_job_same_coil()
	iw_operation_panel.postevent( "ue_same_coil_change_job" )
//	iw_operation_panel.tab_op.closetab( parent )
end if


//close(parent)

//iu_coil.finish( 1, 0)
end event

type cb_refresh from commandbutton within u_tabpg_end_coil
integer x = 2915
integer y = 320
integer width = 571
integer height = 106
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refresh"
end type

event clicked;Integer	li_answer //Alex Gerlants. 10/19/2020. End_Coil_Weight_Warning

if not isValid( iu_coil) then
	return 1
end if
//	iu_coil.of_get_tab_page( ).dw_skid_item.accepttext( )
//	iu_coil.of_get_tab_page( ).dw_scrap.accepttext( )
//	
iu_da_recap_scrap_tabpg.dw_scrap.accepttext( )
iu_da_recap_skid_tabpg.dw_skid_item.accepttext( )

iu_da_recap_scrap_tabpg.dw_edit.accepttext( )
iu_da_recap_skid_tabpg.dw_edit.accepttext( )


//if  iu_da_recap_scrap_tabpg.dw_scrap.of_updatespending( ) = 1 then
//	iu_da_recap_scrap_tabpg.cb_save.event clicked( )
//end if
//
//if  iu_da_recap_skid_tabpg.dw_skid_item.of_updatespending( ) = 1 then
//	iu_da_recap_skid_tabpg.cb_ref.event clicked( )
//end if

iu_coil.of_update_from_skid_scrap( )

if iu_da_recap_skid_tabpg.dw_skid_item.rowcount( ) < 1 then
	il_skid_total = 0
else
	il_skid_total = iu_da_recap_skid_tabpg.dw_skid_item.object.compute_sum_item_nw[1]
end if

//	
if iu_da_recap_scrap_tabpg.dw_scrap.rowcount( ) < 1 then
	il_scrap_total = 0
else
	il_scrap_total =  iu_da_recap_scrap_tabpg.dw_scrap.object.compute_1[1]
end if

////Alex Gerlants. 10/19/2020. End_Coil_Weight_Warning. Begin
//li_answer = MessageBox("Are you sure?", "Are you sure weight " + String(il_new_nt) + " is correct?", Question!, YesNo!, 2)
//If li_answer <> 1 Then Return
////Alex Gerlants. 10/19/2020. End_Coil_Weight_Warning. End

//il_old_nt = Long( em_coil_wt.text )
il_hl = il_skid_total + il_scrap_total + il_new_nt - il_old_nt
ir_hl_percent = Round(ABS(il_hl / il_old_nt ),4) * 100
st_skid_wt.text = string( il_skid_total  )
st_scrap_wt.text = string( il_scrap_total )
st_hl.text = string( il_hl )
st_percent.text = string( ir_hl_percent )

iu_coil.of_set_hl_percent( ir_hl_percent )

if ir_hl_percent > 0.5 then
		//not balance
		if ii_super = 0 then
			parent.cb_ok.enabled = false
			parent.cb_override.enabled = true
			parent.st_not_balance.visible = true
		end if
	else
		parent.cb_ok.enabled = true
		parent.cb_override.enabled = false
		parent.st_not_balance.visible = false
end if

if iu_coil.of_get_feedlength( ) < iw_operation_panel.iw_da_sheet.ii_manual_stack_lenght or iu_coil.of_get_part_length( ) < iw_operation_panel.iw_da_sheet.ii_manual_stack_lenght then
		ii_apple_mode = 1
		parent.cb_ok.enabled = true
		parent.cb_override.enabled = false
		parent.st_not_balance.visible = false
end if

//cb_refresh_job.event clicked( )

end event

type st_9 from statictext within u_tabpg_end_coil
integer x = 3456
integer y = 637
integer width = 102
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 12639424
string text = "%"
boolean focusrectangle = false
end type

type st_percent from statictext within u_tabpg_end_coil
integer x = 3226
integer y = 637
integer width = 219
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 12639424
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_hl from statictext within u_tabpg_end_coil
integer x = 2918
integer y = 637
integer width = 234
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12639424
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_scrap_wt from statictext within u_tabpg_end_coil
integer x = 3226
integer y = 797
integer width = 278
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12639424
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_skid_wt from statictext within u_tabpg_end_coil
integer x = 2918
integer y = 794
integer width = 263
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within u_tabpg_end_coil
integer x = 2918
integer y = 573
integer width = 589
integer height = 77
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Heavy/Light Discrepancy"
boolean focusrectangle = false
end type

type st_7 from statictext within u_tabpg_end_coil
integer x = 4074
integer y = 906
integer width = 66
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "/"
boolean focusrectangle = false
end type

type st_6 from statictext within u_tabpg_end_coil
integer x = 2918
integer y = 746
integer width = 625
integer height = 77
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Good skid / Scrap tatal:"
boolean focusrectangle = false
end type

type st_coil_org_num from statictext within u_tabpg_end_coil
boolean visible = false
integer x = 176
integer y = 38
integer width = 263
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
string text = "none"
boolean focusrectangle = false
end type

type st_4 from statictext within u_tabpg_end_coil
boolean visible = false
integer x = 1097
integer y = 38
integer width = 644
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217752
string text = "had been processed."
end type

type st_3 from statictext within u_tabpg_end_coil
boolean visible = false
integer x = 965
integer y = 38
integer width = 121
integer height = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "LB."
boolean focusrectangle = false
end type

type st_5 from statictext within u_tabpg_end_coil
boolean visible = false
integer x = 1770
integer y = 38
integer width = 1755
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217752
string text = "Logon as production supervisor to override coil initial weight"
boolean focusrectangle = false
end type

type em_coil_wt from u_em within u_tabpg_end_coil
boolean visible = false
integer x = 453
integer y = 26
integer width = 358
integer height = 96
integer taborder = 20
integer textsize = -12
boolean enabled = false
string text = "0000"
string mask = "#####"
boolean spin = true
string minmax = "0~~50000"
end type

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
end event

event modified;call super::modified;long ll_coil_init_wt
long ll_coil, ll_job
ll_coil_init_wt = Long(this.text)
ll_coil = iu_coil.get_coil_abc_id( )
ll_job = iu_coil.get_current_job( )
if ll_coil_init_wt <> il_old_nt then
	//init coil weight changed
			
//	  UPDATE "PROCESS_COIL"  
//     	SET "PROCESS_QUANTITY" = :ll_coil_init_wt  
//   	WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :ll_coil ) AND  
//         ( "PROCESS_COIL"."AB_JOB_NUM" = :ll_job )   
//           ;
//		
			
	  UPDATE "COIL"  
     SET "NET_WT" = :ll_coil_init_wt  
   WHERE "COIL"."COIL_ABC_NUM" = :ll_coil   
           ;
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			return 0
		end if
	
	  UPDATE "PROCESS_COIL"  
     SET "PROCESS_QUANTITY" = :ll_coil_init_wt  
   WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :ll_coil) AND  
         ( "PROCESS_COIL"."PROCESS_QUANTITY" = :il_old_nt )   
           ;

	if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			return 0
	end if
	
	sqlca.of_commit( )
	iu_coil.of_set_coil_origin_wt( ll_coil_init_wt )
	
	il_old_nt = ll_coil_init_wt
	cb_refresh.event clicked( )
end if
end event

type pb_coil_wt from u_pb within u_tabpg_end_coil
boolean visible = false
integer x = 805
integer y = 26
integer width = 132
integer height = 90
integer taborder = 20
integer textsize = -10
string facename = "Arial"
boolean enabled = false
string text = "Change"
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;em_new_coil_wt.Event pfc_DDCalculator( )
//s_position ls_p
//ls_p.x = x
//ls_p.y = y
//OpenWithParm(iw_enter_num, ls_p, parent)
//if not isValid( this ) then
//	return 0
//end if
//em_coil_wt.text = Message.StringParm

//long ll_rc
//	OpenWithParm(iw_production_control_validation, iu_coil.of_get_sheet_window( ).is_prod_control_password)// , parent)
//	ll_rc = message.doubleparm
//	if not isValid( this ) then
//		return 1
//	end if
//	if ll_rc = 1 then
//		em_coil_wt.enabled = true
//	else
//		em_coil_wt.enabled = false
//	end if
end event

type st_2 from statictext within u_tabpg_end_coil
boolean visible = false
integer x = 44
integer y = 38
integer width = 135
integer height = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217752
string text = "Coil"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within u_tabpg_end_coil
boolean visible = false
integer x = 1865
integer y = 1770
integer width = 571
integer height = 138
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;iw_operation_panel.postevent( "ue_operation_finish")
end event

type cb_print from commandbutton within u_tabpg_end_coil
integer x = 91
integer y = 1766
integer width = 571
integer height = 138
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview Eval"
end type

event clicked;//n_ds lds_eval
parent.cb_refresh.event clicked( )


parent.of_transfer_worksheet_2_eval( )
OpenwithParm(iw_report_eval, parent,iw_operation_panel )

//long ll_job, ll_coil, ll_shift,ll_reband_wt,ll_reject_wt
//double ld_yield
//		lds_eval = create n_ds
//		
//		lds_eval.dataobject = "d_coil_evaluation"
//		lds_eval.of_settransobject( sqlca )
////		lds_eval.of_setprintpreview( true )
//		ll_job = parent.iu_coil.get_current_job( )
//		ll_coil = parent.iu_coil.get_coil_abc_id( )
//		ll_shift = parent.iu_coil.of_get_shift_id( )
//		
//		ll_reband_wt = parent.of_get_reband_wt( )
//		ll_reject_wt = parent.of_get_reject_wt( )
//		ld_yield = parent.of_get_coil_yield( )
//		
//		lds_eval.retrieve(ll_shift, ll_coil, ll_job )
//		
//		//Set reject reband info
//		lds_eval.object.t_reject_wt.text = string( ll_reject_wt )
//		lds_eval.object.t_reband_wt.text = string( ll_reband_wt )
//		lds_eval.object.t_coil_yield.text = string( ld_yield ) + "%"
//		lds_eval.object.t_skid_total.text = st_skid_wt.text
//		lds_eval.object.t_scrap_total.text = st_scrap_wt.text
//		OpenwithParm(w_report_eval, lds_eval )
		//lds_eval.print( )
//		lds_eval.event pfc_printpreview( )
//		lds_eval.event pfc_PrintImmediate( )
		
		
end event

type gb_recap from groupbox within u_tabpg_end_coil
integer x = 55
integer y = 237
integer width = 3522
integer height = 1434
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "2) Recap/Adjust skid and scrap weight and pieces until Discrepance within 0.5%.  Enter theo wt for split skid Wt"
end type

type st_wt_prompt from statictext within u_tabpg_end_coil
integer x = 2589
integer y = 122
integer width = 366
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Weight:"
boolean focusrectangle = false
end type

type rb_reject from radiobutton within u_tabpg_end_coil
integer x = 1306
integer y = 109
integer width = 322
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12639424
string text = "Reject"
end type

event clicked;//parent.st_wt_prompt.text = "Rejected Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 3
il_new_nt = iu_coil.get_nw_bal( )
parent.cb_refresh.event clicked( )
end event

type rb_inprocess from radiobutton within u_tabpg_end_coil
boolean visible = false
integer x = 1733
integer y = 109
integer width = 761
integer height = 90
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12639424
boolean enabled = false
string text = "InProcess (change job)"
end type

event clicked;st_wt_prompt.text = "Unprocess Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 1
il_new_nt = iu_coil.get_nw_bal( )
parent.cb_refresh.event clicked( )
end event

type rb_onhold from radiobutton within u_tabpg_end_coil
integer x = 1861
integer y = 109
integer width = 369
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 12639424
string text = "On Hold"
end type

event clicked;parent.st_wt_prompt.text = "OnHold Weight"
//parent.st_wt_prompt.text = "Rejected Weight"
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
//parent.st_new_wt.enabled = true
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 4
il_new_nt = iu_coil.get_nw_bal( )
parent.cb_refresh.event clicked( )
end event

type rb_rebanded from radiobutton within u_tabpg_end_coil
integer x = 622
integer y = 109
integer width = 450
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12639424
string text = "Rebanded"
end type

event clicked;parent.st_wt_prompt.text = "Rebandeded Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
il_new_nt = iu_coil.get_nw_bal( )
parent.ii_new_status = 7
parent.cb_refresh.event clicked( )
end event

type rb_done from radiobutton within u_tabpg_end_coil
integer x = 117
integer y = 109
integer width = 271
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 12639424
string text = "Done"
boolean checked = true
end type

event clicked;parent.st_wt_prompt.text = "Done Coil"
//parent.st_new_wt.text = "0"
//parent.st_new_wt.enabled = false
em_new_coil_wt.text = "0"
em_new_coil_wt.enabled = false
pb_new_coil_wt.enabled = false
parent.ii_new_status = 0
parent.il_new_nt = 0
parent.cb_refresh.event clicked( )


end event

type em_new_coil_wt from u_em within u_tabpg_end_coil
integer x = 2911
integer y = 109
integer width = 377
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
string text = "0000"
string mask = "#####"
boolean spin = true
string minmax = "0~~50000"
end type

event constructor;call super::constructor;//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_setcloseonclick( true)
//this.iuo_calculator.of_setinitialvalue( true)
end event

event modified;call super::modified;il_new_nt = Long( this.text )
cb_refresh.event clicked( )
end event

type pb_new_coil_wt from u_pb within u_tabpg_end_coil
integer x = 3277
integer y = 112
integer width = 132
integer height = 90
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;//em_new_coil_wt.Event pfc_DDCalculator( )
s_position ls_p
ls_p.x = x - 300
ls_p.y = y
OpenWithParm(iw_enter_num, ls_p)// parent)
if not isValid( this ) then
	return 0
end if
em_new_coil_wt.text = Message.StringParm
em_new_coil_wt.event modified( )

end event

type gb_3 from groupbox within u_tabpg_end_coil
integer x = 59
integer y = 1686
integer width = 1349
integer height = 243
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "3) Eval and next coil- Optional"
end type

type gb_4 from groupbox within u_tabpg_end_coil
integer x = 1456
integer y = 1686
integer width = 2121
integer height = 243
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "4) Finish"
end type

type gb_status from groupbox within u_tabpg_end_coil
integer x = 59
integer y = 19
integer width = 3522
integer height = 205
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "1) Change Coil (10000LB) Status/Weight to"
end type

