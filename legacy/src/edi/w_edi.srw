$PBExportHeader$w_edi.srw
$PBExportComments$EDI main windows
forward
global type w_edi from w_sheet
end type
type tv_costomer_edi from u_tv within w_edi
end type
type dw_edi_customer_info from u_dw within w_edi
end type
type dw_customer_edi_list from u_dw within w_edi
end type
type em_calendar from u_em within w_edi
end type
type uo_calendar_1 from u_calendar within w_edi
end type
type tab_log_schedule from tab within w_edi
end type
type tabpage_edilog from userobject within tab_log_schedule
end type
type dw_edi_log from u_dw within tabpage_edilog
end type
type cb_print from u_cb within tabpage_edilog
end type
type cb_openfile from u_cb within tabpage_edilog
end type
type cb_refresh from u_cb within tabpage_edilog
end type
type cb_closeall from u_cb within tabpage_edilog
end type
type tabpage_edilog from userobject within tab_log_schedule
dw_edi_log dw_edi_log
cb_print cb_print
cb_openfile cb_openfile
cb_refresh cb_refresh
cb_closeall cb_closeall
end type
type tab_log_schedule from tab within w_edi
tabpage_edilog tabpage_edilog
end type
type cb_alcan_870 from u_cb within w_edi
end type
type st_1 from statictext within w_edi
end type
type cb_alcan_863 from u_cb within w_edi
end type
type cb_close from u_cb within w_edi
end type
end forward

global type w_edi from w_sheet
integer x = 113
integer y = 128
integer width = 2853
integer height = 2003
string title = "EDI"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event edi_log_refresh ( )
event type string ue_whoami ( )
tv_costomer_edi tv_costomer_edi
dw_edi_customer_info dw_edi_customer_info
dw_customer_edi_list dw_customer_edi_list
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
tab_log_schedule tab_log_schedule
cb_alcan_870 cb_alcan_870
st_1 st_1
cb_alcan_863 cb_alcan_863
cb_close cb_close
end type
global w_edi w_edi

type variables
Int ii_refresh_flag =0   //1: can trigger "refresh_edi_log"
end variables

event edi_log_refresh;
//Refresh EDI LOG 
Date ld_date
int li_customer_id
string ls_customer_edi_name

ld_date = date(em_calendar.text)

If IsValid(dw_edi_customer_info) and NOT ISNULL(dw_edi_customer_info)  then	
li_customer_id = dw_edi_customer_info.GetItemNumber&
                  (dw_edi_customer_info.GetRow(), "customer_id")
else
		return
End If						

if IsValid(dw_customer_edi_list) and NOT ISNULL(dw_customer_edi_list)then
ls_customer_edi_name = dw_customer_edi_list.GetItemString&
                 (dw_customer_edi_list.GetRow(), "customer_edi_name")
else
	   return
end if						

if not ISNULL(li_customer_id) and not ISNULL(ls_customer_edi_name) then
     tab_log_schedule.tabpage_edilog.dw_edi_log.retrieve&
                   (li_customer_id,ls_customer_edi_name, ld_date)
end if




end event

event ue_whoami;return "w_edi"
end event

on w_edi.create
int iCurrent
call super::create
this.tv_costomer_edi=create tv_costomer_edi
this.dw_edi_customer_info=create dw_edi_customer_info
this.dw_customer_edi_list=create dw_customer_edi_list
this.em_calendar=create em_calendar
this.uo_calendar_1=create uo_calendar_1
this.tab_log_schedule=create tab_log_schedule
this.cb_alcan_870=create cb_alcan_870
this.st_1=create st_1
this.cb_alcan_863=create cb_alcan_863
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_costomer_edi
this.Control[iCurrent+2]=this.dw_edi_customer_info
this.Control[iCurrent+3]=this.dw_customer_edi_list
this.Control[iCurrent+4]=this.em_calendar
this.Control[iCurrent+5]=this.uo_calendar_1
this.Control[iCurrent+6]=this.tab_log_schedule
this.Control[iCurrent+7]=this.cb_alcan_870
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_alcan_863
this.Control[iCurrent+10]=this.cb_close
end on

on w_edi.destroy
call super::destroy
destroy(this.tv_costomer_edi)
destroy(this.dw_edi_customer_info)
destroy(this.dw_customer_edi_list)
destroy(this.em_calendar)
destroy(this.uo_calendar_1)
destroy(this.tab_log_schedule)
destroy(this.cb_alcan_870)
destroy(this.st_1)
destroy(this.cb_alcan_863)
destroy(this.cb_close)
end on

event open;call super::open;
//Initiate TreeView tv_costomer_edi
tv_costomer_edi.of_SetDataSource(1,"d_edi_customer_list", SQLCA, &
                "customer_short_name", "", FALSE, 1,2)
tv_costomer_edi.of_SetDataSource(2,"d_customer_edi_list", SQLCA, &
                "customer_edi_name", ":parent.1.customer_id", FALSE, 3,3)
