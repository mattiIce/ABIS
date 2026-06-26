$PBExportHeader$w_maint_logs_management.srw
$PBExportComments$<main>main maintenance logs, inherited from  pfemain.pbl
forward
global type w_maint_logs_management from w_sheet
end type
type cb_report from u_cb within w_maint_logs_management
end type
type dw_subsyseqp from u_dw within w_maint_logs_management
end type
type dw_syseqp from u_dw within w_maint_logs_management
end type
type dw_itemdevice from u_dw within w_maint_logs_management
end type
type dw_grp from u_dw within w_maint_logs_management
end type
type pb_last from u_pb within w_maint_logs_management
end type
type pb_first from u_pb within w_maint_logs_management
end type
type dw_log from u_dw within w_maint_logs_management
end type
type cb_save from u_cb within w_maint_logs_management
end type
type cb_more from u_cb within w_maint_logs_management
end type
type cb_find from u_cb within w_maint_logs_management
end type
type pb_prior from u_pb within w_maint_logs_management
end type
type pb_next from u_pb within w_maint_logs_management
end type
type st_log from statictext within w_maint_logs_management
end type
type mle_a from u_mle within w_maint_logs_management
end type
type mle_p from u_mle within w_maint_logs_management
end type
type st_6 from statictext within w_maint_logs_management
end type
type st_5 from statictext within w_maint_logs_management
end type
type st_4 from statictext within w_maint_logs_management
end type
type st_3 from statictext within w_maint_logs_management
end type
type st_2 from statictext within w_maint_logs_management
end type
type st_1 from statictext within w_maint_logs_management
end type
type ddlb_i from u_ddlb within w_maint_logs_management
end type
type ddlb_sub from u_ddlb within w_maint_logs_management
end type
type ddlb_s from u_ddlb within w_maint_logs_management
end type
type ddlb_d from u_ddlb within w_maint_logs_management
end type
type cb_new from u_cb within w_maint_logs_management
end type
type cb_print from u_cb within w_maint_logs_management
end type
type cb_close from u_cb within w_maint_logs_management
end type
type gb_1 from groupbox within w_maint_logs_management
end type
type gb_2 from groupbox within w_maint_logs_management
end type
type gb_3 from groupbox within w_maint_logs_management
end type
type gb_4 from groupbox within w_maint_logs_management
end type
type gb_5 from groupbox within w_maint_logs_management
end type
end forward

global type w_maint_logs_management from w_sheet
integer x = 4
integer y = 3
integer width = 3076
integer height = 1821
string title = "Maintenance Requests && Logs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 15780518
event type string ue_whoami ( )
event ue_read_only ( )
cb_report cb_report
dw_subsyseqp dw_subsyseqp
dw_syseqp dw_syseqp
dw_itemdevice dw_itemdevice
dw_grp dw_grp
pb_last pb_last
pb_first pb_first
dw_log dw_log
cb_save cb_save
cb_more cb_more
cb_find cb_find
pb_prior pb_prior
pb_next pb_next
st_log st_log
mle_a mle_a
mle_p mle_p
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
ddlb_i ddlb_i
ddlb_sub ddlb_sub
ddlb_s ddlb_s
ddlb_d ddlb_d
cb_new cb_new
cb_print cb_print
cb_close cb_close
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
end type
global w_maint_logs_management w_maint_logs_management

type variables
Long il_logs
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_logs_management"
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

