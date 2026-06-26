$PBExportHeader$w_display_da_apps.srw
$PBExportComments$display applications of this system used only in shop area
forward
global type w_display_da_apps from w_sheet
end type
type st_7 from statictext within w_display_da_apps
end type
type st_6 from statictext within w_display_da_apps
end type
type st_5 from statictext within w_display_da_apps
end type
type st_4 from statictext within w_display_da_apps
end type
type st_3 from statictext within w_display_da_apps
end type
type st_2 from statictext within w_display_da_apps
end type
type pb_receiving from u_pb within w_display_da_apps
end type
type pb_scheduler from u_pb within w_display_da_apps
end type
type pb_scale from u_pb within w_display_da_apps
end type
type pb_downtime from u_pb within w_display_da_apps
end type
type pb_quality from u_pb within w_display_da_apps
end type
type pb_dashboard from u_pb within w_display_da_apps
end type
type p_2 from picture within w_display_da_apps
end type
type p_3 from picture within w_display_da_apps
end type
type cb_1 from commandbutton within w_display_da_apps
end type
type st_1 from statictext within w_display_da_apps
end type
end forward

global type w_display_da_apps from w_sheet
integer x = 519
integer y = 278
integer width = 3807
integer height = 2374
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
windowtype windowtype = child!
long backcolor = 12632256
boolean toolbarvisible = false
boolean center = true
boolean ib_isupdateable = false
event type string ue_whoami ( )
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
pb_receiving pb_receiving
pb_scheduler pb_scheduler
pb_scale pb_scale
pb_downtime pb_downtime
pb_quality pb_quality
pb_dashboard pb_dashboard
p_2 p_2
p_3 p_3
cb_1 cb_1
st_1 st_1
end type
global w_display_da_apps w_display_da_apps

event type string ue_whoami();RETURN "w_display_app_shop"
end event

on w_display_da_apps.create
int iCurrent
call super::create
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.pb_receiving=create pb_receiving
this.pb_scheduler=create pb_scheduler
this.pb_scale=create pb_scale
this.pb_downtime=create pb_downtime
this.pb_quality=create pb_quality
this.pb_dashboard=create pb_dashboard
this.p_2=create p_2
this.p_3=create p_3
this.cb_1=create cb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_7
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.pb_receiving
this.Control[iCurrent+8]=this.pb_scheduler
this.Control[iCurrent+9]=this.pb_scale
this.Control[iCurrent+10]=this.pb_downtime
this.Control[iCurrent+11]=this.pb_quality
this.Control[iCurrent+12]=this.pb_dashboard
this.Control[iCurrent+13]=this.p_2
this.Control[iCurrent+14]=this.p_3
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.st_1
end on

on w_display_da_apps.destroy
call super::destroy
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.pb_receiving)
destroy(this.pb_scheduler)
destroy(this.pb_scale)
destroy(this.pb_downtime)
destroy(this.pb_quality)
destroy(this.pb_dashboard)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.cb_1)
destroy(this.st_1)
end on

