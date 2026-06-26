$PBExportHeader$w_distributed_test.srw
forward
global type w_distributed_test from w_popup
end type
type cb_1 from u_cb within w_distributed_test
end type
type cb_2 from u_cb within w_distributed_test
end type
type cb_3 from u_cb within w_distributed_test
end type
type cb_4 from u_cb within w_distributed_test
end type
type sle_1 from u_sle within w_distributed_test
end type
end forward

global type w_distributed_test from w_popup
int Width=2447
int Height=944
boolean TitleBar=true
string Title="Distributed Applicatioin"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
sle_1 sle_1
end type
global w_distributed_test w_distributed_test

event open;call super::open;/*
//Connection 
connection myconnect
myconnect = create connection
string ErrText, ErrNo
myconnect.driver = "WinSock"
myconnect.application = "lion"
myconnect.location = "NT"
myconnect.ConnectToServer()
ErrNo = string(myconnect.ErrCode)
IF ErrNo <> "0" THEN
	ErrText = myconnect.ErrText
	MessageBox("Connection failed", ErrNo + ":" +ErrText)
	Return
End IF

//Proxy
long ll_result
string ls_custid
po_n_cst_comm po_my_n_cst_comm

po_my_n_cst_comm = create po_n_cst_comm
po_my_n_cst_comm.setconnect(myconnect)

//Invoke methods of remote objects
//ll_result=po_my_cst_comm.test1()
*/
end event

on w_distributed_test.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.sle_1
end on

on w_distributed_test.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.sle_1)
end on

type cb_1 from u_cb within w_distributed_test
int X=1273
int Y=128
int Width=1090
int TabOrder=30
string Text="Connect To Server -> Set Proxy->Invoke Mehthod"
end type

event clicked;call super::clicked;//Connection 
connection myconnect
myconnect = create connection
string ErrText, ErrNo
myconnect.driver = "Winsock"
myconnect.application = "lion"
myconnect.location = "SHUTTLE"
myconnect.ConnectToServer()
ErrNo = string(myconnect.ErrCode)
IF ErrNo <> "0" THEN
	ErrText = myconnect.ErrText
	MessageBox("Connection failed", ErrNo + ":" +ErrText)
	Return
End IF

//Proxy
long ll_result
string ls_custid
po_n_cst_comm po_my_n_cst_comm

po_my_n_cst_comm = create po_n_cst_comm
po_my_n_cst_comm.setconnect(myconnect)

//Invoke methods of remote objects
ll_result=po_my_n_cst_comm.test1()
sle_1.text = string(ll_result)

destroy po_my_n_cst_comm

end event

type cb_2 from u_cb within w_distributed_test
int X=1317
int Y=531
int TabOrder=40
boolean BringToTop=true
string Text="Test1"
end type

event clicked;call super::clicked;//Invoke methods of remote objects
//ll_result=po_my_cst_comm.test1()
end event

type cb_3 from u_cb within w_distributed_test
int X=80
int Y=125
int Width=812
int TabOrder=20
boolean BringToTop=true
string Text="Start Listening(Set Transport Object)"
end type

event clicked;//n_trp mytransport
//mytransport = create n_trp
//string ErrText, ErrNo
//mytransport.driver = "WinSock"
//mytransport.application = "lion"
//mytransport.Listen()
//ErrNo = String(mytransport.ErrCode)
//IF ErrNo <> "0" THEN
//	ErrText = mytransport.ErrText
//	MessageBox("Unabel to start Server", ErrNo + ":" + ErrText)
//	Return
//End IF
end event

type cb_4 from u_cb within w_distributed_test
int X=88
int Y=288
int Width=783
int TabOrder=10
boolean BringToTop=true
string Text="Stop Listening"
end type

type sle_1 from u_sle within w_distributed_test
int X=1324
int Y=266
int TabOrder=2
end type

