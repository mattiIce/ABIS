$PBExportHeader$w_dt_one_min_log.srw
forward
global type w_dt_one_min_log from w_popup
end type
type st_1 from statictext within w_dt_one_min_log
end type
type st_timer from statictext within w_dt_one_min_log
end type
type st_3 from statictext within w_dt_one_min_log
end type
type cb_continue from commandbutton within w_dt_one_min_log
end type
end forward

global type w_dt_one_min_log from w_popup
integer x = 0
integer y = 0
integer width = 3734
integer height = 122
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 65535
boolean ib_isupdateable = false
st_1 st_1
st_timer st_timer
st_3 st_3
cb_continue cb_continue
end type
global w_dt_one_min_log w_dt_one_min_log

type variables
int ii_seconds, ii_line_id
u_causes iu_dt_instance
Long il_shift_id

end variables

on w_dt_one_min_log.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_timer=create st_timer
this.st_3=create st_3
this.cb_continue=create cb_continue
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_timer
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.cb_continue
end on

on w_dt_one_min_log.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_timer)
destroy(this.st_3)
destroy(this.cb_continue)
end on

event timer;call super::timer;if not isValid(iu_dt_instance) then
	close(this)
	return 0
end if
ii_seconds = ii_seconds -1


/*
w_downtime_line_job_info lw_write
if il_shift_id <> gl_shift_num then
	close(this)
	return 0
end if
*/

if ii_seconds < 0 then
	iu_dt_instance.of_get_shift( ).of_enable_line( false)
	iu_dt_instance.of_set_status( 2 )
	//iu_dt_instance_mis.end_cause_by_index( 1)
	//iu_dt_instance_mis.set_end( today(), now())
	//iu_dt_instance_mis.save( )
	//setNull(iu_dt_instance_mis)
	//gnv_current_dt_instance = create u_causes
	//gnv_current_dt_instance.set_start( iu_dt_instance_mis.get_start_date(),iu_dt_instance_mis.get_start_time() )
	//setNull(iu_dt_instance_mis)
	iu_dt_instance.of_open_dt_tabpg( )
		
		UPDATE "LINE_CURRENT_STATUS"  
     	SET "LINE_STATUS" = 22  
   	WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :ii_line_id   
           ;
		
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			MessageBox("Update line status", "Fail to update line status table!")
			return
		else
			sqlca.of_commit( )
		end if
	
	
	close(this)
	
	//lw_write.open_w_downtime_dause( )  //Open Downtime causes window
else
		if ii_seconds < 15 then
			st_timer.textcolor = RGB(255,0,0)
		else
			st_timer.textcolor = RGB(0,128,128)
		end if
	st_timer.text = string(ii_seconds)
//	if iu_dt_instance.of_get_shift( ).of_get_w_sheet( ).ib_autorunning then
//		//destroy iu_dt_instance
//		//close(this)
//		return 0
//	end if
//	if gb_press_idle = false then
//		//iu_dt_instance_mis.add_cause( (120 - ii_seconds)/60, "MISCELLANEOUS", 23)
//		iu_dt_instance_mis.end_cause_by_index( 1)
//		iu_dt_instance_mis.set_end( today(), now())
//		iu_dt_instance_mis.save( )
//		setNull(iu_dt_instance_mis)
//		gb_in_dt_process = false
//		close(this)
//	end if
//
end if

end event

event open;call super::open;iu_dt_instance = message.powerobjectparm
il_shift_id = iu_dt_instance.of_get_shift( ).get_shift_id( )
ii_seconds = 60
ii_line_id = iu_dt_instance.of_get_shift( ).ii_line_id
Timer(1)
end event

type st_1 from statictext within w_dt_one_min_log
integer x = 325
integer y = 19
integer width = 1339
integer height = 99
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "Logged downtime event will occur in"
boolean focusrectangle = false
end type

type st_timer from statictext within w_dt_one_min_log
integer x = 1679
integer y = 19
integer width = 124
integer height = 90
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "0"
boolean focusrectangle = false
end type

type st_3 from statictext within w_dt_one_min_log
integer x = 1847
integer y = 19
integer width = 358
integer height = 106
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "seconds."
boolean focusrectangle = false
end type

type cb_continue from commandbutton within w_dt_one_min_log
integer x = 2297
integer y = 3
integer width = 1331
integer height = 109
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continue to Downtime causes >>"
end type

event clicked;iu_dt_instance.of_get_shift( ).of_enable_line(false)
iu_dt_instance.of_set_status( 2)
iu_dt_instance.of_open_dt_tabpg( )
	UPDATE "LINE_CURRENT_STATUS"  
     	SET "LINE_STATUS" = 22  
   	WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :ii_line_id   
           ;
		
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			MessageBox("Update line status", "Fail to update line status table!")
			return
		else
			sqlca.of_commit( )
		end if
close(parent)

end event

