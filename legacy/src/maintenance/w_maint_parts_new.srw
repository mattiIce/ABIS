$PBExportHeader$w_maint_parts_new.srw
$PBExportComments$<main>new parts, inherited from  pfemain.pbl
forward
global type w_maint_parts_new from w_sheet
end type
type cb_pic from u_cb within w_maint_parts_new
end type
type st_6 from statictext within w_maint_parts_new
end type
type st_5 from statictext within w_maint_parts_new
end type
type st_4 from statictext within w_maint_parts_new
end type
type st_3 from statictext within w_maint_parts_new
end type
type st_2 from statictext within w_maint_parts_new
end type
type st_1 from statictext within w_maint_parts_new
end type
type ddlb_desc from u_ddlb within w_maint_parts_new
end type
type ddlb_loc from u_ddlb within w_maint_parts_new
end type
type ddlb_se from u_ddlb within w_maint_parts_new
end type
type dw_naming from u_dw within w_maint_parts_new
end type
type ddlb_type from u_ddlb within w_maint_parts_new
end type
type ddlb_area from u_ddlb within w_maint_parts_new
end type
type dw_part from u_dw within w_maint_parts_new
end type
type cb_save from u_cb within w_maint_parts_new
end type
type cb_close from u_cb within w_maint_parts_new
end type
type gb_1 from groupbox within w_maint_parts_new
end type
end forward

global type w_maint_parts_new from w_sheet
integer x = 4
integer y = 3
integer width = 3054
integer height = 1952
string title = "New Parts"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217747
event type string ue_whoami ( )
event ue_read_only ( )
cb_pic cb_pic
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
ddlb_desc ddlb_desc
ddlb_loc ddlb_loc
ddlb_se ddlb_se
dw_naming dw_naming
ddlb_type ddlb_type
ddlb_area ddlb_area
dw_part dw_part
cb_save cb_save
cb_close cb_close
gb_1 gb_1
end type
global w_maint_parts_new w_maint_parts_new

type variables
integer ii_contact_new_flag
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
end prototypes

event type string ue_whoami();RETURN "w_maint_parts_new"
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

on w_maint_parts_new.create
int iCurrent
call super::create
this.cb_pic=create cb_pic
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_desc=create ddlb_desc
this.ddlb_loc=create ddlb_loc
this.ddlb_se=create ddlb_se
this.dw_naming=create dw_naming
this.ddlb_type=create ddlb_type
this.ddlb_area=create ddlb_area
this.dw_part=create dw_part
this.cb_save=create cb_save
this.cb_close=create cb_close
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_pic
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.ddlb_desc
this.Control[iCurrent+9]=this.ddlb_loc
this.Control[iCurrent+10]=this.ddlb_se
this.Control[iCurrent+11]=this.dw_naming
this.Control[iCurrent+12]=this.ddlb_type
this.Control[iCurrent+13]=this.ddlb_area
this.Control[iCurrent+14]=this.dw_part
this.Control[iCurrent+15]=this.cb_save
this.Control[iCurrent+16]=this.cb_close
this.Control[iCurrent+17]=this.gb_1
end on

on w_maint_parts_new.destroy
call super::destroy
destroy(this.cb_pic)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_desc)
destroy(this.ddlb_loc)
destroy(this.ddlb_se)
destroy(this.dw_naming)
destroy(this.ddlb_type)
destroy(this.ddlb_area)
destroy(this.dw_part)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event pfc_postopen;call super::pfc_postopen;dw_naming.Retrieve()

