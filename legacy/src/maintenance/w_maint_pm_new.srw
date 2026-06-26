$PBExportHeader$w_maint_pm_new.srw
$PBExportComments$<main>create a new PM
forward
global type w_maint_pm_new from w_sheet
end type
type dw_new from u_dw within w_maint_pm_new
end type
type pb_add from u_pb within w_maint_pm_new
end type
type st_19 from statictext within w_maint_pm_new
end type
type st_18 from statictext within w_maint_pm_new
end type
type pb_delete from u_pb within w_maint_pm_new
end type
type mle_details from u_mle within w_maint_pm_new
end type
type mle_item from u_mle within w_maint_pm_new
end type
type st_17 from statictext within w_maint_pm_new
end type
type ddlb_4 from u_ddlb within w_maint_pm_new
end type
type st_16 from statictext within w_maint_pm_new
end type
type ddlb_3 from u_ddlb within w_maint_pm_new
end type
type rb_3 from u_rb within w_maint_pm_new
end type
type rb_2 from u_rb within w_maint_pm_new
end type
type rb_1 from u_rb within w_maint_pm_new
end type
type cb_parts from u_cb within w_maint_pm_new
end type
type cb_print from u_cb within w_maint_pm_new
end type
type cb_pic from u_cb within w_maint_pm_new
end type
type mle_tailer from u_mle within w_maint_pm_new
end type
type mle_header from u_mle within w_maint_pm_new
end type
type ddlb_2 from u_ddlb within w_maint_pm_new
end type
type st_15 from statictext within w_maint_pm_new
end type
type em_totalhrs from u_em within w_maint_pm_new
end type
type st_14 from statictext within w_maint_pm_new
end type
type em_units from u_em within w_maint_pm_new
end type
type st_13 from statictext within w_maint_pm_new
end type
type em_minper from u_em within w_maint_pm_new
end type
type st_12 from statictext within w_maint_pm_new
end type
type em_cost from u_em within w_maint_pm_new
end type
type st_11 from statictext within w_maint_pm_new
end type
type st_10 from statictext within w_maint_pm_new
end type
type em_1 from u_em within w_maint_pm_new
end type
type st_9 from statictext within w_maint_pm_new
end type
type em_range from u_em within w_maint_pm_new
end type
type st_8 from statictext within w_maint_pm_new
end type
type em_nextdue from u_em within w_maint_pm_new
end type
type st_7 from statictext within w_maint_pm_new
end type
type em_complete from u_em within w_maint_pm_new
end type
type st_6 from statictext within w_maint_pm_new
end type
type st_5 from statictext within w_maint_pm_new
end type
type ddlb_1 from u_ddlb within w_maint_pm_new
end type
type st_2 from statictext within w_maint_pm_new
end type
type dw_itemdevice from u_dw within w_maint_pm_new
end type
type dw_grp from u_dw within w_maint_pm_new
end type
type dw_subsyseqp from u_dw within w_maint_pm_new
end type
type ddlb_i from u_ddlb within w_maint_pm_new
end type
type st_4 from statictext within w_maint_pm_new
end type
type ddlb_sub from u_ddlb within w_maint_pm_new
end type
type st_3 from statictext within w_maint_pm_new
end type
type ddlb_d from u_ddlb within w_maint_pm_new
end type
type st_1 from statictext within w_maint_pm_new
end type
type ddlb_status from u_ddlb within w_maint_pm_new
end type
type cb_save from u_cb within w_maint_pm_new
end type
type dw_pm from u_dw within w_maint_pm_new
end type
type cb_close from u_cb within w_maint_pm_new
end type
type gb_3 from groupbox within w_maint_pm_new
end type
type gb_1 from groupbox within w_maint_pm_new
end type
type gb_4 from groupbox within w_maint_pm_new
end type
type gb_5 from groupbox within w_maint_pm_new
end type
type gb_2 from groupbox within w_maint_pm_new
end type
end forward

