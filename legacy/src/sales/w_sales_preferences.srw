$PBExportHeader$w_sales_preferences.srw
$PBExportComments$<Response> Perferences window inherited from w_response
forward
global type w_sales_preferences from w_response
end type
type tab_perf from tab within w_sales_preferences
end type
type tabpage_gen from userobject within tab_perf
end type
type tabpage_gen from userobject within tab_perf
end type
type tabpage_myself from userobject within tab_perf
end type
type tabpage_myself from userobject within tab_perf
end type
type tabpage_email from userobject within tab_perf
end type
type tabpage_email from userobject within tab_perf
end type
type tabpage_phone from userobject within tab_perf
end type
type tabpage_phone from userobject within tab_perf
end type
type tabpage_catalog from userobject within tab_perf
end type
type tabpage_catalog from userobject within tab_perf
end type
type tabpage_contact from userobject within tab_perf
end type
type tabpage_contact from userobject within tab_perf
end type
type tabpage_material from userobject within tab_perf
end type
type tab_quote from tab within tabpage_material
end type
type tabpage_intrlv from userobject within tab_quote
end type
type tabpage_intrlv from userobject within tab_quote
end type
type tabpage_wood from userobject within tab_quote
end type
type tabpage_wood from userobject within tab_quote
end type
type tabpage_bflute from userobject within tab_quote
end type
type tabpage_bflute from userobject within tab_quote
end type
type tabpage_wrap from userobject within tab_quote
end type
type tabpage_wrap from userobject within tab_quote
end type
type tabpage_guards from userobject within tab_quote
end type
type tabpage_guards from userobject within tab_quote
end type
type tabpage_nail from userobject within tab_quote
end type
type tabpage_nail from userobject within tab_quote
end type
type tabpage_strapping from userobject within tab_quote
end type
type tabpage_strapping from userobject within tab_quote
end type
type tabpage_seal from userobject within tab_quote
end type
type tabpage_seal from userobject within tab_quote
end type
type tabpage_pvc from userobject within tab_quote
end type
type tabpage_pvc from userobject within tab_quote
end type
type tab_quote from tab within tabpage_material
tabpage_intrlv tabpage_intrlv
tabpage_wood tabpage_wood
tabpage_bflute tabpage_bflute
tabpage_wrap tabpage_wrap
tabpage_guards tabpage_guards
tabpage_nail tabpage_nail
tabpage_strapping tabpage_strapping
tabpage_seal tabpage_seal
tabpage_pvc tabpage_pvc
end type
type tabpage_material from userobject within tab_perf
tab_quote tab_quote
end type
type tab_perf from tab within w_sales_preferences
tabpage_gen tabpage_gen
tabpage_myself tabpage_myself
tabpage_email tabpage_email
tabpage_phone tabpage_phone
tabpage_catalog tabpage_catalog
tabpage_contact tabpage_contact
tabpage_material tabpage_material
end type
type cb_save from u_cb within w_sales_preferences
end type
type cb_close from u_cb within w_sales_preferences
end type
type cb_cancel from u_cb within w_sales_preferences
end type
end forward

global type w_sales_preferences from w_response
integer width = 2505
integer height = 1526
string title = "Perferences"
tab_perf tab_perf
cb_save cb_save
cb_close cb_close
cb_cancel cb_cancel
end type
global w_sales_preferences w_sales_preferences

on w_sales_preferences.create
int iCurrent
call super::create
this.tab_perf=create tab_perf
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_perf
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_cancel
end on

on w_sales_preferences.destroy
call super::destroy
destroy(this.tab_perf)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_cancel)
end on

type tab_perf from tab within w_sales_preferences
integer y = 6
integer width = 2491
integer height = 1334
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_gen tabpage_gen
tabpage_myself tabpage_myself
tabpage_email tabpage_email
tabpage_phone tabpage_phone
tabpage_catalog tabpage_catalog
tabpage_contact tabpage_contact
tabpage_material tabpage_material
end type

on tab_perf.create
this.tabpage_gen=create tabpage_gen
this.tabpage_myself=create tabpage_myself
this.tabpage_email=create tabpage_email
this.tabpage_phone=create tabpage_phone
this.tabpage_catalog=create tabpage_catalog
this.tabpage_contact=create tabpage_contact
this.tabpage_material=create tabpage_material
this.Control[]={this.tabpage_gen,&
this.tabpage_myself,&
this.tabpage_email,&
this.tabpage_phone,&
this.tabpage_catalog,&
this.tabpage_contact,&
this.tabpage_material}
end on

on tab_perf.destroy
destroy(this.tabpage_gen)
destroy(this.tabpage_myself)
destroy(this.tabpage_email)
destroy(this.tabpage_phone)
destroy(this.tabpage_catalog)
destroy(this.tabpage_contact)
destroy(this.tabpage_material)
end on

type tabpage_gen from userobject within tab_perf
integer x = 15
integer y = 90
integer width = 2461
integer height = 1232
long backcolor = 12639424
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
string picturename = "Application!"
long picturemaskcolor = 553648127
end type

type tabpage_myself from userobject within tab_perf
integer x = 15
integer y = 90
integer width = 2461
integer height = 1232
long backcolor = 12632256
string text = "Myself"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Custom076!"
long picturemaskcolor = 536870912
end type

