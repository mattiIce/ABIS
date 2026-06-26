$PBExportHeader$w_maint_logs_details.srw
$PBExportComments$<main>log details, inherited from  pfemain.pbl
forward
global type w_maint_logs_details from w_sheet
end type
type tab_log from tab within w_maint_logs_details
end type
type tabpage_who from userobject within tab_log
end type
type gb_3 from groupbox within tabpage_who
end type
type gb_1 from groupbox within tabpage_who
end type
type gb_2 from groupbox within tabpage_who
end type
type gb_4 from groupbox within tabpage_who
end type
type tabpage_who from userobject within tab_log
gb_3 gb_3
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
end type
type tabpage_what from userobject within tab_log
end type
type st_5 from statictext within tabpage_what
end type
type mle_p from u_mle within tabpage_what
end type
type tabpage_what from userobject within tab_log
st_5 st_5
mle_p mle_p
end type
type tabpage_when from userobject within tab_log
end type
type em_calendar from u_em within tabpage_when
end type
type uo_calendar_1 from u_calendar within tabpage_when
end type
type gb_r from groupbox within tabpage_when
end type
type gb_e from groupbox within tabpage_when
end type
type gb_a from groupbox within tabpage_when
end type
type gb_c from groupbox within tabpage_when
end type
type tabpage_when from userobject within tab_log
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
gb_r gb_r
gb_e gb_e
gb_a gb_a
gb_c gb_c
end type
type tabpage_where from userobject within tab_log
end type
type ddlb_i from u_ddlb within tabpage_where
end type
type ddlb_sub from u_ddlb within tabpage_where
end type
type st_9 from statictext within tabpage_where
end type
type st_8 from statictext within tabpage_where
end type
type ddlb_s from u_ddlb within tabpage_where
end type
type st_7 from statictext within tabpage_where
end type
type ddlb_d from u_ddlb within tabpage_where
end type
type st_6 from statictext within tabpage_where
end type
type tabpage_where from userobject within tab_log
ddlb_i ddlb_i
ddlb_sub ddlb_sub
st_9 st_9
st_8 st_8
ddlb_s ddlb_s
st_7 st_7
ddlb_d ddlb_d
st_6 st_6
end type
type tabpage_why from userobject within tab_log
end type
type st_10 from statictext within tabpage_why
end type
type mle_1 from u_mle within tabpage_why
end type
type tabpage_why from userobject within tab_log
st_10 st_10
mle_1 mle_1
end type
type tabpage_how from userobject within tab_log
end type
type st_4 from statictext within tabpage_how
end type
type mle_a from u_mle within tabpage_how
end type
type tabpage_how from userobject within tab_log
st_4 st_4
mle_a mle_a
end type
type tabpage_parts from userobject within tab_log
end type
type dw_1 from u_dw within tabpage_parts
end type
type st_2 from statictext within tabpage_parts
end type
type cb_remove from u_cb within tabpage_parts
end type
type cb_add from u_cb within tabpage_parts
end type
type dw_parts from u_dw within tabpage_parts
end type
type st_1 from statictext within tabpage_parts
end type
type tabpage_parts from userobject within tab_log
dw_1 dw_1
st_2 st_2
cb_remove cb_remove
cb_add cb_add
dw_parts dw_parts
st_1 st_1
end type
type tabpage_pic from userobject within tab_log
end type
type st_3 from statictext within tabpage_pic
end type
type p_pic from picture within tabpage_pic
end type
type plb_qa from picturelistbox within tabpage_pic
end type
type tabpage_pic from userobject within tab_log
st_3 st_3
p_pic p_pic
plb_qa plb_qa
end type
type tabpage_app from userobject within tab_log
end type
type mle_2 from u_mle within tabpage_app
end type
type em_1 from u_em within tabpage_app
end type
type uo_calendar_2 from u_calendar within tabpage_app
end type
type tabpage_app from userobject within tab_log
mle_2 mle_2
em_1 em_1
uo_calendar_2 uo_calendar_2
end type
type tab_log from tab within w_maint_logs_details
tabpage_who tabpage_who
tabpage_what tabpage_what
tabpage_when tabpage_when
tabpage_where tabpage_where
tabpage_why tabpage_why
tabpage_how tabpage_how
tabpage_parts tabpage_parts
tabpage_pic tabpage_pic
tabpage_app tabpage_app
end type
type st_log from statictext within w_maint_logs_details
end type
type cb_close from u_cb within w_maint_logs_details
end type
end forward

