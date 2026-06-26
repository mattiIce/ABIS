$PBExportHeader$w_customer_recovery_report_setup.srw
$PBExportComments$<Responds> for customer recovery report setup
forward
global type w_customer_recovery_report_setup from w_sheet
end type
type ln_divider1 from line within w_customer_recovery_report_setup
end type
type st_1 from u_st within w_customer_recovery_report_setup
end type
type st_username from u_st within w_customer_recovery_report_setup
end type
type cb_close from u_cb within w_customer_recovery_report_setup
end type
type cb_save from u_cb within w_customer_recovery_report_setup
end type
type tab_user from tab within w_customer_recovery_report_setup
end type
type tabpage_general from userobject within tab_user
end type
type st_3 from statictext within tabpage_general
end type
type em_targetbase from editmask within tabpage_general
end type
type em_1 from editmask within tabpage_general
end type
type st_2 from statictext within tabpage_general
end type
type cbx_5 from u_cbx within tabpage_general
end type
type cbx_4 from u_cbx within tabpage_general
end type
type cbx_1 from u_cbx within tabpage_general
end type
type cbx_2 from u_cbx within tabpage_general
end type
type cbx_3 from u_cbx within tabpage_general
end type
type tabpage_general from userobject within tab_user
st_3 st_3
em_targetbase em_targetbase
em_1 em_1
st_2 st_2
cbx_5 cbx_5
cbx_4 cbx_4
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
end type
type tabpage_report from userobject within tab_user
end type
type lb_groupis from u_lb within tabpage_report
end type
type lb_groupnot from u_lb within tabpage_report
end type
type st_6 from statictext within tabpage_report
end type
type st_7 from statictext within tabpage_report
end type
type cb_add1 from u_cb within tabpage_report
end type
type cb_del from u_cb within tabpage_report
end type
type tabpage_report from userobject within tab_user
lb_groupis lb_groupis
lb_groupnot lb_groupnot
st_6 st_6
st_7 st_7
cb_add1 cb_add1
cb_del cb_del
end type
type tabpage_defects from userobject within tab_user
end type
type cb_add2 from u_cb within tabpage_defects
end type
type cb_del2 from u_cb within tabpage_defects
end type
type lb_defectnot from u_lb within tabpage_defects
end type
type st_8 from statictext within tabpage_defects
end type
type st_9 from statictext within tabpage_defects
end type
type dw_defectis from u_dw within tabpage_defects
end type
type tabpage_defects from userobject within tab_user
cb_add2 cb_add2
cb_del2 cb_del2
lb_defectnot lb_defectnot
st_8 st_8
st_9 st_9
dw_defectis dw_defectis
end type
type tab_user from tab within w_customer_recovery_report_setup
tabpage_general tabpage_general
tabpage_report tabpage_report
tabpage_defects tabpage_defects
end type
end forward

global type w_customer_recovery_report_setup from w_sheet
integer x = 944
integer y = 301
integer width = 2337
integer height = 1472
string title = "User Detail"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type string ue_whoami ( )
ln_divider1 ln_divider1
st_1 st_1
st_username st_username
cb_close cb_close
cb_save cb_save
tab_user tab_user
end type
global w_customer_recovery_report_setup w_customer_recovery_report_setup

type variables
DataStore ids_defectnot
Int il_cust
Boolean lb_updated
end variables

forward prototypes
public subroutine show_panel (integer level)
public subroutine wf_show_group ()
end prototypes

event type string ue_whoami();RETURN "w_customer_recovery_report_setup"
end event

public subroutine show_panel (integer level);
end subroutine

public subroutine wf_show_group ();Long ll_row, ll_i

tab_user.tabpage_defects.lb_defectnot.Reset()
ll_row = ids_defectnot.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_defects.lb_defectnot.AddItem(ids_defectnot.GetItemString(ll_i, "display_t", Primary!, FALSE) )
	NEXT
END IF

end subroutine

on w_customer_recovery_report_setup.create
int iCurrent
call super::create
this.ln_divider1=create ln_divider1
this.st_1=create st_1
this.st_username=create st_username
this.cb_close=create cb_close
this.cb_save=create cb_save
this.tab_user=create tab_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_divider1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_username
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.tab_user
end on

