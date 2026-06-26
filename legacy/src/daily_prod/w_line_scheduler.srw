$PBExportHeader$w_line_scheduler.srw
forward
global type w_line_scheduler from w_sheet
end type
type cb_report from u_cb within w_line_scheduler
end type
type cb_cancel from u_cb within w_line_scheduler
end type
type cb_shift_remove from u_cb within w_line_scheduler
end type
type cb_shift_editor_save from u_cb within w_line_scheduler
end type
type cb_shift_editor_modify from u_cb within w_line_scheduler
end type
type cb_shift_add from u_cb within w_line_scheduler
end type
type st_5 from statictext within w_line_scheduler
end type
type st_1 from statictext within w_line_scheduler
end type
type em_calendar from u_em within w_line_scheduler
end type
type dw_line from u_dw within w_line_scheduler
end type
type st_2 from statictext within w_line_scheduler
end type
type st_10 from statictext within w_line_scheduler
end type
type cb_close from u_cb within w_line_scheduler
end type
type dw_shift from u_dw within w_line_scheduler
end type
type uo_calendar_1 from u_calendar within w_line_scheduler
end type
type tv_shift_coil_job from treeview within w_line_scheduler
end type
type gb_3 from groupbox within w_line_scheduler
end type
type gb_1 from groupbox within w_line_scheduler
end type
end forward

global type w_line_scheduler from w_sheet
integer x = 113
integer y = 128
integer width = 2929
integer height = 2080
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean clientedge = true
event type integer ue_date_changed ( )
event type string ue_whoami ( )
event type integer ue_shift_add ( )
event type integer ue_shift_remove ( )
cb_report cb_report
cb_cancel cb_cancel
cb_shift_remove cb_shift_remove
cb_shift_editor_save cb_shift_editor_save
cb_shift_editor_modify cb_shift_editor_modify
cb_shift_add cb_shift_add
st_5 st_5
st_1 st_1
em_calendar em_calendar
dw_line dw_line
st_2 st_2
st_10 st_10
cb_close cb_close
dw_shift dw_shift
uo_calendar_1 uo_calendar_1
tv_shift_coil_job tv_shift_coil_job
gb_3 gb_3
gb_1 gb_1
end type
global w_line_scheduler w_line_scheduler

type variables
String is_date
Long il_line, il_shift_num
Long il_current_treeviewitem_handle, il_parent_treeviewitem_handle
datastore ids_line, ids_shift
end variables

forward prototypes
public function integer of_check_date ()
public function integer of_check_shift_started ()
public function integer of_check_shift_ended ()
end prototypes

event type integer ue_date_changed();Integer li_rc, li_i, li_shiftcount, li_line
DateTime ldt_s, ldt_e

//construct new tree
is_date = em_calendar.Text
st_1.Text = is_date

tv_shift_coil_job.deleteitem(0)
tv_shift_coil_job.Event constructor()

dw_shift.AcceptText()
if (dw_shift.of_updatespending() = 1) then
	li_rc = MessageBox("Warning","Do you want to save the modified shift information first?", Question!, YesNo!)
	if li_rc =  1 then
		cb_shift_editor_save.event clicked()
	end if
end if

dw_shift.Reset()

RETURN 1


end event

event type string ue_whoami();Return "w_line_scheduler"
end event

event type integer ue_shift_add();if of_check_date() = 0 then
	MessageBox("Add Shift Failed", "Can not add shift into past date.")
	return 0
end if

Treeviewitem tvi_current, tvi_add, tvi_add_child
Long ll_current, ll_parent, ll_row, ll_row_child
int i, li_ub, li_return, li_rc, li_selected
s_line_date_shifts  lst_line_date_shifts_for_passing
String ls_starting_time, ls_ending_time

//initiate lst_line_date_shifts_for_passing
lst_line_date_shifts_for_passing.line_num = il_line
lst_line_date_shifts_for_passing.date_of_shifts = date(is_date)
lst_line_date_shifts_for_passing.shift_1 = false
lst_line_date_shifts_for_passing.shift_2 = false
lst_line_date_shifts_for_passing.shift_3 = false

ll_current = tv_shift_coil_job.FindItem(CurrentTreeItem!, 0)
tv_shift_coil_job.GetItem(ll_current, tvi_current)

