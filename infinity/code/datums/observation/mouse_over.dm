GLOBAL_DATUM_INIT(mouse_enter, /decl/observ/mouse_enter, new)
GLOBAL_DATUM_INIT(mouse_exited, /decl/observ/mouse_exited, new)

/decl/observ/mouse_enter
	name = "Mouse Enter"
	expected_type = /client

/client/MouseEntered(object, location, control, params) 
	. = ..()
	GLOB.mouse_enter.raise_event(src, object)

/decl/observ/mouse_exited
	name = "Mouse Exited"
	expected_type = /client

/client/MouseExited(object, location, control, params)
	. = ..()
	GLOB.mouse_exited.raise_event(src, object)
