$PBExportHeader$w_edit_quote.srw
$PBExportComments$<Child> Open an exist quote and edit it
forward
global type w_edit_quote from w_child
end type
type tab_q from tab within w_edit_quote
end type
type tabpage_quote from userobject within tab_q
end type
type dw_quote from u_dw within tabpage_quote
end type
type tabpage_quote from userobject within tab_q
dw_quote dw_quote
end type
type tabpage_review from userobject within tab_q
end type
type dw_history from u_dw within tabpage_review
end type
type st_10 from statictext within tabpage_review
end type
type st_2 from statictext within tabpage_review
end type
type mle_1 from u_mle within tabpage_review
end type
type htb_1 from u_htb within tabpage_review
end type
type st_1 from statictext within tabpage_review
end type
type gb_1 from groupbox within tabpage_review
end type
type gb_today from groupbox within tabpage_review
end type
type tabpage_review from userobject within tab_q
dw_history dw_history
st_10 st_10
st_2 st_2
mle_1 mle_1
htb_1 htb_1
st_1 st_1
gb_1 gb_1
gb_today gb_today
end type
type tabpage_reminder from userobject within tab_q
end type
type pb_12 from u_pb within tabpage_reminder
end type
type pb_11 from u_pb within tabpage_reminder
end type
type pb_10 from u_pb within tabpage_reminder
end type
type cb_save from u_cb within tabpage_reminder
end type
type dw_schedule from u_dw within tabpage_reminder
end type
type uo_calendar_1 from u_calendar within tabpage_reminder
end type
type em_calendar from u_em within tabpage_reminder
end type
type mle_2 from u_mle within tabpage_reminder
end type
type pb_1 from u_pb within tabpage_reminder
end type
type gb_title from groupbox within tabpage_reminder
end type
type gb_6 from groupbox within tabpage_reminder
end type
type tabpage_reminder from userobject within tab_q
pb_12 pb_12
pb_11 pb_11
pb_10 pb_10
cb_save cb_save
dw_schedule dw_schedule
uo_calendar_1 uo_calendar_1
em_calendar em_calendar
mle_2 mle_2
pb_1 pb_1
gb_title gb_title
gb_6 gb_6
end type
type tabpage_order from userobject within tab_q
end type
type dw_order_list from u_dw within tabpage_order
end type
type dw_order from u_dw within tabpage_order
end type
type gb_9 from groupbox within tabpage_order
end type
type gb_10 from groupbox within tabpage_order
end type
type tabpage_order from userobject within tab_q
dw_order_list dw_order_list
dw_order dw_order
gb_9 gb_9
gb_10 gb_10
end type
type tabpage_job from userobject within tab_q
end type
type dw_job_detail from u_dw within tabpage_job
end type
type dw_job_list from u_dw within tabpage_job
end type
type gb_7 from groupbox within tabpage_job
end type
type gb_8 from groupbox within tabpage_job
end type
type tabpage_job from userobject within tab_q
dw_job_detail dw_job_detail
dw_job_list dw_job_list
gb_7 gb_7
gb_8 gb_8
end type
type tabpage_schedule from userobject within tab_q
end type
type dw_job_scheduler from u_dw within tabpage_schedule
end type
type tabpage_schedule from userobject within tab_q
dw_job_scheduler dw_job_scheduler
end type
type tabpage_inventory from userobject within tab_q
end type
type st_47 from statictext within tabpage_inventory
end type
type st_46 from statictext within tabpage_inventory
end type
type st_45 from statictext within tabpage_inventory
end type
type st_30 from statictext within tabpage_inventory
end type
type st_29 from statictext within tabpage_inventory
end type
type st_28 from statictext within tabpage_inventory
end type
type st_27 from statictext within tabpage_inventory
end type
type st_26 from statictext within tabpage_inventory
end type
type st_25 from statictext within tabpage_inventory
end type
type st_24 from statictext within tabpage_inventory
end type
type st_23 from statictext within tabpage_inventory
end type
type st_22 from statictext within tabpage_inventory
end type
type st_21 from statictext within tabpage_inventory
end type
type st_20 from statictext within tabpage_inventory
end type
type pb_i_scrapopen from u_pb within tabpage_inventory
end type
type pb_i_skidopen from u_pb within tabpage_inventory
end type
type pb_i_coilopen from u_pb within tabpage_inventory
end type
type st_44 from statictext within tabpage_inventory
end type
type st_43 from statictext within tabpage_inventory
end type
type st_42 from statictext within tabpage_inventory
end type
type st_41 from statictext within tabpage_inventory
end type
type st_40 from statictext within tabpage_inventory
end type
type st_39 from statictext within tabpage_inventory
end type
type st_38 from statictext within tabpage_inventory
end type
type dw_scrap_list from u_dw within tabpage_inventory
end type
type dw_skid_list from u_dw within tabpage_inventory
end type
type dw_coil_list from u_dw within tabpage_inventory
end type
type gb_i_coil from groupbox within tabpage_inventory
end type
type gb_i_skid from groupbox within tabpage_inventory
end type
type gb_i_scrap from groupbox within tabpage_inventory
end type
type tabpage_inventory from userobject within tab_q
st_47 st_47
st_46 st_46
st_45 st_45
st_30 st_30
st_29 st_29
st_28 st_28
st_27 st_27
st_26 st_26
st_25 st_25
st_24 st_24
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
pb_i_scrapopen pb_i_scrapopen
pb_i_skidopen pb_i_skidopen
pb_i_coilopen pb_i_coilopen
st_44 st_44
st_43 st_43
st_42 st_42
st_41 st_41
st_40 st_40
st_39 st_39
st_38 st_38
dw_scrap_list dw_scrap_list
dw_skid_list dw_skid_list
dw_coil_list dw_coil_list
gb_i_coil gb_i_coil
gb_i_skid gb_i_skid
gb_i_scrap gb_i_scrap
end type
type tabpage_quality from userobject within tab_q
end type
type tabpage_quality from userobject within tab_q
end type
type tabpage_shipment from userobject within tab_q
end type
type pb_17 from u_pb within tabpage_shipment
end type
type pb_16 from u_pb within tabpage_shipment
end type
type pb_15 from u_pb within tabpage_shipment
end type
type st_49 from statictext within tabpage_shipment
end type
type st_48 from statictext within tabpage_shipment
end type
type st_37 from statictext within tabpage_shipment
end type
type st_36 from statictext within tabpage_shipment
end type
type st_35 from statictext within tabpage_shipment
end type
type st_34 from statictext within tabpage_shipment
end type
type st_33 from statictext within tabpage_shipment
end type
type st_32 from statictext within tabpage_shipment
end type
type st_31 from statictext within tabpage_shipment
end type
type st_19 from statictext within tabpage_shipment
end type
type st_18 from statictext within tabpage_shipment
end type
type st_17 from statictext within tabpage_shipment
end type
type st_16 from statictext within tabpage_shipment
end type
type st_15 from statictext within tabpage_shipment
end type
type st_14 from statictext within tabpage_shipment
end type
type st_13 from statictext within tabpage_shipment
end type
type st_12 from statictext within tabpage_shipment
end type
type st_11 from statictext within tabpage_shipment
end type
type pb_14 from u_pb within tabpage_shipment
end type
type dw_shipscrap from u_dw within tabpage_shipment
end type
type pb_13 from u_pb within tabpage_shipment
end type
type dw_shipskid from u_dw within tabpage_shipment
end type
type pb_5 from u_pb within tabpage_shipment
end type
type dw_shipcoil from u_dw within tabpage_shipment
end type
type gb_12 from groupbox within tabpage_shipment
end type
type gb_13 from groupbox within tabpage_shipment
end type
type gb_14 from groupbox within tabpage_shipment
end type
type tabpage_shipment from userobject within tab_q
pb_17 pb_17
pb_16 pb_16
pb_15 pb_15
st_49 st_49
st_48 st_48
st_37 st_37
st_36 st_36
st_35 st_35
st_34 st_34
st_33 st_33
st_32 st_32
st_31 st_31
st_19 st_19
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
pb_14 pb_14
dw_shipscrap dw_shipscrap
pb_13 pb_13
dw_shipskid dw_shipskid
pb_5 pb_5
dw_shipcoil dw_shipcoil
gb_12 gb_12
gb_13 gb_13
gb_14 gb_14
end type
type tab_q from tab within w_edit_quote
tabpage_quote tabpage_quote
tabpage_review tabpage_review
tabpage_reminder tabpage_reminder
tabpage_order tabpage_order
tabpage_job tabpage_job
tabpage_schedule tabpage_schedule
tabpage_inventory tabpage_inventory
tabpage_quality tabpage_quality
tabpage_shipment tabpage_shipment
end type
type st_9 from statictext within w_edit_quote
end type
type pb_9 from u_pb within w_edit_quote
end type
type st_8 from statictext within w_edit_quote
end type
type pb_8 from u_pb within w_edit_quote
end type
type st_7 from statictext within w_edit_quote
end type
type pb_7 from u_pb within w_edit_quote
end type
type st_6 from statictext within w_edit_quote
end type
type pb_6 from u_pb within w_edit_quote
end type
type st_5 from statictext within w_edit_quote
end type
type pb_4 from u_pb within w_edit_quote
end type
type st_4 from statictext within w_edit_quote
end type
type st_3 from statictext within w_edit_quote
end type
type pb_3 from u_pb within w_edit_quote
end type
type pb_2 from u_pb within w_edit_quote
end type
type gb_5 from groupbox within w_edit_quote
end type
type gb_4 from groupbox within w_edit_quote
end type
type gb_2 from groupbox within w_edit_quote
end type
type gb_3 from groupbox within w_edit_quote
end type
end forward

