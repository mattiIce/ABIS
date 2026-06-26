$PBExportHeader$w_scale_skid_bk.srw
$PBExportComments$<Child> skid weight information retrieving from scale
forward
global type w_scale_skid_bk from w_child
end type
type cb_print from u_cb within w_scale_skid_bk
end type
type st_msg from statictext within w_scale_skid_bk
end type
type st_5 from statictext within w_scale_skid_bk
end type
type em_net from u_em within w_scale_skid_bk
end type
type dw_report from u_dw within w_scale_skid_bk
end type
type sle_input from u_sle within w_scale_skid_bk
end type
type em_id from u_em within w_scale_skid_bk
end type
type st_4 from statictext within w_scale_skid_bk
end type
type p_1 from picture within w_scale_skid_bk
end type
type pb_scale from u_pb within w_scale_skid_bk
end type
type st_3 from statictext within w_scale_skid_bk
end type
type st_2 from statictext within w_scale_skid_bk
end type
type st_1 from statictext within w_scale_skid_bk
end type
type em_tare from u_em within w_scale_skid_bk
end type
type em_gross from u_em within w_scale_skid_bk
end type
type cb_save from u_cb within w_scale_skid_bk
end type
type cb_new from u_cb within w_scale_skid_bk
end type
type cb_exit from u_cb within w_scale_skid_bk
end type
end forward

global type w_scale_skid_bk from w_child
string tag = "Skid weight"
integer x = 300
integer y = 99
integer width = 3098
integer height = 2042
string title = "SKID WEIGHT"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type long ue_next ( )
event type long ue_readscale ( )
event type integer ue_print ( )
event ue_display_message ( string as_msg )
cb_print cb_print
st_msg st_msg
st_5 st_5
em_net em_net
dw_report dw_report
sle_input sle_input
em_id em_id
st_4 st_4
p_1 p_1
pb_scale pb_scale
st_3 st_3
st_2 st_2
st_1 st_1
em_tare em_tare
em_gross em_gross
cb_save cb_save
cb_new cb_new
cb_exit cb_exit
end type
global w_scale_skid_bk w_scale_skid_bk

type variables
Long il_skid, il_tare, il_net, il_gross
Boolean ib_saved, ib_simulate_mode, ib_save_then_print_mode, ib_skid_is_valid

//for report
Int ii_type
Long il_customer, il_enduser
String is_printer
end variables

forward prototypes
public function string wf_get_objectname ()
public function integer wf_setreportobject ()
end prototypes

event type long ue_next();//IF NOT(ib_saved) THEN
//	IF MessageBox("Question","Discard current data and loading a new skid?", Question!, YesNO!, 2) = 2 THEN RETURN 0
//END IF
em_id.Text = '  '
em_tare.Text='0'
em_gross.Text='0'
em_net.Text = '0'
SetNULL(il_skid)
SetNULL(il_tare)
SetNULL(il_gross)
SetNULL(il_net)
ib_saved = FALSE
ib_skid_is_valid = FALSE
sle_input.Text = ""
IF ib_simulate_mode THEN 
	//nothing
ELSE
	f_reset_scale()
END IF

sle_input.SetFocus()


RETURN 1
end event

event type long ue_readscale();IF ib_simulate_mode THEN 
	em_gross.Text = String(Rand(32765))
ELSE
	em_gross.Text = String(f_read_scale())
END IF

IF NOT(ib_skid_is_valid) THEN 
	RETURN -1
END IF

IF il_tare > 0 THEN
	em_net.Text = String(Long(em_gross.Text) - il_tare)
ELSE
	em_tare.Text = String(Long(em_gross.Text) - il_net)
END IF

sle_input.SetFocus()

RETURN 1
end event

event type integer ue_print();Long ll_job, ll_tare, ll_net, ll_order, ll_item, ll_shift
Double lr_l, lr_w, lr_gauge
String ls_cust, ls_enduser, ls_alloy, ls_temper, ls_shift
DateTime ldt_t

IF il_skid = 0 OR IsNULL(il_skid) THEN
	RETURN 0
END IF

dw_report.Reset()
dw_report.Retrieve(il_skid)

SELECT ab_job_num, sheet_tare_wt, sheet_net_wt, skid_date, ref_order_abc_num, ref_order_abc_item
INTO :ll_job, :ll_tare, :ll_net, :ldt_t, :ll_order, :ll_item
FROM Sheet_skid
WHERE sheet_skid_num = :il_skid
USING SQLCA;

