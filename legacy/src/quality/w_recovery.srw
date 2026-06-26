$PBExportHeader$w_recovery.srw
forward
global type w_recovery from w_sheet
end type
type cb_setup from u_cb within w_recovery
end type
type dw_customer from u_dw within w_recovery
end type
type cb_reset from u_cb within w_recovery
end type
type sle_coil from singlelineedit within w_recovery
end type
type st_3 from statictext within w_recovery
end type
type st_1 from statictext within w_recovery
end type
type em_end from u_em within w_recovery
end type
type em_start from u_em within w_recovery
end type
type cb_close from u_cb within w_recovery
end type
type cb_1 from u_cb within w_recovery
end type
type st_2 from statictext within w_recovery
end type
type st_5 from statictext within w_recovery
end type
type ddlb_customer from dropdownlistbox within w_recovery
end type
type tab_rec from tab within w_recovery
end type
type tabpage_data from userobject within tab_rec
end type
type cb_delete from u_cb within tabpage_data
end type
type cb_add from u_cb within tabpage_data
end type
type dw_main from u_dw within tabpage_data
end type
type cb_save from u_cb within tabpage_data
end type
type dw_defects from u_dw within tabpage_data
end type
type st_8 from statictext within tabpage_data
end type
type dw_coil_job from u_dw within tabpage_data
end type
type st_7 from statictext within tabpage_data
end type
type gb_2 from groupbox within tabpage_data
end type
type tabpage_data from userobject within tab_rec
cb_delete cb_delete
cb_add cb_add
dw_main dw_main
cb_save cb_save
dw_defects dw_defects
st_8 st_8
dw_coil_job dw_coil_job
st_7 st_7
gb_2 gb_2
end type
type tabpage_report from userobject within tab_rec
end type
type dw_type from u_dw within tabpage_report
end type
type ddlb_type from dropdownlistbox within tabpage_report
end type
type st_4 from statictext within tabpage_report
end type
type cb_retrieve from u_cb within tabpage_report
end type
type cb_email from u_cb within tabpage_report
end type
type cb_3 from u_cb within tabpage_report
end type
type cb_2 from u_cb within tabpage_report
end type
type dw_report from u_dw within tabpage_report
end type
type tabpage_report from userobject within tab_rec
dw_type dw_type
ddlb_type ddlb_type
st_4 st_4
cb_retrieve cb_retrieve
cb_email cb_email
cb_3 cb_3
cb_2 cb_2
dw_report dw_report
end type
type tabpage_file from u_tabpg_fileview_recovery within tab_rec
end type
type tabpage_file from u_tabpg_fileview_recovery within tab_rec
end type
type tab_rec from tab within w_recovery
tabpage_data tabpage_data
tabpage_report tabpage_report
tabpage_file tabpage_file
end type
type gb_1 from groupbox within w_recovery
end type
type gb_3 from groupbox within w_recovery
end type
end forward

global type w_recovery from w_sheet
integer width = 4484
integer height = 2147
string title = "ABCO Recovery Report"
boolean resizable = false
event type string ue_whoami ( )
cb_setup cb_setup
dw_customer dw_customer
cb_reset cb_reset
sle_coil sle_coil
st_3 st_3
st_1 st_1
em_end em_end
em_start em_start
cb_close cb_close
cb_1 cb_1
st_2 st_2
st_5 st_5
ddlb_customer ddlb_customer
tab_rec tab_rec
gb_1 gb_1
gb_3 gb_3
end type
global w_recovery w_recovery

type variables
Long il_cust
String is_cust
end variables

event type string ue_whoami();RETURN "w_recovery"
end event

on w_recovery.create
int iCurrent
call super::create
this.cb_setup=create cb_setup
this.dw_customer=create dw_customer
this.cb_reset=create cb_reset
this.sle_coil=create sle_coil
this.st_3=create st_3
this.st_1=create st_1
this.em_end=create em_end
this.em_start=create em_start
this.cb_close=create cb_close
this.cb_1=create cb_1
this.st_2=create st_2
this.st_5=create st_5
this.ddlb_customer=create ddlb_customer
this.tab_rec=create tab_rec
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_setup
this.Control[iCurrent+2]=this.dw_customer
this.Control[iCurrent+3]=this.cb_reset
this.Control[iCurrent+4]=this.sle_coil
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_end
this.Control[iCurrent+8]=this.em_start
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.ddlb_customer
this.Control[iCurrent+14]=this.tab_rec
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_3
end on

on w_recovery.destroy
call super::destroy
destroy(this.cb_setup)
destroy(this.dw_customer)
destroy(this.cb_reset)
destroy(this.sle_coil)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.em_end)
destroy(this.em_start)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.ddlb_customer)
destroy(this.tab_rec)
destroy(this.gb_1)
destroy(this.gb_3)
end on

event open;call super::open;dw_customer.Visible = FALSE
tab_rec.tabpage_report.dw_type.Visible = FALSE

tab_rec.tabpage_data.dw_main.of_SetLinkage(TRUE)

//coil_job list
tab_rec.tabpage_data.dw_coil_job.of_SetLinkage( TRUE ) 
tab_rec.tabpage_data.dw_coil_job.inv_Linkage.of_SetMaster(tab_rec.tabpage_data.dw_main)
IF NOT tab_rec.tabpage_data.dw_coil_job.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked coil and job!" )
ELSE
	tab_rec.tabpage_data.dw_coil_job.inv_Linkage.of_Register( "coil_coil_abc_num", "process_coil_coil_abc_num" ) 
	tab_rec.tabpage_data.dw_coil_job.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_rec.tabpage_data.dw_main.inv_Linkage.of_SetTransObject(sqlca) 

Long ll_row, ll_c
dw_customer.Retrieve()
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_c, "customer_name"))
		IF ll_c = 1 THEN 
			il_cust = dw_customer.GetItemNumber(ll_c, "customer_id")
			is_cust = dw_customer.GetItemString(ll_c, "customer_name")
			tab_rec.tabpage_report.ddlb_type.Event ue_customer_changed()
		END IF
	NEXT
	ddlb_customer.SelectItem(1)
END IF










end event

type cb_setup from u_cb within w_recovery
integer x = 4052
integer y = 80
integer width = 351
integer height = 93
integer taborder = 70
integer weight = 700
string text = "Setup"
end type

event clicked;call super::clicked;s_cust_datetime lds_data
Integer li_rc
DateTime ldt_s, ldt_e

lds_data.customer_id = il_cust
lds_data.start_time= Datetime(Date(em_start.Text), Time("00:00:00") ) 
lds_data.end_time = Datetime(Date(em_end.Text), Time("23:59:59") ) 
lds_data.customer_name = is_cust

OpenWithParm(w_customer_recovery_report_setup, lds_data)
li_rc = Message.DoubleParm
	IF li_rc > 0 THEN
		tab_rec.tabpage_data.dw_main.inv_linkage.of_retrieve()
		tab_rec.tabpage_data.dw_main.SetFocus()
	END IF
RETURN 1
end event

type dw_customer from u_dw within w_recovery
integer x = 1170
integer y = 2000
integer width = 106
integer height = 48
integer taborder = 80
string dataobject = "d_recovery_customer_list"
boolean vscrollbar = false
boolean righttoleft = true
end type

event clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 









end event

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)




end event

event rbuttondown;//disbaled
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

type cb_reset from u_cb within w_recovery
integer x = 3635
integer y = 80
integer width = 351
integer height = 93
integer taborder = 70
integer weight = 700
string text = "Reset"
end type

event clicked;call super::clicked;tab_rec.tabpage_data.dw_main.inv_linkage.of_Reset()

end event

type sle_coil from singlelineedit within w_recovery
integer x = 2714
integer y = 86
integer width = 475
integer height = 80
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_recovery
integer x = 2333
integer y = 96
integer width = 384
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Customer Coil ID:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_recovery
integer x = 2216
integer y = 96
integer width = 91
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "OR"
boolean focusrectangle = false
end type

type em_end from u_em within w_recovery
integer x = 1876
integer y = 86
integer width = 307
integer height = 80
integer taborder = 30
integer textsize = -9
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
end type

event constructor;call super::constructor;this.Text = String(Today(), 'MM/DD/YYYY')
end event

type em_start from u_em within w_recovery
integer x = 1445
integer y = 86
integer width = 325
integer height = 80
integer taborder = 20
integer textsize = -9
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
end type

event constructor;call super::constructor;this.Text = String(Today(), 'MM/DD/YYYY')
end event

type cb_close from u_cb within w_recovery
integer x = 4067
integer y = 1984
integer width = 351
integer height = 93
integer taborder = 70
integer weight = 700
string text = "Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_1 from u_cb within w_recovery
integer x = 3218
integer y = 80
integer width = 351
integer height = 93
integer taborder = 50
integer weight = 700
string text = "Enter"
end type