on w_customer_recovery_report_setup.destroy
call super::destroy
destroy(this.ln_divider1)
destroy(this.st_1)
destroy(this.st_username)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.tab_user)
end on

event open;call super::open;Long ll_row, ll_i
s_cust_datetime lds_data

lds_data = message.PowerObjectParm

il_cust = lds_data.customer_id
THis.Title = "Setup for Customer: " + lds_data.customer_name  
st_username.Text = lds_data.customer_name

lb_updated = FALSE


ids_defectnot = CREATE datastore  
ids_defectnot.DataObject = "d_recovery_setup_customer_nondefect_list"  
ids_defectnot.SetTransObject (SQLCA)  
ids_defectnot.Retrieve(il_cust)
tab_user.tabpage_defects.lb_defectnot.Reset()
ll_row = ids_defectnot.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		tab_user.tabpage_defects.lb_defectnot.AddItem(ids_defectnot.GetItemString(ll_i, "display_t"))
	NEXT
END IF

tab_user.tabpage_defects.dw_defectis.Retrieve(il_cust)
//
//ids_prinot = CREATE datastore  
//ids_prinot.DataObject = "d_user_notin_app"  
//ids_prinot.SetTransObject (SQLCA)  
//ids_prinot.Retrieve(ii_userid)
//tab_user.tabpage_pri.lb_prinot.Reset()
//ll_row = ids_prinot.RowCount()
//IF ll_row > 0 THEN 
//	FOR ll_i = 1 TO ll_row
//		tab_user.tabpage_pri.lb_prinot.AddItem(ids_prinot.GetItemString(ll_i, "application_name"))
//	NEXT
//END IF
//


end event

event close;call super::close;DESTROY ids_defectnot
end event

event pfc_save;call super::pfc_save;Int li_rc

li_rc = tab_user.tabpage_defects.dw_defectis.Update(TRUE, FALSE)
IF li_rc = 1 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -5
END IF
IF SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA;
	tab_user.tabpage_defects.dw_defectis.ResetUpdate()
	ids_defectnot.ResetUpdate()
END IF

lb_updated = TRUE

RETURN 1

end event

type ln_divider1 from line within w_customer_recovery_report_setup
integer linethickness = 3
integer beginx = 59
integer beginy = 528
integer endx = 1518
integer endy = 528
end type

type st_1 from u_st within w_customer_recovery_report_setup
integer x = 66
integer y = 35
integer width = 245
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "Customer:"
end type

type st_username from u_st within w_customer_recovery_report_setup
integer x = 344
integer y = 32
integer width = 1584
integer height = 74
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = ""
end type

type cb_close from u_cb within w_customer_recovery_report_setup
integer x = 1317
integer y = 1280
integer width = 399
integer height = 93
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;IF lb_updated THEN 
	ClosewithReturn(Parent, 1)
ELSE
	CloseWithReturn(Parent, 0)
END IF
end event

type cb_save from u_cb within w_customer_recovery_report_setup
event clicked pbm_bnclicked
integer x = 731
integer y = 1280
integer width = 399
integer height = 93
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;Parent.Event pfc_save()
end event

type tab_user from tab within w_customer_recovery_report_setup
event create ( )
event destroy ( )
integer x = 48
integer y = 150
integer width = 2256
integer height = 1094
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean fixedwidth = true
boolean boldselectedtext = true
boolean pictureonright = true
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_report tabpage_report
tabpage_defects tabpage_defects
end type

on tab_user.create
this.tabpage_general=create tabpage_general
this.tabpage_report=create tabpage_report
this.tabpage_defects=create tabpage_defects
this.Control[]={this.tabpage_general,&
this.tabpage_report,&
this.tabpage_defects}
end on

on tab_user.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_report)
destroy(this.tabpage_defects)
end on

type tabpage_general from userobject within tab_user
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 2227
integer height = 992
long backcolor = 79741120
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom092!"
long picturemaskcolor = 553648127
string powertiptext = "general"
st_3 st_3
em_targetbase em_targetbase
em_1 em_1
st_2 st_2
cbx_5 cbx_5
cbx_4 cbx_4
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
end type

