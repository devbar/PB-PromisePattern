HA$PBExportHeader$n_cst_promise_result.sru
forward
global type n_cst_promise_result from nonvisualobject
end type
end forward

global type n_cst_promise_result from nonvisualobject
end type
global n_cst_promise_result n_cst_promise_result

type variables
protected:

any	ia_returnValue
any	iaa_referenceArguments[]
end variables
forward prototypes
public subroutine of_setreturnvalue (any aa_value)
public function any of_getreturnvalue ()
public subroutine of_addreferenceargument (any aa_value)
public function any of_getreferenceargument (long al_index)
end prototypes

public subroutine of_setreturnvalue (any aa_value);ia_returnValue = aa_value
end subroutine

public function any of_getreturnvalue ();return ia_returnValue
end function

public subroutine of_addreferenceargument (any aa_value);iaa_referenceArguments[upperBound(iaa_referenceArguments)+1] = aa_value
end subroutine

public function any of_getreferenceargument (long al_index);return iaa_referenceArguments[al_index]
end function

on n_cst_promise_result.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_promise_result.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

