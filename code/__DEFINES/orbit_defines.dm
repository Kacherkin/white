
#define GRAVITATIONAL_CONSTANT 1

//Once the acceleration towards this object is smaller than this value, it will be ignored.
#define MINIMUM_EFFECTIVE_GRAVITATIONAL_ACCEELRATION 0.0001

#define ORBITAL_UPDATE_RATE (1 SECONDS)	//10 stupidseconds
#define ORBITAL_UPDATE_RATE_SECONDS 1	//1 second
#define ORBITAL_UPDATES_PER_SECOND 1	//1 per second

#define RUIN_PART_DEFAULT (1<<0)
#define RUIN_PART_HABITABLE (1<<1)
#define RUIN_PART_CITY (1<<2)

#define PRIMARY_ORBITAL_MAP "primary"

//Orbital map collision detection
//Objects cannot have a radius greater than this value /3 without refactoring.
#define ORBITAL_MAP_ZONE_SIZE 600		//The size of a collision detection zone on an orbital map.

#define ORBITAL_MAX_RADIUS ORBITAL_MAP_ZONE_SIZE * 0.5

//Vector position updates
#define MOVE_ORBITAL_BODY(body_to_move, new_x, new_y) \
	do {\
		var/prev_x = body_to_move.position.GetX();\
		var/prev_y = body_to_move.position.GetY();\
		body_to_move.position.SetUnsafely(new_x, new_y);\
		var/datum/orbital_map/attached_map = SSorbits.orbital_maps[body_to_move.orbital_map_index];\
		attached_map.on_body_move(body_to_move, prev_x, prev_y);\
	} while (FALSE)

//Collision flags
#define COLLISION_UNDEFINED (1 << 0) //Default flag
#define COLLISION_SHUTTLES (1 << 1)	//Shuttle collision flag
#define COLLISION_Z_LINKED (1 << 2)	//Z linked collision flag
#define COLLISION_METEOR (1 << 3) //Meteor collisions
#define COLLISION_HAZARD (1 << 4)	//Map hazards

//Render modes
//These are defined in OrbitalMapSvg.js
//Its much better to have the defines on the javascript so we don't have to constantly send it across every update.
#define RENDER_MODE_DEFAULT "default"			//Classic white circle with a velocity line
#define RENDER_MODE_PLANET "planet"				//Filled circle
#define RENDER_MODE_BEACON "beacon"				//Some kind of beacon type thing?
#define RENDER_MODE_SHUTTLE "shuttle"			//Maybe a green square with heading line + line indicating where it came from
#define RENDER_MODE_PROJECTILE "projectile"		//No circle, just a straight, short velocity line.
#define RENDER_MODE_HAZARD "hazard"				//Hazard on the map, Red stripes

//The amount of a ship that has to be damaged before it is considered destroyed (45%) (This seems very low, but damaging a turf only does 20% damage for that turf, with each turf having up to 5 damage levels)
#define SHIP_INTEGRITY_FACTOR_NPC 0.8
#define SHIP_INTEGRITY_FACTOR_PLAYER 0.45

//Faction status
#define FACTION_STATUS_FRIENDLY "friendly"
#define FACTION_STATUS_NEUTRAL "neutral"
#define FACTION_STATUS_HOSTILE "hostile"

//How AIs should aproach combat
#define BATTLE_POLICY_AVOID 0.7			//For ships that don't wanna combat
#define BATTLE_POLICY_CAREFUL 0.45		//For ships that don't mind a fight, but would rather not die
#define BATTLE_POLICY_SUSTAINED 0.15	//Will keep a fight going and will only retreat when very, very low
#define BATTLE_POLICY_NO_RETREAT 0		//Death to nanotrasen (This can also be used for dropships with no weapons)
