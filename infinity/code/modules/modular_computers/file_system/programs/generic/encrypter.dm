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
	var/browsing
	var/open_file
	var/loaded_data
	var/error
	var/is_edited
	usage_flags = PROGRAM_ALL

/datum/computer_file/program/encrypter/proc/open_file(var/filename)
	var/datum/computer_file/data/F = get_file(filename)
	if(F)
		open_file = F.filename
		loaded_data = F.stored_data
		return 1

/datum/computer_file/program/encrypter/proc/save_file(var/filename)
	var/datum/computer_file/data/F = get_file(filename)
	if(!F) //try to make one if it doesn't exist
		F = create_file(filename, loaded_data, /datum/computer_file/data/text)
		return !isnull(F)
	var/datum/computer_file/data/backup = F.clone()
	var/obj/item/weapon/computer_hardware/hard_drive/HDD = computer.hard_drive
	if(!HDD)
		return
	HDD.remove_file(F)
	F.stored_data = loaded_data
	F.calculate_size()
	if(!HDD.store_file(F))
		HDD.store_file(backup)
		return 0
	is_edited = 0
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
		if(is_edited)
			if(alert("Would you like to save your changes first?",,"Yes","No") == "Yes")
				save_file(open_file)
		browsing = 1
		if(!open_file(href_list["PRG_openfile"]))
			error = "I/O error: Unable to open file '[href_list["PRG_openfile"]]'."

	if(href_list["PRG_saveasfile"])
		. = 1
		var/newname = sanitize(input(usr, "Enter file name:", "Save As") as text|null)
		if(!newname)
			return 1
		var/datum/computer_file/data/F = create_file(newname, loaded_data, /datum/computer_file/data/text)
		if(F)
			open_file = F.filename
		else
			error = "I/O error: Unable to create file '[href_list["PRG_saveasfile"]]'."
		return 1

	if(href_list["PRG_setpass"])
		var/enckey = sanitize(input(usr, "Enter new encryption key:", "Save As") as text|null)
	var/Fl_size = F.size
	if(href_list["RPG_startencrypt"])
		data["proccess"] = TRUE
		if(Fl_size <= 10)//time to encrypt = 5
			data["progress"] = 0
			while (data["progress"] <= 100)
				data["progress"] += 20
				sleep(1)
		if(F.size < 10)//time to encrypt = 20
			data["progress"] = 0
			while (data["progress"] <= 100)
				data["progress"] += 10
				sleep(2)
		if(F.size <= 25)//time to encrypt = 40
			data["progress"] = 0
			while (data["progress"] <= 100)
				data["progress"] += 5
				sleep(2)
		//End of process
		data["proccess"] = FALSE
	if(href_list["RPG_stopprocess"])
		.=1
		if(data["proccess"] == 1)
			data["proccess"] = null

/datum/nano_module/program/encrypter
	name = "Encrypter"

/datum/nano_module/program/encrypter/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = host.initial_data()
	var/datum/computer_file/program/wordprocessor/PRG
	PRG = program
	var/obj/item/weapon/computer_hardware/hard_drive/HDD
	var/obj/item/weapon/computer_hardware/hard_drive/portable/RHDD
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
					files.Add(list(list(
						"name" = F.filename,
						"size" = F.size
					)))
			data["files"] = files

			RHDD = PRG.computer.portable_drive
			if(RHDD)
				data["usbconnected"] = 1
				var/list/usbfiles[0]
				for(var/datum/computer_file/F in RHDD.stored_files)
					if(F.filetype == "ENC")
						usbfiles.Add(list(list(
							"name" = F.filename,
							"size" = F.size,
						)))
				data["usbfiles"] = usbfiles
	else if(PRG.open_file)
		data["filedata"] = pencode2html(PRG.loaded_data)
		data["filename"] = PRG.is_edited ? "[PRG.open_file]*" : PRG.open_file
	else
		data["filedata"] = pencode2html(PRG.loaded_data)
		data["filename"] = "UNNAMED"

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "encrypter.tmpl", "Encrypter", 575, 700, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()