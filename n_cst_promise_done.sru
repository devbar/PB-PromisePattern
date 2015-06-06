HA$PBExportHeader$n_cst_promise_done.sru
forward
global type n_cst_promise_done from nonvisualobject
end type
end forward

global type n_cst_promise_done from nonvisualobject
event ue_complete ( n_cst_promise_result result )
event ue_error ( n_cst_promise_error err )
event ue_progress ( n_cst_promise_progress progress )
end type
global n_cst_promise_done n_cst_promise_done

type variables
protected:

powerobject				ipo_senderComplete
powerobject				ipo_senderError
powerobject				ipo_senderProgress

string					is_eventComplete
string 					is_eventError
string					is_eventProgress
end variables
forward prototypes
public function n_cst_promise_done of_complete (powerobject apo_sender, string as_event)
public function n_cst_promise_done of_error (powerobject apo_sender, string as_event)
public function n_cst_promise_done of_progress (powerobject apo_sender, string as_event)
end prototypes

event ue_complete(n_cst_promise_result result);if isValid(ipo_senderComplete) and len(is_eventComplete) > 0 then
	Message.PowerObjectParm = result
	ipo_senderComplete.dynamic triggerEvent(is_eventComplete)
end if

end event

event ue_error(n_cst_promise_error err);if isValid(ipo_senderError) and len(is_eventError) > 0 then
	Message.PowerObjectParm = err
	ipo_senderError.dynamic triggerEvent(is_eventError)
end if
end event

event ue_progress(n_cst_promise_progress progress);if isValid(ipo_senderProgress) and len(is_eventprogress) > 0 then
	Message.PowerObjectParm = progress
	ipo_senderProgress.dynamic triggerEvent(is_eventProgress)
end if
end event

public function n_cst_promise_done of_complete (powerobject apo_sender, string as_event);ipo_senderComplete = apo_sender
is_eventComplete = as_event

return this
end function

public function n_cst_promise_done of_error (powerobject apo_sender, string as_event);ipo_senderError = apo_sender
is_eventError = as_event

return this


end function

public function n_cst_promise_done of_progress (powerobject apo_sender, string as_event);ipo_senderProgress = apo_sender
is_eventProgress = as_event

return this
end function

on n_cst_promise_done.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_promise_done.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

