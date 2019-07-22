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
	usable_email_tlds = list("tri_opium.net", "smail.sol")

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