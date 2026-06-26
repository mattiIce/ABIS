$PBExportHeader$w_load_skid_offline.srw
$PBExportComments$<Response>loading a new skid inherited from pfemain/w_sheet
forward
global type w_load_skid_offline from w_sheet
end type
type dw_p2 from u_dw within w_load_skid_offline
end type
type dw_p1 from u_dw within w_load_skid_offline
end type
type rb_new from u_rb within w_load_skid_offline
end type
type st_result from statictext within w_load_skid_offline
end type
type ddlb_partial from u_ddlb within w_load_skid_offline
end type
type st_6 from statictext within w_load_skid_offline
end type
type st_job from statictext within w_load_skid_offline
end type
type st_5 from statictext within w_load_skid_offline
end type
type st_4 from statictext within w_load_skid_offline
end type
type em_wt from u_em within w_load_skid_offline
end type
type st_3 from statictext within w_load_skid_offline
end type
type rb_partial from u_rb within w_load_skid_offline
end type
type st_abc_id from statictext within w_load_skid_offline
end type
type st_org_id from statictext within w_load_skid_offline
end type
type st_2 from statictext within w_load_skid_offline
end type
type st_1 from statictext within w_load_skid_offline
end type
type cb_save from u_cb within w_load_skid_offline
end type
type cb_close from u_cb within w_load_skid_offline
end type
type gb_select from u_gb within w_load_skid_offline
end type
end forward

global type w_load_skid_offline from w_sheet
integer x = 318
integer y = 144
integer width = 2194
integer height = 1341
string title = "Load a skid"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_p2 dw_p2
dw_p1 dw_p1
rb_new rb_new
st_result st_result
ddlb_partial ddlb_partial
st_6 st_6
st_job st_job
st_5 st_5
st_4 st_4
em_wt em_wt
st_3 st_3
rb_partial rb_partial
st_abc_id st_abc_id
st_org_id st_org_id
st_2 st_2
st_1 st_1
cb_save cb_save
cb_close cb_close
gb_select gb_select
end type
global w_load_skid_offline w_load_skid_offline

type variables
Long il_coil, il_tare, il_job, il_skid
end variables

on w_load_skid_offline.create
int iCurrent
call super::create
this.dw_p2=create dw_p2
this.dw_p1=create dw_p1
this.rb_new=create rb_new
this.st_result=create st_result
this.ddlb_partial=create ddlb_partial
this.st_6=create st_6
this.st_job=create st_job
this.st_5=create st_5
this.st_4=create st_4
this.em_wt=create em_wt
this.st_3=create st_3
this.rb_partial=create rb_partial
this.st_abc_id=create st_abc_id
this.st_org_id=create st_org_id
this.st_2=create st_2
this.st_1=create st_1
this.cb_save=create cb_save
this.cb_close=create cb_close
this.gb_select=create gb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_p2
this.Control[iCurrent+2]=this.dw_p1
this.Control[iCurrent+3]=this.rb_new
this.Control[iCurrent+4]=this.st_result
this.Control[iCurrent+5]=this.ddlb_partial
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_job
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.em_wt
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.rb_partial
this.Control[iCurrent+13]=this.st_abc_id
this.Control[iCurrent+14]=this.st_org_id
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.cb_save
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.gb_select
end on

on w_load_skid_offline.destroy
call super::destroy
destroy(this.dw_p2)
destroy(this.dw_p1)
destroy(this.rb_new)
destroy(this.st_result)
destroy(this.ddlb_partial)
destroy(this.st_6)
destroy(this.st_job)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.em_wt)
destroy(this.st_3)
destroy(this.rb_partial)
destroy(this.st_abc_id)
destroy(this.st_org_id)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.gb_select)
end on

event open;call super::open;String ls_coil_id
Long ll_row, ll_i
s_job_and_coil lstr_t

dw_p1.Visible = FALSE
dw_p2.Visible = FALSE

lstr_t = message.PowerObjectParm
il_coil = lstr_t.coil_num
il_job = lstr_t.job_num

il_skid = 0
il_tare = 0

SELECT coil_org_num INTO :ls_coil_id
FROM Coil 
WHERE coil_abc_num = :il_coil
USING SQLCA;

st_org_id.Text = ls_coil_id
st_abc_id.Text = String(il_coil)
st_job.Text = String(il_job)

dw_p1.Retrieve(il_job)
dw_p2.Retrieve(il_job)