type tabpage_email from userobject within tab_perf
integer x = 15
integer y = 90
integer width = 2461
integer height = 1232
long backcolor = 8421376
string text = "Email"
long tabtextcolor = 33554432
long tabbackcolor = 8421376
string picturename = "Custom002!"
long picturemaskcolor = 536870912
end type

type tabpage_phone from userobject within tab_perf
integer x = 15
integer y = 90
integer width = 2461
integer height = 1232
long backcolor = 65535
string text = "Phone/Fax"
long tabtextcolor = 33554432
long tabbackcolor = 65535
string picturename = "Custom020!"
long picturemaskcolor = 536870912
end type

type tabpage_catalog from userobject within tab_perf
integer x = 15
integer y = 90
integer width = 2461
integer height = 1232
long backcolor = 16776960
string text = "Catalog"
long tabtextcolor = 33554432
long tabbackcolor = 16776960
string picturename = "UserObject!"
long picturemaskcolor = 536870912
end type

type tabpage_contact from userobject within tab_perf
integer x = 15
integer y = 90
integer width = 2461
integer height = 1232
long backcolor = 16777215
string text = "Contact"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "Properties!"
long picturemaskcolor = 536870912
end type

type tabpage_material from userobject within tab_perf
integer x = 15
integer y = 90
integer width = 2461
integer height = 1232
long backcolor = 15780518
string text = "Material"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "UserObject5!"
long picturemaskcolor = 536870912
tab_quote tab_quote
end type

on tabpage_material.create
this.tab_quote=create tab_quote
this.Control[]={this.tab_quote}
end on

on tabpage_material.destroy
destroy(this.tab_quote)
end on

type tab_quote from tab within tabpage_material
integer y = 10
integer width = 2458
integer height = 1219
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean fixedwidth = true
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
tabposition tabposition = tabsonbottom!
integer selectedtab = 1
tabpage_intrlv tabpage_intrlv
tabpage_wood tabpage_wood
tabpage_bflute tabpage_bflute
tabpage_wrap tabpage_wrap
tabpage_guards tabpage_guards
tabpage_nail tabpage_nail
tabpage_strapping tabpage_strapping
tabpage_seal tabpage_seal
tabpage_pvc tabpage_pvc
end type

on tab_quote.create
this.tabpage_intrlv=create tabpage_intrlv
this.tabpage_wood=create tabpage_wood
this.tabpage_bflute=create tabpage_bflute
this.tabpage_wrap=create tabpage_wrap
this.tabpage_guards=create tabpage_guards
this.tabpage_nail=create tabpage_nail
this.tabpage_strapping=create tabpage_strapping
this.tabpage_seal=create tabpage_seal
this.tabpage_pvc=create tabpage_pvc
this.Control[]={this.tabpage_intrlv,&
this.tabpage_wood,&
this.tabpage_bflute,&
this.tabpage_wrap,&
this.tabpage_guards,&
this.tabpage_nail,&
this.tabpage_strapping,&
this.tabpage_seal,&
this.tabpage_pvc}
end on

on tab_quote.destroy
destroy(this.tabpage_intrlv)
destroy(this.tabpage_wood)
destroy(this.tabpage_bflute)
destroy(this.tabpage_wrap)
destroy(this.tabpage_guards)
destroy(this.tabpage_nail)
destroy(this.tabpage_strapping)
destroy(this.tabpage_seal)
destroy(this.tabpage_pvc)
end on

type tabpage_intrlv from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "Interleave"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Compile!"
long picturemaskcolor = 536870912
end type

type tabpage_wood from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "Wood"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom040!"
long picturemaskcolor = 536870912
end type

type tabpage_bflute from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "B-Flute"
long tabbackcolor = 15780518
string picturename = "CheckOut5!"
long picturemaskcolor = 536870912
end type

type tabpage_wrap from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "Wrap"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Comment!"
long picturemaskcolor = 536870912
end type

type tabpage_guards from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "Edge Guards"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Menu5!"
long picturemaskcolor = 536870912
end type

type tabpage_nail from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "Nails"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "DataManip!"
long picturemaskcolor = 536870912
end type

type tabpage_strapping from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "Strapping"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "DatabaseProfile!"
long picturemaskcolor = 536870912
end type

type tabpage_seal from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "Seals-Metal"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom069!"
long picturemaskcolor = 536870912
end type

type tabpage_pvc from userobject within tab_quote
integer x = 15
integer y = 13
integer width = 2428
integer height = 1040
long backcolor = 15793151
string text = "PVC"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom053!"
long picturemaskcolor = 536870912
end type

type cb_save from u_cb within w_sales_preferences
integer x = 1375
integer y = 1354
integer width = 351
integer height = 93
integer taborder = 20
string facename = "Arial"
string text = "&Save"
end type

type cb_close from u_cb within w_sales_preferences
integer x = 2143
integer y = 1354
integer width = 351
integer height = 93
integer taborder = 20
string facename = "Arial"
string text = "C&lose"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_cancel from u_cb within w_sales_preferences
integer x = 1759
integer y = 1354
integer width = 351
integer height = 93
integer taborder = 10
string facename = "Arial"
string text = "&Cancel"
end type

