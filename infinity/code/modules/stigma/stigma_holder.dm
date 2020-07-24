/datum/stigmas
	var/list/stigmatas = list()
	var/mob/living/owner

/datum/stigmas/New(_owner, list/stigms)
	. = ..()
	owner = _owner
	if(stigms)
		stigmatas = stigms
	if(owner)
		GLOB.moved_event.register(owner, src, /datum/stigmas/proc/onMove)

/datum/stigmas/Destroy()
	GLOB.moved_event.unregister(owner, src, /datum/stigmas/proc/onMove)
	. = ..()

/datum/stigmas/proc/onMove()
	for(var/datum/stigma/S in stigmatas)
		S.onMove()	

/datum/stigmas/proc/onLife()
	for(var/datum/stigma/S in stigmatas)
		S.onLife()

