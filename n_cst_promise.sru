HA$PBExportHeader$n_cst_promise.sru
forward
global type n_cst_promise from nonvisualobject
end type
end forward

global type n_cst_promise from nonvisualobject
end type
global n_cst_promise n_cst_promise

type variables
protected:

n_cst_promise_then	inv_then
n_cst_promise_done	inv_done
end variables
forward prototypes
public function n_cst_promise_then of_then ()
public function n_cst_promise_done of_done ()
end prototypes

public function n_cst_promise_then of_then ();if not isValid(inv_then) then
	inv_then = create n_cst_promise_then
end if

return inv_then
end function

public function n_cst_promise_done of_done ();if not isValid(inv_done) then
	inv_done = create n_cst_promise_done
end if

return inv_done
end function

on n_cst_promise.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_promise.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