global type w_edit_quote from w_child
integer x = 214
integer width = 4447
integer height = 2128
string title = "Quote Editor"
tab_q tab_q
st_9 st_9
pb_9 pb_9
st_8 st_8
pb_8 pb_8
st_7 st_7
pb_7 pb_7
st_6 st_6
pb_6 pb_6
st_5 st_5
pb_4 pb_4
st_4 st_4
st_3 st_3
pb_3 pb_3
pb_2 pb_2
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
end type
global w_edit_quote w_edit_quote

type variables
s_quote_data ids_q
Date is_date
end variables

on w_edit_quote.create
int iCurrent
call super::create
this.tab_q=create tab_q
this.st_9=create st_9
this.pb_9=create pb_9
this.st_8=create st_8
this.pb_8=create pb_8
this.st_7=create st_7
this.pb_7=create pb_7
this.st_6=create st_6
this.pb_6=create pb_6
this.st_5=create st_5
this.pb_4=create pb_4
this.st_4=create st_4
this.st_3=create st_3
this.pb_3=create pb_3
this.pb_2=create pb_2
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_q
this.Control[iCurrent+2]=this.st_9
this.Control[iCurrent+3]=this.pb_9
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.pb_8
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.pb_7
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.pb_6
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.pb_4
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.pb_3
this.Control[iCurrent+15]=this.pb_2
this.Control[iCurrent+16]=this.gb_5
this.Control[iCurrent+17]=this.gb_4
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_3
end on

on w_edit_quote.destroy
call super::destroy
destroy(this.tab_q)
destroy(this.st_9)
destroy(this.pb_9)
destroy(this.st_8)
destroy(this.pb_8)
destroy(this.st_7)
destroy(this.pb_7)
destroy(this.st_6)
destroy(this.pb_6)
destroy(this.st_5)
destroy(this.pb_4)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;Long ll_line

ids_q = Message.PowerObjectParm
SELECT line_num INTO :ll_line 
FROM sales_quote
WHERE quote_id = :ids_q.quote_id AND quote_revision_id = :ids_q.revision_id
USING SQLCA;

//set up
//order
tab_q.tabpage_order.dw_order_list.of_SetLinkage ( TRUE ) 

tab_q.tabpage_order.dw_order.of_SetLinkage( TRUE ) 
tab_q.tabpage_order.dw_order.inv_Linkage.of_SetMaster( tab_q.tabpage_order.dw_order_list )
IF NOT tab_q.tabpage_order.dw_order.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & order details!" )
ELSE
	tab_q.tabpage_order.dw_order.inv_Linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	tab_q.tabpage_order.dw_order.inv_Linkage.of_SetStyle( 2 ) 
	tab_q.tabpage_order.dw_order.SetRowFocusIndicator(FocusRect!)
END IF
tab_q.tabpage_order.dw_order_list.inv_Linkage.of_SetTransObject(sqlca)

//job
tab_q.tabpage_job.dw_job_list.of_SetLinkage ( TRUE ) 

tab_q.tabpage_job.dw_job_detail.of_SetLinkage( TRUE ) 
tab_q.tabpage_job.dw_job_detail.inv_Linkage.of_SetMaster( tab_q.tabpage_job.dw_job_list )
IF NOT tab_q.tabpage_job.dw_job_detail.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked job & job details!" )
ELSE
	tab_q.tabpage_job.dw_job_detail.inv_Linkage.of_Register( "ab_job_num", "ab_job_num" ) 
	tab_q.tabpage_job.dw_job_detail.inv_Linkage.of_SetStyle( 2 ) 
	tab_q.tabpage_job.dw_job_detail.SetRowFocusIndicator(FocusRect!)
END IF
tab_q.tabpage_job.dw_job_list.inv_Linkage.of_SetTransObject(sqlca)

//retrieve
tab_q.tabpage_quote.dw_quote.Retrieve(ids_q.quote_id, ids_q.revision_id)
tab_q.tabpage_review.dw_history.Retrieve(ids_q.quote_id, ids_q.revision_id)
tab_q.tabpage_reminder.dw_schedule.Retrieve(ids_q.quote_id, ids_q.revision_id)

tab_q.tabpage_order.dw_order_list.inv_linkage.of_Reset()
IF tab_q.tabpage_order.dw_order_list.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_edit_quote: open : order" )
	Return 
ELSE
	SQLCA.of_Commit()
	tab_q.tabpage_order.dw_order_list.SetFocus()
End IF

tab_q.tabpage_job.dw_job_list.inv_linkage.of_Reset()
IF tab_q.tabpage_job.dw_job_list.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_edit_quote: open: job" )
	Return 
ELSE
	SQLCA.of_Commit()
	tab_q.tabpage_job.dw_job_list.SetFocus()
End IF

tab_q.tabpage_schedule.dw_job_scheduler.Retrieve(ll_line)

tab_q.tabpage_inventory.dw_coil_list.Retrieve(ids_q.quote_id, ids_q.revision_id)
tab_q.tabpage_inventory.dw_skid_list.Retrieve(ids_q.quote_id, ids_q.revision_id)
tab_q.tabpage_inventory.dw_scrap_list.Retrieve(ids_q.quote_id, ids_q.revision_id)

tab_q.tabpage_shipment.dw_shipcoil.Retrieve(ids_q.quote_id, ids_q.revision_id)
tab_q.tabpage_shipment.dw_shipskid.Retrieve(ids_q.quote_id, ids_q.revision_id)
tab_q.tabpage_shipment.dw_shipscrap.Retrieve(ids_q.quote_id, ids_q.revision_id)
end event

