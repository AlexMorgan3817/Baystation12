/datum/computer_file/data
	var/encrypted = FALSE

/datum/computer_file/program/encrypter
	filename = "encrpt"
	filedesc = "Free NT Encrypter"
	extended_desc = "This program allows to encrypt and decrypt your files with custom encryption key."
	program_icon_state = "word"
	program_key_state = "atmos_key"
	size = 6
	requires_ntnet = 0
	available_on_ntnet = 1
	nanomodule_path = /datum/nano_module/program/encrypter
	var/list/data = list()
	var/open_file
	var/browsing = 1
	var/error
	var/is_edited
	var/progress = 0
	var/is_working = 0
	var/en_key = null
	var/en_speed = 1
	usage_flags = PROGRAM_ALL

/datum/computer_file/program/encrypter/process_tick()
	if (is_working)
		progress = min(progress + 1, 100)
	if (progress == 100)
		is_working = 0


/datum/computer_file/program/encrypter/proc/open_file(var/filename)
	var/datum/computer_file/data/F = get_file(filename)
	if(F && !(F.encrypted))
		open_file = F.filename
		return 1

/datum/computer_file/program/encrypter/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["PRG_closebrowser"])
		browsing = 0
		return 1

	if(href_list["PRG_backtomenu"])
		error = null
		return 1

	if(href_list["PRG_loadmenu"])
		browsing = 1
		return 1

	if(href_list["PRG_openfile"])
		. = 1
		browsing = 0
		if(!open_file(href_list["PRG_openfile"]))
			error = "I/O error: Unable to open file '[href_list["PRG_openfile"]]'."

	if(href_list["PRG_setpass"])
		en_key = sanitize(input(usr, "Enter new encryption key:", "Save As") as text|null)

	if(href_list["PRG_startencrypt"])
		. = 1
		var/computer_file/data/F = get_file(filename)
		is_working = 1
		progress = 0
		en_speed = 1

	if(href_list["PRG_stopprocess"])
		. = 1
		is_working = 0 

/datum/nano_module/program/encrypter
	name = "Encrypter"

/datum/nano_module/program/encrypter/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = host.initial_data()
	var/datum/computer_file/program/encrypter/PRG
	PRG = program
	var/obj/item/weapon/computer_hardware/hard_drive/HDD
	if(PRG.error)
		data["error"] = PRG.error
	if(PRG.browsing)
		data["browsing"] = PRG.browsing
		if(!PRG.computer || !PRG.computer.hard_drive)
			data["error"] = "I/O ERROR: Unable to access hard drive."
		else
			HDD = PRG.computer.hard_drive
			var/list/files[0]
			for(var/datum/computer_file/F in HDD.stored_files)
				if(F.filetype == "TXT")
					files.Add(list(list( "name" = F.filename, "size" = F.size )))
			data["files"] = files
	else
		data["filename"] = PRG.open_file
		data["is_working"] = PRG.is_working
		data["progress"] = PRG.progress

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "encrypter.tmpl", "Encrypter", 575, 700, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()