SELECT "CUSTOMER_A"."CUSTOMER_SHORT_NAME",   
         "CUSTOMER_B"."CUSTOMER_SHORT_NAME",
			f_get_part_length_per_job(:ll_job),
			f_get_part_width_per_job(:ll_job) 
INTO :ls_cust, :ls_enduser, :lr_l, :lr_w
FROM     "AB_JOB",   
         "CUSTOMER_ORDER",   
         "CUSTOMER" "CUSTOMER_A",   
         "CUSTOMER" "CUSTOMER_B"
WHERE    ( customer_order.orig_customer_id = customer_a.customer_id (+)) and  
         ( customer_order.enduser_id = customer_b.customer_id (+)) and  
         ( "AB_JOB"."ORDER_ABC_NUM" = "CUSTOMER_ORDER"."ORDER_ABC_NUM" ) and  
         ( "AB_JOB"."AB_JOB_NUM" = :ll_job  )
USING SQLCA;

SELECT alloy2, temper, gauge
INTO  :ls_alloy, :ls_temper, :lr_gauge
FROM order_item
WHERE (order_item_num = :ll_item) AND (order_abc_num = :ll_order)
USING SQLCA;

dw_report.object.t_customer.text = ls_cust
dw_report.object.t_enduser.text = "End User: " + ls_enduser
dw_report.object.t_skid_num_b.text = "*S" + string(il_skid) + "*"
dw_report.object.t_skid_num_t.text = string(il_skid)
dw_report.object.t_job.text = string(ll_job)
dw_report.object.t_alloy.text = ls_alloy
dw_report.object.t_temper.text = ls_temper
dw_report.object.t_gage.text = string(lr_gauge)
dw_report.object.t_width.text = string(lr_w)
dw_report.object.t_length.text = string(lr_l)
dw_report.object.t_gross_wt.text = string((ll_net + ll_tare))
dw_report.object.t_net.text = string(ll_net)
dw_report.object.t_tare.text = string(ll_tare)
dw_report.object.t_date.text = "Date: " + string(ldt_t, "MM/DD/YYYY")

SELECT  "SHIFT"."SCHEDULE_TYPE"
INTO :ll_shift
FROM "SHIFT","PRODUCTION_SHEET_ITEM"
where ("SHIFT"."SHIFT_NUM" =  "PRODUCTION_SHEET_ITEM"."SHIFT_NUM") and
		"PRODUCTION_SHEET_ITEM"."PROD_ITEM_DATE" = ( select MAX("PRODUCTION_SHEET_ITEM"."PROD_ITEM_DATE") 
    							FROM "PRODUCTION_SHEET_ITEM",  "SHEET_SKID_DETAIL"  
  							 WHERE ( "SHEET_SKID_DETAIL"."SHEET_SKID_NUM" = :il_skid ) and  
        			 ( "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" = "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" ) )
USING SQLCA;

CHOOSE CASE ll_shift
	CASE 1
		ls_shift = "1st Shift"
	CASE 2
		ls_shift = "2nd Shift"
	CASE 3
		ls_shift = "3rd Shift"
	CASE ELSE
		ls_shift = " - "
END CHOOSE
dw_report.object.t_shift.text = ls_shift

dw_report.print( )



Return 1

end event

event ue_display_message(string as_msg);st_msg.Visible = TRUE
st_msg.Text = as_msg
Timer(5)

end event

public function string wf_get_objectname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Get_objectname
//
//	Access:    Public
//
//	Arguments:	None
//
//	Returns:  string
//	  The object name string.
//
//	Description:  
//	Returns report object name base on 
//			il_customer  --  customer_id
//			il_enduser	--	enduser_id
//			ii_type	--	report type
//	IF there is no object specified then return then default one.
//
//////////////////////////////////////////////////////////////////////////////

String ls_name
Int li_template_id

SetNULL(ls_name)
CONNECT USING SQLCA;
SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name  
FROM CUSTOMER_SH_REPORT_TEMPLATES, SH_REPORT_TEMPLATES  
WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = CUSTOMER_SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID ) and  
		( ( CUSTOMER_SH_REPORT_TEMPLATES.CUSTOMER_ID = :il_customer ) AND  
		( CUSTOMER_SH_REPORT_TEMPLATES.SHIPTO_ID = :il_enduser ) AND  
		( SH_REPORT_TEMPLATES.SH_REPORT_TYPE_ID = :ii_type ) )    
USING SQLCA;