type tab_q from tab within w_edit_quote
event create ( )
event destroy ( )
integer width = 4407
integer height = 1840
integer taborder = 10
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
tabpage_quote tabpage_quote
tabpage_review tabpage_review
tabpage_reminder tabpage_reminder
tabpage_order tabpage_order
tabpage_job tabpage_job
tabpage_schedule tabpage_schedule
tabpage_inventory tabpage_inventory
tabpage_quality tabpage_quality
tabpage_shipment tabpage_shipment
end type

on tab_q.create
this.tabpage_quote=create tabpage_quote
this.tabpage_review=create tabpage_review
this.tabpage_reminder=create tabpage_reminder
this.tabpage_order=create tabpage_order
this.tabpage_job=create tabpage_job
this.tabpage_schedule=create tabpage_schedule
this.tabpage_inventory=create tabpage_inventory
this.tabpage_quality=create tabpage_quality
this.tabpage_shipment=create tabpage_shipment
this.Control[]={this.tabpage_quote,&
this.tabpage_review,&
this.tabpage_reminder,&
this.tabpage_order,&
this.tabpage_job,&
this.tabpage_schedule,&
this.tabpage_inventory,&
this.tabpage_quality,&
this.tabpage_shipment}
end on

on tab_q.destroy
destroy(this.tabpage_quote)
destroy(this.tabpage_review)
destroy(this.tabpage_reminder)
destroy(this.tabpage_order)
destroy(this.tabpage_job)
destroy(this.tabpage_schedule)
destroy(this.tabpage_inventory)
destroy(this.tabpage_quality)
destroy(this.tabpage_shipment)
end on

type tabpage_quote from userobject within tab_q
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Quote"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Compute!"
long picturemaskcolor = 536870912
dw_quote dw_quote
end type

on tabpage_quote.create
this.dw_quote=create dw_quote
this.Control[]={this.dw_quote}
end on

on tabpage_quote.destroy
destroy(this.dw_quote)
end on

type dw_quote from u_dw within tabpage_quote
integer x = 7
integer y = 10
integer width = 4370
integer height = 1718
integer taborder = 20
string dataobject = "d_sales_quote_modify"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

event itemchanged;call super::itemchanged;String ls_ColName, ls_lsoverride, ls_h24, ls_pvc, ls_intrlv
Long ll_row
Long ll_c15, ll_c16, ll_f44, ll_f45, ll_f46, ll_f47, ll_f48, ll_f49, ll_f50, ll_i18, ll_i19, ll_i9, ll_i31, ll_i10, ll_i16, ll_i34
Real lr_d20, lr_d21, lr_d22, lr_d23, lr_d24, lr_d25, lr_d26, lr_d31, lr_d32, lr_d33, lr_d34, lr_d35, lr_d36, lr_d38
Real lr_c12, lr_c13, lr_c14, lr_c17, lr_i32
Real lr_g44, lr_g45, lr_g46, lr_g47, lr_g48, lr_g49, lr_g50
Real lr_ros

ls_ColName = this.GetColumnName()

//do nothing
IF ls_ColName = "customer_customer_short_name" OR ls_ColName = "sales_quote_end_use" OR ls_ColName = "sales_quote_alloy" OR ls_ColName = "sales_quote_temper" OR  ls_ColName = "sales_quote_part_shape" THEN
	RETURN 0
END IF


//Start here
this.AcceptText()
ll_row = this.GetRow()

ll_c15 = this.GetItemNumber(ll_row,"sales_quote_total_lb_processed", Primary!, FALSE)
IF ll_c15 = 0 OR isNULL(ll_c15) THEN RETURN 0

ll_c16 = this.GetItemNumber(ll_row,"sales_quote_num_of_coil", Primary!, FALSE)
ll_i19 = this.GetItemNumber(ll_row,"sales_quote_line_num", Primary!, FALSE)
ll_i9 = this.GetItemNumber(ll_row,"sales_quote_skid_wt", Primary!, FALSE)

	IF ll_i9 > 0 THEN
			ll_i10 =  Ceiling(ll_c15/ll_i9)
			this.SetItem(ll_row,"sales_quote_num_of_skid", ll_i10 )
	END IF
	
	AcceptText()
	
ls_lsoverride = this.GetItemString(ll_row,"sales_quote_line_speed_override", Primary!, FALSE)
ll_i31 = Long(this.GetItemString(ll_row,"sales_quote_line_speed", Primary!, FALSE))

	SELECT Sales_rules_pkg.Line_speed(:ls_lsoverride, :ll_i31, :ll_i9) INTO :ll_i31
	FROM Dual
	USING SQLCA;
	this.SetItem(ll_row,"sales_quote_line_speed", String(ll_i31))
	
	AcceptText()

lr_c12 = this.GetItemNumber(ll_row,"sales_quote_gauge", Primary!, FALSE)
lr_c13 = this.GetItemNumber(ll_row,"sales_quote_width", Primary!, FALSE)
lr_c14 = this.GetItemNumber(ll_row,"sales_quote_length", Primary!, FALSE)
ls_h24 = this.GetItemString(ll_row,"sales_quote_material", Primary!, FALSE)

	SELECT Sales_rules_pkg.part_wt(:ls_h24, :lr_c12, :lr_c14, :lr_c13) INTO :lr_c17
	FROM Dual
	USING SQLCA;
	this.SetItem(ll_row,"sales_quote_part_wt", lr_c17)

	SELECT Sales_rules_pkg.SPM(:ll_i31, :lr_c14) INTO :lr_i32
	FROM Dual
	USING SQLCA;
	this.SetItem(ll_row,"sales_quote_spm", lr_i32)

	AcceptText()

