// Bluespace crystals, used in telescience and when crushed it will blink you to a random turf.

/obj/item/bluespace_crystal
	name = "bluespace crystal"
	desc = "A glowing bluespace crystal, not much is known about how they work. It looks very delicate."
	icon = 'infinity/icons/obj/item/bs_crystal.dmi'
	icon_state = "bluespace_crystal"
	color = "#6699ff"
	w_class = 1
	origin_tech = list(TECH_BLUESPACE = 4, TECH_MATERIAL = 3)
	var/blink_range = 8 // The teleport range when crushed/thrown at someone.

/obj/item/bluespace_crystal/Destroy()
	playsound(get_turf(loc), 'sound/effects/supermatter.ogg', 60)
	. = ..()

/obj/item/bluespace_crystal/attack_self(mob/user)
	user.visible_message("<span class='warning'>[user] crushes [src]!</span>", "<span class='danger'>You crush [src]!</span>")
	playsound(loc, 'sound/effects/supermatter.ogg', 60)
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.set_up(5, 0, get_turf(user))
	sparks.start()
	playsound(loc, "sparks", 50, 1)
	playsound(loc, 'sound/effects/phasein.ogg', 25, 1)
	blink_mob(user)
	user.unEquip(src)
	qdel(src)

/obj/item/bluespace_crystal/proc/blink_mob(mob/living/L)
	var/turf/T = get_random_turf_in_range(L, blink_range, 1)
	L.forceMove(T)
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.set_up(5, 0, T)
	sparks.start()

/obj/item/bluespace_crystal/throw_impact(atom/hit_atom)
	if(!..()) // not caught in mid-air
		visible_message("<span class='notice'>[src] fizzles and disappears upon impact!</span>")
		var/turf/T = get_turf(hit_atom)
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(5, 0, T)
		sparks.start()
		playsound(loc, "sparks", 50, 1)
		if(isliving(hit_atom))
			blink_mob(hit_atom)
			playsound(T, 'sound/effects/phasein.ogg', 25, 1)
		qdel(src)

// Artifical bluespace crystal, doesn't give you much research.

/obj/item/bluespace_crystal/artificial
	name = "artificial bluespace crystal"
	desc = "An artificially made bluespace crystal, it looks delicate."
	origin_tech = list(TECH_BLUESPACE = 2)
	blink_range = 4 // Not as good as the organic stuff!
