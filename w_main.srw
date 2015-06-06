HA$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type hpb_progress from hprogressbar within w_main
end type
type cb_3 from commandbutton within w_main
end type
type cb_2 from commandbutton within w_main
end type
type cb_1 from commandbutton within w_main
end type
type sle_end from singlelineedit within w_main
end type
type sle_start from singlelineedit within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type mle_result from multilineedit within w_main
end type
end forward

global type w_main from window
integer width = 3566
integer height = 2104
boolean titlebar = true
string title = "Primer"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_searchcomplete ( )
event ue_searchfailed ( )
event ue_progress ( )
hpb_progress hpb_progress
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
sle_end sle_end
sle_start sle_start
st_2 st_2
st_1 st_1
mle_result mle_result
end type
global w_main w_main

type variables
protected:

n_cst_async_helper	inv_async
end variables

forward prototypes
public subroutine of_print (string as_line)
end prototypes

event ue_searchcomplete();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Search Complete of the Search method
// 
// Author: 
// B.Kemner, 04.05.2015 
// 

long						ll_count, lla_numbers[], ll_index
string					ls_line
n_cst_promise_result	result

result = Message.PowerObjectParm

ll_count = result.of_getReturnValue( )
lla_numbers = result.of_getReferenceArgument(1)

for ll_index = 1 to ll_count
	if len(ls_line) > 0 then ls_line += ", "
	ls_line += string(lla_numbers[ll_index])
next

of_print("Finished Async Call with results: ~r~n" + ls_line)
end event

event ue_searchfailed();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Something went wrong while searching
// 
// Author: 
// B.Kemner, 04.05.2015 
// 

n_cst_promise_error	err

err = Message.PowerObjectParm
of_print("Call Async finished with error: " + string(err.of_getCode()))
end event

event ue_progress();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Progress of the Search method
// 
// Author: 
// B.Kemner, 04.05.2015 
//

n_cst_promise_progress	progress

progress = Message.PowerObjectParm

hpb_progress.position = long(progress.of_getArgument(1))
end event

public subroutine of_print (string as_line);string	ls_datetime

ls_datetime = string(datetime(today(), now()), "[shortdate] [time]")

mle_result.text += ls_datetime + ": " + as_line + "~r~n"
end subroutine

on w_main.create
this.hpb_progress=create hpb_progress
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_end=create sle_end
this.sle_start=create sle_start
this.st_2=create st_2
this.st_1=create st_1
this.mle_result=create mle_result
this.Control[]={this.hpb_progress,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.sle_end,&
this.sle_start,&
this.st_2,&
this.st_1,&
this.mle_result}
end on

on w_main.destroy
destroy(this.hpb_progress)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_end)
destroy(this.sle_start)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_result)
end on

event close;inv_async.of_cleanUp()

return 0
end event

type hpb_progress from hprogressbar within w_main
integer x = 549
integer y = 512
integer width = 987
integer height = 64
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_3 from commandbutton within w_main
integer x = 1646
integer y = 1856
integer width = 1829
integer height = 128
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Results"
end type

event clicked;mle_result.text = ""
end event

type cb_2 from commandbutton within w_main
integer x = 37
integer y = 480
integer width = 457
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Call Async"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is a asynchronous called in promise pattern.
// 
// Author: 
// B.Kemner, 04.05.2015 
//

long				ll_start, ll_end
n_cst_primer	primer

ll_start = long(sle_start.text)
ll_end = long(sle_end.text)

hpb_progress.maxposition = ll_end
hpb_progress.minposition = ll_start

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
end event

type cb_1 from commandbutton within w_main
integer x = 37
integer y = 320
integer width = 457
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Call"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is a classical synchronous call in PowerBuilder.
// 
// Author: 
// B.Kemner, 04.05.2015 
//

string			ls_line
long				lla_results[]
long				ll_start, ll_end, ll_count, ll_index
n_cst_primer	primer

ll_start = long(sle_start.text)
ll_end = long(sle_end.text)

primer = create n_cst_primer

of_print("Start Call")
ll_count = primer.of_search(ll_start, ll_end, ref lla_results)

if ll_count < 0 then
	of_print("Call Finished with error: " + string(ll_count))
	return
end if

for ll_index = 1 to ll_count
	if len(ls_line) > 0 then ls_line += ", "
	ls_line += string(lla_results[ll_index])
next

of_print("Finished Call with Result: ~r~n" + ls_line)
end event

type sle_end from singlelineedit within w_main
integer x = 549
integer y = 160
integer width = 987
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "10000"
borderstyle borderstyle = stylelowered!
end type

type sle_start from singlelineedit within w_main
integer x = 549
integer y = 32
integer width = 987
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_main
integer x = 37
integer y = 160
integer width = 402
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "End:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 37
integer y = 32
integer width = 402
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start:"
boolean focusrectangle = false
end type

type mle_result from multilineedit within w_main
integer x = 1646
integer y = 32
integer width = 1829
integer height = 1792
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

