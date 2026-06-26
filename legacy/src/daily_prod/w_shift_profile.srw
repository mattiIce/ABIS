$PBExportHeader$w_shift_profile.srw
forward
global type w_shift_profile from w_response
end type
type st_2 from statictext within w_shift_profile
end type
type st_1 from statictext within w_shift_profile
end type
type cb_cancel from commandbutton within w_shift_profile
end type
type cb_apply from commandbutton within w_shift_profile
end type
type dw_detail from u_dw within w_shift_profile
end type
type dw_description from u_dw within w_shift_profile
end type
end forward

global type w_shift_profile from w_response
integer x = 1218
integer y = 800
integer width = 2505
integer height = 1251
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_apply cb_apply
dw_detail dw_detail
dw_description dw_description
end type
global w_shift_profile w_shift_profile

type variables
Boolean ib_shift_1, ib_shift_2, ib_shift_3
date id_date_of_shifts
Long il_line
String is_line_desc
end variables

forward prototypes
public function integer of_check_shift_conflict ()
public function integer of_create_shift (long al_line_num, date ad_date_of_shifts, integer ai_shift_profile_id, integer ai_shift_type)
public function integer of_check_shift_time (datetime adt_date_time, long al_line_num)
end prototypes

public function integer of_check_shift_conflict ();//Check if selectd shift(s) exist already.
if ib_shift_1 then	//if 1st shift exists
	dw_detail.Object.selected_1st.Visible = False
end if

if ib_shift_2 then	//if 2nd shift exists
	dw_detail.Object.selected_2nd.Visible = False
end if

if ib_shift_3 then	//if 1st shift exists
	dw_detail.Object.selected_3rd.Visible = False
end if

return 1
end function

public function integer of_create_shift (long al_line_num, date ad_date_of_shifts, integer ai_shift_profile_id, integer ai_shift_type);Long li_shift_id, li_rc_start, li_rc_end
String ls_planned_starting_time, ls_planned_ending_time
datetime ldt_planned_starting_time, ldt_planned_ending_time