IF IsNULL(ls_name) OR Len(ls_name) < 2 THEN
	//CUSTOMER DEFAULT TEMPLATE
	SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name  
	FROM CUST_SH_DEFAULT_TEMPLATE, SH_REPORT_TEMPLATES  
	WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = CUST_SH_DEFAULT_TEMPLATE.SH_REPORT_TEMPLATE_ID ) and  
			( (CUST_SH_DEFAULT_TEMPLATE.CUSTOMER_ID = :il_customer ) AND  
			( CUST_SH_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = :ii_type ) )    
	USING SQLCA;
END IF

//DEFAULT TEMPLATE
IF IsNULL(ls_name) OR Len(ls_name) < 2 THEN
	SELECT SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_OBJECT INTO :ls_name   
   FROM SH_REPORT_DEFAULT_TEMPLATE, SH_REPORT_TEMPLATES  
   WHERE ( SH_REPORT_TEMPLATES.SH_REPORT_TEMPLATE_ID = SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TEMPLATE_ID ) and  
     	   ( SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = SH_REPORT_TEMPLATES.SH_REPORT_TYPE_ID ) and  
    	   ( ( SH_REPORT_DEFAULT_TEMPLATE.SH_REPORT_TYPE_ID = :ii_type ) )    
	USING SQLCA;
END IF




RETURN ls_name
end function

public function integer wf_setreportobject ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_setreportobject
//
//	Access:    Public
//
//	Arguments:	None
//
//	Returns:  Integer
//	  	1	-- success
//		other  -- false
//
//	Description:  setup print object based on the object name
//
//////////////////////////////////////////////////////////////////////////////

String ls_oname
s_dw_info lstr_dw

ls_oname = wf_get_objectname() + "_scale"
//dw_report.of_setabcoreport(ls_oname)

dw_report.Reset()
//dw_report.DataObject = dw_report.inv_abco_report.Dynamic of_getreportobject()
dw_report.setTransObject(SQLCA)
//IF dw_report.inv_abco_report.Dynamic of_retrieve(il_shipment) < 0 THEN
  //MessageBox("Info", "Failed to print report.")
//END IF



RETURN 1
end function

on w_scale_skid_bk.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.st_msg=create st_msg
this.st_5=create st_5
this.em_net=create em_net
this.dw_report=create dw_report
this.sle_input=create sle_input
this.em_id=create em_id
this.st_4=create st_4
this.p_1=create p_1
this.pb_scale=create pb_scale
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.em_tare=create em_tare
this.em_gross=create em_gross
this.cb_save=create cb_save
this.cb_new=create cb_new
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.st_msg
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.em_net
this.Control[iCurrent+5]=this.dw_report
this.Control[iCurrent+6]=this.sle_input
this.Control[iCurrent+7]=this.em_id
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.p_1
this.Control[iCurrent+10]=this.pb_scale
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.em_tare
this.Control[iCurrent+15]=this.em_gross
this.Control[iCurrent+16]=this.cb_save
this.Control[iCurrent+17]=this.cb_new
this.Control[iCurrent+18]=this.cb_exit
end on

on w_scale_skid_bk.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.st_msg)
destroy(this.st_5)
destroy(this.em_net)
destroy(this.dw_report)
destroy(this.sle_input)
destroy(this.em_id)
destroy(this.st_4)
destroy(this.p_1)
destroy(this.pb_scale)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_tare)
destroy(this.em_gross)
destroy(this.cb_save)
destroy(this.cb_new)
destroy(this.cb_exit)
end on

event open;call super::open;SetNULL(il_skid)
SetNULL(il_tare)
SetNULL(il_gross)
SetNULL(il_net)
ib_saved = FALSE
ib_skid_is_valid = FALSE

String ls_inifile, ls_simulate, ls_savethenprint

ls_inifile = gnv_app.of_getappinifile( )
ls_simulate = ProfileString(ls_inifile,"SCALE","Scale_mode","simulate")
IF Upper(Trim(ls_simulate)) = "REAL" THEN
	ib_simulate_mode = FALSE
ELSE
	ib_simulate_mode = TRUE
END IF
ls_savethenprint = ProfileString(ls_inifile,"SCALE","Save_then_print_mode","NO")
IF Upper(Trim(ls_savethenprint)) = "YES" THEN
	ib_save_then_print_mode = TRUE
ELSE
	ib_save_then_print_mode = FALSE
END IF
is_printer = Trim(ProfileString(ls_inifile,"SCALE","Scale_printer","Zebra ZM600"))

