$PBExportHeader$w_wh_detail.srw
$PBExportComments$<Child> display detail information of an warehouse item
forward
global type w_wh_detail from w_child
end type
type cb_cancel from u_cb within w_wh_detail
end type
type dw_wh_detail from u_dw within w_wh_detail
end type
end forward

global type w_wh_detail from w_child
int X=1123
int Y=250
int Width=1236
int Height=1014
WindowType WindowType=response!
boolean TitleBar=true
string Title="Item Information"
string Tag="detail information of warehouse item"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_cancel cb_cancel
dw_wh_detail dw_wh_detail
end type
global w_wh_detail w_wh_detail

on w_wh_detail.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.dw_wh_detail=create dw_wh_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.dw_wh_detail
end on

on w_wh_detail.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.dw_wh_detail)
end on

event open;call super::open;dw_wh_detail.SetTransObject(sqlca)
dw_wh_detail.Retrieve(message.doubleparm)
this.title = "Warehouse Item:  " + String(message.doubleparm)
dw_wh_detail.SetFocus()

end event

type cb_cancel from u_cb within w_wh_detail
event clicked pbm_bnclicked
int X=406
int Y=822
int TabOrder=20
string Tag="Close"
string Text="&Cancel"
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(parent)
end event

type dw_wh_detail from u_dw within w_wh_detail
event constructor pbm_constructor
int X=44
int Y=22
int Width=1141
int Height=762
int TabOrder=10
string Tag="Detail information of an whrehouse item"
string DataObject="d_wh_item"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;DataWindowChild ldddw_cni

IF this.GetChild("wh_product_from", ldddw_cni) = -1 THEN
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("wh_product_from", ldddw_cni)
END IF
IF this.GetChild("wh_product_to", ldddw_cni) = -1 THEN
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("wh_product_to", ldddw_cni)
END IF
IF this.GetChild("wh_bill_to", ldddw_cni) = -1 THEN
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("wh_bill_to", ldddw_cni)
END IF

//this.Event pfc_RetrieveDDDW("wh_product_from")
//this.Event pfc_RetrieveDDDW("wh_product_to")
//this.Event pfc_RetrieveDDDW("wh_bill_to")

end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

