$PBExportHeader$u_dt_cause_tabpg.sru
forward
global type u_dt_cause_tabpg from u_tabpg
end type
type uo_4 from u_downtimebutton within u_dt_cause_tabpg
end type
type st_5 from statictext within u_dt_cause_tabpg
end type
type st_min from statictext within u_dt_cause_tabpg
end type
type st_2 from statictext within u_dt_cause_tabpg
end type
type p_1 from picture within u_dt_cause_tabpg
end type
type p_2 from picture within u_dt_cause_tabpg
end type
type st_4 from statictext within u_dt_cause_tabpg
end type
type dw_causes from u_dw within u_dt_cause_tabpg
end type
type cb_delete from commandbutton within u_dt_cause_tabpg
end type
type st_3 from statictext within u_dt_cause_tabpg
end type
type st_1 from statictext within u_dt_cause_tabpg
end type
type uo_3 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_2 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_1 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_7 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_8 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_9 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_10 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_16 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_17 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_18 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_19 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_20 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_26 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_27 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_28 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_29 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_30 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_35 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_37 from u_downtimebutton within u_dt_cause_tabpg
end type
type uo_15 from u_downtimebutton within u_dt_cause_tabpg
end type
type dw_others from u_dw within u_dt_cause_tabpg
end type
type cb_continue from commandbutton within u_dt_cause_tabpg
end type
end forward

global type u_dt_cause_tabpg from u_tabpg
integer width = 2765
integer height = 1626
long backcolor = 8421376
string text = "DOWNTIME"
long tabbackcolor = 8421376
boolean ib_isupdateable = false
event ue_1_min_timing ( )
uo_4 uo_4
st_5 st_5
st_min st_min
st_2 st_2
p_1 p_1
p_2 p_2
st_4 st_4
dw_causes dw_causes
cb_delete cb_delete
st_3 st_3
st_1 st_1
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
uo_7 uo_7
uo_8 uo_8
uo_9 uo_9
uo_10 uo_10
uo_16 uo_16
uo_17 uo_17
uo_18 uo_18
uo_19 uo_19
uo_20 uo_20
uo_26 uo_26
uo_27 uo_27
uo_28 uo_28
uo_29 uo_29
uo_30 uo_30
uo_35 uo_35
uo_37 uo_37
uo_15 uo_15
dw_others dw_others
cb_continue cb_continue
end type
global u_dt_cause_tabpg u_dt_cause_tabpg

type variables
u_causes iu_causes
//powerobject ipo_handler
//time it_window_open_time
int ii_min
n_tmg itmg_1_min
w_dt_causes_other iw_dt_causes_other
end variables

forward prototypes
public subroutine f_dt_process (readonly u_downtimebutton u_dt)
public subroutine of_init (readonly u_causes au_c)
public subroutine f_dt_process_other (integer ai_dt_id, string as_dt_name)
public function integer of_validate_inactive_duration ()
public function integer f_delete_cause (integer ai_row)
end prototypes

event ue_1_min_timing();ii_min = ii_min + 1
//st_min.text = string(ii_min)
this.text = "Downtime " + string(ii_min) + " min."// "has elapsed"
long ll_rc,ll_i
ll_rc = dw_causes.rowcount( )
for ll_i=1 to ll_rc
	if dw_causes.getitemnumber( ll_i, "active" ) > 0 then
		dw_causes.setitem( ll_i, "minute", dw_causes.getitemnumber( ll_i, "minute") + 1 )
	end if
next
	
end event

public subroutine f_dt_process (readonly u_downtimebutton u_dt);int li_plb_index, li_min, li_cause_id, li_line_id
long ll_row, ll_i, ll_rc

if not u_dt.is_selected( ) then //Do select
	
	if not isValid(iu_causes) then
		MessageBox("Stop", "No downtime instance created!!", StopSign!)
		return
	end if
	
	
	if iu_causes.get_cause_count( ) < 1 then //First cause
		if MessageBox("This is the first downtime cause", "Downtime will be charged to the beginning of current downtime instance, Do you want to continue?", &
					Question!, YesNo!) = 1 then
			iu_causes.add_cause( iu_causes.get_start_time( )   ,trim(u_dt.caption), u_dt.ii_downtime_reason_id)
			u_dt.set_select( )
			
			li_cause_id = u_dt.ii_downtime_reason_id
			li_line_id = iu_causes.of_get_shift( ).ii_line_id
				UPDATE "LINE_CURRENT_STATUS"  
		     	SET "LINE_STATUS" = :li_cause_id  
			   	WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id   
		           ;
				
				if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
