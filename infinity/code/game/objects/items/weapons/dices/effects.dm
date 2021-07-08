/obj/item/dice
	var/list/Effects = list()

GLOBAL_LIST_EMPTY(CachedEffects)

/proc/TriggerDiceEffect(effectType, mob/living/user, obj/item/dice/dice, side, isThrowed)
	if(ispath(effectType, /datum/dice_effect))
		if(GLOB.CachedEffects.Find(effectType))
			var/datum/dice_effect/effect = GLOB.CachedEffects[effectType]
			if(istype(effect))
				return effect.Trigger(user, dice, side, isThrowed)
		else
			GLOB.CachedEffects[effectType] = new effectType()
			return TriggerDiceEffect(arglist(args.Copy()))
	CRASH("Warning, something wrong with dices' effects, maybe someone put bad type of effect in [dice.type]>\ref[dice]/proc/TriggerDiceEffect([json_encode(args)])")

/datum/dice_effect
	var/CooldownOfDice = 0.5 SECONDS

/datum/dice_effect/proc/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	if(istype(dice))
		dice.CooldownDice(CooldownOfDice)

/obj/item/dice/proc/TriggerEffectBySide(mob/living/user, side, isThrowed)
	if(NextUse <= world.time && Effects.Find("[side]"))
		if(ispath(Effects["[side]"], /datum/dice_effect))
			TriggerDiceEffect(Effects["[side]"], user, src, side, isThrowed)
		else
			CRASH("Warning, something wrong with dices' effects, maybe someone put bad type of effect in [type]>\ref[src]/proc/TriggerEffectBySide([json_encode(args)])")

/obj/item/dice/d20
	Effects = list(
		"20"	=	/datum/dice_effect/visible_message/Natural,
		"1"		=	/datum/dice_effect/visible_message/BadLucker
	)

/datum/dice_effect/visible_message
	var/Message
	var/Sound
	var/SoundVolume
	var/UseRandomFrequency = FALSE

/datum/dice_effect/visible_message/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	. = ..()
	var/turf/soundSource = get_turf(dice)
	if(soundSource)
		soundSource.visible_message(GetMessage(user, dice, side, isThrowed))
		if(Sound)
			playsound(soundSource, Sound, SoundVolume, UseRandomFrequency)

/datum/dice_effect/visible_message/proc/GetMessage(mob/living/user, obj/item/dice/dice, side, isThrowed)
	return SPAN_NOTICE(Message)

/datum/dice_effect/visible_message/Natural
	Message = "Wow! Natural "
	GetMessage(mob/living/user, obj/item/dice/dice, side, isThrowed)
		. = SPAN_NOTICE(Message + "[side]!")

/datum/dice_effect/visible_message/BadLucker
	Message = "Ouch, bad luck!"
