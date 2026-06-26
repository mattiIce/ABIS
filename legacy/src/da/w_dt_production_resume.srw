$PBExportHeader$w_dt_production_resume.srw
forward
global type w_dt_production_resume from w_popup
end type
type st_sec from statictext within w_dt_production_resume
end type
type st_1 from statictext within w_dt_production_resume
end type
type cb_back from commandbutton within w_dt_production_resume
end type
end forward

global type w_dt_production_resume from w_popup
integer x = 0
integer y = 0
integer width = 3741
integer height = 122
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 8421376
st_sec st_sec
st_1 st_1
cb_back cb_back
end type
global w_dt_production_resume w_dt_production_resume

type variables
u_causes iu_dt_instance
long il_seconds
end variables

on w_dt_production_resume.create
int iCurrent
call super::create
this.st_sec=create st_sec
this.st_1=create st_1
this.cb_back=create cb_back
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sec
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_back
end on

on w_dt_production_resume.destroy
call super::destroy
destroy(this.st_sec)
destroy(this.st_1)
destroy(this.cb_back)
end on

event open;call super::open;//il_shift_id = message.longparm
iu_dt_instance = message.powerobjectparm
//il_shift_id = iu_dt_instance.of_get_shift( ).get_shift_id( )
iu_dt_instance.of_get_shift( ).of_enable_line( true)
//st_2.text = string(il_shift_id)
//ii_seconds = 60

//ole_1.object.connect
/*
if not isNull(gnv_current_dt_instance) then
	gnv_current_dt_instance.set_end( today(), now())
	gnv_current_dt_instance.save( )
	setNull(gnv_current_dt_instance)
end if

iu_dt_instance_mis = CREATE u_causes
//iu_dt_instance_mis.set_start( today(), now())
iu_dt_instance_mis.add_cause( 0, "MISCELLANEOUS", 23) //MISCELLANEOUS ID is 23
iu_dt_instance_mis.set_start( today(), now())
*/
Timer(1)
end event

event timer;call super::timer;//il_seconds = il_seconds + 1
il_seconds = &
iu_dt_instance.of_get_shift( ).iw_sheet.inv_datetime.of_secondsafter( iu_dt_instance.get_inst_start_datetime( ) , DateTime(Today(), Now()))
st_sec.text = string( il_seconds ) + " sec."

if iu_dt_instance.of_get_shift( ).iw_sheet.ib_autorunning then
	iu_dt_instance.of_get_shift( ).postevent( "ue_line_running")
end if
end event

type st_sec from statictext within w_dt_production_resume
integer x = 15
integer y = 16
integer width = 505
integer height = 83
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
boolean focusrectangle = false
end type

type st_1 from statictext within w_dt_production_resume
integer x = 2136
integer y = 22
integer width = 1382
integer height = 99
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 8421376
string text = "Production auto can return at any time."
boolean focusrectangle = false
end type

type cb_back from commandbutton within w_dt_production_resume
integer x = 571
integer y = 10
integer width = 1324
integer height = 102
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<< Back to downtime causes"
end type

event clicked;iu_dt_instance.of_get_shift( ).of_enable_line(false)
iu_dt_instance.of_set_status( 2)
iu_dt_instance.of_open_dt_tabpg( )
close(parent)

end event