on tabpage_general.create
this.st_3=create st_3
this.em_targetbase=create em_targetbase
this.em_1=create em_1
this.st_2=create st_2
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.Control[]={this.st_3,&
this.em_targetbase,&
this.em_1,&
this.st_2,&
this.cbx_5,&
this.cbx_4,&
this.cbx_1,&
this.cbx_2,&
this.cbx_3}
end on

on tabpage_general.destroy
destroy(this.st_3)
destroy(this.em_targetbase)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
end on

type st_3 from statictext within tabpage_general
integer x = 1254
integer y = 467
integer width = 84
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "%"
boolean focusrectangle = false
end type

type em_targetbase from editmask within tabpage_general
integer x = 1020
integer y = 461
integer width = 219
integer height = 77
integer taborder = 21
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##.##"
end type

type em_1 from editmask within tabpage_general
integer x = 1020
integer y = 368
integer width = 219
integer height = 77
integer taborder = 21
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##.##"
end type

type st_2 from statictext within tabpage_general
integer x = 1254
integer y = 371
integer width = 84
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "%"
boolean focusrectangle = false
end type

type cbx_5 from u_cbx within tabpage_general
integer x = 121
integer y = 464
integer width = 837
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Target Averages Range (Base)"
end type

type cbx_4 from u_cbx within tabpage_general
integer x = 121
integer y = 365
integer width = 775
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Target Averages Range (Top)"
end type

type cbx_1 from u_cbx within tabpage_general
integer x = 121
integer y = 67
integer width = 1148
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer needs daily reports"
end type

type cbx_2 from u_cbx within tabpage_general
integer x = 121
integer y = 166
integer width = 1123
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Send daily report using email"
end type

type cbx_3 from u_cbx within tabpage_general
integer x = 121
integer y = 266
integer width = 1068
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer need scrap piece count"
end type

type tabpage_report from userobject within tab_user
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 2227
integer height = 992
long backcolor = 79741120
string text = "Report"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "ArrangeTables!"
long picturemaskcolor = 553648127
lb_groupis lb_groupis
lb_groupnot lb_groupnot
st_6 st_6
st_7 st_7
cb_add1 cb_add1
cb_del cb_del
end type

on tabpage_report.create
this.lb_groupis=create lb_groupis
this.lb_groupnot=create lb_groupnot
this.st_6=create st_6
this.st_7=create st_7
this.cb_add1=create cb_add1
this.cb_del=create cb_del
this.Control[]={this.lb_groupis,&
this.lb_groupnot,&
this.st_6,&
this.st_7,&
this.cb_add1,&
this.cb_del}
end on

on tabpage_report.destroy
destroy(this.lb_groupis)
destroy(this.lb_groupnot)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cb_add1)
destroy(this.cb_del)
end on

type lb_groupis from u_lb within tabpage_report
integer x = 18
integer y = 83
integer width = 933
integer height = 883
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type lb_groupnot from u_lb within tabpage_report
integer x = 1320
integer y = 80
integer width = 881
integer height = 883
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type st_6 from statictext within tabpage_report
integer x = 22
integer y = 16
integer width = 450
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Run following reports"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_report
integer x = 1072
integer y = 16
integer width = 541
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "NOT run following reports"
boolean focusrectangle = false
end type

type cb_add1 from u_cb within tabpage_report
integer x = 965
integer y = 163
integer width = 344
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = " << &Add"
end type

event clicked;//String ls_item, ls_val
//Long ll_row, ll_i, ll_group, ll_temp
//
//ls_item = tab_user.tabpage_role.lb_groupnot.SelectedItem()
//IF Len(ls_item) < 2 THEN RETURN 0
//IF isNULL(ls_item) THEN Return -1
//ll_row = ids_groupnot.RowCount()
//IF ll_row < 1 THEN Return -2
//FOR ll_i = 1 TO ll_row
//	IF ls_item = ids_groupnot.GetItemString(ll_i, "security_group_group_name") THEN
//		ll_group = ids_groupnot.GetItemNumber(ll_i, "security_group_user_group_id")
//		ll_temp = ll_i
//	END IF
//NEXT
//ll_row = ids_groupis.InsertRow(0)
//ids_groupis.SetItem(ll_row, "security_user_group_user_id", ii_userid)
//ids_groupis.SetItem(ll_row, "security_user_group_user_group_id", ll_group)
//ids_groupis.setItem(ll_row, "security_group_group_name", ls_item)
//ids_groupnot.DeleteRow(ll_temp)
//
//wf_show_group()
//
//
//
//
end event