lr_d20 = this.GetItemNumber(ll_row,"sales_quote_reg_process_charge", Primary!, FALSE)
IF isNULL(lr_d20) THEN lr_d20 = 0.00
lr_d21 = this.GetItemNumber(ll_row,"sales_quote_skid_wt_charge", Primary!, FALSE)
IF isNULL(lr_d21) THEN lr_d21 = 0.00
lr_d22 = this.GetItemNumber(ll_row,"sales_quote_pvc_charge", Primary!, FALSE)
IF isNULL(lr_d22) THEN lr_d22 = 0.00
lr_d23 = this.GetItemNumber(ll_row,"sales_quote_interleave_charge", Primary!, FALSE)
IF isNULL(lr_d23) THEN lr_d23 = 0.00
lr_d24 = this.GetItemNumber(ll_row,"sales_quote_pkg_special_charge", Primary!, FALSE)
IF isNULL(lr_d24) THEN lr_d24 = 0.00
lr_d25 = this.GetItemNumber(ll_row,"sales_quote_coil_size_charge", Primary!, FALSE)
IF isNULL(lr_d25) THEN lr_d25 = 0.00
lr_d26 = lr_d20 + lr_d21 + lr_d22 + lr_d23 + lr_d24 + lr_d25
	
	this.Modify( "st_totalquote.Text='" + String(lr_d26, "###.###")  + "'~"" )
	this.Modify( "st_totalquote_1.Text='" + String(lr_d26, "###.###")  + "'~"" )
	
	AcceptText()

	SELECT Sales_rules_pkg.cutting_time_allocated(:ll_c15, :lr_c17, :lr_i32) INTO :lr_d31
	FROM Dual
	USING SQLCA;
	IF isNULL(lr_d31) THEN lr_d31 = 0
	this.SetItem(ll_row,"sales_quote_cutting_time", lr_d31)	
	
	SELECT Sales_rules_pkg.skid_change_time_allocated(:ll_i10) INTO :lr_d32
	FROM Dual
	USING SQLCA;
	IF isNULL(lr_d32) THEN lr_d32 = 0
	this.SetItem(ll_row,"sales_quote_skid_change_time", lr_d32)	

	SELECT Sales_rules_pkg.coil_change_time_allocated(:ll_c16) INTO :lr_d33
	FROM Dual
	USING SQLCA;
	IF isNULL(lr_d33) THEN lr_d33 = 0
	this.SetItem(ll_row,"sales_quote_coil_change_time", lr_d33)	

	SELECT Sales_rules_pkg.Die_set_time_allocated(:ll_c15, :ll_i9) INTO :lr_d34
	FROM Dual
	USING SQLCA;
	IF isNULL(lr_d34) THEN lr_d34 = 0
	this.SetItem(ll_row,"sales_quote_die_set_time", lr_d34)

	ll_i18 = Long(this.GetItemString(ll_row,"sales_quote_num_of_length_change", Primary!, FALSE))
	SELECT Sales_rules_pkg.Length_change_time_allocated(:ll_i18) INTO :lr_d35
	FROM Dual
	USING SQLCA;
	IF isNULL(lr_d35) THEN lr_d35 = 0
	this.SetItem(ll_row,"sales_quote_length_change_time", lr_d35)

	ll_i16 = this.GetItemNumber(ll_row,"sales_quote_special_process_minutes", Primary!, FALSE)
	IF IsNULL(ll_i16) THEN ll_i16 = 0
	lr_d36 = ll_i16
	this.SetItem(ll_row,"sales_quote_other_process_time", lr_d36)
	
	this.Modify( "st_totaltime_m.Text='" + String((lr_d31 + lr_d32 + lr_d33 + lr_d34 + lr_d35 + lr_d36), "######")  + "'~"" )
	this.Modify( "st_totaltime_h.Text='" + String((lr_d31 + lr_d32 + lr_d33 + lr_d34 + lr_d35 + lr_d36)/60, "######.##")  + "'~"" )
	this.SetItem(ll_row,"sales_quote_percent_time_cutting", 100.00 * lr_d31/(lr_d31 + lr_d32 + lr_d33 + lr_d34 + lr_d35 + lr_d36))
	
		SELECT Sales_rules_pkg.Variable_cost(:ll_i19) INTO :ll_f45
		FROM Dual
		USING SQLCA;
		this.SetItem(ll_row,"sales_quote_variable_cost", ll_f45)
		lr_g45 = 1.00 * (lr_d38 * ll_f45) / ll_c15
		this.Modify( "st_vc.Text='" + String(lr_g45, "##.###")  + "'~"" )

		SELECT Sales_rules_pkg.fixed_cost(:ll_i19) INTO :ll_f46
		FROM Dual
		USING SQLCA;
		this.SetItem(ll_row,"sales_quote_variable_cost", ll_f46)
		lr_g46 = 1.00 * (lr_d38 * ll_f46) / ll_c15
		this.Modify( "st_fc.Text='" + String(lr_g45, "##.###")  + "'~"" )
	
	lr_d38 = (lr_d31 + lr_d32 + lr_d33 + lr_d34 + lr_d35 + lr_d36)/60  
	IF lr_d38 > 0 THEN
		ll_i34 = ll_c15/lr_d38
		this.SetItem(ll_row,"sales_quote_lbs_per_hr", ll_i34)
		
		lr_g44 = lr_d26
		ll_f44 = (lr_d26 * ll_c15)/lr_d38
		this.SetItem(ll_row,"sales_quote_total_rev_per_hr", ll_f44)

		SELECT Sales_rules_pkg.pvc_price_per_lb(:ls_pvc, :lr_c17, :lr_c14, :lr_c13) INTO :lr_g47
		FROM Dual
		USING SQLCA;
		this.Modify( "st_pvcc.Text='" + String(lr_g47, "##.###")  + "'~"" )
		ll_f47 = (lr_g47 * ll_c15)/lr_d38
		this.SetItem(ll_row,"sales_quote_pvc_cost", ll_f47)
		
		SELECT Sales_rules_pkg.intrlv_price_per_lb(:ls_intrlv, :lr_c17, :lr_c14, :lr_c13) INTO :lr_g48
		FROM Dual
		USING SQLCA;
		this.Modify( "st_intrlvc.Text='" + String(lr_g48, "##.###")  + "'~"" )
		ll_f48 = (lr_g48 * ll_c15)/lr_d38
		this.SetItem(ll_row,"sales_quote_intrlv_cost",ll_f48)
		
		lr_g49 = this.GetItemNumber(ll_row,"sales_quote_pkg_special_cost_per_lb", Primary!, FALSE)
		ll_f49 = (lr_g49 * ll_c15)/lr_d38
		this.SetItem(ll_row,"sales_quote_pkg_special_cost",ll_f49)
		
	ELSE
		this.SetItem(ll_row,"sales_quote_lbs_per_hr", 0)
		
		lr_g44 = lr_d26
		ll_f44 = 0
		this.SetItem(ll_row,"sales_quote_total_rev_per_hr", ll_f44)

		SELECT Sales_rules_pkg.pvc_price_per_lb(:ls_pvc, :lr_c17, :lr_c14, :lr_c13) INTO :lr_g47
		FROM Dual
		USING SQLCA;
		this.Modify( "st_pvcc.Text='" + String(lr_g47, "##.###")  + "'~"" )
		ll_f47 = 0
		this.SetItem(ll_row,"sales_quote_pvc_cost", ll_f47)
		
		SELECT Sales_rules_pkg.intrlv_price_per_lb(:ls_intrlv, :lr_c17, :lr_c14, :lr_c13) INTO :lr_g48
		FROM Dual
		USING SQLCA;
		this.Modify( "st_intrlvc.Text='" + String(lr_g48, "##.###")  + "'~"" )
		ll_f48 = 0
		this.SetItem(ll_row,"sales_quote_intrlv_cost",ll_f48)
		
		lr_g49 = this.GetItemNumber(ll_row,"sales_quote_pkg_special_cost_per_lb", Primary!, FALSE)
		ll_f49 = 0
		this.SetItem(ll_row,"sales_quote_pkg_special_cost",ll_f49)
	END IF


	SELECT Sales_rules_pkg.ROS(:ll_f44, :ll_f45, :ll_f46, :ll_f47, :ll_f48, :ll_f48) INTO :lr_ros
	FROM Dual
	USING SQLCA;
	
	this.SetItem(ll_row,"sales_quote_ros", lr_ros )
	
	ll_f50 = ll_f44 - (ll_f45 + ll_f46 + ll_f47 + ll_f48 + ll_f49)
	IF ll_f50 > 0 THEN
		this.Modify( "st_profit.Text='" + String(ll_f50, "######")  + "'~"" )
	ELSE
		this.Modify( "st_profit.Text='(" + String(ll_f50, "######")  + ")'~"" )
	END IF
	
	lr_g50 = lr_g44 - (lr_g45 + lr_g46 + lr_g47 + lr_g48 + lr_g49)
	IF lr_g50 > 0 THEN
		this.Modify( "st_profit_per_lb.Text='" + String(lr_g50, "##.###")  + "'~"" )
	ELSE
		this.Modify( "st_profit_per_lb.Text='(" + String(lr_g50, "##.###")  + ")'~"" )
	END IF
	
	AcceptText()
	



end event

type tabpage_review from userobject within tab_q
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Review"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Preview!"
long picturemaskcolor = 536870912
dw_history dw_history
st_10 st_10
st_2 st_2
mle_1 mle_1
htb_1 htb_1
st_1 st_1
gb_1 gb_1
gb_today gb_today
end type

on tabpage_review.create
this.dw_history=create dw_history
this.st_10=create st_10
this.st_2=create st_2
this.mle_1=create mle_1
this.htb_1=create htb_1
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_today=create gb_today
this.Control[]={this.dw_history,&
this.st_10,&
this.st_2,&
this.mle_1,&
this.htb_1,&
this.st_1,&
this.gb_1,&
this.gb_today}
end on

on tabpage_review.destroy
destroy(this.dw_history)
destroy(this.st_10)
destroy(this.st_2)
destroy(this.mle_1)
destroy(this.htb_1)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_today)
end on

type dw_history from u_dw within tabpage_review
integer x = 110
integer y = 109
integer width = 2030
integer height = 1571
integer taborder = 20
string dataobject = "d_quote_review_probability_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)

end event

type st_10 from statictext within tabpage_review
integer x = 2227
integer y = 170
integer width = 263
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Probability:"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_review
integer x = 2235
integer y = 298
integer width = 234
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Because:"
boolean focusrectangle = false
end type

type mle_1 from u_mle within tabpage_review
integer x = 2480
integer y = 294
integer width = 1792
integer height = 957
integer taborder = 40
string facename = "Arial"
end type

type htb_1 from u_htb within tabpage_review
integer x = 2487
integer y = 154
integer width = 1595
integer height = 77
integer position = 60
integer tickfrequency = 5
htickmarks tickmarks = hticksontop!
end type

event moved;call super::moved;st_3.Text = String(this.Position) + "%"
end event

type st_1 from statictext within tabpage_review
integer x = 4085
integer y = 163
integer width = 143
integer height = 54
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "60%"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within tabpage_review
integer x = 77
integer y = 35
integer width = 2099
integer height = 1670
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quote Review History"
borderstyle borderstyle = styleraised!
end type

type gb_today from groupbox within tabpage_review
integer x = 2209
integer y = 96
integer width = 2096
integer height = 1261
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Quote Review "
borderstyle borderstyle = styleraised!
end type

type tabpage_reminder from userobject within tab_q
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Remind Me"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "EditStops5!"
long picturemaskcolor = 536870912
pb_12 pb_12
pb_11 pb_11
pb_10 pb_10
cb_save cb_save
dw_schedule dw_schedule
uo_calendar_1 uo_calendar_1
em_calendar em_calendar
mle_2 mle_2
pb_1 pb_1
gb_title gb_title
gb_6 gb_6
end type

on tabpage_reminder.create
this.pb_12=create pb_12
this.pb_11=create pb_11
this.pb_10=create pb_10
this.cb_save=create cb_save
this.dw_schedule=create dw_schedule
this.uo_calendar_1=create uo_calendar_1
this.em_calendar=create em_calendar
this.mle_2=create mle_2
this.pb_1=create pb_1
this.gb_title=create gb_title
this.gb_6=create gb_6
this.Control[]={this.pb_12,&
this.pb_11,&
this.pb_10,&
this.cb_save,&
this.dw_schedule,&
this.uo_calendar_1,&
this.em_calendar,&
this.mle_2,&
this.pb_1,&
this.gb_title,&
this.gb_6}
end on

on tabpage_reminder.destroy
destroy(this.pb_12)
destroy(this.pb_11)
destroy(this.pb_10)
destroy(this.cb_save)
destroy(this.dw_schedule)
destroy(this.uo_calendar_1)
destroy(this.em_calendar)
destroy(this.mle_2)
destroy(this.pb_1)
destroy(this.gb_title)
destroy(this.gb_6)
end on

type pb_12 from u_pb within tabpage_reminder
integer x = 1913
integer y = 70
integer width = 80
integer height = 70
integer taborder = 100
string text = ""
boolean originalsize = false
string picturename = "Custom091!"
string powertiptext = "Delete"
end type

type pb_11 from u_pb within tabpage_reminder
integer x = 2011
integer y = 70
integer width = 80
integer height = 70
integer taborder = 110
string text = ""
boolean originalsize = false
string picturename = "Custom072!"
string powertiptext = "Edit"
end type

type pb_10 from u_pb within tabpage_reminder
integer x = 2110
integer y = 70
integer width = 80
integer height = 70
integer taborder = 120
string text = ""
boolean originalsize = false
string picturename = "Custom074!"
string powertiptext = "Print"
end type

type cb_save from u_cb within tabpage_reminder
integer x = 3500
integer y = 701
integer width = 351
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "&Save"
end type

type dw_schedule from u_dw within tabpage_reminder
integer x = 73
integer y = 150
integer width = 2121
integer height = 1552
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sales_quote_event_list"
end type

event constructor;of_SetRowManager(TRUE)
of_SetBase(TRUE)
SetTransObject(SQLCA)


end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type uo_calendar_1 from u_calendar within tabpage_reminder
event destroy ( )
integer x = 2275
integer y = 141
integer width = 706
integer height = 653
integer taborder = 20
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type em_calendar from u_em within tabpage_reminder
boolean visible = false
integer x = 3204
integer y = 1018
integer width = 428
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;//this.of_SetDropDownCalendar(TRUE)
//this.iuo_calendar.of_SetAlwaysRedraw(TRUE)
//this.iuo_calendar.of_SetinitialValue(TRUE)
//
//this.iuo_calendar.of_SetSaturdayBold(TRUE)
//this.iuo_calendar.of_SetSaturdayColor(RGB(0, 255, 0)) 
//this.iuo_calendar.of_SetSundayBold(TRUE) 
//this.iuo_calendar.of_SetSundayColor(RGB(0, 255, 0))
//
//
//this.iuo_calendar.of_SetCloseonClick(TRUE)

uo_calendar_1.of_SetRequestor(this)
end event

event modified;//RETURN Parent.Event ue_date_changed()
end event

event other;//IF em_calendar.Text <>  is_date Then 
//	//MessageBox("", "hello")
//	//RETURN Parent.Event ue_date_changed()
//ELSE
//	RETURN 0
//END IF
end event

type mle_2 from u_mle within tabpage_reminder
integer x = 2988
integer y = 141
integer width = 1335
integer height = 557
integer taborder = 30
end type

type pb_1 from u_pb within tabpage_reminder
integer x = 1818
integer y = 70
integer width = 80
integer height = 70
integer taborder = 50
string text = ""
boolean originalsize = false
string picturename = "AddWatch5!"
string powertiptext = "New"
end type

type gb_title from groupbox within tabpage_reminder
integer x = 2231
integer y = 58
integer width = 2132
integer height = 752
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Remind Me:"
end type

type gb_6 from groupbox within tabpage_reminder
integer x = 11
integer y = 19
integer width = 2209
integer height = 1706
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "History"
end type

type tabpage_order from userobject within tab_q
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Order"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom026!"
long picturemaskcolor = 536870912
dw_order_list dw_order_list
dw_order dw_order
gb_9 gb_9
gb_10 gb_10
end type

on tabpage_order.create
this.dw_order_list=create dw_order_list
this.dw_order=create dw_order
this.gb_9=create gb_9
this.gb_10=create gb_10
this.Control[]={this.dw_order_list,&
this.dw_order,&
this.gb_9,&
this.gb_10}
end on

on tabpage_order.destroy
destroy(this.dw_order_list)
destroy(this.dw_order)
destroy(this.gb_9)
destroy(this.gb_10)
end on

type dw_order_list from u_dw within tabpage_order
integer x = 402
integer y = 115
integer width = 3515
integer height = 320
integer taborder = 21
string dataobject = "d_sales_order_list"
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(ids_q.quote_id, ids_q.revision_id)

end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

type dw_order from u_dw within tabpage_order
integer x = 241
integer y = 570
integer width = 3836
integer height = 1110
integer taborder = 11
string dataobject = "d_sales_order_entry_report"
end type

type gb_9 from groupbox within tabpage_order
integer x = 296
integer y = 51
integer width = 3723
integer height = 413
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "List of Customer Orders Generated From This Quote"
borderstyle borderstyle = styleraised!
end type

type gb_10 from groupbox within tabpage_order
integer x = 165
integer y = 490
integer width = 4027
integer height = 1245
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Customer Order Details"
borderstyle borderstyle = styleraised!
end type

type tabpage_job from userobject within tab_q
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "AB Job"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DosEdit5!"
long picturemaskcolor = 536870912
dw_job_detail dw_job_detail
dw_job_list dw_job_list
gb_7 gb_7
gb_8 gb_8
end type

on tabpage_job.create
this.dw_job_detail=create dw_job_detail
this.dw_job_list=create dw_job_list
this.gb_7=create gb_7
this.gb_8=create gb_8
this.Control[]={this.dw_job_detail,&
this.dw_job_list,&
this.gb_7,&
this.gb_8}
end on

on tabpage_job.destroy
destroy(this.dw_job_detail)
destroy(this.dw_job_list)
destroy(this.gb_7)
destroy(this.gb_8)
end on

type dw_job_detail from u_dw within tabpage_job
integer x = 278
integer y = 538
integer width = 3752
integer height = 1130
integer taborder = 21
string dataobject = "d_sales_prod_order"
end type

type dw_job_list from u_dw within tabpage_job
integer x = 735
integer y = 93
integer width = 2582
integer height = 320
integer taborder = 11
string dataobject = "d_sales_ab_job_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

event pfc_retrieve;call super::pfc_retrieve;RETURN this.Retrieve(ids_q.quote_id, ids_q.revision_id)
end event

type gb_7 from groupbox within tabpage_job
integer x = 600
integer y = 26
integer width = 2772
integer height = 413
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "List of Production Orders for this quote"
borderstyle borderstyle = styleraised!
end type

type gb_8 from groupbox within tabpage_job
integer x = 146
integer y = 464
integer width = 4027
integer height = 1245
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Production Order Details"
borderstyle borderstyle = styleraised!
end type

type tabpage_schedule from userobject within tab_q
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Scheduler"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Compile!"
long picturemaskcolor = 536870912
dw_job_scheduler dw_job_scheduler
end type

on tabpage_schedule.create
this.dw_job_scheduler=create dw_job_scheduler
this.Control[]={this.dw_job_scheduler}
end on

on tabpage_schedule.destroy
destroy(this.dw_job_scheduler)
end on

type dw_job_scheduler from u_dw within tabpage_schedule
integer y = 13
integer width = 4370
integer height = 1696
integer taborder = 11
string dataobject = "d_sales_line_priority"
end type

event constructor;call super::constructor;of_SetRowManager(TRUE)
of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

type tabpage_inventory from userobject within tab_q
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Inventory"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Project!"
long picturemaskcolor = 536870912
st_47 st_47
st_46 st_46
st_45 st_45
st_30 st_30
st_29 st_29
st_28 st_28
st_27 st_27
st_26 st_26
st_25 st_25
st_24 st_24
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
pb_i_scrapopen pb_i_scrapopen
pb_i_skidopen pb_i_skidopen
pb_i_coilopen pb_i_coilopen
st_44 st_44
st_43 st_43
st_42 st_42
st_41 st_41
st_40 st_40
st_39 st_39
st_38 st_38
dw_scrap_list dw_scrap_list
dw_skid_list dw_skid_list
dw_coil_list dw_coil_list
gb_i_coil gb_i_coil
gb_i_skid gb_i_skid
gb_i_scrap gb_i_scrap
end type

on tabpage_inventory.create
this.st_47=create st_47
this.st_46=create st_46
this.st_45=create st_45
this.st_30=create st_30
this.st_29=create st_29
this.st_28=create st_28
this.st_27=create st_27
this.st_26=create st_26
this.st_25=create st_25
this.st_24=create st_24
this.st_23=create st_23
this.st_22=create st_22
this.st_21=create st_21
this.st_20=create st_20
this.pb_i_scrapopen=create pb_i_scrapopen
this.pb_i_skidopen=create pb_i_skidopen
this.pb_i_coilopen=create pb_i_coilopen
this.st_44=create st_44
this.st_43=create st_43
this.st_42=create st_42
this.st_41=create st_41
this.st_40=create st_40
this.st_39=create st_39
this.st_38=create st_38
this.dw_scrap_list=create dw_scrap_list
this.dw_skid_list=create dw_skid_list
this.dw_coil_list=create dw_coil_list
this.gb_i_coil=create gb_i_coil
this.gb_i_skid=create gb_i_skid
this.gb_i_scrap=create gb_i_scrap
this.Control[]={this.st_47,&
this.st_46,&
this.st_45,&
this.st_30,&
this.st_29,&
this.st_28,&
this.st_27,&
this.st_26,&
this.st_25,&
this.st_24,&
this.st_23,&
this.st_22,&
this.st_21,&
this.st_20,&
this.pb_i_scrapopen,&
this.pb_i_skidopen,&
this.pb_i_coilopen,&
this.st_44,&
this.st_43,&
this.st_42,&
this.st_41,&
this.st_40,&
this.st_39,&
this.st_38,&
this.dw_scrap_list,&
this.dw_skid_list,&
this.dw_coil_list,&
this.gb_i_coil,&
this.gb_i_skid,&
this.gb_i_scrap}
end on

on tabpage_inventory.destroy
destroy(this.st_47)
destroy(this.st_46)
destroy(this.st_45)
destroy(this.st_30)
destroy(this.st_29)
destroy(this.st_28)
destroy(this.st_27)
destroy(this.st_26)
destroy(this.st_25)
destroy(this.st_24)
destroy(this.st_23)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.pb_i_scrapopen)
destroy(this.pb_i_skidopen)
destroy(this.pb_i_coilopen)
destroy(this.st_44)
destroy(this.st_43)
destroy(this.st_42)
destroy(this.st_41)
destroy(this.st_40)
destroy(this.st_39)
destroy(this.st_38)
destroy(this.dw_scrap_list)
destroy(this.dw_skid_list)
destroy(this.dw_coil_list)
destroy(this.gb_i_coil)
destroy(this.gb_i_skid)
destroy(this.gb_i_scrap)
end on

type st_47 from statictext within tabpage_inventory
integer x = 3105
integer y = 1616
integer width = 380
integer height = 51
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_46 from statictext within tabpage_inventory
integer x = 4144
integer y = 1667
integer width = 216
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_45 from statictext within tabpage_inventory
integer x = 3855
integer y = 1664
integer width = 252
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Canceled"
boolean focusrectangle = false
end type

type st_30 from statictext within tabpage_inventory
integer x = 3628
integer y = 1664
integer width = 208
integer height = 58
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
string text = "Ready"
boolean focusrectangle = false
end type

type st_29 from statictext within tabpage_inventory
integer x = 3343
integer y = 1664
integer width = 252
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_28 from statictext within tabpage_inventory
integer x = 3160
integer y = 1664
integer width = 135
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
boolean focusrectangle = false
end type

type st_27 from statictext within tabpage_inventory
integer x = 2736
integer y = 1670
integer width = 187
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 79741120
boolean enabled = false
string text = "Partial"
boolean focusrectangle = false
end type

type st_26 from statictext within tabpage_inventory
integer x = 2491
integer y = 1674
integer width = 241
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 79741120
boolean enabled = false
string text = "PreReCap"
boolean focusrectangle = false
end type

type st_25 from statictext within tabpage_inventory
integer x = 2304
integer y = 1670
integer width = 183
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_24 from statictext within tabpage_inventory
integer x = 2081
integer y = 1670
integer width = 212
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Canceled"
boolean focusrectangle = false
end type

type st_23 from statictext within tabpage_inventory
integer x = 1898
integer y = 1670
integer width = 157
integer height = 51
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
string text = "Ready"
boolean focusrectangle = false
end type

type st_22 from statictext within tabpage_inventory
integer x = 1668
integer y = 1670
integer width = 227
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_21 from statictext within tabpage_inventory
integer x = 1518
integer y = 1670
integer width = 132
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
boolean focusrectangle = false
end type

type st_20 from statictext within tabpage_inventory
integer x = 1415
integer y = 1619
integer width = 380
integer height = 51
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type pb_i_scrapopen from u_pb within tabpage_inventory
integer x = 4279
integer y = 54
integer width = 80
integer height = 70
integer taborder = 130
string text = ""
boolean originalsize = false
string picturename = "OutputSkip!"
string powertiptext = "Shipment details"
end type

type pb_i_skidopen from u_pb within tabpage_inventory
integer x = 2926
integer y = 54
integer width = 80
integer height = 70
integer taborder = 130
string text = ""
boolean originalsize = false
string picturename = "Preview!"
string powertiptext = "Skid details"
end type

type pb_i_coilopen from u_pb within tabpage_inventory
integer x = 1251
integer y = 54
integer width = 80
integer height = 70
integer taborder = 120
string text = ""
string picturename = "DeclareProcedure!"
string powertiptext = "Coil details"
end type

type st_44 from statictext within tabpage_inventory
integer x = 1097
integer y = 1670
integer width = 190
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 79741120
boolean enabled = false
string text = "InTransit"
boolean focusrectangle = false
end type

type st_43 from statictext within tabpage_inventory
integer x = 896
integer y = 1670
integer width = 187
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_42 from statictext within tabpage_inventory
integer x = 684
integer y = 1670
integer width = 205
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Rejected"
boolean focusrectangle = false
end type

type st_41 from statictext within tabpage_inventory
integer x = 560
integer y = 1670
integer width = 113
integer height = 54
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
string text = "New"
boolean focusrectangle = false
end type

type st_40 from statictext within tabpage_inventory
integer x = 322
integer y = 1670
integer width = 223
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_39 from statictext within tabpage_inventory
integer x = 150
integer y = 1670
integer width = 150
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Done"
boolean focusrectangle = false
end type

type st_38 from statictext within tabpage_inventory
integer x = 29
integer y = 1619
integer width = 351
integer height = 54
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type dw_scrap_list from u_dw within tabpage_inventory
integer x = 3076
integer y = 128
integer width = 1276
integer height = 1478
integer taborder = 31
string dataobject = "d_sales_scrap_skid_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

type dw_skid_list from u_dw within tabpage_inventory
integer x = 1404
integer y = 128
integer width = 1605
integer height = 1478
integer taborder = 21
string dataobject = "d_sales_skid_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

type dw_coil_list from u_dw within tabpage_inventory
integer x = 37
integer y = 128
integer width = 1298
integer height = 1478
integer taborder = 11
string dataobject = "d_sales_coil_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

type gb_i_coil from groupbox within tabpage_inventory
integer x = 15
integer y = 16
integer width = 1349
integer height = 1722
integer taborder = 31
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Coil"
borderstyle borderstyle = styleraised!
end type

type gb_i_skid from groupbox within tabpage_inventory
integer x = 1379
integer y = 16
integer width = 1657
integer height = 1722
integer taborder = 41
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217730
long backcolor = 79741120
string text = "Skid"
borderstyle borderstyle = styleraised!
end type

type gb_i_scrap from groupbox within tabpage_inventory
integer x = 3054
integer y = 16
integer width = 1324
integer height = 1722
integer taborder = 51
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
string text = "Scrap"
borderstyle borderstyle = styleraised!
end type

type tabpage_quality from userobject within tab_q
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Coil Quality"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DBDisconnect!"
long picturemaskcolor = 536870912
end type

type tabpage_shipment from userobject within tab_q
integer x = 15
integer y = 90
integer width = 4378
integer height = 1738
long backcolor = 79741120
string text = "Shipment"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Import!"
long picturemaskcolor = 536870912
pb_17 pb_17
pb_16 pb_16
pb_15 pb_15
st_49 st_49
st_48 st_48
st_37 st_37
st_36 st_36
st_35 st_35
st_34 st_34
st_33 st_33
st_32 st_32
st_31 st_31
st_19 st_19
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
pb_14 pb_14
dw_shipscrap dw_shipscrap
pb_13 pb_13
dw_shipskid dw_shipskid
pb_5 pb_5
dw_shipcoil dw_shipcoil
gb_12 gb_12
gb_13 gb_13
gb_14 gb_14
end type

on tabpage_shipment.create
this.pb_17=create pb_17
this.pb_16=create pb_16
this.pb_15=create pb_15
this.st_49=create st_49
this.st_48=create st_48
this.st_37=create st_37
this.st_36=create st_36
this.st_35=create st_35
this.st_34=create st_34
this.st_33=create st_33
this.st_32=create st_32
this.st_31=create st_31
this.st_19=create st_19
this.st_18=create st_18
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.pb_14=create pb_14
this.dw_shipscrap=create dw_shipscrap
this.pb_13=create pb_13
this.dw_shipskid=create dw_shipskid
this.pb_5=create pb_5
this.dw_shipcoil=create dw_shipcoil
this.gb_12=create gb_12
this.gb_13=create gb_13
this.gb_14=create gb_14
this.Control[]={this.pb_17,&
this.pb_16,&
this.pb_15,&
this.st_49,&
this.st_48,&
this.st_37,&
this.st_36,&
this.st_35,&
this.st_34,&
this.st_33,&
this.st_32,&
this.st_31,&
this.st_19,&
this.st_18,&
this.st_17,&
this.st_16,&
this.st_15,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.pb_14,&
this.dw_shipscrap,&
this.pb_13,&
this.dw_shipskid,&
this.pb_5,&
this.dw_shipcoil,&
this.gb_12,&
this.gb_13,&
this.gb_14}
end on

on tabpage_shipment.destroy
destroy(this.pb_17)
destroy(this.pb_16)
destroy(this.pb_15)
destroy(this.st_49)
destroy(this.st_48)
destroy(this.st_37)
destroy(this.st_36)
destroy(this.st_35)
destroy(this.st_34)
destroy(this.st_33)
destroy(this.st_32)
destroy(this.st_31)
destroy(this.st_19)
destroy(this.st_18)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.pb_14)
destroy(this.dw_shipscrap)
destroy(this.pb_13)
destroy(this.dw_shipskid)
destroy(this.pb_5)
destroy(this.dw_shipcoil)
destroy(this.gb_12)
destroy(this.gb_13)
destroy(this.gb_14)
end on

type pb_17 from u_pb within tabpage_shipment
integer x = 4184
integer y = 67
integer width = 80
integer height = 70
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "OutputSkip!"
string powertiptext = "Shipment details"
end type

type pb_16 from u_pb within tabpage_shipment
integer x = 2739
integer y = 67
integer width = 80
integer height = 70
integer taborder = 30
string text = ""
boolean originalsize = false
string picturename = "Preview!"
string powertiptext = "Skid details"
end type

type pb_15 from u_pb within tabpage_shipment
integer x = 1207
integer y = 67
integer width = 80
integer height = 70
integer taborder = 110
string text = ""
boolean originalsize = false
string picturename = "DeclareProcedure!"
string powertiptext = "Coil details"
end type

type st_49 from statictext within tabpage_shipment
integer x = 3917
integer y = 1523
integer width = 362
integer height = 54
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
string text = "NetWT:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_48 from statictext within tabpage_shipment
integer x = 3533
integer y = 1523
integer width = 377
integer height = 54
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
string text = "Number of Skids:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_37 from statictext within tabpage_shipment
integer x = 2384
integer y = 1526
integer width = 362
integer height = 54
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
string text = "NetWT:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_36 from statictext within tabpage_shipment
integer x = 2000
integer y = 1526
integer width = 377
integer height = 54
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
string text = "Number of Skids:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_35 from statictext within tabpage_shipment
integer x = 907
integer y = 1526
integer width = 362
integer height = 54
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
string text = "NetWT:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_34 from statictext within tabpage_shipment
integer x = 523
integer y = 1526
integer width = 362
integer height = 54
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
string text = "Number of Coils:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_33 from statictext within tabpage_shipment
integer x = 3313
integer y = 1677
integer width = 146
integer height = 54
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
string text = "Ready"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_32 from statictext within tabpage_shipment
integer x = 3226
integer y = 1629
integer width = 234
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "Scheduled"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_31 from statictext within tabpage_shipment
integer x = 3310
integer y = 1578
integer width = 150
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_19 from statictext within tabpage_shipment
integer x = 3127
integer y = 1526
integer width = 351
integer height = 54
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_18 from statictext within tabpage_shipment
integer x = 1755
integer y = 1677
integer width = 146
integer height = 54
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
string text = "Ready"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_17 from statictext within tabpage_shipment
integer x = 1668
integer y = 1629
integer width = 234
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "Scheduled"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_16 from statictext within tabpage_shipment
integer x = 1752
integer y = 1578
integer width = 150
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_15 from statictext within tabpage_shipment
integer x = 1573
integer y = 1526
integer width = 351
integer height = 54
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_14 from statictext within tabpage_shipment
integer x = 293
integer y = 1677
integer width = 146
integer height = 54
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
string text = "Ready"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_13 from statictext within tabpage_shipment
integer x = 205
integer y = 1629
integer width = 234
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "Scheduled"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within tabpage_shipment
integer x = 289
integer y = 1578
integer width = 150
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within tabpage_shipment
integer x = 121
integer y = 1526
integer width = 351
integer height = 54
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type pb_14 from u_pb within tabpage_shipment
integer x = 4272
integer y = 67
integer width = 80
integer height = 70
integer taborder = 140
string text = ""
boolean originalsize = false
string picturename = "InsertReturn!"
string powertiptext = "Shipment details"
end type

type dw_shipscrap from u_dw within tabpage_shipment
integer x = 2955
integer y = 141
integer width = 1393
integer height = 1379
integer taborder = 41
string dataobject = "d_sales_scrap_ship_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

type pb_13 from u_pb within tabpage_shipment
integer x = 2827
integer y = 67
integer width = 80
integer height = 70
integer taborder = 140
string text = ""
boolean originalsize = false
string picturename = "InsertReturn!"
string powertiptext = "Shipment details"
end type

type dw_shipskid from u_dw within tabpage_shipment
integer x = 1423
integer y = 141
integer width = 1485
integer height = 1379
integer taborder = 31
string dataobject = "d_sales_skid_ship_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

type pb_5 from u_pb within tabpage_shipment
integer x = 1302
integer y = 67
integer width = 80
integer height = 70
integer taborder = 130
string text = ""
boolean originalsize = false
string picturename = "InsertReturn!"
string powertiptext = "Shipment details"
end type

type dw_shipcoil from u_dw within tabpage_shipment
integer x = 22
integer y = 141
integer width = 1360
integer height = 1379
integer taborder = 21
string dataobject = "d_sales_coil_ship_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
end event

type gb_12 from groupbox within tabpage_shipment
integer y = 32
integer width = 1401
integer height = 1706
integer taborder = 41
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 79741120
string text = "Coil"
borderstyle borderstyle = styleraised!
end type

type gb_13 from groupbox within tabpage_shipment
integer x = 1408
integer y = 32
integer width = 1525
integer height = 1706
integer taborder = 51
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217730
long backcolor = 79741120
string text = "Skid"
borderstyle borderstyle = styleraised!
end type

type gb_14 from groupbox within tabpage_shipment
integer x = 2940
integer y = 32
integer width = 1430
integer height = 1706
integer taborder = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
string text = "Scrap"
borderstyle borderstyle = styleraised!
end type

type st_9 from statictext within w_edit_quote
integer x = 2337
integer y = 1933
integer width = 274
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Order"
boolean focusrectangle = false
end type

type pb_9 from u_pb within w_edit_quote
integer x = 2202
integer y = 1917
integer width = 121
integer height = 96
integer taborder = 70
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom026!"
end type

type st_8 from statictext within w_edit_quote
integer x = 1152
integer y = 1933
integer width = 289
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "A Revision"
boolean focusrectangle = false
end type

type pb_8 from u_pb within w_edit_quote
integer x = 1013
integer y = 1917
integer width = 121
integer height = 96
integer taborder = 110
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom023!"
end type

type st_7 from statictext within w_edit_quote
integer x = 1719
integer y = 1933
integer width = 380
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "A New Quote"
boolean focusrectangle = false
end type

type pb_7 from u_pb within w_edit_quote
integer x = 1584
integer y = 1917
integer width = 121
integer height = 96
integer taborder = 110
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Copy!"
end type

type st_6 from statictext within w_edit_quote
integer x = 4100
integer y = 1933
integer width = 212
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Exit"
boolean focusrectangle = false
end type

type pb_6 from u_pb within w_edit_quote
integer x = 3957
integer y = 1917
integer width = 121
integer height = 96
integer taborder = 100
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Exit!"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_5 from statictext within w_edit_quote
integer x = 296
integer y = 1933
integer width = 453
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Save this quote"
boolean focusrectangle = false
end type

type pb_4 from u_pb within w_edit_quote
integer x = 154
integer y = 1917
integer width = 121
integer height = 96
integer taborder = 80
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom008!"
end type

type st_4 from statictext within w_edit_quote
integer x = 3463
integer y = 1933
integer width = 260
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
string text = "Email to .."
boolean focusrectangle = false
end type

type st_3 from statictext within w_edit_quote
integer x = 3013
integer y = 1933
integer width = 150
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
string text = "Print"
boolean focusrectangle = false
end type

type pb_3 from u_pb within w_edit_quote
integer x = 3335
integer y = 1917
integer width = 121
integer height = 96
integer taborder = 70
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom025!"
end type

event clicked;call super::clicked;OpenWithParm(w_sales_quote_to_cust_email, ids_q)
end event

type pb_2 from u_pb within w_edit_quote
integer x = 2882
integer y = 1917
integer width = 121
integer height = 96
integer taborder = 60
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Print!"
end type

event clicked;call super::clicked;OpenWithParm(w_sales_printout, ids_q)
end event

type gb_5 from groupbox within w_edit_quote
integer x = 2721
integer y = 1850
integer width = 1075
integer height = 176
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
string text = "Distribute"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_edit_quote
integer x = 33
integer y = 1850
integer width = 735
integer height = 176
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = " Save"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_edit_quote
integer x = 3825
integer y = 1850
integer width = 563
integer height = 176
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Exit"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_edit_quote
integer x = 786
integer y = 1846
integer width = 1905
integer height = 179
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
string text = "Save This Quote As"
borderstyle borderstyle = styleraised!
end type

