$PBExportHeader$w_change_coil.srw
forward
global type w_change_coil from w_response
end type
type cb_select from commandbutton within w_change_coil
end type
type dw_coils from datawindow within w_change_coil
end type
type st_10 from statictext within w_change_coil
end type
type st_11 from statictext within w_change_coil
end type
type st_12 from statictext within w_change_coil
end type
type st_13 from statictext within w_change_coil
end type
type st_14 from statictext within w_change_coil
end type
type st_15 from statictext within w_change_coil
end type
type st_job from statictext within w_change_coil
end type
type cb_change_job from commandbutton within w_change_coil
end type
type cb_reverse from commandbutton within w_change_coil
end type
end forward

global type w_change_coil from w_response
integer width = 1580
integer height = 2115
string title = "Select Coil from list"
boolean controlmenu = false
boolean center = true
boolean ib_isupdateable = false
cb_select cb_select
dw_coils dw_coils
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
st_14 st_14
st_15 st_15
st_job st_job
cb_change_job cb_change_job
cb_reverse cb_reverse
end type
global w_change_coil w_change_coil

type variables
long il_coil_abc_id_before
long il_coil_abc_id_now
long il_job_num
int ii_selected_status
string istr_selected_coil
long il_current_row
uo_shift iu_shift
w_change_job iw_change_job
w_super_validation iw_super_validation
w_reverse_coil iw_reverse_coil
end variables

on w_change_coil.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.dw_coils=create dw_coils
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_13=create st_13
this.st_14=create st_14
this.st_15=create st_15
this.st_job=create st_job
this.cb_change_job=create cb_change_job
this.cb_reverse=create cb_reverse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.dw_coils
this.Control[iCurrent+3]=this.st_10
this.Control[iCurrent+4]=this.st_11
this.Control[iCurrent+5]=this.st_12
this.Control[iCurrent+6]=this.st_13
this.Control[iCurrent+7]=this.st_14
this.Control[iCurrent+8]=this.st_15
this.Control[iCurrent+9]=this.st_job
this.Control[iCurrent+10]=this.cb_change_job
this.Control[iCurrent+11]=this.cb_reverse
end on

on w_change_coil.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.dw_coils)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.st_15)
destroy(this.st_job)
destroy(this.cb_change_job)
destroy(this.cb_reverse)
end on

event close;call super::close;if isValid(iw_change_job) then
	close(iw_change_job)
end if

if isValid(iw_reverse_coil ) then
	close(iw_reverse_coil )
end if

if isValid(iw_super_validation ) then
	close(iw_super_validation )
end if

end event

event open;call super::open;iu_shift = message.powerobjectparm
il_job_num = iu_shift.get_current_job( )
st_job.text = "JOB# " + string(il_job_num )

	sqlca.of_connect( )
	dw_coils.SetTransObject(sqlca)
	dw_coils.Retrieve(il_job_num )
	
	if isValid( iu_shift.iw_sheet.iu_current_coil ) then
   		il_coil_abc_id_before = iu_shift.iw_sheet.iu_current_coil.get_coil_abc_id( )
		else
			il_coil_abc_id_before = -1
	end if

	il_coil_abc_id_now = -1
end event

type cb_select from commandbutton within w_change_coil
integer x = 11
integer y = 1782
integer width = 1532
integer height = 173
integer taborder = 20
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change to"
boolean default = true
end type

event clicked;if parent.il_coil_abc_id_now < 100 then
	MessageBox("No valid coil selected", "Please select a valid coil from list!", STOPSIGN!)
	return 0
end if

if parent.ii_selected_status =0  then // coil was done by previous shift, user error
	MessageBox("Coil is done", "This Coil has been done, You need a supervisor password to reverse it!")
	return 0
end if

iu_shift.of_set_coil_id( il_coil_abc_id_now )
close(parent)	

end event

type dw_coils from datawindow within w_change_coil
integer x = 11
integer y = 186
integer width = 1079
integer height = 1558
integer taborder = 20
string title = "none"
string dataobject = "d_process_coil_for_panel"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	il_current_row = row
	istr_selected_coil = getitemstring( row, "coil_coil_org_num")
	cb_select.text = "Change to " + istr_selected_coil
	il_coil_abc_id_now = getitemnumber( row,"process_coil_coil_abc_num")
	ii_selected_status = getitemnumber( row,"process_coil_shift_process_status")
	if ii_selected_status = 0 then
		parent.cb_reverse.visible = true
	else
		parent.cb_reverse.visible = false
	end if
	
end if
end event

type st_10 from statictext within w_change_coil
integer x = 1137
integer y = 496
integer width = 190
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Waiting"
boolean focusrectangle = false
end type

type st_11 from statictext within w_change_coil
integer x = 1137
integer y = 582
integer width = 205
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65280
long backcolor = 67108864
string text = "Running"
boolean focusrectangle = false
end type

type st_12 from statictext within w_change_coil
integer x = 1137
integer y = 669
integer width = 190
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "Reject"
boolean focusrectangle = false
end type

type st_13 from statictext within w_change_coil
integer x = 1137
integer y = 755
integer width = 249
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Rebanded"
boolean focusrectangle = false
end type

type st_14 from statictext within w_change_coil
integer x = 1137
integer y = 842
integer width = 190
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 67108864
string text = "Onhold"
boolean focusrectangle = false
end type

type st_15 from statictext within w_change_coil
integer x = 1137
integer y = 950
integer width = 190
integer height = 54
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 67108864
string text = "Done"
boolean focusrectangle = false
end type

