$PBExportHeader$w_group_managment.srw
$PBExportComments$<Sheet> User group managment window inherited from pfemain/w_sheet
forward
global type w_group_managment from w_sheet
end type
type dw_list from u_dw within w_group_managment
end type
type cb_close from u_cb within w_group_managment
end type
type cb_save from u_cb within w_group_managment
end type
type cb_add from u_cb within w_group_managment
end type
type lb_isnot from u_lb within w_group_managment
end type
type st_1 from statictext within w_group_managment
end type
type st_2 from statictext within w_group_managment
end type
type cb_addright from u_cb within w_group_managment
end type
type cb_remove from u_cb within w_group_managment
end type
type dw_is from u_dw within w_group_managment
end type
type cb_delete from u_cb within w_group_managment
end type
end forward

global type w_group_managment from w_sheet
int X=4
int Y=6
int Width=2117
int Height=1587
boolean TitleBar=true
string Title="User Group Managment"
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
dw_list dw_list
cb_close cb_close
cb_save cb_save
cb_add cb_add
lb_isnot lb_isnot
st_1 st_1
st_2 st_2
cb_addright cb_addright
cb_remove cb_remove
dw_is dw_is
cb_delete cb_delete
end type
global w_group_managment w_group_managment

type variables
DataStore ids_apps
end variables

forward prototypes
public subroutine wf_display_rights ()
end prototypes

event ue_whoami;RETURN "w_group_managment"
end event

public subroutine wf_display_rights ();Long ll_row, ll_groupid, ll_newrow
Long ll_r1, ll_i, ll_r2, ll_j, ll_app
Int li_flag, li_pri
String ls_name, ls_format

ll_row = dw_list.GetRow()
IF ll_row < 1 THEN RETURN

lb_isnot.Reset()

ll_groupid = dw_list.getItemNumber(ll_row, "user_group_id", Primary!, FALSE)
ls_format = " security_group_application_user_group_id = " + String(ll_groupid)
dw_is.SetFilter(ls_format)
dw_is.Filter()

ll_r1 = dw_is.RowCount()
ll_r2 = ids_apps.RowCount()
FOR ll_i = 1 TO ll_r2
	ll_app = ids_apps.GetItemNumber(ll_i, "application_id", Primary!, FALSE)
	ls_name = ids_apps.GetItemString(ll_i, "application_name", Primary!, FALSE)
	li_flag = 0
	FOR ll_j = 1 TO ll_r1
		IF (dw_is.GetItemNumber(ll_j, "security_group_application_user_group_id", Primary!, FALSE) = ll_groupid) AND (dw_is.GetItemNumber(ll_j, "security_group_application_application_i", Primary!, FALSE) = ll_app) THEN
			li_flag = 1
		END IF
	NEXT
	IF li_flag = 0 THEN lb_isnot.AddItem(ls_name)
NEXT

end subroutine

on w_group_managment.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_add=create cb_add
this.lb_isnot=create lb_isnot
this.st_1=create st_1
this.st_2=create st_2
this.cb_addright=create cb_addright
this.cb_remove=create cb_remove
this.dw_is=create dw_is
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.lb_isnot
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_addright
this.Control[iCurrent+9]=this.cb_remove
this.Control[iCurrent+10]=this.dw_is
this.Control[iCurrent+11]=this.cb_delete
end on

on w_group_managment.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.lb_isnot)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_addright)
destroy(this.cb_remove)
destroy(this.dw_is)
destroy(this.cb_delete)
end on

event open;call super::open;s_security_data  lds_sec

IF f_security_door("User Group Control") < 0 THEN
	//OpenWithParm(w_security_check, "User Group Control")
	MessageBox("Info", "Insufficient privileges!")
	Close(this)
	RETURN 0
END IF

ids_apps = CREATE datastore  
ids_apps.DataObject = "d_app_list"  
ids_apps.SetTransObject (SQLCA)  
ids_apps.Retrieve()

dw_list.of_SettransObject(SQLCA)
dw_list.Event pfc_retrieve()

//dw_rights.Visible = FALSE

end event

event close;call super::close;DESTROY ids_apps
end event

event pfc_save;call super::pfc_save;Int li_rc

dw_list.AcceptText()
li_rc = dw_list.Update(TRUE, FALSE)
IF li_rc = 1 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

dw_is.AcceptText()
li_rc = dw_is.Update(TRUE, FALSE)
IF li_rc = 1 THEN
	COMMIT USING SQLCA;
	dw_list.ResetUpdate()
	dw_is.ResetUpdate()
ELSE
	ROLLBACK USING SQLCA;
	RETURN -2
