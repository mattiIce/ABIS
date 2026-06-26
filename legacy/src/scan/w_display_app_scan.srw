$PBExportHeader$w_display_app_scan.srw
$PBExportComments$display applications of this system used only in shop area
forward
global type w_display_app_scan from w_sheet
end type
type st_ab_job from statictext within w_display_app_scan
end type
type st_15 from statictext within w_display_app_scan
end type
type cbx_current_job from checkbox within w_display_app_scan
end type
type ole_scanfileview from olecustomcontrol within w_display_app_scan
end type
type cb_scan from commandbutton within w_display_app_scan
end type
type st_14 from statictext within w_display_app_scan
end type
type st_13 from statictext within w_display_app_scan
end type
type cb_confirm from commandbutton within w_display_app_scan
end type
type cb_reset from commandbutton within w_display_app_scan
end type
type st_12 from statictext within w_display_app_scan
end type
type st_11 from statictext within w_display_app_scan
end type
type st_10 from statictext within w_display_app_scan
end type
type st_6 from statictext within w_display_app_scan
end type
type st_9 from statictext within w_display_app_scan
end type
type st_8 from statictext within w_display_app_scan
end type
type st_7 from statictext within w_display_app_scan
end type
type cb_enter from commandbutton within w_display_app_scan
end type
type sle_job from singlelineedit within w_display_app_scan
end type
type st_5 from statictext within w_display_app_scan
end type
type cb_close from commandbutton within w_display_app_scan
end type
type cb_import from commandbutton within w_display_app_scan
end type
type cb_rename from commandbutton within w_display_app_scan
end type
type cb_delete from commandbutton within w_display_app_scan
end type
type st_4 from statictext within w_display_app_scan
end type
type dw_job from u_dw within w_display_app_scan
end type
type cb_select from commandbutton within w_display_app_scan
end type
type st_3 from statictext within w_display_app_scan
end type
type st_2 from statictext within w_display_app_scan
end type
type st_1 from statictext within w_display_app_scan
end type
type gb_1 from groupbox within w_display_app_scan
end type
end forward

global type w_display_app_scan from w_sheet
integer x = 399
integer y = 19
integer width = 3690
integer height = 2467
string title = "E-JobFolder Scan Station"
boolean minbox = false
boolean resizable = false
windowstate windowstate = maximized!
boolean toolbarvisible = false
event type string ue_whoami ( )
event type integer ue_refresh ( )
st_ab_job st_ab_job
st_15 st_15
cbx_current_job cbx_current_job
ole_scanfileview ole_scanfileview
cb_scan cb_scan
st_14 st_14
st_13 st_13
cb_confirm cb_confirm
cb_reset cb_reset
st_12 st_12
st_11 st_11
st_10 st_10
st_6 st_6
st_9 st_9
st_8 st_8
st_7 st_7
cb_enter cb_enter
sle_job sle_job
st_5 st_5
cb_close cb_close
cb_import cb_import
cb_rename cb_rename
cb_delete cb_delete
st_4 st_4
dw_job dw_job
cb_select cb_select
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_display_app_scan w_display_app_scan

type variables
Long il_job, il_line_num
String is_station, is_folder_base, is_local_folder_base
n_cst_filesrv inv_filesrv
end variables

event type string ue_whoami();Return "w_display_app_scan"
end event

event type integer ue_refresh();Long ll_current_job

if cbx_current_job.checked = true then
		select ab_job_num into :ll_current_job
		from line_current_status
		where line_num = :il_line_num
		using SQLCA;
		
		//check if there is current ab_job
		if isnull(ll_current_job) or ll_current_job = 0 then
			cbx_current_job.checked = false
			return 0
		end if
		
		if ll_current_job <> il_job then
			il_job = ll_current_job
			sle_job.text = String(il_job)
			cb_enter.event clicked()			
		end if		
end if



return 1
end event

