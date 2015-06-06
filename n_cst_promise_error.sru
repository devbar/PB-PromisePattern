HA$PBExportHeader$n_cst_promise_error.sru
forward
global type n_cst_promise_error from nonvisualobject
end type
end forward

global type n_cst_promise_error from nonvisualobject
end type
global n_cst_promise_error n_cst_promise_error

type variables
protected:

string	is_message
long		il_code
end variables
forward prototypes
public subroutine of_setmessage (string as_message)
public subroutine of_setcode (long al_code)
public function long of_getcode ()
public function string of_getmessage ()
end prototypes

public subroutine of_setmessage (string as_message);is_message = as_message
end subroutine

public subroutine of_setcode (long al_code);il_code = al_code
end subroutine

public function long of_getcode ();return il_code
end function

public function string of_getmessage ();return is_message
end function

on n_cst_promise_error.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_promise_error.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

