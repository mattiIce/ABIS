$PBExportHeader$w_done_coil.srw
forward
global type w_done_coil from w_response
end type
type cb_ok from commandbutton within w_done_coil
end type
type cb_canel from commandbutton within w_done_coil
end type
type rb_done from radiobutton within w_done_coil
end type
type rb_reject from radiobutton within w_done_coil
end type
type rb_onhold from radiobutton within w_done_coil
end type
type rb_rebanded from radiobutton within w_done_coil
end type
type rb_inprocess from radiobutton within w_done_coil
end type
type st_new_wt from statictext within w_done_coil
end type
type st_wt_prompt from statictext within w_done_coil
end type
type st_1 from statictext within w_done_coil
end type
type st_2 from statictext within w_done_coil
end type
type st_coil_org_num from statictext within w_done_coil
end type
type st_4 from statictext within w_done_coil
end type
type st_5 from statictext within w_done_coil
end type
type st_old_nw from statictext within w_done_coil
end type
type st_3 from statictext within w_done_coil
end type
type st_warning from statictext within w_done_coil
end type
type gb_status from groupbox within w_done_coil
end type
end forward

global type w_done_coil from w_response
integer x = 214
integer width = 2629
integer height = 1626
string title = "Enter statue for processed coil"
cb_ok cb_ok
cb_canel cb_canel
rb_done rb_done
rb_reject rb_reject
rb_onhold rb_onhold
rb_rebanded rb_rebanded
rb_inprocess rb_inprocess
st_new_wt st_new_wt
st_wt_prompt st_wt_prompt
st_1 st_1
st_2 st_2
st_coil_org_num st_coil_org_num
st_4 st_4
st_5 st_5
st_old_nw st_old_nw
st_3 st_3
st_warning st_warning
gb_status gb_status
end type
global w_done_coil w_done_coil

type variables
long il_old_nt
long il_new_nt
int ii_old_status
int ii_new_status
w_enter_num iw_enter_num
u_coil iu_coil
end variables

on w_done_coil.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_canel=create cb_canel
this.rb_done=create rb_done
this.rb_reject=create rb_reject
this.rb_onhold=create rb_onhold
this.rb_rebanded=create rb_rebanded
this.rb_inprocess=create rb_inprocess
this.st_new_wt=create st_new_wt
this.st_wt_prompt=create st_wt_prompt
this.st_1=create st_1
this.st_2=create st_2
this.st_coil_org_num=create st_coil_org_num
this.st_4=create st_4
this.st_5=create st_5
this.st_old_nw=create st_old_nw
this.st_3=create st_3
this.st_warning=create st_warning
this.gb_status=create gb_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_canel
this.Control[iCurrent+3]=this.rb_done
this.Control[iCurrent+4]=this.rb_reject
this.Control[iCurrent+5]=this.rb_onhold
this.Control[iCurrent+6]=this.rb_rebanded
this.Control[iCurrent+7]=this.rb_inprocess
this.Control[iCurrent+8]=this.st_new_wt
this.Control[iCurrent+9]=this.st_wt_prompt
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_coil_org_num
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.st_old_nw
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.st_warning
this.Control[iCurrent+18]=this.gb_status
end on

on w_done_coil.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_canel)
destroy(this.rb_done)
destroy(this.rb_reject)
destroy(this.rb_onhold)
destroy(this.rb_rebanded)
destroy(this.rb_inprocess)
destroy(this.st_new_wt)
destroy(this.st_wt_prompt)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_coil_org_num)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_old_nw)
destroy(this.st_3)
destroy(this.st_warning)
destroy(this.gb_status)
end on

event close;call super::close;if isValid( iw_enter_num ) then
	close(iw_enter_num)
end if
end event

event open;call super::open;iu_coil = message.powerobjectparm
this.title = "Coil " + iu_coil.get_coil_org_id( )
st_coil_org_num.text = iu_coil.get_coil_org_id( )
st_old_nw.text = string(iu_coil.get_old_nw( ) )
st_new_wt.text = "0"
ii_new_status = 0
end event

type cb_ok from commandbutton within w_done_coil
integer x = 1536
integer y = 874
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