//					MessageBox("Update line status", "Fail to update line status table!")
//					return
				else
					sqlca.of_commit( )
				end if
			
			ll_rc = dw_causes.rowcount( )
	
			ll_row = dw_causes.find( "cause_id = " + string(u_dt.ii_downtime_reason_id), 1, ll_rc )
			li_min = Integer(secondsafterabs(iu_causes.get_cause_start_time_by_id( u_dt.ii_downtime_reason_id),now())/60)
			if ll_row > 0 then
				//dw_causes.deleterow( ll_row)
				//dw_causes.insertrow( ll_row)
				dw_causes.setitem( ll_row, "cause_name", trim(u_dt.caption))
				dw_causes.setitem( ll_row, "active", 1)
				dw_causes.setitem( ll_row, "cause_id", u_dt.ii_downtime_reason_id)
				dw_causes.setitem( ll_row, "minute", li_min )
			else
				ll_row = dw_causes.insertrow( 0 )
				dw_causes.setitem( ll_row, "cause_name", trim(u_dt.caption))
				dw_causes.setitem( ll_row, "active", 1)
				dw_causes.setitem( ll_row, "cause_id", u_dt.ii_downtime_reason_id)
				dw_causes.setitem( ll_row, "minute", li_min )
			end if
			
		end if
	else //Not the first cause
			if MessageBox(trim(u_dt.caption), "Do you want to start this caues?", Question!, YesNo!) = 1 then
//				if not gb_on_shift then
//					return
//				end if
			
				iu_causes.add_cause(trim(u_dt.caption), u_dt.ii_downtime_reason_id)
				u_dt.set_select( )
			
				ll_rc = dw_causes.rowcount( )
	
				ll_row = dw_causes.find( "cause_id = " + string(u_dt.ii_downtime_reason_id), 1, ll_rc )
				li_min = Integer(secondsafterabs(iu_causes.get_cause_start_time_by_id( u_dt.ii_downtime_reason_id),now())/60)
				if ll_row > 0 then
					//dw_causes.deleterow( ll_row)
					//dw_causes.insertrow( ll_row)
					dw_causes.setitem( ll_row, "cause_name", trim(u_dt.caption))
					dw_causes.setitem( ll_row, "active", 1)
					dw_causes.setitem( ll_row, "cause_id", u_dt.ii_downtime_reason_id)
					dw_causes.setitem( ll_row, "minute", li_min )
				else
					ll_row = dw_causes.insertrow( 0 )
					dw_causes.setitem( ll_row, "cause_name", trim(u_dt.caption))
					dw_causes.setitem( ll_row, "active", 1)
					dw_causes.setitem( ll_row, "cause_id", u_dt.ii_downtime_reason_id)
					dw_causes.setitem( ll_row, "minute", li_min )
				end if
			end if
	end if
	
	if isValid(iu_causes.of_get_shift( ).iw_sheet.iu_current_coil) then
		if iu_causes.of_get_shift( ).iw_sheet.iu_current_coil.of_get_finish_percent( ) > 10 and u_dt.ii_downtime_reason_id = 4 then
			Open(iu_causes.of_get_shift( ).iw_sheet.iu_current_coil.iw_dt_change_job_reminder, iu_causes.of_get_shift( ).iw_sheet)
		end if
	end if
	
else //Do unselect
//	iu_causes.is
//	Int li_row, li_rc, li_reason_id, li_index
//	li_rc = dw_causes.rowcount( )
//	if li_rc < 1 then return
//	li_reason_id = u_dt.ii_downtime_reason_id
//	li_index = iu_causes.get_index_by_id( li_reason_id )	
	
	

	
	if iu_causes.is_cause_id_active( u_dt.ii_downtime_reason_id) then
			 //------- Might not needed
//			if not iu_causes.is_any_other_cause_active_besides_this(u_dt.ii_downtime_reason_id) then
//				MessageBox(trim(u_dt.caption), "Can not end this cause, at least one cause must be active!" )
//				return
//			end if
			//--------
			if MessageBox(trim(u_dt.caption), "Do you want to end this cause?", Question!, YesNo!) = 1 then
				
				iu_causes.end_cause_by_id( u_dt.ii_downtime_reason_id)
				u_dt.set_no_selected( )
				ll_rc = dw_causes.rowcount( )
				ll_row = dw_causes.find( "cause_id = " + string(u_dt.ii_downtime_reason_id), 1, ll_rc )
				if ll_row > 0 then
					li_min = iu_causes.get_min_by_index( ll_row)/60
					if li_min < 1 then li_min = 1
					dw_causes.setitem( ll_row, "active", 0)
					dw_causes.setitem( ll_row, "minute", li_min)
				end if
				
			end if
			
	end if
	