global type w_maint_pm_new from w_sheet
integer x = 4
integer y = 3
integer width = 3632
integer height = 1952
string title = "New Preventive Maintenance"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 15793151
event type string ue_whoami ( )
event ue_read_only ( )
event type long ue_display_row ( )
event type long ue_pm_format_changed ( integer ai_type )
dw_new dw_new
pb_add pb_add
st_19 st_19
st_18 st_18
pb_delete pb_delete
mle_details mle_details
mle_item mle_item
st_17 st_17
ddlb_4 ddlb_4
st_16 st_16
ddlb_3 ddlb_3
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_parts cb_parts
cb_print cb_print
cb_pic cb_pic
mle_tailer mle_tailer
mle_header mle_header
ddlb_2 ddlb_2
st_15 st_15
em_totalhrs em_totalhrs
st_14 st_14
em_units em_units
st_13 st_13
em_minper em_minper
st_12 st_12
em_cost em_cost
st_11 st_11
st_10 st_10
em_1 em_1
st_9 st_9
em_range em_range
st_8 st_8
em_nextdue em_nextdue
st_7 st_7
em_complete em_complete
st_6 st_6
st_5 st_5
ddlb_1 ddlb_1
st_2 st_2
dw_itemdevice dw_itemdevice
dw_grp dw_grp
dw_subsyseqp dw_subsyseqp
ddlb_i ddlb_i
st_4 st_4
ddlb_sub ddlb_sub
st_3 st_3
ddlb_d ddlb_d
st_1 st_1
ddlb_status ddlb_status
cb_save cb_save
dw_pm dw_pm
cb_close cb_close
gb_3 gb_3
gb_1 gb_1
gb_4 gb_4
gb_5 gb_5
gb_2 gb_2
end type
global w_maint_pm_new w_maint_pm_new

type variables
Long il_pm
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_pm_management"
end event

event type long ue_display_row();
RETURN 1
end event

event type long ue_pm_format_changed(integer ai_type);dw_pm.Reset()

dw_pm.DataObject = "d_maint_pm_format_1"
CHOOSE CASE ai_type
	CASE 1
		dw_pm.DataObject = "d_maint_pm_format_1_new"
	CASE 2
		dw_pm.DataObject = "d_maint_pm_format_2_new"
	CASE 3
		dw_pm.DataObject = "d_maint_pm_format_3_new"
END CHOOSE
dw_pm.SetTransObject(SQLCA)


Int li_new_r, li_i, li_row

li_new_r = dw_new.RowCount()
IF li_new_r > 0 THEN
	FOR li_i = 1 TO li_new_r
		li_row = dw_pm.InsertRow(0)
		dw_pm.SetItem(li_row, "Action_Items", dw_new.GetItemString(li_i, "Action_items"))
		dw_pm.SetItem(li_row, "Item_details", dw_new.GetItemString(li_i, "Item_details"))
	NEXT
	dw_pm.ResetUpdate()
END IF

RETURN li_new_r
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

