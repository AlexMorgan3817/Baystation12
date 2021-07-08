/obj/item/dice/d20/cursed
	icon_state = "d201"
	icon = 'infinity/icons/obj/dice.dmi'

	Effects = list(
		"1"		=	/datum/dice_effect/DustUserAndDice,
		"2"		=	/datum/dice_effect/KillBrain,
		"3"		=	/datum/dice_effect/NePovezloNePovezlo,
		"4"		=	/datum/dice_effect/Spiders2d4,
		"5"		=	/datum/dice_effect/GoBackIWantToBeMonke,
		"6"		=	/datum/dice_effect/Reborn,
		"7"		=	/datum/dice_effect/,
		"10"	=	/datum/dice_effect/visible_message/Nothing,
	)

	DefaultCooldown = 5 SECONDS

/datum/dice_effect/DustUserAndDice/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	. = ..()
	if(istype(user))
		user.dust()
		qdel(dice)

/datum/dice_effect/KillBrain/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	. = ..()
	if(istype(user))
		user.adjustBrainLoss(200)

/datum/dice_effect/NePovezloNePovezlo/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	. = ..()
	if(istype(user))
		if(isThrowed)
			var/old_force = dice.throwforce
			dice.throwforce = 600
			return dice.throw_at(user, 30, 5, callback = CALLBACK(dice, /obj/item/dice/proc/SetThrowForce, old_force))
		new/obj/structure/synthesized_instrument/synthesizer/piano(get_turf(user))
		user.adjustBruteLoss(200)

GLOBAL_LIST_INIT(MessagesOfMonkeBecome, list(\
	SPECIES_HUMAN	=	"Go back, i want to be monke!",\
	SPECIES_UNATHI	=	"Time to rise from water and step on the land.",\
	SPECIES_IPC		=	"Reject machine, time to start new carbon evolution!",\
	SPECIES_ADHERENT=	"Reject protocol, b3c0m3 fr33.",\
	SPECIES_MONKEY	=	"Hoo hoo hoo hoo ah?",\
	SPECIES_SKRELL	=	"Oh, shit, time to stand up on feet.",\
	SPECIES_VOX		=	"Titihiki tahakachi kah SKREKRIKA!!! I don't want to be monke!!!",\
	)\
)
/datum/dice_effect/GoBackIWantToBeMonke/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	. = ..()
	if(istype(user))
		if(istype(user, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = user
			if(GLOB.MessagesOfMonkeBecome.Find(H.species.name))
				H.say(GLOB.MessagesOfMonkeBecome[H.species.name])
			spawn(1 SECOND)
				H.monkeyize()
		else
			user.say("Wait, i can't become monke...")

/datum/dice_effect/Spiders2d4/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	. = ..()
	if(istype(user))
		var/list/dices = list(
			new/obj/item/dice/d4(get_step(dice, EAST)),
			new/obj/item/dice/d4(get_step(dice, WEST))
		)
		for(var/obj/item/dice/D in dices)
			D.throw_at_random(FALSE, 2, 2)
			for(var/i in 1 to D.get_side())
				spawn(2 SECONDS)
					new/mob/living/simple_animal/hostile/giant_spider/guard(get_turf(D))

/datum/dice_effect/Reborn/Trigger(mob/living/user, obj/item/dice/dice, side, isThrowed)
	. = ..()
	if(istype(user))
		user.say("It's time to reborn!")
		spawn(1 SECOND)
			var/mob/living/carbon/human/H = new(get_turf(user))
			user.mind.transfer_to(H)
			spawn(1 SECOND)
				user.dust()

/datum/dice_effect/visible_message/Nothing
	Message = "It seems that something has happened"
