$PBExportHeader$u_tabpg_new_coil.sru
forward
global type u_tabpg_new_coil from u_tabpg
end type
type rb_change_job from u_rb within u_tabpg_new_coil
end type
type rb_same_job from u_rb within u_tabpg_new_coil
end type
type st_title from statictext within u_tabpg_new_coil
end type
type dw_job_schedule from u_dw within u_tabpg_new_coil
end type
type cb_print from commandbutton within u_tabpg_new_coil
end type
type cb_coil from commandbutton within u_tabpg_new_coil
end type
type cb_job from commandbutton within u_tabpg_new_coil
end type
type st_2 from statictext within u_tabpg_new_coil
end type
type st_1 from statictext within u_tabpg_new_coil
end type
type cb_current from commandbutton within u_tabpg_new_coil
end type
type dw_coils from u_dw within u_tabpg_new_coil
end type
type cb_reverse from commandbutton within u_tabpg_new_coil
end type
type cb_ok from commandbutton within u_tabpg_new_coil
end type
type cb_retrieve from commandbutton within u_tabpg_new_coil
end type
type gb_1 from u_gb within u_tabpg_new_coil
end type
type gb_2 from u_gb within u_tabpg_new_coil
end type
end forward

global type u_tabpg_new_coil from u_tabpg
integer width = 3599
integer height = 1946
long backcolor = 134217752
rb_change_job rb_change_job
rb_same_job rb_same_job
st_title st_title
dw_job_schedule dw_job_schedule
cb_print cb_print
cb_coil cb_coil
cb_job cb_job
st_2 st_2
st_1 st_1
cb_current cb_current
dw_coils dw_coils
cb_reverse cb_reverse
cb_ok cb_ok
cb_retrieve cb_retrieve
gb_1 gb_1
gb_2 gb_2
end type
global u_tabpg_new_coil u_tabpg_new_coil

type variables
w_operation_panel iw_operation_panel
w_scan_coil_id iw_scan_coil_id
w_tare iw_tare
int ii_line_id
long il_job, il_retrieve_job
long il_coil, il_shift
int ii_status
end variables

on u_tabpg_new_coil.create
int iCurrent
call super::create
this.rb_change_job=create rb_change_job
this.rb_same_job=create rb_same_job
this.st_title=create st_title
this.dw_job_schedule=create dw_job_schedule
this.cb_print=create cb_print
this.cb_coil=create cb_coil
this.cb_job=create cb_job
this.st_2=create st_2
this.st_1=create st_1
this.cb_current=create cb_current
this.dw_coils=create dw_coils
this.cb_reverse=create cb_reverse
this.cb_ok=create cb_ok
this.cb_retrieve=create cb_retrieve
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_change_job
this.Control[iCurrent+2]=this.rb_same_job
this.Control[iCurrent+3]=this.st_title
this.Control[iCurrent+4]=this.dw_job_schedule
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_coil
this.Control[iCurrent+7]=this.cb_job
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cb_current
this.Control[iCurrent+11]=this.dw_coils
this.Control[iCurrent+12]=this.cb_reverse
this.Control[iCurrent+13]=this.cb_ok
this.Control[iCurrent+14]=this.cb_retrieve
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_2
end on

on u_tabpg_new_coil.destroy
call super::destroy
destroy(this.rb_change_job)
destroy(this.rb_same_job)
destroy(this.st_title)
destroy(this.dw_job_schedule)
destroy(this.cb_print)
destroy(this.cb_coil)
destroy(this.cb_job)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_current)
destroy(this.dw_coils)
destroy(this.cb_reverse)
destroy(this.cb_ok)
destroy(this.cb_retrieve)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
ii_line_id = iw_operation_panel.iw_da_sheet.ii_line_id
il_job = iw_operation_panel.iw_da_sheet.il_abjob
if isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	il_shift = iw_operation_panel.iw_da_sheet.iuo_shift.get_shift_id( )
end if

if isNull(il_job) then il_job = 0

if isNull(il_job ) or il_job < 1000 then
	gb_1.text = "1) " + "No Current job, Please Select Job change option"
else
	gb_1.text = "1) " + "Current Job# " + string(il_job) + ", Please select Job change option"
end if