IF tvi_current.Level = 1 THEN		// Add Shift into Line (Level 1)
	li_rc = ids_shift.RowCount()
	if li_rc >0 then
		for i=1 to li_rc
			choose case ids_shift.GetItemnumber(i, "schedule_type")
				case 1
					lst_line_date_shifts_for_passing.shift_1 = true	//1st shift exists
				case 2
					lst_line_date_shifts_for_passing.shift_2 = true	//2nd shift exists
				case 3
					lst_line_date_shifts_for_passing.shift_3 = true	//3rd shift exists
			end choose
		next
	end if
	OpenwithParm(w_shift_profile, lst_line_date_shifts_for_passing)
ELSE
	MessageBox("Info", "Please choose a BL line to add shift(s).", Information!, OK!)
	Return 0
END IF

//refresh this shift treeitems
Long ll_rowcount, ll_rowcount_child, ll_child

do until ll_child = -1 	//delete childtreeitem until there is none found.
	ll_child = tv_shift_coil_job.finditem(Childtreeitem!, ll_current)
	tv_shift_coil_job.deleteitem(ll_child)
loop

ll_rowcount = ids_shift.Retrieve(is_date,tvi_current.Data)
	FOR ll_row = 1 to ll_rowcount
		tvi_add.Label = ids_shift.GetItemString(ll_row, 'display')
		tvi_add.Data = ids_shift.GetItemNumber(ll_row, 'shift_num')
		tvi_add.PictureIndex = 3
		tvi_add.SelectedPictureIndex = 3
		tvi_add.Children = FALSE
		ll_child = tv_shift_coil_job.InsertItemSort(ll_current,tvi_add)
		
	NEXT
	tv_shift_coil_job.expanditem(ll_current)
return 1
end event

event type integer ue_shift_remove();if of_check_date() = 0 then
	MessageBox("Remove Shift Failed", "Can not remove shift from past date.")
	return 0
end if

Long li_rowcount, li_rc
Treeviewitem tvi_current
Long ll_current
datetime ldt_actual_starting_time, ldt_actual_ending_time

ll_current = tv_shift_coil_job.FindItem(CurrentTreeItem!, 0)
tv_shift_coil_job.GetItem(ll_current, tvi_current)

IF tvi_current.Level <> 2 THEN		// Remove shift from the BL line
	MessageBox("Error", "Please choose a shift to remove from the BL line.", Information!, OK!)
	Return 0
END IF

li_rc = MessageBox("Confirmation", "Do you want to remove this shift?", Question!, YesNo!)
if li_rc = 2 then
	return 0
end if

//check if shift has started yet
select start_time, end_time into :ldt_actual_starting_time, :ldt_actual_ending_time
from shift
where shift_num = :il_shift_num
using SQLCA;

if NOT isnull(ldt_actual_starting_time) then		
		MessageBox("Fail to Remove Shift", "Can not remove since shift has started.")
		Return -1
end if


////Shift can not be removed if there is coil/job assigned to it
//select count(*) into :li_rowcount
//from shift_coil_job
//where shift_num = :il_shift_num
//using SQLCA;
//
//if SQLCA.SQLCode = -1 then
//	MessageBox("SQLError in Selecting", SQLCA.SQLErrText)
//	return -1
//end if
//
//if li_rowcount >0 then
//	Messagebox("Shift Removing Fail", "Please remove all the Coil/Job(s) assigned to this shift first.")
//	return 0
//end if

delete from shift
where shift_num = :il_shift_num
using SQLCA;

if SQLCA.SQLCode = -1 then
	MessageBox("SQLError in Deleting", SQLCA.SQLErrText)
	return -1
end if

commit;

if SQLCA.SQLCode = -1 then
	MessageBox("SQLError in Committing", SQLCA.SQLErrText)
	return -1
else
	tv_shift_coil_job.DeleteItem(ll_current)
	MessageBox("Shift Removing", "The shift has been successfully remove")
end if

return 1
end event

public function integer of_check_date ();if Today() > Date(is_date) then
	return 0
end if

return 1
end function

public function integer of_check_shift_started ();//return
//1: shift started
//0: shift did not start

datetime ldt_actual_starting_time