on w_display_app_scan.create
int iCurrent
call super::create
this.st_ab_job=create st_ab_job
this.st_15=create st_15
this.cbx_current_job=create cbx_current_job
this.ole_scanfileview=create ole_scanfileview
this.cb_scan=create cb_scan
this.st_14=create st_14
this.st_13=create st_13
this.cb_confirm=create cb_confirm
this.cb_reset=create cb_reset
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_6=create st_6
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.cb_enter=create cb_enter
this.sle_job=create sle_job
this.st_5=create st_5
this.cb_close=create cb_close
this.cb_import=create cb_import
this.cb_rename=create cb_rename
this.cb_delete=create cb_delete
this.st_4=create st_4
this.dw_job=create dw_job
this.cb_select=create cb_select
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ab_job
this.Control[iCurrent+2]=this.st_15
this.Control[iCurrent+3]=this.cbx_current_job
this.Control[iCurrent+4]=this.ole_scanfileview
this.Control[iCurrent+5]=this.cb_scan
this.Control[iCurrent+6]=this.st_14
this.Control[iCurrent+7]=this.st_13
this.Control[iCurrent+8]=this.cb_confirm
this.Control[iCurrent+9]=this.cb_reset
this.Control[iCurrent+10]=this.st_12
this.Control[iCurrent+11]=this.st_11
this.Control[iCurrent+12]=this.st_10
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.st_9
this.Control[iCurrent+15]=this.st_8
this.Control[iCurrent+16]=this.st_7
this.Control[iCurrent+17]=this.cb_enter
this.Control[iCurrent+18]=this.sle_job
this.Control[iCurrent+19]=this.st_5
this.Control[iCurrent+20]=this.cb_close
this.Control[iCurrent+21]=this.cb_import
this.Control[iCurrent+22]=this.cb_rename
this.Control[iCurrent+23]=this.cb_delete
this.Control[iCurrent+24]=this.st_4
this.Control[iCurrent+25]=this.dw_job
this.Control[iCurrent+26]=this.cb_select
this.Control[iCurrent+27]=this.st_3
this.Control[iCurrent+28]=this.st_2
this.Control[iCurrent+29]=this.st_1
this.Control[iCurrent+30]=this.gb_1
end on

on w_display_app_scan.destroy
call super::destroy
destroy(this.st_ab_job)
destroy(this.st_15)
destroy(this.cbx_current_job)
destroy(this.ole_scanfileview)
destroy(this.cb_scan)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.cb_confirm)
destroy(this.cb_reset)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_6)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.cb_enter)
destroy(this.sle_job)
destroy(this.st_5)
destroy(this.cb_close)
destroy(this.cb_import)
destroy(this.cb_rename)
destroy(this.cb_delete)
destroy(this.st_4)
destroy(this.dw_job)
destroy(this.cb_select)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event close;call super::close;//f_display_app()
end event

event open;call super::open;F_SetFilesrv(inv_filesrv, TRUE)

dw_job.SetTransObject(SQLCA)
dw_job.Retrieve(il_job)

cb_rename.Enabled = false
cb_delete.Enabled = false
cb_import.Enabled = false

ole_scanfileview.object.ViewStyle = 4


end event

event pfc_preopen;call super::pfc_preopen;is_station = ProfileString(gs_ini_file, "SCAN","STATION","BL110")
is_folder_base = ProfileString(gs_ini_file, "SCAN","FOLDER_BASE","\\albl-pdc\ejobfolder$")
is_local_folder_base = ProfileString(gs_ini_file, "SCAN","LOCAL_FOLDER_BASE","C:\scanner")
il_line_num = ProfileInt(gs_ini_file, "SCAN","LINE_NUM",6)

if NOT DirectoryExists(is_local_folder_base) then	
	CreateDirectory(is_local_folder_base )
end if

if NOT DirectoryExists(is_local_folder_base + "\scan") then		//directory to hold scanned files
	CreateDirectory(is_local_folder_base + "\scan")
end if

if NOT DirectoryExists(is_local_folder_base + "\temp") then		//directory to temporarily hold previously left-over files
	CreateDirectory(is_local_folder_base + "\temp")
end if

