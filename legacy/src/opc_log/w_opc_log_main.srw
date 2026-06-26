$PBExportHeader$w_opc_log_main.srw
$PBExportComments$<Sheet> main opc log app window inherited from w_sheet
forward
global type w_opc_log_main from w_sheet
end type
type st_6 from statictext within w_opc_log_main
end type
type st_current_time from statictext within w_opc_log_main
end type
type dw_details from u_dw within w_opc_log_main
end type
type dw_action from u_dw within w_opc_log_main
end type
type tv_opc from u_tvs within w_opc_log_main
end type
type cb_new from u_cb within w_opc_log_main
end type
type em_timer from editmask within w_opc_log_main
end type
type st_5 from statictext within w_opc_log_main
end type
type st_4 from statictext within w_opc_log_main
end type
type st_run from statictext within w_opc_log_main
end type
type st_2 from statictext within w_opc_log_main
end type
type cb_close from u_cb within w_opc_log_main
end type
type st_1 from statictext within w_opc_log_main
end type
type ole_1 from olecustomcontrol within w_opc_log_main
end type
type dw_item_history from u_dw within w_opc_log_main
end type
type gb_1 from groupbox within w_opc_log_main
end type
type dw_action_log from u_dw within w_opc_log_main
end type
end forward

global type w_opc_log_main from w_sheet
integer x = 0
integer y = 0
integer width = 3068
integer height = 1754
string title = "OPC LOG"
boolean maxbox = false
boolean resizable = false
windowstate windowstate = maximized!
boolean center = true
event type string ue_whoami ( )
event type long ue_refresh_data ( )
event type long ue_load_new_event ( )
st_6 st_6
st_current_time st_current_time
dw_details dw_details
dw_action dw_action
tv_opc tv_opc
cb_new cb_new
em_timer em_timer
st_5 st_5
st_4 st_4
st_run st_run
st_2 st_2
cb_close cb_close
st_1 st_1
ole_1 ole_1
dw_item_history dw_item_history
gb_1 gb_1
dw_action_log dw_action_log
end type
global w_opc_log_main w_opc_log_main

type variables
Long il_current_log, il_level
String is_current_item


end variables

event type string ue_whoami();return "w_opc_log_main"
end event

event type long ue_refresh_data();DataStore lds_source, lds_item
Long ll_tvi
Long ll_i, ll_j, ll_arow, ll_drow, ll_val
String ls_item, ls_itemtype, ls_opc_item, ls_application, ls_notes
String ls_val
DateTime ldt_now

ldt_now = DateTime(Today(), Now())
ls_application = "testing app"
dw_action.ResetUpdate()
dw_action.Reset()
dw_details.ResetUpdate()
dw_details.Reset()

lds_source = CREATE datastore  
lds_source.DataObject = "d_opc_current_log_host_device"  
lds_source.SetTransObject (SQLCA)  
lds_source.Retrieve()

ll_arow = dw_action.InsertRow(0)
IF ll_arow = -1 THEN RETURN -2
IF lds_source.RowCount() = 0 THEN
	ls_notes = "No logged item defined."
	dw_action.SetItem(ll_arow, "opc_log_id", il_current_log)
	dw_action.SetItem(ll_arow, "time_stamp", ldt_now)
	dw_action.SetItem(ll_arow, "source", ls_application)
	dw_action.SetItem(ll_arow, "success", 0)
	dw_action.SetItem(ll_arow, "notes", ls_notes)
	dw_action.AcceptText()
	dw_action.Update()
	IF SQLCA.SQLCode <> 0 then
		ROLLBACK USING SQLCA;
		//Messagebox("DBError", "ue_refresh_data function/no item" )
	ELSE
		COMMIT USING SQLCA;
	END IF
	dw_action.ResetUpdate()
	dw_action.Reset()
	RETURN 0
END IF

ls_notes = "logging data..."
dw_action.SetItem(ll_arow, "opc_log_id", il_current_log)
dw_action.SetItem(ll_arow, "time_stamp", ldt_now)
dw_action.SetItem(ll_arow, "source", ls_application)
dw_action.SetItem(ll_arow, "success", 0)
dw_action.SetItem(ll_arow, "notes", ls_notes)


String ls_remotehost, ls_devicename

