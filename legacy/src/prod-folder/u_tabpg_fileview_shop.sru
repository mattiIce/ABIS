$PBExportHeader$u_tabpg_fileview_shop.sru
$PBExportComments$fileview for shop application
forward
global type u_tabpg_fileview_shop from u_tabpg
end type
type ole_fileview from olecustomcontrol within u_tabpg_fileview_shop
end type
type cb_print from u_cb within u_tabpg_fileview_shop
end type
type cb_open from u_cb within u_tabpg_fileview_shop
end type
type cb_rename from u_cb within u_tabpg_fileview_shop
end type
type cb_delete from u_cb within u_tabpg_fileview_shop
end type
type cb_import from u_cb within u_tabpg_fileview_shop
end type
type st_1 from statictext within u_tabpg_fileview_shop
end type
end forward

global type u_tabpg_fileview_shop from u_tabpg
integer width = 3781
integer height = 2346
ole_fileview ole_fileview
cb_print cb_print
cb_open cb_open
cb_rename cb_rename
cb_delete cb_delete
cb_import cb_import
st_1 st_1
end type
global u_tabpg_fileview_shop u_tabpg_fileview_shop

type variables
long il_job
string is_folder_base
string is_scan_base
string is_abis_base
n_cst_filesrv inv_filesrv
//n_cst_string inv_string
//w_importing_2 iw_importing
//w_quality_control iw_importing
end variables

forward prototypes
public subroutine of_init (long al_job)
end prototypes

public subroutine of_init (long al_job);il_job = al_job
if al_job > 1000 then
	String ls_folder
	ls_folder = is_folder_base  + "\" + string( il_job )
	if not inv_filesrv.of_directoryexists( ls_folder ) then
		inv_filesrv.of_createdirectory( ls_folder )
	end if
//	ls_folder = "\\albl-pdc\ejobfolder$\"
//	ls_folder = ls_folder + "64331"
	ole_fileview.object.CurrentFolder = ls_folder
//	MessageBox( "", ls_folder )
	ole_fileview.object.ViewStyle = 4
	ole_fileview.visible = true
	ole_fileview.enabled = true
	cb_delete.enabled = true
	cb_import.enabled = true
	cb_open.enabled = true
	cb_rename.enabled = true
else
	ole_fileview.enabled = false
	ole_fileview.visible = false
	cb_delete.enabled = false
	cb_import.enabled = false
	cb_open.enabled = false
	cb_rename.enabled = false
end if
end subroutine

on u_tabpg_fileview_shop.create
int iCurrent
call super::create
this.ole_fileview=create ole_fileview
this.cb_print=create cb_print
this.cb_open=create cb_open
this.cb_rename=create cb_rename
this.cb_delete=create cb_delete
this.cb_import=create cb_import
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_fileview
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_open
this.Control[iCurrent+4]=this.cb_rename
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_import
this.Control[iCurrent+7]=this.st_1
end on

on u_tabpg_fileview_shop.destroy
call super::destroy
destroy(this.ole_fileview)
destroy(this.cb_print)
destroy(this.cb_open)
destroy(this.cb_rename)
destroy(this.cb_delete)
destroy(this.cb_import)
destroy(this.st_1)
end on

event constructor;call super::constructor;f_SetFilesrv(inv_filesrv, TRUE)

