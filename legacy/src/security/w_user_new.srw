$PBExportHeader$w_user_new.srw
$PBExportComments$<Sheet>New user information window inherited from pfemain/w_sheet
forward
global type w_user_new from w_sheet
end type
type st_1 from u_st within w_user_new
end type
type st_first from u_st within w_user_new
end type
type st_3 from u_st within w_user_new
end type
type st_4 from u_st within w_user_new
end type
type st_5 from u_st within w_user_new
end type
type sle_desc from u_sle within w_user_new
end type
type sle_p from u_sle within w_user_new
end type
type sle_cp from u_sle within w_user_new
end type
type cb_cancel from u_cb within w_user_new
end type
type cb_save from u_cb within w_user_new
end type
type sle_loginid from u_sle within w_user_new
end type
type sle_firstname from u_sle within w_user_new
end type
type sle_lastname from u_sle within w_user_new
end type
type st_last from u_st within w_user_new
end type
type st_middle from u_st within w_user_new
end type
type sle_middle from u_sle within w_user_new
end type
type st_2 from u_st within w_user_new
end type
type em_userid from u_em within w_user_new
end type
end forward

global type w_user_new from w_sheet
int X=508
int Y=301
int Width=1829
int Height=646
WindowType WindowType=response!
boolean TitleBar=true
string Title="Add New User"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
st_1 st_1
st_first st_first
st_3 st_3
st_4 st_4
st_5 st_5
sle_desc sle_desc
sle_p sle_p
sle_cp sle_cp
cb_cancel cb_cancel
cb_save cb_save
sle_loginid sle_loginid
sle_firstname sle_firstname
sle_lastname sle_lastname
st_last st_last
st_middle st_middle
sle_middle sle_middle
st_2 st_2
em_userid em_userid
end type
global w_user_new w_user_new

type variables


end variables

forward prototypes
public function integer wf_check_values ()
end prototypes

event ue_whoami;RETURN "w_user_new"
end event

public function integer wf_check_values ();Int li_id, li_c

IF Len(em_userid.Text) < 1 THEN
	MessageBox("Error","No user id entered!", StopSign!)
	RETURN -3
END IF

li_c = 0
li_id = Integer(em_userid.Text)
CONNECT USING SQLCA;
SELECT Count(user_id) INTO :li_c
FROM security_user
WHERE user_id = :li_id
USING SQLCA;
IF li_c > 0 THEN 
	MessageBox("Error","Duplicated user id!", StopSign!)
	RETURN -1
END IF

li_c = 0
CONNECT USING SQLCA;
SELECT Count(user_id) INTO :li_c
FROM security_user
WHERE login_id = :sle_loginid.Text
USING SQLCA;
IF li_c > 0 THEN 
	MessageBox("Error","Duplicated user login name!", StopSign!)
	RETURN -2
END IF

IF Len(sle_lastname.Text) < 1 AND Len(sle_firstname.Text) < 1 THEN
	MessageBox("Error","No user name entered!", StopSign!)
	RETURN -3
END IF
	
IF Len(sle_p.Text) < 1 THEN
	MessageBox("Error","No user password entered!", StopSign!)
	RETURN -4
END IF
IF sle_p.Text <> sle_cp.Text THEN
	MessageBox("Error","Failed to verify user's password!", StopSign!)
	RETURN -5
END IF


RETURN 1
end function

on w_user_new.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_first=create st_first
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.sle_desc=create sle_desc
this.sle_p=create sle_p
this.sle_cp=create sle_cp
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.sle_loginid=create sle_loginid
this.sle_firstname=create sle_firstname
this.sle_lastname=create sle_lastname
this.st_last=create st_last
this.st_middle=create st_middle
this.sle_middle=create sle_middle
this.st_2=create st_2
this.em_userid=create em_userid
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_first
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.sle_desc
this.Control[iCurrent+7]=this.sle_p
this.Control[iCurrent+8]=this.sle_cp
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.sle_loginid
this.Control[iCurrent+12]=this.sle_firstname
this.Control[iCurrent+13]=this.sle_lastname
this.Control[iCurrent+14]=this.st_last
this.Control[iCurrent+15]=this.st_middle
this.Control[iCurrent+16]=this.sle_middle
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.em_userid
end on