li_shift_id = f_get_next_value ("shift_num_seq")
choose case ai_shift_type
	case 1
		select starting_time_1st, ending_time_1st into :ls_planned_starting_time, :ls_planned_ending_time
		from shift_profile
		where id = :ai_shift_profile_id
		using SQLCA;
		
		ldt_planned_starting_time = DateTime(ad_date_of_shifts, Time(ls_planned_starting_time))
		ldt_planned_ending_time = DateTime(ad_date_of_shifts, Time(ls_planned_ending_time))
		
		if ldt_planned_starting_time > ldt_planned_ending_time then		//for shift's end at next day's morning			
			ldt_planned_ending_time = DateTime(RelativeDate(ad_date_of_shifts,1), Time(ls_planned_ending_time))
		end if
		
		li_rc_start = of_check_shift_time(ldt_planned_starting_time, il_line)
		li_rc_end = of_check_shift_time(ldt_planned_ending_time, il_line)
		
		if li_rc_start = -1 then
			MessageBox("Shift Starting Time Error", "Shift's starting time has conflict with another shift.")
			return 0
		end if
		
		if li_rc_end = -1 then
			MessageBox("Shift Ending Time Error", "Shift's ending time has conflict with another shift.")
			return 0
		end if
		
		if (li_rc_start = 1) and (li_rc_end = 1) then
			insert into shift (shift_num, line_num, schedule_type, planned_starting_time, planned_ending_time)
			values (:li_shift_id, :al_line_num, 1, :ldt_planned_starting_time, :ldt_planned_ending_time)
			using SQLCA;
			
			if SQLCA.SQLCode = -1 then
				MessageBox("SQLError", SQLCA.SqlErrText)
				rollback using SQLCA;
				return 0
			end if
		end if
		
	case 2
		select starting_time_2nd, ending_time_2nd into :ls_planned_starting_time, :ls_planned_ending_time
		from shift_profile
		where id = :ai_shift_profile_id
		using SQLCA;
		
		ldt_planned_starting_time = DateTime(ad_date_of_shifts, Time(ls_planned_starting_time))
		ldt_planned_ending_time = DateTime(ad_date_of_shifts, Time(ls_planned_ending_time))
		
		if ldt_planned_starting_time > ldt_planned_ending_time then		//for shift's end at next day's morning			
			ldt_planned_ending_time = DateTime(RelativeDate(ad_date_of_shifts,1), Time(ls_planned_ending_time))
		end if
		
		li_rc_start = of_check_shift_time(ldt_planned_starting_time, il_line)
		li_rc_end = of_check_shift_time(ldt_planned_ending_time, il_line)
		
		if li_rc_start = -1 then
			MessageBox("Shift Starting Time Error", "Shift's starting time has conflict with another shift.")
			return 0
		end if
		
		if li_rc_end = -1 then
			MessageBox("Shift Ending Time Error", "Shift's ending time has conflict with another shift.")
			return 0
		end if
		
		if (li_rc_start = 1) and (li_rc_end = 1) then
		
			insert into shift (shift_num, line_num, schedule_type, planned_starting_time, planned_ending_time)
			values (:li_shift_id, :al_line_num, 2, :ldt_planned_starting_time, :ldt_planned_ending_time)
			using SQLCA;
			if SQLCA.SQLCode = -1 then
				MessageBox("SQLError", SQLCA.SqlErrText)
				rollback using SQLCA;
				return 0
			end if
		end if
		
	case 3
		select starting_time_3rd, ending_time_3rd into :ls_planned_starting_time, :ls_planned_ending_time
		from shift_profile
		where id = :ai_shift_profile_id
		using SQLCA;
		
		ldt_planned_starting_time = DateTime(ad_date_of_shifts, Time(ls_planned_starting_time))
		ldt_planned_ending_time = DateTime(ad_date_of_shifts, Time(ls_planned_ending_time))
		
		if ldt_planned_starting_time > ldt_planned_ending_time then		//for shift's end at next day's morning			
			ldt_planned_ending_time = DateTime(RelativeDate(ad_date_of_shifts,1), Time(ls_planned_ending_time))
		end if
		
		li_rc_start = of_check_shift_time(ldt_planned_starting_time, il_line)
		li_rc_end = of_check_shift_time(ldt_planned_ending_time, il_line)
		
		if li_rc_start = -1 then
			MessageBox("Shift Starting Time Error", "Shift's starting time has conflict with another shift.")
			return 0
		end if
		
		if li_rc_end = -1 then
			MessageBox("Shift Ending Time Error", "Shift's ending time has conflict with another shift.")
			return 0
		end if
		
		if (li_rc_start = 1) and (li_rc_end = 1) then
		
			insert into shift (shift_num, line_num, schedule_type, planned_starting_time, planned_ending_time)
			values (:li_shift_id, :al_line_num, 3, :ldt_planned_starting_time, :ldt_planned_ending_time)
			using SQLCA;
			
			if SQLCA.SQLCode = -1 then
				MessageBox("SQLError", SQLCA.SqlErrText)
				rollback using SQLCA;
				return 0
			end if
		end if
end choose

commit using SQLCA;
return 1




return 1
end function

public function integer of_check_shift_time (datetime adt_date_time, long al_line_num);Int li_return

transaction dboconnect
dboconnect = create transaction
dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
dboconnect.LogID = gs_LogID
dboconnect.LogPass = gs_LogPass
connect using dboconnect;
if dboconnect.SQLCode<0 then 
	MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
	disconnect using dboconnect;
	destroy dboconnect;
	return -100
end if

DECLARE p_check_shift_time procedure for F_CHECK_SHIFT_TIME_CONFLICT (:adt_date_time, :al_line_num, 0) using dboconnect;
execute p_check_shift_time;
if dboconnect.SQLCode < 0 then 
	MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
	disconnect using dboconnect;
	destroy dboconnect;
	return -200
end if
fetch p_check_shift_time INTO :li_return; 
close p_check_shift_time;
	
disconnect using dboconnect;
destroy dboconnect;

return li_return
end function

on w_shift_profile.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_apply=create cb_apply
this.dw_detail=create dw_detail
this.dw_description=create dw_description
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_apply
this.Control[iCurrent+5]=this.dw_detail
this.Control[iCurrent+6]=this.dw_description
end on

on w_shift_profile.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_apply)
destroy(this.dw_detail)
destroy(this.dw_description)
end on

event open;call super::open;s_line_date_shifts  lst_line_date_shifts_for_passing

lst_line_date_shifts_for_passing = Message.PowerObjectParm
il_line = lst_line_date_shifts_for_passing.line_num
id_date_of_shifts = lst_line_date_shifts_for_passing.date_of_shifts
ib_shift_1 = lst_line_date_shifts_for_passing.shift_1
ib_shift_2 = lst_line_date_shifts_for_passing.shift_2
ib_shift_3 = lst_line_date_shifts_for_passing.shift_3