on w_maint_pm_new.create
int iCurrent
call super::create
this.dw_new=create dw_new
this.pb_add=create pb_add
this.st_19=create st_19
this.st_18=create st_18
this.pb_delete=create pb_delete
this.mle_details=create mle_details
this.mle_item=create mle_item
this.st_17=create st_17
this.ddlb_4=create ddlb_4
this.st_16=create st_16
this.ddlb_3=create ddlb_3
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_parts=create cb_parts
this.cb_print=create cb_print
this.cb_pic=create cb_pic
this.mle_tailer=create mle_tailer
this.mle_header=create mle_header
this.ddlb_2=create ddlb_2
this.st_15=create st_15
this.em_totalhrs=create em_totalhrs
this.st_14=create st_14
this.em_units=create em_units
this.st_13=create st_13
this.em_minper=create em_minper
this.st_12=create st_12
this.em_cost=create em_cost
this.st_11=create st_11
this.st_10=create st_10
this.em_1=create em_1
this.st_9=create st_9
this.em_range=create em_range
this.st_8=create st_8
this.em_nextdue=create em_nextdue
this.st_7=create st_7
this.em_complete=create em_complete
this.st_6=create st_6
this.st_5=create st_5
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.dw_itemdevice=create dw_itemdevice
this.dw_grp=create dw_grp
this.dw_subsyseqp=create dw_subsyseqp
this.ddlb_i=create ddlb_i
this.st_4=create st_4
this.ddlb_sub=create ddlb_sub
this.st_3=create st_3
this.ddlb_d=create ddlb_d
this.st_1=create st_1
this.ddlb_status=create ddlb_status
this.cb_save=create cb_save
this.dw_pm=create dw_pm
this.cb_close=create cb_close
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_new
this.Control[iCurrent+2]=this.pb_add
this.Control[iCurrent+3]=this.st_19
this.Control[iCurrent+4]=this.st_18
this.Control[iCurrent+5]=this.pb_delete
this.Control[iCurrent+6]=this.mle_details
this.Control[iCurrent+7]=this.mle_item
this.Control[iCurrent+8]=this.st_17
this.Control[iCurrent+9]=this.ddlb_4
this.Control[iCurrent+10]=this.st_16
this.Control[iCurrent+11]=this.ddlb_3
this.Control[iCurrent+12]=this.rb_3
this.Control[iCurrent+13]=this.rb_2
this.Control[iCurrent+14]=this.rb_1
this.Control[iCurrent+15]=this.cb_parts
this.Control[iCurrent+16]=this.cb_print
this.Control[iCurrent+17]=this.cb_pic
this.Control[iCurrent+18]=this.mle_tailer
this.Control[iCurrent+19]=this.mle_header
this.Control[iCurrent+20]=this.ddlb_2
this.Control[iCurrent+21]=this.st_15
this.Control[iCurrent+22]=this.em_totalhrs
this.Control[iCurrent+23]=this.st_14
this.Control[iCurrent+24]=this.em_units
this.Control[iCurrent+25]=this.st_13
this.Control[iCurrent+26]=this.em_minper
this.Control[iCurrent+27]=this.st_12
this.Control[iCurrent+28]=this.em_cost
this.Control[iCurrent+29]=this.st_11
this.Control[iCurrent+30]=this.st_10
this.Control[iCurrent+31]=this.em_1
this.Control[iCurrent+32]=this.st_9
this.Control[iCurrent+33]=this.em_range
this.Control[iCurrent+34]=this.st_8
this.Control[iCurrent+35]=this.em_nextdue
this.Control[iCurrent+36]=this.st_7
this.Control[iCurrent+37]=this.em_complete
this.Control[iCurrent+38]=this.st_6
this.Control[iCurrent+39]=this.st_5
this.Control[iCurrent+40]=this.ddlb_1
this.Control[iCurrent+41]=this.st_2
this.Control[iCurrent+42]=this.dw_itemdevice
this.Control[iCurrent+43]=this.dw_grp
this.Control[iCurrent+44]=this.dw_subsyseqp
this.Control[iCurrent+45]=this.ddlb_i
this.Control[iCurrent+46]=this.st_4
this.Control[iCurrent+47]=this.ddlb_sub
this.Control[iCurrent+48]=this.st_3
this.Control[iCurrent+49]=this.ddlb_d
this.Control[iCurrent+50]=this.st_1
this.Control[iCurrent+51]=this.ddlb_status
this.Control[iCurrent+52]=this.cb_save
this.Control[iCurrent+53]=this.dw_pm
this.Control[iCurrent+54]=this.cb_close
this.Control[iCurrent+55]=this.gb_3
this.Control[iCurrent+56]=this.gb_1
this.Control[iCurrent+57]=this.gb_4
this.Control[iCurrent+58]=this.gb_5
this.Control[iCurrent+59]=this.gb_2
end on

