HA$PBExportHeader$n_cst_promise_progress.sru
forward
global type n_cst_promise_progress from nonvisualobject
end type
end forward

global type n_cst_promise_progress from nonvisualobject
end type
global n_cst_promise_progress n_cst_promise_progress

type variables
protected:

any 	iaa_arguments[]
end variables
forward prototypes
public subroutine of_addargument (any aa_value)
public function any of_getargument (long al_index)
end prototypes

public subroutine of_addargument (any aa_value);iaa_arguments[upperBound(iaa_arguments)+1] = aa_value
end subroutine

public function any of_getargument (long al_index);return iaa_arguments[al_index]
end function

on n_cst_promise_progress.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_promise_progress.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

