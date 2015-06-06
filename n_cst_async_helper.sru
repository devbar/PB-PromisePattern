HA$PBExportHeader$n_cst_async_helper.sru
forward
global type n_cst_async_helper from nonvisualobject
end type
end forward

global type n_cst_async_helper from nonvisualobject autoinstantiate
end type

forward prototypes
public function powerobject of_shareobject (powerobject pbobject)
public subroutine of_cleanup ()
end prototypes

public function powerobject of_shareobject (powerobject pbobject);string		ls_signatur
powerobject	sharedobject

randomize(0)
ls_signatur = classname(pbobject) + string(rand(20000))

SharedObjectRegister(classname(pbobject), ls_signatur)
SharedObjectGet(ls_signatur, ref sharedobject)

return sharedobject
end function

public subroutine of_cleanup ();long		ll_index, ll_count
string	lsa_instances[]

SharedObjectDirectory(ref lsa_instances)

for ll_index = 1 to ll_count
	SharedObjectUnregister(lsa_instances[ll_index])
next
end subroutine

on n_cst_async_helper.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_async_helper.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