select start_time into :ldt_actual_starting_time
from shift
where shift_num = :il_shift_num
using SQLCA;

if isnull(ldt_actual_starting_time) then
	Return 0
end if

return 1
end function

public function integer of_check_shift_ended ();//return
//1: shift ended
//0: shift did not end

datetime ldt_actual_ending_time

select end_time into :ldt_actual_ending_time
from shift
where shift_num = :il_shift_num
using SQLCA;

if isnull(ldt_actual_ending_time) then
	Return 0
end if

return 1
end function

on w_line_scheduler.create
int iCurrent
call super::create
this.cb_report=create cb_report
this.cb_cancel=create cb_cancel
this.cb_shift_remove=create cb_shift_remove
this.cb_shift_editor_save=create cb_shift_editor_save
this.cb_shift_editor_modify=create cb_shift_editor_modify
this.cb_shift_add=create cb_shift_add
this.st_5=create st_5
this.st_1=create st_1
this.em_calendar=create em_calendar
this.dw_line=create dw_line
this.st_2=create st_2
this.st_10=create st_10
this.cb_close=create cb_close
this.dw_shift=create dw_shift
this.uo_calendar_1=create uo_calendar_1
this.tv_shift_coil_job=create tv_shift_coil_job
this.gb_3=create gb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_report
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_shift_remove
this.Control[iCurrent+4]=this.cb_shift_editor_save
this.Control[iCurrent+5]=this.cb_shift_editor_modify
this.Control[iCurrent+6]=this.cb_shift_add
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_calendar
this.Control[iCurrent+10]=this.dw_line
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_10
this.Control[iCurrent+13]=this.cb_close
this.Control[iCurrent+14]=this.dw_shift
this.Control[iCurrent+15]=this.uo_calendar_1
this.Control[iCurrent+16]=this.tv_shift_coil_job
this.Control[iCurrent+17]=this.gb_3
this.Control[iCurrent+18]=this.gb_1
end on

on w_line_scheduler.destroy
call super::destroy
destroy(this.cb_report)
destroy(this.cb_cancel)
destroy(this.cb_shift_remove)
destroy(this.cb_shift_editor_save)
destroy(this.cb_shift_editor_modify)
destroy(this.cb_shift_add)
destroy(this.st_5)
destroy(this.st_1)
destroy(this.em_calendar)
destroy(this.dw_line)
destroy(this.st_2)
destroy(this.st_10)
destroy(this.cb_close)
destroy(this.dw_shift)
destroy(this.uo_calendar_1)
destroy(this.tv_shift_coil_job)
destroy(this.gb_3)
destroy(this.gb_1)
end on

event open;call super::open;Long ll_row, ll_c
String ls_sql
date ld_today

dw_shift.SetTransObject(sqlca)

//set today's date
ld_today = Today()
em_calendar.Text =  String(ld_today, "mm/dd/yyyy")
is_date = em_calendar.Text
st_1.Text = is_date
end event

event close;call super::close;Long li_rc

DESTROY ids_line
DESTROY ids_shift

f_display_app()
end event

type cb_report from u_cb within w_line_scheduler
integer x = 2355
integer y = 1107
integer width = 362
integer height = 109
integer taborder = 180
string text = "Shift &Report"
end type

event clicked;call super::clicked;s_new_daily_prod_info lstr_q


OpenwithParm(w_daily_prod_schedule_reports, lstr_q)

RETURN 1

end event

type cb_cancel from u_cb within w_line_scheduler
integer x = 1690
integer y = 1581
integer width = 362
integer height = 109
integer taborder = 80
string text = "&Cancel"
end type

event clicked;call super::clicked;dw_shift.Reset()
dw_shift.Retrieve(il_shift_num)

dw_shift.enabled = False
dw_shift.Object.planned_starting_time.border = 0
dw_shift.Object.planned_ending_time.border = 0
dw_shift.Object.note.border = 0

//cb_shift_editor_save.Enabled = false
end event

type cb_shift_remove from u_cb within w_line_scheduler
integer x = 1690
integer y = 880
integer width = 362
integer height = 109
integer taborder = 70
string text = "Re&move Shift"
end type

event clicked;call super::clicked;parent.Event ue_shift_remove()
end event

