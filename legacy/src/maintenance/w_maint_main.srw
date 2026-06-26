$PBExportHeader$w_maint_main.srw
$PBExportComments$<main>main maintenance application, inherited from  pfemain.pbl
forward
global type w_maint_main from w_sheet
end type
type cb_main from u_cb within w_maint_main
end type
type cb_perf from u_cb within w_maint_main
end type
type cb_today from u_cb within w_maint_main
end type
type cb_parts from u_cb within w_maint_main
end type
type cb_log from u_cb within w_maint_main
end type
type cb_pm from u_cb within w_maint_main
end type
type cb_s_today from u_cb within w_maint_main
end type
type cb_s_logs from u_cb within w_maint_main
end type
type cb_shop from u_cb within w_maint_main
end type
type cb_office from u_cb within w_maint_main
end type
type cb_close from u_cb within w_maint_main
end type
type ln_1 from line within w_maint_main
end type
type ln_2 from line within w_maint_main
end type
type ln_3 from line within w_maint_main
end type
type ln_4 from line within w_maint_main
end type
type ln_5 from line within w_maint_main
end type
type ln_6 from line within w_maint_main
end type
type ln_7 from line within w_maint_main
end type
type ln_8 from line within w_maint_main
end type
type ln_9 from line within w_maint_main
end type
type ln_10 from line within w_maint_main
end type
type ln_11 from line within w_maint_main
end type
end forward

global type w_maint_main from w_sheet
integer x = 4
integer y = 3
integer width = 3427
integer height = 1552
string title = "Maintenance"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 15780518
event type string ue_whoami ( )
event ue_read_only ( )
cb_main cb_main
cb_perf cb_perf
cb_today cb_today
cb_parts cb_parts
cb_log cb_log
cb_pm cb_pm
cb_s_today cb_s_today
cb_s_logs cb_s_logs
cb_shop cb_shop
cb_office cb_office
cb_close cb_close
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_7 ln_7
ln_8 ln_8
ln_9 ln_9
ln_10 ln_10
ln_11 ln_11
end type
global w_maint_main w_maint_main

type variables
integer ii_contact_new_flag
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_main"
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

on w_maint_main.create
int iCurrent
call super::create
this.cb_main=create cb_main
this.cb_perf=create cb_perf
this.cb_today=create cb_today
this.cb_parts=create cb_parts
this.cb_log=create cb_log
this.cb_pm=create cb_pm
this.cb_s_today=create cb_s_today
this.cb_s_logs=create cb_s_logs
this.cb_shop=create cb_shop
this.cb_office=create cb_office
this.cb_close=create cb_close
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_7=create ln_7
this.ln_8=create ln_8
this.ln_9=create ln_9
this.ln_10=create ln_10
this.ln_11=create ln_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_main
this.Control[iCurrent+2]=this.cb_perf
this.Control[iCurrent+3]=this.cb_today
this.Control[iCurrent+4]=this.cb_parts
this.Control[iCurrent+5]=this.cb_log
this.Control[iCurrent+6]=this.cb_pm
this.Control[iCurrent+7]=this.cb_s_today
this.Control[iCurrent+8]=this.cb_s_logs
this.Control[iCurrent+9]=this.cb_shop
this.Control[iCurrent+10]=this.cb_office
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.ln_1
this.Control[iCurrent+13]=this.ln_2
this.Control[iCurrent+14]=this.ln_3
this.Control[iCurrent+15]=this.ln_4
this.Control[iCurrent+16]=this.ln_5
this.Control[iCurrent+17]=this.ln_6
this.Control[iCurrent+18]=this.ln_7
this.Control[iCurrent+19]=this.ln_8
this.Control[iCurrent+20]=this.ln_9
this.Control[iCurrent+21]=this.ln_10
this.Control[iCurrent+22]=this.ln_11
end on

on w_maint_main.destroy
call super::destroy
destroy(this.cb_main)
destroy(this.cb_perf)
destroy(this.cb_today)
destroy(this.cb_parts)
destroy(this.cb_log)
destroy(this.cb_pm)
destroy(this.cb_s_today)
destroy(this.cb_s_logs)
destroy(this.cb_shop)
destroy(this.cb_office)
destroy(this.cb_close)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_7)
destroy(this.ln_8)
destroy(this.ln_9)
destroy(this.ln_10)
destroy(this.ln_11)
end on

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Maintenance") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event open;call super::open;this.Width = 3420
this.Height = 750

ln_1.Visible = FALSE
ln_2.Visible = FALSE
ln_3.Visible = FALSE
ln_4.Visible = FALSE

ln_5.Visible = FALSE
ln_6.Visible = FALSE
ln_7.Visible = FALSE
ln_8.Visible = FALSE
ln_9.Visible = FALSE
ln_10.Visible = FALSE
ln_11.Visible = FALSE

cb_s_logs.Visible = FALSE
cb_s_today.Visible = FALSE

cb_main.Visible = FALSE
cb_pm.Visible = FALSE
cb_log.Visible = FALSE
cb_perf.Visible = FALSE
cb_parts.Visible = FALSE
cb_today.Visible = FALSE
end event

type cb_main from u_cb within w_maint_main
integer x = 121
integer y = 746
integer width = 1009
integer height = 256
integer taborder = 70
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Maintenance Main"
end type

type cb_perf from u_cb within w_maint_main
integer x = 1236
integer y = 1094
integer width = 1009
integer height = 256
integer taborder = 60
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Perference"
end type