on w_maint_pm_new.destroy
call super::destroy
destroy(this.dw_new)
destroy(this.pb_add)
destroy(this.st_19)
destroy(this.st_18)
destroy(this.pb_delete)
destroy(this.mle_details)
destroy(this.mle_item)
destroy(this.st_17)
destroy(this.ddlb_4)
destroy(this.st_16)
destroy(this.ddlb_3)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_parts)
destroy(this.cb_print)
destroy(this.cb_pic)
destroy(this.mle_tailer)
destroy(this.mle_header)
destroy(this.ddlb_2)
destroy(this.st_15)
destroy(this.em_totalhrs)
destroy(this.st_14)
destroy(this.em_units)
destroy(this.st_13)
destroy(this.em_minper)
destroy(this.st_12)
destroy(this.em_cost)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.em_1)
destroy(this.st_9)
destroy(this.em_range)
destroy(this.st_8)
destroy(this.em_nextdue)
destroy(this.st_7)
destroy(this.em_complete)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.dw_itemdevice)
destroy(this.dw_grp)
destroy(this.dw_subsyseqp)
destroy(this.ddlb_i)
destroy(this.st_4)
destroy(this.ddlb_sub)
destroy(this.st_3)
destroy(this.ddlb_d)
destroy(this.st_1)
destroy(this.ddlb_status)
destroy(this.cb_save)
destroy(this.dw_pm)
destroy(this.cb_close)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_2)
end on

event activate;call super::activate;IF f_security_door("Maintenance_pm") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type dw_new from u_dw within w_maint_pm_new
integer x = 3266
integer y = 1808
integer width = 157
integer height = 42
integer taborder = 110
boolean enabled = false
string dataobject = "d_maint_pm_new"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetBase(TRUE)
SetTransObject(SQLCA)
this.Retrieve(il_pm)
end event

type pb_add from u_pb within w_maint_pm_new
integer x = 3482
integer y = 1165
integer width = 80
integer height = 70
integer taborder = 110
string text = ""
string picturename = "Insert5!"
string powertiptext = "Insert row"
end type

event clicked;call super::clicked;Int li_row, li_new_r, li_i
String ls_item

IF Len(mle_item.Text) = 0 AND Len(mle_details.Text) = 0 THEN
	MessageBox("Warning", "Nothing can be added.")
	RETURN 0
END IF

li_row = dw_new.InsertRow(0)
IF li_row > 0 THEN
	
	IF Len(mle_item.Text) = 0 THEN
		ls_item = '.'
	ELSE
		ls_item = mle_item.Text
	END IF
	
	dw_new.SetItem(li_row, "Action_Items", ls_item)
	dw_new.SetItem(li_row, "Item_details", mle_details.Text)
	dw_new.SetItem(li_row, "pm_id", il_pm)	
END IF

li_new_r = dw_new.RowCount()
IF li_new_r > 0 THEN
	dw_pm.Reset()
	FOR li_i = 1 TO li_new_r
		li_row = dw_pm.InsertRow(0)
		dw_pm.SetItem(li_row, "Action_Items", dw_new.GetItemString(li_i, "Action_items"))
		dw_pm.SetItem(li_row, "Item_details", dw_new.GetItemString(li_i, "Item_details"))
	NEXT
	dw_pm.ResetUpdate()
END IF

RETURN li_row

end event

type st_19 from statictext within w_maint_pm_new
integer x = 2619
integer y = 762
integer width = 285
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Item Details"
boolean focusrectangle = false
end type

type st_18 from statictext within w_maint_pm_new
integer x = 2615
integer y = 480
integer width = 362
integer height = 58
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "PM Action Item"
boolean focusrectangle = false
end type

type pb_delete from u_pb within w_maint_pm_new
integer x = 2509
integer y = 1184
integer width = 80
integer height = 70
integer taborder = 110
string text = ""
string picturename = "DeleteRow!"
string powertiptext = "Delete row"
end type

event clicked;call super::clicked;Long li_row

li_row = dw_pm.GetRow()
IF li_row > 0 THEN
	dw_pm.DeleteRow(li_row)
END IF

RETURN li_row
end event

type mle_details from u_mle within w_maint_pm_new
integer x = 2615
integer y = 822
integer width = 951
integer height = 339
integer taborder = 110
string facename = "Arial"
end type

