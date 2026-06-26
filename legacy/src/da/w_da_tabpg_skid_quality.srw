$PBExportHeader$w_da_tabpg_skid_quality.srw
$PBExportComments$skid quality issue
forward
global type w_da_tabpg_skid_quality from w_popup
end type
type st_2 from statictext within w_da_tabpg_skid_quality
end type
type mle_desc from u_mle within w_da_tabpg_skid_quality
end type
type ddlb_skid from dropdownlistbox within w_da_tabpg_skid_quality
end type
type st_skid_id from statictext within w_da_tabpg_skid_quality
end type
type rb_select from radiobutton within w_da_tabpg_skid_quality
end type
type st_1 from statictext within w_da_tabpg_skid_quality
end type
type rb_current from radiobutton within w_da_tabpg_skid_quality
end type
type cb_cancel from u_cb within w_da_tabpg_skid_quality
end type
type cb_save from u_cb within w_da_tabpg_skid_quality
end type
type gb_1 from groupbox within w_da_tabpg_skid_quality
end type
end forward

global type w_da_tabpg_skid_quality from w_popup
integer x = 214
integer width = 2670
integer height = 739
string title = "Put a skid to Quality Hold"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean ib_isupdateable = false
st_2 st_2
mle_desc mle_desc
ddlb_skid ddlb_skid
st_skid_id st_skid_id
rb_select rb_select
st_1 st_1
rb_current rb_current
cb_cancel cb_cancel
cb_save cb_save
gb_1 gb_1
end type
global w_da_tabpg_skid_quality w_da_tabpg_skid_quality

type variables
u_coil iu_coil
u_da_skid_tabpg iu_da_skid_tabpg
long il_item
SQLPreviewType isql_criteria

string is_PRODUCTION_SHEET_ITEM_keys[] = {"production_sheet_item_prod_item_num" }
string is_PRODUCTION_SHEET_ITEM_cols[] = & 
{"production_sheet_item_prod_item_pieces", "production_sheet_item_prod_item_net_wt","production_sheet_item_prod_item_num", &
"production_sheet_item_prod_item_theoretical_wt"}
string is_SHEET_SKID_DETAIL_keys[] ={"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
string is_SHEET_SKID_DETAIL_cols[] = &
{"sheet_skid_detail_prod_item_num", "sheet_skid_detail_sheet_skid_num"}
string is_SHEET_SKID_keys[]={"sheet_skid_sheet_skid_num"}
string is_SHEET_SKID_cols[] = &
{"sheet_skid_sheet_tare_wt","sheet_skid_sheet_net_wt","sheet_skid_skid_pieces", "sheet_skid_sheet_theoretical_wt","sheet_skid_skid_sheet_status"}


long il_current_row, il_skid
Long il_orig_row

end variables

forward prototypes
public subroutine wf_copy_row ()
public function integer wf_data_validation ()
end prototypes

public subroutine wf_copy_row ();iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_skid_sheet_status[il_orig_row] = 4
iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_skid_quality_notes[il_orig_row] = mle_desc.Text
end subroutine

public function integer wf_data_validation ();return 0 //return 0 if validated
end function

on w_da_tabpg_skid_quality.create
int iCurrent
call super::create
this.st_2=create st_2
this.mle_desc=create mle_desc
this.ddlb_skid=create ddlb_skid
this.st_skid_id=create st_skid_id
this.rb_select=create rb_select
this.st_1=create st_1
this.rb_current=create rb_current
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.mle_desc
this.Control[iCurrent+3]=this.ddlb_skid
this.Control[iCurrent+4]=this.st_skid_id
this.Control[iCurrent+5]=this.rb_select
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rb_current
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.cb_save
this.Control[iCurrent+10]=this.gb_1
end on

on w_da_tabpg_skid_quality.destroy
call super::destroy
destroy(this.st_2)
destroy(this.mle_desc)
destroy(this.ddlb_skid)
destroy(this.st_skid_id)
destroy(this.rb_select)
destroy(this.st_1)
destroy(this.rb_current)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.gb_1)
end on

event open;call super::open;Long ll_row, ll_i
DataStore lds_s


if gi_screen = 2 then
	if gi_dual_mode = 2 then
		this.x = 1200
		this.y = 4000
	else
		this.x = 7000
		this.y = 600
	end if
else
	this.x = 1200
	this.y = 600
end if

iu_da_skid_tabpg = message.powerobjectparm
iu_coil = iu_da_skid_tabpg.iu_coil

ll_row = iu_da_skid_tabpg.dw_skid_item.getselectedrow(0)
if ll_row < 1 then
	IF iu_da_skid_tabpg.il_current_row > 0 THEN
		il_orig_row = iu_da_skid_tabpg.il_current_row
		il_skid = iu_da_skid_tabpg.dw_skid_item.GetItemNumber(il_orig_row, "sheet_skid_sheet_skid_num", Primary!, TRUE)
	ELSE
		il_orig_row = 0
		il_skid = 0
	END IF
