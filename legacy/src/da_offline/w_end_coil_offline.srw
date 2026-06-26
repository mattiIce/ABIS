$PBExportHeader$w_end_coil_offline.srw
$PBExportComments$<Response> finish a coil inherited from pfemain/w_sheet
forward
global type w_end_coil_offline from w_sheet
end type
type rb_2 from u_rb within w_end_coil_offline
end type
type st_4 from statictext within w_end_coil_offline
end type
type em_wt from u_em within w_end_coil_offline
end type
type rb_4 from u_rb within w_end_coil_offline
end type
type rb_7 from u_rb within w_end_coil_offline
end type
type rb_3 from u_rb within w_end_coil_offline
end type
type st_3 from statictext within w_end_coil_offline
end type
type rb_0 from u_rb within w_end_coil_offline
end type
type st_abc_id from statictext within w_end_coil_offline
end type
type st_org_id from statictext within w_end_coil_offline
end type
type st_2 from statictext within w_end_coil_offline
end type
type st_1 from statictext within w_end_coil_offline
end type
type cb_save from u_cb within w_end_coil_offline
end type
type cb_close from u_cb within w_end_coil_offline
end type
type gb_select from u_gb within w_end_coil_offline
end type
end forward

global type w_end_coil_offline from w_sheet
integer x = 318
integer y = 144
integer width = 2194
integer height = 1133
string title = "Finishing a coil"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
rb_2 rb_2
st_4 st_4
em_wt em_wt
rb_4 rb_4
rb_7 rb_7
rb_3 rb_3
st_3 st_3
rb_0 rb_0
st_abc_id st_abc_id
st_org_id st_org_id
st_2 st_2
st_1 st_1
cb_save cb_save
cb_close cb_close
gb_select gb_select
end type
global w_end_coil_offline w_end_coil_offline

type variables
Long il_coil, il_wt, il_job
end variables

on w_end_coil_offline.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.st_4=create st_4
this.em_wt=create em_wt
this.rb_4=create rb_4
this.rb_7=create rb_7
this.rb_3=create rb_3
this.st_3=create st_3
this.rb_0=create rb_0
this.st_abc_id=create st_abc_id
this.st_org_id=create st_org_id
this.st_2=create st_2
this.st_1=create st_1
this.cb_save=create cb_save
this.cb_close=create cb_close
this.gb_select=create gb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.em_wt
this.Control[iCurrent+4]=this.rb_4
this.Control[iCurrent+5]=this.rb_7
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.rb_0
this.Control[iCurrent+9]=this.st_abc_id
this.Control[iCurrent+10]=this.st_org_id
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.cb_save
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.gb_select
end on

on w_end_coil_offline.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.st_4)
destroy(this.em_wt)
destroy(this.rb_4)
destroy(this.rb_7)
destroy(this.rb_3)
destroy(this.st_3)
destroy(this.rb_0)
destroy(this.st_abc_id)
destroy(this.st_org_id)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.gb_select)
end on

event open;call super::open;String ls_coil_id
s_job_and_coil lstr_t

lstr_t = message.PowerObjectParm
il_coil = lstr_t.coil_num
il_job = lstr_t.job_num

SELECT coil_org_num, net_wt_balance INTO :ls_coil_id, :il_wt
FROM Coil 
WHERE coil_abc_num = :il_coil
USING SQLCA;

st_org_id.Text = ls_coil_id
st_abc_id.Text = String(il_coil)


end event

type rb_2 from u_rb within w_end_coil_offline
integer x = 717
integer y = 765
integer textsize = -12
string facename = "Arial"
string text = "New"
end type

event clicked;call super::clicked;IF this.Checked THEN
	em_wt.Text = String (il_wt)
	em_wt.Enabled = FALSE
END IF

end event

type st_4 from statictext within w_end_coil_offline
integer x = 1401
integer y = 646
integer width = 702
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Remaining Weight:"
boolean focusrectangle = false
end type

type em_wt from u_em within w_end_coil_offline
integer x = 1397
integer y = 742
integer width = 662
integer height = 109
integer taborder = 40
integer textsize = -12
string facename = "Arial"
boolean enabled = false
string mask = "#########"
end type

type rb_4 from u_rb within w_end_coil_offline
integer x = 717
integer y = 653
integer textsize = -12
string facename = "Arial"
string text = "OnHold"
end type

event clicked;call super::clicked;IF this.Checked THEN
	em_wt.Text = ""
	em_wt.Enabled = TRUE
END IF

end event

type rb_7 from u_rb within w_end_coil_offline
integer x = 168
integer y = 765
integer textsize = -12
string facename = "Arial"
string text = "Rebanded"
end type

event clicked;call super::clicked;IF this.Checked THEN
	em_wt.Text = ""
	em_wt.Enabled = TRUE
END IF

end event

type rb_3 from u_rb within w_end_coil_offline
integer x = 168
integer y = 653
integer textsize = -12
string facename = "Arial"
string text = "Rejected"
end type

event clicked;call super::clicked;IF this.Checked THEN
	em_wt.Text = ""
	em_wt.Enabled = TRUE
END IF
	
end event

type st_3 from statictext within w_end_coil_offline
integer x = 227
integer y = 518
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

type rb_0 from u_rb within w_end_coil_offline
integer x = 168
integer y = 416
integer textsize = -12
string facename = "Arial"
string text = "Done"
boolean checked = true
end type

event clicked;call super::clicked;IF this.Checked THEN
	em_wt.Text = "0"
	em_wt.Enabled = FALSE
END IF
	
end event

type st_abc_id from statictext within w_end_coil_offline
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

type st_org_id from statictext within w_end_coil_offline
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

type st_2 from statictext within w_end_coil_offline
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

type st_1 from statictext within w_end_coil_offline
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

type cb_save from u_cb within w_end_coil_offline
integer x = 560
integer y = 902
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

Long ll_newwt
Int li_status
DateTime ldt_t

ll_newwt = Long(em_wt.Text)

IF ll_newwt > il_wt THEN
	MessageBox("Error", "Coil's new weight more than its original weight.")
	RETURN -1
END IF

IF rb_0.Checked THEN li_status = 0
IF rb_2.Checked THEN li_status = 2
IF rb_3.Checked THEN li_status = 3
IF rb_4.Checked THEN li_status = 4
IF rb_7.Checked THEN li_status = 7

ldt_t = DateTime(Today(),Now())

UPDATE Coil
SET net_wt_balance = :ll_newwt, coil_status = :li_status
WHERE coil_abc_num = :il_coil
USING SQLCA;

UPDATE "PROCESS_COIL"  
SET "PROCESS_COIL_STATUS" = :li_status,   
    "PROCESS_QUANTITY" = :il_wt,   
    "PROCESS_DATE" = :ldt_t,   
    "SHIFT_PROCESS_STATUS" = :li_status ,   
    "CURRENT_WT" = :ll_newwt ,   
    "PROCESS_END_WT" = :ll_newwt  
WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :il_coil ) AND  
         ( "PROCESS_COIL"."AB_JOB_NUM" = :il_job )  
USING SQLCA;

	if sqlca.sqlcode <> 0 then 
		sqlca.of_rollback( )
		return 1
	else
		sqlca.of_commit( )
		return 0
	end if

CloseWithReturn(Parent,1)
end event

type cb_close from u_cb within w_end_coil_offline
string tag = "Close without selection"
integer x = 1185
integer y = 902
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

type gb_select from u_gb within w_end_coil_offline
integer x = 37
integer y = 288
integer width = 2110
integer height = 592
integer taborder = 10
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Please select a new status"
end type