tv_costomer_edi.of_InitialRetrieve()


dw_edi_customer_info.SetTransObject(SQLCA)
//dw_edi_customer_info.retrieve(1000)
dw_edi_customer_info.InsertRow(0)

dw_customer_edi_list.SetTransObject(SQLCA)
//dw_customer_edi_list.retrieve(9999, "nothing")
dw_customer_edi_list.InsertRow(0)

tab_log_schedule.tabpage_edilog.dw_edi_log.SetTransObject(SQLCA)
//tab_log_schedule.tabpage_edilog.dw_edi_log.retrieve(99999, "nothing", date("8/8/88"))

em_calendar.Text =  String(Today(), "mm/dd/yyyy")
ii_refresh_flag = 1


end event

event closequery;call super::closequery;ii_refresh_flag = 0  //prevent from triggering "refresh_edi_log"
end event

event close;call super::close;f_display_app()
end event

type tv_costomer_edi from u_tv within w_edi
integer x = 18
integer y = 22
integer width = 666
integer height = 1485
integer taborder = 80
long backcolor = 1090519039
string picturename[] = {"Custom039!","Custom050!","Form!"}
string statepicturename[] = {"Custom050!"}
integer statepicturewidth = 32
integer statepictureheight = 32
long statepicturemaskcolor = 553648127
end type

event selectionchanged;call super::selectionchanged;Long ll_current, ll_return, ll_row
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.of_GetDataStore(ltvi_item.level, lds_datastore)
ll_return = this.of_GetDataRow(ll_current, lds_datastore,ll_row)

if ltvi_item.level =1 then
 dw_edi_customer_info.Retrieve(lds_datastore.GetItemNumber(ll_row,"customer_id"))
else
 dw_edi_customer_info.Retrieve(lds_datastore.GetItemNumber(ll_row,"customer_id"))
 
 dw_customer_edi_list.Retrieve&
  (lds_datastore.GetItemNumber(ll_row,"customer_id"), &
  lds_datastore.GetItemString(ll_row,"customer_edi_name"))
 

//Refresh EDI Log	
Parent.TriggerEvent("edi_log_refresh")

end if


end event

event clicked;call super::clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;//Triggerevent ("sectionchanged")
end event

type dw_edi_customer_info from u_dw within w_edi
integer x = 688
integer y = 51
integer width = 1357
integer height = 266
integer taborder = 70
string dataobject = "d_customer_edi_info"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event rbuttondown;//override Ancestor script

end event

event rbuttonup;//override ancestor script
//read only
end event

type dw_customer_edi_list from u_dw within w_edi
integer x = 695
integer y = 336
integer width = 1349
integer height = 352
integer taborder = 50
string dataobject = "d_customer_edi_list_where"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event rbuttondown;//override
end event

event rbuttonup;//override
end event

type em_calendar from u_em within w_edi
boolean visible = false
integer x = 1401
integer y = 1443
integer width = 644
integer height = 67
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
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


//this.iuo_calendar.of_SetCloseonClick(TRUE)
int li_r
li_r = uo_calendar_1.of_SetRequestor(this)
end event

event modified;//MessageBox("Greeting", "Hello User")
//Parent.TriggerEvent("edi_log_refresh")
end event

event other;if ii_refresh_flag = 1 then
	Parent.TriggerEvent("edi_log_refresh")
end if
end event

type uo_calendar_1 from u_calendar within w_edi
integer x = 2077
integer y = 29
integer taborder = 10
boolean bringtotop = true
long backcolor = 79741120
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type tab_log_schedule from tab within w_edi
event edi_log_refresh ( )
integer x = 713
integer y = 720
integer width = 2070
integer height = 790
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
boolean powertips = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_edilog tabpage_edilog
end type

event edi_log_refresh;parent.TriggerEvent("edi_log_refresh")
end event

on tab_log_schedule.create
this.tabpage_edilog=create tabpage_edilog
this.Control[]={this.tabpage_edilog}
end on

on tab_log_schedule.destroy
destroy(this.tabpage_edilog)
end on

type tabpage_edilog from userobject within tab_log_schedule
integer x = 15
integer y = 90
integer width = 2041
integer height = 688
long backcolor = 12632256
string text = "   EDI Log   "
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Paste!"
long picturemaskcolor = 553648127
dw_edi_log dw_edi_log
cb_print cb_print
cb_openfile cb_openfile
cb_refresh cb_refresh
cb_closeall cb_closeall
end type

on tabpage_edilog.create
this.dw_edi_log=create dw_edi_log
this.cb_print=create cb_print
this.cb_openfile=create cb_openfile
this.cb_refresh=create cb_refresh
this.cb_closeall=create cb_closeall
this.Control[]={this.dw_edi_log,&
this.cb_print,&
this.cb_openfile,&
this.cb_refresh,&
this.cb_closeall}
end on

