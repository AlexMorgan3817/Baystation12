/datum/extension/target_check
	base_type = /datum/extension/target_check
	expected_type = /atom
	var/atom/movable/atom_holder

/datum/extension/target_check/proc/examine(mob/user)

/datum/extension/target_check/proc/get_maptext_by_target(mob/user, atom/target)
	. = list()

/datum/extension/target_check/New()
	. = ..()
	atom_holder = holder

/datum/extension/target_check/proc/check_can_fire(mob/user, atom/target)
	return TARGET_MAXIMUM_DANGER