global type w_maint_logs_details from w_sheet
integer x = 4
integer y = 3
integer width = 2370
integer height = 1488
string title = "Log details"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217747
event type string ue_whoami ( )
event ue_read_only ( )
tab_log tab_log
st_log st_log
cb_close cb_close
end type
global w_maint_logs_details w_maint_logs_details

type variables
DataWindow idw_data
Long il_logs
String is_path 



end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_logs_details"
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

on w_maint_logs_details.create
int iCurrent
call super::create
this.tab_log=create tab_log
this.st_log=create st_log
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_log
this.Control[iCurrent+2]=this.st_log
this.Control[iCurrent+3]=this.cb_close
end on

on w_maint_logs_details.destroy
call super::destroy
destroy(this.tab_log)
destroy(this.st_log)
destroy(this.cb_close)
end on

event open;call super::open;idw_data = message.PowerObjectParm

Long ll_i

ll_i = idw_data.GetRow()
il_logs = idw_data.GetItemNumber(ll_i, "maint_log_id")
tab_log.tabpage_what.mle_p.Text = idw_data.GetItemString(ll_i, "prob_details")
tab_log.tabpage_how.mle_a.Text = idw_data.GetItemString(ll_i, "Actions")
st_log.text = "LOG ID : " + String(il_logs)

st_log.text = "LOG ID : " + String(il_logs)

is_path = ProfileString(gs_ini_file, "MAINT_PICTURE","FOLDER_BASE","E:\PHOTO")
end event

type tab_log from tab within w_maint_logs_details
integer y = 102
integer width = 2352
integer height = 1178
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
boolean pictureonright = true
integer selectedtab = 1
tabpage_who tabpage_who
tabpage_what tabpage_what
tabpage_when tabpage_when
tabpage_where tabpage_where
tabpage_why tabpage_why
tabpage_how tabpage_how
tabpage_parts tabpage_parts
tabpage_pic tabpage_pic
tabpage_app tabpage_app
end type

on tab_log.create
this.tabpage_who=create tabpage_who
this.tabpage_what=create tabpage_what
this.tabpage_when=create tabpage_when
this.tabpage_where=create tabpage_where
this.tabpage_why=create tabpage_why
this.tabpage_how=create tabpage_how
this.tabpage_parts=create tabpage_parts
this.tabpage_pic=create tabpage_pic
this.tabpage_app=create tabpage_app
this.Control[]={this.tabpage_who,&
this.tabpage_what,&
this.tabpage_when,&
this.tabpage_where,&
this.tabpage_why,&
this.tabpage_how,&
this.tabpage_parts,&
this.tabpage_pic,&
this.tabpage_app}
end on

on tab_log.destroy
destroy(this.tabpage_who)
destroy(this.tabpage_what)
destroy(this.tabpage_when)
destroy(this.tabpage_where)
destroy(this.tabpage_why)
destroy(this.tabpage_how)
destroy(this.tabpage_parts)
destroy(this.tabpage_pic)
destroy(this.tabpage_app)
end on

type tabpage_who from userobject within tab_log
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "Who"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "Custom026!"
long picturemaskcolor = 536870912
string powertiptext = "people involved"
gb_3 gb_3
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
end type

on tabpage_who.create
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.Control[]={this.gb_3,&
this.gb_1,&
this.gb_2,&
this.gb_4}
end on

on tabpage_who.destroy
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
end on

type gb_3 from groupbox within tabpage_who
integer y = 16
integer width = 940
integer height = 470
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
string text = "Who Reported"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_who
integer y = 502
integer width = 940
integer height = 557
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
string text = "Who Entered"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_who
integer x = 965
integer y = 16
integer width = 1349
integer height = 470
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
string text = "Assigned to"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_who
integer x = 962
integer y = 502
integer width = 1353
integer height = 557
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
string text = "Completed by"
borderstyle borderstyle = styleraised!
end type

type tabpage_what from userobject within tab_log
event create ( )
event destroy ( )
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "What"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "CreateLibrary5!"
long picturemaskcolor = 536870912
string powertiptext = "what happend?"
st_5 st_5
mle_p mle_p
end type