FOR ll_i = 1 TO lds_source.RowCount()
	il_current_log = lds_source.GetItemNumber(ll_i, "opc_log_sources_opc_log_id")
	ls_remotehost = lds_source.GetItemString(ll_i, "opc_log_sources_remote_host")
	ls_devicename = lds_source.GetItemString(ll_i, "opc_log_sources_device_name")

	lds_item = CREATE datastore  
	lds_item.DataObject = "d_opc_current_log_item_per_source"  
	lds_item.SetTransObject (SQLCA)  
	lds_item.Retrieve(il_current_log, ls_remotehost, ls_devicename)

	IF lds_item.RowCount() = 0 THEN
		//ls_notes = "not item scheduled to be logged"
	END IF
	
	IF lds_item.RowCount() > 0 THEN
		FOR ll_j = 1 TO lds_item.RowCount()
			ole_1.object.disconnect

			ls_item = lds_item.GetItemString(ll_j, "item_name")
			ls_itemtype = lds_item.GetItemString(ll_j, "item_type")
		
			ls_opc_item = ls_devicename + "." + ls_item

			ole_1.object.RemoteHost = ls_remotehost
			ole_1.object.Items.RemoveAll
			ole_1.object.Items.AddItem(ls_opc_item)


			If ole_1.object.Connect = false then
				ls_notes = "Fail to connect opc server!"
				dw_action.SetItem(ll_arow, "notes", ls_notes)
				dw_action.AcceptText()
				dw_action.Update()
				IF SQLCA.SQLCode <> 0 then
					ROLLBACK USING SQLCA;
					//Messagebox("DBError", "ue_refresh_data function/failed to connect opc" )
				ELSE
					COMMIT USING SQLCA;
				END IF
				dw_action.ResetUpdate()
				dw_action.Reset()
				RETURN -1
			end if
			ole_1.object.Refresh


			CHOOSE CASE UPPER(ls_itemtype)
				CASE "VT-I4"
					ll_val = ole_1.object.items(ls_opc_item).value
					ll_drow = dw_details.InsertRow(0)
					dw_details.SetItem(ll_drow, "opc_log_id",il_current_log)
					dw_details.SetItem(ll_drow, "item_name",ls_item)
					dw_details.SetItem(ll_drow, "time_stamp",ldt_now)
					dw_details.SetItem(ll_drow, "remote_host",ls_remotehost)
					dw_details.SetItem(ll_drow, "device_name",ls_devicename)
					dw_details.SetItem(ll_drow, "value",ll_val)

			END CHOOSE
		NEXT
	END IF
	
	DESTROY lds_item
NEXT

DESTROY lds_source

ls_notes = "Success!"
dw_action.SetItem(ll_arow, "success", 1)
dw_action.SetItem(ll_arow, "notes", ls_notes)

dw_action.AcceptText()
dw_action.Update()
IF SQLCA.SQLCode <> 0 then
	ROLLBACK USING SQLCA;
	//Messagebox("DBError", "ue_refresh_data function updating action table" )
END IF
dw_details.AcceptText()
dw_details.Update()
IF SQLCA.SQLCode <> 0 then
	ROLLBACK USING SQLCA;
	//Messagebox("DBError", "ue_refresh_data function updating detail table" )
END IF
COMMIT USING SQLCA;

dw_action.ResetUpdate()
dw_action.Reset()
dw_details.ResetUpdate()
dw_details.Reset()

ole_1.object.disconnect

IF (Len(is_current_item) > 0) AND (il_level = 4) THEN dw_item_history.Retrieve(il_current_log, is_current_item)
dw_action_log.Retrieve()

IF Long(em_timer.Text) > 1 THEN 
	Timer(60*Long(em_timer.Text), this)
ELSE //default
	Timer(59, this)
END IF

RETURN 1
end event

event type long ue_load_new_event();RETURN 1
end event

on w_opc_log_main.create
int iCurrent
call super::create
this.st_6=create st_6
this.st_current_time=create st_current_time
this.dw_details=create dw_details
this.dw_action=create dw_action
this.tv_opc=create tv_opc
this.cb_new=create cb_new
this.em_timer=create em_timer
this.st_5=create st_5
this.st_4=create st_4
this.st_run=create st_run
this.st_2=create st_2
this.cb_close=create cb_close
this.st_1=create st_1
this.ole_1=create ole_1
this.dw_item_history=create dw_item_history
this.gb_1=create gb_1
this.dw_action_log=create dw_action_log
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_6
this.Control[iCurrent+2]=this.st_current_time
this.Control[iCurrent+3]=this.dw_details
this.Control[iCurrent+4]=this.dw_action
this.Control[iCurrent+5]=this.tv_opc
this.Control[iCurrent+6]=this.cb_new
this.Control[iCurrent+7]=this.em_timer
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_run
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.ole_1
this.Control[iCurrent+15]=this.dw_item_history
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.dw_action_log
end on

on w_opc_log_main.destroy
call super::destroy
destroy(this.st_6)
destroy(this.st_current_time)
destroy(this.dw_details)
destroy(this.dw_action)
destroy(this.tv_opc)
destroy(this.cb_new)
destroy(this.em_timer)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_run)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.ole_1)
destroy(this.dw_item_history)
destroy(this.gb_1)
destroy(this.dw_action_log)
end on

