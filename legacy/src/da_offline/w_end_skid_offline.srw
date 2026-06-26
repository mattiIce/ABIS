$PBExportHeader$w_end_skid_offline.srw
$PBExportComments$<Response> finish a skid inherited from pfemain/w_sheet
forward
global type w_end_skid_offline from w_sheet
end type
type rb_12 from u_rb within w_end_skid_offline
end type
type st_5 from statictext within w_end_skid_offline
end type
type em_pc from u_em within w_end_skid_offline
end type
type st_1 from statictext within w_end_skid_offline
end type
type rb_7 from u_rb within w_end_skid_offline
end type
type st_4 from statictext within w_end_skid_offline
end type
type em_wt from u_em within w_end_skid_offline
end type
type st_3 from statictext within w_end_skid_offline
end type
type rb_5 from u_rb within w_end_skid_offline
end type
type st_abc_id from statictext within w_end_skid_offline
end type
type st_2 from statictext within w_end_skid_offline
end type
type cb_save from u_cb within w_end_skid_offline
end type
type cb_close from u_cb within w_end_skid_offline
end type
type gb_select from u_gb within w_end_skid_offline
end type
end forward

global type w_end_skid_offline from w_sheet
integer x = 318
integer y = 144
integer width = 2194
integer height = 1133
string title = "Finishing a skid"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
rb_12 rb_12
st_5 st_5
em_pc em_pc
st_1 st_1
rb_7 rb_7
st_4 st_4
em_wt em_wt
st_3 st_3
rb_5 rb_5
st_abc_id st_abc_id
st_2 st_2
cb_save cb_save
cb_close cb_close
gb_select gb_select
end type
global w_end_skid_offline w_end_skid_offline

type variables
Long il_skid, il_item, il_theo
end variables

on w_end_skid_offline.create
int iCurrent
call super::create
this.rb_12=create rb_12
this.st_5=create st_5
this.em_pc=create em_pc
this.st_1=create st_1
this.rb_7=create rb_7
this.st_4=create st_4
this.em_wt=create em_wt
this.st_3=create st_3
this.rb_5=create rb_5
this.st_abc_id=create st_abc_id
this.st_2=create st_2
this.cb_save=create cb_save
this.cb_close=create cb_close
this.gb_select=create gb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_12
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.em_pc
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_7
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.em_wt
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.rb_5
this.Control[iCurrent+10]=this.st_abc_id
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.cb_save
this.Control[iCurrent+13]=this.cb_close
this.Control[iCurrent+14]=this.gb_select
end on

on w_end_skid_offline.destroy
call super::destroy
destroy(this.rb_12)
destroy(this.st_5)
destroy(this.em_pc)
destroy(this.st_1)
destroy(this.rb_7)
destroy(this.st_4)
destroy(this.em_wt)
destroy(this.st_3)
destroy(this.rb_5)
destroy(this.st_abc_id)
destroy(this.st_2)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.gb_select)
end on

event open;call super::open;s_skid_item lds_s

lds_s = message.PowerObjectParm

il_skid = lds_s.skid_num
il_item = lds_s.item_num
il_theo = lds_s.net

st_abc_id.Text = String(il_skid)


end event

type rb_12 from u_rb within w_end_skid_offline
integer x = 168
integer y = 746
integer textsize = -12
string facename = "Arial"
string text = "Sample"
end type

type st_5 from statictext within w_end_skid_offline
integer x = 168
integer y = 618
integer width = 827
integer height = 86
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

type em_pc from u_em within w_end_skid_offline
integer x = 1273
integer y = 707
integer width = 750
integer height = 109
integer taborder = 30
integer textsize = -12
string facename = "Arial"
string mask = "#########"
end type

type st_1 from statictext within w_end_skid_offline
integer x = 1273
integer y = 611
integer width = 618
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Skid Total Pieces:"
boolean focusrectangle = false
end type

type rb_7 from u_rb within w_end_skid_offline
integer x = 168
integer y = 509
integer textsize = -12
string facename = "Arial"
string text = "Partial"
end type

type st_4 from statictext within w_end_skid_offline
integer x = 1273
integer y = 317
integer width = 735
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Skid Total Net Weight:"
boolean focusrectangle = false
end type