event clicked;call super::clicked;IF tab_rec.tabpage_data.dw_main.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_recovery::ue_retrievelinkage" )
ELSE
	SQLCA.of_Commit()
	tab_rec.tabpage_data.dw_main.SetFocus()
End IF
end event

type st_2 from statictext within w_recovery
integer x = 1788
integer y = 96
integer width = 91
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_recovery
integer x = 1298
integer y = 96
integer width = 146
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "From:"
boolean focusrectangle = false
end type

type ddlb_customer from dropdownlistbox within w_recovery
integer x = 40
integer y = 83
integer width = 1196
integer height = 1248
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Long ll_row, ll_i
String ls_cust

ls_cust = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_name") = ls_cust THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		il_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
	END IF
NEXT

tab_rec.tabpage_data.dw_main.Event pfc_retrieve()
is_cust = ls_cust

IF tab_rec.SelectedTab = 3 THEN
	tab_rec.tabpage_file.of_recovery_init(is_cust)
END IF

tab_rec.tabpage_report.ddlb_type.Event ue_customer_changed()


RETURN 1


end event

type tab_rec from tab within w_recovery
integer x = 11
integer y = 224
integer width = 4421
integer height = 1738
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_data tabpage_data
tabpage_report tabpage_report
tabpage_file tabpage_file
end type

on tab_rec.create
this.tabpage_data=create tabpage_data
this.tabpage_report=create tabpage_report
this.tabpage_file=create tabpage_file
this.Control[]={this.tabpage_data,&
this.tabpage_report,&
this.tabpage_file}
end on

on tab_rec.destroy
destroy(this.tabpage_data)
destroy(this.tabpage_report)
destroy(this.tabpage_file)
end on

event clicked;IF this.SelectedTab = 3 THEN
		tabpage_file.of_recovery_init(is_cust)
END IF
RETURN 1
end event

type tabpage_data from userobject within tab_rec
integer x = 15
integer y = 90
integer width = 4392
integer height = 1635
long backcolor = 79741120
string text = "Source Data"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_delete cb_delete
cb_add cb_add
dw_main dw_main
cb_save cb_save
dw_defects dw_defects
st_8 st_8
dw_coil_job dw_coil_job
st_7 st_7
gb_2 gb_2
end type

on tabpage_data.create
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_main=create dw_main
this.cb_save=create cb_save
this.dw_defects=create dw_defects
this.st_8=create st_8
this.dw_coil_job=create dw_coil_job
this.st_7=create st_7
this.gb_2=create gb_2
this.Control[]={this.cb_delete,&
this.cb_add,&
this.dw_main,&
this.cb_save,&
this.dw_defects,&
this.st_8,&
this.dw_coil_job,&
this.st_7,&
this.gb_2}
end on

on tabpage_data.destroy
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_main)
destroy(this.cb_save)
destroy(this.dw_defects)
destroy(this.st_8)
destroy(this.dw_coil_job)
destroy(this.st_7)
destroy(this.gb_2)
end on

type cb_delete from u_cb within tabpage_data
integer x = 1924
integer y = 1526
integer width = 384
integer height = 93
integer taborder = 90
integer weight = 700
string facename = "Arial"
string text = "&Remove Coil"
end type

event clicked;call super::clicked;s_cust_datetime lds_data
Integer li_rc
DateTime ldt_s, ldt_e

lds_data.customer_id = il_cust
lds_data.start_time= Datetime(Date(em_start.Text), Time("00:00:00") ) 
lds_data.end_time = Datetime(Date(em_end.Text), Time("23:59:59") ) 
lds_data.customer_name = is_cust

OpenWithParm(w_recovery_delete, lds_data)
li_rc = Message.DoubleParm
	IF li_rc > 0 THEN
		tab_rec.tabpage_data.dw_main.inv_linkage.of_retrieve()
		tab_rec.tabpage_data.dw_main.SetFocus()
	END IF
RETURN 1
end event

type cb_add from u_cb within tabpage_data
integer x = 962
integer y = 1526
integer width = 351
integer height = 93
integer taborder = 80
integer weight = 700
string facename = "Arial"
string text = "&Add Coil"
end type

event clicked;call super::clicked;s_cust_datetime lds_data
Integer li_rc
DateTime ldt_s, ldt_e

lds_data.customer_id = il_cust
lds_data.start_time= Datetime(Date(em_start.Text), Time("00:00:00") ) 
lds_data.end_time = Datetime(Date(em_end.Text), Time("23:59:59") ) 
lds_data.customer_name = is_cust

OpenWithParm(w_recovery_selection, lds_data)
li_rc = Message.DoubleParm
	IF li_rc > 0 THEN
		tab_rec.tabpage_data.dw_main.inv_linkage.of_retrieve()
		tab_rec.tabpage_data.dw_main.SetFocus()
	END IF
RETURN 1
end event

type dw_main from u_dw within tabpage_data
integer y = 29
integer width = 3233
integer height = 1475
integer taborder = 140
string dataobject = "d_recovery_info_main"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)

end event

event pfc_retrieve;call super::pfc_retrieve;DateTime ldt_s, ldt_e

ldt_s = Datetime(Date(em_start.Text), Time("00:00:00") ) 
ldt_e = Datetime(Date(em_end.Text), Time("23:59:59") ) 

Return this.Retrieve(ldt_s, ldt_e, il_cust)
end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type cb_save from u_cb within tabpage_data
integer x = 3675
integer y = 1520
integer width = 351
integer height = 93
integer taborder = 130
integer weight = 700
string text = "Save"
end type

event clicked;call super::clicked;Long ll_coil, ll_job, ll_screenrow
Long ll_s, ll_i, ll_updaterow, ll_new, ll_row
Long ll_erow, ll_rc
Long ll_value, ll_pc
DataStore lds_d


IF tab_rec.tabpage_data.dw_main.RowCount() = 0 THEN
	RETURN 0
END IF

ll_row = tab_rec.tabpage_data.dw_coil_job.GetRow()
IF ll_row <= 0 THEN
	RETURN 0
END IF

ll_coil = tab_rec.tabpage_data.dw_coil_job.GetItemNumber(ll_row, "process_coil_coil_abc_num")
ll_job = tab_rec.tabpage_data.dw_coil_job.GetItemNumber(ll_row, "process_coil_ab_job_num")


lds_d = CREATE datastore  
lds_d.DataObject = "d_update_coil_job_defects"  
lds_d.SetTransObject (SQLCA)  
lds_d.Retrieve(ll_job, ll_coil)

tab_rec.tabpage_data.dw_defects.AcceptText()
ll_screenrow = tab_rec.tabpage_data.dw_defects.RowCount()
FOR ll_s = 1 TO ll_screenrow 
	ll_value = tab_rec.tabpage_data.dw_defects.GetItemNumber(ll_s, "value")
	IF isNULL(ll_value) THEN ll_value = 0
	ll_pc = tab_rec.tabpage_data.dw_defects.GetItemNumber(ll_s, "piece")
	IF isNULL(ll_pc) THEN ll_pc = 0
	ll_erow = 0
	ll_updaterow = lds_d.RowCount()
	IF ll_updaterow > 0 THEN
   	FOR ll_i = 1 TO ll_updaterow
			IF tab_rec.tabpage_data.dw_defects.GetItemString(ll_s, "scrap_code") = lds_d.GetItemString(ll_i, "scrap_type_scrap_code") THEN
               ll_erow = ll_s
					lds_d.SetItem(ll_i,"recovery_scrap_worksheet_scrap_item_net_wt", ll_value)
					lds_d.SetItem(ll_i,"recovery_scrap_worksheet_scrap_item_piece", ll_pc)
			END IF
		NEXT
	END IF
	IF ll_erow = 0 THEN
		IF ll_value > 0 OR ll_pc > 0 THEN
			ll_erow = lds_d.InsertRow(0)
			lds_d.SetItem(ll_erow,"recovery_scrap_worksheet_scrap_item_net_wt", ll_value)
			lds_d.SetItem(ll_erow,"recovery_scrap_worksheet_scrap_item_piece", ll_pc)		
			lds_d.SetItem(ll_erow,"recovery_scrap_worksheet_coil_abc_num", ll_coil)
			lds_d.SetItem(ll_erow,"recovery_scrap_worksheet_ab_job_num", ll_job)		
			lds_d.SetItem(ll_erow,"recovery_scrap_worksheet_scrap_type_id", tab_rec.tabpage_data.dw_defects.GetItemNumber(ll_s, "id"))		
		END IF
	END IF
NEXT
lds_d.AcceptText()
ll_rc = lds_d.Update(TRUE, TRUE)
IF ll_rc = 1 THEN
        COMMIT USING SQLCA;