event close;call super::close;ole_1.object.disconnect
f_display_app()
end event

event pfc_postopen;call super::pfc_postopen;Long ll_tvi
DataStore lds_source

tv_opc.Event pfc_RefreshLevel(1)
ll_tvi = tv_opc.FindItem(RootTreeItem! , 0)
tv_opc.ExpandAll(ll_tvi)

lds_source = CREATE datastore  
lds_source.DataObject = "d_opc_current_log"  
lds_source.SetTransObject (SQLCA)  
lds_source.Retrieve()

IF lds_source.RowCount() > 1 THEN
	MessageBox("Warning","Multiple current logged defined. Only one event allowed.")
END IF

IF lds_source.RowCount() = 0 THEN
	MessageBox("Warning", "No current logged defined.")
END IF

il_current_log = lds_source.GetItemNumber(1, "opc_log_id")
is_current_item = ""
il_level = 1

DESTROY lds_source

This.Event ue_refresh_data()






end event

event timer;call super::timer;st_current_time.Text = String(DateTime(Today(), Now()),"MM/DD/YYYY HH:MM:SS")
RETURN This.Event ue_refresh_data()
end event

type st_6 from statictext within w_opc_log_main
integer x = 205
integer y = 1616
integer width = 391
integer height = 61
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Last Log Time:"
boolean focusrectangle = false
end type

type st_current_time from statictext within w_opc_log_main
integer x = 603
integer y = 1619
integer width = 549
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "12/25/2009 23:59:59"
boolean focusrectangle = false
end type

event constructor;this.Text = String(DateTime(Today(), Now()),"MM/DD/YYYY HH:MM:SS")
end event

type dw_details from u_dw within w_opc_log_main
integer x = 889
integer y = 1181
integer width = 2077
integer height = 278
integer taborder = 50
string dataobject = "d_detail_table_update"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)


end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 
end event

type dw_action from u_dw within w_opc_log_main
integer x = 900
integer y = 880
integer width = 2063
integer height = 278
integer taborder = 40
string dataobject = "d_action_table_update"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)


end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 
end event

type tv_opc from u_tvs within w_opc_log_main
integer x = 15
integer y = 35
integer width = 848
integer height = 643
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!","ArrangeTables!","ArrangeIcons!","SelectApplication!","SelectAndRun!","Custom035!","CreateRuntime!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;Long ll_tvi