type mle_item from u_mle within w_maint_pm_new
integer x = 2615
integer y = 541
integer width = 951
integer height = 211
integer taborder = 100
string facename = "Arial"
end type

type st_17 from statictext within w_maint_pm_new
integer x = 724
integer y = 64
integer width = 549
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Group Department"
boolean focusrectangle = false
end type

type ddlb_4 from u_ddlb within w_maint_pm_new
integer x = 1335
integer y = 51
integer width = 797
integer height = 1270
integer taborder = 80
integer textsize = -9
string facename = "Arial"
end type

type st_16 from statictext within w_maint_pm_new
integer x = 2154
integer y = 61
integer width = 421
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Sytem Equipment"
boolean focusrectangle = false
end type

type ddlb_3 from u_ddlb within w_maint_pm_new
integer x = 2578
integer y = 51
integer width = 955
integer height = 1270
integer taborder = 80
integer textsize = -9
string facename = "Arial"
end type

type rb_3 from u_rb within w_maint_pm_new
integer x = 402
integer y = 99
integer width = 132
string facename = "Arial"
long backcolor = 15793151
string text = "3"
end type

event clicked;call super::clicked;RETURN Parent.Event ue_pm_format_changed(3)
end event

type rb_2 from u_rb within w_maint_pm_new
integer x = 260
integer y = 99
integer width = 132
string facename = "Arial"
long backcolor = 15793151
string text = "2"
end type

event clicked;call super::clicked;RETURN Parent.Event ue_pm_format_changed(2)
end event

type rb_1 from u_rb within w_maint_pm_new
integer x = 117
integer y = 99
integer width = 132
string facename = "Arial"
long backcolor = 15793151
string text = "1"
boolean checked = true
end type

event clicked;call super::clicked;RETURN Parent.Event ue_pm_format_changed(1)
end event

type cb_parts from u_cb within w_maint_pm_new
string tag = "Parts for new PM"
integer x = 889
integer y = 1741
integer width = 541
integer height = 115
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "P&arts Req~'d"
end type

type cb_print from u_cb within w_maint_pm_new
string tag = "Print new PM"
integer x = 300
integer y = 1741
integer width = 541
integer height = 115
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "P&rint"
end type

type cb_pic from u_cb within w_maint_pm_new
string tag = "Save new PM"
integer x = 1477
integer y = 1741
integer width = 541
integer height = 115
integer taborder = 120
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Pictures"
end type

type mle_tailer from u_mle within w_maint_pm_new
integer x = 40
integer y = 1264
integer width = 3540
integer height = 154
integer taborder = 100
string facename = "Arial"
end type

type mle_header from u_mle within w_maint_pm_new
integer x = 40
integer y = 278
integer width = 3536
integer height = 128
integer taborder = 60
string facename = "Arial"
end type

type ddlb_2 from u_ddlb within w_maint_pm_new
integer x = 1635
integer y = 1501
integer width = 344
integer height = 394
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type st_15 from statictext within w_maint_pm_new
integer x = 1492
integer y = 1504
integer width = 150
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Shift:"
boolean focusrectangle = false
end type

type em_totalhrs from u_em within w_maint_pm_new
integer x = 2655
integer y = 1654
integer width = 300
integer height = 67
integer taborder = 80
string facename = "Arial"
string mask = "#####.##"
end type

type st_14 from statictext within w_maint_pm_new
integer x = 2260
integer y = 1658
integer width = 377
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 15793151
string text = " = Total PM Hrs:"
boolean focusrectangle = false
end type

type em_units from u_em within w_maint_pm_new
integer x = 2019
integer y = 1654
integer width = 208
integer height = 67
integer taborder = 80
string facename = "Arial"
string mask = "#####"
end type

type st_13 from statictext within w_maint_pm_new
integer x = 1777
integer y = 1661
integer width = 227
integer height = 54
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 15793151
string text = " X # Units"
boolean focusrectangle = false
end type