on w_user_new.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_first)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_desc)
destroy(this.sle_p)
destroy(this.sle_cp)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.sle_loginid)
destroy(this.sle_firstname)
destroy(this.sle_lastname)
destroy(this.st_last)
destroy(this.st_middle)
destroy(this.sle_middle)
destroy(this.st_2)
destroy(this.em_userid)
end on

event open;call super::open;em_userid.Text = String(Message.DoubleParm)
end event

type st_1 from u_st within w_user_new
int X=84
int Y=29
int Width=205
string Text="User ID:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_first from u_st within w_user_new
int X=84
int Y=112
int Width=285
boolean BringToTop=true
string Text="First Name:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_3 from u_st within w_user_new
int X=84
int Y=461
int Width=307
boolean BringToTop=true
string Text="Description:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_4 from u_st within w_user_new
int X=84
int Y=288
int Width=315
boolean BringToTop=true
string Text="Password:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_5 from u_st within w_user_new
int X=84
int Y=374
int Width=325
int Height=67
boolean BringToTop=true
string Text="Confirm Pwd:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type sle_desc from u_sle within w_user_new
int X=410
int Y=454
int Width=965
int TabOrder=70
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type sle_p from u_sle within w_user_new
int X=410
int Y=282
int Width=965
int TabOrder=50
boolean BringToTop=true
boolean PassWord=true
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event constructor;call super::constructor;this.ib_autoselect = true
end event

type sle_cp from u_sle within w_user_new
int X=410
int Y=368
int Width=965
int TabOrder=60
boolean BringToTop=true
boolean PassWord=true
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event constructor;call super::constructor;this.ib_autoselect = true
end event

type cb_cancel from u_cb within w_user_new
int X=1437
int Y=154
int Width=325
int TabOrder=90
string Text="&Cancel"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_save from u_cb within w_user_new
event clicked pbm_bnclicked
int X=1434
int Y=29
int Width=325
int TabOrder=80
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;IF wf_check_values() < 1 THEN RETURN

Date ld_1, ld_2

SetNULL(ld_1)
ld_2 = Today()
IF f_add_user(sle_loginid.Text, sle_p.Text) > 0 THEN
	CONNECT USING SQLCA;
	INSERT INTO security_user
	VALUES (:em_userid.Text, :sle_loginid.Text, :sle_lastname.Text,:sle_firstname.Text, :sle_middle.Text, :ld_1, :ld_2, 1, :sle_desc.Text) 
	USING SQLCA;
	COMMIT USING SQLCA;
END IF

CloseWithReturn(Parent, 99999999)
end event

type sle_loginid from u_sle within w_user_new
int X=753
int Y=22
int Width=622
int TabOrder=10
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type sle_firstname from u_sle within w_user_new
int X=410
int Y=109
int Width=490
int TabOrder=20
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type sle_lastname from u_sle within w_user_new
int X=410
int Y=195
int Width=965
int TabOrder=40
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_last from u_st within w_user_new
int X=84
int Y=202
int Width=285
boolean BringToTop=true
string Text="Last Name:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type st_middle from u_st within w_user_new
int X=911
int Y=118
int Width=260
boolean BringToTop=true
string Text="Mid Initial:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type sle_middle from u_sle within w_user_new
int X=1174
int Y=109
int Width=201
int TabOrder=30
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_2 from u_st within w_user_new
int X=534
int Y=29
int Width=219
string Text="Login ID:"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type em_userid from u_em within w_user_new
int X=289
int Y=19
int TabOrder=0
boolean BringToTop=true
Alignment Alignment=Center!
string Mask="####"
double Increment=0
string MinMax=""
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

