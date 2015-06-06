HA$PBExportHeader$n_cst_primer.sru
forward
global type n_cst_primer from nonvisualobject
end type
end forward

global type n_cst_primer from nonvisualobject
end type
global n_cst_primer n_cst_primer

type variables
protected:

n_cst_async_helper	inv_async
end variables

forward prototypes
public function n_cst_promise of_searchasync (long al_start, long al_end)
public subroutine of_search (long al_start, long al_end, n_cst_promise promise)
public function long of_search (long al_start, long al_end, ref long rla_numbers[], n_cst_promise promise)
public function integer of_search (long al_start, long al_end, ref long rla_numbers[])
end prototypes

public function n_cst_promise of_searchasync (long al_start, long al_end);//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is or asynchronous method with the promise object to return.
// 
// Author: 
// B.Kemner, 04.05.2015 
// 

n_cst_promise	promise
n_cst_primer	primer

// Here is a pitfull! The of_shareObject creates a new instance of primer.
// If your method is not "stateless" it is necessary to make a "deep copy".
primer = inv_async.of_shareObject(this)

promise = create n_cst_promise
primer.post of_search(al_start, al_end, promise)

return promise
end function

public subroutine of_search (long al_start, long al_end, n_cst_promise promise);//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is a small wrapper for the asynchronous call. Collect the result and
// send it to the promise object.
// 
// Author: 
// B.Kemner, 04.05.2015 
// 

long						ll_return, lla_numbers[]
n_cst_promise_result	result
n_cst_promise_error	err

ll_return = of_search(al_start, al_end, ref lla_numbers, promise)

if ll_return < 0 then
	err = create n_cst_promise_error
	err.of_setCode(ll_return)
	
	promise.of_then().post event ue_error(err)
else	
	result = create n_cst_promise_result
	result.of_setReturnValue(ll_return)
	result.of_addReferenceArgument(lla_numbers)
	
	promise.of_then().post event ue_complete(result)
end if


end subroutine

public function long of_search (long al_start, long al_end, ref long rla_numbers[], n_cst_promise promise);//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is classical method to search prime numbers. It is not effecient but 
// this is not what we want here.
// 
// Author: 
// B.Kemner, 04.05.2015 
//
//	Arguments
//		al_start			long	This is the first number to check
//		al_end			long	This is the last number to check
//		rla_numbers[]	This is the resultset of numbers if we call this synchronously
//		promise			This is the communication object if we call this asynchronously
//

long 							ll_number, ll_numberCount, ll_divider, ll_dividerCount
boolean 						lb_prime
n_cst_promise_progress	progress

if al_start < 0 then return -2
if al_end < 0 then return -3

for ll_number = al_start to al_end
	lb_prime = true
	
	// This is only necessary if you want to capture
	// the progress of your asynchronous called method
	if isValid(promise) then
		progress = create n_cst_promise_progress
		progress.of_addArgument(ll_number)
		promise.of_then().event ue_progress(progress)
	end if
	
	for ll_divider = 2 to ll_number -1
		if mod(ll_number, ll_divider) = 0 then
			lb_prime = false
		end if
	next
	
	if lb_prime then
		rla_numbers[upperBound(rla_numbers)+1] = ll_number
	end if
next

return upperBound(rla_numbers)
end function

public function integer of_search (long al_start, long al_end, ref long rla_numbers[]);//////////////////////////////////////////////////////////////////////////////
// Description: 
// The classical synchronous call. We don't need the promise object so 
// give a dummy for this onverloading.
// 
// Author: 
// B.Kemner, 04.05.2015 
// 


n_cst_promise	promise

return of_search(al_start, al_end, ref rla_numbers, promise)
end function

on n_cst_primer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_primer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