end if


end subroutine

public subroutine of_init (readonly u_causes au_c);iu_causes = au_c

int li_control_count, i, j, li_cause_count, li_p_index
u_downtimebutton lu_temp
li_control_count = UpperBound(control)


if not isValid(iu_causes ) then
	return
elseif iu_causes.get_cause_count( ) > 0 then
	
	li_cause_count = iu_causes.get_cause_count( )
	ii_min = secondsafterabs(iu_causes.get_start_time( ), now()) / 60
	this.text = "Downtime " + string(ii_min) + " min." //"has elapsed"
//	this.text = ""
	For i = 1 to li_control_count
		if control[i].tag = "dt" then
			lu_temp = control[i]
			if iu_causes.is_cause_id_active(lu_temp.ii_downtime_reason_id) then
				lu_temp.set_select( )
			end if
		end if
	Next
	
	long ll_row
	for i = 1 to li_cause_count
		ll_row = dw_causes.insertrow( 0 )
		dw_causes.setitem( ll_row, "cause_name", iu_causes.get_name_by_index(i))
		dw_causes.setitem( ll_row, "cause_id",iu_causes.get_id_by_index( i))
		dw_causes.setitem( ll_row, "cause_note", iu_causes.get_note_by_index( i))
		if iu_causes.is_cause_active_by_index( i) then
			dw_causes.setitem( ll_row, "active",1)
			dw_causes.setitem( ll_row, "minute",Integer(secondsafterabs(iu_causes.get_cause_start_time_by_index( i), now())/60))
		else
			dw_causes.setitem( ll_row, "active",0)
			dw_causes.setitem( ll_row, "minute",Integer(iu_causes.get_min_by_index(i)/60) )
		end if
		if iu_causes.get_id_by_index( i) > 26 then
			//
		end if
		
	next
else 
	ii_min = secondsafter(iu_causes.get_start_time( ), now()) / 60
//	st_min.text = string(ii_min)
	this.text = "Downtime " + string(ii_min) + " min."//" has elapsed"
end if

//if dw_others.rowcount( ) <> 1 then
//	dw_others.insertrow( 0 )
//	dw_others.object.caption[1] = "Other"
//	dw_others.object.id[1] = 0
//	dw_others.object.active[1] = 0
//end if
end subroutine

public subroutine f_dt_process_other (integer ai_dt_id, string as_dt_name);int li_plb_index, li_min, li_cause_id, li_line_id
long ll_row, ll_i, ll_rc

boolean lb_selected

if not lb_selected then //select
	
	if not isValid(iu_causes) then
		MessageBox("Stop", "No downtime instance created!!", StopSign!)
		return
	end if
	
	
	if iu_causes.get_cause_count( ) < 1 then
		if MessageBox("This is the first downtime cause", "Downtime will be charged to the beginning of current downtime instance, Do you want to continue?", &
					Question!, YesNo!) = 1 then
			iu_causes.add_cause( iu_causes.get_start_time( )   ,as_dt_name , ai_dt_id )
			lb_selected = true
			
			li_cause_id = ai_dt_id
			li_line_id = iu_causes.of_get_shift( ).ii_line_id
				UPDATE "LINE_CURRENT_STATUS"  
		     	SET "LINE_STATUS" = :li_cause_id  
			   	WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id   
		           ;
				
				if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
//					MessageBox("Update line status", "Fail to update line status table!")
//					return
				else
					sqlca.of_commit( )
				end if
			
			ll_rc = dw_causes.rowcount( )
	
			ll_row = dw_causes.find( "cause_id = " + string(ai_dt_id ), 1, ll_rc )
			li_min = Integer(secondsafterabs(iu_causes.get_cause_start_time_by_id( ai_dt_id ),now())/60)
			if ll_row > 0 then
				//dw_causes.deleterow( ll_row)
				//dw_causes.insertrow( ll_row)
				dw_causes.setitem( ll_row, "cause_name", as_dt_name )
				dw_causes.setitem( ll_row, "active", 1)
				dw_causes.setitem( ll_row, "cause_id", ai_dt_id )
				dw_causes.setitem( ll_row, "minute", li_min )
			else
				ll_row = dw_causes.insertrow( 0 )
				dw_causes.setitem( ll_row, "cause_name", as_dt_name )
				dw_causes.setitem( ll_row, "active", 1)
				dw_causes.setitem( ll_row, "cause_id", ai_dt_id )
				dw_causes.setitem( ll_row, "minute", li_min )
			end if
			
		end if
	else
			if MessageBox(as_dt_name , "Do you want to start this caues?", Question!, YesNo!) = 1 then