type cb_shift_editor_save from u_cb within w_line_scheduler
integer x = 1690
integer y = 1725
integer width = 362
integer height = 109
integer taborder = 160
string text = "&Save"
end type

event clicked;call super::clicked;dw_shift.AcceptText()
if (	dw_shift.GetItemStatus(1, "planned_starting_time",Primary!) = NotModified!	 and	&
		dw_shift.GetItemStatus(1, "planned_ending_time",Primary!) = NotModified!	 and 	&
		dw_shift.GetItemStatus(1, "note",Primary!) = NotModified!		)	then
	MessageBox("Info", "Please modify shift information then save.")
	return 0
end if


datetime ldt_actual_starting_time, ldt_actual_ending_time, ldt_modified_starting_time, ldt_modified_ending_time
Long ll_row, ll_shift_num, li_return

ll_row = dw_shift.GetRow()
ll_shift_num = dw_shift.GetItemNumber(ll_row, "shift_num")
ldt_modified_starting_time = dw_shift.GetItemDateTime(ll_row, "planned_starting_time")
ldt_modified_ending_time = dw_shift.GetItemDateTime(ll_row, "planned_ending_time")

//select start_time, end_time into :ldt_actual_starting_time, :ldt_actual_ending_time
//from shift
//where shift_num = :ll_shift_num
//using SQLCA;


if (dw_shift.GetItemStatus(ll_row,  "planned_starting_time", Primary!) = DataModified!) then
	if (of_check_shift_started() = 1) then		//check if the shift has started
		MessageBox("Fail to Reschedule", "Can not reschedule starting time since shift has started.")
		Return 0
	end if
end if

if (dw_shift.GetItemStatus(ll_row,  "planned_ending_time", Primary!) = DataModified!) then
	if (of_check_shift_ended() = 1) then		//check if the shift has ended
		MessageBox("Fail to Reschedule", "Can not reschedule ending time since shift has ended.")
		Return 0
	end if
end if

//check if the new time conflicts with other shifts
transaction dboconnect
dboconnect = create transaction
dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
dboconnect.LogID = gs_LogID
dboconnect.LogPass = gs_LogPass
connect using dboconnect;
if dboconnect.SQLCode<0 then 
	MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
	return -100
end if

//check starting time
DECLARE p_check_shift_starting_time procedure for F_CHECK_SHIFT_TIME_CONFLICT (:ldt_modified_starting_time, :il_line, :il_shift_num) using dboconnect;
execute p_check_shift_starting_time;
if dboconnect.SQLCode < 0 then 
	MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
	disconnect using dboconnect;
	destroy dboconnect;
	return -200
end if
fetch p_check_shift_starting_time INTO :li_return; 
if li_return <> 1 then
		MessageBox("Fail to Reschedule","Can not reschedule starting time since it conflicts with another shift.")
		disconnect using dboconnect;
		destroy dboconnect;
		return 0
end if
close p_check_shift_starting_time;
//check ending time
DECLARE p_check_shift_ending_time procedure for F_CHECK_SHIFT_TIME_CONFLICT (:ldt_modified_ending_time, :il_line, :il_shift_num) using dboconnect;
execute p_check_shift_ending_time;
if dboconnect.SQLCode < 0 then 
	MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
	disconnect using dboconnect;
	destroy dboconnect;
	return -200
end if
fetch p_check_shift_ending_time INTO :li_return; 
if li_return <> 1 then
		MessageBox("Fail to Reschedule","Can not reschedule ending time since it conflicts with another shift.")
		disconnect using dboconnect;
		destroy dboconnect;
		return 0
end if	
close p_check_shift_ending_time;
	
disconnect using dboconnect;
destroy dboconnect;

//update 
Int li_rc

li_rc = dw_shift.update()
IF li_rc = 1 THEN
    COMMIT USING SQLCA;
	 MessageBox("Info", "Shift time has been successfully updated.")
ELSE
    ROLLBACK USING SQLCA;
	 MessageBox("Info", "There was problem tring to update shift time please try again.")
END IF

dw_shift.enabled = False
dw_shift.Object.planned_starting_time.border = 0
dw_shift.Object.planned_ending_time.border = 0
dw_shift.Object.note.border = 0

