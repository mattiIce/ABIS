$PBExportHeader$w_maint_parts_management.srw
$PBExportComments$<main>main maintenance parts, inherited from  pfemain.pbl
forward
global type w_maint_parts_management from w_sheet
end type
type p_1 from u_p within w_maint_parts_management
end type
type dw_vendor_part_num from u_dw within w_maint_parts_management
end type
type dw_internal_id from u_dw within w_maint_parts_management
end type
type ddlb_e from u_ddlb within w_maint_parts_management
end type
type ddlb_i from u_ddlb within w_maint_parts_management
end type
type cb_serach from u_cb within w_maint_parts_management
end type
type rb_v from radiobutton within w_maint_parts_management
end type
type rb_i from radiobutton within w_maint_parts_management
end type
type cb_update from u_cb within w_maint_parts_management
end type
type dw_part from u_dw within w_maint_parts_management
end type
type cb_new from u_cb within w_maint_parts_management
end type
type cb_print from u_cb within w_maint_parts_management
end type
type cb_close from u_cb within w_maint_parts_management
end type
type gb_1 from groupbox within w_maint_parts_management
end type
end forward

global type w_maint_parts_management from w_sheet
integer x = 4
integer y = 3
integer width = 3076
integer height = 1706
string title = "Parts"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 8421376
event type string ue_whoami ( )
event ue_read_only ( )
p_1 p_1
dw_vendor_part_num dw_vendor_part_num
dw_internal_id dw_internal_id
ddlb_e ddlb_e
ddlb_i ddlb_i
cb_serach cb_serach
rb_v rb_v
rb_i rb_i
cb_update cb_update
dw_part dw_part
cb_new cb_new
cb_print cb_print
cb_close cb_close
gb_1 gb_1
end type
global w_maint_parts_management w_maint_parts_management

type variables
Long il_parts
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_parts_management"
end event

public function long wf_getnew_id (string id_name);Long ll_int_next_id
String ls_col_name

CHOOSE CASE id_name
CASE "Customer"
	ls_col_name = 'customer_id_seq'
	SELECT customer_id_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;
CASE "Customer_Contact"
	ls_Col_name = 'customer_contact_id_seq'
	SELECT customer_contact_id_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;
CASE ELSE
	Return -1
END CHOOSE

// generate next id using oracle sequence 
UPDATE sequence_key
SET sequence_curval = :ll_int_next_id
WHERE sequence_name = :ls_col_name
USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
	ROLLBACK using SQLCA;
	Return -2
ELSE
	COMMIT using SQLCA;
END IF

Return ll_int_next_id

end function

on w_maint_parts_management.create
int iCurrent
call super::create
this.p_1=create p_1
this.dw_vendor_part_num=create dw_vendor_part_num
this.dw_internal_id=create dw_internal_id
this.ddlb_e=create ddlb_e
this.ddlb_i=create ddlb_i
this.cb_serach=create cb_serach
this.rb_v=create rb_v
this.rb_i=create rb_i
this.cb_update=create cb_update
this.dw_part=create dw_part
this.cb_new=create cb_new
this.cb_print=create cb_print
this.cb_close=create cb_close
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.dw_vendor_part_num
this.Control[iCurrent+3]=this.dw_internal_id
this.Control[iCurrent+4]=this.ddlb_e
this.Control[iCurrent+5]=this.ddlb_i
this.Control[iCurrent+6]=this.cb_serach
this.Control[iCurrent+7]=this.rb_v
this.Control[iCurrent+8]=this.rb_i
this.Control[iCurrent+9]=this.cb_update
this.Control[iCurrent+10]=this.dw_part
this.Control[iCurrent+11]=this.cb_new
this.Control[iCurrent+12]=this.cb_print
this.Control[iCurrent+13]=this.cb_close
this.Control[iCurrent+14]=this.gb_1
end on

on w_maint_parts_management.destroy
call super::destroy
destroy(this.p_1)
destroy(this.dw_vendor_part_num)
destroy(this.dw_internal_id)
destroy(this.ddlb_e)
destroy(this.ddlb_i)
destroy(this.cb_serach)
destroy(this.rb_v)
destroy(this.rb_i)
destroy(this.cb_update)
destroy(this.dw_part)
destroy(this.cb_new)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event activate;call super::activate;IF f_security_door("Maintenance_parts") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event pfc_postopen;call super::pfc_postopen;dw_internal_id.Retrieve()

Long ll_row, ll_i
ll_row = dw_internal_id.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_i.AddItem(dw_internal_id.GetItemString(ll_i, "internal_id"))
	NEXT
END IF
ddlb_i.SelectItem(1)
ddlb_i.Event SelectionChanged(1)

dw_vendor_part_num.Retrieve()
ll_row = dw_vendor_part_num.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		IF Len(dw_vendor_part_num.GetItemString(ll_i, "vendor_part_number")) > 0 THEN
			ddlb_e.AddItem(dw_vendor_part_num.GetItemString(ll_i, "vendor_part_number"))
		END IF
	NEXT
END IF
ddlb_e.SelectItem(1)

end event

event open;call super::open;dw_internal_id.Visible = FALSE
dw_vendor_part_num.Visible = FALSE
end event

