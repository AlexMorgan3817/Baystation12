/obj/structure/closet/crate/freezer/blood
	name = "blood freezer"
	desc = "A crate of O-minus blood packs. Don't drink it, please."

/obj/structure/closet/crate/freezer/blood/WillContain()
	return list(/obj/item/weapon/reagent_containers/ivbag/blood/OMinus = 4)

/obj/structure/closet/crate/freezer/blood/small
	name = "blood freezer"
	desc = "A crate of O-minus blood packs. Don't drink it, please."

/obj/structure/closet/crate/freezer/blood/small/WillContain()
	return list(/obj/item/weapon/reagent_containers/ivbag/blood/OMinus = 2)

/obj/structure/closet/crate/freezer/nanoblood
	name = "nanoblood freezer"
	desc = "A crate of nanoblood packs. Don't drink it."

/obj/structure/closet/crate/freezer/nanoblood/WillContain()
	return list(/obj/item/weapon/reagent_containers/ivbag/nanoblood = 4)

/obj/structure/closet/crate/freezer/nanoblood/small/WillContain()
	return list(/obj/item/weapon/reagent_containers/ivbag/nanoblood = 2)

/obj/structure/closet/crate/smes_coils
	name = "SMES assembly kit"
	desc = "A crate with SMES coils, and circuits."

/obj/structure/closet/crate/smes_coils/WillContain()
	return list(/obj/item/weapon/stock_parts/smes_coil = 4,
				/obj/item/weapon/stock_parts/smes_coil/super_capacity = 4,
				/obj/item/weapon/stock_parts/smes_coil/super_io = 4
	)

/obj/structure/closet/crate/fuel/pacman/phoron
	name = "phoron crate"
	desc = "A crate with solid phoron, maybe for P.A.C.K.M.A.N?"
	closet_appearance = /decl/closet_appearance/crate/radiation

/obj/structure/closet/crate/phoron/WillContain()
	return list(/obj/item/stack/material/phoron/ten = 5)

/obj/structure/closet/crate/fuel/pacman/nuclear
	name = "nuclear fuel crate"
	desc = "A crate with solid uranium, maube for nuclear reactor or super P.A.C.K.M.A.N?"
	closet_appearance = /decl/closet_appearance/crate/radiation

/obj/structure/closet/crate/fuel/pacman/nuclear/WillContain()
	return list(/obj/item/stack/material/uranium/ten = 5)