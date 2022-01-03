#define HOLOEN_ALGORITHM_BLOCK(msg, delay, goTo) list("message" = msg, "delay" = delay, "goto" = goTo)
//MSG - message to say; DELAY - delay before goto; GOTO - (num)index or in ["NEXT", "END"] GOTO is strictly [1-4] characters
/datum/computer_file/holoengram
	filetype = "HGR"
	var/list/program = list()
	var/image/hologram = new/image{icon = 'infinity/icons/mob/hologram.dmi'; icon_state="Default"}() // TODO: Editing

/datum/computer_file/holoengram/New()
	. = ..()
	calculate_size()

/datum/computer_file/holoengram/proc/calculate_size()
	. = 0
	for(var/list/i in program)
		if(istext(i["message"]))
			. += length(i)
		/*
		else if(istype(i, /datum/holoaction))
			var/datum/holoaction/I = i
			. += I.GetSize()
		*/

	size = max(1, round(. / 30)) // Audio data size more than text
	. = size
