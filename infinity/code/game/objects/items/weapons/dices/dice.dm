/obj/item/dice
	maptext_x = -1
	maptext_y = 16

	var/NextUse
	var/DefaultCooldown = 0.5 SECOND

/obj/item/dice/proc/CooldownDice(howLong = DefaultCooldown)
	if(howLong < DefaultCooldown)
		howLong = DefaultCooldown
	NextUse = world.time + howLong

/obj/item/dice/proc/SetThrowForce(value)
	. = value - throwforce
	throwforce = value

/obj/item/dice/proc/roll_die()
	. = rand(1, sides)
	UpdateIconByRolledSide(.)
	visible_message(SPAN_NOTICE("\The [src] lands on [.]."))

/obj/item/dice/d100/roll_die()
	. = ..() * 10

/obj/item/dice/attack_self(mob/user as mob)
	. = ..()
	TriggerEffectBySide(user, roll_die(), FALSE)

/obj/item/dice/proc/UpdateIconByRolledSide(side)
	icon_state = "[name][side]"

/obj/item/dice/proc/get_side()
	return text2num(copytext(icon_state, length(name) + 1, 0))

/obj/item/dice/throw_at(atom/target, range, speed, mob/thrower, spin = TRUE, datum/callback/callback)
	. = ..()
	if(.)
		TriggerEffectBySide(thrower, roll_die(), TRUE)