on w_maint_logs_management.create
int iCurrent
call super::create
this.cb_report=create cb_report
this.dw_subsyseqp=create dw_subsyseqp
this.dw_syseqp=create dw_syseqp
this.dw_itemdevice=create dw_itemdevice
this.dw_grp=create dw_grp
this.pb_last=create pb_last
this.pb_first=create pb_first
this.dw_log=create dw_log
this.cb_save=create cb_save
this.cb_more=create cb_more
this.cb_find=create cb_find
this.pb_prior=create pb_prior
this.pb_next=create pb_next
this.st_log=create st_log
this.mle_a=create mle_a
this.mle_p=create mle_p
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_i=create ddlb_i
this.ddlb_sub=create ddlb_sub
this.ddlb_s=create ddlb_s
this.ddlb_d=create ddlb_d
this.cb_new=create cb_new
this.cb_print=create cb_print
this.cb_close=create cb_close
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_report
this.Control[iCurrent+2]=this.dw_subsyseqp
this.Control[iCurrent+3]=this.dw_syseqp
this.Control[iCurrent+4]=this.dw_itemdevice
this.Control[iCurrent+5]=this.dw_grp
this.Control[iCurrent+6]=this.pb_last
this.Control[iCurrent+7]=this.pb_first
this.Control[iCurrent+8]=this.dw_log
this.Control[iCurrent+9]=this.cb_save
this.Control[iCurrent+10]=this.cb_more
this.Control[iCurrent+11]=this.cb_find
this.Control[iCurrent+12]=this.pb_prior
this.Control[iCurrent+13]=this.pb_next
this.Control[iCurrent+14]=this.st_log
this.Control[iCurrent+15]=this.mle_a
this.Control[iCurrent+16]=this.mle_p
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.st_5
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.st_1
this.Control[iCurrent+23]=this.ddlb_i
this.Control[iCurrent+24]=this.ddlb_sub
this.Control[iCurrent+25]=this.ddlb_s
this.Control[iCurrent+26]=this.ddlb_d
this.Control[iCurrent+27]=this.cb_new
this.Control[iCurrent+28]=this.cb_print
this.Control[iCurrent+29]=this.cb_close
this.Control[iCurrent+30]=this.gb_1
this.Control[iCurrent+31]=this.gb_2
this.Control[iCurrent+32]=this.gb_3
this.Control[iCurrent+33]=this.gb_4
this.Control[iCurrent+34]=this.gb_5
end on

on w_maint_logs_management.destroy
call super::destroy
destroy(this.cb_report)
destroy(this.dw_subsyseqp)
destroy(this.dw_syseqp)
destroy(this.dw_itemdevice)
destroy(this.dw_grp)
destroy(this.pb_last)
destroy(this.pb_first)
destroy(this.dw_log)
destroy(this.cb_save)
destroy(this.cb_more)
destroy(this.cb_find)
destroy(this.pb_prior)
destroy(this.pb_next)
destroy(this.st_log)
destroy(this.mle_a)
destroy(this.mle_p)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_i)
destroy(this.ddlb_sub)
destroy(this.ddlb_s)
destroy(this.ddlb_d)
destroy(this.cb_new)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event activate;call super::activate;IF f_security_door("Maintenance_logs") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event pfc_postopen;call super::pfc_postopen;SELECT Max(maint_log_id) INTO :il_logs
FROM Maint_log
USING SQLCA;

dw_log.Retrieve(il_logs)

Long ll_i

ll_i = dw_log.GetRow()
mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
st_log.text = "LOG ID : " + String(il_logs)

dw_grp.Retrieve()
dw_syseqp.Retrieve()
dw_subsyseqp.Retrieve()
dw_itemdevice.Retrieve()
end event

event open;call super::open;dw_log.Visible = FALSE
dw_grp.Visible = FALSE
dw_syseqp.Visible = FALSE
dw_subsyseqp.Visible = FALSE
dw_itemdevice.Visible = FALSE
end event

type cb_report from u_cb within w_maint_logs_management
string tag = "Log related reports"
integer x = 1785
integer y = 1606
integer width = 501
integer height = 115
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reports"
end type

type dw_subsyseqp from u_dw within w_maint_logs_management
integer x = 2527
integer y = 1546
integer width = 157
integer height = 42
integer taborder = 60
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

type dw_syseqp from u_dw within w_maint_logs_management
integer x = 2889
integer y = 1539
integer width = 157
integer height = 42
integer taborder = 110
string dataobject = "d_maint_sysequip"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type dw_itemdevice from u_dw within w_maint_logs_management
integer x = 2768
integer y = 1546
integer width = 157
integer height = 42
integer taborder = 60
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

type dw_grp from u_dw within w_maint_logs_management
integer x = 2666
integer y = 1542
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

type pb_last from u_pb within w_maint_logs_management
integer x = 2088
integer y = 42
integer width = 121
integer height = 106
integer taborder = 40
integer textsize = -12
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "VCRLast!"
string powertiptext = "Last Record"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_logs