//check if it can connect to EJob folder base directory
if NOT DirectoryExists(is_folder_base) then
	MessageBox("Connection Error", "Error in connecting to job folder, please check network connection.")
end if

this.Title = "E-JobFolder Scan Station " + is_station
//ole_scanfileview.object.CurrentFolder = is_folder_base  + "\scan" + is_station
ole_scanfileview.object.CurrentFolder = is_local_folder_base + "\scan"

Run("cmd /c move " + is_local_folder_base + "\scan" + "\*.* " + is_local_folder_base + "\temp", Minimized!)

cbx_current_job.checked = false

Timer(60, this)


end event

event timer;call super::timer;this.event ue_refresh()
end event

type st_ab_job from statictext within w_display_app_scan
integer x = 1803
integer y = 19
integer width = 538
integer height = 141
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_15 from statictext within w_display_app_scan
integer x = 1317
integer y = 42
integer width = 468
integer height = 118
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "AB JOB: "
boolean focusrectangle = false
end type

type cbx_current_job from checkbox within w_display_app_scan
boolean visible = false
integer x = 1404
integer y = 61
integer width = 903
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Currently processed AB Job"
end type

event clicked;Int li_rc

if this.checked = true then
	li_rc = MessageBox("AB Job", "Scan file(s) for currently processed AB Job?", Question!, YesNo!)
	if li_rc = 1 then
		select ab_job_num into :il_job
		from line_current_status
		where line_num = :il_line_num
		using SQLCA;
		
		//check if there is current ab_job
		if isnull(il_job) or il_job = 0 then
			MessageBox("AB Job", "There is not currently processed AB Job.")
			this.checked = false
			return 0
		end if
		sle_job.text = String(il_job)
		cb_enter.event clicked()
		cb_select.Enabled = false
		cb_enter.Enabled = false
		sle_job.Enabled = false
		cb_confirm.Enabled = false
		cb_rename.Enabled = true
		cb_delete.Enabled = true
		cb_import.Enabled = true	
	else
		this.checked = false
		return 0
	end if
else	
	li_rc = MessageBox("AB Job", "Scan file(s) for another AB Job?", Question!, YesNo!)
	if li_rc = 1 then
		il_job = 0
		dw_job.reset()
		Run("cmd /c del " + is_local_folder_base + "\scan" + "\*.* /Q", Minimized!)
		cb_select.Enabled = true
		cb_enter.Enabled = true
		sle_job.Enabled = true
		cb_confirm.Enabled = true
		cb_rename.Enabled = false
		cb_delete.Enabled = false
		cb_import.Enabled = false
		sle_job.text = ""		
	else
		this.checked = true
		return 0
	end if
end if

return 1
end event

type ole_scanfileview from olecustomcontrol within w_display_app_scan
event onitemclick ( oleobject item,  long ocx_x,  long ocx_y )
event onitemdblclick ( oleobject item,  long ocx_x,  long ocx_y,  boolean cancel_ )
event oncurrentfolderchanged ( string newfolder )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event onitemrightclick ( oleobject item )
event oncontextmenuhint ( string hint )
event click ( )
event dblclick ( )
event onitemcheck ( oleobject item,  boolean checkstate,  boolean cancel_ )
event onbeginitemrename ( oleobject item,  boolean cancel_ )
event onenditemrename ( oleobject item,  string newname,  boolean cancel_ )
event onbeforeselectionchange ( oleobject item,  boolean selecting,  boolean cancel_ )
event onafterselectionchange ( oleobject item,  boolean selectionstate )
event onbeforecolumnadd ( string name,  boolean add )
event onafteritemadd ( oleobject item )
event onbeforeitemdelete ( oleobject item )
event oncustomcontextmenuitemselect ( oleobject item,  long cmdid )
event oncustomcontextmenuitemadd ( oleobject item )
event onbackgroundrightclicked ( long ocx_x,  long ocx_y )
event onbeforefill ( )
event onafterfill ( )
event onbeforecolumnsort ( string columnname,  long columnindex,  integer sortmethod )
event oncompareitems ( oleobject item1,  oleobject item2,  long comparison )
event onbeforeshellcommandexecute ( string commandstr,  boolean cancel_,  integer command )
event onoledragover ( oleobject data,  integer effect,  integer button,  integer shift,  real ocx_x,  real ocx_y,  long state,  oleobject item )
event ongetinfotip ( oleobject item,  string infotip )
event onolestartdrag ( oleobject data,  integer effects,  integer button,  boolean cancel_ )
event onoledragdrop ( oleobject data,  integer effect,  integer button,  integer shift,  real ocx_x,  real ocx_y,  oleobject item,  boolean dodefaultshelldropaction )
event oncustomcontextmenuitemselect2 ( oleobject item,  string caption,  long cmdid )
event oncontextmenupopup ( oleobject shellmenu,  boolean backgroundmenu,  boolean cancel_ )
event onheaderrightclick ( long headerareas,  long columnindex,  long ocx_x,  long ocx_y )
event initialize ( string path,  double pidl )
event ongetitemthumbnail ( oleobject item,  long iconindex,  boolean showdefault )
event onitemdraw ( oleobject e )
integer x = 99
integer y = 1405
integer width = 1317
integer height = 768
integer taborder = 100
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_display_app_scan.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_scan from commandbutton within w_display_app_scan
boolean visible = false
integer x = 1551
integer y = 947
integer width = 468
integer height = 102
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Scan"
end type