//				if not gb_on_shift then
//					return
//				end if
			
				iu_causes.add_cause(as_dt_name , ai_dt_id )
				lb_selected = true
			
				ll_rc = dw_causes.rowcount( )
	
				ll_row = dw_causes.find( "cause_id = " + string(ai_dt_id ), 1, ll_rc )
				li_min = Integer(secondsafterabs(iu_causes.get_cause_start_time_by_id( ai_dt_id ),now())/60)
				if ll_row > 0 then
					//dw_causes.deleterow( ll_row)
					//dw_causes.insertrow( ll_row)
					dw_causes.setitem( ll_row, "cause_name", as_dt_name )
					dw_causes.setitem( ll_row, "active", 1)
					dw_causes.setitem( ll_row, "cause_id", ai_dt_id )
					dw_causes.setitem( ll_row, "minute", li_min )
				else
					ll_row = dw_causes.insertrow( 0 )
					dw_causes.setitem( ll_row, "cause_name", as_dt_name )
					dw_causes.setitem( ll_row, "active", 1)
					dw_causes.setitem( ll_row, "cause_id", ai_dt_id )
					dw_causes.setitem( ll_row, "minute", li_min )
				end if
			end if
	end if
else
	if iu_causes.is_cause_id_active( ai_dt_id ) then
			if MessageBox(as_dt_name , "Do you want to end this cause?", Question!, YesNo!) = 1 then
				
				iu_causes.end_cause_by_id( ai_dt_id )
				lb_selected = false
				ll_rc = dw_causes.rowcount( )
				ll_row = dw_causes.find( "cause_id = " + string(ai_dt_id ), 1, ll_rc )
				if ll_row > 0 then
					li_min = iu_causes.get_min_by_index( ll_row)/60
					dw_causes.setitem( ll_row, "active", 0)
					dw_causes.setitem( ll_row, "minute", li_min)
				end if
				
			end if
			
	end if
	
end if


end subroutine

public function integer of_validate_inactive_duration ();//return 1 if valid, return 0 if too short, return 2 if too long
//dw_causes.accepttext( )
long ll_total_inactive_seconds, ll_i, ll_tmp
boolean lb_too_long
if dw_causes.rowcount( ) < 1 then return 1

ll_total_inactive_seconds = 0
		for ll_i=1 to dw_causes.rowcount( )
			if dw_causes.object.active[ll_i] > 0  then continue
				ll_tmp = dw_causes.object.minute[ll_i]
				if isNull(ll_tmp ) then ll_tmp = 0
				if ll_tmp > ii_min + 1 then lb_too_long = true
				ll_total_inactive_seconds = ll_total_inactive_seconds + ll_tmp * 60
		next

			ll_total_inactive_seconds = ll_total_inactive_seconds + 60
			
			if lb_too_long then 
				return 2
			elseif ll_total_inactive_seconds < iu_causes.get_sec_from_inst_start_2_active_cause( ) then
				return 0	
			else
				return 1
			end if

end function

public function integer f_delete_cause (integer ai_row);long ll_selected
ll_selected = ai_row
if ll_selected < 1 then
	MessageBox("Stop", "You have selected nothing!!", StopSign!)
	return 0
end if

if isValid(iu_causes) and iu_causes.is_cause_active_by_index( Integer(ll_selected ) ) then
//	MessageBox(iu_causes.get_name_by_index( Integer(ll_selected )) , "You can not delete a actived cause!!", StopSign!)
	return 0
end if


if MessageBox(iu_causes.get_name_by_index( Integer(ll_selected )), "Do you want to delete this cause?", Question!, YesNo!) = 1 then
		//if not gb_on_shift then
		//	return 0
		//end if
		//plb_cause_queue.deleteitem( li_selected)
		dw_causes.deleterow( ll_selected )
		iu_causes.delete_cause_by_index( ll_selected)
end if
return 1
end function