ELSE
        ROLLBACK USING SQLCA;
END IF
DESTROY lds_d
	
tab_rec.tabpage_data.dw_defects.ResetUpdate()

RETURN 1
end event

type dw_defects from u_dw within tabpage_data
event type integer ue_retrieve ( )
integer x = 3288
integer y = 506
integer width = 1093
integer height = 998
integer taborder = 70
string dataobject = "d_recovery_defect_input"
end type

event type integer ue_retrieve();Long ll_row, ll_coil, ll_job, ll_drow, ll_i, ll_new
Long ll_erow, ll_j
Long ll_part_id, ll_autopart
Long ll_office_data_exist
DataStore lds_d

this.Reset()

IF tab_rec.tabpage_data.dw_main.RowCount() = 0 THEN
	RETURN 0
END IF

ll_row = tab_rec.tabpage_data.dw_coil_job.GetRow()
IF ll_row <= 0 THEN
	RETURN 0
END IF

ll_coil = tab_rec.tabpage_data.dw_coil_job.GetItemNumber(ll_row, "process_coil_coil_abc_num")
ll_job = tab_rec.tabpage_data.dw_coil_job.GetItemNumber(ll_row, "process_coil_ab_job_num")

ll_part_id = 0

SELECT ORDER_ITEM.PART_NUM_ID INTO :ll_part_id  
FROM AB_JOB,   ORDER_ITEM  
WHERE ( ORDER_ITEM.ORDER_ITEM_NUM = AB_JOB.ORDER_ITEM_NUM) and  
         (ORDER_ITEM.ORDER_ABC_NUM = AB_JOB.ORDER_ABC_NUM ) and 
			(AB_JOB.AB_JOB_NUM = :ll_job)
USING SQLCA;

IF isNULL(ll_part_id) OR ll_part_id <= 0 THEN 
    ll_autopart = 0
ELSE	
	SELECT autoparts INTO :ll_autopart
	FROM Part_num
	WHERE part_num_id = :ll_part_id
	USING SQLCA;
END IF
IF isNULL(ll_autopart) THEN 
	ll_autopart = 0
END IF

//create empty dataset
lds_d = CREATE datastore  
lds_d.DataObject = "d_recovery_customer_defect_list"  
lds_d.SetTransObject (SQLCA)  
lds_d.Retrieve(il_cust)
ll_drow = lds_d.RowCount()
	IF ll_drow > 0 THEN
		FOR ll_i = 1 TO ll_drow
			IF ll_autopart = 1 THEN 
				IF lds_d.GetItemNumber(ll_i, "cust_scrap_type_needed_autoparts") = 1 THEN
					ll_new = this.InsertRow(0)
					this.SetItem(ll_new,"scrap_code", lds_d.GetItemString(ll_i, "scrap_type_scrap_code"))
					this.SetItem(ll_new,"scrap_defect", lds_d.GetItemString(ll_i, "scrap_type_scrap_defect"))
					this.SetItem(ll_new,"id", lds_d.GetItemNumber(ll_i, "cust_scrap_type_needed_scrap_type_id"))
				END IF
			ELSE
				ll_new = this.InsertRow(0)
				this.SetItem(ll_new,"scrap_code", lds_d.GetItemString(ll_i, "scrap_type_scrap_code"))
				this.SetItem(ll_new,"scrap_defect", lds_d.GetItemString(ll_i, "scrap_type_scrap_defect"))				
				this.SetItem(ll_new,"id", lds_d.GetItemNumber(ll_i, "cust_scrap_type_needed_scrap_type_id"))
			END IF
		NEXT
	END IF
DESTROY lds_d

//existing data
ll_office_data_exist = 0
SELECT COUNT(*) INTO :ll_office_data_exist
FROM RECOVERY_SCRAP_WORKSHEET
WHERE (ab_job_num = :ll_job) AND (coil_abc_num = :ll_coil)
USING SQLCA;

lds_d = CREATE datastore
IF ll_office_data_exist > 0 THEN  //existing office data
	lds_d.DataObject = "d_existing_coil_job_defects_office"  
	lds_d.SetTransObject (SQLCA)  
	lds_d.Retrieve(ll_job, ll_coil)
	ll_drow = lds_d.RowCount()
	IF ll_drow > 0 THEN
		ll_erow = this.RowCount()
		FOR ll_i = 1 TO ll_drow
			FOR ll_j = 1 to ll_erow
				IF this.GetItemString(ll_j, "scrap_code") = lds_d.GetItemString(ll_i, "scrap_type_scrap_code") THEN
				   this.SetItem(ll_j,"value", lds_d.GetItemNumber(ll_i, "recovery_scrap_worksheet_scrap_item_net_wt"))
				   this.SetItem(ll_j,"piece", lds_d.GetItemNumber(ll_i, "recovery_scrap_worksheet_scrap_item_piece"))
				END IF
			NEXT
		NEXT
	END IF
ELSE  //data from DAS
	lds_d.DataObject = "d_existing_coil_job_defects_das"  
	lds_d.SetTransObject (SQLCA)  
	lds_d.Retrieve(ll_job, ll_coil)
	ll_drow = lds_d.RowCount()
	IF ll_drow > 0 THEN
		ll_erow = this.RowCount()
		FOR ll_i = 1 TO ll_drow
			FOR ll_j = 1 to ll_erow
				IF this.GetItemString(ll_j, "scrap_code") = lds_d.GetItemString(ll_i, "scrap_type_scrap_code") THEN
				   this.SetItem(ll_j,"value", lds_d.GetItemNumber(ll_i, "total_wt"))
				   this.SetItem(ll_j,"piece", lds_d.GetItemNumber(ll_i, "total_pc"))
				END IF
			NEXT
		NEXT
	END IF
END IF
DESTROY lds_d
	
this.ResetUpdate()

RETURN 1
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)

end event

event rbuttondown;RETURN 0

end event

event rbuttonup;RETURN 0
end event

type st_8 from statictext within tabpage_data
integer x = 3288
integer y = 448
integer width = 538
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Defects:"
boolean focusrectangle = false
end type

type dw_coil_job from u_dw within tabpage_data
integer x = 3288
integer y = 109
integer width = 1086
integer height = 326
integer taborder = 60
string dataobject = "d_recovery_job_coil"
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)

end event

event clicked;//Override pfc's clicked because it is running on wrong sequence
integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

tab_rec.tabpage_data.dw_defects.Event ue_retrieve()

Return 
end event

event rowfocuschanged;call super::rowfocuschanged;tab_rec.tabpage_data.dw_defects.Event ue_retrieve()
end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type st_7 from statictext within tabpage_data
integer x = 3288
integer y = 42
integer width = 538
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Coil/Job List:"
boolean focusrectangle = false
end type

type gb_2 from groupbox within tabpage_data
integer x = 3248
integer width = 1145
integer height = 1629
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
end type

type tabpage_report from userobject within tab_rec
integer x = 15
integer y = 90
integer width = 4392
integer height = 1635
long backcolor = 79741120
string text = "Reports"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_type dw_type
ddlb_type ddlb_type
st_4 st_4
cb_retrieve cb_retrieve
cb_email cb_email
cb_3 cb_3
cb_2 cb_2
dw_report dw_report
end type

on tabpage_report.create
this.dw_type=create dw_type
this.ddlb_type=create ddlb_type
this.st_4=create st_4
this.cb_retrieve=create cb_retrieve
this.cb_email=create cb_email
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_report=create dw_report
this.Control[]={this.dw_type,&
this.ddlb_type,&
this.st_4,&
this.cb_retrieve,&
this.cb_email,&
this.cb_3,&
this.cb_2,&
this.dw_report}
end on

on tabpage_report.destroy
destroy(this.dw_type)
destroy(this.ddlb_type)
destroy(this.st_4)
destroy(this.cb_retrieve)
destroy(this.cb_email)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_report)
end on

type dw_type from u_dw within tabpage_report
integer x = 2286
integer y = 22
integer width = 143
integer height = 54
integer taborder = 11
string dataobject = "d_recovery_customer_report_template"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

type ddlb_type from dropdownlistbox within tabpage_report
event type long ue_customer_changed ( )
integer x = 2940
integer y = 19
integer width = 1430
integer height = 675
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_customer_changed();Long ll_row, ll_i

this.Reset()

tab_rec.tabpage_report.dw_type.Retrieve(il_cust, is_cust)
tab_rec.tabpage_report.dw_type.SelectRow(1,TRUE)
ll_row = tab_rec.tabpage_report.dw_type.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		this.AddItem(tab_rec.tabpage_report.dw_type.GetItemString(ll_i, "recovery_report_type_recovery_report_type"))
	NEXT
END IF

