/datum/stigma
	var/name = "unknown stigma"
	var/desc = "unknown stigma?"
	var/list/stigma_nodes = /datum/stigmata_node/default
	var/list/active_nodes
	var/mob/owner

/datum/stigma/New(_owner)
	. = ..()
	if(ismob(_owner))
		owner = _owner
	if(ispath(stigma_nodes, /datum/stigmata_nodes))
		stigma_nodes = subtypesof(stigma_nodes)

/datum/stigma/proc/onLife()
	if(islist(stigma_nodes))
		for(var/datum/stigmata_node/node in stigma_nodes)
			node.onLife(arglist(args))
