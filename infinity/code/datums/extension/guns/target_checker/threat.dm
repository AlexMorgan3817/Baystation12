#define YOU_HEAR_SYNTHETICVOICEINYOURHEAD(txt) "You hear synthetic voice in your head: [SPAN_SYNTH_VOICE("\"[txt]\"")]"
/datum/extension/target_check/threat/var/list/msgcooldown = list()
/datum/extension/target_check/threat/examine(mob/user)
	. = ..()
	to_chat(user, "[atom_holder] have ai threat calculating system installed.")

/datum/extension/target_check/threat/check_can_fire(mob/user, atom/target)
	. = ..()
	if(!has_access(atom_holder.get_req_access(), user.GetAccess()))
		try_message(user, YOU_HEAR_SYNTHETICVOICEINYOURHEAD("Unauthorized user. Access denied."))
		return FALSE //access denied
	if(ishuman(target))
		. = convertThreat2DangerLevel(get_treat(target))
		if(!.)
			try_message(user, YOU_HEAR_SYNTHETICVOICEINYOURHEAD("Threat index equal [.]. Trigger locked."))
			return FALSE
		else if(. == 1)
			try_message(user, YOU_HEAR_SYNTHETICVOICEINYOURHEAD("Threat index equal [.]. Stun. Please aim calmly and subdue the target."))

	else if(istype(target, /mob/living/simple_animal/hostile))
		return TARGET_MAXIMUM_DANGER
	else
		try_message(user, YOU_HEAR_SYNTHETICVOICEINYOURHEAD("Inappropriate target."))
		return TARGET_NODANGER

/datum/extension/target_check/threat/proc/try_message(mob/target, text)
	if(msgcooldown.Find(text)) if(msgcooldown[text] > world.time) return
	to_chat(target, text)
	msgcooldown[text] = world.time

/datum/extension/target_check/threat/proc/get_treat(mob/target)
	return get_threat_from_appearance(target) * get_threatmod_by_records(target) //x * (1 + (sin(arrest_status) * 10) - (sin(economic_power - 1) * 10))

/datum/extension/target_check/threat/proc/get_threatmod_by_records(mob/user, mob/target)
	. = 1
	if(ishuman(target))
		var/mob/living/carbon/human/t = target
		var/datum/computer_file/report/crew_record/CR = get_crewmember_record(t.real_name)
		if(CR)
			var/criminal_status = CR.get_criminalStatus()
			if(criminal_status) . += sin(GLOB.security_statuses.Find(criminal_status) - 1) * 10
			var/count_of_economic_powers = 0
			var/economic_power_all = 0
			for(var/i in t.cultural_info)
				var/decl/cultural_info/culture = t.cultural_info[i]
				if(istype(culture))
					economic_power_all += culture.economic_power
					count_of_economic_powers += 1 
			economic_power_all /= count_of_economic_powers
			. -= sin(economic_power_all) * 10
		else . = 1.5

GLOBAL_LIST_INIT(safe_armor_stats, list("rad", "bio", "bomb"))
/datum/extension/target_check/threat/proc/get_threat_from_appearance(mob/user, mob/target)
	. = 0
	var/list/inventory = target.get_equipped_items()

	for(var/atom/A in inventory)
		if(A.was_bloodied) . += 12
		if(istype(A, /obj/item/clothing))
			var/obj/item/clothing/C = A
			for(var/key in C.armor)
				if(key in GLOB.safe_armor_stats) continue
				. += C.armor[key]

	var/list/TheHands = list(target.get_active_hand(), target.get_inactive_hand())
	for(var/obj/item/i in TheHands)
		if(i.force) . += i.force

	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(C.handcuffed) . /= 4 - log(12, .)
		if(C.resting) . /= 4 - log(6, .)

/datum/extension/target_check/threat/get_maptext_by_target(mob/user, atom/target)
	. = ..()
	if(!ismob(target))
		return
	if(!has_access(atom_holder.get_req_access(), user.GetAccess()))
		.["text"] = "ACCESS DENIED"
		.["color"] = "#ff0000"
	else
		var/threat = get_treat(user, target)
		var/danger_level = convertThreat2DangerLevel(threat)
		.["text"] = "[threat]"
		.["color"] = "#00ecff"
		if(!danger_level) return
		else if(danger_level == 1)
			.["color"] = "#ffc100"
		else if(danger_level == 2)
			.["color"] = "#ff9a00"
		else if(danger_level >= 3)
			.["color"] = "#ff0000"
		else
			.["text"] = "!DANGER!"
			.["color"] = "#ff0000"

/proc/convertThreat2DangerLevel(threat)
	threat = text2num(threat)
	if(threat <= TARGET_SEMISAFE)											return 0
	else if(threat > TARGET_SEMISAFE && threat <= TARGET_SIGNIFICANT)		return 1
	else if(threat > TARGET_SIGNIFICANT && threat <= TARGET_DANGEROUS)		return 2
	else if(threat > TARGET_DANGEROUS && threat <= TARGET_MAXIMUM_DANGER)	return 3
	else																	return 4