st_msg.Visible = FALSE
em_id.Text = ""
em_tare.Text = ""
em_net.Text = ""
em_gross.Text = ""
end event

event pfc_save;Long ll_skid, ll_other_items_wt, ll_item_wt, ll_no_wt_item_id, ll_db_skid_wt, ll_current_item_wt, ll_current_skid_wt, ll_tare
Int li_row, li_i, li_no_wt_item
DataStore lds_skid

sle_input.SetFocus()

ll_skid = Long(em_id.Text)
IF ll_skid <= 1 THEN
	this.Event ue_display_message("Warning : Invalid skid ID.")
	RETURN -1
END IF

il_gross = Long(em_gross.Text)
IF il_gross <= 0 THEN
	this.Event ue_display_message("Warning : Invalid gross WT.")
	RETURN -1
END IF

IF NOT(ib_skid_is_valid) THEN
	this.Event ue_display_message("Warning : Action denied due to invalid data.")
	RETURN -2
END IF

IF il_tare > 0 THEN 

	lds_skid = Create DataStore
	lds_skid.DataObject = "d_scale_skid_info"
	lds_skid.SetTransObject(SQLCA)
	lds_skid.Retrieve(ll_skid)
	li_row = lds_skid.RowCount()

	IF li_row <= 0 THEN
		this.Event ue_display_message("Warning : Invalid skid ID.")
		DESTROY lds_skid
		RETURN -2
	END IF

	ll_other_items_wt = 0
	li_no_wt_item = 0
	FOR li_i = 1 TO li_row
		ll_db_skid_wt = lds_skid.GetItemNumber(li_i, "sheet_skid_sheet_net_wt")
		ll_item_wt = lds_skid.GetItemNumber(li_i, "production_sheet_item_prod_item_net_wt")
		IF IsNULL(ll_item_wt) OR (ll_item_wt = 0) THEN
			ll_item_wt = 0
			li_no_wt_item++
			ll_no_wt_item_id = lds_skid.GetItemNumber(li_i, "production_sheet_item_prod_item_num")
		END IF
		ll_other_items_wt = ll_other_items_wt + ll_item_wt
	NEXT
	DESTROY lds_skid

	IF li_no_wt_item = 0 THEN
		this.Event ue_display_message("Warning : All items for this skid has been weighted. Please verify.")
		RETURN -3
	END IF
	IF li_no_wt_item > 1 THEN
		this.Event ue_display_message("Warning : More than one item on this skid need weight info. Please verify.")
		RETURN -4
	END IF
	ll_current_skid_wt = il_gross - il_tare 
	ll_current_item_wt = ll_current_skid_wt - ll_other_items_wt
	IF ll_current_skid_wt <= 0 THEN
		this.Event ue_display_message("Warning : Invalid current skid net weight.")
		RETURN -5
	END IF
	IF ll_current_item_wt <= 0 THEN
		this.Event ue_display_message("Warning : Invalid tare or gross wt.")
		RETURN -6
	END IF

	UPDATE sheet_skid
	SET sheet_net_wt = :ll_current_skid_wt
	WHERE sheet_skid_num = :ll_skid
	USING SQLCA;
	IF SQLCA.SQLCode >= 0 THEN
		//COMMIT USING SQLCA;
	ELSE
		MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
		Rollback using SQLCA;
	END IF

	UPDATE production_sheet_item
	SET prod_item_net_wt = :ll_current_item_wt
	WHERE prod_item_num = :ll_no_wt_item_id
	USING SQLCA;
	IF SQLCA.SQLCode >= 0 THEN
	//COMMIT USING SQLCA;
	ELSE
		MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
		Rollback using SQLCA;
	END IF
	COMMIT USING SQLCA;
ELSE 
	ll_tare = il_gross - il_net
	UPDATE sheet_skid
	SET sheet_tare_wt = :ll_tare
	WHERE sheet_skid_num = :ll_skid
	USING SQLCA;
	IF SQLCA.SQLCode >= 0 THEN
		//COMMIT USING SQLCA;
	ELSE	
		MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
		Rollback using SQLCA;
	END IF
	COMMIT USING SQLCA;
END IF
	
ib_saved = TRUE

this.Event ue_display_message("Data saved!")

IF ib_save_then_print_mode THEN
	this.Event ue_print()
END IF

this.Event ue_next()

RETURN 1
end event

event timer;call super::timer;st_msg.Text = ""
st_msg.Visible = FALSE
end event

