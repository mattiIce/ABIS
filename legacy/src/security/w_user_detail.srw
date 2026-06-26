$PBExportHeader$w_user_detail.srw
$PBExportComments$<Sheet>User Detail information window inherited from pfemain/w_sheet
forward
global type w_user_detail from w_sheet
end type
type ln_divider1 from line within w_user_detail
end type
type ln_divider2 from line within w_user_detail
end type
type st_1 from u_st within w_user_detail
end type
type st_username from u_st within w_user_detail
end type
type st_2 from u_st within w_user_detail
end type
type st_fullname from u_st within w_user_detail
end type
type st_3 from u_st within w_user_detail
end type
type st_4 from u_st within w_user_detail
end type
type st_5 from u_st within w_user_detail
end type
type sle_desc from u_sle within w_user_detail
end type
type sle_p from u_sle within w_user_detail
end type
type sle_cp from u_sle within w_user_detail
end type
type cb_close from u_cb within w_user_detail
end type
type cb_save from u_cb within w_user_detail
end type
type tab_user from tab within w_user_detail
end type
type tabpage_general from userobject within tab_user
end type
type cbx_1 from u_cbx within tabpage_general
end type
type cbx_2 from u_cbx within tabpage_general
end type
type cbx_3 from u_cbx within tabpage_general
end type
type cbx_4 from u_cbx within tabpage_general
end type
type cbx_5 from u_cbx within tabpage_general
end type
type tabpage_role from userobject within tab_user
end type
type lb_groupis from u_lb within tabpage_role
end type
type lb_groupnot from u_lb within tabpage_role
end type
type st_6 from statictext within tabpage_role
end type
type st_7 from statictext within tabpage_role
end type
type cb_add1 from u_cb within tabpage_role
end type
type cb_del from u_cb within tabpage_role
end type
type tabpage_pri from userobject within tab_user
end type
type cb_add2 from u_cb within tabpage_pri
end type
type cb_del2 from u_cb within tabpage_pri
end type
type lb_prinot from u_lb within tabpage_pri
end type
type st_8 from statictext within tabpage_pri
end type
type st_9 from statictext within tabpage_pri
end type
type dw_priis from u_dw within tabpage_pri
end type
type tabpage_general from userobject within tab_user
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
end type
type tabpage_role from userobject within tab_user
lb_groupis lb_groupis
lb_groupnot lb_groupnot
st_6 st_6
st_7 st_7
cb_add1 cb_add1
cb_del cb_del
end type
type tabpage_pri from userobject within tab_user
cb_add2 cb_add2
cb_del2 cb_del2
lb_prinot lb_prinot
st_8 st_8
st_9 st_9
dw_priis dw_priis
end type
type tab_user from tab within w_user_detail
tabpage_general tabpage_general
tabpage_role tabpage_role
tabpage_pri tabpage_pri
end type
end forward

global type w_user_detail from w_sheet
int X=944
int Y=301
int Width=1755
int Height=1472
WindowType WindowType=response!
boolean TitleBar=true
string Title="User Detail"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
ln_divider1 ln_divider1
ln_divider2 ln_divider2
st_1 st_1
st_username st_username
st_2 st_2
st_fullname st_fullname
st_3 st_3
st_4 st_4
st_5 st_5
sle_desc sle_desc
sle_p sle_p
sle_cp sle_cp
cb_close cb_close
cb_save cb_save
tab_user tab_user
end type
global w_user_detail w_user_detail

type variables
DataStore ids_groupis
DataStore ids_groupnot
DataStore ids_prinot
Int ii_userid
end variables

forward prototypes
public subroutine show_panel (integer level)
public subroutine wf_show_group ()
end prototypes

event ue_whoami;RETURN "w_user_detail"
end event

public subroutine show_panel (integer level);integer li_total_height
integer li_inside_height
integer li_adjustment
integer li_bottom

li_total_height = this.Height		
li_inside_height = this.WorkSpaceHeight ( )
li_adjustment = li_total_height - li_inside_height


	// Now, determine how many panels to display.

CHOOSE CASE level
		
	CASE 1
		li_bottom = this.ln_divider1.BeginY
	CASE 2
		li_bottom = this.ln_divider2.BeginY
	CASE ELSE
		RETURN
END CHOOSE
li_bottom = li_bottom - 2
li_bottom = li_bottom + li_adjustment
this.Height = li_bottom

end subroutine