Long ll_row, ll_i
ll_row = dw_naming.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		CHOOSE CASE Upper(dw_naming.GetItemString(ll_i, "naming_area"))
			CASE 'AREAS'
				ddlb_area.AddItem(dw_naming.GetItemString(ll_i, "Title"))
			CASE 'TYPE'
				ddlb_type.AddItem(dw_naming.GetItemString(ll_i, "Title"))
			CASE 'SPEC_EQUIP'
				ddlb_se.AddItem(dw_naming.GetItemString(ll_i, "Title"))
			CASE 'DESCRIPTION'
				ddlb_desc.AddItem(dw_naming.GetItemString(ll_i, "Title"))
			CASE 'STORE_LOCATION'
				ddlb_loc.AddItem(dw_naming.GetItemString(ll_i, "Title"))
		END CHOOSE
	NEXT
END IF
ddlb_area.SelectItem(1)
ddlb_type.SelectItem(1)
ddlb_se.SelectItem(1)
ddlb_desc.SelectItem(1)
ddlb_loc.SelectItem(1)
ddlb_area.Event SelectionChanged(1)


end event

event open;call super::open;dw_naming.Visible = FALSE


end event

type cb_pic from u_cb within w_maint_parts_new
string tag = "Load Picture"
integer x = 534
integer y = 1722
integer width = 541
integer height = 115
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Load Picture"
end type

type st_6 from statictext within w_maint_parts_new
integer x = 1086
integer y = 288
integer width = 797
integer height = 67
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16776960
string text = "OR"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_maint_parts_new
integer x = 2322
integer y = 208
integer width = 618
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 16776960
string text = "Step 4: Stored Location"
boolean focusrectangle = false
end type

type st_4 from statictext within w_maint_parts_new
integer x = 1002
integer y = 352
integer width = 991
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16776960
string text = "Step 2 && 3: Select a part description:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_maint_parts_new
integer x = 1437
integer y = 102
integer width = 827
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16776960
string text = "Step 3: For Specific Equipment"
boolean focusrectangle = false
end type

type st_2 from statictext within w_maint_parts_new
integer x = 878
integer y = 102
integer width = 468
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16776960
string text = "Step 2: Part Type:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_maint_parts_new
integer x = 37
integer y = 208
integer width = 731
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32896
long backcolor = 16776960
string text = "Step 1: For Specific Area:"
boolean focusrectangle = false
end type

type ddlb_desc from u_ddlb within w_maint_parts_new
integer x = 973
integer y = 422
integer width = 1006
integer height = 1270
integer taborder = 20
string facename = "Arial"
end type

type ddlb_loc from u_ddlb within w_maint_parts_new
integer x = 2333
integer y = 285
integer width = 669
integer height = 1270
integer taborder = 20
string facename = "Arial"
end type

type ddlb_se from u_ddlb within w_maint_parts_new
integer x = 1459
integer y = 176
integer width = 786
integer height = 1270
integer taborder = 20
string facename = "Arial"
end type

type dw_naming from u_dw within w_maint_parts_new
integer x = 15
integer y = 1763
integer width = 176
integer height = 51
integer taborder = 80
string dataobject = "d_parts_naming_list"
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type ddlb_type from u_ddlb within w_maint_parts_new
integer x = 852
integer y = 176
integer width = 560
integer height = 1270
integer taborder = 20
string facename = "Arial"
end type

type ddlb_area from u_ddlb within w_maint_parts_new
integer x = 40
integer y = 285
integer width = 746
integer height = 1270
integer taborder = 30
string facename = "Arial"
end type

type dw_part from u_dw within w_maint_parts_new
integer x = 11
integer y = 570
integer width = 3028
integer height = 1126
integer taborder = 10
string dataobject = "d_parts_new"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)
end event

type cb_save from u_cb within w_maint_parts_new
string tag = "Save"
integer x = 1225
integer y = 1722
integer width = 541
integer height = 115
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

type cb_close from u_cb within w_maint_parts_new
string tag = "Exit"
integer x = 1916
integer y = 1722
integer width = 541
integer height = 115
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(parent)



end event

type gb_1 from groupbox within w_maint_parts_new
integer x = 11
integer y = 16
integer width = 3013
integer height = 541
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16776960
string text = "Create a new internal ID"
end type

