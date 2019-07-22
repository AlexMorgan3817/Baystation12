
/***********
Unique items
***********/

/obj/item/weapon/pen/multi/cmd/hop
	name = "first mate's pen"
	icon = 'maps/sierra/icons/obj/uniques.dmi'
	icon_state = "pen_xo"
	desc = "A slightly bulky pen with a silvery case. Twisting the top allows you to switch the nib for different colors."

/obj/item/weapon/pen/multi/cmd/captain
	name = "captain's pen"
	icon = 'maps/sierra/icons/obj/uniques.dmi'
	icon_state = "pen_co"
	desc = "A slightly bulky pen with a golden case. Twisting the top allows you to switch the nib for different colors."

/obj/item/weapon/pen/multi/cmd/attack_self(mob/user)
	if(++selectedColor > 3)
		selectedColor = 1
	colour = colors[selectedColor]
	to_chat(user, "<span class='notice'>Changed color to '[colour].'</span>")



/******
Weapons
******/

/obj/item/weapon/gun/projectile/revolver/medium/captain/anaconda
	name = "Killer of Chemists"
	desc = "A shiny automatic revolver, with black accents. It isn't marked. Uses .357 magnum rounds."