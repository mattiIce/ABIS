$PBExportHeader$w_maint_parts_modify.srw
$PBExportComments$<main>modify existing parts, inherited from  pfemain.pbl
forward
global type w_maint_parts_modify from w_sheet
end type
type p_1 from u_p within w_maint_parts_modify
end type
type cb_pic from u_cb within w_maint_parts_modify
end type
type dw_part from u_dw within w_maint_parts_modify
end type
type cb_save from u_cb within w_maint_parts_modify
end type
type cb_close from u_cb within w_maint_parts_modify
end type
end forward

global type w_maint_parts_modify from w_sheet
integer x = 4
integer y = 3
integer width = 3083
integer height = 1382
string title = "Modify Existing Parts"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217747
event type string ue_whoami ( )
event ue_read_only ( )
p_1 p_1
cb_pic cb_pic
dw_part dw_part
cb_save cb_save
cb_close cb_close
end type
global w_maint_parts_modify w_maint_parts_modify

type variables
integer il_parts
Int ii_saved
Boolean ib_newbmp
Blob ib_pic
String is_docname
end variables

forward prototypes
public function blob wf_get_bmp ()
public function integer wf_save ()
public function integer wf_set_sketch_file ()
end prototypes

public function blob wf_get_bmp ();Integer li_filenum, li_loops, li_i
Long ll_flen, ll_bytes_read, ll_new_pos
blob lb_b, lb_tot_b
String ls_named
integer li_val

SetPointer(HourGlass!)

li_val = GetFileOpenName("Select File", is_docname, ls_named, "JPG", "JPEG Files (*.jpg),*.jpg" )
IF li_val <> 1 THEN
	SetNull(lb_tot_b)
	RETURN lb_tot_b 
END IF

ll_flen = FileLength(is_docname)
li_filenum = FileOpen(is_docname, StreamMode!, Read!, LockRead!)
IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
		li_loops = ll_flen / 32765
	ELSE
		li_loops = (ll_flen / 32765) + 1
	END IF
ELSE
	li_loops = 1
END IF

ll_new_pos = 1
FOR li_i = 1 TO li_loops
	ll_bytes_read = FileRead(li_FileNum, lb_b)
	lb_tot_b = lb_tot_b + lb_b
NEXT

FileClose(li_FileNum)

Return lb_tot_b
end function

public function integer wf_save ();dw_part.AcceptText()
dw_part.Event pfc_Update(TRUE,TRUE)

SetPointer(HourGlass!)

IF ib_newbmp THEN
	UPDATEBLOB parts
	SET parts_view = :ib_pic
	WHERE parts_id = :il_parts
	USING SQLCA;
	IF SQLCA.SQLCode >= 0 THEN
		COMMIT USING SQLCA;
		MessageBox("Info", "Information has been saved successfully.")
	ELSE
		MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
		Return -4
	END IF
END IF

ii_saved = 1
dw_part.ResetUpdate()

Return 1
end function

public function integer wf_set_sketch_file ();//copy current sketch to current directory sketch.bmp file
// and will be used in the production order report
Int li_filenum
Long ll_flen
Long ll_new_pos
Int li_loops, li_i
Blob lb_pic
Long ll_sid

SetPointer(HourGlass!)

SELECTBLOB parts_view 
INTO :lb_pic
FROM parts
WHERE parts_id = :il_parts
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return -1
END IF

ll_flen = Len(lb_pic)
IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
		li_loops = ll_flen / 32765
	ELSE
		li_loops = (ll_flen / 32765) + 1
	END IF
ELSE
	li_loops = 1
END IF

ll_new_pos = 1
li_filenum = FileOpen("Maint_parts.jpg", StreamMode!, Write!, LockReadWrite!, Replace!)
FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
FileClose(li_FileNum)

FOR li_i = 1 TO li_loops
	li_filenum = FileOpen("Maint_parts.jpg", StreamMode!, Write!, LockreadWrite!,Append!)
	FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
	FileClose(li_FileNum)
NEXT

Return 1
end function

on w_maint_parts_modify.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_pic=create cb_pic
this.dw_part=create dw_part
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_pic
this.Control[iCurrent+3]=this.dw_part
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_close
end on

on w_maint_parts_modify.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_pic)
destroy(this.dw_part)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event open;call super::open;il_parts = message.doubleparm
dw_part.Retrieve(il_parts)
this.title = "Updating Parts # :  " + String(il_parts)
dw_part.SetFocus()
ii_saved = 0

	SELECTBLOB parts_view 
	INTO :ib_pic
	FROM parts
	WHERE parts_id = :il_parts
	USING SQLCA;
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
		Return -1
	END IF
	p_1.SetPicture(ib_pic)
end event

type p_1 from u_p within w_maint_parts_modify
integer x = 1989
integer y = 32
integer width = 1031
integer height = 781
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_pic from u_cb within w_maint_parts_modify
string tag = "Update Picture"
integer x = 571
integer y = 1162
integer width = 541
integer height = 115
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Update Picture"
end type

event clicked;call super::clicked;ib_pic = wf_get_bmp()
IF IsNull(ib_pic) THEN Return 
p_1.SetPicture(ib_pic)
//dw_part.Modify("p_1.Filename='" + is_docname + "'")
ib_newbmp = TRUE
cb_save.Enabled = TRUE


end event

type dw_part from u_dw within w_maint_parts_modify
integer x = 7
integer y = 10
integer width = 3035
integer height = 1126
integer taborder = 10
string dataobject = "d_parts_new"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)
end event

event itemchanged;call super::itemchanged;cb_save.Enabled = TRUE
end event

type cb_save from u_cb within w_maint_parts_modify
string tag = "Save"
integer x = 1240
integer y = 1162
integer width = 541
integer height = 115
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

event clicked;call super::clicked;wf_save()
end event

type cb_close from u_cb within w_maint_parts_modify
string tag = "Exit"
integer x = 1883
integer y = 1162
integer width = 541
integer height = 115
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;long ll_row
Int li_rc
IF dw_part.Event pfc_UpdatesPending() = 1 THEN
	li_rc = MessageBox("Question", "Do you want to save updated information before closing?", Question!, YesNo!, 1)	
	IF li_rc = 1 THEN
		wf_Save()
	ELSE
		dw_part.ResetUpdate()
	END IF
END IF

IF ib_newbmp AND ii_saved = 1 THEN
	wf_set_sketch_file()
END IF
ClosewithReturn(parent, ii_saved)



end event