event clicked;if iu_coil.get_coil_shift_status( ) = 2 then
	
	choose case ii_new_status
		case 0	//done
			iu_coil.finish( 0, 0)
		case 4	//onhold
			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) < iu_coil.get_old_nw( ) then
				iu_coil.finish( 4, Long(st_new_wt.text))
			else 
				st_warning.text = "Weight must be less than old wt and > 0!"
				return 0
			end if
		case 1	//inProcess
			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) < iu_coil.get_old_nw( ) then
				iu_coil.finish( 1, Long(st_new_wt.text))
			else 
				st_warning.text = "Weight must be less than old wt and > 0!"
				return 0
			end if
		case else
			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) < iu_coil.get_old_nw( ) then
				iu_coil.finish( ii_new_status, Long(st_new_wt.text))
			else 
				st_warning.text = "Weight must be less than old wt and >0!"
				return 0
			end if
	end choose
else
		choose case ii_new_status
		case 0	//done
			iu_coil.finish( 0, 0)
		case 4	//onhold
			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) <= iu_coil.get_old_nw( ) then
				iu_coil.finish( 4, Long(st_new_wt.text))
			else 
				st_warning.text = "Weight must be less than old wt and > 0!"
				return 0
			end if
		case 1	//inProcess
			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) <= iu_coil.get_old_nw( ) then
				iu_coil.finish( 1, Long(st_new_wt.text))
			else 
				st_warning.text = "Weight must be less than old wt and > 0!"
				return 0
			end if
		case else
			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) <= iu_coil.get_old_nw( ) then
				iu_coil.finish( ii_new_status, Long(st_new_wt.text))
			else 
				st_warning.text = "Weight must be less than old wt and > 0!"
				return 0
			end if
	end choose	
	
end if


close(parent)

//iu_coil.finish( 1, 0)
end event

type cb_canel from commandbutton within w_done_coil
boolean visible = false
integer x = 1536
integer y = 1178
integer width = 713
integer height = 198
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cancel"
end type

event clicked;close(parent)
end event

type rb_done from radiobutton within w_done_coil
integer x = 143
integer y = 531
integer width = 742
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 67108864
string text = "Done"
boolean checked = true
end type

event clicked;parent.st_wt_prompt.text = "Done Coil"
parent.st_new_wt.text = "0"
parent.st_new_wt.enabled = false
parent.ii_new_status = 0

end event

type rb_reject from radiobutton within w_done_coil
integer x = 143
integer y = 1146
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
parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
parent.ii_new_status = 3

end event

type rb_onhold from radiobutton within w_done_coil
integer x = 143
integer y = 838
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
parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
parent.st_new_wt.enabled = true
parent.ii_new_status = 4
end event

type rb_rebanded from radiobutton within w_done_coil
integer x = 143
integer y = 685
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
parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
parent.ii_new_status = 7

end event

type rb_inprocess from radiobutton within w_done_coil
integer x = 143
integer y = 992
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
end type

event clicked;st_wt_prompt.text = "Unprocess Weight"
parent.st_new_wt.enabled = true
parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
parent.ii_new_status = 1

end event

type st_new_wt from statictext within w_done_coil
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
boolean enabled = false
string text = "0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;s_position ls_p
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

type st_wt_prompt from statictext within w_done_coil
integer x = 1584
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

type st_1 from statictext within w_done_coil
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

type st_2 from statictext within w_done_coil
integer x = 527
integer y = 42
integer width = 245
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Coil"
boolean focusrectangle = false
end type

type st_coil_org_num from statictext within w_done_coil
integer x = 764
integer y = 35
integer width = 497
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_4 from statictext within w_done_coil
integer x = 424
integer y = 150
integer width = 1730
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "had been processed, please update"
end type

type st_5 from statictext within w_done_coil
integer x = 1280
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

type st_old_nw from statictext within w_done_coil
integer x = 1273
integer y = 35
integer width = 556
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_3 from statictext within w_done_coil
integer x = 1785
integer y = 42
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

type st_warning from statictext within w_done_coil
integer x = 1247
integer y = 730
integer width = 1287
integer height = 102
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type gb_status from groupbox within w_done_coil
integer x = 73
integer y = 365
integer width = 1046
integer height = 1002
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