event pfc_postopen;//String ls_login
//Int li_userid, li_group_id, li_temp
//Long ll_row, ll_i, ll_row2, ll_j
//DataStore lds_group_app, lds_user_group, lds_user_app
//Int li_q, li_ore, li_ofe, li_pc, li_sh, li_ir, li_wh, li_ic, li_is, li_sc, li_sr, li_edi,li_pls, li_dp, li_dt, li_ss
//
//ls_login = gnv_app.of_GetUserId()
//li_userid = 0
//
//CONNECT USING SQLCA;
//SELECT user_id INTO :li_userid
//FROM security_user
//WHERE login_id = :ls_login
//USING SQLCA;
//
//IF li_userid < 1 THEN RETURN 
//
//li_q = -1
//li_ore = -1
//li_ofe = -1
//li_pc = -1
//li_sh = -1
//li_ir = -1
//li_wh = -1
//li_ic = -1
//li_is = -1
//li_sc = -1
//li_sr = -1
//li_edi = -1
//li_pls = -1
//li_dp = -1
//li_dt = -1
//li_ss = -1
//
//lds_user_app = CREATE datastore  
//lds_user_app.DataObject = "d_user_app"  
//lds_user_app.SetTransObject (SQLCA)  
//lds_user_app.Retrieve(li_userid)
//ll_row = lds_user_app.RowCount()
//IF ll_row > 0 THEN
//	FOR ll_i = 1 TO ll_row 
//		CHOOSE CASE lds_user_app.GetItemString(ll_i,"security_application_application_name") 
//			CASE "Quotation(Sheet)"
//				li_q = MAX(li_q, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Order Entry"
//				li_ore = MAX(li_ore, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Office Entry"
//				li_ofe = MAX(li_ofe, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Production Control"
//				li_pc = MAX(li_pc, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Scrap Handling"
//				li_sh = MAX(li_sh, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Inventory(ReCap)"
//				li_ir = MAX(li_ir, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Warehouse"
//				li_wh = MAX(li_wh, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Inventory(Coil)"
//				li_ic = MAX(li_ic, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Inventory(Skid)"
//				li_is = MAX(li_is, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Shipment(Control)"
//				li_sc = MAX(li_sc, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Shipment(Receiving)"
//				li_sr = MAX(li_sr, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "EDI"
//				li_edi = MAX(li_edi, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Production Line Schedule"
//				li_pls = MAX(li_pls, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Daily Production"
//				li_dp = MAX(li_dp, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Downtime report"
//				li_dt = MAX(li_dt, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//			CASE "Shift Scheduler"
//				li_ss = MAX(li_dt, lds_user_app.GetItemNumber(ll_i, "security_user_application_user_applicati"))
//		END CHOOSE
//	NEXT
//END IF
//DESTROY lds_user_app
//
//lds_user_group = CREATE datastore  
//lds_user_group.DataObject = "d_user_group"  
//lds_user_group.SetTransObject (SQLCA)  
//lds_user_group.Retrieve(li_userid)
//ll_row = lds_user_group.RowCount()
//
//IF ll_row > 1 THEN 
//	lds_group_app = CREATE datastore  
//	lds_group_app.DataObject = "d_group_app"  
//	lds_group_app.SetTransObject (SQLCA)  
//	FOR ll_i = 1 TO ll_row
//		lds_group_app.Retrieve(lds_user_group.GetItemNumber(ll_i, "user_group_id"))
//		ll_row2 = lds_group_app.RowCount()
//		IF ll_row2 > 0 THEN
//			FOR ll_j = 1 TO ll_row2
//				CHOOSE CASE lds_group_app.GetItemString(ll_j, "security_application_application_name") 
//					CASE "Quotation(Sheet)"
//						li_q = MAX(li_q, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Order Entry"
//						li_ore = MAX(li_ore, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Office Entry"
//						li_ofe = MAX(li_ofe, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Production Control"
//						li_pc = MAX(li_pc, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Scrap Handling"
//						li_sh = MAX(li_sh, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Inventory(ReCap)"
//						li_ir = MAX(li_ir, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Warehouse"
//						li_wh = MAX(li_wh, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Inventory(Coil)"
//						li_ic = MAX(li_ic, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Inventory(Skid)"
//						li_is = MAX(li_is, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Shipment(Control)"
//						li_sc = MAX(li_sc, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Shipment(Receiving)"
//						li_sr = MAX(li_sr, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "EDI"
//						li_edi = MAX(li_edi, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Production Line Schedule"
//						li_pls = MAX(li_pls, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Daily Production"
//						li_dp = MAX(li_dp, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Downtime report"
//						li_dt = MAX(li_dt, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//					CASE "Shift Scheduler"
//						li_ss = MAX(li_dt, lds_group_app.GetItemNumber(ll_j, "security_group_application_group_applica"))
//				END CHOOSE
//			NEXT
//		END IF
//	NEXT
//	DESTROY lds_group_app
//END IF
//
//DESTROY lds_user_group
//
//CHOOSE CASE li_q
//	CASE 0 //Readonly
//		st_sheetpro.Enabled = TRUE
//		st_circlepro.Enabled = TRUE
//	CASE 1 //Write
//		st_sheetpro.Enabled = TRUE
//		st_circlepro.Enabled = TRUE
//	CASE ELSE
//		st_sheetpro.Enabled = FALSE
//		st_sheetpro.Textcolor = RGB(0,0,0)
//		st_circlepro.Enabled = FALSE
//		st_circlepro.Textcolor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_ore
//	CASE 0 //Readonly
//		st_orderentry.Enabled = TRUE
//	CASE 1 //Write
//		st_orderentry.Enabled = TRUE
//	CASE ELSE
//		st_orderentry.Enabled = FALSE
//		st_orderentry.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_ofe
//	CASE 0 //Readonly
//		st_skidentry.Enabled = TRUE
//	CASE 1 //Write
//		st_skidentry.Enabled = TRUE
//	CASE ELSE
//		st_skidentry.Enabled = FALSE
//		st_skidentry.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_pc
//	CASE 0 //Readonly
//		st_production.Enabled = TRUE
//	CASE 1 //Write
//		st_production.Enabled = TRUE
//	CASE ELSE
//		st_production.Enabled = FALSE
//		st_production.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_sh
//	CASE 0 //Readonly
//		st_scrap.Enabled = TRUE
//	CASE 1 //Write
//		st_scrap.Enabled = TRUE
//	CASE ELSE
//		st_scrap.Enabled = FALSE
//		st_scrap.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_ir
//	CASE 0 //Readonly
//		st_recap.Enabled = TRUE
//	CASE 1 //Write
//		st_recap.Enabled = TRUE
//	CASE ELSE
//		st_recap.Enabled = FALSE
//		st_recap.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_wh
//	CASE 0 //Readonly
//		st_warehouse.Enabled = TRUE
//	CASE 1 //Write
//		st_warehouse.Enabled = TRUE
//	CASE ELSE
//		st_warehouse.Enabled = FALSE
//		st_warehouse.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_ic
//	CASE 0 //Readonly
//		st_coil.Enabled = TRUE
//	CASE 1 //Write
//		st_coil.Enabled = TRUE
//	CASE ELSE
//		st_coil.Enabled = FALSE
//		st_coil.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_is
//	CASE 0 //Readonly
//		st_skid.Enabled = TRUE
//	CASE 1 //Write
//		st_skid.Enabled = TRUE
//	CASE ELSE
//		st_skid.Enabled = FALSE
//		st_skid.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_sc
//	CASE 0 //Readonly
//		st_shipping.Enabled = TRUE
//	CASE 1 //Write
//		st_shipping.Enabled = TRUE
//	CASE ELSE
//		st_shipping.Enabled = FALSE
//		st_shipping.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_sr
//	CASE 0 //Readonly
//		st_receiving.Enabled = TRUE
//	CASE 1 //Write
//		st_receiving.Enabled = TRUE
//	CASE ELSE
//		st_receiving.Enabled = FALSE
//		st_receiving.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_edi
//	CASE 0 //Readonly
//		st_edi.Enabled = TRUE
//	CASE 1 //Write
//		st_edi.Enabled = TRUE
//	CASE ELSE
//		st_edi.Enabled = FALSE
//		st_edi.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_pls
//	CASE 0 //Readonly
//		st_schedule.Enabled = TRUE
//	CASE 1 //Write
//		st_schedule.Enabled = TRUE
//	CASE ELSE
//		st_schedule.Enabled = FALSE
//		st_schedule.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_dp
//	CASE 0 //Readonly
//		st_dailyprod.Enabled = TRUE
//	CASE 1 //Write
//		st_dailyprod.Enabled = TRUE
//	CASE ELSE
//		st_dailyprod.Enabled = FALSE
//		st_dailyprod.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_dt
//	CASE 0 //Readonly
//		st_downtime.Enabled = TRUE
//	CASE 1 //Write
//		st_downtime.Enabled = TRUE
//	CASE ELSE
//		st_downtime.Enabled = FALSE
//		st_downtime.TextColor = RGB(0,0,0)
//END CHOOSE
//
//CHOOSE CASE li_ss
//	CASE 0 //Readonly
//		st_shiftschedule.Enabled = TRUE
//	CASE 1 //Write
//		st_shiftschedule.Enabled = TRUE
//	CASE ELSE
//		st_shiftschedule.Enabled = FALSE
//		st_shiftschedule.TextColor = RGB(0,0,0)
//END CHOOSE
end event