this.SelectItem(1)
this.Event SelectionChanged(1)

RETURN 1
end event

event selectionchanged;SetPointer(HourGlass!)

String ls_text, ls_object, ls_event, ls_modstring
Long ll_row, ll_i

ls_text = Text(index)
IF Len(ls_text) < 2 THEN Return 0

ll_row = tab_rec.tabpage_report.dw_type.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		IF tab_rec.tabpage_report.dw_type.GetItemString(ll_i, "recovery_report_type_recovery_report_type") = ls_text THEN
			ls_object = tab_rec.tabpage_report.dw_type.GetItemString(ll_i, "recovery_report_type_recovery_report_datawindow")
			ls_event = tab_rec.tabpage_report.dw_type.GetItemString(ll_i, "recovery_report_type_recovery_report_event")
		END IF
	NEXT
END IF

tab_rec.tabpage_report.dw_report.DataObject = ls_object

CHOOSE CASE ls_event
	CASE "ue_report_recovery_product_type_summary"
		tab_rec.tabpage_report.dw_report.Event ue_report_recovery_product_type_summary()
	CASE "ue_report_scrapdefectdetails_main"
		tab_rec.tabpage_report.dw_report.Event ue_report_scrapdefectdetails_main()
	CASE "ue_report_recovery_rej_coil_yearly"
		tab_rec.tabpage_report.dw_report.Event ue_report_recovery_rej_coil_yearly()
	CASE "ue_report_recovery_historical_data"
		tab_rec.tabpage_report.dw_report.Event ue_report_recovery_historical_data()
	CASE "ue_report_recovery_yearly_summary"
		tab_rec.tabpage_report.dw_report.Event ue_report_recovery_yearly_summary()
	CASE "ue_filling_basic_daily_report"
		tab_rec.tabpage_report.dw_report.Event ue_filling_basic_daily_report()
	CASE "ue_daily_report_constellium"
		tab_rec.tabpage_report.dw_report.Event ue_daily_report_constellium()
END CHOOSE

RETURN 1
end event

type st_4 from statictext within tabpage_report
integer x = 2571
integer y = 26
integer width = 362
integer height = 77
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
string text = "Select a report :"
boolean focusrectangle = false
end type

type cb_retrieve from u_cb within tabpage_report
integer x = 1203
integer y = 1536
integer width = 351
integer height = 93
integer taborder = 170
integer weight = 700
string text = "&Retrieve"
end type

event clicked;call super::clicked;tab_rec.tabpage_report.dw_report.Reset()
//tab_rec.tabpage_report.dw_report.Event ue_filling_basic_daily_report()
//tab_rec.tabpage_report.dw_report.Event ue_daily_report_constellium()
//tab_rec.tabpage_report.dw_report.Event ue_report_scrapdefectdetails_main()
//tab_rec.tabpage_report.dw_report.Event ue_report_recovery_yearly_summary()
//tab_rec.tabpage_report.dw_report.Event ue_report_recovery_rej_coil_yearly()
//tab_rec.tabpage_report.dw_report.Event ue_report_recovery_product_type_summary()
tab_rec.tabpage_report.dw_report.Event ue_report_recovery_historical_data()
tab_rec.tabpage_report.dw_report.ResetUpdate()
RETURN 1
end event

type cb_email from u_cb within tabpage_report
integer x = 2684
integer y = 1536
integer width = 351
integer height = 93
integer taborder = 180
integer weight = 700
string text = "Email"
end type

type cb_3 from u_cb within tabpage_report
integer x = 2191
integer y = 1536
integer width = 351
integer height = 93
integer taborder = 170
integer weight = 700
string text = "Print"
end type

event clicked;call super::clicked;RETURN tab_rec.tabpage_report.dw_report.Event pfc_print()
end event

type cb_2 from u_cb within tabpage_report
integer x = 1697
integer y = 1536
integer width = 351
integer height = 93
integer taborder = 160
integer weight = 700
string text = "Export"
end type

type dw_report from u_dw within tabpage_report
event type long ue_filling_basic_daily_report ( )
event type long ue_daily_report_constellium ( )
event type long ue_report_scrapdefectdetails_main ( )
event type long ue_report_recovery_yearly_summary ( )
event type long ue_report_recovery_rej_coil_yearly ( )
event type long ue_re ( )
event type long ue_report_recovery_product_type_summary ( )
event type long ue_report_recovery_historical_data ( )
integer x = 22
integer y = 112
integer width = 4348
integer height = 1408
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_report_recovery_historical_data"
boolean hscrollbar = true
end type

event type long ue_filling_basic_daily_report();Long ll_row, ll_i, ll_newrow, ll_j, ll_k, ll_drow, ll_erow, ll_d, ll_e
Long ll_coil, ll_job, ll_coil_wt, ll_ship_wt, ll_scrap_wt, ll_rej_wt, ll_def_wt
String ls_coil, ls_yield, ls_defs, ls_pareto, ls_def_temp
Boolean lb_exist
DataStore lds_t, lds_m
Long ll_wt_temp, ll_pc_temp

ll_row = tab_rec.tabpage_data.dw_main.RowCount()
IF ll_row <= 0 THEN RETURN 0

lds_t = CREATE datastore  
lds_t.DataObject = "d_recovery_customer_defect_worksheet"  
lds_t.SetTransObject (SQLCA) 

lb_exist = FALSE
FOR ll_i = 1 TO ll_row
	ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "coil_coil_abc_num")
	ls_coil = tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "coil_coil_org_num")
	ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
	
	IF this.RowCount() > 0 THEN
		FOR ll_j = 1 TO this.RowCount()
			IF ls_coil = this.GetItemString(ll_j, "coil_num") THEN
				lb_exist = TRUE
			END IF
		NEXT
	END IF
	
	IF NOT(lb_exist) THEN
		ll_newrow = this.InsertRow(0)
		this.SetItem(ll_newrow, "coil_num", ls_coil)
		this.SetItem(ll_newrow, "lot_num", tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "coil_lot_num"))
		ll_coil_wt = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
		this.SetItem(ll_newrow, "coil_wt", ll_coil_wt)
		
		ll_ship_wt = 0
		FOR ll_k = 1 TO ll_row
			IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "coil_coil_abc_num") THEN
				ll_ship_wt = ll_ship_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "ship_wt")
			END IF
		NEXT
		this.SetItem(ll_newrow, "ship_wt", ll_ship_wt)
		
		ll_rej_wt = 0
		FOR ll_k = 1 TO ll_row
			IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "coil_coil_abc_num") THEN
				ll_rej_wt = ll_rej_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "rejected_wt")
			END IF
		NEXT
		this.SetItem(ll_newrow, "rejected_wt", ll_rej_wt)

		ll_scrap_wt = 0
		FOR ll_k = 1 TO ll_row
			IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "coil_coil_abc_num") THEN
				ll_scrap_wt = ll_scrap_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "scrap_wt")				
			END IF
		NEXT
		this.SetItem(ll_newrow, "scrap_wt", ll_scrap_wt)

		this.SetItem(ll_newrow, "coil_yield", String(100.00 * (1.00 - 1.00*(ll_scrap_wt/ll_coil_wt)),"###.##") + "%")		
      
		lds_t.Reset()
		lds_t.Retrieve(il_cust)
		FOR ll_k = 1 TO ll_row
			ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "ab_job_ab_job_num")
			IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "coil_coil_abc_num") THEN
					lds_m = CREATE DataStore
					lds_m.DataObject = "d_existing_coil_job_defects_office"  
					lds_m.SetTransObject(SQLCA)  
					lds_m.Retrieve(ll_job, ll_coil)
					ll_drow = lds_m.RowCount()
					IF ll_drow > 0 THEN
						ll_erow = lds_t.RowCount()
						FOR ll_d = 1 TO ll_drow
							FOR ll_e = 1 to ll_erow
								IF lds_t.GetItemString(ll_e, "scrap_type_scrap_code") = lds_m.GetItemString(ll_d, "scrap_type_scrap_code") THEN
									ll_wt_temp = lds_t.GetItemNumber(ll_e, "TOTAL_WT")
									IF isNULL(ll_wt_temp) THEN ll_wt_temp = 0
									ll_wt_temp = ll_wt_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_net_wt")
				  				 	lds_t.SetItem(ll_e,"TOTAL_WT", ll_wt_temp)
										
									ll_pc_temp = lds_t.GetItemNumber(ll_e, "TOTAL_PC")
									IF isNULL(ll_pc_temp) THEN ll_pc_temp = 0
									ll_pc_temp = ll_pc_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_piece")
									lds_t.SetItem(ll_e,"TOTAL_PC", ll_pc_temp)
									
									lds_t.AcceptText()
								END IF
							NEXT
						NEXT
					END IF
					
					DESTROY lds_m
			END IF
		NEXT
		
		lds_t.AcceptText()
		ll_erow = lds_t.RowCount()
		FOR ll_e = 1 TO ll_erow
			ls_def_temp = lds_t.GetItemString(ll_e, "scrap_type_scrap_defect")
			ll_wt_temp = lds_t.GetItemNumber(ll_e, "TOTAL_WT")
			ll_pc_temp = lds_t.GetItemNumber(ll_e, "TOTAL_PC")
			IF ll_wt_temp > 0 THEN
				this.SetItem(ll_newrow, "coil_defects",ls_def_temp) 
				this.SetItem(ll_newrow, "scrap_per_defect", ll_wt_temp)
				this.SetItem(ll_newrow,"scrap_pareto", String(100.00 * (1.0 * ll_wt_temp/ll_scrap_wt),"###.##") + "%")
				this.SetItem(ll_newrow, "num_of_pieces", ll_pc_temp)
				ll_newrow = this.InsertRow(0)
			END IF
		NEXT

	END IF
	this.AcceptText()
	lb_exist = FALSE