SELECT Max(maint_log_id) INTO :il_logs
FROM Maint_log
USING SQLCA;

IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
	il_logs = ll_temp
	RETURN 0
END IF

dw_log.Reset()
mle_a.Clear()
mle_p.Clear()

dw_log.REtrieve(il_logs)

ll_i = dw_log.GetRow()
mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
st_log.text = "LOG ID : " + String(il_logs)

RETURN 1
end event

type pb_first from u_pb within w_maint_logs_management
integer x = 325
integer y = 42
integer width = 121
integer height = 106
integer taborder = 40
integer textsize = -12
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "VCRFirst!"
string powertiptext = "First record"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_logs

SELECT Min(maint_log_id) INTO :il_logs
FROM Maint_log
USING SQLCA;

IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
	il_logs = ll_temp
	RETURN 0
END IF

dw_log.Reset()
mle_a.Clear()
mle_p.Clear()

dw_log.REtrieve(il_logs)

ll_i = dw_log.GetRow()
mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
st_log.text = "LOG ID : " + String(il_logs)

RETURN 1
end event

type dw_log from u_dw within w_maint_logs_management
integer x = 26
integer y = 1603
integer width = 157
integer height = 42
integer taborder = 90
string dataobject = "d_part_maint_log"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type cb_save from u_cb within w_maint_logs_management
string tag = "Save information"
integer x = 739
integer y = 1606
integer width = 501
integer height = 115
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

type cb_more from u_cb within w_maint_logs_management
string tag = "More details for this log"
integer x = 2501
integer y = 1446
integer width = 541
integer height = 90
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&More Details"
end type

event clicked;call super::clicked;OpenWithParm(w_maint_logs_details, dw_log)
end event

type cb_find from u_cb within w_maint_logs_management
string tag = "Search logs"
integer x = 2469
integer y = 48
integer width = 541
integer height = 90
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Find Logs"
end type

type pb_prior from u_pb within w_maint_logs_management
integer x = 508
integer y = 42
integer width = 121
integer height = 106
integer taborder = 30
integer textsize = -12
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Prior!"
string powertiptext = "Prior"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_logs

SELECT Max(maint_log_id) INTO :il_logs
FROM Maint_log
WHERE maint_log_id < :il_logs
USING SQLCA;

IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
	il_logs = ll_temp
	RETURN 0
END IF

dw_log.Reset()
mle_a.Clear()
mle_p.Clear()

dw_log.REtrieve(il_logs)

ll_i = dw_log.GetRow()
mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
st_log.text = "LOG ID : " + String(il_logs)

RETURN 1
end event

type pb_next from u_pb within w_maint_logs_management
integer x = 1909
integer y = 42
integer width = 121
integer height = 106
integer taborder = 20
integer textsize = -12
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Next!"
string powertiptext = "Next"
end type

event clicked;call super::clicked;Long ll_temp, ll_i

ll_temp = il_logs

SELECT Min(maint_log_id) INTO :il_logs
FROM Maint_log
WHERE maint_log_id > :il_logs
USING SQLCA;

IF IsNULL(il_logs) OR (il_logs = 0) OR (il_logs = ll_temp) THEN
	il_logs = ll_temp
	RETURN 0
END IF

dw_log.Reset()
mle_a.Clear()
mle_p.Clear()

dw_log.REtrieve(il_logs)

ll_i = dw_log.GetRow()
mle_p.Text = dw_log.GetItemString(ll_i, "prob_details")
mle_a.Text = dw_log.GetItemString(ll_i, "Actions")
st_log.text = "LOG ID : " + String(il_logs)

RETURN 1
end event

type st_log from statictext within w_maint_logs_management
integer x = 636
integer y = 51
integer width = 1211
integer height = 83
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
string text = "Log ID: 201009120712"
alignment alignment = center!
boolean focusrectangle = false
end type

type mle_a from u_mle within w_maint_logs_management
integer x = 7
integer y = 1014
integer width = 3032
integer height = 429
integer taborder = 100
end type

type mle_p from u_mle within w_maint_logs_management
integer x = 4
integer y = 515
integer width = 3035
integer height = 419
integer taborder = 90
end type