on tabpage_what.create
this.st_5=create st_5
this.mle_p=create mle_p
this.Control[]={this.st_5,&
this.mle_p}
end on

on tabpage_what.destroy
destroy(this.st_5)
destroy(this.mle_p)
end on

type st_5 from statictext within tabpage_what
integer y = 16
integer width = 351
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Problem:"
boolean focusrectangle = false
end type

type mle_p from u_mle within tabpage_what
integer y = 70
integer width = 2322
integer height = 998
integer taborder = 20
end type

type tabpage_when from userobject within tab_log
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "When"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "AddWatch!"
long picturemaskcolor = 536870912
string powertiptext = "Time related"
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
gb_r gb_r
gb_e gb_e
gb_a gb_a
gb_c gb_c
end type

on tabpage_when.create
this.em_calendar=create em_calendar
this.uo_calendar_1=create uo_calendar_1
this.gb_r=create gb_r
this.gb_e=create gb_e
this.gb_a=create gb_a
this.gb_c=create gb_c
this.Control[]={this.em_calendar,&
this.uo_calendar_1,&
this.gb_r,&
this.gb_e,&
this.gb_a,&
this.gb_c}
end on

on tabpage_when.destroy
destroy(this.em_calendar)
destroy(this.uo_calendar_1)
destroy(this.gb_r)
destroy(this.gb_e)
destroy(this.gb_a)
destroy(this.gb_c)
end on

type em_calendar from u_em within tabpage_when
boolean visible = false
integer x = 128
integer y = 720
integer width = 380
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;uo_calendar_1.of_SetRequestor(this)
end event

type uo_calendar_1 from u_calendar within tabpage_when
integer y = 22
integer width = 706
integer height = 650
integer taborder = 20
boolean bringtotop = true
long backcolor = 79741120
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type gb_r from groupbox within tabpage_when
integer x = 713
integer y = 10
integer width = 779
integer height = 470
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
string text = "Reported Time"
borderstyle borderstyle = styleraised!
end type

type gb_e from groupbox within tabpage_when
integer x = 713
integer y = 515
integer width = 779
integer height = 538
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
boolean enabled = false
string text = "Entered Time"
borderstyle borderstyle = styleraised!
end type

type gb_a from groupbox within tabpage_when
integer x = 1510
integer y = 10
integer width = 808
integer height = 470
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
boolean enabled = false
string text = "Assigned Time"
borderstyle borderstyle = styleraised!
end type

type gb_c from groupbox within tabpage_when
integer x = 1510
integer y = 515
integer width = 808
integer height = 538
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217747
boolean enabled = false
string text = "Completed Time"
borderstyle borderstyle = styleraised!
end type

type tabpage_where from userobject within tab_log
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "Where"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "SelectApplication!"
long picturemaskcolor = 536870912
string powertiptext = "where did it happen?"
ddlb_i ddlb_i
ddlb_sub ddlb_sub
st_9 st_9
st_8 st_8
ddlb_s ddlb_s
st_7 st_7
ddlb_d ddlb_d
st_6 st_6
end type

on tabpage_where.create
this.ddlb_i=create ddlb_i
this.ddlb_sub=create ddlb_sub
this.st_9=create st_9
this.st_8=create st_8
this.ddlb_s=create ddlb_s
this.st_7=create st_7
this.ddlb_d=create ddlb_d
this.st_6=create st_6
this.Control[]={this.ddlb_i,&
this.ddlb_sub,&
this.st_9,&
this.st_8,&
this.ddlb_s,&
this.st_7,&
this.ddlb_d,&
this.st_6}
end on

on tabpage_where.destroy
destroy(this.ddlb_i)
destroy(this.ddlb_sub)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.ddlb_s)
destroy(this.st_7)
destroy(this.ddlb_d)
destroy(this.st_6)
end on

type ddlb_i from u_ddlb within tabpage_where
integer x = 823
integer y = 515
integer width = 889
integer height = 1270
integer taborder = 90
integer textsize = -9
string facename = "Arial"
end type

type ddlb_sub from u_ddlb within tabpage_where
integer x = 823
integer y = 378
integer width = 889
integer height = 1270
integer taborder = 40
integer textsize = -9
string facename = "Arial"
end type

type st_9 from statictext within tabpage_where
integer x = 212
integer y = 522
integer width = 556
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Item or Device"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_where
integer x = 212
integer y = 378
integer width = 549
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Sub-System Equipment"
boolean focusrectangle = false
end type