on u_dt_cause_tabpg.create
int iCurrent
call super::create
this.uo_4=create uo_4
this.st_5=create st_5
this.st_min=create st_min
this.st_2=create st_2
this.p_1=create p_1
this.p_2=create p_2
this.st_4=create st_4
this.dw_causes=create dw_causes
this.cb_delete=create cb_delete
this.st_3=create st_3
this.st_1=create st_1
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
this.uo_7=create uo_7
this.uo_8=create uo_8
this.uo_9=create uo_9
this.uo_10=create uo_10
this.uo_16=create uo_16
this.uo_17=create uo_17
this.uo_18=create uo_18
this.uo_19=create uo_19
this.uo_20=create uo_20
this.uo_26=create uo_26
this.uo_27=create uo_27
this.uo_28=create uo_28
this.uo_29=create uo_29
this.uo_30=create uo_30
this.uo_35=create uo_35
this.uo_37=create uo_37
this.uo_15=create uo_15
this.dw_others=create dw_others
this.cb_continue=create cb_continue
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_4
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_min
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.dw_causes
this.Control[iCurrent+9]=this.cb_delete
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.uo_3
this.Control[iCurrent+13]=this.uo_2
this.Control[iCurrent+14]=this.uo_1
this.Control[iCurrent+15]=this.uo_7
this.Control[iCurrent+16]=this.uo_8
this.Control[iCurrent+17]=this.uo_9
this.Control[iCurrent+18]=this.uo_10
this.Control[iCurrent+19]=this.uo_16
this.Control[iCurrent+20]=this.uo_17
this.Control[iCurrent+21]=this.uo_18
this.Control[iCurrent+22]=this.uo_19
this.Control[iCurrent+23]=this.uo_20
this.Control[iCurrent+24]=this.uo_26
this.Control[iCurrent+25]=this.uo_27
this.Control[iCurrent+26]=this.uo_28
this.Control[iCurrent+27]=this.uo_29
this.Control[iCurrent+28]=this.uo_30
this.Control[iCurrent+29]=this.uo_35
this.Control[iCurrent+30]=this.uo_37
this.Control[iCurrent+31]=this.uo_15
this.Control[iCurrent+32]=this.dw_others
this.Control[iCurrent+33]=this.cb_continue
end on

on u_dt_cause_tabpg.destroy
call super::destroy
destroy(this.uo_4)
destroy(this.st_5)
destroy(this.st_min)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.st_4)
destroy(this.dw_causes)
destroy(this.cb_delete)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.uo_7)
destroy(this.uo_8)
destroy(this.uo_9)
destroy(this.uo_10)
destroy(this.uo_16)
destroy(this.uo_17)
destroy(this.uo_18)
destroy(this.uo_19)
destroy(this.uo_20)
destroy(this.uo_26)
destroy(this.uo_27)
destroy(this.uo_28)
destroy(this.uo_29)
destroy(this.uo_30)
destroy(this.uo_35)
destroy(this.uo_37)
destroy(this.uo_15)
destroy(this.dw_others)
destroy(this.cb_continue)
end on

event constructor;call super::constructor;//MessageBox("cause page", "constructor")
//this.text = "Downtime causes"
itmg_1_min = create n_tmg
itmg_1_min.of_setsingle( true)
itmg_1_min.inv_single.of_register( this, "ue_1_min_timing", 60)
ii_min = 0
end event

event destructor;call super::destructor;destroy itmg_1_min
//ipo_handler.postevent("ue_downtime_processing", 0, 0)
end event

type uo_4 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 18
integer y = 774
integer width = 658
integer height = 115
integer taborder = 30
boolean bringtotop = true
integer ii_downtime_reason_id = 43
string caption = "        EDGE TRIM"
end type

on uo_4.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type st_5 from statictext within u_dt_cause_tabpg
boolean visible = false
integer x = 1931
integer y = 19
integer width = 702
integer height = 58
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 8421376
string text = "min. has elapsed"
boolean focusrectangle = false
end type

type st_min from statictext within u_dt_cause_tabpg
boolean visible = false
integer x = 1843
integer y = 13
integer width = 102
integer height = 64
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 8421376
string text = "0"
boolean focusrectangle = false
end type

type st_2 from statictext within u_dt_cause_tabpg
integer x = 2008
integer y = 1536
integer width = 761
integer height = 102
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 8421376
string text = "Apply time and notes to causes"
boolean focusrectangle = false
end type

type p_1 from picture within u_dt_cause_tabpg
integer x = 15
integer y = 1523
integer width = 73
integer height = 64
string picturename = "playH.jpg"
boolean focusrectangle = false
end type