public subroutine wf_show_group ();String ls_loginid, ls_fname, ls_lname
Long ll_uid
Long ll_row, ll_i

tab_user.tabpage_role.lb_groupis.Reset()
ll_row = ids_groupis.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_role.lb_groupis.AddItem(ids_groupis.GetItemString(ll_i, "security_group_group_name", Primary!, FALSE))
	NEXT
END IF

tab_user.tabpage_role.lb_groupnot.Reset()
ll_row = ids_groupnot.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_role.lb_groupnot.AddItem(ids_groupnot.GetItemString(ll_i, "security_group_group_name", Primary!, FALSE) )
	NEXT
END IF

tab_user.tabpage_pri.lb_prinot.Reset()
ll_row = ids_prinot.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_pri.lb_prinot.AddItem(ids_prinot.GetItemString(ll_i, "application_name", Primary!, FALSE) )
	NEXT
END IF

end subroutine

on w_user_detail.create
int iCurrent
call super::create
this.ln_divider1=create ln_divider1
this.ln_divider2=create ln_divider2
this.st_1=create st_1
this.st_username=create st_username
this.st_2=create st_2
this.st_fullname=create st_fullname
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.sle_desc=create sle_desc
this.sle_p=create sle_p
this.sle_cp=create sle_cp
this.cb_close=create cb_close
this.cb_save=create cb_save
this.tab_user=create tab_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_divider1
this.Control[iCurrent+2]=this.ln_divider2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_username
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_fullname
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.sle_desc
this.Control[iCurrent+11]=this.sle_p
this.Control[iCurrent+12]=this.sle_cp
this.Control[iCurrent+13]=this.cb_close
this.Control[iCurrent+14]=this.cb_save
this.Control[iCurrent+15]=this.tab_user
end on

on w_user_detail.destroy
call super::destroy
destroy(this.ln_divider1)
destroy(this.ln_divider2)
destroy(this.st_1)
destroy(this.st_username)
destroy(this.st_2)
destroy(this.st_fullname)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_desc)
destroy(this.sle_p)
destroy(this.sle_cp)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.tab_user)
end on

event open;call super::open;String ls_loginid, ls_fname, ls_lname
Long ll_uid
Long ll_row, ll_i

ii_userid = message.doubleparm 

ids_groupis = CREATE datastore  
ids_groupis.DataObject = "d_user_group_list"  
ids_groupis.SetTransObject (SQLCA)  
ids_groupis.Retrieve(ii_userid)
tab_user.tabpage_role.lb_groupis.Reset()
ll_row = ids_groupis.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_role.lb_groupis.AddItem(ids_groupis.GetItemString(ll_i, "security_group_group_name"))
	NEXT
END IF

ids_groupnot = CREATE datastore  
ids_groupnot.DataObject = "d_user_notin_group_list"  
ids_groupnot.SetTransObject (SQLCA)  
ids_groupnot.Retrieve(ii_userid)
tab_user.tabpage_role.lb_groupnot.Reset()
ll_row = ids_groupnot.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_role.lb_groupnot.AddItem(ids_groupnot.GetItemString(ll_i, "security_group_group_name"))
	NEXT
END IF

tab_user.tabpage_pri.dw_priis.Retrieve(ii_userid)

ids_prinot = CREATE datastore  
ids_prinot.DataObject = "d_user_notin_app"  
ids_prinot.SetTransObject (SQLCA)  
ids_prinot.Retrieve(ii_userid)
tab_user.tabpage_pri.lb_prinot.Reset()
ll_row = ids_prinot.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_pri.lb_prinot.AddItem(ids_prinot.GetItemString(ll_i, "application_name"))
	NEXT
END IF

CONNECT USING SQLCA;
SELECT login_id, user_notes, user_first_name, user_last_name  
INTO :st_username.Text, :sle_desc.Text, :ls_fname, :ls_lname
FROM security_user
WHERE user_id = :ii_userid
USING SQLCA;

st_fullname.Text = Trim(ls_fname) + " " + trim(ls_lname)


end event

event close;call super::close;DESTROY ids_groupis
DESTROY ids_groupnot
DESTROY ids_prinot
end event

event pfc_save;call super::pfc_save;if sle_p.Text <> sle_cp.Text THEN
	MessageBox("Error", "Failed to save user information due to unconfirmed password!", StopSign!)
	Return -1
END IF

