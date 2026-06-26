$PBExportHeader$u_tabpg_eval_job_selection.sru
forward
global type u_tabpg_eval_job_selection from u_tabpg
end type
type cb_1 from commandbutton within u_tabpg_eval_job_selection
end type
type tv_selection from u_tvs within u_tabpg_eval_job_selection
end type
end forward

global type u_tabpg_eval_job_selection from u_tabpg
integer width = 786
integer height = 1818
string text = "AB Job"
cb_1 cb_1
tv_selection tv_selection
end type
global u_tabpg_eval_job_selection u_tabpg_eval_job_selection

type variables
w_qc_sheet iw_sheet
n_ds ids_job_list
long il_job, il_skid
end variables

forward prototypes
public function integer of_init (long al_job)
end prototypes

public function integer of_init (long al_job);return 1
end function

on u_tabpg_eval_job_selection.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.tv_selection=create tv_selection
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.tv_selection
end on

on u_tabpg_eval_job_selection.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.tv_selection)
end on

event constructor;call super::constructor;iw_sheet = message.powerobjectparm
//MessageBox("tabpg", "constructor")
tv_selection.of_SetLevelSource(TRUE)
long ll_1
//ids_job_list = create DataStore
//iw_sheet.ids_job_list.sharedata( ids_job_list )

ids_job_list = iw_sheet.ids_job_list
ll_1 = tv_selection.inv_levelsource.of_Register(1, "ab_job_name", "", ids_job_list , "")
//MessageBox("fdf",string(ll_1))
ll_1 = tv_selection.inv_levelsource.of_Register(2, "compute_1", ":parent.1.ab_job", "d_qc_coil_list", SQLCA,"")
//MessageBox("fdf",string(ll_1))
ll_1 = tv_selection.inv_levelsource.of_Register(3, "compute_1", & 
":parent.1.process_coil_coil_abc_num, :parent.2.ab_job", "d_qc_skid_list", SQLCA,"")
//MessageBox("fdf",string(ll_1))
//ll_1 = tv_selection.inv_levelsource.of_Register(4, "compute_1", ":parent.1.sheet_skid_detail_sheet_skid_num", "d_qc_skid_pc_list", SQLCA,"")

tv_selection.inv_levelsource.of_SetPictureColumn(1, "1")
tv_selection.inv_levelsource.of_SetSelectedPictureColumn &
(1, "2")
tv_selection.inv_levelsource.of_SetPictureColumn(2, "3")
tv_selection.inv_levelsource.of_SetSelectedPictureColumn &
(2, "4")
tv_selection.inv_levelsource.of_SetPictureColumn(3, "5")
tv_selection.inv_levelsource.of_SetSelectedPictureColumn &
(3, "6")
//tv_selection.inv_levelsource.of_SetPictureColumn(4, "7")
//tv_selection.inv_levelsource.of_SetSelectedPictureColumn &
//(4, "8")

//tv_selection.selectitem( /*long h */)

tv_selection.event pfc_Populate(0)
//tv_selection.expandall( 1 )

end event

type cb_1 from commandbutton within u_tabpg_eval_job_selection
boolean visible = false
integer x = 102
integer y = 38
integer width = 413
integer height = 118
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "test"
end type

event clicked;messagebox("test", string(iw_sheet.classname( ))   )
end event

type tv_selection from u_tvs within u_tabpg_eval_job_selection
integer x = 15
integer y = 38
integer width = 746
integer height = 1754
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
string facename = "Arial"
long textcolor = 8388608
string picturename[] = {"Custom039!","Custom050!","DatabaseProfile!","Database!","ArrangeTables5!","ArrangeTables!","UserObject!","UserObject5!"}
end type

event clicked;call super::clicked;//this.triggerevent( "selectionchanged")
end event

event constructor;call super::constructor;////MessageBox("this", "constructor")
//this.of_SetLevelSource(TRUE)
//long ll_1
//ids_job_list = create DataStore
//iw_sheet.ids_job_list.sharedata( ids_job_list )
//
//ll_1 = this.inv_levelsource.of_Register(1, "ab_job_name", "", ids_job_list , "")
////MessageBox("fdf",string(ll_1))
//ll_1 = this.inv_levelsource.of_Register(2, "compute_1", ":parent.1.ab_job", "d_qc_coil_list", SQLCA,"")
////MessageBox("fdf",string(ll_1))
//ll_1 = this.inv_levelsource.of_Register(3, "compute_1", & 
//":parent.1.process_coil_coil_abc_num, :parent.2.ab_job", "d_qc_skid_list", SQLCA,"")
////MessageBox("fdf",string(ll_1))
//ll_1 = this.inv_levelsource.of_Register(4, "compute_1", ":parent.1.sheet_skid_detail_sheet_skid_num", "d_qc_skid_pc_list", SQLCA,"")
//
//this.inv_levelsource.of_SetPictureColumn(1, "1")
//this.inv_levelsource.of_SetSelectedPictureColumn &
//(1, "2")
//this.inv_levelsource.of_SetPictureColumn(2, "3")
//this.inv_levelsource.of_SetSelectedPictureColumn &
//(2, "4")
//this.inv_levelsource.of_SetPictureColumn(3, "5")
//this.inv_levelsource.of_SetSelectedPictureColumn &
//(3, "6")
//this.inv_levelsource.of_SetPictureColumn(4, "7")
//this.inv_levelsource.of_SetSelectedPictureColumn &
//(4, "8")
//
////this.selectitem( /*long h */)
//
//this.event pfc_Populate(0)
////this.expandall( 1 )
//
//
end event