ll_row = dw_p1.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_partial.AddItem(String(dw_p1.GetItemNumber(ll_i, "sheet_skid_num")))
	NEXT
END IF
ll_row = dw_p2.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_partial.AddItem(String(dw_p2.GetItemNumber(ll_i, "sheet_skid_num")))
	NEXT
END IF

ddlb_partial.SelectItem(1)



end event

type dw_p2 from u_dw within w_load_skid_offline
integer x = 1766
integer y = 1162
integer width = 183
integer height = 67
integer taborder = 60
string dataobject = "d_ab_job_current_partial_offline"
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 
this.SetTransObject(SQLCA)
end event

type dw_p1 from u_dw within w_load_skid_offline
integer x = 1971
integer y = 1158
integer width = 183
integer height = 67
integer taborder = 50
string dataobject = "d_ab_job_process_partial_offline"
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 
this.SetTransObject(SQLCA)
end event

type rb_new from u_rb within w_load_skid_offline
integer x = 124
integer y = 794
integer textsize = -12
string facename = "Arial"
string text = "New"
boolean checked = true
end type

event clicked;call super::clicked;IF this.Checked THEN
	em_wt.Enabled = TRUE
	em_wt.Text = ""
	ddlb_partial.Enabled = FALSE
END IF
st_result.Text = "Loading new skid"
end event

type st_result from statictext within w_load_skid_offline
integer x = 44
integer y = 944
integer width = 2096
integer height = 182
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
boolean focusrectangle = false
end type

type ddlb_partial from u_ddlb within w_load_skid_offline
integer x = 1342
integer y = 509
integer width = 713
integer height = 362
integer taborder = 20
integer textsize = -12
string facename = "Arial"
end type

event selectionchanged;call super::selectionchanged;String ls_text
Long ll_row, ll_i, ll_pc, ll_tare, ll_job, ll_net

ls_text = Text(index)
il_skid = Long(ls_text)

ll_row = dw_p1.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_p1.GetItemNumber(ll_i, "sheet_skid_num") = il_skid THEN
		ll_pc = dw_p1.GetItemNumber(ll_i, "partial_skid_pieces") 
		ll_tare = dw_p1.GetItemNumber(ll_i, "sheet_skid_sheet_tare_wt")
		ll_job = dw_p1.GetItemNumber(ll_i, "partial_skid_ab_job_num")
		ll_net = dw_p1.GetItemNumber(ll_i, "partial_sheet_net_wt")
	END IF
NEXT
ll_row = dw_p2.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_p2.GetItemNumber(ll_i, "sheet_skid_num") = il_skid THEN
		ll_pc = dw_p2.GetItemNumber(ll_i, "skid_pieces") 
		ll_tare = dw_p2.GetItemNumber(ll_i, "sheet_tare_wt")
		ll_job = dw_p2.GetItemNumber(ll_i, "ab_job_num")
		ll_net = dw_p2.GetItemNumber(ll_i, "sheet_net_wt")
	END IF
NEXT
st_result.Text = "Loading skid " + String(il_skid) + " created in job " + string(ll_job) + ". Tare WT:" + String(ll_tare) + " Net WT:" + String(ll_net) + " Pieces:" + String(ll_pc) 

end event

type st_6 from statictext within w_load_skid_offline
integer x = 640
integer y = 506
integer width = 669
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Select a partial skid:"
boolean focusrectangle = false
end type

type st_job from statictext within w_load_skid_offline
integer x = 965
integer y = 250
integer width = 1214
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_load_skid_offline
integer x = 18
integer y = 250
integer width = 706
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Current Job:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_load_skid_offline
integer x = 691
integer y = 787
integer width = 486
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Tare Weight:"
boolean focusrectangle = false
end type

type em_wt from u_em within w_load_skid_offline
integer x = 1254
integer y = 771
integer width = 801
integer height = 109
integer taborder = 40
integer textsize = -12
string facename = "Arial"
boolean enabled = false
string mask = "#########"
end type

event modified;call super::modified;IF rb_new.Checked THEN 
	st_result.Text = "Loading new skid. Tare WT: " + this.Text
	il_tare = Long(this.Text)
END IF

end event

type st_3 from statictext within w_load_skid_offline
integer x = 578
integer y = 643
integer width = 1093
integer height = 61
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "----------  OR ----------"
boolean focusrectangle = false
end type