if Len(sle_p.Text) > 0 AND Len(sle_p.Text) < 3 THEN
	MessageBox("Error", "Password required more than 2 characters", StopSign!)
	Return -2
END IF

Date ld_date
ld_date = Today()

IF len(sle_p.Text) > 0 THEN
	IF f_change_password(st_username.Text, sle_p.Text) < 0 THEN RETURN -3
END IF

CONNECT USING SQLCA;
Int li_rc
li_rc = ids_groupis.Update(TRUE, FALSE)
IF li_rc = 1 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -4
END IF
li_rc = tab_user.tabpage_pri.dw_priis.Update(TRUE, FALSE)
IF li_rc = 1 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -5
END IF
UPDATE security_user
SET user_notes = :sle_desc.Text, last_modified_date = :ld_date
WHERE user_id = :ii_userid
USING SQLCA;
IF SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA;
	ids_groupis.ResetUpdate()
	ids_groupnot.ResetUpdate()
	tab_user.tabpage_pri.dw_priis.ResetUpdate()
	ids_prinot.ResetUpdate()
END IF

RETURN 1

end event

type ln_divider1 from line within w_user_detail
boolean Enabled=false
int BeginX=59
int BeginY=528
int EndX=1518
int EndY=528
int LineThickness=3
end type

type ln_divider2 from line within w_user_detail
boolean Enabled=false
int BeginX=128
int BeginY=1373
int EndX=1613
int EndY=1373
int LineThickness=3
end type

type st_1 from u_st within w_user_detail
int X=69
int Y=38
int Width=146
string Text="User:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_username from u_st within w_user_detail
int X=252
int Y=38
int Width=545
boolean BringToTop=true
string Text=""
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_2 from u_st within w_user_detail
int X=69
int Y=125
int Width=285
boolean BringToTop=true
string Text="Full Name:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_fullname from u_st within w_user_detail
int X=377
int Y=125
int Width=625
boolean BringToTop=true
string Text=""
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_3 from u_st within w_user_detail
int X=69
int Y=211
int Width=307
boolean BringToTop=true
string Text="Description:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_4 from u_st within w_user_detail
int X=69
int Y=298
boolean BringToTop=true
string Text="Password:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_5 from u_st within w_user_detail
int X=69
int Y=374
int Height=102
boolean BringToTop=true
string Text="Confirm Password:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type sle_desc from u_sle within w_user_detail
int X=395
int Y=202
int Width=827
int TabOrder=10
end type

type sle_p from u_sle within w_user_detail
int X=395
int Y=291
int Width=827
int TabOrder=20
boolean BringToTop=true
boolean PassWord=true
end type

event constructor;call super::constructor;this.ib_autoselect = true
end event

type sle_cp from u_sle within w_user_detail
int X=395
int Y=384
int Width=827
int TabOrder=30
boolean BringToTop=true
boolean PassWord=true
end type

event constructor;call super::constructor;this.ib_autoselect = true
end event

type cb_close from u_cb within w_user_detail
int X=1287
int Y=365
int Width=399
int TabOrder=50
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_save from u_cb within w_user_detail
event clicked pbm_bnclicked
int X=1287
int Y=240
int Width=399
int TabOrder=40
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;Parent.Event pfc_save()
end event

type tab_user from tab within w_user_detail
event create ( )
event destroy ( )
int X=48
int Y=509
int Width=1638
int Height=845
int TabOrder=60
boolean BringToTop=true
boolean FixedWidth=true
boolean PictureOnRight=true
boolean BoldSelectedText=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_general tabpage_general
tabpage_role tabpage_role
tabpage_pri tabpage_pri
end type

on tab_user.create
this.tabpage_general=create tabpage_general
this.tabpage_role=create tabpage_role
this.tabpage_pri=create tabpage_pri
this.Control[]={this.tabpage_general,&
this.tabpage_role,&
this.tabpage_pri}
end on

on tab_user.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_role)
destroy(this.tabpage_pri)
end on

type tabpage_general from userobject within tab_user
event create ( )
event destroy ( )
int X=15
int Y=90
int Width=1609
int Height=742
long BackColor=79741120
string Text="General"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Custom092!"
string PowerTipText="general"
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
end type

on tabpage_general.create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.Control[]={this.cbx_1,&
this.cbx_2,&
this.cbx_3,&
this.cbx_4,&
this.cbx_5}
end on

on tabpage_general.destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
end on

