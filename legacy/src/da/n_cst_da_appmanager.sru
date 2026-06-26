$PBExportHeader$n_cst_da_appmanager.sru
forward
global type n_cst_da_appmanager from n_cst_appmanager
end type
end forward

global type n_cst_da_appmanager from n_cst_appmanager
string is_appinifile = "C:\abis\downtime.ini"
string is_version = "PFC 9.0"
string is_logo = ".\ABIS.jpg"
end type
global n_cst_da_appmanager n_cst_da_appmanager

on n_cst_da_appmanager.create
call super::create
end on

on n_cst_da_appmanager.destroy
call super::destroy
end on

event pfc_open;call super::pfc_open;int li_rc
this.of_seterror( true)
this.inv_error.of_setpredefinedsource( "err.txt")
IF li_rc = -1 THEN
          MessageBox("of_SetPredefinedSource failed", "Please ensure errors.txt exists")
     END IF
this.inv_error.of_setlogfile( "errlog.txt")
this.inv_error.of_setstyle( 1)
this.inv_error.of_setlogseverity( 4)
this.inv_error.of_SetTimeOut(30)
open(w_da_frame)
end event

