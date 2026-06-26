$PBExportHeader$n_cst_comm.sru
$PBExportComments$communication ralated services including fax, email and EDI etc.
forward
global type n_cst_comm from nonvisualobject
end type
end forward

global type n_cst_comm from nonvisualobject
string ProxyName="po_n_cst_comm"
end type
global n_cst_comm n_cst_comm

forward prototypes
public function integer beeper1 ()
public function integer test1 ()
end prototypes

public function integer beeper1 ();int rc
char retmsg[100]
string port, baud, modem_init_str, modem_dial_str
string access_number, pager_id, max_chars_per_blk, msg, debug_file
string delay_seconds,termination_str, digits_to_send

port="COM2"
baud="300"
modem_init_str=""
modem_dial_str=""

max_chars_per_blk="80"
access_number="13136067099"
pager_id="5856873"

msg="5856873"

digits_to_send="5856873"
delay_seconds="10"
termination_str="H"

debug_file="\pagedebug.txt"

//rc= send_alpha_page(port, baud, modem_init_str, &
	//modem_dial_str, access_number, &
	//pager_id, max_chars_per_blk, msg, debug_file, retmsg)

//rc= beeper(port, baud, modem_init_str, &
//	modem_dial_str, access_number, &
//	delay_seconds, msg, termination_str, retmsg)

//rc= beeper(port, baud, modem_init_str, &
//   modem_dial_str,access_number,  &
//	delay_seconds,digits_to_send, termination_str,  retmsg) 

//MessageBox("Done",retmsg)

return 1

end function

public function integer test1 ();return 100
end function

on n_cst_comm.create
TriggerEvent( this, "constructor" )
end on

on n_cst_comm.destroy
TriggerEvent( this, "destructor" )
end on

