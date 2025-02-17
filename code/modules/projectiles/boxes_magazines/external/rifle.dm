/obj/item/ammo_box/magazine/m10mm/rifle
	name = "винтовочный 10мм магазин"
	desc = "Содержит обычные патроны калибра 10мм. Используется в самозарядных винтовках."
	icon_state = "75-8"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/m10mm/rifle/update_icon()
	..()
	if(ammo_count())
		icon_state = "75-8"
	else
		icon_state = "75-0"

/obj/item/ammo_box/magazine/m556
	name = "горизонтальный магазин калибра 5.56мм"
	desc = "Содержит обычные патроны калибра 5.56мм. Используется в пистолет-пулемете M-90gl."
	icon_state = "5.56m"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m556/phasic
	name = "toploader magazine (5.56mm Phasic)"
	ammo_type = /obj/item/ammo_casing/a556/phasic