NEXT

DESTROY lds_t

//title data
String ls_modstring, ls_enduser, ls_alloy, ls_temper, ls_gauge, ls_width, ls_length
String ls_joblist, ls_po, ls_titletemp

ls_enduser = ""
ls_alloy = "" 
ls_temper = "" 
ls_gauge = "" 
ls_width = "" 
ls_length = ""
ls_joblist = "" 
ls_po = "" 
ls_titletemp = ""
FOR ll_i = 1 TO ll_row
	ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "customer_order_orig_customer_po")
	IF ls_po = "" THEN
		ls_po = ls_titletemp
	ELSE 
		IF Pos(ls_po, ls_titletemp) = 0 THEN
			ls_po = ls_po + ", " + ls_titletemp
		END IF
	END IF
	
	ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "customer_customer_short_name_1")
	IF ls_enduser = "" THEN
		ls_enduser = ls_titletemp
	ELSE 
		IF ls_enduser <> "Multiple End Users" THEN
			IF Pos(ls_enduser, ls_titletemp) = 0 THEN
				ls_enduser = "Multiple End Users"
			END IF
		END IF
	END IF
	
	ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "coil_coil_alloy2")
	IF ls_alloy = "" THEN
		ls_alloy = ls_titletemp
	ELSE 
		IF ls_alloy <> "Various" THEN
			IF Pos(ls_alloy, ls_titletemp) = 0 THEN
				ls_alloy = "Various"
			END IF
		END IF
	END IF
	
	ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "coil_coil_temper")
	IF ls_temper = "" THEN
		ls_temper = ls_titletemp
	ELSE 
		IF ls_temper <> "Various" THEN
			IF Pos(ls_temper, ls_titletemp) = 0 THEN
				ls_temper = "Various"
			END IF
		END IF
	END IF
	
	ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "coil_coil_gauge"))
	IF ls_gauge = "" THEN
		ls_gauge = ls_titletemp
	ELSE 
		IF ls_gauge <> "Various" THEN
			IF Pos(ls_gauge, ls_titletemp) = 0 THEN
				ls_gauge = "Various"
			END IF
		END IF
	END IF
	
	ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "width"))
	IF ls_width = "" THEN
		ls_width = ls_titletemp
	ELSE 
		IF ls_width <> "Various" THEN
			IF Pos(ls_width, ls_titletemp) = 0 THEN
				ls_width = "Various"
			END IF
		END IF
	END IF
	
	ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "length"))
	IF ls_length = "" THEN
		ls_length = ls_titletemp
	ELSE 
		IF ls_length <> "Various" THEN
			IF Pos(ls_length, ls_titletemp) = 0 THEN
				ls_length = "Various"
			END IF
		END IF
	END IF
	
	ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num"))
	IF ls_joblist = "" THEN
		ls_joblist = ls_titletemp
	ELSE 
		IF Pos(ls_joblist, ls_titletemp) = 0 THEN
			ls_joblist = ls_joblist + ", " + ls_titletemp
		END IF
	END IF
NEXT

ls_modstring = "t_enduser.Text = ~"" + ls_enduser + "~""
this.Modify(ls_modstring) 

ls_modstring = "t_alloy.Text = ~"" + ls_alloy + "~""
this.Modify(ls_modstring) 

ls_modstring = "t_temper.Text = ~"" + ls_temper + "~""
this.Modify(ls_modstring) 

ls_modstring = "t_gauge.Text = ~"" + ls_gauge + "~""
this.Modify(ls_modstring) 

ls_modstring = "t_width.Text = ~"" + ls_width + "~""
this.Modify(ls_modstring) 

ls_modstring = "t_length.Text = ~"" + ls_length + "~""
this.Modify(ls_modstring) 

ls_modstring = "t_job.Text = ~"" + ls_joblist + "~""
this.Modify(ls_modstring) 

ls_modstring = "t_po.Text = ~"" + ls_po + "~""
this.Modify(ls_modstring) 

RETURN 1
end event

event type long ue_daily_report_constellium();Long ll_row, ll_i, ll_newrow, ll_j, ll_k, ll_drow, ll_erow, ll_d, ll_e, ll_z
Long ll_coil, ll_job, ll_coil_wt, ll_ship_wt, ll_scrap_wt, ll_rej_wt, ll_def_wt
String ls_coil, ls_yield, ls_defs, ls_pareto, ls_def_temp
Boolean lb_exist
DataStore lds_t, lds_m
Long ll_wt_temp, ll_pc_temp, ll_code_temp
String ls_modstring, ls_enduser, ls_alloy, ls_temper, ls_gauge, ls_width, ls_length
String ls_joblist, ls_po, ls_titletemp

ll_row = tab_rec.tabpage_data.dw_main.RowCount()
IF ll_row <= 0 THEN RETURN 0

lds_t = CREATE datastore  
lds_t.DataObject = "d_recovery_customer_defect_worksheet"  
lds_t.SetTransObject (SQLCA) 