//gb_1.text =  "1) " + "Select Job change option"

dw_job_schedule.of_setlinkage( true)
dw_coils.of_setlinkage( true)
dw_job_schedule.inv_linkage.of_SetConfirmOnRowChange (True)
dw_job_schedule.inv_linkage.of_setUpdateOnRowChange (TRUE)
dw_coils.of_setlinkage( true)

////dw_coils.inv_linkage.of_settransobject( sqlca)
dw_coils.inv_linkage.of_setmaster( dw_job_schedule )
dw_coils.inv_linkage.of_Register("line_priority_ab_job_num","process_coil_ab_job_num")
//dw_job_schedule.of_settransobject( sqlca)
//dw_coils.of_retrieve( )
dw_coils.inv_linkage.of_setstyle( dw_coils.inv_linkage.retrieve )
dw_job_schedule.inv_linkage.of_settransobject( sqlca)
//dw_job_schedule.of_retrieve()
dw_job_schedule.setfocus( )
//select the current job first
//long ll_row
//ll_row = dw_job_schedule.find( "line_priority_ab_job_num="+string(ll_row), 1, dw_job_schedule.rowcount( ) )

//if ll_row > 0 then
//	dw_job_schedule.scrolltorow( ll_row )
////	dw_job_schedule.selectrow
//end if





//-----------------------------------------old scheduler-------------
//dw_coils.of_settransobject( sqlca)
//dw_coils.of_retrieve( )
//iw_operation_panel.iw_da_sheet.tab_queue.tabpage_coil_queue.dw_coil_queue.of_retrieve( )
end event

type rb_change_job from u_rb within u_tabpg_new_coil
integer x = 1887
integer y = 176
integer width = 827
integer height = 83
integer textsize = -12
string facename = "Arial"
long backcolor = 134217752
string text = "Change Job"
end type

event clicked;call super::clicked;if this.checked then
	dw_job_schedule.dataobject = "d_job_schedule_change_job"
	il_retrieve_job = il_job
	dw_job_schedule.inv_linkage.of_settransobject( sqlca)
	dw_job_schedule.of_retrieve( )
	dw_job_schedule.setfocus( )
end if
end event

type rb_same_job from u_rb within u_tabpg_new_coil
integer x = 391
integer y = 176
integer width = 827
integer height = 80
integer textsize = -12
string facename = "Arial"
long backcolor = 134217752
string text = "Keep this same Job"
end type

event clicked;call super::clicked;if this.checked then
	dw_job_schedule.dataobject = "d_job_schedule_same_job"
	il_retrieve_job = il_job
	dw_job_schedule.inv_linkage.of_settransobject( sqlca)
	dw_job_schedule.of_retrieve( )
	dw_job_schedule.setfocus( )
	
end if
end event

type st_title from statictext within u_tabpg_new_coil
boolean visible = false
integer x = 2421
integer y = 19
integer width = 395
integer height = 77
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "New coil"
boolean focusrectangle = false
end type

type dw_job_schedule from u_dw within u_tabpg_new_coil
integer x = 66
integer y = 486
integer width = 2114
integer height = 1440
integer taborder = 10
string dataobject = "d_job_schedule"
end type

event pfc_retrieve;call super::pfc_retrieve;return retrieve( ii_line_id, il_retrieve_job )
end event

event rowfocuschanged;call super::rowfocuschanged;//if currentrow > 0 then
//	this.selectrow( 0, false)
//	this.selectrow( currentrow, true)
//end if
this.Event pfc_rowchanged()
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
//of_SetSort(TRUE)
//inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( inv_rowselect.single ) 
//inv_RowSelect.of_SetStyle ( 0 ) 
end event

event doubleclicked;call super::doubleclicked;// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	MessageBox("Select coil", "Shift is not running, Can not select coil!", StopSign!)
	return 1
end if

if row > 0 then
	il_job = this.object.line_priority_ab_job_num[row]
	OpenWithParm(w_daily_prod_job_detail_display, il_job )
end if
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event clicked;call super::clicked;return 1
integer li_rc

//if row > 0 then
//	this.selectrow( 0, false)
//	this.selectrow( row, true)
//end if
//return 1

