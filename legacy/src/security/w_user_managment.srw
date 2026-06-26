$PBExportHeader$w_user_managment.srw
$PBExportComments$<Sheet> User managment window inherited from pfemain/w_sheet
forward
global type w_user_managment from w_sheet
end type
type dw_user_list from u_dw within w_user_managment
end type
type cb_close from u_cb within w_user_managment
end type
type cb_save from u_cb within w_user_managment
end type
type cb_add from u_cb within w_user_managment
end type
type cb_del from u_cb within w_user_managment
end type
type cb_detail from u_cb within w_user_managment
end type
end forward

global type w_user_managment from w_sheet
int X=4
int Y=6
int Width=2110
int Height=1578
boolean TitleBar=true
string Title="User Managment"
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
event ue_read_only ( )
dw_user_list dw_user_list
cb_close cb_close
cb_save cb_save
cb_add cb_add
cb_del cb_del
cb_detail cb_detail
end type
global w_user_managment w_user_managment

type variables
String istr_user[]
end variables

event ue_whoami;RETURN "w_user_managment"
end event

event ue_read_only;dw_user_list.Object.DataWindow.ReadOnly = "YES"
cb_add.Enabled = FALSE
cb_del.Enabled = FALSE
end event

on w_user_managment.create
int iCurrent
call super::create
this.dw_user_list=create dw_user_list
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_del=create cb_del
this.cb_detail=create cb_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_user_list
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_del
this.Control[iCurrent+6]=this.cb_detail
end on

on w_user_managment.destroy
call super::destroy
destroy(this.dw_user_list)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.cb_detail)
end on

event open;call super::open;s_security_data  lds_sec

IF f_security_door("User Control") < 0 THEN
	MessageBox("Info", "Insufficient privileges!")
	Close(this)
	RETURN 0
END IF

dw_user_list.SetTransObject(SQLCA)
dw_user_list.Event pfc_Retrieve()

end event

event pfc_save;call super::pfc_save;Int li_i, li_tot

li_tot = UpperBound(istr_user)
IF li_tot = 0 THEN RETURN 0
FOR li_i = 1 TO li_tot
		//delete ORACLE user code start
	IF NOT(IsNULL(istr_user[li_i])) THEN f_drop_user(istr_user[li_i])
NEXT		
FOR li_i = li_tot TO 1 STEP -1
		//delete ORACLE user code start
	SetNULL(istr_user[li_i])
NEXT
RETURN 1


end event

event activate;call super::activate;IF f_security_door("User Control") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type dw_user_list from u_dw within w_user_managment
int X=51
int Y=6
int Width=1993
int Height=1363
int TabOrder=10
string DataObject="d_user_list"
end type

event doubleclicked;call super::doubleclicked;long ll_user_id

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

ll_user_id = GetItemNumber(row, "user_id")
OpenWithParm(w_user_detail,ll_user_id)


end event

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

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

type cb_close from u_cb within w_user_managment
int X=1627
int Y=1376
int TabOrder=60
string Text="&Close"
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_save from u_cb within w_user_managment
int X=1247
int Y=1376
int TabOrder=50
string Tag="save changes"
string Text="&Save"
string FaceName="Arial"
end type

event clicked;call super::clicked;Parent.Event pfc_Save()
end event

type cb_add from u_cb within w_user_managment
int X=102
int Y=1373
int TabOrder=20
string Tag="add a new user"
string Text="&Add"
string FaceName="Arial"
end type

event clicked;Long ll_rc
Long ll_id

ll_id = Long(dw_user_list.Describe("Evaluate('MAX(user_id FOR All)', 0 )"))
ll_id = ll_id + 1
OpenWithParm(w_user_new, ll_id)
ll_rc = Message.DoubleParm
IF ll_rc = 99999999 THEN
	dw_user_list.Event pfc_Retrieve()
END IF

RETURN 1

end event

type cb_del from u_cb within w_user_managment
int X=486
int Y=1376
int TabOrder=30
string Tag="delete current user"
string Text="&Delete"
string FaceName="Arial"
end type

event clicked;long ll_user_id, ll_row
String ls_fname, ls_lname, ls_loginname, ls_msg
Int ll_rc, li_tot

ll_row = dw_user_list.GetRow()
IF ll_row > 0 THEN 
	ll_user_id = dw_user_list.GetItemNumber(ll_row, "user_id")
	ls_fname = dw_user_list.GetItemString(ll_row, "user_first_name")
	ls_lname = dw_user_list.GetItemString(ll_row, "user_last_name")
	ls_loginname = dw_user_list.GetItemString(ll_row, "login_id")
	ls_msg = "Deleting user " + ls_fname + " " + ls_lname + ". Are you sure?"
	IF MessageBox("Question", ls_msg, Question!, OKCancel!, 2) = 2 THEN RETURN 0
	
	ll_rc = 0
	SELECT COUNT(user_id) INTO :ll_rc
	FROM security_user_application
	WHERE user_id = :ll_user_id
	USING SQLCA;
	IF ll_rc > 0 THEN
		MessageBox("Info", "There are applications assigned to this user, clear user privilege please!" )
		RETURN -2
	END IF

	ll_rc = 0
	SELECT COUNT(user_id) INTO :ll_rc
	FROM security_user_group
	WHERE user_id = :ll_user_id
	USING SQLCA;
	IF ll_rc > 0 THEN
		MessageBox("Info", "User has been assigned to group, clear user roles please!" )
		RETURN -3
	END IF
	
	dw_user_list.DeleteRow(ll_row)
	
	ll_rc = 0 
	SELECT COUNT(user_id) INTO :ll_rc
	FROM security_user
	WHERE user_id = :ll_user_id
	USING SQLCA;
	IF ll_rc > 0 THEN
		li_tot = UpperBound(istr_user)
		istr_user[li_tot + 1] = ls_loginname
	END IF
	
	//end
	RETURN 1
END IF

RETURN -1

end event

type cb_detail from u_cb within w_user_managment
int X=867
int Y=1376
int TabOrder=40
string Tag="display detail infromation about current user"
string Text="D&etail"
string FaceName="Arial"
end type

event clicked;long ll_user_id, ll_row

ll_row = dw_user_list.GetRow()
IF ll_row > 0 THEN 
	ll_user_id = dw_user_list.GetItemNumber(ll_row, "user_id")
	OpenWithParm(w_user_detail,ll_user_id)
	RETURN 1
END IF
RETURN 0


end event