lb_exist = FALSE
FOR ll_i = 1 TO ll_row
	ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "coil_coil_abc_num")
	ls_coil = tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "coil_coil_org_num")
	ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
	
	IF this.RowCount() > 0 THEN
		FOR ll_j = 1 TO this.RowCount()
			IF ls_coil = this.GetItemString(ll_j, "col_coil") THEN
				lb_exist = TRUE
			END IF
		NEXT
	END IF
	
	IF NOT(lb_exist) THEN
		ll_newrow = this.InsertRow(0)
		this.SetItem(ll_newrow, "col_coil", ls_coil)
		this.SetItem(ll_newrow, "col_lot", tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "coil_lot_num"))
		ll_coil_wt = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
		this.SetItem(ll_newrow, "col_netwt", String(ll_coil_wt))
		
		ll_ship_wt = 0
		FOR ll_k = 1 TO ll_row
			IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "coil_coil_abc_num") THEN
				ll_ship_wt = ll_ship_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "ship_wt")
			END IF
		NEXT
		this.SetItem(ll_newrow, "col_shipwt", String(ll_ship_wt))
		
		this.SetItem(ll_newrow, "col_rec", String(100.00 * (1.00* ll_ship_wt/ll_coil_wt),"###.#") + "%")		

      //title data
		
		ls_enduser = ""
		ls_alloy = "" 
		ls_temper = "" 
		ls_gauge = "" 
		ls_width = "" 
		ls_length = ""
		ls_joblist = "" 
		ls_po = "" 
		ls_titletemp = ""
		FOR ll_z = 1 TO ll_row
			IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_z, "coil_coil_abc_num") THEN
			
				ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_z, "customer_order_orig_customer_po")
				IF ls_po = "" THEN
					ls_po = ls_titletemp
				ELSE 
					IF Pos(ls_po, ls_titletemp) = 0 THEN
						ls_po = ls_po + ", " + ls_titletemp
					END IF
				END IF
			
				ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_z, "customer_customer_short_name_1")
				IF ls_enduser = "" THEN
					ls_enduser = ls_titletemp
				ELSE 
					IF ls_enduser <> "Multiple End Users" THEN
						IF Pos(ls_enduser, ls_titletemp) = 0 THEN
							ls_enduser = "Multiple End Users"
						END IF
					END IF
				END IF
			
				ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_z, "coil_coil_alloy2")
				IF ls_alloy = "" THEN
					ls_alloy = ls_titletemp
				ELSE 
					IF ls_alloy <> "Various" THEN
						IF Pos(ls_alloy, ls_titletemp) = 0 THEN
							ls_alloy = "Various"
						END IF
					END IF
				END IF
			
				ls_titletemp = tab_rec.tabpage_data.dw_main.GetItemString(ll_z, "coil_coil_temper")
				IF ls_temper = "" THEN
					ls_temper = ls_titletemp
				ELSE 
					IF ls_temper <> "Various" THEN
						IF Pos(ls_temper, ls_titletemp) = 0 THEN
							ls_temper = "Various"
						END IF
					END IF
				END IF
			
				ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_z, "coil_coil_gauge"))
				IF ls_gauge = "" THEN
					ls_gauge = ls_titletemp
				ELSE 
					IF ls_gauge <> "Various" THEN
						IF Pos(ls_gauge, ls_titletemp) = 0 THEN
							ls_gauge = "Various"
						END IF
					END IF
				END IF
			
				ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_z, "width"))
				IF ls_width = "" THEN
					ls_width = ls_titletemp
				ELSE 
					IF ls_width <> "Various" THEN
						IF Pos(ls_width, ls_titletemp) = 0 THEN
							ls_width = "Various"
						END IF
					END IF
				END IF
			
				ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_z, "length"))
				IF ls_length = "" THEN
					ls_length = ls_titletemp
				ELSE 
					IF ls_length <> "Various" THEN
						IF Pos(ls_length, ls_titletemp) = 0 THEN
							ls_length = "Various"
						END IF
					END IF
				END IF
			
				ls_titletemp = String(tab_rec.tabpage_data.dw_main.GetItemNumber(ll_z, "ab_job_ab_job_num"))
				IF ls_joblist = "" THEN
					ls_joblist = ls_titletemp
				ELSE 
					IF Pos(ls_joblist, ls_titletemp) = 0 THEN
						ls_joblist = ls_joblist + ", " + ls_titletemp
					END IF
				END IF
			END IF
		NEXT
		
		this.SetItem(ll_newrow, "col_enduser", ls_enduser)
		this.SetItem(ll_newrow, "col_alloy", ls_alloy)
		this.SetItem(ll_newrow, "col_gauge", ls_gauge)
		this.SetItem(ll_newrow, "col_width", ls_width)
		this.SetItem(ll_newrow, "col_job", ls_joblist)
		this.SetItem(ll_newrow, "col_po", ls_po)
		//end of title data
		
		lds_t.Reset()
		lds_t.Retrieve(il_cust)
		FOR ll_k = 1 TO ll_row
			ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "ab_job_ab_job_num")
			IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_k, "coil_coil_abc_num") THEN
					lds_m = CREATE DataStore
					lds_m.DataObject = "d_existing_coil_job_defects_office"  
					lds_m.SetTransObject(SQLCA)  
					lds_m.Retrieve(ll_job, ll_coil)
					ll_drow = lds_m.RowCount()
					IF ll_drow > 0 THEN
						ll_erow = lds_t.RowCount()
						FOR ll_d = 1 TO ll_drow
							FOR ll_e = 1 to ll_erow
								IF lds_t.GetItemString(ll_e, "scrap_type_scrap_code") = lds_m.GetItemString(ll_d, "scrap_type_scrap_code") THEN
									ll_wt_temp = lds_t.GetItemNumber(ll_e, "TOTAL_WT")
									IF isNULL(ll_wt_temp) THEN ll_wt_temp = 0
									ll_wt_temp = ll_wt_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_net_wt")
				  				 	lds_t.SetItem(ll_e,"TOTAL_WT", ll_wt_temp)
										
									ll_pc_temp = lds_t.GetItemNumber(ll_e, "TOTAL_PC")
									IF isNULL(ll_pc_temp) THEN ll_pc_temp = 0
									ll_pc_temp = ll_pc_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_piece")
									lds_t.SetItem(ll_e,"TOTAL_PC", ll_pc_temp)
									
									lds_t.AcceptText()
								END IF
							NEXT
						NEXT
					END IF
					
					DESTROY lds_m
			END IF
		NEXT
		
		lds_t.AcceptText()
		ll_erow = lds_t.RowCount()
		FOR ll_e = 1 TO ll_erow
			ls_def_temp = lds_t.GetItemString(ll_e, "scrap_type_scrap_defect")
			ll_wt_temp = lds_t.GetItemNumber(ll_e, "TOTAL_WT")
			ll_pc_temp = lds_t.GetItemNumber(ll_e, "TOTAL_PC")
			ll_code_temp = lds_t.GetItemNumber(ll_e, "cust_scrap_type_needed_scrap_type_id")
			IF ll_wt_temp > 0 THEN
				this.SetItem(ll_newrow, "def_" + String(ll_code_temp), String(ll_wt_temp))
			END IF
		NEXT

	END IF
	this.AcceptText()
	lb_exist = FALSE
NEXT

DESTROY lds_t

ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 0 TO 50
		ll_wt_temp = 0
		lb_exist = FALSE
		FOR ll_j = 1 TO ll_row
			Long(this.GetItemString(ll_j, "def_"+String(ll_i)))
			IF Long(this.GetItemString(ll_j, "def_"+String(ll_i))) > 0 THEN
				lb_exist = TRUE
			END IF
		NEXT
		IF NOT(lb_exist) THEN
			ls_modstring = "def_"+ String(ll_i) + ".Width = 0"  
			tab_rec.tabpage_report.dw_report.Modify(ls_modstring) 
		END IF
	NEXT
END IF

RETURN 1
end event

event type long ue_report_scrapdefectdetails_main();Long ll_row, ll_i, ll_newrow, ll_drow, ll_d, ll_erow, ll_e, ll_j
Long ll_wt_temp, ll_pc_temp, ll_code_temp, ll_coil_total, ll_scrap_total, ll_abc_total, ll_mill_total
Long ll_job, ll_coil
String ls_def_temp 
Boolean lb_exist
DataStore lds_t, lds_m

ll_row = tab_rec.tabpage_data.dw_main.RowCount()
IF ll_row <= 0 THEN RETURN 0

ll_newrow = this.InsertRow(0)

lds_t = CREATE datastore  
lds_t.DataObject = "d_recovery_customer_defect_worksheet"  
lds_t.SetTransObject (SQLCA) 
lds_t.Retrieve(il_cust)
ll_erow = lds_t.RowCount()

lds_m = CREATE DataStore
lds_m.DataObject = "d_existing_coil_job_defects_office"  
lds_m.SetTransObject(SQLCA)  

ll_coil_total = 0
ll_scrap_total = 0

FOR ll_i = 1 TO ll_row
	IF Month(date(tab_rec.tabpage_data.dw_main.GetItemDateTime(ll_i, "ab_job_job_done_time")) ) = 2 THEN
		ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
		ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "coil_coil_abc_num")
					lds_m.Retrieve(ll_job, ll_coil)
					ll_drow = lds_m.RowCount()
					IF ll_drow > 0 THEN
						FOR ll_d = 1 TO ll_drow
							FOR ll_e = 1 to ll_erow
								IF lds_t.GetItemString(ll_e, "scrap_type_scrap_code") = lds_m.GetItemString(ll_d, "scrap_type_scrap_code") THEN
									ll_wt_temp = lds_t.GetItemNumber(ll_e, "TOTAL_WT")
									IF isNULL(ll_wt_temp) THEN ll_wt_temp = 0
									ll_wt_temp = ll_wt_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_net_wt")
				  				 	lds_t.SetItem(ll_e,"TOTAL_WT", ll_wt_temp)
										
									ll_pc_temp = lds_t.GetItemNumber(ll_e, "TOTAL_PC")
									IF isNULL(ll_pc_temp) THEN ll_pc_temp = 0
									ll_pc_temp = ll_pc_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_piece")
									lds_t.SetItem(ll_e,"TOTAL_PC", ll_pc_temp)
									
									lds_t.AcceptText()
								END IF
							NEXT
						NEXT
					END IF
		
		IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"scrap_wt") > 0 THEN 
			ll_scrap_total = ll_scrap_total + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"scrap_wt")
		END IF
		
		IF ll_i = 1 THEN
			ll_coil_total = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
		END IF
		
		IF ll_i > 1 THEN
			lb_exist = FALSE
			FOR ll_j = 1 TO (ll_i - 1)
				IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_j, "coil_coil_abc_num") THEN
					lb_exist = TRUE
				END IF
			NEXT
			IF NOT(lb_exist) THEN
				ll_coil_total = ll_coil_total + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
			END IF
		END IF
	END IF