type cbx_1 from u_cbx within tabpage_general
int X=121
int Y=67
int Width=1148
boolean Enabled=false
boolean BringToTop=true
string Text="User must change password at next logon"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cbx_2 from u_cbx within tabpage_general
int X=121
int Y=166
int Width=1123
boolean Enabled=false
boolean BringToTop=true
string Text="User can not change password"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cbx_3 from u_cbx within tabpage_general
int X=121
int Y=266
int Width=1068
boolean Enabled=false
boolean BringToTop=true
string Text="Password never expires"
boolean Checked=true
long BackColor=79741120
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cbx_4 from u_cbx within tabpage_general
int X=121
int Y=365
int Width=991
boolean Enabled=false
boolean BringToTop=true
string Text="Account disabled"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cbx_5 from u_cbx within tabpage_general
int X=121
int Y=464
int Width=1042
boolean Enabled=false
boolean BringToTop=true
string Text="Account locked out"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type tabpage_role from userobject within tab_user
event create ( )
event destroy ( )
int X=15
int Y=90
int Width=1609
int Height=742
long BackColor=79741120
string Text="Role"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="ArrangeTables!"
lb_groupis lb_groupis
lb_groupnot lb_groupnot
st_6 st_6
st_7 st_7
cb_add1 cb_add1
cb_del cb_del
end type

on tabpage_role.create
this.lb_groupis=create lb_groupis
this.lb_groupnot=create lb_groupnot
this.st_6=create st_6
this.st_7=create st_7
this.cb_add1=create cb_add1
this.cb_del=create cb_del
this.Control[]={this.lb_groupis,&
this.lb_groupnot,&
this.st_6,&
this.st_7,&
this.cb_add1,&
this.cb_del}
end on

on tabpage_role.destroy
destroy(this.lb_groupis)
destroy(this.lb_groupnot)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cb_add1)
destroy(this.cb_del)
end on

type lb_groupis from u_lb within tabpage_role
int X=18
int Y=83
int Width=600
int Height=640
int TabOrder=11
boolean BringToTop=true
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type lb_groupnot from u_lb within tabpage_role
int X=991
int Y=83
int Width=600
int Height=640
int TabOrder=11
boolean BringToTop=true
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_6 from statictext within tabpage_role
int X=22
int Y=16
int Width=300
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Is member of:"
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

type st_7 from statictext within tabpage_role
int X=998
int Y=16
int Width=421
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Is not a member of:"
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

type cb_add1 from u_cb within tabpage_role
int X=633
int Y=176
int Width=344
int TabOrder=11
boolean BringToTop=true
string Text=" << &Add"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;String ls_item, ls_val
Long ll_row, ll_i, ll_group, ll_temp

ls_item = tab_user.tabpage_role.lb_groupnot.SelectedItem()
IF Len(ls_item) < 2 THEN RETURN 0
IF isNULL(ls_item) THEN Return -1
ll_row = ids_groupnot.RowCount()
IF ll_row < 1 THEN Return -2
FOR ll_i = 1 TO ll_row
	IF ls_item = ids_groupnot.GetItemString(ll_i, "security_group_group_name") THEN
		ll_group = ids_groupnot.GetItemNumber(ll_i, "security_group_user_group_id")
		ll_temp = ll_i
	END IF
NEXT
ll_row = ids_groupis.InsertRow(0)
ids_groupis.SetItem(ll_row, "security_user_group_user_id", ii_userid)
ids_groupis.SetItem(ll_row, "security_user_group_user_group_id", ll_group)
ids_groupis.setItem(ll_row, "security_group_group_name", ls_item)
ids_groupnot.DeleteRow(ll_temp)

wf_show_group()




end event

type cb_del from u_cb within tabpage_role
int X=633
int Y=368
int Width=344
int TabOrder=11
boolean BringToTop=true
string Text="&Remove >>"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;String ls_item, ls_val
Long ll_row, ll_i, ll_group, ll_temp

ls_item = tab_user.tabpage_role.lb_groupis.SelectedItem()
IF Len(ls_item) < 2 THEN RETURN 0
IF isNULL(ls_item) THEN Return -1
ll_row = ids_groupis.RowCount()
IF ll_row < 1 THEN Return -2
FOR ll_i = 1 TO ll_row
	IF ls_item = ids_groupis.GetItemString(ll_i, "security_group_group_name") THEN
		ll_group = ids_groupis.GetItemNumber(ll_i, "security_user_group_user_group_id")
		ll_temp = ll_i
	END IF