type st_7 from statictext within w_display_da_apps
integer x = 2282
integer y = 1754
integer width = 775
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "110 Line Stacker read only"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_display_da_apps
integer x = 1638
integer y = 1754
integer width = 490
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "110 Line Stacker"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_display_da_apps
integer x = 922
integer y = 1754
integer width = 402
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Scale"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_display_da_apps
integer x = 2472
integer y = 1165
integer width = 402
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "DAS realtime"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_display_da_apps
integer x = 1653
integer y = 1165
integer width = 512
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dimension Check"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_display_da_apps
integer x = 922
integer y = 1165
integer width = 402
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "DAS offline"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_receiving from u_pb within w_display_da_apps
integer x = 2414
integer y = 1382
integer width = 541
integer height = 371
integer taborder = 60
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Receiving.gif"
end type

event clicked;call super::clicked;//IF this.Enabled THEN
//	Message.StringParm = "w_110_stacker_read_only" 
//	gnv_app.of_getframe( ).postevent( "pfc_open")
//END IF
end event

type pb_scheduler from u_pb within w_display_da_apps
integer x = 1624
integer y = 1382
integer width = 541
integer height = 371
integer taborder = 50
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "scheduler.jpg"
end type

event clicked;call super::clicked;IF this.Enabled THEN
	Message.StringParm = "w_da_sheet_110_stacker" 
	gnv_app.of_getframe( ).postevent( "pfc_open")
