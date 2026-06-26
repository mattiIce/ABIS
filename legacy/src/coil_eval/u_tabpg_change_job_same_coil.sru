$PBExportHeader$u_tabpg_change_job_same_coil.sru
forward
global type u_tabpg_change_job_same_coil from u_tabpg
end type
type st_nw_bal from statictext within u_tabpg_change_job_same_coil
end type
type st_6 from statictext within u_tabpg_change_job_same_coil
end type
type st_5 from statictext within u_tabpg_change_job_same_coil
end type
type st_wt from statictext within u_tabpg_change_job_same_coil
end type
type st_4 from statictext within u_tabpg_change_job_same_coil
end type
type em_new_wt from editmask within u_tabpg_change_job_same_coil
end type
type st_3 from statictext within u_tabpg_change_job_same_coil
end type
type st_2 from statictext within u_tabpg_change_job_same_coil
end type
type dw_job from u_dw within u_tabpg_change_job_same_coil
end type
type cb_back from commandbutton within u_tabpg_change_job_same_coil
end type
type st_coil from statictext within u_tabpg_change_job_same_coil
end type
type st_1 from statictext within u_tabpg_change_job_same_coil
end type
type cb_next from commandbutton within u_tabpg_change_job_same_coil
end type
end forward

global type u_tabpg_change_job_same_coil from u_tabpg
integer width = 2955
integer height = 1946
st_nw_bal st_nw_bal
st_6 st_6
st_5 st_5
st_wt st_wt
st_4 st_4
em_new_wt em_new_wt
st_3 st_3
st_2 st_2
dw_job dw_job
cb_back cb_back
st_coil st_coil
st_1 st_1
cb_next cb_next
end type
global u_tabpg_change_job_same_coil u_tabpg_change_job_same_coil

type variables
w_operation_panel iw_operation_panel
w_tare iw_tare
long il_coil_id,il_job, il_shift
string is_coil_org_id
int ii_line_id
end variables

on u_tabpg_change_job_same_coil.create
int iCurrent
call super::create
this.st_nw_bal=create st_nw_bal
this.st_6=create st_6
this.st_5=create st_5
this.st_wt=create st_wt
this.st_4=create st_4
this.em_new_wt=create em_new_wt
this.st_3=create st_3
this.st_2=create st_2
this.dw_job=create dw_job
this.cb_back=create cb_back
this.st_coil=create st_coil
this.st_1=create st_1
this.cb_next=create cb_next
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nw_bal
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_wt
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.em_new_wt
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.dw_job
this.Control[iCurrent+10]=this.cb_back
this.Control[iCurrent+11]=this.st_coil
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.cb_next
end on

on u_tabpg_change_job_same_coil.destroy
call super::destroy
destroy(this.st_nw_bal)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_wt)
destroy(this.st_4)
destroy(this.em_new_wt)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_job)
destroy(this.cb_back)
destroy(this.st_coil)
destroy(this.st_1)
destroy(this.cb_next)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
ii_line_id = iw_operation_panel.iw_da_sheet.ii_line_id
il_coil_id = iw_operation_panel.il_coil_id_same_coil
il_job = iw_operation_panel.il_old_job_id_same_coil
is_coil_org_id = iw_operation_panel.is_coil_org_id_same_coil
st_coil.text = is_coil_org_id
if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil) then
	st_wt.text =   string(iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_init_wt( ))
	st_nw_bal.text = string(iw_operation_panel.iw_da_sheet.iu_current_coil.get_nw_bal( ) )
end if
if isValid(iw_operation_panel.iw_da_sheet.iuo_shift) then
	il_shift = iw_operation_panel.iw_da_sheet.iuo_shift.get_shift_id( )
end if

dw_job.settransobject( sqlca)
dw_job.of_retrieve( )
end event

type st_nw_bal from statictext within u_tabpg_change_job_same_coil
integer x = 2494
integer y = 1008
integer width = 362
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_6 from statictext within u_tabpg_change_job_same_coil
integer x = 2333
integer y = 1014
integer width = 172
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "theo:"
boolean focusrectangle = false
end type

type st_5 from statictext within u_tabpg_change_job_same_coil
integer x = 424
integer y = 64
integer width = 940
integer height = 74
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Change Job for this coil  >>>>>"
boolean focusrectangle = false
end type

type st_wt from statictext within u_tabpg_change_job_same_coil
integer x = 2348
integer y = 253
integer width = 391
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_4 from statictext within u_tabpg_change_job_same_coil
integer x = 2341
integer y = 170
integer width = 300
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Initial wt:"
boolean focusrectangle = false
end type

type em_new_wt from editmask within u_tabpg_change_job_same_coil
integer x = 2395
integer y = 858
integer width = 457
integer height = 128
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_3 from statictext within u_tabpg_change_job_same_coil
integer x = 2308
integer y = 733
integer width = 457
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "weight here:"
boolean focusrectangle = false
end type

type st_2 from statictext within u_tabpg_change_job_same_coil
integer x = 2308
integer y = 650
integer width = 874
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Enter coil remaining"
boolean focusrectangle = false
end type

type dw_job from u_dw within u_tabpg_change_job_same_coil
integer x = 59
integer y = 170
integer width = 2238
integer height = 1725
integer taborder = 10
string dataobject = "d_job_schedule_same_coil"
end type

event clicked;call super::clicked;//if row > 0 then
//	this.selectrow( 0, false)
//	this.selectrow( row, true)
//end if
return 1
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
//of_SetSort(TRUE)
//inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( inv_rowselect.single ) 
//inv_RowSelect.of_SetStyle ( 0 ) 
end event

