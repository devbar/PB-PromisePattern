PB-PromisePattern
=========

An example how to use the promise pattern (popular in the JavaScript world) in PowerScript.

![ScreenShot](./resources/PromisePattern.png)

How to use:

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
