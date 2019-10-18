#!/usr/bin/env tclsh
# Cat Language Translator (web UI)
# Copyright (C) Tim K/RoverAMD 2018-2019 <timprogrammer@rambler.ru>

package require Toolatra 19.10
package require ToolatraTemplates
source catlanguage/translate.tcl

set content {}

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

post /do-meow {
	render [meowify $rawData] text/plain
}

get /do-meow {
	status 400
	render "Legacy GET-request based API is no longer available. Please use the new POST-request based API."
}

post /do-english {
	render [unmeow $rawData] text/plain
}

get /do-english {
	status 400
	render "Legacy GET-request based API is no longer available. Please use the new POST-request based API."
}

get /api {
	global content
	set content [layout api-info]
	etcl index.html
}

run