type ddlb_s from u_ddlb within tabpage_where
integer x = 823
integer y = 240
integer width = 889
integer height = 829
integer taborder = 30
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

type st_7 from statictext within tabpage_where
integer x = 212
integer y = 253
integer width = 585
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "On System or Equipment"
boolean focusrectangle = false
end type

type ddlb_d from u_ddlb within tabpage_where
integer x = 823
integer y = 102
integer width = 889
integer height = 966
integer taborder = 40
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

type st_6 from statictext within tabpage_where
integer x = 212
integer y = 106
integer width = 578
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "For Dept or Location"
boolean focusrectangle = false
end type

type tabpage_why from userobject within tab_log
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "Why"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "CheckStatus5!"
long picturemaskcolor = 536870912
string powertiptext = "what caused"
st_10 st_10
mle_1 mle_1
end type

on tabpage_why.create
this.st_10=create st_10
this.mle_1=create mle_1
this.Control[]={this.st_10,&
this.mle_1}
end on

on tabpage_why.destroy
destroy(this.st_10)
destroy(this.mle_1)
end on

type st_10 from statictext within tabpage_why
integer y = 3
integer width = 351
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Causes:"
boolean focusrectangle = false
end type

type mle_1 from u_mle within tabpage_why
integer y = 67
integer width = 2315
integer height = 992
integer taborder = 30
end type

type tabpage_how from userobject within tab_log
event create ( )
event destroy ( )
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "How"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "Asterisk!"
long picturemaskcolor = 536870912
string powertiptext = "How to fix it"
st_4 st_4
mle_a mle_a
end type

on tabpage_how.create
this.st_4=create st_4
this.mle_a=create mle_a
this.Control[]={this.st_4,&
this.mle_a}
end on

on tabpage_how.destroy
destroy(this.st_4)
destroy(this.mle_a)
end on

type st_4 from statictext within tabpage_how
integer width = 351
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Actions:"
boolean focusrectangle = false
end type

type mle_a from u_mle within tabpage_how
integer y = 64
integer width = 2315
integer height = 992
integer taborder = 20
end type

type tabpage_parts from userobject within tab_log
event create ( )
event destroy ( )
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "Parts"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "UserObject!"
long picturemaskcolor = 536870912
string powertiptext = "parts used"
dw_1 dw_1
st_2 st_2
cb_remove cb_remove
cb_add cb_add
dw_parts dw_parts
st_1 st_1
end type

on tabpage_parts.create
this.dw_1=create dw_1
this.st_2=create st_2
this.cb_remove=create cb_remove
this.cb_add=create cb_add
this.dw_parts=create dw_parts
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_2,&
this.cb_remove,&
this.cb_add,&
this.dw_parts,&
this.st_1}
end on

on tabpage_parts.destroy
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.cb_remove)
destroy(this.cb_add)
destroy(this.dw_parts)
destroy(this.st_1)
end on

type dw_1 from u_dw within tabpage_parts
integer x = 1375
integer y = 74
integer width = 940
integer height = 992
integer taborder = 50
boolean bringtotop = true
boolean livescroll = false
end type

type st_2 from statictext within tabpage_parts
integer x = 4
integer y = 19
integer width = 406
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Used Parts:"
boolean focusrectangle = false
end type

type cb_remove from u_cb within tabpage_parts
integer x = 1006
integer y = 474
integer width = 351
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "&Remove >>"
end type

event clicked;//Long ll_row
//
//ll_row = dw_is.GetRow()
//IF ll_row < 1 THEN RETURN
//dw_is.DeleteRow(ll_row)
//wf_display_rights()
//
//RETURN 0


end event

type cb_add from u_cb within tabpage_parts
integer x = 1002
integer y = 243
integer width = 358
integer height = 93
integer taborder = 30
string facename = "Arial"
string text = "<< Select"
end type