type em_wt from u_em within w_end_skid_offline
integer x = 1273
integer y = 413
integer width = 750
integer height = 109
integer taborder = 20
integer textsize = -12
string facename = "Arial"
string mask = "#########"
end type

type st_3 from statictext within w_end_skid_offline
integer x = 168
integer y = 406
integer width = 827
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

type rb_5 from u_rb within w_end_skid_offline
integer x = 168
integer y = 298
integer textsize = -12
string facename = "Arial"
string text = "Finished"
boolean checked = true
end type

type st_abc_id from statictext within w_end_skid_offline
integer x = 764
integer y = 10
integer width = 1412
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

type st_2 from statictext within w_end_skid_offline
integer x = 51
integer y = 10
integer width = 699
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Skid Number:"
boolean focusrectangle = false
end type

type cb_save from u_cb within w_end_skid_offline
integer x = 585
integer y = 912
integer width = 351
integer height = 102
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;SetPointer(HourGlass!)

Long ll_wt, ll_pc, ll_theo, ll_ipc, ll_iwt, ll_itheo, ll_owt, ll_opc
Int li_status
DateTime ldt_t

ll_wt = Long(em_wt.Text)

IF IsNULL(ll_wt) OR ll_wt = 0 THEN
	MessageBox("Error", "Invalid net weight.")
	RETURN -1
END IF

ll_pc = Long(em_pc.Text)

IF IsNULL(ll_pc) OR ll_pc = 0 THEN
	MessageBox("Error", "Invalid pieces.")
	RETURN -1
END IF

ll_theo = il_theo * ll_pc

IF rb_5.Checked THEN li_status = 5
IF rb_7.Checked THEN li_status = 7
IF rb_12.Checked THEN li_status = 12

ldt_t = DateTime(Today(),Now())

ll_owt = 0
ll_opc = 0

SELECT SUM("PRODUCTION_SHEET_ITEM"."PROD_ITEM_PIECES"),   
         SUM("PRODUCTION_SHEET_ITEM"."PROD_ITEM_NET_WT")
INTO :ll_opc, :ll_owt
FROM "PRODUCTION_SHEET_ITEM", "SHEET_SKID_DETAIL"  
WHERE ( "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" = "PRODUCTION_SHEET_ITEM"."PROD_ITEM_NUM" ) and  
         ( ( "SHEET_SKID_DETAIL"."SHEET_SKID_NUM" = :il_skid ) AND  
         ( "SHEET_SKID_DETAIL"."PROD_ITEM_NUM" <> :il_item )   
         )    
USING SQLCA;

ll_iwt = ll_wt - ll_owt
ll_ipc = ll_pc - ll_opc
ll_itheo = il_theo * ll_ipc

UPDATE sheet_skid 
SET sheet_net_wt = :ll_wt, skid_date = :ldt_t, skid_sheet_status = :li_status, skid_pieces = :ll_pc, sheet_theoretical_wt = :ll_theo
WHERE sheet_skid_num = :il_skid
USING SQLCA;
	if sqlca.sqlcode <> 0 then 
		MessageBox("Waring","Error updating skid data.") 
		sqlca.of_rollback( )
		return -1
	end if
	
UPDATE Production_sheet_item
SET prod_item_pieces = :ll_ipc, prod_item_net_wt = :ll_iwt, prod_item_theoretical_wt = :ll_itheo, prod_item_status = 2, prod_item_date = :ldt_t
WHERE prod_item_num = :il_item
USING SQLCA;

	if sqlca.sqlcode <> 0 then 
		MessageBox("Waring","Error updating item data.") 
		sqlca.of_rollback( )
		return -2
	end if
	
sqlca.of_commit( )

CloseWithReturn(Parent,1)
end event

type cb_close from u_cb within w_end_skid_offline
string tag = "Close without selection"
integer x = 1211
integer y = 912
integer width = 351
integer height = 102
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;CloseWithReturn(Parent,0)
end event

type gb_select from u_gb within w_end_skid_offline
integer x = 37
integer y = 170
integer width = 1104
integer height = 710
integer taborder = 10
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Please select a new status"
end type

