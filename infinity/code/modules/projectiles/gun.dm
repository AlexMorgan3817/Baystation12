GLOBAL_LIST_INIT(serials, list())

/obj/item/weapon/gun/proc/modify_projectile(obj/item/projectile/p, var/list/params = list())
	return p

/obj/item/weapon/gun/proc/set_firemode(modeindex)
	if(!modeindex || modeindex == sel_mode || firemodes.len < sel_mode)
		return null
	sel_mode = modeindex
	var/datum/firemode/new_mode = firemodes[sel_mode]
	new_mode.apply_to(src)
	playsound(loc, selector_sound, 50, 1)
	return new_mode

/obj/item/weapon/gun
	var/is_serial = 0 //the entrie variable that defines should the gun have serial
	var/serial // < most important thing, this is the SERIAL itself
	var/s_type //energy or kinetic
	var/s_gun //gun type, e.g. LP - laep

	var/target_checker_extension_type = /datum/extension/target_check
	var/list/mob/target_data_tooltip = list()

/obj/item/weapon/gun/Initialize()
	. = ..()
	set_extension(src, target_checker_extension_type)
	if(is_serial) //serial
		var/snum = rand(1,10000)
		while(snum in GLOB.serials) //system against similar numbers
			snum = rand(1,10000)
		serial = "[s_type]-[s_gun]-[snum]" //e.g K-P20-9999
		GLOB.serials += serial //list of serials

	GLOB.item_equipped_event.register(src, src, .proc/equiped)

/obj/item/weapon/gun/examine(mob/user, distance)
	. = ..()
	var/datum/extension/target_check/e = get_extension(src, /datum/extension/target_check)
	e.examine(user)

/obj/item/weapon/gun/proc/check_can_fire(mob/user, atom/target)
	var/datum/extension/target_check/tchecker = get_extension(src, /datum/extension/target_check)
	if(tchecker)
		var/check_result = tchecker.check_can_fire(user, target)
		if(check_result)
			return TRUE
		else
			if(!safety())
				toggle_safety()
				playsound(src, 'sound/weapons/flipblade.ogg', 30, 1)
			return FALSE

//GLOBAL_LIST_EMPTY(threat_image_cache)
/obj/item/weapon/gun/proc/SetMaptextImageTo(atom/target, mob/dude)
	if(!dude.client) return FALSE
	var/datum/extension/target_check/e = get_extension(src, /datum/extension/target_check)
	var/list/mptext_packet = e.get_maptext_by_target(dude, target)
	var/mpcolor
	var/mptext
	if(mptext_packet?.len)
		mpcolor = mptext_packet["color"]
		if(!mpcolor)
			mpcolor = "#ffffff"
		mptext = mptext_packet["text"]
		if(mptext)
			var/image/im = image(null,target)

			im.maptext = "<center><span style=\"font-family: 'Small Fonts'; -dm-text-outline: 1 [invertHTML(mpcolor)]; font-size: 8px;\">[mptext]</span></center>"
			im.maptext_width = 96
			im.maptext_y = 28
			im.maptext_x = 0 - length_char(mptext)
			im.color = mpcolor

			dude.client.images += im
			target_data_tooltip[target] = im

			return TRUE

/obj/item/weapon/gun/proc/SetMaptextImageTo_for_event(client/dude, atom/target)
	if(isclient(dude))
		if(dude.mob?.get_active_hand() != src) return 
		SetMaptextImageTo(target, dude.mob)
		GLOB.mouse_exited.register(dude, src, .proc/ResetMaptextImage_for_event)

/obj/item/weapon/gun/proc/ResetMaptextImage_for_event(client/dude, atom/target)
	if(isclient(dude))
		if(dude.mob?.get_active_hand() != src) return 
		ResetMaptextImage(dude, target)
		GLOB.mouse_enter.register(dude, src, .proc/SetMaptextImageTo_for_event)

/obj/item/weapon/gun/proc/ResetMaptextImage(client/dude, atom/target)
	if(!dude) return
	if(target in target_data_tooltip)
		var/image/im = target_data_tooltip[target]
		if(!im)
			CRASH("Warning, somebody left target without cached maptext-image using [src] [src].target_data_tooltip = [json_encode(target_data_tooltip)]")
		dude.images -= im
		target_data_tooltip -= target

/obj/item/weapon/gun/proc/equiped(var/me, var/who)
	GLOB.item_unequipped_event.register(me, me, .proc/unequiped)
	if(ismob(who))
		var/mob/m = who
		if(m.client) GLOB.mouse_enter.register(m.client, src, .proc/SetMaptextImageTo_for_event)

/obj/item/weapon/gun/proc/unequiped(var/me, var/who)
	GLOB.item_equipped_event.register(me, me, .proc/equiped)
	if(ismob(who))
		var/mob/M = who
		if(M.client) for(var/mob/target in target_data_tooltip) ResetMaptextImage(M.client, target)
/*
/mob/living/carbon/human/MouseEntered()
	. = ..()
	if(usr)
		var/mob/living/carbon/human/user = usr
		if(istype(user) && user.client)
			var/obj/item/weapon/gun/g = user.get_active_hand()
			if(istype(g)) g?.SetMaptextImageTo(src, user.client)


/mob/living/carbon/human/MouseExited()
	. = ..()
	if(usr)
		var/mob/living/carbon/human/user = usr
		if(istype(user) && user.client)
			var/obj/item/weapon/gun/g = user.get_active_hand()
			if(istype(g)) g?.ResetMaptextImage(src, user.client)
*/