ELSE
	il_orig_row = ll_row
	il_skid = iu_da_skid_tabpg.dw_skid_item.GetItemNumber(il_orig_row, "sheet_skid_sheet_skid_num", Primary!, TRUE)
END IF
IF il_skid > 0 THEN
	st_skid_id.Text = String(il_skid)
	gb_1.Text = "Select a skid to mark it Quality OnHold - " + st_skid_id.Text
ELSE
	st_skid_id.Text = "Not Available"
	gb_1.Text = "Select a skid to mark it Quality OnHold"
END IF

lds_s = CREATE datastore  
lds_s.DataObject = "d_skid_list_per_shift"  
lds_s.SetTransObject (SQLCA)  
lds_s.Retrieve(iu_coil.of_get_shift_id())
ll_row = lds_s.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_skid.AddItem(String(lds_s.GetItemNumber(ll_i, "sheet_skid_detail_sheet_skid_num")))
	NEXT
END IF
DESTROY lds_s
end event

type st_2 from statictext within w_da_tabpg_skid_quality
integer x = 11
integer y = 205
integer width = 344
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Description:"
boolean focusrectangle = false
end type

type mle_desc from u_mle within w_da_tabpg_skid_quality
integer x = 366
integer y = 195
integer width = 2271
integer height = 285
integer taborder = 50
end type

type ddlb_skid from dropdownlistbox within w_da_tabpg_skid_quality
integer x = 1979
integer y = 70
integer width = 633
integer height = 515
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;il_skid = Long(Text(index))
gb_1.Text = "Select a skid to mark it Quality OnHold - " + Text(il_skid)

end event

type st_skid_id from statictext within w_da_tabpg_skid_quality
integer x = 563
integer y = 80
integer width = 527
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Not Available"
boolean focusrectangle = false
end type

type rb_select from radiobutton within w_da_tabpg_skid_quality
integer x = 1287
integer y = 70
integer width = 717
integer height = 77
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select a skid from list:"
end type

event clicked;IF this.Checked THEN
	ddlb_skid.Enabled = TRUE
	il_skid = 0
END IF
end event

type st_1 from statictext within w_da_tabpg_skid_quality
integer x = 1134
integer y = 77
integer width = 135
integer height = 64
integer textsize = -10
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

type rb_current from radiobutton within w_da_tabpg_skid_quality
integer x = 80
integer y = 70
integer width = 432
integer height = 77
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Current Skid:"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_skid.Enabled = FALSE
	IF IsNumber(st_skid_id.Text) THEN
	 	il_skid = Long(st_skid_id.Text)
	 	gb_1.Text = "Select a skid to mark it Quality OnHold - " + st_skid_id.Text
	ELSE
	 	gb_1.Text = "Select a skid to mark it Quality OnHold"
		il_skid = 0
	END IF
END IF
end event

type cb_cancel from u_cb within w_da_tabpg_skid_quality
integer x = 1514
integer y = 515
integer width = 512
integer height = 141
integer taborder = 70
integer textsize = -12
string facename = "Arial"
string text = "Cancel"
end type

event clicked;call super::clicked;close( parent )
end event

type cb_save from u_cb within w_da_tabpg_skid_quality
integer x = 556
integer y = 515
integer width = 571
integer height = 141
integer taborder = 60
integer textsize = -12
string facename = "Arial"
string text = "Save"
end type

event clicked;call super::clicked;Long ll_row, ll_i
Boolean lb_current

IF il_skid > 0 THEN
	If MessageBox("Save skid", "Do you want to save the changes?", Question!, YesNo!, 2) = 1 then

		IF rb_select.Checked THEN
			lb_current = FALSE
			ll_row = iu_da_skid_tabpg.dw_skid_item.Rowcount()
			IF ll_row > 0 THEN
				FOR ll_i = 1 to ll_row
					IF iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_skid_num[ll_i] = il_skid THEN
						iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_skid_sheet_status[ll_i] = 4
         			iu_da_skid_tabpg.dw_skid_item.object.sheet_skid_sheet_skid_quality_notes[ll_i] = mle_desc.Text
						iu_da_skid_tabpg.of_save( )
						lb_current = TRUE
					END IF
				NEXT
			END IF
			IF NOT(lb_current) THEN
				UPDATE sheet_skid SET skid_sheet_status = 4, sheet_skid_quality_notes = :mle_desc.Text
				WHERE sheet_skid_num = :il_skid
				USING SQLCA;
	   		COMMIT USING SQLCA;
			END IF
		ELSE
			IF il_orig_row > 0 THEN
				wf_copy_row()
				iu_da_skid_tabpg.of_save( )
			END IF
		END IF
	END IF
END IF
close( parent )
	

		
end event

type gb_1 from groupbox within w_da_tabpg_skid_quality
integer x = 7
integer y = 3
integer width = 2629
integer height = 163
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select a skid to mark it Quality OnHold"
end type

