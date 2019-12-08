#if !defined(using_map_DATUM)

//general
	#include "anaconda_announcements.dm"
	//#include "anaconda_antagonism.dm"
	#include "anaconda_areas.dm"

	#include "anaconda_lobby.dm"

	#include "anaconda_ranks.dm"
	//#include "anaconda_security_state.dm"

	#include "anaconda_overmap.dm"
	#include "anaconda_setup.dm"
	#include "anaconda_shuttles.dm"
	#include "anaconda_submaps.dm"

	#include "anaconda_turfs.dm"
	#include "anaconda_elevator.dm"
	#include "anaconda_presets.dm"
	#include "anaconda_procs.dm"

	//#include "anaconda_unit_testing.dm"

//secondary level
	#include "job/access.dm"
	#include "obj/items.dm"
	#include "obj/effects/effects.dm"



//vessel levels
	#include "_anaconda-R.dmm"
	#include "anaconda-2.dmm"
	#include "anaconda-3.dmm"
	#include "~anaconda-B.dmm"
	#include "../away/empty.dmm"



//away

	//away_inf
	#include "../away_inf/yacht/yacht.dm"
	#include "../away_inf/smugglers/smugglers.dm"
	#include "../away_inf/blueriver/blueriver.dm"
	#include "../away_inf/mining/mining.dm"
	#include "../away_inf/skrellscoutship/skrellscoutship.dm"

	//away_bay
	#include "../away/bearcat/bearcat.dm"

	//#include "../away/mining/mining.dm"

	#include "../away/derelict/derelict.dm"
	#include "../away/magshield/magshield.dm"
	#include "../away/casino/casino.dm"

	//#include "../away/icarus/icarus.dm"
	#include "../away/errant_pisces/errant_pisces.dm"
	#include "../away/lar_maria/lar_maria.dm"
	#include "../away/unishi/unishi.dm"
	#include "../away/slavers/slavers_base.dm"
	#include "../away/voxship/voxship.dm"



	#define using_map_DATUM /datum/map/anaconda

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring anaconda

#endif
