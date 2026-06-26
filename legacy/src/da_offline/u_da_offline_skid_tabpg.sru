$PBExportHeader$u_da_offline_skid_tabpg.sru
forward
global type u_da_offline_skid_tabpg from u_da_skid_tabpg
end type
end forward

global type u_da_offline_skid_tabpg from u_da_skid_tabpg
end type
global u_da_offline_skid_tabpg u_da_offline_skid_tabpg

on u_da_offline_skid_tabpg.create
call super::create
end on

on u_da_offline_skid_tabpg.destroy
call super::destroy
end on

type cb_reset_pcs from u_da_skid_tabpg`cb_reset_pcs within u_da_offline_skid_tabpg
boolean visible = false
end type

type st_offset from u_da_skid_tabpg`st_offset within u_da_offline_skid_tabpg
boolean visible = false
end type

type em_offset from u_da_skid_tabpg`em_offset within u_da_offline_skid_tabpg
boolean visible = false
end type

type cb_retrieve from u_da_skid_tabpg`cb_retrieve within u_da_offline_skid_tabpg
end type

type cb_ref from u_da_skid_tabpg`cb_ref within u_da_offline_skid_tabpg
end type

type cb_edit from u_da_skid_tabpg`cb_edit within u_da_offline_skid_tabpg
end type

type cb_delete from u_da_skid_tabpg`cb_delete within u_da_offline_skid_tabpg
end type

type cb_print from u_da_skid_tabpg`cb_print within u_da_offline_skid_tabpg
end type

type cb_done_skid from u_da_skid_tabpg`cb_done_skid within u_da_offline_skid_tabpg
end type

type cb_load_partial from u_da_skid_tabpg`cb_load_partial within u_da_offline_skid_tabpg
end type

type cb_new_skid from u_da_skid_tabpg`cb_new_skid within u_da_offline_skid_tabpg
end type

type st_1 from u_da_skid_tabpg`st_1 within u_da_offline_skid_tabpg
end type

type dw_current_edit from u_da_skid_tabpg`dw_current_edit within u_da_offline_skid_tabpg
end type

type dw_skid_item from u_da_skid_tabpg`dw_skid_item within u_da_offline_skid_tabpg
end type

type cb_dim_check from u_da_skid_tabpg`cb_dim_check within u_da_offline_skid_tabpg
end type

type st_2 from u_da_skid_tabpg`st_2 within u_da_offline_skid_tabpg
end type