type cb_del from u_cb within tabpage_report
integer x = 965
integer y = 355
integer width = 344
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Remove >>"
end type

event clicked;//String ls_item, ls_val
//Long ll_row, ll_i, ll_group, ll_temp
//
//ls_item = tab_user.tabpage_role.lb_groupis.SelectedItem()
//IF Len(ls_item) < 2 THEN RETURN 0
//IF isNULL(ls_item) THEN Return -1
//ll_row = ids_groupis.RowCount()
//IF ll_row < 1 THEN Return -2
//FOR ll_i = 1 TO ll_row
//	IF ls_item = ids_groupis.GetItemString(ll_i, "security_group_group_name") THEN
//		ll_group = ids_groupis.GetItemNumber(ll_i, "security_user_group_user_group_id")
//		ll_temp = ll_i
//	END IF
//NEXT
//ll_row = ids_groupnot.InsertRow(0)
//ids_groupnot.SetItem(ll_row, "security_group_user_group_id", ll_group)
//ids_groupnot.setItem(ll_row, "security_group_group_name", ls_item)
//ids_groupis.DeleteRow(ll_temp)
//
//wf_show_group()
//
//
end event

type tabpage_defects from userobject within tab_user
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 2227
integer height = 992
long backcolor = 79741120
string text = "Defects"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DataManip!"
long picturemaskcolor = 553648127
cb_add2 cb_add2
cb_del2 cb_del2
lb_defectnot lb_defectnot
st_8 st_8
st_9 st_9
dw_defectis dw_defectis
end type

on tabpage_defects.create
this.cb_add2=create cb_add2
this.cb_del2=create cb_del2
this.lb_defectnot=create lb_defectnot
this.st_8=create st_8
this.st_9=create st_9
this.dw_defectis=create dw_defectis
this.Control[]={this.cb_add2,&
this.cb_del2,&
this.lb_defectnot,&
this.st_8,&
this.st_9,&
this.dw_defectis}
end on

on tabpage_defects.destroy
destroy(this.cb_add2)
destroy(this.cb_del2)
destroy(this.lb_defectnot)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.dw_defectis)
end on

type cb_add2 from u_cb within tabpage_defects
integer x = 1200
integer y = 186
integer width = 315
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "<< &Add"
end type

event clicked;String ls_item, ls_val, ls_code, ls_def
Long ll_row, ll_i, ll_app, ll_temp

ls_item = tab_user.tabpage_defects.lb_defectnot.SelectedItem()
ll_row = ids_defectnot.RowCount()
IF ll_row < 1 THEN Return -2
FOR ll_i = 1 TO ll_row
	IF ls_item = ids_defectnot.GetItemString(ll_i, "display_t") THEN
		ll_app = ids_defectnot.GetItemNumber(ll_i, "scrap_type_id")
		ls_code = ids_defectnot.GetItemString(ll_i, "scrap_type_scrap_code")
		ls_def = ids_defectnot.GetItemString(ll_i, "scrap_type_scrap_defect")
		ll_temp = ll_i
	END IF
NEXT
ll_row = tab_user.tabpage_defects.dw_defectis.InsertRow(0)
tab_user.tabpage_defects.dw_defectis.SetItem(ll_row, "CUST_SCRAP_TYPE_NEEDED_CUSTOMER_ID", il_cust)
tab_user.tabpage_defects.dw_defectis.SetItem(ll_row, "CUST_SCRAP_TYPE_NEEDED_SCRAP_TYPE_ID", ll_app)
tab_user.tabpage_defects.dw_defectis.SetItem(ll_row, "SCRAP_TYPE_SCRAP_CODE", ls_code)
tab_user.tabpage_defects.dw_defectis.SetItem(ll_row, "SCRAP_TYPE_SCRAP_DEFECT", ls_def)
tab_user.tabpage_defects.dw_defectis.SetItem(ll_row, "CUST_SCRAP_TYPE_NEEDED_ABC_OR_MILL",   'mill')
tab_user.tabpage_defects.dw_defectis.setItem(ll_row, "CUST_SCRAP_TYPE_NEEDED_AUTOPARTS", 0)
tab_user.tabpage_defects.dw_defectis.SetItem(ll_row, "CUST_SCRAP_TYPE_NEEDED_NON_AUTOPARTS", 1)
ids_defectnot.DeleteRow(ll_temp)

