/mob/living
	var/datum/stigmas/stigmata

/mob/living/Life()
	. = ..()
	if(stigmata)
		stigmata.onLife(args.Copy())
