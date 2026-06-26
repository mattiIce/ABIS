$PBExportHeader$w_opc_log_item_selection.srw
$PBExportComments$<Child> listed all items to be logged
forward
global type w_opc_log_item_selection from w_child
end type
type ole_1 from olecustomcontrol within w_opc_log_item_selection
end type
type dw_item_list from u_dw within w_opc_log_item_selection
end type
type cb_coil_cancel from u_cb within w_opc_log_item_selection
end type
type cb_ok from u_cb within w_opc_log_item_selection
end type
end forward

global type w_opc_log_item_selection from w_child
string tag = "create new log event"
integer x = 878
integer y = 486
integer width = 1609
integer height = 1680
string title = "Select items from list"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
ole_1 ole_1
dw_item_list dw_item_list
cb_coil_cancel cb_coil_cancel
cb_ok cb_ok
end type
global w_opc_log_item_selection w_opc_log_item_selection

type variables
Long il_new_event
end variables

on w_opc_log_item_selection.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.dw_item_list=create dw_item_list
this.cb_coil_cancel=create cb_coil_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.dw_item_list
this.Control[iCurrent+3]=this.cb_coil_cancel
this.Control[iCurrent+4]=this.cb_ok
end on

on w_opc_log_item_selection.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.dw_item_list)
destroy(this.cb_coil_cancel)
destroy(this.cb_ok)
end on

event pfc_postopen;call super::pfc_postopen;string ls_remotehost, ls_devicename, ls_line, ls_stacker, ls_devicename_stacker
int li_line_width
long ll_value, ll_shift

ls_remotehost = ProfileString(gs_downtime_ini_file,"OPCItems","RemoteHost","localhost")
ls_devicename = ProfileString(gs_downtime_ini_file,"OPCItems","DeviceName","PLC5-BL110.")
ls_devicename_stacker = ProfileString(gs_downtime_ini_file,"StackerItem","DeviceName","")

ls_line = ProfileString(gs_downtime_ini_file,"DataBase","LogId","bl110")

li_line_width = integer(mid(ls_line,3))

////Add OPC item in this section
//is_coil = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_coil","abcoil")
//is_job = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_job","abjob")
//is_override = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_override","abshiftoverride")
//is_shift = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_shift","abshift")
//is_noauto = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_noauto","noauto-t")
//is_automode = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_automode","automode")
//is_autorunning = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_autorunning","autorunning")
//is_coilinfeeder = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_coilinfeeder","coilinfeeder")
//is_coilunload = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_coilunload","coilunload")
//is_coilunloadreset = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_coilunloadreset","coilunloadreset")
//is_feedlength = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_feedlength","feedlength")
//is_goodpartcnt = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_goodpartcnt","goodpartcnt")
//is_rejectpartcnt = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_rejectpartcnt","rejectpartcnt")
//is_rejectlength = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_rejectlength","rejectlength")
//is_partno = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_partno","partno")
//is_strokes = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_strokes","strokecnt")
//is_skid= ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_skid","abskid")
//is_feedreject= ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_feedreject","feedreject")
//is_plc_fault = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_plc_fault","activefault")
//is_opc_error = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_opc_error","Attributes._ErrorCode")
////Stacker OPC items
//is_station2_stack_counter = ls_devicename_stacker + ProfileString(gs_downtime_ini_file,"StackerItem","is_station2_stack_counter","")
//is_station1_stack_counter = ls_devicename_stacker + ProfileString(gs_downtime_ini_file,"StackerItem","is_station1_stack_counter","")
//is_Sta2StackComplete = ls_devicename_stacker + ProfileString(gs_downtime_ini_file,"StackerItem","is_Sta2StackComplete","")
//is_Sta1StackComplete = ls_devicename_stacker + ProfileString(gs_downtime_ini_file,"StackerItem","is_Sta1StackComplete","")
//is_SendBlankToSta2 = ls_devicename_stacker + ProfileString(gs_downtime_ini_file,"StackerItem","is_SendBlankToSta2","")
//is_SendBlankToSta1 = ls_devicename_stacker + ProfileString(gs_downtime_ini_file,"StackerItem","is_SendBlankToSta1","")
//is_SlaveSta2ToSta1 = ls_devicename_stacker + ProfileString(gs_downtime_ini_file,"StackerItem","is_SlaveSta2ToSta1","")
////End of Stacker OPC items
ole_1.object.RemoteHost = ls_remotehost
//ole_1.object.Items.RemoveAll
//ole_1.object.Items.AddItem(is_shift)
//ole_1.object.Items.AddItem(is_coil)
//ole_1.object.Items.AddItem(is_job)
//ole_1.object.Items.AddItem(is_override)
//ole_1.object.Items.AddItem(is_noauto)
//ole_1.object.Items.AddItem(is_automode)
//ole_1.object.Items.AddItem(is_autorunning)
//ole_1.object.Items.AddItem(is_coilinfeeder)
//ole_1.object.Items.AddItem(is_feedlength)
//ole_1.object.Items.AddItem(is_goodpartcnt)
//ole_1.object.Items.AddItem(is_rejectpartcnt)
//ole_1.object.Items.AddItem(is_rejectlength)
//ole_1.object.Items.AddItem(is_partno)
//ole_1.object.Items.AddItem(is_strokes)
//ole_1.object.Items.AddItem(is_skid)
//ole_1.object.Items.AddItem(is_feedreject)
//ole_1.object.Items.AddItem(is_opc_error )
//ole_1.object.Items.AddItem(is_plc_fault )
////These are stacker items
//if is_station2_stack_counter <> "" then ole_1.object.Items.AddItem(is_station2_stack_counter)
//if is_station1_stack_counter <> "" then ole_1.object.Items.AddItem(is_station1_stack_counter)
//if is_Sta2StackComplete <> "" then ole_1.object.Items.AddItem(is_Sta2StackComplete)
//if is_Sta1StackComplete <> "" then ole_1.object.Items.AddItem(is_Sta1StackComplete)
//if is_SendBlankToSta2 <> "" then ole_1.object.Items.AddItem(is_SendBlankToSta2)
//if is_SendBlankToSta1 <> "" then ole_1.object.Items.AddItem(is_SendBlankToSta1)
//if is_SlaveSta2ToSta1 <> "" then ole_1.object.Items.AddItem(is_SlaveSta2ToSta1)
////End of OPC item section
//