this.of_SetPrint(TRUE)
this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"Title", "", "d_opc_current_log", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.opc_log_id", "d_opc_current_log_source_host", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.2.opc_log_id,:parent.1.remote_host", "d_opc_current_log_source_device", SQLCA, "")
this.inv_levelsource.of_Register(4, "item_name",  &
  ":parent.3.opc_log_id,:parent.2.Remote_host,:parent.1.device_name", "d_opc_current_log_item_per_source", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")
this.inv_levelsource.of_SetPictureColumn(4, "7")
this.inv_levelsource.of_SetSelectedPictureColumn(4, "8")

this.event pfc_Populate(0)



end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 1	//event
 		il_current_log = lds_datastore.GetItemNumber(ll_row,"opc_log_id")
		il_level = 1
	CASE 2   //host
		il_level = 2
	CASE 3   //machine
		il_level = 3
	CASE 4	//item
		is_current_item = lds_datastore.GetItemString(ll_row,"item_name")
		dw_item_history.Retrieve(il_current_log, is_current_item)
END CHOOSE

end event

type cb_new from u_cb within w_opc_log_main
integer x = 91
integer y = 694
integer width = 699
integer height = 77
integer taborder = 40
string facename = "Arial"
string text = "Create &New Logging Event"
end type

event clicked;call super::clicked;Open(w_opc_log_item_selection)
IF Message.DoubleParm <> 0 THEN
	il_current_log = Message.DoubleParm
	RETURN Parent.Event ue_load_new_event()
END IF
RETURN 0
end event

type em_timer from editmask within w_opc_log_main
integer x = 2132
integer y = 1581
integer width = 219
integer height = 80
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "5"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
end type

type st_5 from statictext within w_opc_log_main
integer x = 2381
integer y = 1590
integer width = 227
integer height = 61
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "minutes"
boolean focusrectangle = false
end type

type st_4 from statictext within w_opc_log_main
integer x = 1704
integer y = 1590
integer width = 410
integer height = 61
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Retrieve every"
boolean focusrectangle = false
end type

type st_run from statictext within w_opc_log_main
integer x = 603
integer y = 1562
integer width = 501
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "12/25/2009 23:59:59"
boolean focusrectangle = false
end type

event constructor;this.Text = String(DateTime(Today(),Now()),"mm/dd/yyyy hh:mm:ss")
end event

type st_2 from statictext within w_opc_log_main
integer x = 205
integer y = 1562
integer width = 410
integer height = 61
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Running Since:"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_opc_log_main
integer x = 2629
integer y = 1568
integer width = 399
integer height = 93
integer taborder = 60
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_1 from statictext within w_opc_log_main
integer x = 7
integer y = 787
integer width = 574
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Last 24 hours actions:"
boolean focusrectangle = false
end type

type ole_1 from olecustomcontrol within w_opc_log_main
event onconnect ( )
event ondisconnect ( )
event ondatachanged ( integer bokay,  oleobject changeditems )
event onwritecompleted ( integer bokay,  oleobject writtenitems )
event onerror ( long ocx_error,  string description )
integer x = 7
integer y = 1562
integer width = 176
integer height = 122
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_opc_log_main.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event ondatachanged(integer bokay, oleobject changeditems);
int li_count, li_i
long ll_value
string ls_tag
li_count = changeditems.count
for li_i= 0 to li_count - 1
//	ls_tag = changeditems.item(li_i).ItemId
//	if ls_tag = is_coil then
//		il_coil = changeditems.item(li_i).value
//	elseif ls_tag = is_job then
//		il_job = changeditems.item(li_i).value
//		if rb_realtime.checked then
//			of_register_treeview( il_job)
//		end if
//	elseif ls_tag = is_skid then
//		il_skid = changeditems.item(li_i).value
//		if rb_realtime.checked then
//			of_realtime_change_skid( il_skid )
//		end if
//	elseif ls_tag = is_shift then
//		il_shift = changeditems.item(li_i).value
//	else
//		continue
//	end if
next
		
end event

type dw_item_history from u_dw within w_opc_log_main
integer x = 874
integer y = 35
integer width = 2165
integer height = 726
integer taborder = 40
string dataobject = "d_opc_item_history"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 
end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

type gb_1 from groupbox within w_opc_log_main
integer x = 4
integer width = 3050
integer height = 781
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_action_log from u_dw within w_opc_log_main
integer x = 7
integer y = 858
integer width = 3043
integer height = 694
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_opc_log_action_list"
end type

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
this.Retrieve()

end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_opc_log_main.bin 3992 
2000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffe00000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000003000000000000000000000000000000000000000000000000000000002d58a51001ca72bd00000003000003000000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000020000012a00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004016d22bc11d72951a000c9b5073e3624000000002d58a51001ca72bd2d58a51001ca72bd00000000000000000000000000000001fffffffe00000003000000040000000500000006fffffffe00000008000000090000000a0000000bfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00630064006b006b00680063006e00640064006f006d00660065006e0062006200610063006c007000670066006a007000700065006700700069006e00660062006b0063006f0069006f0062006a0062006a006e006e00620069006a006d00640067006b006200620061006400610066006700660064006d006c0064006600660000030000000003000800000000002c006900430051006d0065007500740073006e0049002e0063004700490050004f00410043002e004200000031000200080000000000140008006c00000063006f006c0061006f00680074007300030000000003e800000004000b00000003ffff00004e20ffff000bffff000b13880003197100000004050800240000005000000043004c002d0035004c004200310031002e003000620061006f0063006c006900220000005000000043004c002d0035004c004200310031002e003000620061006f006a0000006200000024004c0050003500430042002d0031004c003000310061002e007300620069006b0000006400000026004c0050003500430042002d0031004c003000310061002e00730062006900680074006600200000006500430074006e006100720020006c002e00340000030000000003000800000000002c006900430051006d0065007500740073006e0049002e0063004700490050004f00410043002e00420000003100020008006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000070000012a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000140008006c00000063006f006c0061006f00680074007300030000000003e800000004000b00000003ffff00004e20ffff000bffff000b13880003197100000004050800240000005000000043004c002d0035004c004200310031002e003000620061006f0063006c006900220000005000000043004c002d0035004c004200310031002e003000620061006f006a0000006200000024004c0050003500430042002d0031004c003000310061002e007300620069006b0000006400000026004c0050003500430042002d0031004c003000310061002e00730062006900680074006600750000006e007200200073006f006c0067006e005b002000620070005f006d0062006c00740075006f00740075006e005d0070006f0000006500700020006e00200028002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d0062006f005f00650070005d006e006f0000006800740072006500280020007500200073006e006700690065006e006c0064006e006f002000670070007700720061006d00610020002c006f006c0067006e006c002000610070006100720020006d002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d0062006f005f00680074007200650000005d0062007200740075006f00740064006e0077006f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_opc_log_main.bin 3992 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
