/datum/computer_file/program/holoprocessor
	filename = "engramprocessor"
	filedesc = "DAIS HoloEngram Programer"
	extended_desc = "This program developed by DAIS for programing artificial holographic engrams."
	program_icon_state = "word"
	program_key_state = "atmos_key"
	program_menu_icon = "script"
	size = 16
	requires_ntnet = FALSE
	available_on_ntnet = TRUE
	nanomodule_path = /datum/nano_module/program/computer_holoprocessor/
	usage_flags = PROGRAM_ALL
	category = PROG_OFFICE

	var/default_delay = 0.5
	var/fname = "NewHologram"
	var/list/loaded_data = list()
	var/tmp/cached_loaded_data = 0
	var/error
	var/browsing
	var/algorithmlenPerProcessing = 16

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
	else
		result.calculate_size()
/datum/computer_file/program/holoprocessor/proc/clear_file()
	fname = "NewHologram"
	loaded_data = list()
	cached_loaded_data = 0

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
			var/inp = sanitize(input(usr, "Edit message (512 characters cap)", "Message", loaded_data[index]["message"]) as message)
			if(length_char(inp) <= 512)
				loaded_data[index]["message"] = inp
				cached_loaded_data = holoengram_size_by_program(loaded_data)
				return 1
		return
	if(href_list["PRG_change_sleep"])
		var/index = clamp(text2num(href_list["PRG_change_sleep"]) + 1, 1, length(loaded_data))
		if(length(loaded_data) >= index)
			var/inp = clamp(input(usr, "Delay before next message \[0-20] seconds:", "Delay", loaded_data[index]["delay"]) as num, 0, 20)
			loaded_data[index]["delay"] = inp
			return 1
		return
/*
	if(href_list["PRG_change_goto"])
		var/index = clamp(text2num(href_list["PRG_change_goto"]) + 1, 1, length(loaded_data))
		var/goto_index = input(usr, "Go to command after delay:", "Go to", loaded_data[index]["goto"]) as text|null
		if(goto_index && length_char(goto_index) <= 4)
			var/converted = text2num(goto_index)
			if(isnum(converted))
				goto_index = converted // no clamp, because holographer self must give error if it face an inappropriate goto
			loaded_data[index]["goto"] = goto_index
			return 1
		return
*/
	if(href_list["PRG_swap"])
		var/index = clamp(text2num(href_list["PRG_swap"]) + 1, 1, length(loaded_data))
		var/goto_swap
		if(href_list["PRG_swap_index"])
			goto_swap = clamp(index + text2num(href_list["PRG_swap_index"]), 1, length(loaded_data))
		else
			goto_swap = input(usr, "Swap with index:", "Go to", loaded_data[index]["goto"]) as num|null
			if(goto_swap == null)
				return
			goto_swap = clamp(text2num(goto_swap), 1, length(loaded_data))
		if(goto_swap)
			loaded_data.Swap(index, goto_swap)
			return 1
		return
	if(href_list["PRG_addcommand"])
		var/index = clamp(text2num(href_list["PRG_addcommand"]) + 2, 1, length(loaded_data) + 1)
		var/obj/item/stock_parts/computer/processor_unit/CPU = computer.get_component(PART_CPU)
		if(length(loaded_data) + 1 >= index)
			if(algorithmlenPerProcessing * CPU.processing_power > length(loaded_data))
				loaded_data.Insert(index, list(HOLOEN_ALGORITHM_BLOCK("", default_delay)))
			else
				error = "CPU ERROR: RAM is full, can't add more commands"
			return 1
		return
	if(href_list["PRG_removecommand"])
		var/index = clamp(text2num(href_list["PRG_removecommand"]) + 1, 1, length(loaded_data))
		if(length(loaded_data) >= index)
			loaded_data.Cut(index, index + 1)
			cached_loaded_data = holoengram_size_by_program(loaded_data)
			return 1
		return
	if(href_list["PRG_openfile"])
		. = open_file(href_list["PRG_openfile"])
		if(.)
			cached_loaded_data = holoengram_size_by_program(loaded_data)
		browsing = 0
		return
	if(href_list["PRG_rename"])
		var/nfn = sanitize(input(usr, "Enter file name (20 characters cap):", "New Engram", fname) as text|null)
		if(istext(nfn) && length(nfn) <= 20)
			fname = nfn
			return 1
		return
	if(href_list["PRG_default_delay"])
		default_delay = text2num(input(usr, "Default delay when command created:", "Default Delay", default_delay) as num)
		return 1
	return 1
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
		data["filedata_size"] = PRG.cached_loaded_data
		data["default_delay"] = PRG.default_delay

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "_inf.holo_processor.tmpl", "Holo Processor", 700, 700, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()