If ole_1.object.Connect = false then
	MessageBox( "OPC connect", "Fail to connect opc server!", StopSign!, OK!)
	HALT CLOSE
end if
ole_1.object.Refresh
sleep(3)
ole_1.object.Refresh


//il_abjob = ole_1.object.items(is_job ).value
//st_job.text = string( il_abjob )
//	
//ib_feedreject = ole_1.object.items(is_feedreject).value
//		
//ib_automode = ole_1.object.items(is_automode ).value
//uo_automode.set_select(ib_automode)
//		
//ib_autorunning = ole_1.object.items(is_autorunning ).value
//
//
//ib_coilinfeeder = ole_1.object.items(is_coilinfeeder ).value
//uo_coilinfeeder.set_select( ib_coilinfeeder )



end event

type ole_1 from olecustomcontrol within w_opc_log_item_selection
event onconnect ( )
event ondisconnect ( )
event ondatachanged ( integer bokay,  oleobject changeditems )
event onwritecompleted ( integer bokay,  oleobject writtenitems )
event onerror ( long ocx_error,  string description )
integer x = 55
integer y = 1498
integer width = 176
integer height = 122
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_opc_log_item_selection.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type dw_item_list from u_dw within w_opc_log_item_selection
integer x = 4
integer y = 10
integer width = 1591
integer height = 1482
integer taborder = 20
string dataobject = "d_opc_event_item_select"
boolean vscrollbar = false
boolean livescroll = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event itemchanged;call super::itemchanged;this.ResetUpdate()
end event

type cb_coil_cancel from u_cb within w_opc_log_item_selection
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 852
integer y = 1498
integer width = 351
integer height = 93
integer taborder = 10
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(parent, il_new_event)
end event

type cb_ok from u_cb within w_opc_log_item_selection
string tag = "Close this window and pass the information"
integer x = 366
integer y = 1498
integer width = 351
integer height = 93
integer taborder = 11
string facename = "Arial"
string text = "&OK"
end type

event clicked;CloseWithReturn(parent, 0)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
03w_opc_log_item_selection.bin 3992 
2000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffe00000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000076e6688001d1b82400000003000003000000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000020000012a00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004016d22bc11d72951a000c9b5073e36240000000076e6688001d1b82476e6688001d1b82400000000000000000000000000000001fffffffe00000003000000040000000500000006fffffffe00000008000000090000000a0000000bfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00630064006b006b00680063006e00640064006f006d00660065006e00620062006400680069006600650062006f006800670064006500670070006e0066006200610064006e006a00670062006600610065006d007000680069006a006600660062006d0070006100650066006600670063006700640070006c0064006600660000030000000003000800000000002c006900430051006d0065007500740073006e0049002e0063004700490050004f00410043002e004200000031000200080000000000140008006c00000063006f006c0061006f00680074007300030000000003e800000004000b00000003ffff00004e20ffff000bffff000b13880003197100000004050800240000005000000043004c002d0035004c004200310031002e003000620061006f0063006c006900220000005000000043004c002d0035004c004200310031002e003000620061006f006a0000006200000024004c0050003500430042002d0031004c003000310061002e007300620069006b0000006400000026004c0050003500430042002d0031004c003000310061002e0073006200690068007400660000000000000000000000000000000000000000000000000000030000000003000800000000002c006900430051006d0065007500740073006e0049002e0063004700490050004f00410043002e00420000003100020008006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000070000012a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000140008006c00000063006f006c0061006f00680074007300030000000003e800000004000b00000003ffff00004e20ffff000bffff000b13880003197100000004050800240000005000000043004c002d0035004c004200310031002e003000620061006f0063006c006900220000005000000043004c002d0035004c004200310031002e003000620061006f006a0000006200000024004c0050003500430042002d0031004c003000310061002e007300620069006b0000006400000026004c0050003500430042002d0031004c003000310061002e007300620069006800740066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13w_opc_log_item_selection.bin 3992 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