END IF
end event

type pb_scale from u_pb within w_display_da_apps
integer x = 848
integer y = 1382
integer width = 541
integer height = 371
integer taborder = 40
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Scale.gif"
end type

event clicked;call super::clicked;//IF this.Enabled THEN
//	Message.StringParm = "w_da_sheet_110_stacker" 
//	w_lion_sys_frame.Event pfc_Open()
//END IF
end event

type pb_downtime from u_pb within w_display_da_apps
integer x = 2414
integer y = 794
integer width = 541
integer height = 371
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "downtime.gif"
end type

event clicked;call super::clicked;message.stringparm = "w_da_sheet"
gnv_app.of_getframe( ).postevent( "pfc_open")
end event

type pb_quality from u_pb within w_display_da_apps
integer x = 1638
integer y = 794
integer width = 541
integer height = 371
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Quality.gif"
end type

event clicked;call super::clicked;message.stringparm = "w_qc_sheet"
gnv_app.of_getframe( ).postevent( "pfc_open")
end event

type pb_dashboard from u_pb within w_display_da_apps
integer x = 848
integer y = 794
integer width = 541
integer height = 371
integer taborder = 10
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Dashboard.gif"
end type

event clicked;call super::clicked;//message.stringparm = "w_da_offline_sheet"
//gnv_app.of_getframe( ).postevent( "pfc_open")
end event

type p_2 from picture within w_display_da_apps
integer x = 497
integer y = 294
integer width = 168
integer height = 141
boolean bringtotop = true
string picturename = "ABC1.jpg"
boolean focusrectangle = false
end type

type p_3 from picture within w_display_da_apps
integer x = 2940
integer y = 294
integer width = 168
integer height = 138
boolean bringtotop = true
string picturename = "ABC1.jpg"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_display_da_apps
integer x = 1624
integer y = 1971
integer width = 541
integer height = 115
integer taborder = 70
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit"
end type

event clicked;//close(parent)
HALT close
end event

type st_1 from statictext within w_display_da_apps
integer x = 805
integer y = 320
integer width = 1931
integer height = 77
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "ALUMINUM BLANKING COMPANY, INC."
alignment alignment = center!
boolean focusrectangle = false
end type

