source toolatra_http.tcl
source toolatra_templates.tcl
source catlanguage/translate.tcl

set content {}

proc atob {vl} {
	set result [binary decode base64 [string map {__EQ__ {=} __SL__ {/} __MN__ {+}} $vl]]
	return $result
}

proc layout {getL} {
	set directory "[file dirname [info script]]/layouts"
	if {! [file isdirectory $directory]} {
		return ""
	}
	set fileDesc [open $directory/$getL.html r]
	set result [read $fileDesc]
	close $fileDesc
	return $result
}

get / {
	global content
	set content [layout translator]
	etcl index.html
}

get /do-meow {
	if {! [dict exists $params c]} {
		error 500
	}
	render [meowify [atob [dict get $params c]]] text/plain
}

get /do-english {
	if {! [dict exists $params c]} {
		error 500
	}
	render [unmeow [atob [dict get $params c]]] text/plain
}

get /api {
	global content
	set content [layout api-info]
	etcl index.html
}

run