// Check arguments
//IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
//	Return 1
//END IF
//
//IF IsValid (inv_RowSelect) THEN
//	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
//END IF
//
//IF IsValid (inv_Sort) THEN 
//	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
//END IF 
//
//IF IsValid (inv_linkage) THEN
//	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
//		inv_linkage.CONTINUE_ACTION Then
//		// The user or a service action prevents from going to the clicked row.
//		Return 1
//	End If
//END IF
//
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

type cb_print from commandbutton within u_tabpg_new_coil
integer x = 3035
integer y = 998
integer width = 508
integer height = 179
integer taborder = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Print Coil Label"
end type

event clicked;long ll_row
//string ls_coil_id
ll_row = dw_coils.getselectedrow( 0 )


if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	MessageBox("Select coil", "Shift is not running, Can not select coil!", StopSign!)
	return 1
end if

if ll_row < 1 then
	MessageBox("Invalid coil", "Please select a valid coil number!", StopSign!)
	return 1
end if

//il_job = dw_coils.object.shift_coil_job_ab_job_num[ll_row]
il_coil = dw_coils.object.process_coil_coil_abc_num[ll_row]

Datastore lds_coil
		lds_coil = create datastore
		lds_coil.dataobject = "d_report_coil_barcode_zebra"
		lds_coil.settransobject( sqlca)
		lds_coil.retrieve( il_coil)
		lds_coil.print( )

end event

type cb_coil from commandbutton within u_tabpg_new_coil
integer x = 3035
integer y = 675
integer width = 508
integer height = 179
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coil Detail"
end type

event clicked;long ll_row
string ls_coil_id
ll_row = dw_coils.getselectedrow( 0 )


if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	MessageBox("Select coil", "Shift is not running, Can not select coil!", StopSign!)
	return 1
end if

if ll_row < 1 then
	MessageBox("Invalid coil", "Please select a valid coil number!", StopSign!)
	return 1
end if

//il_job = dw_coils.object.shift_coil_job_ab_job_num[ll_row]
il_coil = dw_coils.object.process_coil_coil_abc_num[ll_row]

OpenWithParm(w_daily_prod_coil_detail_display, il_coil)
end event

type cb_job from commandbutton within u_tabpg_new_coil
integer x = 3035
integer y = 352
integer width = 508
integer height = 179
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Job Detail"
end type

event clicked;long ll_row
string ls_coil_id
ll_row = dw_coils.getselectedrow( 0 )


if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	MessageBox("Select coil", "Shift is not running, Can not select coil!", StopSign!)
	return 1
end if

if ll_row < 1 then
	MessageBox("Invalid coil", "Please select a valid coil number!", StopSign!)
	return 1
end if

il_job = dw_coils.object.process_coil_ab_job_num[ll_row]
//il_coil = dw_coils.object.shift_coil_job_coil_abc_num[ll_row]


OpenWithParm(w_daily_prod_job_detail_display, il_job )
end event

type st_2 from statictext within u_tabpg_new_coil
boolean visible = false
integer x = 3233
integer width = 205
integer height = 51
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within u_tabpg_new_coil
boolean visible = false
integer x = 3013
integer width = 190
integer height = 51
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "none"
boolean focusrectangle = false
end type

type cb_current from commandbutton within u_tabpg_new_coil
boolean visible = false
integer x = 3116
integer y = 106
integer width = 428
integer height = 128
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Current Job"
end type

event clicked;il_job = iw_operation_panel.iw_da_sheet.il_abjob
dw_coils.of_retrieve( )
end event

type dw_coils from u_dw within u_tabpg_new_coil
integer x = 2198
integer y = 486
integer width = 764
integer height = 1440
integer taborder = 0
string dataobject = "d_process_coil_for_panel"
end type

event clicked;call super::clicked;if row > 0 then
	if not iw_operation_panel.iw_da_sheet.ib_scanner_connected then
		this.selectrow( 0, false)
		this.selectrow( row, true)
	end if

//	il_coil = this.object.process_coil_coil_abc_num[row]
//	//if isNull()
//	
//	ii_status = this.object.process_coil_shift_process_status[row]
//	
//	if isNull(ii_status) then
//		ii_status = 2
//	end if
//	
//	st_1.text = string(il_coil)
//	st_2.text = string(ii_status)
	//parent.cb_select.text = "Change to " + string(this.getitemnumber( row, "line_priority_ab_job_num"))
