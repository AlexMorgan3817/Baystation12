/datum/computer_file/holoengram
	filetype = "HGR"
	var/list/program = list()
	var/image/hologram = new/image{icon = 'infinity/icons/mob/hologram.dmi'; icon_state="Default"}() // TODO: Editing

/datum/computer_file/holoengram/New()
	. = ..()
	calculate_size()

/datum/computer_file/holoengram/proc/calculate_size()
	. = 0
	for(var/i in program)
		if(istext(i))
			. += length(i)
		/*
		else if(istype(i, /datum/holoaction))
			var/datum/holoaction/I = i
			. += I.GetSize()
		*/

	size = max(1, round(. / 30)) // Audio data size more than text
	. = size