event clicked;Run("cmd /c ~"C:\Program Files\Common Files\Microsoft Shared\MODI\11.0\MSPSCAN.EXE~" Test", Minimized!)

end event

type st_14 from statictext within w_display_app_scan
integer x = 307
integer y = 234
integer width = 263
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "AB Job# "
boolean focusrectangle = false
end type

type st_13 from statictext within w_display_app_scan
integer x = 307
integer y = 925
integer width = 146
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Click "
boolean focusrectangle = false
end type

type cb_confirm from commandbutton within w_display_app_scan
integer x = 483
integer y = 899
integer width = 468
integer height = 102
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Con&firm"
end type

event clicked;Long ll_rc

if il_job = 0 or IsNull(il_job) then
	MessageBox("Invalid AB Job#", "AB Job# is invalid, please select a valid AB Job#.")
else
	ll_rc = MessageBox("AB Job# Confirmation", "Please confirm AB Job# is " + String(il_job), Question!, YesNo!)
	if ll_rc = 1 then
		cb_select.Enabled = false
		cb_enter.Enabled = false
		sle_job.Enabled = false
		cb_rename.Enabled = true
		cb_delete.Enabled = true
		cb_import.Enabled = true
	end if
end if


end event

type cb_reset from commandbutton within w_display_app_scan
integer x = 2417
integer y = 2192
integer width = 468
integer height = 102
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rese&t"
end type

event clicked;Int li_rc

li_rc = MessageBox("Reset", "Do you want to reset AB Job# and remove all the scanned files?", Question!, YesNo!)
if li_rc = 1 then
	il_job = 0
	dw_job.reset()
	Run("cmd /c del " + is_local_folder_base + "\scan" + "\*.* /Q", Minimized!)
	cb_select.Enabled = true
	cb_enter.Enabled = true
	sle_job.Enabled = true
	cb_rename.Enabled = false
	cb_delete.Enabled = false
	cb_import.Enabled = false
	sle_job.text = ""
	st_ab_job.text = ""
else
	return	0
end if

end event

type st_12 from statictext within w_display_app_scan
integer x = 77
integer y = 2115
integer width = 234
integer height = 102
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 4:"
boolean focusrectangle = false
end type

type st_11 from statictext within w_display_app_scan
integer x = 73
integer y = 1130
integer width = 234
integer height = 102
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 3:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_display_app_scan
integer x = 73
integer y = 925
integer width = 234
integer height = 102
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 2:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_display_app_scan
integer x = 73
integer y = 234
integer width = 234
integer height = 102
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 1:"
boolean focusrectangle = false
end type

type st_9 from statictext within w_display_app_scan
integer x = 984
integer y = 2115
integer width = 1148
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " to save scanned file(s) into job folder."
boolean focusrectangle = false
end type