NEXT
DESTROY lds_m

		lds_t.AcceptText()
		ll_row = lds_t.RowCount()
		ll_abc_total = 0
		ll_mill_total = 0
		FOR ll_i = 1 TO ll_row
			ls_def_temp = lds_t.GetItemString(ll_i, "scrap_type_scrap_defect")
			ll_wt_temp = lds_t.GetItemNumber(ll_i, "TOTAL_WT")
			ll_pc_temp = lds_t.GetItemNumber(ll_i, "TOTAL_PC")
			ll_code_temp = lds_t.GetItemNumber(ll_i, "cust_scrap_type_needed_scrap_type_id")
			IF ll_wt_temp > 0 THEN
				this.SetItem(ll_newrow, "total_2_" + String(ll_code_temp), ll_wt_temp)
			END IF
			IF lds_t.GetItemString(ll_i, "cust_scrap_type_needed_abc_or_mill") = "abc" THEN
				ll_abc_total = ll_abc_total + ll_wt_temp
			ELSE
				ll_mill_total = ll_mill_total + ll_wt_temp
			END IF
		NEXT
		this.SetItem(ll_newrow, "total_2_abc_scrap", ll_abc_total)
		this.SetItem(ll_newrow, "total_2_mill_scrap", ll_mill_total)
		
DESTROY lds_t

this.SetItem(ll_newrow, "total_2_coil", ll_coil_total)
this.SetItem(ll_newrow, "total_2_scrap", ll_scrap_total)


RETURN 1
end event

event type long ue_report_recovery_yearly_summary();Long ll_row, ll_i, ll_newrow, ll_drow, ll_d, ll_erow, ll_e, ll_j
Long ll_wt_temp, ll_pc_temp, ll_code_temp, ll_coil_total, ll_scrap_total, ll_abc_total, ll_mill_total
Long ll_coil_num, ll_ship_wt
Long ll_att_num, ll_att_wt, ll_handle_num, ll_handle_wt, ll_rej_num, ll_rej_wt, ll_reband_num, ll_reband_wt
Long ll_job, ll_coil
String ls_def_temp 
Boolean lb_exist
DataStore lds_t, lds_m

ll_row = tab_rec.tabpage_data.dw_main.RowCount()
IF ll_row <= 0 THEN RETURN 0

ll_newrow = this.InsertRow(0)

lds_t = CREATE datastore  
lds_t.DataObject = "d_recovery_customer_defect_worksheet"  
lds_t.SetTransObject (SQLCA) 
lds_t.Retrieve(il_cust)
ll_erow = lds_t.RowCount()

lds_m = CREATE DataStore
lds_m.DataObject = "d_existing_coil_job_defects_office"  
lds_m.SetTransObject(SQLCA)  

ll_coil_total = 0
ll_scrap_total = 0
ll_att_num = 0
ll_att_wt = 0
ll_handle_num = 0
ll_handle_wt = 0
ll_rej_num = 0
ll_rej_wt = 0
ll_reband_num = 0
ll_reband_wt = 0

FOR ll_i = 1 TO ll_row
	IF Month(date(tab_rec.tabpage_data.dw_main.GetItemDateTime(ll_i, "ab_job_job_done_time")) ) = 2 THEN
		ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
		ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "coil_coil_abc_num")
					lds_m.Retrieve(ll_job, ll_coil)
					ll_drow = lds_m.RowCount()
					IF ll_drow > 0 THEN
						FOR ll_d = 1 TO ll_drow
							FOR ll_e = 1 to ll_erow
								IF lds_t.GetItemString(ll_e, "scrap_type_scrap_code") = lds_m.GetItemString(ll_d, "scrap_type_scrap_code") THEN
									ll_wt_temp = lds_t.GetItemNumber(ll_e, "TOTAL_WT")
									IF isNULL(ll_wt_temp) THEN ll_wt_temp = 0
									ll_wt_temp = ll_wt_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_net_wt")
				  				 	lds_t.SetItem(ll_e,"TOTAL_WT", ll_wt_temp)
										
									ll_pc_temp = lds_t.GetItemNumber(ll_e, "TOTAL_PC")
									IF isNULL(ll_pc_temp) THEN ll_pc_temp = 0
									ll_pc_temp = ll_pc_temp + lds_m.GetItemNumber(ll_d, "recovery_scrap_worksheet_scrap_item_piece")
									lds_t.SetItem(ll_e,"TOTAL_PC", ll_pc_temp)
									
									lds_t.AcceptText()
								END IF
							NEXT
						NEXT
					END IF
		
		IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"scrap_wt") > 0 THEN 
			ll_scrap_total = ll_scrap_total + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"scrap_wt")
		END IF
		IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"ship_wt") > 0 THEN 
			ll_ship_wt = ll_ship_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"ship_wt")
		END IF
		
			IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"recovery_job_coil_special_attention") = 1 THEN
				ll_att_num = ll_att_num + 1
				ll_att_wt = ll_att_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
			END IF
			IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"recovery_job_coil_special_handling") = 1 THEN
				ll_handle_num = ll_handle_wt + 1
				ll_handle_wt = ll_handle_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
			END IF
			IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"recovery_job_coil_coil_rejected") = 1 THEN
				ll_rej_num = ll_rej_num + 1
				ll_rej_wt = ll_rej_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"rejected_wt")
			END IF
			IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"recovery_job_coil_coil_rebanded") = 1 THEN
				ll_reband_num = ll_reband_num + 1
				ll_reband_wt = ll_reband_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt_balance")
			END IF	
			
		IF ll_i = 1 THEN
			ll_coil_total = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
			ll_coil_num = 1
		END IF
		
		IF ll_i > 1 THEN
			lb_exist = FALSE
			FOR ll_j = 1 TO (ll_i - 1)
				IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_j, "coil_coil_abc_num") THEN
					lb_exist = TRUE
				END IF
			NEXT
			IF NOT(lb_exist) THEN
				ll_coil_total = ll_coil_total + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
				ll_coil_num = ll_coil_num + 1
			END IF
		END IF
	END IF
NEXT
DESTROY lds_m

		lds_t.AcceptText()
		ll_row = lds_t.RowCount()
		ll_abc_total = 0
		ll_mill_total = 0
		FOR ll_i = 1 TO ll_row
			ls_def_temp = lds_t.GetItemString(ll_i, "scrap_type_scrap_defect")
			ll_wt_temp = lds_t.GetItemNumber(ll_i, "TOTAL_WT")
			ll_pc_temp = lds_t.GetItemNumber(ll_i, "TOTAL_PC")
			ll_code_temp = lds_t.GetItemNumber(ll_i, "cust_scrap_type_needed_scrap_type_id")
			IF lds_t.GetItemString(ll_i, "cust_scrap_type_needed_abc_or_mill") = "abc" THEN
				ll_abc_total = ll_abc_total + ll_wt_temp
			ELSE
				ll_mill_total = ll_mill_total + ll_wt_temp
			END IF
		NEXT
		this.SetItem(ll_newrow, "total_2_abc_scrap", ll_abc_total)
		this.SetItem(ll_newrow, "total_2_mill_scrap", ll_mill_total)
		
DESTROY lds_t

this.SetItem(ll_newrow, "total_2_coil", ll_coil_total)
this.SetItem(ll_newrow, "total_2_scrap", ll_scrap_total)
this.SetItem(ll_newrow, "total_2_coil_num", ll_coil_num)
this.SetItem(ll_newrow, "total_2_ship", ll_ship_wt)
this.SetItem(ll_newrow, "total_2_attention", ll_att_num)
this.SetItem(ll_newrow, "total_2_attentionwt", ll_att_wt)
this.SetItem(ll_newrow, "total_2_handle", ll_handle_num)
this.SetItem(ll_newrow, "total_2_handlewt", ll_handle_wt)
this.SetItem(ll_newrow, "total_2_reject", ll_rej_num)
this.SetItem(ll_newrow, "total_2_rejectwt", ll_rej_wt)
this.SetItem(ll_newrow, "total_2_reband", ll_reband_num)
this.SetItem(ll_newrow, "total_2_rebandwt", ll_reband_wt)


RETURN 1
end event

event type long ue_report_recovery_rej_coil_yearly();Long ll_row, ll_i, ll_newrow, ll_y
Long ll_rej_num, ll_rej_wt
Long ll_job, ll_coil
String ls_modstring 

ll_row = tab_rec.tabpage_data.dw_main.RowCount()
IF ll_row <= 0 THEN RETURN 0

ll_newrow = this.InsertRow(0)

FOR ll_y = 1 TO 12 
	ll_rej_num = 0
	ll_rej_wt = 0
	FOR ll_i = 1 TO ll_row
		IF Month(date(tab_rec.tabpage_data.dw_main.GetItemDateTime(ll_i, "ab_job_job_done_time")) ) = ll_y THEN
			ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
			ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "coil_coil_abc_num")
			IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"recovery_job_coil_coil_rejected") = 1 THEN
				ll_rej_num = ll_rej_num + 1
				ll_rej_wt = ll_rej_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"rejected_wt")
			END IF
		END IF
 	NEXT

	this.SetItem(ll_newrow, "total_"+String(ll_y)+"_coil", ll_rej_num)
	this.SetItem(ll_newrow, "total_"+String(ll_y)+"_wt", ll_rej_wt)
	
	ls_modstring = "t_" + String(ll_y)+"_pc.Text = ~"" + String(ll_rej_num) + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "t_" + String(ll_y)+"_wt.Text = ~"" + String(ll_rej_wt) + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "t_" + String(ll_y)+"_wt.Y = ~"" + String(2381 - (ll_rej_wt/10000 * 180)) + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "l_" + String(ll_y)+"_wt.Y1 = ~"" + String(2381 - (ll_rej_wt/10000 * 180)) + "~""
	dw_report.Modify(ls_modstring) 