event pfc_retrieve;call super::pfc_retrieve;return retrieve(ii_line_id,il_coil_id )
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged( )
end event

type cb_back from commandbutton within u_tabpg_change_job_same_coil
boolean visible = false
integer x = 2377
integer y = 1725
integer width = 439
integer height = 154
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Back"
end type

event clicked;iw_operation_panel.postevent( "ue_same_coil_change_job_back")
end event

type st_coil from statictext within u_tabpg_change_job_same_coil
integer x = 2560
integer y = 77
integer width = 366
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coil #"
boolean focusrectangle = false
end type

type st_1 from statictext within u_tabpg_change_job_same_coil
integer x = 2341
integer y = 77
integer width = 205
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coil #"
boolean focusrectangle = false
end type

type cb_next from commandbutton within u_tabpg_change_job_same_coil
integer x = 2399
integer y = 1213
integer width = 439
integer height = 154
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Next"
end type

event clicked;long ll_job, ll_row
ll_row = dw_job.getselectedrow( 0 )

if not isValid(iw_operation_panel.iw_da_sheet.iu_current_coil ) then
	return 0
end if

if ll_row < 1 then
	Messagebox("Change Job Num", "Please select the Job#!!!", StopSign!)
	return 1
end if

ll_job = dw_job.getitemnumber( ll_row, "line_priority_ab_job_num") 

if ll_job = 0 or isNull(ll_job) then
	Messagebox("Change Job Num", "Please select the Job#!!!", StopSign!)
	return 0
end if
 
 if ll_job = iw_operation_panel.iw_da_sheet.iu_current_coil.get_current_job( ) then
	MessageBox("Job number", "Please select a different job" )
	return 0
end if
	
 
 long ll_new_wt
   if isNumber( em_new_wt.text ) then  
		ll_new_wt = Long( em_new_wt.text )
	else
		MessageBox("New weight error", "Please enter valid new coil weight" )
		return 0
	end if
 	if ll_new_wt < 1 or ll_new_wt >= iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_init_wt( ) then
		MessageBox("New weight error", "remaining coil weight must be between coil initial weight and 0!")
		return 0
	end if
 
 
 
 
 if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( )) then
	//Check current skid
		long ll_skid_rc
		ll_skid_rc = iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.rowcount( )
	if ll_skid_rc > 0 then
		long ll_skid_row, ll_stack1_row, ll_stack2_row, ll_stack_job
		ll_skid_row = iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.getrow( )
		if iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.object.stacker[ ll_skid_row ] = 1 then
			//stacker 1 cutting not done yet
			ll_stack2_row = iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.find( "stacker=2 and sheet_skid_skid_sheet_status=1", 1,  ll_skid_rc )
			if ll_stack2_row > 0 then
				ll_stack_job = iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_skid_item.object.production_sheet_item_ab_job_num[ll_stack2_row]
				if ll_stack_job = ll_job then
				 	iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.setrow( ll_stack2_row )
					iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.scrolltorow( ll_stack2_row )
				else
					MessageBox("Can not change job", "Stacker 2 is not running on job " + string( ll_job ) + "!")
					return 0
				end if
			else
				MessageBox("Change job", "Please make sure send next piece to STACKER 2!" )
//				return 0
			end if
		elseif iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.object.stacker[ ll_skid_row ] = 2 then
			//stacker 2 cutting not done yet
			ll_stack1_row = iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.find( "stacker=1 and sheet_skid_skid_sheet_status=1", 1, ll_skid_rc )
			if ll_stack1_row > 0 then
				ll_stack_job = iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_skid_item.object.production_sheet_item_ab_job_num[ll_stack1_row]
				if ll_stack_job = ll_job then
				 	iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.setrow( ll_stack1_row )
					iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.scrolltorow( ll_stack1_row )
				else
					MessageBox("Can not change job", "Stacker 1 is not running on job " + string( ll_job ) + "!")
					return 0
				end if
			else
				MessageBox("Change job", "Please make sure send next piece to STACKER 1!" )
//				return 0
			end if
		else
			//manual cutting not done
			MessageBox("Current skid not done", "Can not change job, Please done current skid first!" )
			return 0
		end if
	end if
	
end if
 
 
// long ll_new_wt
//   if isNumber( em_new_wt.text ) then  
//		ll_new_wt = Long( em_new_wt.text )
//	else
//		MessageBox("New weight error", "Please enter valid new coil weight" )
//		return 0
//	end if
// 	if ll_new_wt < 1 or ll_new_wt >= iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_init_wt( ) then
//		MessageBox("New weight error", "remaining coil weight must be between coil initial weight and 0!")
//		return 0
//	end if
//	
 
 
 if iw_operation_panel.iw_da_sheet.iuo_shift.of_set_job_id_same_coil(ll_job, ll_new_wt ) = 1 then
	
	//-------------
				long ll_tare_wt//, ll_job
				//ll_job = il_job
			  SELECT "AB_JOB"."JOB_TARE_WT"  
    			INTO :ll_tare_wt  
    			FROM "AB_JOB"  
   			WHERE "AB_JOB"."AB_JOB_NUM" = :ll_job;

			if isNull( ll_tare_wt ) or ll_tare_wt = 0 then
				if not isValid( iw_tare ) then
					OpenWithParm(iw_tare, ll_job )
					ll_tare_wt = message.doubleparm
						
					if ll_tare_wt > 0 and ll_tare_wt < 9000 then
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

	
	//--------------
	MessageBox("Same coil change job", "Coil #" + st_coil.text + " has new job " + string(ll_job) + "!") 
else
	MessageBox("Same coil change job", "Coil #" + st_coil.text + " didn't changed!" )
end if

iw_operation_panel.postevent( "ue_operation_finish")
end event

