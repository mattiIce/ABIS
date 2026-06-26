$PBExportHeader$w_maint_pm_management.srw
$PBExportComments$<main>main maintenance PMs, inherited from  pfemain.pbl
forward
global type w_maint_pm_management from w_sheet
end type
type mle_tailer from u_mle within w_maint_pm_management
end type
type mle_header from u_mle within w_maint_pm_management
end type
type ddlb_2 from u_ddlb within w_maint_pm_management
end type
type st_15 from statictext within w_maint_pm_management
end type
type em_totalhrs from u_em within w_maint_pm_management
end type
type st_14 from statictext within w_maint_pm_management
end type
type em_units from u_em within w_maint_pm_management
end type
type st_13 from statictext within w_maint_pm_management
end type
type em_minper from u_em within w_maint_pm_management
end type
type st_12 from statictext within w_maint_pm_management
end type
type em_cost from u_em within w_maint_pm_management
end type
type st_11 from statictext within w_maint_pm_management
end type
type st_10 from statictext within w_maint_pm_management
end type
type em_1 from u_em within w_maint_pm_management
end type
type st_9 from statictext within w_maint_pm_management
end type
type em_range from u_em within w_maint_pm_management
end type
type st_8 from statictext within w_maint_pm_management
end type
type em_nextdue from u_em within w_maint_pm_management
end type
type st_7 from statictext within w_maint_pm_management
end type
type em_complete from u_em within w_maint_pm_management
end type
type st_6 from statictext within w_maint_pm_management
end type
type st_5 from statictext within w_maint_pm_management
end type
type ddlb_1 from u_ddlb within w_maint_pm_management
end type
type st_2 from statictext within w_maint_pm_management
end type
type dw_itemdevice from u_dw within w_maint_pm_management
end type
type dw_grp from u_dw within w_maint_pm_management
end type
type dw_subsyseqp from u_dw within w_maint_pm_management
end type
type ddlb_i from u_ddlb within w_maint_pm_management
end type
type st_4 from statictext within w_maint_pm_management
end type
type ddlb_sub from u_ddlb within w_maint_pm_management
end type
type st_3 from statictext within w_maint_pm_management
end type
type ddlb_d from u_ddlb within w_maint_pm_management
end type
type st_1 from statictext within w_maint_pm_management
end type
type ddlb_status from u_ddlb within w_maint_pm_management
end type
type cb_report from u_cb within w_maint_pm_management
end type
type dw_pm from u_dw within w_maint_pm_management
end type
type dw_list from u_dw within w_maint_pm_management
end type
type cb_print from u_cb within w_maint_pm_management
end type
type cb_parts from u_cb within w_maint_pm_management
end type
type cb_pictures from u_cb within w_maint_pm_management
end type
type cb_update from u_cb within w_maint_pm_management
end type
type pb_last from u_pb within w_maint_pm_management
end type
type pb_first from u_pb within w_maint_pm_management
end type
type cb_find from u_cb within w_maint_pm_management
end type
type pb_prior from u_pb within w_maint_pm_management
end type
type pb_next from u_pb within w_maint_pm_management
end type
type cb_new from u_cb within w_maint_pm_management
end type
type cb_close from u_cb within w_maint_pm_management
end type
type gb_3 from groupbox within w_maint_pm_management
end type
type gb_pm from groupbox within w_maint_pm_management
end type
end forward

global type w_maint_pm_management from w_sheet
integer x = 4
integer y = 3
integer width = 3632
integer height = 1789
string title = "Preventive Maintenance Management"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
event type string ue_whoami ( )
event ue_read_only ( )
event type long ue_display_row ( )
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
cb_report cb_report
dw_pm dw_pm
dw_list dw_list
cb_print cb_print
cb_parts cb_parts
cb_pictures cb_pictures
cb_update cb_update
pb_last pb_last
pb_first pb_first
cb_find cb_find
pb_prior pb_prior
pb_next pb_next
cb_new cb_new
cb_close cb_close
gb_3 gb_3
gb_pm gb_pm
end type
global w_maint_pm_management w_maint_pm_management

type variables
Long il_pm
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_pm_management"
end event

event type long ue_display_row();Long ll_currow, ll_row, ll_style