NEXT

RETURN 1
end event

event type long ue_report_recovery_product_type_summary();Long ll_row, ll_i, ll_drow, ll_d, ll_newrow
Long ll_shipwt, ll_shipwt_temp, ll_processwt, ll_processwt_temp
String ls_p_type
Boolean lb_exist
DataStore lds_t
String ls_modstring

ll_row = tab_rec.tabpage_data.dw_main.RowCount()
IF ll_row <= 0 THEN RETURN 0

lds_t = CREATE datastore  
lds_t.DataObject = "d_recovery_product_type_worksheet"  
lds_t.SetTransObject (SQLCA) 


FOR ll_i = 1 TO ll_row
		ll_shipwt = 0
		ll_shipwt_temp = 0
		ll_processwt = 0
		ll_processwt_temp = 0
		lb_exist = FALSE
		
		ls_p_type = tab_rec.tabpage_data.dw_main.GetItemString(ll_i, "product_type_product_type")
		ll_shipwt_temp = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ship_wt")
		IF isNULL(ll_shipwt_temp) THEN ll_shipwt_temp = 0
		ll_processwt_temp = tab_rec.tabpage_data.dw_main.GetItemNUmber(ll_i, "coil_net_wt")
		IF isNULL(ll_processwt_temp) THEN ll_processwt_temp = 0

		
					ll_drow = lds_t.RowCount()
					IF ll_drow > 0 THEN
							FOR ll_d = 1 TO ll_drow
								IF lds_t.GetItemString(ll_d, "product_type") = ls_p_type THEN
									ll_shipwt_temp = ll_shipwt_temp + lds_t.GetItemNumber(ll_d, "ship_wt")
				  				 	lds_t.SetItem(ll_d,"ship_wt", ll_shipwt_temp)
										
									ll_processwt_temp = ll_processwt_temp + lds_t.GetItemNumber(ll_d, "process_wt")
									lds_t.SetItem(ll_d,"process_wt", ll_processwt_temp)
									
									lds_t.AcceptText()
									lb_exist = TRUE
								END IF
							NEXT
						END IF
		
		IF NOT(lb_exist) OR ll_drow = 0 THEN
			ll_newrow = lds_t.InsertRow(0)
			lds_t.SetItem(ll_newrow,"ship_wt", ll_shipwt_temp)
			lds_t.SetItem(ll_newrow,"process_wt", ll_processwt_temp)
			lds_t.SetItem(ll_newrow,"product_type", ls_p_type)
			lds_t.AcceptText()			
		END IF
NEXT

lds_t.AcceptText()
ll_row = lds_t.RowCount()
//		FOR ll_i = 1 TO ll_row
//			ls_p_type = lds_t.GetItemString(ll_i, "product_type")
//			ll_shipwt_temp = lds_t.GetItemNumber(ll_i, "ship_wt")
//			ll_processwt_temp = lds_t.GetItemNumber(ll_i, "process_wt")
//			ll_newrow = this.InsertRow(0)
//			this.SetItem(ll_newrow,"ship_wt", ll_shipwt_temp)
//			this.SetItem(ll_newrow,"processed_wt", ll_processwt_temp)
//			this.SetItem(ll_newrow,"product_type", ls_p_type)
//		NEXT
ll_newrow = this.InsertRow(0)
FOR ll_i = 1 TO 13
	ls_modstring = "r_" + String(ll_i)+".Width = ~"0~""
	this.Modify(ls_modstring) 
NEXT

ll_shipwt = 0
ll_processwt = 0
FOR ll_i = 1 TO ll_row
			ls_p_type = lds_t.GetItemString(ll_i, "product_type")
			ll_shipwt_temp = lds_t.GetItemNumber(ll_i, "ship_wt")
			ll_shipwt = ll_shipwt + ll_shipwt_temp
			ll_processwt_temp = lds_t.GetItemNumber(ll_i, "process_wt")
			ll_processwt =ll_processwt + ll_processwt_temp
			IF ll_processwt_temp > 0 THEN
				this.SetItem(ll_newrow,"recovery_"+String(ll_i), String((100.00 * ll_shipwt_temp/ll_processwt_temp), "###.##")+"%")
				this.SetItem(ll_newrow,"value_"+String(ll_i), ll_processwt_temp)
				ls_modstring = "t_" + String(ll_i)+".Text = ~"" + ls_p_type + "~""
				this.Modify(ls_modstring) 
				ls_modstring = "r_" + String(ll_i)+".Width = ~"" + String(100 * ll_processwt_temp / 10000) + "~""
				this.Modify(ls_modstring) 
			END IF
NEXT
this.SetItem(ll_newrow,"process_total", ll_processwt)
this.SetItem(ll_newrow,"ship_total", ll_shipwt)

DESTROY lds_t


RETURN 1
end event

event type long ue_report_recovery_historical_data();Long ll_row, ll_i, ll_newrow, ll_j
Long ll_wt_temp, ll_pc_temp, ll_code_temp, ll_coil_total, ll_scrap_total
Long ll_coil_num, ll_ship_wt
Long ll_job, ll_coil
Boolean lb_exist
String ls_modstring

ll_row = tab_rec.tabpage_data.dw_main.RowCount()
IF ll_row <= 0 THEN RETURN 0

ll_newrow = this.InsertRow(0)

ll_coil_total = 0
ll_scrap_total = 0

FOR ll_i = 1 TO ll_row
	IF Month(date(tab_rec.tabpage_data.dw_main.GetItemDateTime(ll_i, "ab_job_job_done_time")) ) = 2 THEN
		ll_job = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "ab_job_ab_job_num")
		ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i, "coil_coil_abc_num")
		
		IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"scrap_wt") > 0 THEN 
			ll_scrap_total = ll_scrap_total + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"scrap_wt")
		END IF
		IF tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"ship_wt") > 0 THEN 
			ll_ship_wt = ll_ship_wt + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"ship_wt")
		END IF
		

		IF ll_i = 1 THEN
			ll_coil_total = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
			ll_coil_num = 1
		END IF
		
		IF ll_i > 1 THEN
			lb_exist = FALSE
			FOR ll_j = 1 TO (ll_i - 1)
				IF ll_coil = tab_rec.tabpage_data.dw_main.GetItemNumber(ll_j, "coil_coil_abc_num") THEN
					lb_exist = TRUE
				END IF
			NEXT
			IF NOT(lb_exist) THEN
				ll_coil_total = ll_coil_total + tab_rec.tabpage_data.dw_main.GetItemNumber(ll_i,"coil_net_wt")
				ll_coil_num = ll_coil_num + 1
			END IF
		END IF
	END IF
NEXT

	ls_modstring = "t_2_wt.Text = ~"" + String(ll_coil_total, "###,###,###") + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "t_2_wt.Height = ~"" + String(ll_coil_total/250000 * 150) + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "t_2_wt.Y = ~"" + String(2250 - ll_coil_total/250000 * 150) + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "t_2_rec.Text = ~"" + String(100.00*ll_ship_wt/ll_coil_total, "###.##")+ "%" + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "t_2_rec.Y = ~"" + String(((100.00 - (100.00 * ll_ship_wt/ll_coil_total)) * 150), "####") + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "l_12.Y2 = ~"" + String(((100.00 - (100.00 * ll_ship_wt/ll_coil_total)) * 150), "####") + "~""
	dw_report.Modify(ls_modstring) 
	ls_modstring = "l_23.Y1 = ~"" + String(((100.00 - (100.00 * ll_ship_wt/ll_coil_total)) * 150), "####") + "~""
	dw_report.Modify(ls_modstring) 


RETURN 1
end event

event itemchanged;call super::itemchanged;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)
SetTransObject(SQLCA)

end event

type tabpage_file from u_tabpg_fileview_recovery within tab_rec
integer x = 15
integer y = 90
integer width = 4392
integer height = 1635
string text = "Archive folder"
end type

type gb_1 from groupbox within w_recovery
integer x = 7
integer width = 1247
integer height = 208
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 1. Select a customer"
end type

type gb_3 from groupbox within w_recovery
integer x = 1269
integer width = 2761
integer height = 208
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step 2. Select job DONE date range or pick any coils"
end type

