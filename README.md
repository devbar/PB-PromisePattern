PB-PromisePattern
=========

This is an example how to use the promise pattern (popular in the JavaScript world) in PowerScript. Coding asynchronous in PowerScript can be painfull. So making methods ready for asynchronism should produce a minimum effort.

Example:

```
//////////////////////////////////////////////////////////////////////////////
// Name:
//	of_search
// Description: 
// 	This is a classical method to search prime numbers. It is not effecient but 
// 	this is not what we want here.
// 
// Arguments
//	al_start	long	This is the first number to check
//	al_end		long	This is the last number to check
//	rla_numbers[]	This is the resultset of numbers if we call this synchronously
//	promise		This is the communication object if we call this asynchronously
//

long	ll_number, ll_numberCount, ll_divider, ll_dividerCount
boolean	lb_prime
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
```
The method is callable synchronous. To have a asynchronous entry point use this kind of method.

```
//////////////////////////////////////////////////////////////////////////////
// Name:
//	of_searchAsync
// Description: 
// 	This is or asynchronous method with the promise object to return.
// 

n_cst_promise	promise
n_cst_primer	primer

// Here is a pitfull! The of_shareObject creates a new instance of primer.
// If your method is not "stateless" it is necessary to make a "deep copy".
primer = inv_async.of_shareObject(this)

promise = create n_cst_promise
primer.post of_search(al_start, al_end, promise)

return promise
```
You are able to chain result processing of the asynchronous call.
```
primer = create n_cst_primer

of_print("Start Call Async")

// You can chain the events to call on complete,
// error or if the progress changes
primer.of_searchAsync(ll_start, ll_end) &
	.of_then() &
		.of_complete(parent, "ue_searchcomplete") &
		.of_error(parent, "ue_searchfailed") &
		.of_progress(parent, "ue_progress") &
	.of_done()
```

![ScreenShot](./resources/PromisePattern.png)