ll_row = dw_list.RowCount()
ll_currow = dw_list.GetRow()

IF ll_row < 1 THEN Return 0
IF ll_currow < 1 THEN Return 0

il_pm = dw_list.GetItemNumber(ll_currow, "pm_pm_id")
ll_style = dw_list.GetItemNumber(ll_currow, "pm_display_style")
mle_header.Text = dw_list.GetItemString(ll_currow, "pm_pm_action_header")
mle_tailer.Text = dw_list.GetItemString(ll_currow, "pm_pm_action_tailer")

gb_pm.Text = "ID : " + String(il_pm)

dw_pm.DataObject = "d_maint_pm_format_1"
CHOOSE CASE ll_style
	CASE 1
		dw_pm.DataObject = "d_maint_pm_format_1"
	CASE 2
		dw_pm.DataObject = "d_maint_pm_format_2"
	CASE 3
		dw_pm.DataObject = "d_maint_pm_format_3"
END CHOOSE
dw_pm.SetTransObject(SQLCA)
dw_pm.Retrieve(il_pm)

RETURN 1
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

on w_maint_pm_management.create
int iCurrent
call super::create
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
this.cb_report=create cb_report
this.dw_pm=create dw_pm
this.dw_list=create dw_list
this.cb_print=create cb_print
this.cb_parts=create cb_parts
this.cb_pictures=create cb_pictures
this.cb_update=create cb_update
this.pb_last=create pb_last
this.pb_first=create pb_first
this.cb_find=create cb_find
this.pb_prior=create pb_prior
this.pb_next=create pb_next
this.cb_new=create cb_new
this.cb_close=create cb_close
this.gb_3=create gb_3
this.gb_pm=create gb_pm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_tailer
this.Control[iCurrent+2]=this.mle_header
this.Control[iCurrent+3]=this.ddlb_2
this.Control[iCurrent+4]=this.st_15
this.Control[iCurrent+5]=this.em_totalhrs
this.Control[iCurrent+6]=this.st_14
this.Control[iCurrent+7]=this.em_units
this.Control[iCurrent+8]=this.st_13
this.Control[iCurrent+9]=this.em_minper
this.Control[iCurrent+10]=this.st_12
this.Control[iCurrent+11]=this.em_cost
this.Control[iCurrent+12]=this.st_11
this.Control[iCurrent+13]=this.st_10
this.Control[iCurrent+14]=this.em_1
this.Control[iCurrent+15]=this.st_9
this.Control[iCurrent+16]=this.em_range
this.Control[iCurrent+17]=this.st_8
this.Control[iCurrent+18]=this.em_nextdue
this.Control[iCurrent+19]=this.st_7
this.Control[iCurrent+20]=this.em_complete
this.Control[iCurrent+21]=this.st_6
this.Control[iCurrent+22]=this.st_5
this.Control[iCurrent+23]=this.ddlb_1
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.dw_itemdevice
this.Control[iCurrent+26]=this.dw_grp
this.Control[iCurrent+27]=this.dw_subsyseqp
this.Control[iCurrent+28]=this.ddlb_i
this.Control[iCurrent+29]=this.st_4
this.Control[iCurrent+30]=this.ddlb_sub
this.Control[iCurrent+31]=this.st_3
this.Control[iCurrent+32]=this.ddlb_d
this.Control[iCurrent+33]=this.st_1
this.Control[iCurrent+34]=this.ddlb_status
this.Control[iCurrent+35]=this.cb_report
this.Control[iCurrent+36]=this.dw_pm
this.Control[iCurrent+37]=this.dw_list
this.Control[iCurrent+38]=this.cb_print
this.Control[iCurrent+39]=this.cb_parts
this.Control[iCurrent+40]=this.cb_pictures
this.Control[iCurrent+41]=this.cb_update
this.Control[iCurrent+42]=this.pb_last
this.Control[iCurrent+43]=this.pb_first
this.Control[iCurrent+44]=this.cb_find
this.Control[iCurrent+45]=this.pb_prior
this.Control[iCurrent+46]=this.pb_next
this.Control[iCurrent+47]=this.cb_new
this.Control[iCurrent+48]=this.cb_close
this.Control[iCurrent+49]=this.gb_3
this.Control[iCurrent+50]=this.gb_pm
end on

on w_maint_pm_management.destroy
call super::destroy
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
destroy(this.cb_report)
destroy(this.dw_pm)
destroy(this.dw_list)
destroy(this.cb_print)
destroy(this.cb_parts)
destroy(this.cb_pictures)
destroy(this.cb_update)
destroy(this.pb_last)
destroy(this.pb_first)
destroy(this.cb_find)
destroy(this.pb_prior)
destroy(this.pb_next)
destroy(this.cb_new)
destroy(this.cb_close)
destroy(this.gb_3)
destroy(this.gb_pm)
end on

event activate;call super::activate;IF f_security_door("Maintenance_pm") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event open;call super::open;IF dw_list.Event pfc_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_maint_pm_management::open function" )
Else
	SQLCA.of_Commit()
End IF

end event

type mle_tailer from u_mle within w_maint_pm_management
integer x = 1035
integer y = 1123
integer width = 2549
integer height = 154
integer taborder = 100
string facename = "Arial"
end type

type mle_header from u_mle within w_maint_pm_management
integer x = 1035
integer y = 157
integer width = 2549
integer height = 182
integer taborder = 60
string facename = "Arial"
end type

type ddlb_2 from u_ddlb within w_maint_pm_management
integer x = 2604
integer y = 1286
integer width = 344
integer height = 394
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type st_15 from statictext within w_maint_pm_management
integer x = 2461
integer y = 1290
integer width = 150
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
string text = "Shift:"
boolean focusrectangle = false
end type

type em_totalhrs from u_em within w_maint_pm_management
integer x = 3152
integer y = 1434
integer width = 300
integer height = 67
integer taborder = 80
string facename = "Arial"
string mask = "#####.##"
end type

type st_14 from statictext within w_maint_pm_management
integer x = 2761
integer y = 1434
integer width = 377
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12639424
string text = " = Total PM Hrs:"
boolean focusrectangle = false
end type

type em_units from u_em within w_maint_pm_management
integer x = 2516
integer y = 1434
integer width = 208
integer height = 67
integer taborder = 80
string facename = "Arial"
string mask = "#####"
end type

type st_13 from statictext within w_maint_pm_management
integer x = 2271
integer y = 1434
integer width = 227
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12639424
string text = " X # Units"
boolean focusrectangle = false
end type

type em_minper from u_em within w_maint_pm_management
integer x = 2055
integer y = 1434
integer width = 208
integer height = 67
integer taborder = 80
string facename = "Arial"
string mask = "#####"
end type

type st_12 from statictext within w_maint_pm_management
integer x = 1832
integer y = 1434
integer width = 216
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12639424
string text = "Min Per:"
boolean focusrectangle = false
end type

type em_cost from u_em within w_maint_pm_management
integer x = 1368
integer y = 1434
integer width = 355
integer height = 67
integer taborder = 70
string facename = "Arial"
string mask = "#####.##"
end type

type st_11 from statictext within w_maint_pm_management
integer x = 1119
integer y = 1434
integer width = 238
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12639424
string text = "PM Cost:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_maint_pm_management
integer x = 3379
integer y = 1363
integer width = 139
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12639424
string text = "Days"
boolean focusrectangle = false
end type

type em_1 from u_em within w_maint_pm_management
integer x = 3156
integer y = 1363
integer width = 208
integer height = 67
integer taborder = 70
string facename = "Arial"
string mask = "#####"
end type

type st_9 from statictext within w_maint_pm_management
integer x = 2787
integer y = 1363
integer width = 355
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12639424
string text = "Repeats Every:"
boolean focusrectangle = false
end type

type em_range from u_em within w_maint_pm_management
integer x = 2549
integer y = 1363
integer width = 208
integer height = 67
integer taborder = 60
string facename = "Arial"
string mask = "#####"
end type

type st_8 from statictext within w_maint_pm_management
integer x = 2366
integer y = 1363
integer width = 197
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12639424
string text = "Range:"
boolean focusrectangle = false
end type

type em_nextdue from u_em within w_maint_pm_management
integer x = 2063
integer y = 1363
integer width = 278
integer height = 67
integer taborder = 60
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "MM/DD/YYYY"
end type

type st_7 from statictext within w_maint_pm_management
integer x = 1679
integer y = 1363
integer width = 358
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12639424
string text = "Next Due Date:"
boolean focusrectangle = false
end type

type em_complete from u_em within w_maint_pm_management
integer x = 1386
integer y = 1363
integer width = 278
integer height = 67
integer taborder = 50
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "MM/DD/YYYY"
end type

type st_6 from statictext within w_maint_pm_management
integer x = 1093
integer y = 1363
integer width = 278
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12639424
string text = "Completed:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_maint_pm_management
integer x = 2977
integer y = 1290
integer width = 271
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
string text = "Frequency:"
boolean focusrectangle = false
end type

type ddlb_1 from u_ddlb within w_maint_pm_management
integer x = 3251
integer y = 1283
integer width = 344
integer height = 394
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type st_2 from statictext within w_maint_pm_management
integer x = 1042
integer y = 1290
integer width = 183
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
string text = "Status:"
boolean focusrectangle = false
end type

type dw_itemdevice from u_dw within w_maint_pm_management
integer x = 3141
integer y = 1610
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

type dw_grp from u_dw within w_maint_pm_management
integer x = 2977
integer y = 1603
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

type dw_subsyseqp from u_dw within w_maint_pm_management
integer x = 2809
integer y = 1600
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

type ddlb_i from u_ddlb within w_maint_pm_management
integer x = 2692
integer y = 70
integer width = 889
integer height = 1270
integer taborder = 90
integer textsize = -9
string facename = "Arial"
end type

type st_4 from statictext within w_maint_pm_management
integer x = 2326
integer y = 70
integer width = 373
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
string text = "Item or Device"
boolean focusrectangle = false
end type

type ddlb_sub from u_ddlb within w_maint_pm_management
integer x = 1620
integer y = 70
integer width = 677
integer height = 1270
integer taborder = 80
integer textsize = -9
string facename = "Arial"
end type

type st_3 from statictext within w_maint_pm_management
integer x = 1061
integer y = 74
integer width = 549
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
string text = "Sub-System Equipment"
boolean focusrectangle = false
end type

type ddlb_d from u_ddlb within w_maint_pm_management
integer x = 1927
integer y = 1286
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

type st_1 from statictext within w_maint_pm_management
integer x = 1624
integer y = 1290
integer width = 293
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12639424
string text = "Assigned to:"
boolean focusrectangle = false
end type

type ddlb_status from u_ddlb within w_maint_pm_management
integer x = 1236
integer y = 1286
integer width = 380
integer height = 342
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type cb_report from u_cb within w_maint_pm_management
string tag = "PM related reports"
integer x = 1452
integer y = 1597
integer width = 541
integer height = 115
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reports"
end type

type dw_pm from u_dw within w_maint_pm_management
integer x = 1035
integer y = 339
integer width = 2553
integer height = 784
integer taborder = 90
string dataobject = "d_maint_pm_details_1"
end type

event constructor;call super::constructor;of_SetBase(TRUE)

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type dw_list from u_dw within w_maint_pm_management
integer x = 37
integer y = 83
integer width = 852
integer height = 1376
integer taborder = 50
string dataobject = "d_pm_list"
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetBase(TRUE)
SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;RETURN this.Retrieve()
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

li_Row = dw_list.GetRow()
dw_list.SelectRow(0, False)
dw_list.SelectRow(li_Row, True)

Parent.Event ue_display_row()

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type cb_print from u_cb within w_maint_pm_management
string tag = "Print current PM"
integer x = 1467
integer y = 1507
integer width = 439
integer height = 70
integer taborder = 120
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "p&rint"
end type

type cb_parts from u_cb within w_maint_pm_management
string tag = "PM related parts"
integer x = 2926
integer y = 1507
integer width = 439
integer height = 70
integer taborder = 110
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "P&arts Req~'d"
end type

type cb_pictures from u_cb within w_maint_pm_management
string tag = "PM related pictures"
integer x = 2439
integer y = 1507
integer width = 439
integer height = 70
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Pictures"
end type

event clicked;call super::clicked;Open(w_maint_parts_new)
end event

type cb_update from u_cb within w_maint_pm_management
string tag = "Update PM"
integer x = 1953
integer y = 1507
integer width = 439
integer height = 70
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Update"
end type

event clicked;call super::clicked;Open(w_maint_parts_new)
end event

type pb_last from u_pb within w_maint_pm_management
integer x = 903
integer y = 1238
integer width = 80
integer height = 70
integer taborder = 40
integer textsize = -12
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "AlignBottom!"
string powertiptext = "Last Record"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_pm
//
//SELECT Max(maint_log_id) INTO :il_logs
//FROM Maint_log
//USING SQLCA;
//
//IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
//	il_logs = ll_temp
//	RETURN 0
//END IF
//
//dw_log.Reset()
//mle_a.Clear()
//mle_p.Clear()
//
//dw_log.REtrieve(il_logs)
//
//ll_i = dw_log.GetRow()
//mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
//mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
//st_log.text = "LOG ID : " + String(il_logs)
//
//RETURN 1
end event

type pb_first from u_pb within w_maint_pm_management
integer x = 903
integer y = 221
integer width = 80
integer height = 70
integer taborder = 40
integer textsize = -12
string facename = "Arial"
string text = ""
string picturename = "AlignTop!"
string powertiptext = "First record"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_pm
//
//SELECT Min(maint_log_id) INTO :il_logs
//FROM Maint_log
//USING SQLCA;
//
//IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
//	il_logs = ll_temp
//	RETURN 0
//END IF
//
//dw_log.Reset()
//mle_a.Clear()
//mle_p.Clear()
//
//dw_log.REtrieve(il_logs)
//
//ll_i = dw_log.GetRow()
//mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
//mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
//st_log.text = "LOG ID : " + String(il_logs)

RETURN 1
end event

type cb_find from u_cb within w_maint_pm_management
string tag = "Search PM items"
integer x = 230
integer y = 1472
integer width = 541
integer height = 90
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Find"
end type

type pb_prior from u_pb within w_maint_pm_management
integer x = 903
integer y = 301
integer width = 80
integer height = 70
integer taborder = 30
integer textsize = -12
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom033!"
string powertiptext = "Prior"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_pm

//SELECT Max(maint_log_id) INTO :il_logs
//FROM Maint_log
//WHERE maint_log_id < :il_logs
//USING SQLCA;
//
//IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
//	il_logs = ll_temp
//	RETURN 0
//END IF
//
//dw_log.Reset()
//mle_a.Clear()
//mle_p.Clear()
//
//dw_log.REtrieve(il_logs)
//
//ll_i = dw_log.GetRow()
//mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
//mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
//st_log.text = "LOG ID : " + String(il_logs)
//
RETURN 1
end event

type pb_next from u_pb within w_maint_pm_management
integer x = 903
integer y = 1158
integer width = 80
integer height = 70
integer taborder = 20
integer textsize = -12
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom034!"
string powertiptext = "Next"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_pm

//SELECT Min(maint_log_id) INTO :il_logs
//FROM Maint_log
//WHERE maint_log_id > :il_logs
//USING SQLCA;
//
//IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
//	il_logs = ll_temp
//	RETURN 0
//END IF
//
//dw_log.Reset()
//mle_a.Clear()
//mle_p.Clear()
//
//dw_log.REtrieve(il_logs)
//
//ll_i = dw_log.GetRow()
//mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
//mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
//st_log.text = "LOG ID : " + String(il_logs)
//
RETURN 1
end event

type cb_new from u_cb within w_maint_pm_management
string tag = "New PM"
integer x = 720
integer y = 1597
integer width = 541
integer height = 115
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New"
end type

event clicked;call super::clicked;Open(w_maint_pm_new)
end event

type cb_close from u_cb within w_maint_pm_management
string tag = "Exit"
integer x = 2183
integer y = 1597
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
Message.StringParm = "w_maint_main" 
gnv_app.of_getFrame().Event pfc_open()

end event

type gb_3 from groupbox within w_maint_pm_management
integer x = 15
integer y = 10
integer width = 995
integer height = 1578
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Preventive Maintenance List"
end type

type gb_pm from groupbox within w_maint_pm_management
integer x = 1013
integer y = 10
integer width = 2597
integer height = 1581
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "ID:1234"
end type

