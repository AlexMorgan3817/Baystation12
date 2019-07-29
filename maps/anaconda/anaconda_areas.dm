/datum/map/anaconda

	base_floor_type = /turf/simulated/floor/reinforced/airless
	//base_floor_area = /area/maintenance/exterior

	post_round_safe_areas = list (
		/area/shuttle/administration/centcom,
		/area/shuttle/transport1/centcom
	)
//VESSEL
	//Safe Rooms
/area/crew_quarters/safe_room
	name = "Safe Room"
	icon_state = "crew_quarters"
	sound_env = SMALL_ENCLOSED
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/crew_quarters/safe_room/seconddeck
	name = "Living Deck Safe Room"
/area/crew_quarters/safe_room/firstdeck
	name = "Operating Deck Safe Room"
/area/crew_quarters/safe_room/bridge
	name = "Bridge Deck Safe Room"

	//Deck R
		//CARGO
/area/quartermaster
	req_access = list(access_cargo)

/area/quartermaster/hangar
	name = "Hangar Deck"
	icon_state = "hangar"
	sound_env = LARGE_ENCLOSED
	req_access = list(access_hangar)

/area/quartermaster/office
	name = "Supply Office"
	icon_state = "quartoffice"

/area/quartermaster/sorting
	name = "Sorting Office"
	icon_state = "quartoffice"
	req_access = list(access_mailsorting)

/area/quartermaster/storage
	name = "Warehouse"
	icon_state = "quartstorage"
	sound_env = LARGE_ENCLOSED

/area/quartermaster/deckofficer
	name = "Quartermaster"
	icon_state = "quart"
	req_access = list(access_qm)

		//ENGINEERING
/area/engineering
	req_access = list(access_engine)
	icon_state = "engineering"

/area/engineering/hallway
	name = "Engineering Hallway"
	icon_state = "engineering_workshop"

/area/engineering/hardstorage
	name = "Engineering Hard Storage"
	icon_state = "engineering_storage"
	sound_env = SMALL_ENCLOSED

/area/engineering/engine_room
	name = "Engine Room"
	icon_state = "engine"
	sound_env = LARGE_ENCLOSED
	area_flags = AREA_FLAG_ION_SHIELDED
	req_access = list(access_engine_equip)

/area/engineering/engine_eva
	name = "Engine EVA"
	icon_state = "engine_eva"
	req_access = list(list(access_eva, access_external_airlocks), access_engine)

/area/engineering/engineering_monitoring
	name = "Engineering Monitoring Room"
	icon_state = "engine_monitoring"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/engineering/locker_room
	name = "Engineering Locker Room"
	icon_state = "engineering_locker"

/area/engineering/atmos
 	name = "Atmospherics"
 	icon_state = "atmos"
 	sound_env = LARGE_ENCLOSED
 	req_access = list(access_atmospherics)

/area/engineering/drone_fabrication
	name = "Engineering Drone Fabrication"
	icon_state = "drone_fab"
	sound_env = SMALL_ENCLOSED
	req_access = list(access_ai_upload)

//CC
	//SP DRONE
/area/supply/dock
	name = "Supply Shuttle"
	icon_state = "shuttle3"
	requires_power = 0
	req_access = list(access_cent_storage)

	//ANTAGS'
		// Ninja areas
/area/ninja_dojo
	name = "Ninja Base"
	icon_state = "green"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_syndicate)

/area/ninja_dojo/dojo
	name = "Clan Dojo"
	dynamic_lighting = 0

/area/ninja_dojo/start
	name = "Clan Dojo"
	icon_state = "shuttlered"
	base_turf = /turf/simulated/floor/plating



		//Merchant
/area/shuttle/merchant/home
	name = "Merchant Vessel"
	icon_state = "shuttlegrn"
	requires_power = 1
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_merchant)




		//Nuke
/area/syndicate_mothership
	name = "Mercenary Base"
	icon_state = "syndie-ship"
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_syndicate)

/area/syndicate_station/start
	name = "Mercenary Forward Operating Base"
	icon_state = "yellow"
	requires_power = 0
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_syndicate)




		//Skipjack
/area/skipjack_station
	name = "Raider Outpost"
	icon_state = "yellow"
	requires_power = 0
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_syndicate)



		//TRIOP ERT
/area/rescue_base
	name = "Response Team Base"
	icon_state = "yellow"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_cent_specops)

/area/rescue_base/base
	name = "Barracks"
	icon_state = "yellow"
	dynamic_lighting = 0

/area/rescue_base/start
	name = "Response Team Base"
	icon_state = "shuttlered"
	base_turf = /turf/unsimulated/floor/rescue_base



//MISC
	//Turbolift
		//body
/area/turbolift
	icon_state = "shuttle"
	dynamic_lighting = 1
	area_flags = AREA_FLAG_ION_SHIELDED
	req_access = list(access_maint_tunnels)

/area/turbolift/cargo
	req_access = list(access_hangar)
/area/turbolift/cargo/anaconda_top
	name = "lift (first deck)"
	lift_floor_label = "Deck 1"
	lift_floor_name = "Operating Deck"
	lift_announce_str = "Arriving at Main Deck: RnD or Tri-Optium Departament, Med Bay, Main Thusters, Telecommunications, Staff EVA."

/area/turbolift/cargo/anaconda_middle
	name = "lift (second deck)"
	lift_floor_label = "Deck 2"
	lift_floor_name = "Living Deck"
	lift_announce_str = "Arriving at Living Deck: Cryogenic Storage. Dormitory. Lounge. Bar. Hydroponics. Gym. Laundry. EVA."

/area/turbolift/cargo/anaconda_ground
	name = "lift (third deck)"
	lift_floor_label = "Deck R"
	lift_floor_name = "Reactor-Hangar"
	lift_announce_str = "Arriving at Deck R: Hangar, Engineering."
	base_turf = /turf/simulated/floor

		//vessel body
/area/turbolift/cargo/start
	name = "Turbolift Start"

/area/turbolift/cargo/firstdeck
	name = "first deck"
	base_turf = /turf/simulated/open

/area/turbolift/cargo/seconddeck
	name = "second deck"
	base_turf = /turf/simulated/open

/area/turbolift/cargo/reactor
	name = "third deck"
	base_turf = /turf/simulated/open

	//shuttles
/area/shuttles/guppy_hangar/start
	name = "Guppy"
	icon_state = "shuttlered"
	requires_power = 1
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	req_access = list(access_guppy)

/area/shuttle/administration/centcom
	name = "Administration Shuttle"
	icon_state = "shuttlered"
	req_access = list(access_cent_general)

/area/shuttle/transport1/centcom
	icon_state = "shuttle"
	name = "Transport Shuttle Centcom"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT

