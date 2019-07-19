/datum/map/anaconda
	name = "Anaconda"
	full_name = "ITV Anaconda" //Indie Trade Vessel
	path = "anaconda"

	station_levels = list(1,2,3)
	contact_levels = list(1,2,3)
	player_levels = list(1,2,3)
	admin_levels = list(4)
	overmap_size = 50
	overmap_event_areas = 34
	usable_email_tlds = list("tri_opium.net")

	allowed_spawns = list("Cryogenic Storage")
	default_spawn = "Cryogenic Storage"

	station_name  = "ITV Anaconda"
	station_short = "Anaconda"
	dock_name     = "TBD"
	boss_name     = "Tri-Opium Command"
	boss_short    = "Command"
	company_name  = "Tri-Opium"
	company_short = "Tri"

	map_admin_faxes = list("Tri-Opium Central Office")

	//These should probably be moved into the evac controller...
	shuttle_docked_message = "Attention all hands: Jump preparation complete. The Frame-Shift drive is now spooling up, secure all stations for departure. Time to jump: approximately %ETD%."
	shuttle_leaving_dock = "Attention all hands: Jump initiated, exiting bluespace in %ETA%."
	shuttle_called_message = "Attention all hands: Jump sequence initiated. Transit procedures are now in effect. Jump in %ETA%."
	shuttle_recall_message = "Attention all hands: Jump sequence aborted, return to normal operating conditions."

	evac_controller_type = /datum/evacuation_controller/starship

	default_law_type = /datum/ai_laws/asimov
	use_overmap = 1
	num_exoplanets = 2

	away_site_budget = 3
	id_hud_icons = 'maps/torch/icons/assignment_hud.dmi'

/datum/map/anaconda/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('sound/AI/torch/commandreport.ogg', volume = 45))

/datum/map/anaconda/map_info(victim)
	to_chat(victim, "<h2>Current map information</h2>")
	to_chat(victim, "You're aboard the <b>[station_name]</b>.")
	to_chat(victim, "The vessel is staffed with a mix of SCG government personnel and hired contractors.")
	to_chat(victim, "This area of space is uncharted, away from SCG territory.")

/datum/map/anaconda/send_welcome()
	var/welcome_text = "<center><img src = daislogo.png /><br /><font size = 3><b>ITV Anaconda</b> DAIS's Sensors Readings:</font><br>"
	welcome_text += "Report generated on [stationdate2text()] at [stationtime2text()]</center><br /><br />"
	welcome_text += "<hr>Current system:<br /><b>[system_name()]</b><br /><br>"
	welcome_text += "Next system targeted for jump:<br /><b>[generate_system_name()]</b><br /><br>"
	welcome_text += "Time since last port visit:<br /><b>[rand(30,180)] days</b><br /><hr>"
	welcome_text += "Scan results show the following points of interest:<br />"
	var/list/space_things = list()
	var/obj/effect/overmap/anaconda = map_sectors["1"]
	for(var/zlevel in map_sectors)
		var/obj/effect/overmap/O = map_sectors[zlevel]
		if(O.name == anaconda.name)
			continue
		if(istype(O, /obj/effect/overmap/ship/landable)) //Don't show shuttles
			continue
		space_things |= O

	var/list/distress_calls
	for(var/obj/effect/overmap/O in space_things)
		var/location_desc = " at present co-ordinates."
		if(O.loc != anaconda.loc)
			var/bearing = round(90 - Atan2(O.x - anaconda.x, O.y - anaconda.y),5) //fucking triangles how do they work
			if(bearing < 0)
				bearing += 360
			location_desc = ", bearing [bearing]."
		if(O.has_distress_beacon)
			LAZYADD(distress_calls, "[O.has_distress_beacon][location_desc]")
		welcome_text += "<li>\A <b>[O.name]</b>[location_desc]</li>"

	if(LAZYLEN(distress_calls))
		welcome_text += "<br><b>Distress calls logged:</b><br>[jointext(distress_calls, "<br>")]<br>"
	else
		welcome_text += "<br>No distress calls logged.<br />"
	welcome_text += "<hr>"

	post_comm_message("ITV Anaconda Sensor Readings", welcome_text)
	minor_announcement.Announce(message = "New [GLOB.using_map.company_name] Update available at all communication consoles.")

/turf/simulated/wall //landlubbers go home
	name = "bulkhead"

/turf/simulated/floor
	name = "bare deck"

/turf/simulated/floor/tiled
	name = "deck"

/decl/flooring/tiling
	name = "deck"

/turf/simulated/floor/shuttle_ceiling/anaconda
	color = COLOR_HULL

/turf/simulated/floor/shuttle_ceiling/anaconda/air
	initial_gas = list("oxygen" = MOLES_O2STANDARD, "nitrogen" = MOLES_N2STANDARD)