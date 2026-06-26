$PBExportHeader$w_reverse_coil.srw
forward
global type w_reverse_coil from w_response
end type
type st_warning from statictext within w_reverse_coil
end type
type st_5 from statictext within w_reverse_coil
end type
type st_1 from statictext within w_reverse_coil
end type
type st_wt_prompt from statictext within w_reverse_coil
end type
type st_new_wt from statictext within w_reverse_coil
end type
type rb_inprocess from radiobutton within w_reverse_coil
end type
type rb_rebanded from radiobutton within w_reverse_coil
end type
type rb_onhold from radiobutton within w_reverse_coil
end type
type rb_reject from radiobutton within w_reverse_coil
end type
type cb_ok from commandbutton within w_reverse_coil
end type
type st_2 from statictext within w_reverse_coil
end type
type st_coil from statictext within w_reverse_coil
end type
type st_3 from statictext within w_reverse_coil
end type
type gb_status from groupbox within w_reverse_coil
end type
end forward

global type w_reverse_coil from w_response
integer width = 2370
integer height = 1501
string title = "Reverse coil"
boolean controlmenu = false
boolean center = true
st_warning st_warning
st_5 st_5
st_1 st_1
st_wt_prompt st_wt_prompt
st_new_wt st_new_wt
rb_inprocess rb_inprocess
rb_rebanded rb_rebanded
rb_onhold rb_onhold
rb_reject rb_reject
cb_ok cb_ok
st_2 st_2
st_coil st_coil
st_3 st_3
gb_status gb_status
end type
global w_reverse_coil w_reverse_coil

type variables
int ii_new_status
w_enter_num iw_enter_num

end variables

on w_reverse_coil.create
int iCurrent
call super::create
this.st_warning=create st_warning
this.st_5=create st_5
this.st_1=create st_1
this.st_wt_prompt=create st_wt_prompt
this.st_new_wt=create st_new_wt
this.rb_inprocess=create rb_inprocess
this.rb_rebanded=create rb_rebanded
this.rb_onhold=create rb_onhold
this.rb_reject=create rb_reject
this.cb_ok=create cb_ok
this.st_2=create st_2
this.st_coil=create st_coil
this.st_3=create st_3
this.gb_status=create gb_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_warning
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_wt_prompt
this.Control[iCurrent+5]=this.st_new_wt
this.Control[iCurrent+6]=this.rb_inprocess
this.Control[iCurrent+7]=this.rb_rebanded
this.Control[iCurrent+8]=this.rb_onhold
this.Control[iCurrent+9]=this.rb_reject
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_coil
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.gb_status
end on

on w_reverse_coil.destroy
call super::destroy
destroy(this.st_warning)
destroy(this.st_5)
destroy(this.st_1)
destroy(this.st_wt_prompt)
destroy(this.st_new_wt)
destroy(this.rb_inprocess)
destroy(this.rb_rebanded)
destroy(this.rb_onhold)
destroy(this.rb_reject)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.st_coil)
destroy(this.st_3)
destroy(this.gb_status)
end on

event close;call super::close;if isValid( iw_enter_num ) then
	close( iw_enter_num )
end if
	
end event

event open;call super::open;st_coil.text = message.stringparm

ii_new_status = 1
end event

type st_warning from statictext within w_reverse_coil
integer x = 1276
integer y = 730
integer width = 1024
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_5 from statictext within w_reverse_coil
integer x = 1225
integer y = 365
integer width = 252
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "and"
boolean focusrectangle = false
end type

type st_1 from statictext within w_reverse_coil
integer x = 2158
integer y = 534
integer width = 187
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "LB."
boolean focusrectangle = false
end type

type st_wt_prompt from statictext within w_reverse_coil
integer x = 1529
integer y = 371
integer width = 940
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Coil weight"
boolean focusrectangle = false
end type

type st_new_wt from statictext within w_reverse_coil
string tag = "dt_min_1"
integer x = 1536
integer y = 538
integer width = 574
integer height = 138
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;
s_position ls_p
//w_downtime_line_job_info lw_w
//lw_w = w_downtime2_frame.GetActiveSheet()
ls_p.x = x
ls_p.y = y
OpenWithParm(iw_enter_num, ls_p, parent)
if not isValid( this ) then
	return 0
end if
this.text = Message.StringParm

//int j
//j =  Integer(Mid(this.tag, 8))
//f_update_min(j, this.text)
end event

type rb_inprocess from radiobutton within w_reverse_coil
integer x = 172
integer y = 957
integer width = 852
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65280
long backcolor = 67108864
string text = "Remain on Line"
boolean checked = true
end type

event clicked;st_wt_prompt.text = "Unprocess Weight"
parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(gnv_current_coil.get_old_nw( ))
parent.ii_new_status = 1
end event

type rb_rebanded from radiobutton within w_reverse_coil
integer x = 168
integer y = 800
integer width = 596
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Rebanded"
end type

event clicked;parent.st_wt_prompt.text = "Rebandeded Weight"
parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(gnv_current_coil.get_old_nw( ))
parent.ii_new_status = 7
end event

type rb_onhold from radiobutton within w_reverse_coil
integer x = 168
integer y = 646
integer width = 596
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 67108864
string text = "On Hold"
end type

event clicked;parent.st_wt_prompt.text = "OnHold Weight"
//parent.st_wt_prompt.text = "Rejected Weight"
parent.st_new_wt.enabled = true
parent.ii_new_status = 4
end event

type rb_reject from radiobutton within w_reverse_coil
integer x = 168
integer y = 493
integer width = 596
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "Reject"
end type

event clicked;parent.st_wt_prompt.text = "Rejected Weight"
parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(gnv_current_coil.get_old_nw( ))
parent.ii_new_status = 3
end event

type cb_ok from commandbutton within w_reverse_coil
integer x = 1536
integer y = 950
integer width = 713
integer height = 198
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;s_coil_status ls_new_coil_status
if Long(st_new_wt.text) > 0 then
	ls_new_coil_status.status = ii_new_status
	ls_new_coil_status.weight = Long(st_new_wt.text)
	CloseWithReturn(parent, ls_new_coil_status )
else
	st_warning.text = "Wrong coil weight!"
	return 0
end if



//
//choose case ii_new_status
//	case 0	//done
//		gnv_current_coil.finish( 0, 0)
//	case 4	//onhold
//		if Long(st_new_wt.text) <= gnv_current_coil.get_old_nw( ) then
//				gnv_current_coil.finish( 4, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt!"
//				return 0
//			end if
//	case 1	//inProcess
//		if Long(st_new_wt.text) <= gnv_current_coil.get_old_nw( ) then
//				gnv_current_coil.finish( 1, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt!"
//				return 0
//			end if
//	case else
//		if Long(st_new_wt.text) < gnv_current_coil.get_old_nw( ) then
//				gnv_current_coil.finish( ii_new_status, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt!"
//				return 0
//			end if
//end choose
//
//close(parent)
//gnv_current_coil.finish( 1, 0)
end event

type st_2 from statictext within w_reverse_coil
integer x = 165
integer y = 70
integer width = 644
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Reverse coil "
boolean focusrectangle = false
end type

type st_coil from statictext within w_reverse_coil
integer x = 808
integer y = 67
integer width = 464
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_3 from statictext within w_reverse_coil
integer x = 1371
integer y = 77
integer width = 647
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "from done to"
boolean focusrectangle = false
end type

type gb_status from groupbox within w_reverse_coil
integer x = 95
integer y = 339
integer width = 1115
integer height = 854
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coil Status"
end type

