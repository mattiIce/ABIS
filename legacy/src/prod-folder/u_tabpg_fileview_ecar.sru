$PBExportHeader$u_tabpg_fileview_ecar.sru
$PBExportComments$fileview for ecar application
forward
global type u_tabpg_fileview_ecar from u_tabpg
end type
type ole_fileview from olecustomcontrol within u_tabpg_fileview_ecar
end type
type cb_print from u_cb within u_tabpg_fileview_ecar
end type
type cb_open from u_cb within u_tabpg_fileview_ecar
end type
type cb_rename from u_cb within u_tabpg_fileview_ecar
end type
type cb_delete from u_cb within u_tabpg_fileview_ecar
end type
type cb_import from u_cb within u_tabpg_fileview_ecar
end type
type st_1 from statictext within u_tabpg_fileview_ecar
end type
end forward

global type u_tabpg_fileview_ecar from u_tabpg
integer width = 4202
integer height = 1600
ole_fileview ole_fileview
cb_print cb_print
cb_open cb_open
cb_rename cb_rename
cb_delete cb_delete
cb_import cb_import
st_1 st_1
end type
global u_tabpg_fileview_ecar u_tabpg_fileview_ecar

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

on u_tabpg_fileview_ecar.create
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

on u_tabpg_fileview_ecar.destroy
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
//ole_fileview.object.ViewStyle = 4

end event

event destructor;call super::destructor;DESTROY inv_filesrv
//ole_fileview.object.CurrentFolder = is_abis_base
end event

type ole_fileview from olecustomcontrol within u_tabpg_fileview_ecar
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
integer x = 11
integer y = 10
integer width = 3672
integer height = 1574
integer taborder = 60
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "u_tabpg_fileview_ecar.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_print from u_cb within u_tabpg_fileview_ecar
boolean visible = false
integer x = 3778
integer y = 6
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

type cb_open from u_cb within u_tabpg_fileview_ecar
integer x = 3712
integer y = 240
integer width = 450
integer height = 154
integer taborder = 50
integer textsize = -11
string facename = "Arial"
string text = "Open"
end type

event clicked;call super::clicked;ole_fileview.object.ExeCmdForAllSelected(0)
end event

type cb_rename from u_cb within u_tabpg_fileview_ecar
integer x = 3712
integer y = 707
integer width = 450
integer height = 154
integer taborder = 40
integer textsize = -11
string facename = "Arial"
string text = "Rename"
end type

event clicked;call super::clicked;ole_fileview.object.ExeCmdForAllSelected(10)
end event

type cb_delete from u_cb within u_tabpg_fileview_ecar
integer x = 3712
integer y = 474
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

type cb_import from u_cb within u_tabpg_fileview_ecar
integer x = 3712
integer y = 941
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

type st_1 from statictext within u_tabpg_fileview_ecar
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
0Du_tabpg_fileview_ecar.bin 1996 
2000000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Du_tabpg_fileview_ecar.bin 1996 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
