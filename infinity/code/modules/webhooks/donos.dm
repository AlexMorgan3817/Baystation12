/decl/webhook/donos
	id = WEBHOOK_DONOS

/decl/webhook/donos/get_message(var/list/data)
	. = ..()

	if(!length(data) || !data.Find("author_ckey"))
		.["content"] = "I'm blue, da bu di da bu dai, u da bu di da bu dai da bu di da bu dai."
	else
		var/TheDonos = list(
			"color" = COLOR_WEBHOOK_DONOS,
			"footer" = list("text" = time2text(world.timeofday, "YYYY:MM:DD/hh:mm:ss")),
			"title" = DiscordSanitize("[data["author_ckey"]] posted the donos over [data["target_ckey"]]."),
		)
		TheDonos["fields"] = list()
		if(istext(data["reason"]))
			TheDonos["fields"] += list(list(
				"name" = "Reason",
				"value"= data["reason"],
//				"inline" = TRUE
			))
		if(istext(data["details"]))
			TheDonos["fields"] += list(list(
				"name" = "Details of Situation",
				"value"= data["details"],
//				"inline" = TRUE
			))
		. = list(
			"name" = "The Commisarium of Bluespace",
			"embeds" = list(TheDonos),
		)

/client/var/list/donoses = list()

/client/proc/PostDonos(client/target, reason, details)
	SSwebhooks.send(WEBHOOK_SEND_RUNTIME, list(
		"author_ckey" = ckey,
		"target_ckey" = target.ckey,
		"reason" = reason,
		"details" = details,
		)
	)

/client/verb/verbMakeDonos()
	set name = "Post Donos"
	set category = "Admin"
	set desc = "Сообщить о нарушении правил или порче игры администрации если таковая отсутствует на сервере."


	if(alert("Sure?", "Bluespace Commissary Secretary","Yes", "No, cancel!!!") == "Yes")
		var/client/target = src
		do
			if(length(GLOB.clients) <= 1 && alert("Select dude or enter his name?", "Bluespace Commissary Secretary", "Select", "Input") == "Select")
				target = input("Select the bad dude to report. Do not report yourself.", "Bluespace Commissary Secretary", src) in GLOB.clients
				target = target.ckey
			else
				target = input("So, tell me name of bad dude.", "Bluespace Commissary Secretary") as text
			if(target == src)
				alert("What did I say?", "Bluespace Commissary Secretary", "Sorry, i won't select myself anymore...👉👈")
		while(target == src)

		var/reason = input("Short title of what happend", "Bluespace Commissary Secretary")
		reason = length(reason) >= 3 ? reason : "Untitled"

		var/details
		do
			details = input("Now, describe situation. But no more 2000 characters and at least 3.", "Bluespace Commissary Secretary", details) as message
			if(length_char(details) > 2000) // TODO: Add bluespace cascade after too many tries.
				alert(
					"What did I say?",
					"Bluespace Commissary Secretary", 
						"Sorry, now i won't write more then 2000...👉👈"
					)
		while(length_char(details) > 2000 && length_char(details) <= 3)

		if(
			alert(
				"Still sure, is [target] so bad?",
				"Bluespace Commissary Secretary",
					"Yes",
					"Maybe, i should think better..."
			) == "Yes"
		)
			PostDonos(target, reason, details)
