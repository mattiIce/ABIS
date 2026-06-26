$PBExportHeader$w_user_profile.srw
$PBExportComments$<Popup>show and edit current user's profile, inherited from pfemain\w_popup.
forward
global type w_user_profile from w_popup
end type
type mle_profile from u_mle within w_user_profile
end type
type cb_save from u_cb within w_user_profile
end type
type cb_close from u_cb within w_user_profile
end type
end forward

global type w_user_profile from w_popup
integer x = 560
integer y = 282
integer width = 1807
integer height = 1254
string title = "User profile"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
mle_profile mle_profile
cb_save cb_save
cb_close cb_close
end type
global w_user_profile w_user_profile

on w_user_profile.create
int iCurrent
call super::create
this.mle_profile=create mle_profile
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_profile
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
end on

on w_user_profile.destroy
call super::destroy
destroy(this.mle_profile)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event open;call super::open;Int li_FileNum
String ls_text
Long ll_fl

ll_fl = FileLength(gs_ini_file)
IF (ll_fl = -1) OR IsNULL(ll_fl) THEN
	MessageBox("Error", "Failed to open INI file!")
	Close(this)
	RETURN -1
END IF
li_fileNum = FileOpen(gs_ini_file, StreamMode!)

IF ll_fl < 32767 THEN
	FileRead(li_FileNum, ls_text)
	mle_profile.Text = ls_text
END IF


end event

type mle_profile from u_mle within w_user_profile
integer x = 33
integer y = 16
integer width = 1719
integer height = 1024
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
end type

type cb_save from u_cb within w_user_profile
integer x = 282
integer y = 1050
integer width = 351
integer height = 93
integer taborder = 20
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

type cb_close from u_cb within w_user_profile
integer x = 1090
integer y = 1050
integer width = 351
integer height = 93
integer taborder = 2
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

