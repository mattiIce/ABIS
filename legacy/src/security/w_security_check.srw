$PBExportHeader$w_security_check.srw
$PBExportComments$<Popup>check user security code
forward
global type w_security_check from w_popup
end type
type cb_ok from u_cb within w_security_check
end type
type sle_name from u_sle within w_security_check
end type
type sle_pass from u_sle within w_security_check
end type
type st_1 from statictext within w_security_check
end type
type st_2 from statictext within w_security_check
end type
type cb_cancel from u_cb within w_security_check
end type
end forward

global type w_security_check from w_popup
int X=516
int Y=211
int Width=1595
int Height=653
WindowType WindowType=response!
boolean TitleBar=true
string Title="Security"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
sle_name sle_name
sle_pass sle_pass
st_1 st_1
st_2 st_2
cb_cancel cb_cancel
end type
global w_security_check w_security_check

type variables
Int ii_times
String is_app_name
end variables

on w_security_check.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.sle_name=create sle_name
this.sle_pass=create sle_pass
this.st_1=create st_1
this.st_2=create st_2
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.sle_name
this.Control[iCurrent+3]=this.sle_pass
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_cancel
end on

on w_security_check.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.sle_name)
destroy(this.sle_pass)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_cancel)
end on

event open;call super::open;is_app_name = Message.StringParm
sle_name.Text = gnv_app.of_GetUserId()
ii_times = 0
end event

event key;call super::key;IF KeyDown(KeyEnter!) THEN 
	cb_ok.TriggerEvent(Clicked!)
END IF
end event

type cb_ok from u_cb within w_security_check
int X=300
int Y=429
int TabOrder=30
string Text="&Ok"
string FaceName="Arial"
end type

event clicked;SetPointer(HourGlass!)

Int li_c
s_security_data lds_values
Transaction lt_dbTrans

li_c = 0
CONNECT USING SQLCA;
SELECT COUNT(user_id) INTO :li_c
FROM security_user
WHERE login_id = :sle_name.Text
USING SQLCA;

IF li_c = 0 THEN
	ii_times = ii_times + 1
	IF ii_times = 3 THEN 
		lds_values.who = sle_name.Text
		lds_values.security_level = -1
		CloseWithReturn(Parent, lds_values)
		RETURN -1
	ELSE
		MessageBox("Error", "Invalid username or password, " + String(3 - ii_times) + " try available.")
		Return 0
	END IF
ELSE
	
	lt_dbTrans = CREATE TRANSACTION
	lt_dbTrans.DBMS="O73 ORACLE v7.3"
	//lt_dbTrans.Database=""
	//lt_dbTrans.UserId=""
	//lt_dbTrans.DatabasePassword=""
	lt_dbTrans.ServerName="@db02_abc01"
	lt_dbTrans.LogId=sle_name.Text
	lt_dbTrans.LogPass=sle_pass.Text
	
	CONNECT USING lt_dbTrans;
	IF lt_dbTrans.SQLCode <> 0 THEN
		MessageBox("Error","Failed to connect to database!", StopSign!)
		DESTROY lt_dbTrans
		lds_values.who = sle_name.Text
		lds_values.security_level = -1
		CloseWithReturn(Parent, lds_values)	
		RETURN -1
	ELSE
		DISCONNECT USING lt_dbTrans;
		DESTROY lt_dbTrans
	END IF

	lds_values.who = sle_name.Text
	lds_values.security_level = f_user_app_security(is_app_name, sle_name.Text)
	lds_values.pass = sle_pass.Text
	CloseWithReturn(Parent, lds_values)	
END IF 



end event

type sle_name from u_sle within w_security_check
int X=461
int Y=86
int Width=1017
int Height=122
int TabOrder=10
int TextSize=-14
string FaceName="Arial"
end type

type sle_pass from u_sle within w_security_check
int X=461
int Y=250
int Width=1017
int Height=122
int TabOrder=20
boolean BringToTop=true
boolean PassWord=true
int TextSize=-14
string FaceName="Arial"
end type

type st_1 from statictext within w_security_check
int X=18
int Y=106
int Width=435
int Height=90
boolean Enabled=false
boolean BringToTop=true
string Text="UserName:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-14
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_security_check
int X=18
int Y=266
int Width=413
int Height=90
boolean Enabled=false
boolean BringToTop=true
string Text="Password:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-14
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from u_cb within w_security_check
event clicked pbm_bnclicked
int X=878
int Y=429
int TabOrder=40
string Text="&Cancel"
string FaceName="Arial"
end type

event clicked;SetPointer(HourGlass!)

Int li_level1, li_level2
s_security_data lds_values

lds_values.who = "Unknown"
lds_values.security_level = -1
CloseWithReturn(Parent, lds_values)	

end event

