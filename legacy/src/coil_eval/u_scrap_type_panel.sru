$PBExportHeader$u_scrap_type_panel.sru
forward
global type u_scrap_type_panel from userobject
end type
type uo_12 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_11 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_10 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_9 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_8 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_7 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_6 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_5 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_4 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_3 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_2 from u_scrap_type_button within u_scrap_type_panel
end type
type uo_1 from u_scrap_type_button within u_scrap_type_panel
end type
end forward

global type u_scrap_type_panel from userobject
integer width = 2348
integer height = 499
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type_changed ( )
uo_12 uo_12
uo_11 uo_11
uo_10 uo_10
uo_9 uo_9
uo_8 uo_8
uo_7 uo_7
uo_6 uo_6
uo_5 uo_5
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_scrap_type_panel u_scrap_type_panel

type variables
private int ii_current_scrap_type
private int ii_pre_scrap_type
private string is_current_scrap_defect
private string is_pre_scrap_defect
end variables

forward prototypes
public function integer of_get_current_scrap_type ()
public function integer of_get_pre_scrap_type ()
public function string of_get_current_scrap_defect ()
public function string of_get_previous_scrap_defect ()
public function integer of_set_defect_id (integer ai_id)
end prototypes

event type_changed();//Override this even for your own process
end event

public function integer of_get_current_scrap_type ();return ii_current_scrap_type
end function

public function integer of_get_pre_scrap_type ();return ii_pre_scrap_type
end function

public function string of_get_current_scrap_defect ();if not isNull( is_current_scrap_defect ) then
	return is_current_scrap_defect
else
	return ""
end if
end function

public function string of_get_previous_scrap_defect ();if not isNull( is_pre_scrap_defect ) then
	return is_pre_scrap_defect
else
	return ""
end if
end function

public function integer of_set_defect_id (integer ai_id);//return 0 if id is not in panel
//return 1 if id is in panel and defect changed to id
//this.control

int li_control_count,li_i
u_scrap_type_button iu_temp
li_control_count =  UpperBound(control)

for li_i=1 to li_control_count
	if control[ li_i ].tag = "scrap_type" then
		iu_temp = control[ li_i ]
			if iu_temp.ii_downtime_reason_id = ai_id then
				iu_temp.set_select( )
				ii_current_scrap_type = iu_temp.ii_downtime_reason_id
				is_current_scrap_defect = iu_temp.caption
			end if
	end if
	//MessageBox("dd", string(control[ li_i ].Classdefinition))
	//iu_temp.Classdefinition
	
next


return 0
end function

on u_scrap_type_panel.create
this.uo_12=create uo_12
this.uo_11=create uo_11
this.uo_10=create uo_10
this.uo_9=create uo_9
this.uo_8=create uo_8
this.uo_7=create uo_7
this.uo_6=create uo_6
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
this.Control[]={this.uo_12,&
this.uo_11,&
this.uo_10,&
this.uo_9,&
this.uo_8,&
this.uo_7,&
this.uo_6,&
this.uo_5,&
this.uo_4,&
this.uo_3,&
this.uo_2,&
this.uo_1}
end on

on u_scrap_type_panel.destroy
destroy(this.uo_12)
destroy(this.uo_11)
destroy(this.uo_10)
destroy(this.uo_9)
destroy(this.uo_8)
destroy(this.uo_7)
destroy(this.uo_6)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

event constructor;//uo_1.set_select( )
//ii_current_scrap_type = uo_1.ii_downtime_reason_id
//ii_pre_scrap_type  = uo_1.ii_downtime_reason_id
//is_current_scrap_defect = uo_1.caption 
//is_pre_scrap_defect = uo_1.caption
end event

type uo_12 from u_scrap_type_button within u_scrap_type_panel
integer x = 1565
integer y = 378
integer taborder = 90
integer ii_downtime_reason_id = 17
string caption = "Repeat Marks Gen"
end type

on uo_12.destroy
call u_scrap_type_button::destroy
end on

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_12.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_1.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

type uo_11 from u_scrap_type_button within u_scrap_type_panel
integer x = 1565
integer y = 253
integer taborder = 80
integer ii_downtime_reason_id = 12
string caption = "ID Edge Damage"
end type