type st_6 from statictext within w_maint_logs_management
integer x = 7
integer y = 947
integer width = 585
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
string text = "Action:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_maint_logs_management
integer x = 11
integer y = 454
integer width = 585
integer height = 58
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15780518
string text = "Problem:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_maint_logs_management
integer x = 1525
integer y = 355
integer width = 556
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 32896
string text = "Item or Device"
boolean focusrectangle = false
end type

type st_3 from statictext within w_maint_logs_management
integer x = 1529
integer y = 262
integer width = 549
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 32896
string text = "Sub-System Equipment"
boolean focusrectangle = false
end type

type st_2 from statictext within w_maint_logs_management
integer x = 51
integer y = 352
integer width = 585
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 32896
string text = "On System or Equipment"
boolean focusrectangle = false
end type

type st_1 from statictext within w_maint_logs_management
integer x = 55
integer y = 259
integer width = 578
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 32896
string text = "For Dept or Location"
boolean focusrectangle = false
end type

type ddlb_i from u_ddlb within w_maint_logs_management
integer x = 2103
integer y = 342
integer width = 889
integer height = 1270
integer taborder = 80
integer textsize = -9
string facename = "Arial"
end type

type ddlb_sub from u_ddlb within w_maint_logs_management
integer x = 2103
integer y = 250
integer width = 889
integer height = 1270
integer taborder = 30
integer textsize = -9
string facename = "Arial"
end type

type ddlb_s from u_ddlb within w_maint_logs_management
integer x = 647
integer y = 342
integer width = 867
integer height = 1270
integer taborder = 20
integer textsize = -9
string facename = "Arial"
end type

event selectionchanged;call super::selectionchanged;//String ls_text
//Long ll_row, ll_i
//
//ls_text = Text(index)
//
//ll_row = dw_vendor_part_num.RowCount()
//FOR ll_i = 1 TO ll_row
//		IF dw_vendor_part_num.GetItemString(ll_i, "vendor_part_number") = ls_text THEN
//				dw_vendor_part_num.Event RowFocusChanged(ll_i)
//				dw_vendor_part_num.SelectRow(0, False)
//				dw_vendor_part_num.SelectRow(ll_i, True)
//				il_parts = dw_vendor_part_num.GetItemNumber(ll_i, "parts_id")				
//		END IF
//NEXT
//dw_part.Retrieve(il_parts)
//
RETURN 1


end event

type ddlb_d from u_ddlb within w_maint_logs_management
integer x = 647
integer y = 250
integer width = 867
integer height = 1270
integer taborder = 30
integer textsize = -9
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

type cb_new from u_cb within w_maint_logs_management
string tag = "New Parts"
integer x = 216
integer y = 1606
integer width = 501
integer height = 115
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Request"
end type

event clicked;call super::clicked;Open(w_maint_parts_new)
end event

type cb_print from u_cb within w_maint_logs_management
string tag = "Print current parts"
integer x = 1262
integer y = 1606
integer width = 501
integer height = 115
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;If il_logs = 0 THEN
	MessageBox("Warning", "Please select a log.")
	RETURN 0
END IF
//OpenWithParm(w_report_maint_logs, il_logs)
end event

type cb_close from u_cb within w_maint_logs_management
string tag = "Exit"
integer x = 2308
integer y = 1606
integer width = 501
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

type gb_1 from groupbox within w_maint_logs_management
integer x = 7
integer y = 173
integer width = 3032
integer height = 272
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 8421376
string text = "Request Location"
end type

type gb_2 from groupbox within w_maint_logs_management
integer x = 7
integer y = 1446
integer width = 552
integer height = 141
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
string text = "Status"
end type

type gb_3 from groupbox within w_maint_logs_management
integer x = 15
integer y = 10
integer width = 3024
integer height = 141
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
string text = "Log"
end type

type gb_4 from groupbox within w_maint_logs_management
integer x = 592
integer y = 1446
integer width = 863
integer height = 141
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
string text = "Assigned to:"
end type

type gb_5 from groupbox within w_maint_logs_management
integer x = 1492
integer y = 1446
integer width = 987
integer height = 141
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
string text = "Finished by:"
end type

