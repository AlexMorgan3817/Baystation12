/datum/computer_file/program/holoprocessor
	filename = "engramprocessor"
	filedesc = "DAIS HoloEngram Programer"
	extended_desc = "This program developed by DAIS for programing artificial holographic engrams."
	program_icon_state = "word"
	program_key_state = "atmos_key"
	size = 16
	requires_ntnet = FALSE
	available_on_ntnet = TRUE
	nanomodule_path = /datum/nano_module/program/computer_holoprocessor/
	usage_flags = PROGRAM_ALL
	category = PROG_OFFICE

	var/fname = "NewHologram"
	var/list/loaded_data = list()
	var/error
	var/browsing
	var/maxalgorithmlen = 20

/datum/computer_file/program/holoprocessor/proc/open_file(var/_fname)
	var/datum/computer_file/holoengram/F = get_file(_fname)
	if(F)
		fname = _fname
		loaded_data = F.program.Copy()
		return 1

/datum/computer_file/program/holoprocessor/proc/save_file(var/_fname)
	var/datum/computer_file/holoengram/result = new()
	result.program = loaded_data.Copy()
	result.filename = _fname
	. = computer.store_file(result)
	if(!.)
		error = "I/O Error: Check hard drive. You need [result.size] GQ."
		qdel(result)

/datum/computer_file/program/holoprocessor/proc/clear_file()
	fname = "NewHologram"
	loaded_data = list()

/datum/computer_file/program/holoprocessor/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["PRG_closebrowser"])
		browsing = 0
		return 1
	if(href_list["PRG_loadmenu"])
		browsing = 1
		return 1
	if(href_list["PRG_backtomenu"])
		error = null
		return 1
	if(href_list["PRG_clear"])
		if(alert(usr, "Are you sure?", "Confirm", "Yes", "No") == "Yes")
			clear_file()
			return 1
		return
	if(href_list["PRG_save"])
		save_file(fname)
		return 1
	if(href_list["PRG_change_message"])
		var/index = clamp(text2num(href_list["PRG_change_message"]) + 1, 1, length(loaded_data))
		if(length(loaded_data) >= index)
			var/inp = sanitize(input(usr, "Edit message (512 characters cap)", "Input", loaded_data[index]["message"]) as text|null)
			if(istext(inp) && length_char(inp) <= 512)
				loaded_data[index]["message"] = inp
				return 1
		return
	if(href_list["PRG_change_sleep"])
		var/index = clamp(text2num(href_list["PRG_change_sleep"]) + 1, 1, length(loaded_data))
		if(length(loaded_data) >= index)
			var/inp = clamp(input(usr, "Delay before next message \[0-20] seconds):", "Input", loaded_data[index]["sleep"]) as num|null, 0, 20)
			loaded_data[index]["sleep"] = inp
			return 1
		return
	if(href_list["PRG_addcommand"])
		var/index = clamp(text2num(href_list["PRG_addcommand"]) + 2, 1, length(loaded_data) + 1)
		var/obj/item/stock_parts/computer/processor_unit/CPU = computer.get_component(PART_CPU)
		if(length(loaded_data) + 1 >= index && maxalgorithmlen * CPU.processing_power > length(loaded_data))
			loaded_data.Insert(index, list(list("message" = "", "sleep" = 0)))
			return 1
	if(href_list["PRG_openfile"])
		return open_file(href_list["PRG_openfile"])
	if(href_list["PRG_rename"])
		var/nfn = sanitize(input(usr, "Enter file name (20 characters cap):", "New Engram", fname) as text|null)
		if(istext(nfn) && length(nfn) <= 20)
			fname = nfn
			return 1
		return

/datum/nano_module/program/computer_holoprocessor
	name = "HoloEngram Programer"

/datum/nano_module/program/computer_holoprocessor/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = host.initial_data()
	var/datum/computer_file/program/holoprocessor/PRG
	PRG = program

	if(PRG.error)
		data["error"] = PRG.error
	else if(PRG.browsing)
		data["browsing"] = PRG.browsing
		if(!PRG.computer || !PRG.computer.has_component(PART_HDD))
			data["error"] = "I/O ERROR: Unable to access hard drive."
		else
			var/list/files = list()
			for(var/datum/computer_file/holoengram/F in PRG.computer.get_all_files())
				files.Add(list(list(
					"name" = F.filename,
					"size" = F.size
				)))
			data["files"] = files

			var/obj/item/stock_parts/computer/hard_drive/portable/RHDD = PRG.computer.get_component(PART_DRIVE)
			if(RHDD)
				var/list/usbfiles = list()
				for(var/datum/computer_file/holoengram/F in PRG.computer.get_all_files(RHDD))
					usbfiles.Add(list(list(
						"name" = F.filename,
						"size" = F.size,
					)))
				data["usbfiles"] = usbfiles
	else
		data["filename"] = PRG.fname
		data["filedata"] = PRG.loaded_data

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "_inf.holo_processor.tmpl", "Holo Processor", 575, 700, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()