wf_show_group()




end event

type cb_del2 from u_cb within tabpage_defects
integer x = 1200
integer y = 403
integer width = 315
integer height = 93
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Remove >>"
end type

event clicked;String ls_def, ls_code, ls_val
Long ll_row, ll_i, ll_app, ll_temp
Long ll_exist

ll_row = tab_user.tabpage_defects.dw_defectis.GetRow()
IF ll_row < 1 THEN RETURN 0
ls_def = tab_user.tabpage_defects.dw_defectis.GetItemString(ll_row, "SCRAP_TYPE_SCRAP_DEFECT", Primary!, FALSE)
ls_code = tab_user.tabpage_defects.dw_defectis.GetItemString(ll_row, "SCRAP_TYPE_SCRAP_CODE", Primary!, FALSE)
ll_app = tab_user.tabpage_defects.dw_defectis.GetItemNumber(ll_row, "CUST_SCRAP_TYPE_NEEDED_SCRAP_TYPE_ID", Primary!, FALSE)
ll_temp = ll_row

ll_exist = 0
SELECT Count(QUALITY_SCRAP_WORKSHEET.SCRAP_ITEM_TYPE) INTO :ll_exist 
FROM AB_JOB,   QUALITY_SCRAP_WORKSHEET,   CUSTOMER_ORDER 
WHERE ( AB_JOB.AB_JOB_NUM = QUALITY_SCRAP_WORKSHEET.AB_JOB_NUM ) and  
         ( AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM ) and
			( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = :il_cust) and
			( QUALITY_SCRAP_WORKSHEET.SCRAP_ITEM_TYPE = :ll_app);
IF ll_exist > 0 THEN
	MessageBox("Sorry", "This defect may not be removed due to existing data in system.", StopSign!)
	RETURN -1
END IF

SELECT Count(RECOVERY_SCRAP_WORKSHEET.SCRAP_TYPE_ID) INTO :ll_exist 
FROM AB_JOB,   RECOVERY_SCRAP_WORKSHEET,   CUSTOMER_ORDER 
WHERE ( AB_JOB.AB_JOB_NUM = RECOVERY_SCRAP_WORKSHEET.AB_JOB_NUM ) and  
         ( AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM ) and
			( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = :il_cust) and
			( RECOVERY_SCRAP_WORKSHEET.SCRAP_TYPE_ID = :ll_app);
IF ll_exist > 0 THEN
	MessageBox("Sorry", "This defect may not be removed due to existing data in system.", StopSign!)
	RETURN -1
END IF

ll_row = ids_defectnot.InsertRow(0)
ids_defectnot.SetItem(ll_row, "scrap_type_id", ll_app)
ids_defectnot.setItem(ll_row, "scrap_type_scrap_defect", ls_def)
ids_defectnot.setItem(ll_row, "scrap_type_scrap_code", ls_code)
tab_user.tabpage_defects.dw_defectis.DeleteRow(ll_temp)

wf_show_group()




end event

type lb_defectnot from u_lb within tabpage_defects
integer x = 1514
integer y = 83
integer width = 706
integer height = 883
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type st_8 from statictext within tabpage_defects
integer x = 22
integer y = 16
integer width = 505
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Tracking these defects:"
boolean focusrectangle = false
end type

type st_9 from statictext within tabpage_defects
integer x = 1503
integer y = 16
integer width = 629
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Not tracking these defects:"
boolean focusrectangle = false
end type

type dw_defectis from u_dw within tabpage_defects
integer y = 90
integer width = 1196
integer height = 883
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_recovery_setup_customer_defect_list"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
this.SetTransObject(SQLCA)

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