event selectionchanged;call super::selectionchanged;Long ll_current, ll_return, ll_row, ll_row_parent, ll_parent
TreeViewItem ltvi_item
n_ds lds_datastore, lds_temp
//Date ld_d
//DateTime ldt_s, ldt_e

//reset dw
//dw_schedule.Reset()

// Get the DataStore and row for the new item
IF inv_levelsource.of_GetDataRow(newhandle, lds_datastore, ll_row) = -1 THEN
	MessageBox("Error", "Error in of_GetDataRow", Exclamation!)
	RETURN -1
END IF

ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)

if ltvi_item.level =1 then
// 	ii_line = lds_datastore.GetItemNumber(ll_row,"line_schedule_line_num")
// 	is_line = lds_datastore.GetItemString(ll_row,"line_line_desc")
//	ii_schedule_type = 0
//	ii_data = 0 //line
//	Parent.Event ue_show_daily_schedule()
	//MessageBox("a","1")
	il_job = lds_datastore.object.ab_job[ll_row]
	if iw_sheet.rb_offline.checked or iw_sheet.rb_current_shift.checked then
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_skid_dim_check )
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_job_dim_check_gr )
		iw_sheet.tab_dim_skid.opentabwithparm( iw_sheet.iu_tabpg_job_dim_check_gr, il_job, 0)
	end if
elseif ltvi_item.level =2 then
// 	ii_schedule_type = lds_datastore.GetItemNumber(ll_row,"schedule_type")
	
	ll_parent = this.FindItem(ParentTreeItem!, ll_current)
	IF inv_levelsource.of_GetDataRow(ll_parent, lds_temp, ll_row_parent) = -1 THEN
		MessageBox("Error", "Error in of_GetDataRow", Exclamation!)
		RETURN -2
	END IF
// 	ii_line = lds_temp.GetItemNumber(ll_row_parent,"line_schedule_line_num")
// 	is_line = lds_temp.GetItemString(ll_row_parent,"line_line_desc")
//	ii_data = 1 //shift
//	ld_d = Date(is_date)

//	Parent.Event ue_show_shift_schedule()
	//MessageBox("a","2")
	il_job = lds_temp.object.ab_job[ll_row_parent]
	if iw_sheet.rb_offline.checked or iw_sheet.rb_current_shift.checked then
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_skid_dim_check )
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_job_dim_check_gr )
		iw_sheet.tab_dim_skid.opentabwithparm( iw_sheet.iu_tabpg_job_dim_check_gr, il_job, 0)
	end if
elseif ltvi_item.level = 3 then
	//MessageBox("a","3")
//
	il_skid = lds_datastore.object.sheet_skid_detail_sheet_skid_num[ll_row]
	if iw_sheet.rb_offline.checked or iw_sheet.rb_current_shift.checked then
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_skid_dim_check )
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_job_dim_check_gr )
		iw_sheet.tab_dim_skid.opentabwithparm( iw_sheet.iu_tabpg_skid_dim_check, il_skid, 0)
	end if
elseif ltvi_item.level = 4 then
//
	//MessageBox("a","4")
	ll_parent = this.FindItem(ParentTreeItem!, ll_current)
	IF inv_levelsource.of_GetDataRow(ll_parent, lds_temp, ll_row_parent) = -1 THEN
		MessageBox("Error", "Error in of_GetDataRow", Exclamation!)
		RETURN -2
	END IF
	il_skid = lds_temp.object.sheet_skid_detail_sheet_skid_num[ll_row_parent]
	if iw_sheet.rb_offline.checked or iw_sheet.rb_current_shift.checked then
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_skid_dim_check )
		iw_sheet.tab_dim_skid.closetab( iw_sheet.iu_tabpg_job_dim_check_gr )
		iw_sheet.tab_dim_skid.opentabwithparm( iw_sheet.iu_tabpg_skid_dim_check, il_skid, 0)
	end if
else
	//
end if

//	this.
RETURN 1


end event

event pfc_retrieve;call super::pfc_retrieve;Any la_args[20]
Integer li_level
IF IsValid(inv_levelsource) THEN
li_level = this.of_GetNextLevel(al_parent)
this.inv_levelsource.of_GetArgs(al_parent, &
li_level, la_args)
END IF
Return this.of_Retrieve(al_parent, la_args, &
ads_data)
end event