type st_8 from statictext within w_display_app_scan
integer x = 311
integer y = 2115
integer width = 176
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Click"
boolean focusrectangle = false
end type

type st_7 from statictext within w_display_app_scan
integer x = 2238
integer y = 234
integer width = 713
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "to start selecting AB Job#."
boolean focusrectangle = false
end type

type cb_enter from commandbutton within w_display_app_scan
integer x = 1009
integer y = 208
integer width = 468
integer height = 102
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Enter"
boolean default = true
end type

event clicked;Long ll_job
Int li_order_match

ll_job = Long(sle_job.Text)
li_order_match = 0
SELECT COUNT(ab_job_num) INTO :li_order_match
FROM ab_job
WHERE ab_job_num = :ll_job
USING SQLCA;

IF li_order_match <= 0 THEN
	MessageBox("Error: AB Job no found", "Please input a valid AB Job number", StopSign!)
	Return 
END IF

il_job = ll_job
dw_job.Retrieve(il_job)
st_ab_job.text = string(il_job)

end event

type sle_job from singlelineedit within w_display_app_scan
integer x = 571
integer y = 208
integer width = 380
integer height = 102
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_display_app_scan
integer x = 73
integer y = 1283
integer width = 658
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scanned File(s) List"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_display_app_scan
integer x = 3120
integer y = 2192
integer width = 468
integer height = 102
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Run("cmd /c move " + is_local_folder_base + "\temp" + "\*.* " + is_local_folder_base + "\scan", Minimized!)

CLOSE(PARENT)
end event

type cb_import from commandbutton within w_display_app_scan
integer x = 486
integer y = 2090
integer width = 468
integer height = 102
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Import"
end type

event clicked;Int li_rc
Long ll_job_status
DateTime ldt_time_date_finished
String ls_job_status, ls_message

if il_job = 0 or IsNull(il_job) then
	MessageBox("Invalid AB Job#", "AB Job# is invalid, please select a valid AB Job#.")
	return 0
end if


li_rc = MessageBox("Confirmation", "Do you want to save all scanned file(s) into folder of AB Job# " + String(il_job) + "?", question!, YesNo!)
if li_rc = 2 then
	return 0
end if

//check if it can connect to EJob folder base directory
if NOT DirectoryExists(is_folder_base) then
	MessageBox("Connection Error", "Error in connecting to job folder, please check network connection.")
	return 0
end if