type st_job from statictext within w_change_coil
integer x = 40
integer y = 42
integer width = 764
integer height = 125
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Job#"
boolean focusrectangle = false
end type

type cb_change_job from commandbutton within w_change_coil
integer x = 867
integer y = 10
integer width = 647
integer height = 163
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change job"
end type

event clicked;long ll_job_num
ll_job_num = iu_shift.get_current_job( )
OpenWithParm(iw_change_job, iu_shift, iu_shift.iw_sheet )
if not isValid(this) then
	return 0
end if
if not isValid(iu_shift) then
	return 0
end if
il_job_num = iu_shift.get_current_job( )
if ll_job_num <> il_job_num then
	dw_coils.SetTransObject(sqlca)
	dw_coils.Retrieve( il_job_num )
	if isValid(iu_shift.iw_sheet.iu_current_coil ) then
   		il_coil_abc_id_before = iu_shift.iw_sheet.iu_current_coil.get_coil_abc_id( )
		else
			il_coil_abc_id_before = -1
		end if

		il_coil_abc_id_now = 0
		parent.st_job.text = "Job# " + string( il_job_num )
		
		if dw_coils.rowcount( ) > 1 then 
			dw_coils.selectrow( 1, false) 
		end if
		cb_select.text = "Change to"

end if
/*
w_downtime_line_job_info lw_w
lw_w = w_downtime2_frame.GetActiveSheet()
lw_w.open_w_change_job( )
	//if job changed retrieve new coil list
	if not lw_w.ib_in_setup_process then
		if not gb_on_shift then
			return 0
		end if
	end if
	if ll_job_num <> gl_job_num then
		dw_coils.SetTransObject(sqlca)
		dw_coils.Retrieve(gl_job_num)
		//gnv_connect.of_disconnectdb( )

		if not isNull(gnv_current_coil) then
   		il_coil_abc_id_before = gnv_current_coil.get_coil_abc_id( )
		else
			il_coil_abc_id_before = 0
		end if

		il_coil_abc_id_now = 0
		parent.st_job.text = "Job# " + string(gl_job_num)
		
		if dw_coils.rowcount( ) > 1 then 
			dw_coils.selectrow( 1, false) 
		end if
		cb_select.text = "Change to"
	
	end if
	
	*/
end event

type cb_reverse from commandbutton within w_change_coil
boolean visible = false
integer x = 1108
integer y = 1021
integer width = 432
integer height = 195
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reverse"
end type

event clicked;int li_valid
s_coil_status ls_new_status
Open(iw_super_validation )
if not isValid(this) then
	return 0
end if
if not isValid( iu_shift ) then
		return 0
end if
li_valid = Message.doubleparm
if li_valid = 1 then
	openwithparm(iw_reverse_coil, parent.istr_selected_coil, iu_shift.iw_sheet )
	if not isValid(this) then
		return 0
	end if
	if not isValid( iu_shift ) then
		return 0
	end if
	ls_new_status = Message.powerobjectparm
	parent.dw_coils.setitem( il_current_row, "process_coil_shift_process_status" ,ls_new_status.status )
	parent.dw_coils.setitem( il_current_row, "coil_net_wt_balance" ,ls_new_status.weight)
	
	  UPDATE "PROCESS_COIL"  
     	SET "SHIFT_PROCESS_STATUS" = :ls_new_status.status,   
         "CURRENT_WT" = :ls_new_status.weight  
   	WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :il_coil_abc_id_now ) AND  
         ( "PROCESS_COIL"."AB_JOB_NUM" = :il_job_num )   
           ;

	  UPDATE "SHIFT_COIL"  
     	SET "COIL_END_STATUS" = :ls_new_status.status,   
         "COIL_END_WT" = :ls_new_status.weight,   
         "PROCESS_WT" = "COIL_BEGIN_WT" - :ls_new_status.weight  
   	WHERE "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_id_now   
           ;
		COMMIT;

	
end if


/*
int li_valid
s_coil_status ls_new_status
w_downtime_line_job_info lw_w
lw_w = w_downtime2_frame.GetActiveSheet()
lw_w.open_w_super_validation( )
li_valid = Message.doubleparm
if not lw_w.ib_in_setup_process then
		if not gb_on_shift then
			return 0
		end if
end if
if li_valid = 1 then
	openwithparm(lw_w.iw_reverse_coil, parent.istr_selected_coil)
	ls_new_status = Message.powerobjectparm
	
	if not lw_w.ib_in_setup_process then
		if not gb_on_shift then
			return 0
		end if
	end if

	
	parent.dw_coils.setitem( il_current_row, "process_coil_shift_process_status" ,ls_new_status.status )
	parent.dw_coils.setitem( il_current_row, "coil_net_wt_balance" ,ls_new_status.weight)
	
	  UPDATE "PROCESS_COIL"  
     SET "SHIFT_PROCESS_STATUS" = :ls_new_status.status,   
         "CURRENT_WT" = :ls_new_status.weight  
   WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :il_coil_abc_id_now ) AND  
         ( "PROCESS_COIL"."AB_JOB_NUM" = :gl_job_num )   
           ;

	  UPDATE "SHIFT_COIL"  
     SET "COIL_END_STATUS" = :ls_new_status.status,   
         "COIL_END_WT" = :ls_new_status.weight,   
         "PROCESS_WT" = "COIL_BEGIN_WT" - :ls_new_status.weight  
   	WHERE "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_id_now   
           ;
		COMMIT;

	
end if
*/
end event