type cb_print from u_cb within w_scale_skid_bk
string tag = "Print Skid Ticket"
integer x = 1624
integer y = 1664
integer width = 585
integer height = 182
integer taborder = 50
integer textsize = -26
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN Parent.Event ue_print()
end event

type st_msg from statictext within w_scale_skid_bk
integer x = 51
integer y = 1869
integer width = 2977
integer height = 86
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_scale_skid_bk
integer x = 1075
integer y = 656
integer width = 925
integer height = 150
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "NET:"
boolean focusrectangle = false
end type

type em_net from u_em within w_scale_skid_bk
integer x = 1072
integer y = 819
integer width = 1152
integer height = 333
integer taborder = 20
integer textsize = -52
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33554432
string text = "123456"
alignment alignment = center!
boolean displayonly = true
string mask = "#########"
end type

type dw_report from u_dw within w_scale_skid_bk
integer x = 2289
integer y = 1082
integer width = 143
integer height = 61
integer taborder = 0
boolean enabled = false
string dataobject = "d_skid_ticket_new"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.Visible = FALSE
This.SetTransObject(SQLCA)
end event

type sle_input from u_sle within w_scale_skid_bk
integer x = 2227
integer y = 1187
integer width = 574
integer taborder = 10
string facename = "Arial"
end type

event constructor;call super::constructor;this.Visible = FALSE
end event

event modified;call super::modified;String ls_input, ls_pre, ls_pre1
Int li_status, li_row, li_i, li_no_wt_item
Long ll_item_wt
DataStore lds_skid

ls_input = This.Text
this.Text = ""
ls_input = LeftTrim(ls_input)
ls_input = RightTrim(ls_input)
IF Len(ls_input) <= 2 OR ISNULL(ls_input) THEN RETURN 0

ls_pre = Left(ls_input, 2)
ls_pre1 = Left(ls_input,1)

CHOOSE CASE Upper(ls_pre1)
	CASE "S"
		il_skid = Long(Mid(ls_input, 2))
		IF il_skid <= 0 OR IsNULL(il_skid) THEN
			Parent.Event ue_display_message("Warning : Invalid skid ID.")
			Return -1
		END IF
		
		SELECT Count(sheet_skid_num) INTO :li_row
		FROM sheet_skid
		WHERE sheet_skid_num = :il_skid
		USING SQLCA;
		IF li_row = 0 THEN 
			Parent.Event ue_display_message("Warning : Invalid skid ID.")
			RETURN -1
		END IF
		
		SetNULL(li_status)
		SELECT skid_sheet_status, sheet_net_wt, sheet_tare_wt INTO :li_status, :il_net, :il_tare
		FROM sheet_skid
		WHERE sheet_skid_num = :il_skid
		USING SQLCA;
		IF NOT(IsNULL(li_status)) THEN
			em_id.Text = String(il_skid)
			sle_input.Text = ""
			em_gross.Text = ""
			IF li_status = 0 THEN 
				Parent.Event ue_display_message("Warning : This skid has been shipped. Please verify.")
				RETURN -2
			END IF
			IF il_net  = 0 AND il_tare = 0 THEN
				Parent.Event ue_display_message("Warning : No net and tare weight for this skid. Please verify.")
				RETURN -3				
			END IF
			IF il_net > 0 AND il_tare > 0 THEN
				lds_skid = Create DataStore
				lds_skid.DataObject = "d_scale_skid_info"
				lds_skid.SetTransObject(SQLCA)
				lds_skid.Retrieve(il_skid)
				li_row = lds_skid.RowCount()

				IF li_row <= 0 THEN
					Parent.Event ue_display_message("Warning : Invalid skid ID.")
					DESTROY lds_skid
					RETURN -2
				END IF

				li_no_wt_item = 0
				FOR li_i = 1 TO li_row
					ll_item_wt = lds_skid.GetItemNumber(li_i, "production_sheet_item_prod_item_net_wt")
					IF IsNULL(ll_item_wt) OR (ll_item_wt = 0) THEN
						li_no_wt_item++
					END IF
				NEXT
				DESTROY lds_skid

				IF li_no_wt_item = 0 THEN
					Parent.Event ue_display_message("Warning : All items for this skid has been weighted. Please verify.")
					RETURN -3
				END IF
				IF li_no_wt_item > 1 THEN
					Parent.Event ue_display_message("Warning : More than one item on this skid need weight info. Please verify.")
					RETURN -4
				END IF
			END IF
			IF il_tare > 0 THEN
				em_tare.Text = String(il_tare)
				em_net.Text = "-"
			END IF				
			IF il_tare = 0 THEN
				em_tare.Text = "-"
				em_net.Text = String(il_net)
			END IF
			ib_skid_is_valid = TRUE
		END IF