on uo_11.destroy
call u_scrap_type_button::destroy
end on

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_11.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_1.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

type uo_10 from u_scrap_type_button within u_scrap_type_panel
integer x = 1565
integer y = 128
integer taborder = 80
integer ii_downtime_reason_id = 7
string caption = "OD Dents"
end type

on uo_10.destroy
call u_scrap_type_button::destroy
end on

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_10.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_1.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

type uo_9 from u_scrap_type_button within u_scrap_type_panel
integer x = 1565
integer y = 3
integer taborder = 60
integer ii_downtime_reason_id = 4
string caption = "Start/Stop-Crop Roll"
end type

on uo_9.destroy
call u_scrap_type_button::destroy
end on

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_9.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_1.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

type uo_8 from u_scrap_type_button within u_scrap_type_panel
integer x = 786
integer y = 378
integer taborder = 80
integer ii_downtime_reason_id = 15
string caption = "Leveler Roll Marks"
end type

on uo_8.destroy
call u_scrap_type_button::destroy
end on

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_8.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_1.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

type uo_7 from u_scrap_type_button within u_scrap_type_panel
integer x = 786
integer y = 253
integer taborder = 70
integer ii_downtime_reason_id = 9
string caption = "OD Gouges"
end type

on uo_7.destroy
call u_scrap_type_button::destroy
end on

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_7.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_1.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

type uo_6 from u_scrap_type_button within u_scrap_type_panel
integer x = 786
integer y = 128
integer taborder = 70
integer ii_downtime_reason_id = 6
string caption = "ID Scratches"
end type

on uo_6.destroy
call u_scrap_type_button::destroy
end on

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_6.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_1.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

type uo_5 from u_scrap_type_button within u_scrap_type_panel
integer x = 786
integer y = 3
integer taborder = 60
integer ii_downtime_reason_id = 3
string caption = "WSW-Stoned"
end type

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_5.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_1.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

on uo_5.destroy
call u_scrap_type_button::destroy
end on

type uo_4 from u_scrap_type_button within u_scrap_type_panel
integer x = 4
integer y = 378
integer taborder = 80
integer ii_downtime_reason_id = 14
string caption = "ID Arbor Breaks"
end type

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_4.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_1.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

on uo_4.destroy
call u_scrap_type_button::destroy
end on

type uo_3 from u_scrap_type_button within u_scrap_type_panel
integer x = 4
integer y = 253
integer taborder = 70
integer ii_downtime_reason_id = 8
string caption = "ID Dents"
end type

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_3.set_select( )
uo_2.set_no_selected( )
uo_1.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

on uo_3.destroy
call u_scrap_type_button::destroy
end on

type uo_2 from u_scrap_type_button within u_scrap_type_panel
integer x = 4
integer y = 128
integer taborder = 60
integer ii_downtime_reason_id = 5
string caption = "OD Scratches"
end type

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_1.set_no_selected( )
uo_2.set_select( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

on uo_2.destroy
call u_scrap_type_button::destroy
end on

type uo_1 from u_scrap_type_button within u_scrap_type_panel
integer x = 4
integer y = 3
integer taborder = 50
integer ii_downtime_reason_id = 2
string caption = "Set Up"
end type

event clicked;call super::clicked;ii_pre_scrap_type = ii_current_scrap_type
ii_current_scrap_type = this.ii_downtime_reason_id
is_pre_scrap_defect = is_current_scrap_defect
is_current_scrap_defect = this.caption
uo_1.set_select( )
uo_2.set_no_selected( )
uo_3.set_no_selected( )
uo_4.set_no_selected( )
uo_5.set_no_selected( )
uo_6.set_no_selected( )
uo_7.set_no_selected( )
uo_8.set_no_selected( )
uo_9.set_no_selected( )
uo_10.set_no_selected( )
uo_11.set_no_selected( )
uo_12.set_no_selected( )
if ii_current_scrap_type <> ii_pre_scrap_type then
	parent.postevent( "type_changed")
end if

end event

on uo_1.destroy
call u_scrap_type_button::destroy
end on

