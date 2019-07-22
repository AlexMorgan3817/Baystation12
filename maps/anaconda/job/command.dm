/datum/job/captain
	title = "Captain"
	department = "Command"
	supervisors = "the yourself"
	department_flag = COM
	head_position = 1
	minimal_player_age = 21
	economic_power = 20
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/sierra/crew/command/captain
	total_positions = 1
	spawn_positions = 1
	req_admin_notify = 1
	allowed_branches = list()
	allowed_ranks = list(/datum/mil_rank/civ/nt)
	min_skill = list(	SKILL_BUREAUCRACY = SKILL_ADEPT,
						SKILL_PILOT       = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX)


	skill_points = 25

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)