type em_minper from u_em within w_maint_pm_new
integer x = 1558
integer y = 1654
integer width = 208
integer height = 67
integer taborder = 80
string facename = "Arial"
string mask = "#####"
end type

type st_12 from statictext within w_maint_pm_new
integer x = 1335
integer y = 1658
integer width = 216
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 15793151
string text = "Min Per:"
boolean focusrectangle = false
end type

type em_cost from u_em within w_maint_pm_new
integer x = 870
integer y = 1654
integer width = 355
integer height = 67
integer taborder = 70
string facename = "Arial"
string mask = "#####.##"
end type

type st_11 from statictext within w_maint_pm_new
integer x = 629
integer y = 1654
integer width = 238
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 15793151
string text = "PM Cost:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_maint_pm_new
integer x = 2882
integer y = 1584
integer width = 139
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 15793151
string text = "Days"
boolean focusrectangle = false
end type

type em_1 from u_em within w_maint_pm_new
integer x = 2659
integer y = 1584
integer width = 208
integer height = 67
integer taborder = 70
string facename = "Arial"
string mask = "#####"
end type

type st_9 from statictext within w_maint_pm_new
integer x = 2289
integer y = 1584
integer width = 355
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 15793151
string text = "Repeats Every:"
boolean focusrectangle = false
end type

type em_range from u_em within w_maint_pm_new
integer x = 2052
integer y = 1584
integer width = 208
integer height = 67
integer taborder = 60
string facename = "Arial"
string mask = "#####"
end type

type st_8 from statictext within w_maint_pm_new
integer x = 1869
integer y = 1584
integer width = 197
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 15793151
string text = "Range:"
boolean focusrectangle = false
end type

type em_nextdue from u_em within w_maint_pm_new
integer x = 1565
integer y = 1584
integer width = 278
integer height = 67
integer taborder = 60
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "MM/DD/YYYY"
end type

type st_7 from statictext within w_maint_pm_new
integer x = 1181
integer y = 1584
integer width = 358
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 15793151
string text = "Next Due Date:"
boolean focusrectangle = false
end type

type em_complete from u_em within w_maint_pm_new
integer x = 889
integer y = 1584
integer width = 278
integer height = 67
integer taborder = 50
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "MM/DD/YYYY"
end type

type st_6 from statictext within w_maint_pm_new
integer x = 603
integer y = 1584
integer width = 278
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 15793151
string text = "Completed:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_maint_pm_new
integer x = 2008
integer y = 1504
integer width = 271
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Frequency:"
boolean focusrectangle = false
end type

type ddlb_1 from u_ddlb within w_maint_pm_new
integer x = 2282
integer y = 1498
integer width = 344
integer height = 394
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type st_2 from statictext within w_maint_pm_new
integer x = 80
integer y = 1504
integer width = 183
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Status:"
boolean focusrectangle = false
end type

type dw_itemdevice from u_dw within w_maint_pm_new
integer x = 3266
integer y = 1750
integer width = 157
integer height = 42
integer taborder = 110
string dataobject = "d_maint_itemdevice"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type dw_grp from u_dw within w_maint_pm_new
integer x = 3416
integer y = 1786
integer width = 157
integer height = 42
integer taborder = 100
string dataobject = "d_maint_groupdept"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type dw_subsyseqp from u_dw within w_maint_pm_new
integer x = 3412
integer y = 1741
integer width = 157
integer height = 42
integer taborder = 100
string dataobject = "d_maint_subsysequip"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type ddlb_i from u_ddlb within w_maint_pm_new
integer x = 2578
integer y = 131
integer width = 955
integer height = 1270
integer taborder = 90
integer textsize = -9
string facename = "Arial"
end type

type st_4 from statictext within w_maint_pm_new
integer x = 2209
integer y = 131
integer width = 373
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Item or Device"
boolean focusrectangle = false
end type

type ddlb_sub from u_ddlb within w_maint_pm_new
integer x = 1335
integer y = 131
integer width = 797
integer height = 1270
integer taborder = 80
integer textsize = -9
string facename = "Arial"
end type