NEXT
ll_row = ids_groupnot.InsertRow(0)
ids_groupnot.SetItem(ll_row, "security_group_user_group_id", ll_group)
ids_groupnot.setItem(ll_row, "security_group_group_name", ls_item)
ids_groupis.DeleteRow(ll_temp)

wf_show_group()


end event

type tabpage_pri from userobject within tab_user
event create ( )
event destroy ( )
int X=15
int Y=90
int Width=1609
int Height=742
long BackColor=79741120
string Text="Privilege"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="DataManip!"
cb_add2 cb_add2
cb_del2 cb_del2
lb_prinot lb_prinot
st_8 st_8
st_9 st_9
dw_priis dw_priis
end type

on tabpage_pri.create
this.cb_add2=create cb_add2
this.cb_del2=create cb_del2
this.lb_prinot=create lb_prinot
this.st_8=create st_8
this.st_9=create st_9
this.dw_priis=create dw_priis
this.Control[]={this.cb_add2,&
this.cb_del2,&
this.lb_prinot,&
this.st_8,&
this.st_9,&
this.dw_priis}
end on

on tabpage_pri.destroy
destroy(this.cb_add2)
destroy(this.cb_del2)
destroy(this.lb_prinot)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.dw_priis)
end on

type cb_add2 from u_cb within tabpage_pri
int X=677
int Y=189
int Width=315
int TabOrder=11
boolean BringToTop=true
string Text="<< &Add"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;String ls_item, ls_val
Long ll_row, ll_i, ll_app, ll_temp

ls_item = tab_user.tabpage_pri.lb_prinot.SelectedItem()
ll_row = ids_prinot.RowCount()
IF ll_row < 1 THEN Return -2
FOR ll_i = 1 TO ll_row
	IF ls_item = ids_prinot.GetItemString(ll_i, "application_name") THEN
		ll_app = ids_prinot.GetItemNumber(ll_i, "application_id")
		ll_temp = ll_i
	END IF
NEXT
ll_row = tab_user.tabpage_pri.dw_priis.InsertRow(0)
tab_user.tabpage_pri.dw_priis.SetItem(ll_row, "security_user_application_user_id", ii_userid)
tab_user.tabpage_pri.dw_priis.SetItem(ll_row, "security_user_application_application_id", ll_app)
tab_user.tabpage_pri.dw_priis.SetItem(ll_row, "security_application_application_id", ll_app)
tab_user.tabpage_pri.dw_priis.setItem(ll_row, "security_application_application_name", ls_item)
tab_user.tabpage_pri.dw_priis.SetItem(ll_row, "security_user_application_user_applicati", 1)
ids_prinot.DeleteRow(ll_temp)

wf_show_group()




end event

type cb_del2 from u_cb within tabpage_pri
int X=677
int Y=406
int Width=315
int TabOrder=11
boolean BringToTop=true
string Text="Remove >>"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;String ls_item, ls_val
Long ll_row, ll_i, ll_app, ll_temp

ll_row = tab_user.tabpage_pri.dw_priis.GetRow()
IF ll_row < 1 THEN RETURN 0
ls_item = tab_user.tabpage_pri.dw_priis.GetItemString(ll_row, "security_application_application_name", Primary!, FALSE)
ll_app = tab_user.tabpage_pri.dw_priis.GetItemNumber(ll_row, "security_application_application_id", Primary!, FALSE)
ll_temp = ll_row

ll_row = ids_prinot.InsertRow(0)
ids_prinot.SetItem(ll_row, "application_id", ll_app)
ids_prinot.setItem(ll_row, "application_name", ls_item)
tab_user.tabpage_pri.dw_priis.DeleteRow(ll_temp)

wf_show_group()




end event

type lb_prinot from u_lb within tabpage_pri
int X=995
int Y=86
int Width=607
int Height=640
int TabOrder=10
boolean BringToTop=true
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_8 from statictext within tabpage_pri
int X=22
int Y=19
int Width=267
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Privilege on:"
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

type st_9 from statictext within tabpage_pri
int X=995
int Y=19
int Width=347
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Privilege not on:"
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

type dw_priis from u_dw within tabpage_pri
int X=4
int Y=90
int Width=673
int Height=640
int TabOrder=11
boolean BringToTop=true
string DataObject="d_user_app"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
this.SetTransObject(SQLCA)

end event

