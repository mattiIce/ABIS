$PBExportHeader$w_scale_scrap.srw
$PBExportComments$<Child> scrap weight information retrieving from scale
forward
global type w_scale_scrap from w_child
end type
type p_1 from picture within w_scale_scrap
end type
type sle_input from u_sle within w_scale_scrap
end type
type em_id from u_em within w_scale_scrap
end type
type st_4 from statictext within w_scale_scrap
end type
type pb_scale from u_pb within w_scale_scrap
end type
type st_3 from statictext within w_scale_scrap
end type
type st_2 from statictext within w_scale_scrap
end type
type st_1 from statictext within w_scale_scrap
end type
type em_tare from u_em within w_scale_scrap
end type
type em_gross from u_em within w_scale_scrap
end type
type cb_save from u_cb within w_scale_scrap
end type
type cb_new from u_cb within w_scale_scrap
end type
type cb_exit from u_cb within w_scale_scrap
end type
end forward

global type w_scale_scrap from w_child
string tag = "Scrap weight"
integer x = 878
integer y = 486
integer width = 2542
integer height = 1802
string title = "SCRAP WEIGHT"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type long ue_next ( )
event type long ue_readscale ( )
p_1 p_1
sle_input sle_input
em_id em_id
st_4 st_4
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
global w_scale_scrap w_scale_scrap

type variables
Long il_skid, il_tare, il_gross
Boolean ib_saved, ib_simulate_mode
end variables

event type long ue_next();IF NOT(ib_saved) THEN
	IF MessageBox("Question","Discard current data andlLoading a new skid?", Question!, YesNO!, 2) = 2 THEN RETURN 0
END IF
em_id.Text = '  '
em_tare.Text='0'
em_gross.Text='0'
SetNULL(il_skid)
SetNULL(il_tare)
SetNULL(il_gross)
ib_saved = FALSE
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

sle_input.SetFocus()

RETURN 1
end event

on w_scale_scrap.create
int iCurrent
call super::create
this.p_1=create p_1
this.sle_input=create sle_input
this.em_id=create em_id
this.st_4=create st_4
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
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.sle_input
this.Control[iCurrent+3]=this.em_id
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.pb_scale
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_tare
this.Control[iCurrent+10]=this.em_gross
this.Control[iCurrent+11]=this.cb_save
this.Control[iCurrent+12]=this.cb_new
this.Control[iCurrent+13]=this.cb_exit
end on

on w_scale_scrap.destroy
call super::destroy
destroy(this.p_1)
destroy(this.sle_input)
destroy(this.em_id)
destroy(this.st_4)
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
ib_saved = FALSE

String ls_inifile, ls_simulate

ls_inifile = gnv_app.of_getappinifile( )
ls_simulate = ProfileString(ls_inifile,"SCALE","Scale_mode","simulate")
IF Upper(Trim(ls_simulate)) = "REAL" THEN
	ib_simulate_mode = FALSE
ELSE
	ib_simulate_mode = TRUE
END IF
end event

event pfc_save;call super::pfc_save;Long ll_skid, ll_other_items_wt, ll_item_wt, ll_no_wt_item_id, ll_current_item_wt, ll_current_skid_wt
Int li_row, li_i, li_no_wt_item
DataStore lds_skid

sle_input.SetFocus()

ll_skid = Long(em_id.Text)
IF ll_skid <= 1 THEN
	MessageBox("Warning", "Invalid scrap skid ID.")
	RETURN -1
END IF

il_gross = Long(em_gross.Text)
IF il_gross <= 0 THEN
	MessageBox("Warning", "Invalid scrap gross WT.")
	RETURN -1
END IF

il_tare = Long(em_tare.Text)
IF il_tare <= 0 THEN
	MessageBox("Warning", "Invalid tare weight.")
	RETURN -1
END IF

lds_skid = Create DataStore
lds_skid.DataObject = "d_scale_scrap_info"
lds_skid.SetTransObject(SQLCA)
lds_skid.Retrieve(ll_skid)
li_row = lds_skid.RowCount()

IF li_row <= 0 THEN
	MessageBox("Warning", "Invalid skid ID.")
	DESTROY lds_skid
	RETURN -2
END IF

ll_other_items_wt = 0
li_no_wt_item = 0
FOR li_i = 1 TO li_row
	ll_item_wt = lds_skid.GetItemNumber(li_i, "return_scrap_item_return_item_net_wt")
	IF IsNULL(ll_item_wt) OR (ll_item_wt = 0) THEN
		ll_item_wt = 0
		li_no_wt_item++
		ll_no_wt_item_id = lds_skid.GetItemNumber(li_i, "return_scrap_item_return_scrap_item_num")
	END IF
	ll_other_items_wt = ll_other_items_wt + ll_item_wt
NEXT
DESTROY lds_skid

IF li_no_wt_item = 0 THEN
	MessageBox("Warning", "All items for this scrap skid has been weighted. Please verify the skid ID.")
	RETURN -3
END IF
IF li_no_wt_item > 1 THEN
	MessageBox("Warning", "There are more than one item on this skid needs weight info. Please verify the skid ID.")
	RETURN -4
END IF
ll_current_skid_wt = il_gross - il_tare 
ll_current_item_wt = ll_current_skid_wt - ll_other_items_wt
IF ll_current_skid_wt <= 0 THEN
	MessageBox("Warning", "Invalid current skid net weight.")
	RETURN -5