type p_2 from picture within u_dt_cause_tabpg
boolean visible = false
integer x = 347
integer y = 1523
integer width = 73
integer height = 64
boolean enabled = false
string picturename = "stop.jpg"
boolean focusrectangle = false
end type

type st_4 from statictext within u_dt_cause_tabpg
integer x = 5665
integer y = 1811
integer width = 293
integer height = 90
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
string text = "Ended"
boolean focusrectangle = false
end type

type dw_causes from u_dw within u_dt_cause_tabpg
integer x = 4
integer y = 928
integer width = 2765
integer height = 582
integer taborder = 70
string title = "Causes Queue"
string dataobject = "d_downtime_causes"
end type

event constructor;call super::constructor;//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_register( "minute", this.iuo_calculator.NONE)
//this.iuo_calculator.of_SetCloseOnClick(True)
//this.iuo_calculator.of_SetInitialValue(TRUE)
this.of_setbase( true)
end event

event clicked;call super::clicked;if row < 1 then 
	return 0
end if

//this.selectrow( 0, false)
//this.selectrow( row, true)
//



if dwo.Name = "minute" and this.getitemnumber( row, "active") > 0 then
//	iuo_calculator.enabled = false
	return 1
elseif dwo.Name="delete" then
//	MessageBox("Delete","Clicked")
	f_delete_cause(row)
else
	return 0
end if
end event

event itemchanged;call super::itemchanged;Long ll_total_inactive_seconds,ll_i, ll_sec
CHOOSE CASE Lower(dwo.Name)
	case "cause_note"
		iu_causes.set_note_by_index( row, data)
	case "minute"
		ll_total_inactive_seconds = 0
		for ll_i=1 to this.rowcount( )
			if ll_i = row or this.object.active[ll_i] > 0  then continue
				ll_sec =  this.object.minute[ll_i] * 60
				if isNull(ll_sec) then ll_sec = 0
				ll_total_inactive_seconds = ll_total_inactive_seconds + ll_sec
				//
		next

		ll_total_inactive_seconds = (Integer(data) + 1) * 60 + ll_total_inactive_seconds
		
		if isNull(ll_total_inactive_seconds) then ll_total_inactive_seconds = 0
		
		if (not iu_causes.is_cause_active_by_index( row )) then
			if Integer(data) > (ii_min + 1) then 
				MessageBox("Data Error", "Downtime minute can not be longer then " + string( ii_min + 1) + "!")
				return 1
			elseif ll_total_inactive_seconds < iu_causes.get_sec_from_inst_start_2_active_cause( ) then
				MessageBox("Data Error", "Downtime minute can not be shorter then " + string( Int(iu_causes.get_sec_from_inst_start_2_active_cause( )/60)) + " minutes" )  
				return 1	
			else
				iu_causes.set_min_by_index( row, Integer(data) * 60 )	
				return 0
			end if
		else
			MessageBox("Data Error", "Downtime minute can not be changed for active cause!")
			return 1 //Can not change when active
		end if
END CHOOSE
return 0
	
end event

event itemerror;call super::itemerror;return 1
end event

event rbuttondown;return 0
end event

event rbuttonup;return 0
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;//this.setfocus( )
this.setrow( al_row)
this.setcolumn( "cause_note")
end event

event doubleclicked;call super::doubleclicked;//if row > 0 then
//	this.selectrow( 0, false)
//	this.selectrow( row, true)
//end if
end event

type cb_delete from commandbutton within u_dt_cause_tabpg
boolean visible = false
integer x = 644
integer y = 1523
integer width = 717
integer height = 102
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete selected cause"
end type

event clicked;if not isValid(iu_causes) then
	return 0
end if
long ll_selected
ll_selected = dw_causes.getrow( )
if ll_selected < 1 then
	MessageBox("Stop", "You have selected nothing!!", StopSign!)
	return 0
end if

if isValid(iu_causes) and iu_causes.is_cause_active_by_index( Integer(ll_selected ) ) then
//	MessageBox(iu_causes.get_name_by_index( Integer(ll_selected )) , "You can not delete a actived cause!!", StopSign!)
	return 0
end if


if MessageBox(iu_causes.get_name_by_index( Integer(ll_selected )), "Do you want to delete this cause?", Question!, YesNo!) = 1 then
		//if not gb_on_shift then
		//	return 0
		//end if
		//plb_cause_queue.deleteitem( li_selected)
		dw_causes.deleterow( ll_selected )
		iu_causes.delete_cause_by_index( ll_selected)
end if

end event