END CHOOSE

CHOOSE CASE Upper(ls_pre)
	CASE "1A" //save
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "SAVE" THEN 
			sle_input.Text = ""
			RETURN Parent.Event pfc_save()
		END IF
	CASE "2A" //next
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "NEXT" THEN 
			sle_input.Text = ""
			RETURN Parent.Event ue_next()
		END IF
	CASE "3A" //exit
		Close(Parent)
	CASE "4A" //read
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "READ" THEN 
			sle_input.Text = ""
			RETURN Parent.Event ue_readscale()
		END IF
	CASE "5A" //print
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "PRINT" THEN 
			sle_input.Text = ""
			RETURN Parent.Event ue_print()
		END IF
END CHOOSE
		
RETURN 1

end event

type em_id from u_em within w_scale_skid_bk
integer x = 29
integer y = 320
integer width = 2194
integer height = 333
integer taborder = 0
integer textsize = -52
string facename = "Arial"
long textcolor = 16711680
long backcolor = 0
string text = "123,456"
alignment alignment = center!
string mask = "#########"
end type

event losefocus;call super::losefocus;il_skid = 0
il_skid = Long(this.Text)
IF il_skid <= 0 THEN RETURN 0

SetNULL(il_tare)
SELECT sheet_tare_wt INTO :il_tare
FROM sheet_skid
where sheet_skid_num = :il_skid
USING SQLCA;

IF il_tare = 0 THEN 
	em_tare.Text = "  "
ELSE
	em_tare.Text = String(il_tare)
END IF


end event

type st_4 from statictext within w_scale_skid_bk
integer x = 29
integer y = 170
integer width = 592
integer height = 141
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SKID ID:"
boolean focusrectangle = false
end type

type p_1 from picture within w_scale_skid_bk
integer x = 2267
integer y = 269
integer width = 750
integer height = 733
string picturename = "scale_skid.JPG"
boolean focusrectangle = false
end type

type pb_scale from u_pb within w_scale_skid_bk
integer x = 2520
integer y = 1286
integer width = 497
integer height = 349
integer taborder = 20
integer textsize = -20
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Read Scale"
boolean cancel = true
boolean originalsize = false
vtextalign vtextalign = multiline!
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN Parent.Event ue_readscale()


end event

type st_3 from statictext within w_scale_skid_bk
integer x = 15
integer y = 10
integer width = 3046
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "---SKID WEIGHT INFORMATION---"
alignment alignment = center!
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_2 from statictext within w_scale_skid_bk
integer x = 29
integer y = 1165
integer width = 1232
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "GROSS WEIGHT:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_scale_skid_bk
integer x = 29
integer y = 662
integer width = 925
integer height = 150
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TARE:"
boolean focusrectangle = false
end type

type em_tare from u_em within w_scale_skid_bk
integer x = 29
integer y = 822
integer width = 973
integer height = 333
integer taborder = 0
integer textsize = -52
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33554432
string text = "123456"
alignment alignment = center!
boolean displayonly = true
string mask = "#########"
end type

type em_gross from u_em within w_scale_skid_bk
integer x = 29
integer y = 1318
integer width = 2450
integer height = 333
integer taborder = 0
integer textsize = -52
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33554432
string text = "123456789"
alignment alignment = center!
string mask = "#########"
end type

type cb_save from u_cb within w_scale_skid_bk
string tag = "Save skid weight info"
integer x = 135
integer y = 1664
integer width = 611
integer height = 182
integer taborder = 30
integer textsize = -26
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN parent.Event pfc_save()
end event

type cb_new from u_cb within w_scale_skid_bk
string tag = "Reset data"
integer x = 892
integer y = 1664
integer width = 585
integer height = 182
integer taborder = 40
integer textsize = -26
string facename = "Arial"
string text = "&Reset"
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN Parent.Event ue_next()

end event

type cb_exit from u_cb within w_scale_skid_bk
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 2355
integer y = 1664
integer width = 585
integer height = 182
integer taborder = 60
integer textsize = -26
string facename = "Arial"
string text = "&EXIT"
end type

event clicked;call super::clicked;Close(Parent)
end event