tv_shift_coil_job.deleteitem(0)
tv_shift_coil_job.Event constructor()
end event

type cb_shift_editor_modify from u_cb within w_line_scheduler
integer x = 1690
integer y = 1437
integer width = 362
integer height = 109
integer taborder = 80
string text = "&Modify"
end type

event clicked;call super::clicked;if of_check_date() = 0 then
	MessageBox("Modify Shift Failed", "Can not modify shift of past date.")
	return 0
end if

dw_shift.enabled = true
dw_shift.Object.planned_starting_time.border = 5
dw_shift.Object.planned_ending_time.border = 5
dw_shift.Object.note.border = 5


end event

type cb_shift_add from u_cb within w_line_scheduler
integer x = 1690
integer y = 464
integer width = 362
integer height = 109
integer taborder = 50
string text = "A&dd Shift"
end type

event clicked;call super::clicked;parent.event ue_shift_add()
end event

type st_5 from statictext within w_line_scheduler
integer x = 2172
integer y = 45
integer width = 380
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calendar:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_line_scheduler
integer x = 333
integer y = 45
integer width = 443
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
boolean focusrectangle = false
end type

type em_calendar from u_em within w_line_scheduler
boolean visible = false
integer x = 2534
integer y = 835
integer width = 380
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;//this.of_SetDropDownCalendar(TRUE)
//this.iuo_calendar.of_SetAlwaysRedraw(TRUE)
//this.iuo_calendar.of_SetinitialValue(TRUE)
//
//this.iuo_calendar.of_SetSaturdayBold(TRUE)
//this.iuo_calendar.of_SetSaturdayColor(RGB(0, 255, 0)) 
//this.iuo_calendar.of_SetSundayBold(TRUE) 
//this.iuo_calendar.of_SetSundayColor(RGB(0, 255, 0))
//
//
//this.iuo_calendar.of_SetCloseonClick(TRUE)

uo_calendar_1.of_SetRequestor(this)
end event

event modified;RETURN Parent.Event ue_date_changed()
end event

event other;IF em_calendar.Text <>  is_date Then 
	RETURN Parent.Event ue_date_changed()
ELSE
	RETURN 0
END IF
end event

type dw_line from u_dw within w_line_scheduler
boolean visible = false
integer x = 841
integer y = 208
integer width = 102
integer height = 58
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_line"
end type

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)
Retrieve()

end event

type st_2 from statictext within w_line_scheduler
integer x = 88
integer y = 45
integer width = 234
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shifts of"
boolean focusrectangle = false
end type

type st_10 from statictext within w_line_scheduler
boolean visible = false
integer x = 77
integer y = 26
integer width = 622
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Production Line:"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_line_scheduler
integer x = 2355
integer y = 1581
integer width = 362
integer height = 109
integer taborder = 170
string text = "&Close"
end type

event clicked;call super::clicked;close(parent)
end event

type dw_shift from u_dw within w_line_scheduler
integer x = 124
integer y = 1408
integer width = 1518
integer height = 442
integer taborder = 40
boolean enabled = false
string dataobject = "d_shift_info"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;cb_shift_editor_save.Enabled = true
end event