end if
return 1
end event

event doubleclicked;call super::doubleclicked;//
if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	MessageBox("Select coil", "Shift is not running, Can not select coil!", StopSign!)
	return 1
end if

if row > 0 then
	il_coil = this.object.process_coil_coil_abc_num[row]
	OpenWithParm(w_daily_prod_coil_detail_display, il_coil)
end if
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;//long li_Row
//
//this.AcceptText()
//li_Row = this.GetRow()
//this.SelectRow(0, False)
//this.SelectRow(li_Row, True)
//
////Nochange
//Return 
end event

event rowfocuschanged;call super::rowfocuschanged;//this.event pfc_rowchanged( )
end event

type cb_reverse from commandbutton within u_tabpg_new_coil
boolean visible = false
integer x = 3120
integer y = 32
integer width = 428
integer height = 128
integer taborder = 70
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reverse"
end type

event clicked;int li_valid
s_coil_status ls_new_status
//Open(iw_super_validation )
//if not isValid(this) then
//	return 0
//end if
//if not isValid( iu_shift ) then
//		return 0
//end if
//li_valid = Message.doubleparm
//if li_valid = 1 then
//	openwithparm(iw_reverse_coil, parent.istr_selected_coil, iu_shift.iw_sheet )
//	if not isValid(this) then
//		return 0
//	end if
//	if not isValid( iu_shift ) then
//		return 0
//	end if
//	ls_new_status = Message.powerobjectparm
//	parent.dw_coils.setitem( il_current_row, "process_coil_shift_process_status" ,ls_new_status.status )
//	parent.dw_coils.setitem( il_current_row, "coil_net_wt_balance" ,ls_new_status.weight)
//	
//	  UPDATE "PROCESS_COIL"  
//     	SET "SHIFT_PROCESS_STATUS" = :ls_new_status.status,   
//         "CURRENT_WT" = :ls_new_status.weight  
//   	WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :il_coil_abc_id_now ) AND  
//         ( "PROCESS_COIL"."AB_JOB_NUM" = :il_job_num )   
//           ;
//
//	  UPDATE "SHIFT_COIL"  
//     	SET "COIL_END_STATUS" = :ls_new_status.status,   
//         "COIL_END_WT" = :ls_new_status.weight,   
//         "PROCESS_WT" = "COIL_BEGIN_WT" - :ls_new_status.weight  
//   	WHERE "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_id_now   
//           ;
//		COMMIT;
//
//	
//end if
//
end event

type cb_ok from commandbutton within u_tabpg_new_coil
integer x = 3035
integer y = 1322
integer width = 508
integer height = 307
integer taborder = 50
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Load Coil"
end type

event clicked;//MessageBox(string(il_coil), string(ii_status))
//if il_coil > 10000  and ii_status <> 0 then
//	if isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
//		iw_operation_panel.iw_da_sheet.iuo_shift.of_set_job_id( il_job )
//		iw_operation_panel.iw_da_sheet.iuo_shift.of_set_coil_id( il_coil )
//		iw_operation_panel.iw_da_sheet.wf_set_operation_id( 0 )
//		iw_operation_panel.iw_da_sheet.ii_event_id = 0
//		iw_operation_panel.postevent( "ue_operation_finish")
//	end if
//else 
//	MessageBox("Invalid coil", "Please select a valid coil number!", StopSign!)
//	return 1
//end if

long ll_row, ll_job_row, ll_scan_row
string ls_coil_id
ll_row = dw_coils.rowcount( )
ll_job_row = dw_job_schedule.getselectedrow( 0 )

if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	MessageBox("Select coil", "Shift is not running, Can not select coil!", StopSign!)
	return 1
end if

if ll_row < 1 then
	MessageBox("Invalid coil", "Please select a valid coil number!", StopSign!)
	return 1
end if

if ll_job_row < 1 then
	MessageBox("Invalid Job", "Please select a valid job number!", StopSign!)
	return 1
end if


//if dw_coils.object.process_coil_shift_process_status[ll_row] = 0 or dw_coils.object.coil_net_wt_balance[ll_row] < 1 then
//	MessageBox("Invalid coil", "Coil is done! Please select a valid coil.")
//	return 1
//end if

