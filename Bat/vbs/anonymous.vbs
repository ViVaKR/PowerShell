Dim IIsObject
Set IIsObject = GetObject ("IIS://Localhost/w3svc")
Wscript.Echo "According to the metabase, The anonymous credentials are:"
Wscript.Echo " anonymoususername = " & _
IIsObject.Get("anonymoususername")
Wscript.Echo " anonymoususerpass = " & _
IIsObject.Get("anonymoususerpass")
Wscript.Echo " Wamusername = " & IIsObject.get("wamusername")
Wscript.Echo " Wamuserpass = " & IIsObject.get("wamuserpass")
Set IIsObject = nothing
