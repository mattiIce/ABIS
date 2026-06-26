$PBExportHeader$w_display_edi_file.srw
forward
global type w_display_edi_file from w_response
end type
type rte_edi_file from u_rte within w_display_edi_file
end type
type cb_saveas from u_cb within w_display_edi_file
end type
type cb_print from u_cb within w_display_edi_file
end type
type cb_close from u_cb within w_display_edi_file
end type
end forward

global type w_display_edi_file from w_response
int Height=1526
rte_edi_file rte_edi_file
cb_saveas cb_saveas
cb_print cb_print
cb_close cb_close
end type
global w_display_edi_file w_display_edi_file

on w_display_edi_file.create
int iCurrent
call super::create
this.rte_edi_file=create rte_edi_file
this.cb_saveas=create cb_saveas
this.cb_print=create cb_print
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rte_edi_file
this.Control[iCurrent+2]=this.cb_saveas
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_close
end on

on w_display_edi_file.destroy
call super::destroy
destroy(this.rte_edi_file)
destroy(this.cb_saveas)
destroy(this.cb_print)
destroy(this.cb_close)
end on

event open;call super::open;
int  li_result, li_answer
string ls_path_name
ls_path_name = Message.StringParm

li_result = rte_edi_file.InsertDocument(ls_path_name, TRUE, FileTypeText!)

IF li_result <> 1 THEN
	MessageBox("Error", "File: "+ls_path_name+" not opened.")
End IF

return 0	
	
	


end event

type rte_edi_file from u_rte within w_display_edi_file
int X=26
int Y=19
int Width=2425
int Height=1290
int TabOrder=10
boolean BringToTop=true
end type

on rte_edi_file.create
call super::create
HScrollBar=true
VScrollBar=true
BackColor=1090519039
InputFieldBackColor=1090519039
end on

type cb_saveas from u_cb within w_display_edi_file
int X=201
int Y=1344
int TabOrder=30
boolean BringToTop=true
string Text="Save As..."
end type

event clicked;rte_edi_file.Event pfc_saveas()
end event

type cb_print from u_cb within w_display_edi_file
int X=1028
int Y=1338
int TabOrder=20
boolean BringToTop=true
string Text="Print ..."
end type

event clicked;rte_edi_file.Event pfc_print( )
end event

type cb_close from u_cb within w_display_edi_file
int X=1924
int Y=1334
int TabOrder=11
boolean BringToTop=true
string Text="Close"
end type

event clicked;close(parent)
end event

