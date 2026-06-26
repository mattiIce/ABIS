$PBExportHeader$w_user_password.srw
$PBExportComments$<Sheet>User uses this window to change his password and description inherited from pfemain/w_sheet
forward
global type w_user_password from w_sheet
end type
type st_1 from u_st within w_user_password
end type
type st_username from u_st within w_user_password
end type
type st_2 from u_st within w_user_password
end type
type st_fullname from u_st within w_user_password
end type
type st_4 from u_st within w_user_password
end type
type st_5 from u_st within w_user_password
end type
type sle_p from u_sle within w_user_password
end type
type sle_cp from u_sle within w_user_password
end type
type cb_ok from u_cb within w_user_password
end type
type cb_cancel from u_cb within w_user_password
end type
type sle_op from u_sle within w_user_password
end type
type st_6 from u_st within w_user_password
end type
end forward

global type w_user_password from w_sheet
int X=640
int Y=317
int Width=1521
int Height=608
boolean TitleBar=true
string Title="User Properties"
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
st_1 st_1
st_username st_username
st_2 st_2
st_fullname st_fullname
st_4 st_4
st_5 st_5
sle_p sle_p
sle_cp sle_cp
cb_ok cb_ok
cb_cancel cb_cancel
sle_op sle_op
st_6 st_6
end type
global w_user_password w_user_password

type variables
String is_password
 DECLARE change_pwd PROCEDURE FOR  CHANGE_PWD  
         UNAME = uname,   
         NEW_PWD = password  ;

end variables

event ue_whoami;RETURN "w_user_password"
end event

on w_user_password.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_username=create st_username
this.st_2=create st_2
this.st_fullname=create st_fullname
this.st_4=create st_4
this.st_5=create st_5
this.sle_p=create sle_p
this.sle_cp=create sle_cp
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.sle_op=create sle_op
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_username
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_fullname
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.sle_p
this.Control[iCurrent+8]=this.sle_cp
this.Control[iCurrent+9]=this.cb_ok
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.sle_op
this.Control[iCurrent+12]=this.st_6
end on

on w_user_password.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_username)
destroy(this.st_2)
destroy(this.st_fullname)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_p)
destroy(this.sle_cp)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.sle_op)
destroy(this.st_6)
end on

event open;call super::open;String ls_loginid, ls_fname, ls_lname
Int li_userid

ls_loginid = gnv_app.of_GetUserId()
st_username.Text = ls_loginid

CONNECT USING SQLCA;
SELECT user_id, user_first_name, user_last_name  
INTO  :li_userid, :ls_fname, :ls_lname
FROM security_user
WHERE login_id = :ls_loginid
USING SQLCA;

is_password = SQLCA.logpass
st_fullname.Text = Trim(ls_fname) + " " + trim(ls_lname)



end event

type st_1 from u_st within w_user_password
int X=37
int Y=35
int Width=146
string Text="User:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_username from u_st within w_user_password
int X=252
int Y=35
int Width=545
boolean BringToTop=true
string Text=""
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_2 from u_st within w_user_password
int X=37
int Y=122
int Width=285
boolean BringToTop=true
string Text="Full Name:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_fullname from u_st within w_user_password
int X=377
int Y=122
int Width=625
boolean BringToTop=true
string Text=""
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_4 from u_st within w_user_password
int X=37
int Y=317
int Width=355
boolean BringToTop=true
string Text="New Password:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_5 from u_st within w_user_password
int X=37
int Y=387
int Height=102
boolean BringToTop=true
string Text="Confirm Password:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type sle_p from u_sle within w_user_password
int X=399
int Y=310
int Width=633
int TabOrder=20
boolean BringToTop=true
boolean PassWord=true
end type

type sle_cp from u_sle within w_user_password
int X=399
int Y=403
int Width=633
int TabOrder=30
boolean BringToTop=true
boolean PassWord=true
end type

type cb_ok from u_cb within w_user_password
int X=1115
int Y=262
int Width=325
int Height=90
int TabOrder=40
string Text="&Ok"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;integer li_rc

IF (sle_op.Text <> is_password) THEN
	MessageBox("Warning", "Failed to confirm your current password!" )
	Return 0
END IF

li_rc = MessageBox("Warning!", "Are you sure?", Question!, YesNO!, 2 )
IF Li_rc = 2 THEN 
	RETURN 0
END IF

IF sle_p.Text <> sle_cp.Text THEN
	li_rc = MessageBox("Warning!", "The new password was not correctly confirmed!", StopSign!, OKCancel!, 2 )
	IF Li_rc = 1 THEN 
		Return -1
	END IF
ELSE
	String ls_loginid
	DATE ld_date
	ls_loginid = gnv_app.of_GetUserId()
	ld_date = Today()
	IF Len(sle_p.Text) > 2  THEN
		IF f_change_password(ls_loginid, sle_p.Text) < 0 THEN RETURN -2
		CONNECT USING SQLCA;
		Update security_user
		SET last_modified_date = :ld_date
		WHERE login_id = :ls_loginid
		USING SQLCA;
		COMMIT USING SQLCA;
		SQLCA.logpass = sle_p.Text
		MessageBox("Info", "Password has been changed!")
	ELSE
		MessageBox("Sorry", "Password must be more than 2 characters!", StopSign!)
	END IF
END IF



end event

type cb_cancel from u_cb within w_user_password
int X=1115
int Y=384
int Width=325
int Height=90
int TabOrder=50
string Text="&Cancel"
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(parent)
end event

type sle_op from u_sle within w_user_password
int X=399
int Y=221
int Width=633
int TabOrder=10
boolean BringToTop=true
boolean PassWord=true
end type

type st_6 from u_st within w_user_password
int X=37
int Y=227
boolean BringToTop=true
string Text="Old Password:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