select line_desc into :is_line_desc
from line
where line_num = :il_line
using SQLCA;

dw_description.SetTransObject(SQLCA)
dw_description.Retrieve()
dw_detail.SetTransObject(SQLCA)

dw_description.of_SetLinkage(TRUE)
dw_description.inv_linkage.of_SetConfirmOnRowChange (True)
dw_description.inv_linkage.of_setUpdateOnRowChange (TRUE)

dw_detail.of_SetLinkage( TRUE ) 
dw_detail.inv_Linkage.of_SetMaster(dw_description)
IF NOT dw_detail.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link description & detail in win w_shift_profile" )
ELSE
	dw_detail.inv_Linkage.of_Register( "id", "id" ) 
	dw_detail.inv_Linkage.of_SetStyle( dw_description.inv_linkage.RETRIEVE ) 
END IF

dw_description.selectRow(1, True)
dw_detail.Retrieve(1)
of_check_shift_conflict()

return 1

end event

type st_2 from statictext within w_shift_profile
integer x = 1039
integer y = 42
integer width = 344
integer height = 58
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shift Detail:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_shift_profile
integer x = 59
integer y = 42
integer width = 234
integer height = 58
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shift:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_shift_profile
integer x = 1536
integer y = 995
integer width = 344
integer height = 99
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_apply from commandbutton within w_shift_profile
integer x = 644
integer y = 995
integer width = 344
integer height = 99
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Apply"
end type

event clicked;Int li_row, li_id, li_return, li_selected_1, li_selected_2, li_selected_3, li_shift_profile_id
String ls_desc
Long ll_shift_num


dw_detail.AcceptText()
dw_description.AcceptText()

li_row = dw_description.GetRow()
if li_row <= 0  then
	MessageBox("Info", "Please select shift type in description window.")
end if

li_shift_profile_id = dw_description.GetItemNumber(li_row, "id", Primary!, FALSE)

li_row = dw_detail.GetRow()
li_selected_1 = dw_detail.GetItemNumber(li_row, "selected_1st", Primary!, FALSE)
li_selected_2 = dw_detail.GetItemNumber(li_row, "selected_2nd", Primary!, FALSE)
li_selected_3 = dw_detail.GetItemNumber(li_row, "selected_3rd", Primary!, FALSE)

if (li_selected_1=1) or (li_selected_2=1) or (li_selected_3=1) then
	
	li_return = MessageBox("Confirmation", "Do you want to apply the slected shift(s) on " + String(id_date_of_shifts) &
	+ " to " + is_line_desc + "?", Question!, YesNo!)
	if li_return = 1 then
		//create 1st shift
		if (li_selected_1=1) then //created 1st shift
			li_return = of_create_shift(il_line, id_date_of_shifts, li_shift_profile_id, 1)
				if li_return <> 1 then
					MessageBox("Error", "Could not create 1st shift.")
					return 0
				end if
		end if
		//create 2nd shift
		if (li_selected_2=1) then //created 2nd shift
			li_return = of_create_shift(il_line, id_date_of_shifts, li_shift_profile_id, 2)
				if li_return <> 1 then
					MessageBox("Error", "Could not create 2nd shift.")
					return 0
				end if
		end if
		//create 3rd shift
		if (li_selected_3=1) then //created 1st shift
			li_return = of_create_shift(il_line, id_date_of_shifts, li_shift_profile_id, 3)
				if li_return <> 1 then
					MessageBox("Error", "Could not create 3rd shift.")
					return 0
				end if
		end if
	else
		return 0
	end if
	MessageBox("Info", "Shift(s) have already been added")
	dw_detail.ResetUpdate()
	closewithreturn(parent,1)
else
	MessageBox("Info", "No shift has been selected")
	return 0
end if




end event

type dw_detail from u_dw within w_shift_profile
integer x = 1031
integer y = 163
integer width = 1415
integer height = 707
integer taborder = 20
string dataobject = "d_shift_profile_detail"
boolean vscrollbar = false
end type

type dw_description from u_dw within w_shift_profile
integer x = 51
integer y = 163
integer width = 911
integer height = 701
integer taborder = 10
string dataobject = "d_shift_profile"
end type

event clicked;call super::clicked;//Override pfc_clicked

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF

end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 )


end event

event rbuttondown;call super::rbuttondown;//disable
Return 0
end event

event rbuttonup;call super::rbuttonup;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
of_check_shift_conflict()


end event