//If the Job folder exist?
if NOT DirectoryExists(is_folder_base + "\" + String(il_job)) then
	select job_status , time_date_finished into :ll_job_status, :ldt_time_date_finished
	from ab_job 
	where ab_job_num = :il_job
	using SQLCA;
	
	choose case ll_job_status
	case 0
		li_rc = MessageBox("Warning", "Job folder for AB Job# " + String(il_job) + " does not exist. The job was done at " + String(ldt_time_date_finished) + ". Do you want to continue?", Question!, YesNo! )
		if li_rc = 2 then
			return 0 
		end if
	case else
		choose case ll_job_status
			case 1	
				ls_job_status = "InProcess"
			case 2	
				ls_job_status = "New"
			case 3	
				ls_job_status = "Canceled"
			case 4	
				ls_job_status = "OnHold"			
		end choose
		li_rc = MessageBox("Warning", "Job folder for AB Job# " + String(il_job) + " does not exist. The job status is ~"" + ls_job_status + "~". Do you want to continue?", Question!, YesNo! )
		if li_rc = 2 then
			return 0 
		end if
	end choose
end if

inv_filesrv.of_CreateDirectory(is_folder_base + "\" + String(il_job))

//Run("cmd /c copy " + is_local_folder_base + "\scan\SC_????.jpg " + is_local_folder_base + "\scan\SC_????_" + String(Today(), "yymmdd") + String(Now(), "hhmm")  + ".jpg", Minimized!)
//Run("cmd /c del " + is_local_folder_base + "\scan\SC_????.jpg", Minimized!)
//
//Run("cmd /c move " + is_local_folder_base + "\scan\*.* " + is_folder_base + "\" + String(il_job), Minimized!)

Run("cmd /c copy " + is_local_folder_base + "\scan\SC_????.jpg " + is_local_folder_base + "\scan\SC_????_" + String(Today(), "yymmdd") + String(Now(), "hhmm")  + ".jpg & del " + is_local_folder_base + "\scan\SC_????.jpg & move " + is_local_folder_base + "\scan\*.* " + is_folder_base + "\" + String(il_job), Minimized!)

MessageBox("File(s) Saved", "All scanned file(s) have been saved.")

//log table
//ls_message = "EJobFolder: Scanned at Station# " + is_station + " for AB Job# " + String(il_job) + "."
//f_add_system_log(ls_message)
Long ll_scan_id
ll_scan_id = f_get_next_value("scan_log_seq")
DateTime ldt_scan_datetime
ldt_scan_datetime = datetime(Today(),Now())

INSERT INTO "SCAN_LOG" ( "SCAN_ID", "SCAN_DATETIME", "AB_JOB_NUM", "SCAN_STATION")  
VALUES ( :ll_scan_id, :ldt_scan_datetime, :il_job, :is_station) 
USING SQLCA;

COMMIT USING SQLCA;

return 1

end event

type cb_rename from commandbutton within w_display_app_scan
integer x = 3131
integer y = 1555
integer width = 468
integer height = 102
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Rename"
end type

event clicked;ole_scanfileview.object.ExeCmdForAllSelected(10)
end event

type cb_delete from commandbutton within w_display_app_scan
integer x = 3127
integer y = 1805
integer width = 468
integer height = 102
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;ole_scanfileview.object.ExeCmdForAllSelected(6)
end event

type st_4 from statictext within w_display_app_scan
integer x = 73
integer y = 387
integer width = 658
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selected AB Job Details"
boolean focusrectangle = false
end type

type dw_job from u_dw within w_display_app_scan
integer x = 73
integer y = 464
integer width = 3522
integer height = 333
integer taborder = 20
string dataobject = "d_product_order_detail_scan"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type cb_select from commandbutton within w_display_app_scan
integer x = 1741
integer y = 208
integer width = 468
integer height = 102
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S&elect"
end type

event clicked;Long ll_rc

Open(w_ab_job_list_scan)

ll_rc = Message.DoubleParm
if (Not IsNull(ll_rc)) and ll_rc <> 0 then
	il_job = ll_rc
	dw_job.Retrieve(il_job)
	sle_job.text = String(il_job)
	st_ab_job.text = string(il_job)
end if








end event

type st_3 from statictext within w_display_app_scan
integer x = 307
integer y = 1130
integer width = 1317
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use buttons below to manage scanned file(s)."
boolean focusrectangle = false
end type

type st_2 from statictext within w_display_app_scan
integer x = 980
integer y = 925
integer width = 1477
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " to confirm AB Job#, then start scanning file(s)."
boolean focusrectangle = false
end type

type st_1 from statictext within w_display_app_scan
integer x = 1507
integer y = 234
integer width = 227
integer height = 102
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "or click "
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_display_app_scan
integer x = 73
integer y = 1354
integer width = 3599
integer height = 704
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
07w_display_app_scan.bin 3992 
2000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000063b6e4d001d1b78c00000003000001000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036ae24111457f8113326c50a0ba095eed0000000063b6e4d001d1b78c63b6e4d001d1b78c000000000000000000000000004f00010065006c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000102000affffffff00000004ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000001400000000fffffffe0000000200000003fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff02000001000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000042e4000010350000004000000001000400000101000001010101ffffff010000000001010000002f0101001400004fe0501f3aea20d0d8a21069302b000800199d305c3a432f00000000000000000000000000000000000000002a03010002012a2e0000040003000100910be3529d11ce8f00aa00e30151b84b9000000001d4c001654804000000766c00010000000000020000000100000000ffffff00000000ff00000000010100000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17w_display_app_scan.bin 3992 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