type cb_today from u_cb within w_maint_main
integer x = 2352
integer y = 1094
integer width = 1009
integer height = 256
integer taborder = 50
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Today~'s Tasks"
end type

type cb_parts from u_cb within w_maint_main
integer x = 2352
integer y = 746
integer width = 1009
integer height = 256
integer taborder = 50
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Parts"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_parts" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_log from u_cb within w_maint_main
integer x = 1236
integer y = 746
integer width = 1009
integer height = 256
integer taborder = 40
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Maintenance Requests && Log"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_logs_management" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_pm from u_cb within w_maint_main
integer x = 121
integer y = 1094
integer width = 1009
integer height = 256
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Preventive Maintenance"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_pm_management" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_s_today from u_cb within w_maint_main
integer x = 1880
integer y = 829
integer width = 998
integer height = 602
integer taborder = 40
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Today~'s Tasks"
end type

type cb_s_logs from u_cb within w_maint_main
integer x = 501
integer y = 829
integer width = 998
integer height = 602
integer taborder = 30
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Maintenance Requests && Log"
end type

event clicked;call super::clicked;Close(parent)

SetPointer(HourGlass!)
Message.StringParm = "w_maint_logs_management" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_shop from u_cb within w_maint_main
integer x = 1203
integer y = 35
integer width = 998
integer height = 602
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Shop Applications"
end type

event clicked;call super::clicked;Parent.Height = 1550

ln_1.Visible = TRUE
ln_2.Visible = TRUE
ln_3.Visible = TRUE
ln_4.Visible = TRUE

ln_5.Visible = FALSE
ln_6.Visible = FALSE
ln_7.Visible = FALSE
ln_8.Visible = FALSE
ln_9.Visible = FALSE
ln_10.Visible = FALSE
ln_11.Visible = FALSE

cb_s_logs.Visible = TRUE
cb_s_today.Visible = TRUE

cb_main.Visible = FALSE
cb_pm.Visible = FALSE
cb_log.Visible = FALSE
cb_perf.Visible = FALSE
cb_parts.Visible = FALSE
cb_today.Visible = FALSE

end event

type cb_office from u_cb within w_maint_main
integer x = 37
integer y = 35
integer width = 998
integer height = 602
integer taborder = 10
integer textsize = -10
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Office Applications"
end type

event clicked;call super::clicked;Parent.Height = 1550

ln_1.Visible = FALSE
ln_2.Visible = FALSE
ln_3.Visible = FALSE
ln_4.Visible = FALSE

ln_5.Visible = TRUE
ln_6.Visible = TRUE
ln_7.Visible = TRUE
ln_8.Visible = TRUE
ln_9.Visible = TRUE
ln_10.Visible = TRUE
ln_11.Visible = TRUE

cb_s_logs.Visible = FALSE
cb_s_today.Visible = FALSE

cb_main.Visible = TRUE
cb_pm.Visible = TRUE
cb_log.Visible = TRUE
cb_perf.Visible = TRUE
cb_parts.Visible = TRUE
cb_today.Visible = TRUE

end event

type cb_close from u_cb within w_maint_main
string tag = "Exit"
integer x = 2370
integer y = 35
integer width = 998
integer height = 602
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean italic = true
boolean underline = true
string text = "Close"
end type

event clicked;call super::clicked;Close(parent)
end event

type ln_1 from line within w_maint_main
long linecolor = 16711680
integer linethickness = 11
integer beginx = 1664
integer beginy = 637
integer endx = 1664
integer endy = 730
end type

type ln_2 from line within w_maint_main
long linecolor = 16711680
integer linethickness = 11
integer beginx = 1039
integer beginy = 726
integer endx = 2308
integer endy = 726
end type

type ln_3 from line within w_maint_main
long linecolor = 16711680
integer linethickness = 11
integer beginx = 1042
integer beginy = 736
integer endx = 1042
integer endy = 829
end type

type ln_4 from line within w_maint_main
long linecolor = 16711680
integer linethickness = 11
integer beginx = 2311
integer beginy = 733
integer endx = 2311
integer endy = 826
end type

type ln_5 from line within w_maint_main
long linecolor = 128
integer linethickness = 3
integer beginx = 55
integer beginy = 586
integer endx = 55
integer endy = 1187
end type

type ln_6 from line within w_maint_main
long linecolor = 128
integer linethickness = 3
integer beginx = 66
integer beginy = 893
integer endx = 176
integer endy = 893
end type

type ln_7 from line within w_maint_main
long linecolor = 128
integer linethickness = 3
integer beginx = 62
integer beginy = 1184
integer endx = 172
integer endy = 1184
end type

type ln_8 from line within w_maint_main
long linecolor = 128
integer linethickness = 3
integer beginx = 1141
integer beginy = 1206
integer endx = 1251
integer endy = 1206
end type

type ln_9 from line within w_maint_main
long linecolor = 128
integer linethickness = 3
integer beginx = 2249
integer beginy = 1197
integer endx = 2359
integer endy = 1197
end type

type ln_10 from line within w_maint_main
long linecolor = 128
integer linethickness = 3
integer beginx = 1130
integer beginy = 870
integer endx = 1240
integer endy = 870
end type

type ln_11 from line within w_maint_main
long linecolor = 128
integer linethickness = 3
integer beginx = 2245
integer beginy = 880
integer endx = 2355
integer endy = 880
end type

