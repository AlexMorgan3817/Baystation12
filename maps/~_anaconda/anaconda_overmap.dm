/obj/effect/overmap/ship/anaconda
	name = "ITV Anaconda"
	fore_dir = WEST
	vessel_mass = 28000
	start_x = 4
	start_y = 5
	base = TRUE
	color = LIGHT_COLOR_PURPLE
	icon = 'icons/obj/overmap_inf.dmi'

	initial_restricted_waypoints = list(
		"Guppy" = list("nav_hangar_guppy")
	)

	initial_generic_waypoints = list(
		"nav_merc_deck1",
		"nav_merc_deck2",
		"nav_merc_deck3",
		"nav_merc_deck4",
		"nav_merc_deck5",
		"nav_ert_deck1",
		"nav_ert_deck2",
		"nav_ert_deck3",
		"nav_ert_deck4",
		"nav_ert_deck5",
		"nav_bridge_calypso",
		"nav_deck1_guppy",
		"nav_deck2_guppy",
		"nav_deck3_guppy",
		"nav_deck4_guppy",
		"nav_deck1_salvage",
		"nav_bridge_guppy"
	)

/obj/effect/overmap/ship/landable/guppy
	name = "Guppy"
	shuttle = "Guppy"
	max_speed = 1/(10 SECONDS)
	burn_delay = 2 SECONDS
	vessel_mass = 1700
	fore_dir = SOUTH

/obj/machinery/computer/shuttle_control/explore/guppy
	name = "guppy control console"
	shuttle_tag = "Guppy"
	req_access = list(access_guppy_helm)