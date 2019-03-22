/obj/structure/closet/secure_closet/freezer/kitchen
	name = "kitchen cabinet"
	req_access = list(access_kitchen)

/obj/structure/closet/secure_closet/freezer/kitchen/WillContain()
	return list(
		/obj/item/weapon/reagent_containers/food/condiment/salt = 1,
		/obj/item/weapon/reagent_containers/food/condiment/flour = 7,
		/obj/item/weapon/reagent_containers/food/condiment/sugar = 2
	)

/obj/structure/closet/secure_closet/freezer/kitchen/mining
	req_access = list()

/obj/structure/closet/secure_closet/freezer/meat
	name = "meat fridge"
	icon_state = "fridge1"
	icon_closed = "fridge"
	icon_locked = "fridge1"
	icon_opened = "fridgeopen"
	icon_off = "fridgebroken"

/obj/structure/closet/secure_closet/freezer/meat/WillContain()
	return list(
		/obj/item/weapon/reagent_containers/food/snacks/meat/beef = 8,
		/obj/item/weapon/reagent_containers/food/snacks/fish = 4
	)

/obj/structure/closet/secure_closet/freezer/fridge
	name = "refrigerator"
	icon_state = "fridge1"
	icon_closed = "fridge"
	icon_locked = "fridge1"
	icon_opened = "fridgeopen"
	icon_off = "fridgebroken"

/obj/structure/closet/secure_closet/freezer/fridge/WillContain()
	return list(
		/obj/item/weapon/reagent_containers/food/drinks/milk = 6,
		/obj/item/weapon/reagent_containers/food/drinks/soymilk = 4,
		/obj/item/weapon/storage/fancy/egg_box = 4
	)

/obj/structure/closet/secure_closet/freezer/fridge/zeppelin/

obj/structure/closet/secure_closet/freezer/fridge/zeppelin/WillContain()
	return list(
		/obj/item/weapon/reagent_containers/food/drinks/milk = 2,
		/obj/item/weapon/reagent_containers/food/condiment/flour = 2,
		/obj/item/weapon/storage/fancy/egg_box = 2,
		/obj/item/weapon/reagent_containers/food/snacks/meat/beef = 4,
		/obj/item/weapon/reagent_containers/food/snacks/fish = 2,
		/obj/item/weapon/reagent_containers/food/condiment/small/peppermill = 1,
		/obj/item/weapon/reagent_containers/food/condiment/small/saltshaker = 1)

/obj/structure/closet/secure_closet/freezer/money
	name = "secure locker"
	icon_state = "fridge1"
	icon_closed = "fridge"
	icon_locked = "fridge1"
	icon_opened = "fridgeopen"
	icon_off = "fridgebroken"
	req_access = list(access_heads_vault)

/obj/structure/closet/secure_closet/freezer/money/Initialize()
	. = ..()
	//let's make hold a substantial amount.
	var/created_size = 0
	for(var/i = 1 to 200) //sanity loop limit
		var/obj/item/cash_type = pick(3; /obj/item/weapon/spacecash/bundle/c1000, 4; /obj/item/weapon/spacecash/bundle/c500, 5; /obj/item/weapon/spacecash/bundle/c200)
		var/bundle_size = initial(cash_type.w_class) / 2
		if(created_size + bundle_size <= storage_capacity)
			created_size += bundle_size
			new cash_type(src)
		else
			break

/obj/structure/closet/secure_closet/freezer/var/jones = FALSE

/obj/structure/closet/secure_closet/freezer/ex_act()
	if(!jones)
		jones = TRUE
	else
		..()
/obj/structure/closet/fridge
	name = "fridge"
	icon = 'icons/obj/closets_inf.dmi'
	icon_state = "fridge"
	icon_closed = "fridge"
	icon_opened = "fridgeopen"