type st_3 from statictext within u_dt_cause_tabpg
integer x = 88
integer y = 1523
integer width = 249
integer height = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 8421376
string text = "Active"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within u_dt_cause_tabpg
boolean visible = false
integer x = 453
integer y = 1523
integer width = 190
integer height = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 8421376
boolean enabled = false
string text = "Ended"
boolean focusrectangle = false
end type

type uo_3 from u_downtimebutton within u_dt_cause_tabpg
string tag = "dt"
integer x = 2099
integer y = 637
integer width = 658
integer height = 115
integer taborder = 50
boolean bringtotop = true
integer ii_downtime_reason_id = 25
string caption = "        INTERLEAVE"
end type

on uo_3.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_2 from u_downtimebutton within u_dt_cause_tabpg
string tag = "dt"
integer x = 1404
integer y = 637
integer width = 658
integer height = 115
integer taborder = 40
boolean bringtotop = true
integer ii_downtime_reason_id = 24
string caption = "        LATE START"
end type

on uo_2.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_1 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 15
integer y = 22
integer width = 658
integer height = 115
integer taborder = 10
boolean bringtotop = true
integer ii_downtime_reason_id = 1
string caption = "        COIL CHANGE"
end type

on uo_1.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)

end event

type uo_7 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 15
integer y = 483
integer width = 658
integer height = 115
integer taborder = 70
boolean bringtotop = true
integer ii_downtime_reason_id = 13
string caption = "        ANGLE CHANGE"
end type

on uo_7.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_8 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 709
integer y = 330
integer width = 658
integer height = 115
integer taborder = 60
boolean bringtotop = true
integer ii_downtime_reason_id = 10
string caption = "        QUALITY"
end type

on uo_8.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_9 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 1404
integer y = 176
integer width = 658
integer height = 115
integer taborder = 50
boolean bringtotop = true
integer ii_downtime_reason_id = 7
string caption = "        FIRST PIECE"
end type

on uo_9.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_10 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 2099
integer y = 22
integer width = 658
integer height = 115
integer taborder = 30
boolean bringtotop = true
integer ii_downtime_reason_id = 4
string caption = "        SET UP"
end type

on uo_10.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_16 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 709
integer y = 483
integer width = 658
integer height = 115
integer taborder = 60
boolean bringtotop = true
integer ii_downtime_reason_id = 14
string caption = "        TAPE BLADE"
end type

on uo_16.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_17 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 1404
integer y = 330
integer width = 658
integer height = 115
integer taborder = 50
boolean bringtotop = true
integer ii_downtime_reason_id = 11
string caption = "        OILER FAULT"
end type

on uo_17.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_18 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 2099
integer y = 176
integer width = 658
integer height = 115
integer taborder = 40
boolean bringtotop = true
integer ii_downtime_reason_id = 8
string caption = "        CLEAN ROLLS"
end type

on uo_18.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_19 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 15
integer y = 176
integer width = 658
integer height = 115
integer taborder = 30
boolean bringtotop = true
integer ii_downtime_reason_id = 5
string caption = "        DIE CHANGE"
end type

on uo_19.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_20 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 709
integer y = 22
integer width = 658
integer height = 115
integer taborder = 10
boolean bringtotop = true
integer ii_downtime_reason_id = 2
string caption = "        SKID CHANGE"
end type

on uo_20.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_26 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 1404
integer y = 483
integer width = 658
integer height = 115
integer taborder = 50
boolean bringtotop = true
integer ii_downtime_reason_id = 15
string caption = "        UNDERWIND"
end type

on uo_26.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_27 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 2099
integer y = 330
integer width = 658
integer height = 115
integer taborder = 40
boolean bringtotop = true
integer ii_downtime_reason_id = 12
string caption = "        REJECT COIL"
end type

on uo_27.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_28 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 15
integer y = 330
integer width = 658
integer height = 115
integer taborder = 30
boolean bringtotop = true
integer ii_downtime_reason_id = 9
string caption = "        TOOLING"
end type

on uo_28.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_29 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 709
integer y = 176
integer width = 658
integer height = 115
integer taborder = 20
boolean bringtotop = true
integer ii_downtime_reason_id = 6
string caption = "        TEAR DOWN"
end type

on uo_29.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_30 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 1404
integer y = 22
integer width = 658
integer height = 115
integer taborder = 10
boolean bringtotop = true
integer ii_downtime_reason_id = 3
string caption = "        MAINTENANCE"
end type

