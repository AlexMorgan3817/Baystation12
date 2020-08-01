/mob/living
	var/datum/stigma/stigmata

/mob/living/Life()
	. = ..()
	if(istype(stigmata))
		stigmata.onLife(arglist(args))
