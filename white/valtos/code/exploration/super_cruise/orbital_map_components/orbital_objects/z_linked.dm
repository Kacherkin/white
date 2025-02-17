/datum/orbital_object/z_linked
	name = "Неизвестный маяк"
	collision_type = COLLISION_Z_LINKED
	collision_flags = COLLISION_SHUTTLES
	priority = 1
	//Its a beacon, its emitting a signal
	signal_range = 1000
	//Minimum velocity before you are forcefully collided with this location
	//0 if disabled
	var/min_collision_velocity = 0
	//The space level(s) we are linked to
	var/list/datum/space_level/linked_z_level
	//If docking is forced upon collision
	//If you hit a planet, you are going to the planet whether you like it or not.
	var/forced_docking = FALSE
	//Can you dock on this Z-level anywhere?
	var/can_dock_anywhere = FALSE
	//If we can't dock anywhere, will we just crash on the Z-level at a random position?
	var/random_docking = FALSE
	//Inherit the name of z-level?
	var/inherit_name = FALSE
	//are we generateing
	var/is_generating = FALSE

/datum/orbital_object/z_linked/proc/link_to_z(datum/space_level/level)
	LAZYADD(linked_z_level, level)
	if(inherit_name)
		name = level.name

/datum/orbital_object/z_linked/is_distress()
	for(var/datum/space_level/level as() in linked_z_level)
		if(SSorbits.assoc_distress_beacons["[level.z_value]"])
			return TRUE
	return FALSE

/datum/orbital_object/z_linked/explode()
	message_admins("ORBITAL BODY [name] WAS DESTROYED.")
	log_game("Orbital body [name] was destroyed.")
	//Holy shit this is bad.
	for(var/mob/living/L in GLOB.mob_living_list)
		for(var/datum/space_level/level as() in linked_z_level)
			if(L.z == level.z_value)
				L.gib()
				break
	//Kill the shuttles
	for (var/obj/docking_port/mobile/M in SSshuttle.mobile)
		M.intoTheSunset()
	//Kill the z-level
	for (var/datum/space_level/space_level in linked_z_level)
		SSzclear.wipe_z_level(space_level.z_value)
	//Prevent access to the z-level.
	qdel(src)

/datum/orbital_object/z_linked/collision(datum/orbital_object/other)
	//Send shuttle to z-level for docking.
	if(istype(other, /datum/orbital_object/shuttle))
		//send them to the place
		var/datum/orbital_object/shuttle/shuttle = other
		//Check if shuttle can dock at this location.
		if(!random_docking && !(can_dock_anywhere && (!GLOB.shuttle_docking_jammed || shuttle.stealth || !istype(src, /datum/orbital_object/z_linked/station))))
			var/can_dock_here = FALSE
			for(var/port_name in shuttle.valid_docks)
				var/obj/docking_port/port = SSshuttle.getDock(port_name)
				if(z_in_contents(port?.z))
					can_dock_here = TRUE
					break
			if(!can_dock_here)
				return
		//Check overspeed
		if(min_collision_velocity && other.velocity.Length() > min_collision_velocity)
			//You crashed...
			shuttle.commence_docking(src, TRUE, FALSE, TRUE)
			var/datum/space_level/picked_level = pick(linked_z_level)
			//Crashing
			shuttle.random_drop(picked_level.z_value, TRUE)
			return
		shuttle.commence_docking(src)

/datum/orbital_object/z_linked/proc/z_in_contents(z_value)
	if(!LAZYLEN(linked_z_level))
		return FALSE
	for(var/datum/space_level/level as() in linked_z_level)
		if(level.z_value == z_value)
			return TRUE
	return FALSE
