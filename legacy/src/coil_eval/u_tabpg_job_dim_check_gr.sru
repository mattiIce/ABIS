$PBExportHeader$u_tabpg_job_dim_check_gr.sru
forward
global type u_tabpg_job_dim_check_gr from u_tabpg
end type
type dw_gr from u_dw within u_tabpg_job_dim_check_gr
end type
type rb_len_dr from radiobutton within u_tabpg_job_dim_check_gr
end type
type rb_len_op from radiobutton within u_tabpg_job_dim_check_gr
end type
type rb_width from radiobutton within u_tabpg_job_dim_check_gr
end type
type rb_gauge from radiobutton within u_tabpg_job_dim_check_gr
end type
type gb_1 from groupbox within u_tabpg_job_dim_check_gr
end type
end forward

global type u_tabpg_job_dim_check_gr from u_tabpg
integer width = 2703
integer height = 1290
dw_gr dw_gr
rb_len_dr rb_len_dr
rb_len_op rb_len_op
rb_width rb_width
rb_gauge rb_gauge
gb_1 gb_1
end type
global u_tabpg_job_dim_check_gr u_tabpg_job_dim_check_gr

type variables
long il_job
end variables

on u_tabpg_job_dim_check_gr.create
int iCurrent
call super::create
this.dw_gr=create dw_gr
this.rb_len_dr=create rb_len_dr
this.rb_len_op=create rb_len_op
this.rb_width=create rb_width
this.rb_gauge=create rb_gauge
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gr
this.Control[iCurrent+2]=this.rb_len_dr
this.Control[iCurrent+3]=this.rb_len_op
this.Control[iCurrent+4]=this.rb_width
this.Control[iCurrent+5]=this.rb_gauge
this.Control[iCurrent+6]=this.gb_1
end on

on u_tabpg_job_dim_check_gr.destroy
call super::destroy
destroy(this.dw_gr)
destroy(this.rb_len_dr)
destroy(this.rb_len_op)
destroy(this.rb_width)
destroy(this.rb_gauge)
destroy(this.gb_1)
end on

event constructor;call super::constructor;il_job = message.doubleparm
this.text = "Job # " + string( il_job ) + " QC graphic"
//st_skid.text = string( il_skid )
//dw_skid_dim.of_retrieve( )
end event

type dw_gr from u_dw within u_tabpg_job_dim_check_gr
integer x = 146
integer y = 410
integer width = 2414
integer height = 742
integer taborder = 20
string dataobject = "d_job_dim_gauge_gr"
end type

event constructor;call super::constructor;this.of_SetTransObject(SQLCA)
this.of_retrieve( )
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_job )
end event

type rb_len_dr from radiobutton within u_tabpg_job_dim_check_gr
integer x = 1931
integer y = 128
integer width = 413
integer height = 83
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Length-dr"
end type

event clicked;dw_gr.dataobject = "d_job_dim_len_dr_gr"
dw_gr.of_SetTransObject(SQLCA)
dw_gr.of_retrieve( )
end event

type rb_len_op from radiobutton within u_tabpg_job_dim_check_gr
integer x = 1404
integer y = 128
integer width = 413
integer height = 83
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Length-op"
end type

event clicked;dw_gr.dataobject = "d_job_dim_len_op_gr"
dw_gr.of_SetTransObject(SQLCA)
dw_gr.of_retrieve( )
end event

type rb_width from radiobutton within u_tabpg_job_dim_check_gr
integer x = 878
integer y = 128
integer width = 413
integer height = 83
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Width"
end type

event clicked;dw_gr.dataobject = "d_job_dim_width_gr"
dw_gr.of_SetTransObject(SQLCA)
dw_gr.of_retrieve( )
end event

type rb_gauge from radiobutton within u_tabpg_job_dim_check_gr
integer x = 351
integer y = 128
integer width = 413
integer height = 83
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gauge"
boolean checked = true
end type

event clicked;dw_gr.dataobject = "d_job_dim_gauge_gr"
dw_gr.of_SetTransObject(SQLCA)
dw_gr.of_retrieve( )
end event

type gb_1 from groupbox within u_tabpg_job_dim_check_gr
integer x = 146
integer y = 38
integer width = 2414
integer height = 256
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Graph"
end type