type uo_calendar_1 from u_calendar within w_line_scheduler
integer x = 2161
integer y = 125
integer height = 650
integer taborder = 60
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type tv_shift_coil_job from treeview within w_line_scheduler
integer x = 124
integer y = 144
integer width = 1518
integer height = 1117
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer indent = 1
boolean disabledragdrop = false
boolean hideselection = false
boolean tooltips = false
boolean trackselect = true
boolean fullrowselect = true
string picturename[] = {"UnionReturn!","Cascade!","Custom015!","SelectTable!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event constructor;treeviewitem tvi, tvi1, tvi2
long ll_rowcount, ll_rowcount_1, ll_rowcount_2
long ll_row, ll_row_1, ll_row_2
Long handle_1, handle_2, ll_current

//Create instance variable datastore
ids_shift = CREATE datastore
ids_shift.DataObject = "d_shift_line_date"
ids_shift.SetTransObject(SQLCA)

ids_line = CREATE datastore
ids_line.DataObject = "d_line"
ids_line.SetTransObject(SQLCA)
ll_rowcount = ids_line.Retrieve()

//Create the first level of the TreeView
tvi.PictureIndex = 1
tvi.SelectedPictureIndex = 2
tvi.Children = TRUE
//Populate the TreeView with data retrieved from the datastore
FOR ll_row = 1 to ll_rowcount
tvi.Label = ids_line.GetItemString(ll_row, 'line_desc')
tvi.Data = ids_line.GetItemNumber(ll_row, 'line_num')
handle_1 = This.InsertItemLast(0, tvi)
ll_rowcount_1 = ids_shift.Retrieve(is_date,tvi.Data)

	FOR ll_row_1 = 1 to ll_rowcount_1	//Populate shife level
		tvi1.Label = ids_shift.GetItemString(ll_row_1, 'display')
		tvi1.Data = ids_shift.GetItemNumber(ll_row_1, 'shift_num')
		tvi1.PictureIndex = 3
		tvi1.SelectedPictureIndex = 3
		tvi1.Children = FALSE
		handle_2 = This.InsertItemSort(handle_1,tvi1)
	NEXT
this.expanditem(handle_1)
NEXT


end event

event itempopulate;//TreeViewItem tvi_current
//long ll_row, ll_rowcount
//s_coil_job ls_coil_job_current
//
//This.GetItem(handle, tvi_current)
//
//IF tvi_current.Level = 1 THEN		// Populate level 2
//	ll_rowcount = ids_shift.Retrieve(is_date,tvi_current.Data)
//
//	this.SelectItem(handle)
//	
//END IF
//
//
end event

event selectionchanged;TreeViewItem tvi_current, tvi_parent, tvi_grandparent
long ll_row, ll_rowcount, ll_current, ll_parent, ll_grandparent
Int li_rc

dw_shift.AcceptText()
if (dw_shift.of_updatespending() = 1) then
	li_rc = MessageBox("Warning","Do you want to save the modified shift information first?", Question!, YesNo!)
	if li_rc =  1 then
		cb_shift_editor_save.event clicked()
	end if
end if

This.GetItem(newhandle, tvi_current)

IF tvi_current.Level = 1 THEN		// Line (Level 1)
	il_line = tvi_current.Data
	dw_shift.Reset()
	ids_shift.Retrieve(is_date,tvi_current.Data)
ELSEIF tvi_current.Level = 2 THEN		// Shift (Level 2)
	il_shift_num = tvi_current.Data	
	dw_shift.Retrieve(il_shift_num)
	ll_parent = this.FindItem(ParentTreeItem!, newhandle)
	This.GetItem(ll_parent, tvi_parent)
	il_line = tvi_parent.Data	
END IF

this.selectitem(newhandle)
dw_shift.enabled = False
dw_shift.Object.planned_starting_time.border = 0
dw_shift.Object.planned_ending_time.border = 0
dw_shift.Object.note.border = 0
end event

event clicked;selectitem(this.FindItem(CurrentTreeItem!, 0))

end event

event destructor;destroy ids_line
destroy ids_shift

end event

type gb_3 from groupbox within w_line_scheduler
integer x = 80
integer y = 1322
integer width = 2011
integer height = 640
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shift Editor"
end type

type gb_1 from groupbox within w_line_scheduler
integer x = 88
integer y = 96
integer width = 2011
integer height = 1200
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_3 from statictext within w_line_scheduler
integer x = 937
integer y = 600
integer width = 517
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shift Job / Coil List"
boolean focusrectangle = false
end type

type dw_shift_job_coil_detail from u_dw within w_line_scheduler
integer x = 933
integer y = 692
integer width = 2185
integer height = 880
integer taborder = 180
string dataobject = "d_shift_job_coil_detail"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
end event

type cb_save from u_cb within w_line_scheduler
integer x = 2441
integer y = 1616
integer width = 297
integer height = 108
integer taborder = 140
string text = "&Save"
end type

type cb_remove from u_cb within w_line_scheduler
integer x = 1897
integer y = 1616
integer width = 297
integer height = 108
integer taborder = 100
string text = "&Remove"
end type

type cb_add from u_cb within w_line_scheduler
integer x = 1353
integer y = 1616
integer width = 297
integer height = 108
integer taborder = 130
string text = "&Add"
end type

