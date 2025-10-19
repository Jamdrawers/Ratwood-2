/datum/job/roguetown/manorguard
	title = "Rookie"
	flag = MANATARMS
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT)
	job_traits = list(TRAIT_GUARDSMAN)
	tutorial = "Ready to prove yourself loyal and capable, you are entrusted to defend the town and enforce its laws. \
				Trained regularly in combat and siege warfare, you deal with threats - both within and without. \
				Obey your Sergeant-at-Arms, the Marshal, and the Crown. Show the nobles and knights your respect, so that you may earn it in turn. Not as a commoner, but as a soldier.."
	display_order = JDO_CASTLEGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/manorguard
	advclass_cat_rolls = list(CTAG_MENATARMS = 20)

	give_bank_account = 12
	min_pq = 3
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_ManAtArms.ogg'
	job_subclasses = list(
		/datum/advclass/manorguard/footsmanrecruit,
		/datum/advclass/manorguard/skirmisherrecruit,
	)

/datum/outfit/job/roguetown/manorguard
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/manorguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "man-at-arms jupon ([index])"

/datum/outfit/job/roguetown/manorguard
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	beltl = /obj/item/rogueweapon/mace/cudgel
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	id = /obj/item/scomstone/bad/garrison

// Melee goon
/datum/advclass/manorguard/footsman
	name = "Footman"
	tutorial = "You are a trainee soldier of the realm, beginning your training in melee warfare."
	outfit = /datum/outfit/job/roguetown/manorguard/footsman

	category_tags = list(CTAG_MENATARMS)
	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_STR = 1,// seems kinda lame but remember guardsman bonus!!
		STATKEY_WIL = 1
	)

/datum/outfit/job/roguetown/manorguard/footsman/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron

	H.adjust_blindness(-3)
	var/weapons = list("Warhammer & Shield","Axe & Shield","Halberd","Greataxe")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Warhammer & Shield")
			beltr = /obj/item/rogueweapon/mace/warhammer
			backl = /obj/item/rogueweapon/shield/iron
		if("Axe & Shield")
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
			backl = /obj/item/rogueweapon/shield/iron
		if("Halberd")
			r_hand = /obj/item/rogueweapon/halberd
			backl = /obj/item/rogueweapon/scabbard/gwstrap
		if("Greataxe")
			r_hand = /obj/item/rogueweapon/greataxe
			backl = /obj/item/rogueweapon/scabbard/gwstrap
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1,
		)
	H.verbs |= /mob/proc/haltyell

	var/helmets = list(
	"Simple Helmet" 	= /obj/item/clothing/head/roguetown/helmet,
	"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle,
	"Bascinet Helmet"		= /obj/item/clothing/head/roguetown/helmet/bascinet,
	"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet,
	"Winged Helmet" 	= /obj/item/clothing/head/roguetown/helmet/winged,
	"Skull Cap"			= /obj/item/clothing/head/roguetown/helmet/skullcap,
	"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Lightweight Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine/light,
		"Iron Hauberk"		= /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron,
		"Scalemail"	= /obj/item/clothing/suit/roguetown/armor/plate/scale,
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]

	var/arms = list(
		"Brigandine Splint Arms"		= wrists = /obj/item/clothing/wrists/roguetown/splintarms,
		"Steel Bracers"		= wrists = /obj/item/clothing/wrists/roguetown/bracers,
		"Jack Chains"		= wrists = /obj/item/clothing/wrists/roguetown/bracers/jackchain,
	)
	var/armschoice = input("Choose your arm protection.", "READY THYSELF") as anything in arms
	wrists = arms[armschoice]

	var/chausses = list(
		"Brigandine Chausses"		= /obj/item/clothing/under/roguetown/splintlegs,
		"Steel Chain Chausses"		= /obj/item/clothing/under/roguetown/chainlegs,
	)
	var/chausseschoice = input("Choose your chausses.", "READY THYSELF") as anything in chausses
	pants = chausses[chausseschoice]

// Ranged weapons and daggers on the side - lighter armor, but fleet!
/datum/advclass/manorguard/skirmisher
	name = "Skirmisher"
	tutorial = "You are a professional soldier of the realm, specializing in ranged implements. You sport a keen eye, looking for your enemies weaknesses."
	outfit = /datum/outfit/job/roguetown/manorguard/skirmisher

	category_tags = list(CTAG_MENATARMS)
	//Garrison ranged/speed class. Time to go wild
	subclass_stats = list(
		STATKEY_SPD = 1,// seems kinda lame but remember guardsman bonus!!
		STATKEY_PER = 1,
	)
	extra_context = "Chooses between Light Armor (Dodge Expert) & Medium Armor."

/datum/outfit/job/roguetown/manorguard/skirmisher/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE) 		// Still have a cugel.
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)		//Only effects draw and reload time.
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)			//Only effects draw times.
	H.adjust_skillrank(/datum/skill/combat/slings, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) // A little better; run fast, weak boy.
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord			// Cant wear chainmail anymoooree
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded		//Helps against arrows; makes sense for a ranged-type role.
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	pants = /obj/item/clothing/under/roguetown/trou/leather
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather

	H.adjust_blindness(-3)
	var/weapons = list("Crossbow","Bow","Sling")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	var/armor_options = list("Light Armor", "Medium Armor")
	var/armor_choice = input("Choose your armor.", "TAKE UP ARMS") as anything in armor_options
	H.set_blindness(0)
	switch(weapon_choice)
		if("Crossbow")
			beltr = /obj/item/quiver/bolts
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
		if("Bow") // They can head down to the armory to sideshift into one of the other bows.
			beltr = /obj/item/quiver/arrows
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
		if("Sling")
			beltr = /obj/item/quiver/sling/iron
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/sling // Both are belt slots and it's not worth setting where the cugel goes for everyone else, sad.

	switch(armor_choice)
		if("Light Armor")
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		if("Medium Armor")
			pants = /obj/item/clothing/under/roguetown/chainlegs
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	var/arms = list(
		"Brigandine Splint Arms"		= wrists = /obj/item/clothing/wrists/roguetown/splintarms,
		"Steel Bracers"		= wrists = /obj/item/clothing/wrists/roguetown/bracers,
		"Jack Chains"		= wrists = /obj/item/clothing/wrists/roguetown/bracers/jackchain,
	)
	var/armschoice = input("Choose your arm protection.", "READY THYSELF") as anything in arms
	wrists = arms[armschoice]

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1,
		)
	H.verbs |= /mob/proc/haltyell

	var/helmets = list(
	"Simple Helmet" 	= /obj/item/clothing/head/roguetown/helmet,
	"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle,
	"Bascinet Helmet"		= /obj/item/clothing/head/roguetown/helmet/bascinet,
	"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet,
	"Winged Helmet" 	= /obj/item/clothing/head/roguetown/helmet/winged,
	"Skull Cap"			= /obj/item/clothing/head/roguetown/helmet/skullcap,
	"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

		