END IF
IF ll_current_item_wt <= 0 THEN
	MessageBox("Warning", "Invalid tare or gross wt.")
	RETURN -6
END IF

UPDATE scrap_skid
SET scrap_net_wt = :ll_current_skid_wt
WHERE scrap_skid_num = :ll_skid
USING SQLCA;
IF SQLCA.SQLCode >= 0 THEN
	//COMMIT USING SQLCA;
ELSE
	MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
	Rollback using SQLCA;
END IF

UPDATE return_scrap_item
SET return_item_net_wt = :ll_current_item_wt
WHERE return_scrap_item_num = :ll_no_wt_item_id
USING SQLCA;
IF SQLCA.SQLCode >= 0 THEN
	//COMMIT USING SQLCA;
ELSE
	MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
	Rollback using SQLCA;
END IF
COMMIT USING SQLCA;

ib_saved = TRUE

RETURN 1
end event

type p_1 from picture within w_scale_scrap
integer x = 1763
integer y = 189
integer width = 658
integer height = 832
string picturename = "scale_scrap.JPG"
boolean focusrectangle = false
end type

type sle_input from u_sle within w_scale_scrap
integer x = 1211
integer y = 195
integer taborder = 10
string facename = "Arial"
end type

event constructor;call super::constructor;this.Visible = FALSE
end event

event modified;call super::modified;String ls_input, ls_pre
Int li_status

ls_input = This.Text
This.Text = ""
ls_input = LeftTrim(ls_input)
ls_input = RightTrim(ls_input)
IF Len(ls_input) <= 2 OR ISNULL(ls_input) THEN RETURN 0

ls_pre = Left(ls_input, 2)

CHOOSE CASE Upper(ls_pre)
	CASE "3S"
		il_skid = Long(Mid(ls_input, 3))
		IF il_skid <= 0 OR IsNULL(il_skid) THEN
			MessageBox("Warning", "Invalid skid ID.")
			Return -1
		END IF
		SetNULL(li_status)
		SELECT skid_scrap_status, scrap_tare_wt INTO :li_status, :il_tare
		FROM scrap_skid
		WHERE scrap_skid_num = :il_skid
		USING SQLCA;
		IF NOT(IsNULL(li_status)) THEN
			em_id.Text = String(il_skid)
			sle_input.Text = ""
			em_gross.Text = ""
			IF li_status = 0 THEN 
				MessageBox("Warning", "This skid has been shipped. Please verify.")
				RETURN -2
			END IF
			em_tare.Text = String(il_tare)		
		END IF
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
END CHOOSE
		
RETURN 1

end event

type em_id from u_em within w_scale_scrap
integer x = 22
integer y = 326
integer width = 1657
integer height = 285
integer taborder = 10
integer textsize = -48
string facename = "Arial"
long textcolor = 128
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

IF IsNULL(il_tare) THEN 
	em_tare.Text = "  "
ELSE
	em_tare.Text = String(il_tare)
END IF


end event

type st_4 from statictext within w_scale_scrap
integer x = 22
integer y = 189
integer width = 1145
integer height = 138
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SCRAP SKID ID:"
boolean focusrectangle = false
end type

type pb_scale from u_pb within w_scale_scrap
integer x = 2026
integer y = 1162
integer width = 453
integer height = 307
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

type st_3 from statictext within w_scale_scrap
integer x = 15
integer y = 10
integer width = 2509
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "---SCRAP WEIGHT INFORMATION---"
alignment alignment = center!
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_2 from statictext within w_scale_scrap
integer x = 22
integer y = 1046
integer width = 1781
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SCRAP GROSS WEIGHT:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_scale_scrap
integer x = 22
integer y = 611
integer width = 1093
integer height = 150
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TARE WEIGHT:"
boolean focusrectangle = false
end type

type em_tare from u_em within w_scale_scrap
integer x = 22
integer y = 762
integer width = 1649
integer height = 285
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

type em_gross from u_em within w_scale_scrap
integer x = 22
integer y = 1190
integer width = 1986
integer height = 285
integer taborder = 0
integer textsize = -52
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33554432
string text = "123456789"
alignment alignment = center!
string mask = "#########"
end type

type cb_save from u_cb within w_scale_scrap
string tag = "Save skid weight info"
integer x = 179
integer y = 1494
integer width = 611
integer height = 182
integer taborder = 30
integer textsize = -26
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;sle_input.SetFocus()
sle_input.Text = ""

RETURN parent.Event pfc_save()
end event

type cb_new from u_cb within w_scale_scrap
string tag = "Next Skid"
integer x = 976
integer y = 1494
integer width = 585
integer height = 182
integer taborder = 40
integer textsize = -26
string facename = "Arial"
string text = "&Next"
end type

event clicked;call super::clicked;sle_input.SetFocus()
sle_input.Text = ""

RETURN Parent.Event ue_next()

end event

type cb_exit from u_cb within w_scale_scrap
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 1748
integer y = 1494
integer width = 585
integer height = 182
integer taborder = 50
integer textsize = -26
string facename = "Arial"
string text = "&EXIT"
end type

event clicked;call super::clicked;Close(Parent)
end event

