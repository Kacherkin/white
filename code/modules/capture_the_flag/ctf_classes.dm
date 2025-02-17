// GENERIC CLASSES

/datum/outfit/ctf
	name = "CTF Rifleman (Solo)"
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest/ctf
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	id = /obj/item/card/id/away
	belt = /obj/item/gun/ballistic/automatic/pistol/deagle/ctf
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf

	///Description to be shown in the class selection menu
	var/class_description = "General purpose combat class. Armed with a laser rifle and backup pistol."
	///Radio frequency to assign players with this outfit
	var/team_radio_freq = FREQ_COMMON // they won't be able to use this on the centcom z-level, so ffa players cannot use radio
	///Icon file for the class radial menu icons
	var/icon = 'icons/hud/radial_ctf.dmi'
	///Icon state for this class
	var/icon_state = "ctf_rifleman"
	///Do they get a headset?
	var/has_radio = TRUE
	///Do they get an ID?
	var/has_card = TRUE
	///Which slots to apply TRAIT_NODROP to the items in
	var/list/nodrop_slots = list(ITEM_SLOT_OCLOTHING, ITEM_SLOT_GLOVES, ITEM_SLOT_FEET, ITEM_SLOT_ICLOTHING, ITEM_SLOT_EARS)

/datum/outfit/ctf/post_equip(mob/living/carbon/human/human_to_equip, visualsOnly=FALSE)
	if(visualsOnly)
		return
	var/list/no_drops = list()

	if(has_card)
		var/obj/item/card/id/idcard = human_to_equip.wear_id
		no_drops += idcard
		idcard.registered_name = human_to_equip.real_name
		idcard.update_label()
		idcard.update_icon()

	// Make clothing in the specified slots NODROP
	for(var/slot in nodrop_slots)
		no_drops += human_to_equip.get_item_by_slot(slot)
	// Make items in the hands NODROP
	for(var/obj/item/held_item in human_to_equip.held_items)
		no_drops += held_item
	list_clear_nulls(no_drops) // For any slots we didn't have filled
	// Apply TRAIT_NODROP to everything
	for(var/obj/item/item_to_nodrop as anything in no_drops)
		ADD_TRAIT(item_to_nodrop, TRAIT_NODROP, CAPTURE_THE_FLAG_TRAIT)

	if(has_radio)
		var/obj/item/radio/headset = human_to_equip.ears
		headset.set_frequency(team_radio_freq)
		headset.freqlock = TRUE
		headset.independent = TRUE
	human_to_equip.dna.species.stunmod = 0

/datum/outfit/ctf/instagib
	name = "CTF Instagib (Solo)"
	r_hand = /obj/item/gun/energy/laser/instakill/ctf
	shoes = /obj/item/clothing/shoes/jackboots/fast
	icon_state = "ctf_instakill"
	class_description = "General purpose combat class. Armed with a laser rifle and backup pistol."

/datum/outfit/ctf/assault
	name = "CTF Assaulter (Solo)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/light
	r_hand = /obj/item/gun/ballistic/shotgun/ctf
	gloves = /obj/item/clothing/gloves/tackler/rocket
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun
	belt = null
	icon_state = "ctf_assaulter"
	class_description = "Close combat class. Armed with a shotgun and rocket gloves."

/datum/outfit/ctf/marksman
	name = "CTF Marksman (Solo)"
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/marksman
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman
	belt = null
	icon_state = "ctf_marksman"
	class_description = "Long range class. Armed with a hitscan laser rifle."

// RED TEAM CLASSES

/datum/outfit/ctf/red
	name = "CTF Rifleman (Red)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/red
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/red
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/red
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/red
	id = /obj/item/card/id/red //it's red
	team_radio_freq = FREQ_CTF_RED

/datum/outfit/ctf/red/instagib
	name = "CTF Instagib (Red)"
	r_hand = /obj/item/gun/energy/laser/instakill/ctf/red
	shoes = /obj/item/clothing/shoes/jackboots/fast
	team_radio_freq = FREQ_CTF_RED

/datum/outfit/ctf/assault/red
	name = "CTF Assaulter (Red)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/light/red
	r_hand = /obj/item/gun/ballistic/shotgun/ctf/red
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/red
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/red
	id = /obj/item/card/id/red
	team_radio_freq = FREQ_CTF_RED

/datum/outfit/ctf/marksman/red
	name = "CTF Marksman (Red)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/red
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/marksman/red
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/red
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/red
	id = /obj/item/card/id/red
	team_radio_freq = FREQ_CTF_RED

// BLUE TEAM CLASSES

/datum/outfit/ctf/blue
	name = "CTF Rifleman (Blue)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/blue
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/blue
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/blue
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/blue
	id = /obj/item/card/id/blue //it's blue
	team_radio_freq = FREQ_CTF_BLUE