on uo_30.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_35 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 15
integer y = 637
integer width = 658
integer height = 115
integer taborder = 20
boolean bringtotop = true
integer ii_downtime_reason_id = 17
string caption = "        RECAP"
end type

on uo_35.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_37 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 2099
integer y = 483
integer width = 658
integer height = 115
integer taborder = 10
boolean bringtotop = true
integer ii_downtime_reason_id = 16
string caption = "        BREAK"
end type

on uo_37.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;f_dt_process(this)
end event

type uo_15 from u_downtimebutton within u_dt_cause_tabpg
event destroy ( )
string tag = "dt"
integer x = 709
integer y = 637
integer width = 658
integer height = 115
integer taborder = 30
integer ii_downtime_reason_id = 18
string caption = "        OTHER"
end type

on uo_15.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;//f_dt_process(this)
OpenWithParm( iw_dt_causes_other, parent )
end event

type dw_others from u_dw within u_dt_cause_tabpg
integer x = 709
integer y = 637
integer width = 658
integer height = 115
integer taborder = 60
string dataobject = "d_causes_other"
boolean vscrollbar = false
end type

event constructor;call super::constructor;//
end event

type cb_continue from commandbutton within u_dt_cause_tabpg
integer x = 662
integer y = 1523
integer width = 1342
integer height = 102
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Finish downtime cause and enable auto >>"
end type

event clicked;dw_causes.accepttext( )

//if not isValid(iu_causes ) then
//	iu_causes = create u_causes
//end if

if iu_causes.get_cause_count( ) <= 0 then
	MessageBox("No Downtime cause selected", "Please select downtime cause!!", StopSign!)
	return 0
end if

if of_validate_inactive_duration( ) = 0 then
	MessageBox("Inactive cause error", "Total inactive cause duration too short!"  )
	return 0
end if

if of_validate_inactive_duration( ) = 2 then
	MessageBox("Inactive cause error", "Total inactive cause duration too long!"  )
	return 0
end if

if not iu_causes.is_any_cause_active( ) then
	MessageBox("No active cause", "You must have at least one cause active in order to continue!!", StopSign!)
	return 0
end if

int j

	For j =1 to iu_causes.get_cause_count( )
		if iu_causes.get_note_by_index( j) = "" then
			if iu_causes.get_id_by_index( j ) = 3 or iu_causes.get_id_by_index( j ) = 9 or &
				iu_causes.get_id_by_index( j ) = 10 or iu_causes.get_id_by_index( j ) = 18 then
					st_2.text = "You must enter note for " + iu_causes.get_name_by_index( j) 
					//MessageBox("Can not continue", "You must enter note for " + iu_causes.get_name_by_index( j), StopSign!)
					parent.of_messagebox( "id123", "Can not continue", "You must enter note for " + iu_causes.get_name_by_index( j), StopSign!, OK!, 1)
					return 0	
			else 
				st_2.text = "Apply time and notes to downtime causes"
			end if
		end if
	Next
iu_causes.of_set_status( 3 )
iu_causes.of_open_prodution_resume( )
iu_causes.postevent( "ue_log_end")
//ipo_handler.postevent( "ue_close_cause_tabpg")


/*
	if iu_causes.is_id_in_instance( 12 ) or iu_causes.is_id_in_instance( 1 ) then //Coil changed or rejected
		if MessageBox("Coil " + gnv_current_coil.get_coil_org_id( ) , "Do you want to change this coil " + gnv_current_coil.get_coil_org_id( ), Question!, YesNo!) = 1 then
				if not gb_on_shift then
					return 0
				end if
				lw_w.open_w_change_coil( )
				if not gb_on_shift then
					return 0
				end if
		elseif gnv_current_coil.get_coil_shift_status( ) < 2 then
		else
				return 0
		end if
	elseif parent.cbx_change_job_not_coil.checked = true then
		long ll_job
		ll_job = gl_job_num
		lw_w.open_w_change_job( )
		if not gb_on_shift then
					return 0
		end if
		if ll_job <> gl_job_num then
			lw_w.open_w_finish_coil( )
			if not gb_on_shift then
					return 0
			end if
			gnv_current_coil.split_and_save( gnv_current_coil.get_new_status( ) ,  gnv_current_coil.get_nw_bal( ) , ll_job)
			lw_w.show_dw_process_status( )
			lw_w.show_dw_shift_coil( )
		end if
	else
	end if
	
	if not gb_on_shift then
					return 0
	end if
	
	close(parent)
	lw_w.open_w_apply_duratio( )

*/
end event