on tabpage_edilog.destroy
destroy(this.dw_edi_log)
destroy(this.cb_print)
destroy(this.cb_openfile)
destroy(this.cb_refresh)
destroy(this.cb_closeall)
end on

type dw_edi_log from u_dw within tabpage_edilog
integer x = 11
integer y = 3
integer width = 2004
integer height = 557
integer taborder = 10
string dataobject = "d_edi_log"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;//this.SetRowFocusIndicator(Hand!) 
this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 
end event

type cb_print from u_cb within tabpage_edilog
integer x = 600
integer y = 592
integer width = 351
integer height = 77
integer taborder = 11
boolean bringtotop = true
string text = "Print ..."
end type

event clicked;tab_log_schedule.tabpage_edilog.dw_edi_log.Event pfc_print()
end event

type cb_openfile from u_cb within tabpage_edilog
integer x = 48
integer y = 592
integer width = 351
integer height = 77
integer taborder = 21
boolean bringtotop = true
string text = "Open Archive"
end type

event clicked;long  ll_file_id = 0
string ls_edi_path_name, ls_edi_file_name, ls_edi_path_file_name
boolean lb_exist
int li_row

li_row = dw_edi_log.GetRow()
if li_row = 0 or li_row = -1 or ISNULL(li_row) then
	return -1
end if

ll_file_id = dw_edi_log.GetItemNumber(li_row, "edi_file_id")


if not ISNULL(ll_file_id) or ll_file_id <> 0 THEN
	
 SELECT edi_file_archive_path, edi_file_name
	INTO :ls_edi_path_name, :ls_edi_file_name
	FROM edi_out_file
	WHERE edi_out_id = :ll_file_id
	USING SQLCA;

if ISNULL(ls_edi_path_name) or ISNULL(ls_edi_file_name) then
	return -1
end if

ls_edi_path_file_name = ls_edi_path_name +"\"+ ls_edi_file_name
if ls_edi_path_file_name = "\" then return -1

lb_exist = FileExists(ls_edi_path_file_name)

 IF lb_exist  THEN
   OpenWithParm(w_display_edi_file, ls_edi_path_file_name)
 ELSE
 MessageBox("Open File", "File: " + ls_edi_path_file_name + " not found.")
 END IF

End If

 



end event

type cb_refresh from u_cb within tabpage_edilog
integer x = 1152
integer y = 592
integer width = 322
integer height = 80
integer taborder = 11
boolean bringtotop = true
string text = "Refresh"
end type

event clicked;//w_edi.TriggerEvent("edi_log_refresh")
parent.TriggerEvent("edi_log_refresh")
end event

type cb_closeall from u_cb within tabpage_edilog
integer x = 1675
integer y = 592
integer width = 322
integer height = 80
integer taborder = 11
boolean bringtotop = true
string text = "Close"
end type

event clicked;close(Getparent(parent.Getparent()))
end event

type cb_alcan_870 from u_cb within w_edi
integer x = 55
integer y = 1581
integer width = 512
integer height = 106
integer taborder = 30
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Send Alcan 870"
end type

event clicked;SetPointer(HourGlass!)

Int li_return 
//Manually send EDI 870 to Alan, added by Bing on Jan 16 2001
transaction dboconnect
dboconnect = create transaction
dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
dboconnect.LogID = gs_LogID
dboconnect.LogPass = gs_LogPass
connect using dboconnect;
if dboconnect.SQLCode<0 then 
	MessageBox ("Database Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
   return -1
end if

DECLARE p_edi_870 procedure for f_edi_alcan_870 using dboconnect;
execute p_edi_870;
if dboconnect.SQLCode <> 0 then 
	MessageBox ("870 Procedure Failed,  Please contact system support.",dboconnect.sqlerrtext,exclamation!)
	return -1
End if	
//else
//	MessageBox ("EDI", "870 Generated Successfully.")
//end if
fetch p_edi_870 INTO :li_return; 
close p_edi_870;

disconnect using dboconnect;
destroy dboconnect;

CHOOSE CASE li_return
   CASE 0
    messagebox("EDI Generation","EDI 870 generated successfully")
   CASE -1
		MessageBox("EDI Error","EDI Failed, Please Contact System Support!", StopSign!)
	CASE 100
		MessageBox("EDI Info","No new data.  Have you saved your changes ?" )
	
end CHOOSE



end event

type st_1 from statictext within w_edi
integer x = 589
integer y = 1587
integer width = 1697
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "(It will take about 1 minute to finish,  please wait for  the pop-up message box.)"
boolean focusrectangle = false
end type

type cb_alcan_863 from u_cb within w_edi
integer x = 59
integer y = 1722
integer width = 512
integer height = 106
integer taborder = 20
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Send Alcan 863"
end type

event clicked;open(w_edi_863)
end event

type cb_close from u_cb within w_edi
integer x = 2428
integer y = 1722
integer width = 322
integer height = 106
integer taborder = 11
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Close"
end type

event clicked;close(parent)
end event