/datum/outfit/ctf/blue/warfare
	head = /obj/item/clothing/head/helmet/elite/blue
	mask = /obj/item/clothing/mask/gas/german
	uniform = /obj/item/clothing/under/victorian/vest
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/fingerless
	belt = /obj/item/melee/sabre/marineofficer
	suit = /obj/item/clothing/suit/armor/opvest
	r_hand = /obj/item/gun/ballistic/rifle/boltaction/kar98k
	l_pocket = /obj/item/ammo_box/magazine/a792x57
	r_pocket = /obj/item/ammo_box/magazine/a792x57

/datum/outfit/ctf/blue/warfare/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.add_client_colour(/datum/client_colour/warfare)
	H.overlay_fullscreen("noisewwi", /atom/movable/screen/fullscreen/noisescreen/warfare)

/datum/outfit/ctf/blue/instagib
	name = "CTF Instagib (Blue)"
	r_hand = /obj/item/gun/energy/laser/instakill/ctf/blue
	shoes = /obj/item/clothing/shoes/jackboots/fast
	team_radio_freq = FREQ_CTF_BLUE

/datum/outfit/ctf/assault/blue
	name = "CTF Assaulter (Blue)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/light/blue
	r_hand = /obj/item/gun/ballistic/shotgun/ctf/blue
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/blue
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/blue
	id = /obj/item/card/id/blue
	team_radio_freq = FREQ_CTF_BLUE

/datum/outfit/ctf/marksman/blue
	name = "CTF Marksman (Blue)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/blue
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/marksman/blue
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/blue
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/blue
	id = /obj/item/card/id/blue
	team_radio_freq = FREQ_CTF_BLUE

// GREEN TEAM CLASSES

/datum/outfit/ctf/green
	name = "CTF Rifleman (Green)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/green
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/green
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/green
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/green
	id = /obj/item/card/id/green //it's green
	team_radio_freq = FREQ_CTF_GREEN

/datum/outfit/ctf/green/instagib
	name = "CTF Instagib (Green)"
	r_hand = /obj/item/gun/energy/laser/instakill/ctf/green
	shoes = /obj/item/clothing/shoes/jackboots/fast
	team_radio_freq = FREQ_CTF_GREEN

/datum/outfit/ctf/assault/green
	name = "CTF Assaulter (Green)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/light/green
	r_hand = /obj/item/gun/ballistic/shotgun/ctf/green
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/green
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/green
	id = /obj/item/card/id/green
	team_radio_freq = FREQ_CTF_GREEN

/datum/outfit/ctf/marksman/green
	name = "CTF Marksman (Green)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/green
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/marksman/green
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/green
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/green
	id = /obj/item/card/id/green
	team_radio_freq = FREQ_CTF_GREEN

// YELLOW TEAM CLASSES

/datum/outfit/ctf/yellow
	name = "CTF Rifleman (Yellow)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/yellow
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/yellow
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/yellow
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/rifle/yellow
	id = /obj/item/card/id/yellow //it's yellow
	team_radio_freq = FREQ_CTF_YELLOW

/datum/outfit/ctf/yellow/warfare
	head = /obj/item/clothing/head/helmet/elite/yellow
	mask = /obj/item/clothing/mask/gas/german
	uniform = /obj/item/clothing/under/victorian/vest
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/fingerless
	belt = /obj/item/melee/sabre/marineofficer
	suit = /obj/item/clothing/suit/armor/opvest
	r_hand = /obj/item/gun/ballistic/rifle/boltaction/kar98k
	l_pocket = /obj/item/ammo_box/magazine/a792x57
	r_pocket = /obj/item/ammo_box/magazine/a792x57

/datum/outfit/ctf/yellow/warfare/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.add_client_colour(/datum/client_colour/warfare)
	H.overlay_fullscreen("noisewwi", /atom/movable/screen/fullscreen/noisescreen/warfare)

/datum/outfit/ctf/yellow/instagib
	name = "CTF Instagib (Yellow)"
	r_hand = /obj/item/gun/energy/laser/instakill/ctf/yellow
	shoes = /obj/item/clothing/shoes/jackboots/fast
	team_radio_freq = FREQ_CTF_YELLOW

/datum/outfit/ctf/assault/yellow
	name = "CTF Assaulter (Yellow)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/light/yellow
	r_hand = /obj/item/gun/ballistic/shotgun/ctf/yellow
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/yellow
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/shotgun/yellow
	id = /obj/item/card/id/yellow
	team_radio_freq = FREQ_CTF_YELLOW

/datum/outfit/ctf/marksman/yellow
	name = "CTF Marksman (Yellow)"
	suit = /obj/item/clothing/suit/armor/vest/ctf/yellow
	r_hand = /obj/item/gun/ballistic/automatic/laser/ctf/marksman/yellow
	l_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/yellow
	r_pocket = /obj/item/ammo_box/magazine/recharge/ctf/marksman/yellow
	id = /obj/item/card/id/yellow
	team_radio_freq = FREQ_CTF_YELLOW
