HA$PBExportHeader$primesample.sra
$PBExportComments$Generated Application Object
forward
global type primesample from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type primesample from application
string appname = "primesample"
end type
global primesample primesample

on primesample.create
appname="primesample"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on primesample.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open (w_main)
end event