type rb_partial from u_rb within w_load_skid_offline
integer x = 124
integer y = 509
integer textsize = -12
string facename = "Arial"
string text = "Partial"
end type

event clicked;call super::clicked;IF this.Checked THEN
	em_wt.Enabled = FALSE
	ddlb_partial.Enabled = TRUE
END IF
	
end event

type st_abc_id from statictext within w_load_skid_offline
integer x = 965
integer y = 131
integer width = 1214
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_org_id from statictext within w_load_skid_offline
integer x = 965
integer y = 13
integer width = 1207
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_load_skid_offline
integer x = 18
integer y = 131
integer width = 955
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coil ABCO Number:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_load_skid_offline
integer x = 18
integer y = 13
integer width = 925
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coil Original Number:"
boolean focusrectangle = false
end type

type cb_save from u_cb within w_load_skid_offline
integer x = 600
integer y = 1139
integer width = 351
integer height = 102
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;SetPointer(HourGlass!)

DateTime ldt_t
Long ll_item, ll_order, ll_orderitem

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num

SELECT order_abc_num, order_item_num INTO :ll_order, :ll_orderitem
FROM ab_job
WHERE ab_job_num = :il_job
USING SQLCA;

ldt_t = DateTime(Today(),Now())
ll_item = f_get_next_value("prod_item_num_seq")

IF rb_partial.Checked THEN
	IF il_skid = 0 THEN
		MessageBox("Warning", "Please select a partial skid first.")
		RETURN -2
	END IF
	
	UPDATE sheet_skid
	SET ab_job_num = :il_job, skid_date = :ldt_t
	WHERE sheet_skid_num = :il_skid
	USING SQLCA;
	IF SQLCA.SQLNRows = 0 THEN
		ROLLBACK USING SQLCA;
		Messagebox("DBError", "add partial skid function" )
		RETURN -4
	END IF			
	
	INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt)
	VALUES (:ll_item, :il_coil,:il_job,0,0,:ldt_t,0, 0)
	USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		ROLLBACK USING SQLCA;
		Messagebox("DBError", "add partial item function" )
		RETURN -5
	END IF
	
	INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
	VALUES (:il_skid, :ll_item)
	USING SQLCA;		
	IF SQLCA.SQLCode <> 0 then
		ROLLBACK USING SQLCA;
		Messagebox("DBError", "Insert Item function: skid detail table" )
		RETURN -5
	END IF
		
ELSE //new skid
	il_skid = f_get_next_value("sheet_skid_num_seq")

	INSERT INTO sheet_skid (sheet_skid_num, ab_job_num, sheet_net_wt , sheet_tare_wt, skid_date, skid_pieces , skid_sheet_status, sheet_theoretical_wt, ref_order_abc_num, ref_order_abc_item)
	VALUES (:il_skid, :il_job, 0, :il_tare,:ldt_t,0, 5, 0, :ll_order, :ll_orderitem)
	USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		ROLLBACK USING SQLCA;
		Messagebox("DBError", "Insert new skid function." )
		RETURN -5
	END IF
		
	INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt)
	VALUES (:ll_item, :il_coil,:il_job,2,0, :ldt_t,0, 0)
	USING SQLCA;
	IF SQLCA.SQLCode <> 0 then
		ROLLBACK USING SQLCA;
		Messagebox("DBError", "Insert new skid item function." )
		RETURN -5
	END IF
	
	INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
	VALUES (:il_skid, :ll_item)
	USING SQLCA;		
	IF SQLCA.SQLCode <> 0 then
		ROLLBACK USING SQLCA;
		Messagebox("DBError", "Insert new new skid detail function." )
		RETURN -5
	END IF
	
	//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
	li_rtn = f_insert_sheet_skid_package(il_job, il_skid, sqlca)
	
	If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package(). Error message is in this function.
		rollback using sqlca;
		Return -5
	End If
	//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	
END IF

sqlca.of_commit( )

CloseWithReturn(Parent,il_skid)
end event

type cb_close from u_cb within w_load_skid_offline
string tag = "Close without selection"
integer x = 1225
integer y = 1139
integer width = 351
integer height = 102
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;CloseWithReturn(Parent,0)
end event

type gb_select from u_gb within w_load_skid_offline
integer x = 37
integer y = 397
integer width = 2110
integer height = 515
integer taborder = 10
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Please select a skid"
end type