event clicked;//String ls_item
//Long ll_row, ll_i, ll_group, ll_app
//
//ls_item = lb_isnot.SelectedItem()
//
//ll_row = ids_apps.RowCount()
//FOR ll_i = 1 TO ll_row
//	IF ids_apps.GetItemString(ll_i, "application_name") = ls_item THEN
//		ll_app = ids_apps.GetItemNumber(ll_i, "application_id")
//	END IF
//NEXT
//
//ll_row = dw_list.GetRow()
//IF ll_row > 0 THEN
//	ll_group = dw_list.GetItemNumber(ll_row, "user_group_id", Primary!, FALSE)
//END IF
//
//ll_row = dw_is.InsertRow(0)
//dw_is.SetItem(ll_row, "security_group_application_user_group_id", ll_group)
//dw_is.SetItem(ll_row, "security_group_application_application_i", ll_app)
//dw_is.setItem(ll_row, "security_group_application_group_applica", 1)
//dw_is.SetItem(ll_row, "security_application_application_name", ls_item)
//
//wf_display_rights()
//
//RETURN 1
//
//
end event

type dw_parts from u_dw within tabpage_parts
event ue_fill_new_row ( long al_row,  string as_value,  long al_groupid,  long al_appid,  integer ai_pri )
integer y = 74
integer width = 987
integer height = 992
integer taborder = 20
boolean bringtotop = true
boolean livescroll = false
end type

event ue_fill_new_row;this.SetItem(al_row, "security_application_application_name", as_value)
this.SetItem(al_row, "security_application_application_id", al_appid)
this.SetItem(al_row, "security_group_application_group_applica", ai_pri)

end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
this.SetTransObject(SQLCA)
this.Retrieve()

end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row
ll_row = this.GetRow()
RETURN ll_row
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

RETURN
end event

type st_1 from statictext within tabpage_parts
integer x = 1371
integer y = 13
integer width = 541
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Available Part:"
boolean focusrectangle = false
end type

type tabpage_pic from userobject within tab_log
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "Pictures"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "Custom010!"
long picturemaskcolor = 536870912
string powertiptext = "related pictures"
st_3 st_3
p_pic p_pic
plb_qa plb_qa
end type

on tabpage_pic.create
this.st_3=create st_3
this.p_pic=create p_pic
this.plb_qa=create plb_qa
this.Control[]={this.st_3,&
this.p_pic,&
this.plb_qa}
end on

on tabpage_pic.destroy
destroy(this.st_3)
destroy(this.p_pic)
destroy(this.plb_qa)
end on

type st_3 from statictext within tabpage_pic
integer x = 4
integer y = 10
integer width = 571
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Log Related Pictures:"
boolean focusrectangle = false
end type

type p_pic from picture within tabpage_pic
integer x = 636
integer y = 3
integer width = 1686
integer height = 1066
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type plb_qa from picturelistbox within tabpage_pic
integer y = 77
integer width = 629
integer height = 995
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
end type

event selectionchanged;String ls_item_name

ls_item_name =this.Text(INDEX)

tab_log.tabpage_pic.p_pic.picturename = is_path + "\" + String(il_logs) + "\" + ls_item_name
end event

type tabpage_app from userobject within tab_log
string tag = "Append"
integer x = 15
integer y = 96
integer width = 2322
integer height = 1069
long backcolor = 134217747
string text = "Append"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
string picturename = "AddWatch5!"
long picturemaskcolor = 536870912
string powertiptext = "Append"
mle_2 mle_2
em_1 em_1
uo_calendar_2 uo_calendar_2
end type

on tabpage_app.create
this.mle_2=create mle_2
this.em_1=create em_1
this.uo_calendar_2=create uo_calendar_2
this.Control[]={this.mle_2,&
this.em_1,&
this.uo_calendar_2}
end on

on tabpage_app.destroy
destroy(this.mle_2)
destroy(this.em_1)
destroy(this.uo_calendar_2)
end on

type mle_2 from u_mle within tabpage_app
integer x = 1434
integer y = 128
integer width = 841
integer height = 890
integer taborder = 11
end type

type em_1 from u_em within tabpage_app
boolean visible = false
integer x = 764
integer y = 790
integer width = 380
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;uo_calendar_2.of_SetRequestor(this)
end event

type uo_calendar_2 from u_calendar within tabpage_app
integer x = 607
integer y = 138
integer width = 706
integer height = 650
integer taborder = 30
boolean bringtotop = true
long backcolor = 79741120
end type

on uo_calendar_2.destroy
call u_calendar::destroy
end on

type st_log from statictext within w_maint_logs_details
integer x = 4
integer width = 2352
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

type cb_close from u_cb within w_maint_logs_details
string tag = "Exit"
integer x = 874
integer y = 1290
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



end event