type p_1 from u_p within w_maint_parts_management
integer x = 1989
integer y = 339
integer width = 1042
integer height = 781
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_vendor_part_num from u_dw within w_maint_parts_management
integer x = 33
integer y = 1530
integer width = 176
integer height = 51
integer taborder = 80
string dataobject = "d_parts_vendor_part_num"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type dw_internal_id from u_dw within w_maint_parts_management
integer x = 33
integer y = 1462
integer width = 176
integer height = 51
integer taborder = 80
string dataobject = "d_parts_internal_id"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type ddlb_e from u_ddlb within w_maint_parts_management
integer x = 805
integer y = 198
integer width = 1170
integer height = 1270
integer taborder = 20
integer textsize = -9
string facename = "Arial"
boolean enabled = false
end type

event selectionchanged;call super::selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)

ll_row = dw_vendor_part_num.RowCount()
FOR ll_i = 1 TO ll_row
		IF dw_vendor_part_num.GetItemString(ll_i, "vendor_part_number") = ls_text THEN
				dw_vendor_part_num.Event RowFocusChanged(ll_i)
				dw_vendor_part_num.SelectRow(0, False)
				dw_vendor_part_num.SelectRow(ll_i, True)
				il_parts = dw_vendor_part_num.GetItemNumber(ll_i, "parts_id")				
		END IF
NEXT
dw_part.Retrieve(il_parts)

RETURN 1


end event

type ddlb_i from u_ddlb within w_maint_parts_management
integer x = 805
integer y = 106
integer width = 1170
integer height = 1270
integer taborder = 30
integer textsize = -9
string facename = "Arial"
end type

event selectionchanged;call super::selectionchanged;String ls_text
Long ll_row, ll_i, ll_flen, ll_new_pos
int li_filenum, li_loops, li_i
Blob lb_pic

ls_text = Text(index)

ll_row = dw_internal_id.RowCount()
FOR ll_i = 1 TO ll_row
		IF dw_internal_id.GetItemString(ll_i, "internal_id") = ls_text THEN
				dw_internal_id.Event RowFocusChanged(ll_i)
				dw_internal_id.SelectRow(0, False)
				dw_internal_id.SelectRow(ll_i, True)
				il_parts = dw_internal_id.GetItemNumber(ll_i, "parts_id")
		END IF
NEXT

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
	li_filenum = FileOpen(gs_Maint_Parts_file, StreamMode!, Write!, LockReadWrite!, Replace!)
	FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
	FileClose(li_FileNum)

	FOR li_i = 1 TO li_loops
		li_filenum = FileOpen(gs_Maint_Parts_file, StreamMode!, Write!, LockreadWrite!,Append!)
		FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
		FileClose(li_FileNum)
	NEXT

p_1.SetPicture(lb_pic)
dw_part.Reset()
dw_part.Retrieve(il_parts)

RETURN 1



end event

type cb_serach from u_cb within w_maint_parts_management
integer x = 2150
integer y = 96
integer width = 819
integer height = 138
integer taborder = 20
integer textsize = -12
string facename = "Arial"
string text = "Part Search"
end type

type rb_v from radiobutton within w_maint_parts_management
integer x = 44
integer y = 198
integer width = 684
integer height = 77
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "By Vendor Part Number"
end type

event clicked;If this.Checked THEN
	rb_i.Checked = FALSE
	ddlb_i.Enabled = FALSE
	ddlb_e.Enabled = TRUE
END IF
RETURN 1
end event

type rb_i from radiobutton within w_maint_parts_management
integer x = 44
integer y = 106
integer width = 475
integer height = 77
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "By Internal ID"
boolean checked = true
end type

event clicked;If this.Checked THEN
	rb_v.Checked = FALSE
	ddlb_e.Enabled = FALSE
	ddlb_i.Enabled = TRUE
END IF
RETURN 1
end event

type cb_update from u_cb within w_maint_parts_management
string tag = "Update Parts Info"
integer x = 918
integer y = 1469
integer width = 541
integer height = 115
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Update"
end type

event clicked;call super::clicked;If il_parts = 0 THEN
	MessageBox("Warning", "Please select a part.")
	RETURN 0
END IF
OpenWithParm(w_maint_parts_modify, il_parts)
IF Message.DoubleParm = 1 THEN //saved 
	dw_part.Retrieve(il_parts)
END IF
end event

type dw_part from u_dw within w_maint_parts_management
integer x = 11
integer y = 317
integer width = 3035
integer height = 1126
integer taborder = 10
string dataobject = "d_parts_details"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)
end event

type cb_new from u_cb within w_maint_parts_management
string tag = "New Parts"
integer x = 304
integer y = 1469
integer width = 541
integer height = 115
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New"
end type

event clicked;call super::clicked;Open(w_maint_parts_new)
end event

type cb_print from u_cb within w_maint_parts_management
string tag = "Print current parts"
integer x = 1532
integer y = 1469
integer width = 541
integer height = 115
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;If il_parts = 0 THEN
	MessageBox("Warning", "Please select a part.")
	RETURN 0
END IF
OpenWithParm(w_report_maint_parts_management, il_parts)
end event

type cb_close from u_cb within w_maint_parts_management
string tag = "Exit"
integer x = 2147
integer y = 1469
integer width = 541
integer height = 115
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_parts" 
gnv_app.of_getFrame().Event pfc_open()

end event

type gb_1 from groupbox within w_maint_parts_management
integer x = 11
integer y = 16
integer width = 2019
integer height = 285
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 67108864
string text = "Select a Parts"
end type