END IF

RETURN 1

end event

type dw_list from u_dw within w_group_managment
int X=44
int Y=0
int Width=2015
int Height=598
int TabOrder=10
string DataObject="d_group_list"
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event rbuttondown;//override
Return 0
end event

event rbuttonup;//override
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

IF this.GetItemNumber(li_Row, "user_group_id", Primary!, FALSE) > 0 THEN
	wf_display_rights()
END IF

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(FocusRect!)


end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_row1, ll_i, ll_id, ll_temp

ll_row = this.GetRow()
ll_id = Long(this.Describe("Evaluate('MAX(user_group_id FOR All)', 0 )"))
ll_id = ll_id + 1
SetItem(ll_row, "user_group_id", ll_id)

wf_display_rights()

RETURN ll_id	


end event

type cb_close from u_cb within w_group_managment
int X=1532
int Y=1366
int TabOrder=90
string Text="&Close"
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_save from u_cb within w_group_managment
int X=1097
int Y=1366
int TabOrder=80
string Tag="save changes"
string Text="&Save"
string FaceName="Arial"
end type

event clicked;call super::clicked;Parent.Event pfc_Save()
end event

type cb_add from u_cb within w_group_managment
int X=227
int Y=1366
int TabOrder=60
string Tag="add a new user"
string Text="&Add Group"
string FaceName="Arial"
end type

event clicked;dw_is.SetFilter("")
dw_is.Filter()
dw_list.Event pfc_addrow()
end event

type lb_isnot from u_lb within w_group_managment
int X=1269
int Y=659
int Width=775
int Height=688
int TabOrder=50
boolean BringToTop=true
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_1 from statictext within w_group_managment
int X=84
int Y=602
int Width=307
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Has rights on:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_group_managment
int X=1276
int Y=602
int Width=406
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="Has NO rights on:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_addright from u_cb within w_group_managment
int X=878
int Y=790
int Width=358
int TabOrder=40
string Text="<< Add &Right"
string FaceName="Arial"
end type

event clicked;String ls_item
Long ll_row, ll_i, ll_group, ll_app

ls_item = lb_isnot.SelectedItem()

ll_row = ids_apps.RowCount()
FOR ll_i = 1 TO ll_row
	IF ids_apps.GetItemString(ll_i, "application_name") = ls_item THEN
		ll_app = ids_apps.GetItemNumber(ll_i, "application_id")
	END IF
NEXT

ll_row = dw_list.GetRow()
IF ll_row > 0 THEN
	ll_group = dw_list.GetItemNumber(ll_row, "user_group_id", Primary!, FALSE)
END IF

ll_row = dw_is.InsertRow(0)
dw_is.SetItem(ll_row, "security_group_application_user_group_id", ll_group)
dw_is.SetItem(ll_row, "security_group_application_application_i", ll_app)
dw_is.setItem(ll_row, "security_group_application_group_applica", 1)
dw_is.SetItem(ll_row, "security_application_application_name", ls_item)

wf_display_rights()

RETURN 1


end event

type cb_remove from u_cb within w_group_managment
int X=878
int Y=1021
int TabOrder=30
string Text="&Remove >>"
string FaceName="Arial"
end type

event clicked;Long ll_row

ll_row = dw_is.GetRow()
IF ll_row < 1 THEN RETURN
dw_is.DeleteRow(ll_row)
wf_display_rights()

RETURN 0


end event

type dw_is from u_dw within w_group_managment
event ue_fill_new_row ( long al_row,  string as_value,  long al_groupid,  long al_appid,  integer ai_pri )
int X=51
int Y=659
int Width=775
int Height=688
int TabOrder=20
boolean BringToTop=true
string DataObject="d_group_app_display"
boolean LiveScroll=false
end type

event ue_fill_new_row;this.SetItem(al_row, "security_application_application_name", as_value)
this.SetItem(al_row, "security_application_application_id", al_appid)
this.SetItem(al_row, "security_group_application_group_applica", ai_pri)

end event

event pfc_addrow;call super::pfc_addrow;Long ll_row
ll_row = this.GetRow()
RETURN ll_row
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
this.SetTransObject(SQLCA)
this.Retrieve()

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

RETURN
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type cb_delete from u_cb within w_group_managment
int X=662
int Y=1366
int Width=355
int TabOrder=70
string Tag="delete a new user"
string Text="&Delete Group"
string FaceName="Arial"
end type

event clicked;Long ll_row
ll_row = dw_list.GetRow()
IF ll_row > 0 THEN
	dw_list.DeleteRow(0)
END IF

end event