type st_3 from statictext within w_maint_pm_new
integer x = 724
integer y = 131
integer width = 549
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Sub-System Equipment"
boolean focusrectangle = false
end type

type ddlb_d from u_ddlb within w_maint_pm_new
integer x = 958
integer y = 1501
integer width = 527
integer height = 285
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event selectionchanged;call super::selectionchanged;//String ls_text
//Long ll_row, ll_i, ll_flen, ll_new_pos
//int li_filenum, li_loops, li_i
//Blob lb_pic
//
//ls_text = Text(index)
//
//ll_row = dw_internal_id.RowCount()
//FOR ll_i = 1 TO ll_row
//		IF dw_internal_id.GetItemString(ll_i, "internal_id") = ls_text THEN
//				dw_internal_id.Event RowFocusChanged(ll_i)
//				dw_internal_id.SelectRow(0, False)
//				dw_internal_id.SelectRow(ll_i, True)
//				il_parts = dw_internal_id.GetItemNumber(ll_i, "parts_id")
//		END IF
//NEXT
//
//	SELECTBLOB parts_view 
//	INTO :lb_pic
//	FROM parts
//	WHERE parts_id = :il_parts
//	USING SQLCA;
//	IF SQLCA.SQLCode = -1 THEN
//		MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
//		Return -1
//	END IF
//
//	ll_flen = Len(lb_pic)
//	IF ll_flen > 32765 THEN
//		IF Mod(ll_flen, 32765) = 0 THEN
//			li_loops = ll_flen / 32765
//		ELSE
//			li_loops = (ll_flen / 32765) + 1
//		END IF
//	ELSE
//		li_loops = 1
//	END IF
//
//	ll_new_pos = 1
//	li_filenum = FileOpen(gs_Maint_Parts_file, StreamMode!, Write!, LockReadWrite!, Replace!)
//	FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
//	FileClose(li_FileNum)
//
//	FOR li_i = 1 TO li_loops
//		li_filenum = FileOpen(gs_Maint_Parts_file, StreamMode!, Write!, LockreadWrite!,Append!)
//		FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
//		FileClose(li_FileNum)
//	NEXT
//
//p_1.SetPicture(lb_pic)
//dw_part.Reset()
//dw_part.Retrieve(il_parts)

RETURN 1



end event

type st_1 from statictext within w_maint_pm_new
integer x = 655
integer y = 1504
integer width = 293
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Assigned to:"
boolean focusrectangle = false
end type

type ddlb_status from u_ddlb within w_maint_pm_new
integer x = 267
integer y = 1501
integer width = 380
integer height = 342
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type cb_save from u_cb within w_maint_pm_new
string tag = "Save new PM"
integer x = 2066
integer y = 1741
integer width = 541
integer height = 115
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

type dw_pm from u_dw within w_maint_pm_new
integer x = 40
integer y = 410
integer width = 2553
integer height = 774
integer taborder = 90
string dataobject = "d_maint_pm_format_1_new"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type cb_close from u_cb within w_maint_pm_new
string tag = "Exit"
integer x = 2655
integer y = 1741
integer width = 541
integer height = 115
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;ClosewithReturn(parent,il_pm )


end event

type gb_3 from groupbox within w_maint_pm_new
integer x = 15
integer y = 10
integer width = 618
integer height = 208
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "Step 1: Select a PM style"
end type

type gb_1 from groupbox within w_maint_pm_new
integer x = 662
integer y = 10
integer width = 2944
integer height = 208
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "Step 2: Select location/item"
end type

type gb_4 from groupbox within w_maint_pm_new
integer x = 11
integer y = 1446
integer width = 3591
integer height = 291
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "Step 4: Misc PM Details"
end type

type gb_5 from groupbox within w_maint_pm_new
integer x = 2600
integer y = 406
integer width = 987
integer height = 845
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "Input"
end type

type gb_2 from groupbox within w_maint_pm_new
integer x = 11
integer y = 224
integer width = 3591
integer height = 1213
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "Step 3: Action Details"
end type