is_folder_base = ProfileString(gs_ini_file,"FOLDERS","job_folder_base","\\Albl-pdc\ejobfolder$")
is_scan_base = ProfileString(gs_ini_file,"FOLDERS","scan_base","s:\")
is_abis_base = ProfileString(gs_ini_file,"FOLDERS","abis_base","i:\Abis\")
ole_fileview.object.ViewStyle = 4
//RUN ( "net use y: " + is_folder_base ,Minimized!  )
//is_folder_base = "y:\"
end event

event destructor;call super::destructor;DESTROY inv_filesrv
//run ("net use y: /DELETE /Y", Minimized! )
//MessageBox("", is_abis_base )
ole_fileview.object.CurrentFolder = is_abis_base
end event

type ole_fileview from olecustomcontrol within u_tabpg_fileview_shop
event onitemclick ( oleobject item,  long ocx_x,  long ocx_y )
event onitemdblclick ( oleobject item,  long ocx_x,  long ocx_y,  boolean ab_cancel )
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
event onitemcheck ( oleobject item,  boolean checkstate,  boolean ab_cancel )
event onbeginitemrename ( oleobject item,  boolean ab_cancel )
event onenditemrename ( oleobject item,  string newname,  boolean ab_cancel )
event onbeforeselectionchange ( oleobject item,  boolean selecting,  boolean ab_cancel )
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
event onbeforeshellcommandexecute ( string commandstr,  boolean ab_cancel,  integer command )
event onoledragover ( oleobject data,  integer effect,  integer button,  integer shift,  real ocx_x,  real ocx_y,  long state,  oleobject item )
event ongetinfotip ( oleobject item,  string infotip )
event onolestartdrag ( oleobject data,  integer effects,  integer button,  boolean ab_cancel )
event onoledragdrop ( oleobject data,  integer effect,  integer button,  integer shift,  real ocx_x,  real ocx_y,  oleobject item,  boolean dodefaultshelldropaction )
event oncustomcontextmenuitemselect2 ( oleobject item,  string caption,  long cmdid )
event oncontextmenupopup ( oleobject shellmenu,  boolean backgroundmenu,  boolean ab_cancel )
event onheaderrightclick ( long headerareas,  long columnindex,  long ocx_x,  long ocx_y )
event initialize ( string path,  double pidl )
event ongetitemthumbnail ( oleobject item,  long iconindex,  boolean showdefault )
event onitemdraw ( oleobject e )
integer x = 22
integer y = 6
integer width = 1317
integer height = 768
integer taborder = 60
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "u_tabpg_fileview_shop.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_print from u_cb within u_tabpg_fileview_shop
boolean visible = false
integer x = 3368
integer y = 2166
integer width = 304
integer height = 83
integer taborder = 50
integer textsize = -12
string facename = "Arial"
boolean enabled = false
string text = "Print"
end type

event clicked;call super::clicked;ole_fileview.object.ExeCmdForAllSelected(9)
end event

type cb_open from u_cb within u_tabpg_fileview_shop
integer x = 351
integer y = 2173
integer width = 450
integer height = 154
integer taborder = 50
integer textsize = -11
string facename = "Arial"
string text = "Open"
end type

event clicked;call super::clicked;ole_fileview.object.ExeCmdForAllSelected(0)
end event

type cb_rename from u_cb within u_tabpg_fileview_shop
integer x = 1931
integer y = 2173
integer width = 450
integer height = 154
integer taborder = 40
integer textsize = -11
string facename = "Arial"
string text = "Rename"
end type

event clicked;call super::clicked;ole_fileview.object.ExeCmdForAllSelected(10)
end event

type cb_delete from u_cb within u_tabpg_fileview_shop
integer x = 1141
integer y = 2173
integer width = 450
integer height = 154
integer taborder = 30
integer textsize = -11
string facename = "Arial"
string text = "Delete"
end type

event clicked;call super::clicked;
ole_fileview.object.ExeCmdForAllSelected(6)


end event

type cb_import from u_cb within u_tabpg_fileview_shop
integer x = 2721
integer y = 2173
integer width = 450
integer height = 154
integer taborder = 20
integer textsize = -11
string facename = "Arial"
string text = "Import file..."
end type

event clicked;call super::clicked;String ls_pathname
String ls_files_selected[]
String ls_filter

pointer oldpointer // Declares a pointer variable

//oldpointer = SetPointer(HourGlass!)
//
//
//
//SetPointer(oldpointer)

//MessageBox( is_folder_base , is_scan_base )
Int li_file_count, li_i
int li_rc
ls_filter = "All supported files (*.bmp;*.gif;*.jpg;*.jpeg;*.pdf;*.doc;*.eml;*.wav;*.msg;*.avi;*.mov)"

if GetFileOpenName("Select import file", ls_pathname, ls_files_selected,"","", is_scan_base ) = 1 then
	
	li_file_count = Upperbound(ls_files_selected)
	if li_file_count > 1 then
	oldpointer = SetPointer(HourGlass!)	
		for li_i=1 to li_file_count
//			MessageBox(ls_pathname, ls_files_selected[li_i] )
//			int li_rc
//			MessageBox(ls_pathname + "\" + ls_files_selected[li_i] , is_folder_base + string( il_job ) + "\"+ls_files_selected[li_i] )
			
			li_rc = inv_filesrv.of_filecopy( ls_pathname + "\"+ls_files_selected[li_i] , is_folder_base + "\" + string( il_job ) + "\"+ls_files_selected[li_i] )
			choose case li_rc
				case 1
//					MessageBox("Import file", ls_files_selected[li_i] + " success")
				case -1
					MessageBox("Import file", ls_files_selected[li_i] + " error opening sourcefile")
				case -2
					MessageBox("Import file", ls_files_selected[li_i] + " error writing targetfile")
			end choose
		next
		SetPointer(oldpointer)
	else //single file
//			MessageBox(ls_pathname, ls_files_selected[1] )		
//			MessageBox(ls_pathname,is_folder_base + string( il_job ) + "\"+ls_files_selected[1])
			oldpointer = SetPointer(HourGlass!)
			li_rc = inv_filesrv.of_filecopy( ls_pathname , is_folder_base + "\" +string( il_job ) + "\"+ls_files_selected[1] )
			choose case li_rc
				case 1
//					MessageBox("Import file", ls_files_selected[1] + " success")
				case -1
					MessageBox("Import file", ls_files_selected[1] + " error opening sourcefile")
				case -2
					MessageBox("Import file", ls_files_selected[1] + " error writing targetfile")
			end choose
			oldpointer = SetPointer(HourGlass!)
	end if
	
//	MessageBox( UPPER(ls_pathname), string(Pos(UPPER(ls_pathname),UPPER(is_scan_base))) )
	
	if Pos(UPPER(ls_pathname),UPPER(is_scan_base)) > 0 then //Path is in scan base
		if MessageBox( "import file(s)", "Do you want to delete the original file(s)?", Question!, YesNo! ) = 1 then
			//Delete file(s)	
			if li_file_count > 1 then
				for li_i=1 to li_file_count
					FileDelete( ls_pathname + "\"+ls_files_selected[li_i] )
				next
			else
				FileDelete( ls_pathname )
			end if
		end if
	end if
ole_fileview.object.RefreshViewFast() 
end if

end event

type st_1 from statictext within u_tabpg_fileview_shop
integer x = 1075
integer y = 714
integer width = 1009
integer height = 138
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No valid Job"
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Cu_tabpg_fileview_shop.bin 5988 
2000001000e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000006fffffffe0000000400000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000917df94001d1e1d900000003000005c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000010e0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000038300000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a0000000200000001000000046ae24111457f8113326c50a0ba095eed00000000917df94001d1e1d9917df94001d1e1d900000000000000000000000000000001000000020000000300000004fffffffe000000060000000700000008000000090000000a0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffe0000001500000016fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0050004d003e003f0045004100730050006d00620064006900560055002e006a006a004b0070004400560064006d002f006d006200710054004400490070004800560059006f003300560061006b0033004400490073004c0057006200650040006d0062006e006900470064006d004400540064006500400046006200700048006c004c0073004c005000620036003f005200340045003f0067003300460076004e0046004400610079004f0075003f0057006b0070006000560069005e0075007700650041006c006c00430060004f0063003600510070007400580034006d002a002f005e003f006700300057005100540030002f0048005300330030004a0054006d0043006100330034000000360000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe000201056ae24111457f8113326c50a0ba095eed00000001fb8f0821101b01640008ed8413c72e2b00000030000003530000000e0000010000000078000001010000008000000102000000880000010300000090000001040000009800000105000000a000000106000000a800000107000000b000000108000000b800000109000001fc0000010a000002040000010b0000020c0000010c00000214000000000000021c00000003000c00000000000300001dc400000003000013d800000003000000400000000b000000000000000b000000000000000b0000000000000041000000000000004b000001390000fffe000101050be3520311ce8f91aa00e39d51b84b0000000001fb8f0821101b01640008ed8413c72e2b00000030000001090000000800000002000000480000000a00000054000000090000005c0000000400000064000000070000007000000006000000780000000800000080000000000000008800000008000000020000004d00000002000000000000000200000190000000060001d4c0000000000000000b000000000000000b000000000000000b00000000000000080000000000000005006f00660000086e00000e00740073006900720065006b000400740005000000730000007a0069000000000900000007006500770a670069080000006300000061006800070072000a0000007500000064006e0072006500000002000000050061006e0000066d000007000000690000006100740000006c0000000b0000ffff0000000b000000000000000b0000000000000003ffffffff0000000e000000000000000100010b0000000e00646968006c6573656974636507006e6f0e00000163000000657272756f66746e7265646c00010a00000010006c6c6100697a776f6c6f6670737265640001030000000c0074735f00706b636f73706f7200010c000000110074657300747865746b6361626f6c6f6301090072001a00006c61000063776f6c6d756c6f6165686e647265646467617200706f7200000105000000176f6c6c616c756d776c7069746c6573656974636501006e6f090000015f000000657478650078746e00000104000000156f6c6c6176696477746e69656c6f666f73726564000102000000090078655f00746e657401080079000500006f6600000600746e130000017300000073776f68696365706f666c617265646c0100007300090000765f00006973726500006e6f0073006500560068006500690046007700730061002800740020002900200000002d002d002d002d002d002d002d002d002d002d00440020006e006f000c000000001dc4000013d80000004000000001000000000100000001010000ffffff0100000000010100000000010103010000012a2e2a00040002000100000be3520311ce8f91aa00e39d51b84b0000000001d4c001904804000101766c6501000000000002000000010000000000ffff00000000ffff0000000001000000006901010067006e004f0020006a006200630065002000740075002c0074005f00620061006700700066005f006c0069007600650065006900200077006f006600200072006f00270065006c0066005f006c006900760065006500690027007700000020006f00420064006c0041000000690072006c0061005500200069006e006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000001400000082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Cu_tabpg_fileview_shop.bin 5988 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
