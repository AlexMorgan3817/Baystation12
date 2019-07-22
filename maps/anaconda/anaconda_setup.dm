/datum/map/anaconda/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('sound/AI/torch/commandreport.ogg', volume = 45))

/datum/map/anaconda/map_info(victim)
	to_chat(victim, "<h2>Информаци&#255; о карте</h2>")
	to_chat(victim, "Вы находитесь на борту <b>[station_name]</b>, независимого наёмного судна, на данный момент нанятого [company_name].")
	to_chat(victim, "Охрана судна укомплектована сотрудниками Службы Безопасности НаноТрайзен и частных предпри&#255;тий.")
	to_chat(victim, "Помимо ЧВК в охране, в остальных отделах также присутствуют подр&#255;дчики. Их нан&#255;ли как выдающихс&#255; специалистов в своей области, что превзошли корпоративного кандидата. Как правило, они либо работают на себ&#255; (civilian), либо на другую корпорацию (contractor). Полезные ссылки:")
	to_chat(victim, "<a href=\"https://wiki.infinity-ss13.info/index.php?title=Стандартные_процедуры_НТ\">Процедуры НТ</a>, <a href=\"https://wiki.infinity-ss13.info/index.php?title=Корпоративные_законы\">Регул&#255;ции НТ</a>, <a href=\"https://wiki.infinity-ss13.info/index.php?title=Коды_угрозы_НТ\">Коды угроз НТ</a>, <a href=\"https://wiki.infinity-ss13.info/index.php?title=Итак,_Вы_хотите_узнать_о_мире_корпораций%3F\">Список корпораций</a>.")
	to_chat(victim, "<br><strong>Внимание! Год игры был изменён. Теперь в игре не 2563, а 2307 (-256 лет).")

/datum/map/anaconda/send_welcome()
	var/welcome_text = "<center><img src = daislogo.png /><br /><font size = 3><b>ITV Anaconda</b> DAIS's Sensors Readings:</font><hr>"
	welcome_text += "Отчет сгенерирован [stationdate2text()] в [stationtime2text()]</center><br /><br />"
	welcome_text += "Текуща&#255; система: <b>[system_name()]</b><br />"
	welcome_text += "Следующа&#255; система дл&#255; прыжка: <b>[generate_system_name()]</b><br />"
	welcome_text += "Дней до Солнечной Системы: <b>[rand(15,45)]</b><br />"
	welcome_text += "Дней с последнего визита в порт: <b>[rand(60,180)]</b><br />"
	welcome_text += "Результаты сканировани&#255; показали следующие потенциальные объекты дл&#255; исследовани&#255;:<br />"
	var/list/space_things = list()
	var/obj/effect/overmap/sierra = map_sectors["1"]
	for(var/zlevel in map_sectors)
		var/obj/effect/overmap/O = map_sectors[zlevel]
		if(O.name == sierra.name)
			continue
		if(istype(O, /obj/effect/overmap/ship/landable))
			continue
		space_things |= O

	var/list/distress_calls
	for(var/obj/effect/overmap/O in space_things)
		var/location_desc = " на текущем квадрате."
		if(O.loc != sierra.loc)
			var/bearing = round(90 - Atan2(O.x - sierra.x, O.y - sierra.y),5) //fucking triangles how do they work
			if(bearing < 0)
				bearing += 360
			location_desc = ", по азимуту [bearing]."
		if(O.has_distress_beacon)
			LAZYADD(distress_calls, "[O.has_distress_beacon][location_desc]")
		welcome_text += "<li>\A <b>[O.name]</b>[location_desc]</li>"

	if(LAZYLEN(distress_calls))
		welcome_text += "<br><b>Обнаружены сигналы бедстви&#255;:</b><br>[jointext(distress_calls, "<br>")]<br>"
	else
		welcome_text += "<br>Сигналов бедстви&#255; не обнаружено.<br />"
	welcome_text += "<hr>"

	post_comm_message("NSV Sierra Sensor Readings", welcome_text)
	minor_announcement.Announce(message = "New [GLOB.using_map.company_name] Update available at all communication consoles.")




/datum/map/anaconda/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('infinity/sound/AI/TG/attention.ogg', volume = 45))


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