//if dw_coils.object.shift_coil_job_status[ll_row] <> 0 then
//	MessageBox("Invalid coil", "Coil/Job has been ran, Please select a valid coil!")
//	return 1
//end if

//il_job = dw_coils.object.process_coil_ab_job_num[ll_row]
//il_coil = dw_coils.object.process_coil_coil_abc_num[ll_row]

if iw_operation_panel.iw_da_sheet.ib_scanner_connected then
	if not isValid( iw_scan_coil_id) then
		OpenWithParm( iw_scan_coil_id, parent )
		ll_scan_row = message.doubleparm
		if ll_scan_row  < 1 then
			return 1
		end if
	end if
else
	ll_scan_row = dw_coils.getselectedrow( 0 )
end if

if ll_scan_row < 1 then
	MessageBox("Error", "Invalid coil, please scan or select coil!")
	return 1
end if

il_job = dw_coils.object.process_coil_ab_job_num[ll_scan_row]
il_coil = dw_coils.object.process_coil_coil_abc_num[ll_scan_row]

ls_coil_id = dw_coils.object.coil_coil_org_num[ll_scan_row]
			
		if dw_coils.object.process_coil_shift_process_status[ll_scan_row] = 0 or dw_coils.object.coil_net_wt_balance[ll_scan_row] < 1 then
				MessageBox("Invalid coil", "Coil is done! Please select a valid coil.")
				return 1
		end if
	
			
			if isValid( iw_operation_panel.iw_da_sheet.iu_current_coil ) then
				MessageBox("Coil is running", "Please end coil first!" )
				return 1
//			if iw_operation_panel.iw_da_sheet.iu_current_coil.get_coil_abc_id( ) = il_coil and &
//				iw_operation_panel.iw_da_sheet.iu_current_coil.get_current_job( ) = il_job then
//				MessageBox( "Select coil", "You already running same coil " + ls_coil_id + " and same job!" , StopSign!)
//			elseif iw_operation_panel.iw_da_sheet.iu_current_coil.get_coil_abc_id( ) = il_coil and &
//				iw_operation_panel.iw_da_sheet.iu_current_coil.get_current_job( ) <> il_job then
//				if MessageBox( "Change Job", "Do you want to change Job for running coil " + ls_coil_id +"?" , Question!, YesNo!,1) =1 then
////					if iw_operation_panel.iw_da_sheet.iuo_shift.of_set_job_id_same_coil(il_job) = 1 then
////							MessageBox("Same coil change job", "Coil #" + ls_coil_id + " has new job " + string(il_job) + "!") 
////					else
////							MessageBox("Same coil change job", "Coil #" + ls_coil_id + " didn't changed!" )
////					end if
//				end if
//			else
//				//
//			end if
		else //No current coil running
			
				long ll_tare_wt, ll_job
				ll_job = il_job
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

			
			iw_operation_panel.iw_da_sheet.iuo_shift.of_set_job_id( il_job )
			iw_operation_panel.iw_da_sheet.iuo_shift.of_set_coil_id( il_coil )
		end if
		iw_operation_panel.iw_da_sheet.wf_set_operation_id( 0 )
		iw_operation_panel.iw_da_sheet.ii_event_id = 0
		iw_operation_panel.postevent( "ue_operation_finish")

end event

type cb_retrieve from commandbutton within u_tabpg_new_coil
boolean visible = false
integer x = 3043
integer y = 163
integer width = 508
integer height = 154
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Retrieve Job list"
end type

event clicked;dw_job_schedule.of_retrieve()
end event

type gb_1 from u_gb within u_tabpg_new_coil
integer x = 40
integer y = 54
integer width = 2955
integer height = 262
integer taborder = 11
integer textsize = -12
string facename = "Arial"
long backcolor = 134217752
string text = "1) Select Job change option"
end type

type gb_2 from u_gb within u_tabpg_new_coil
integer x = 40
integer y = 374
integer width = 2951
integer height = 1568
integer taborder = 21
integer textsize = -12
string facename = "Arial"
long backcolor = 134217752
string text = "2) Select Job and Load coil"
end type

