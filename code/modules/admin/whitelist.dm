#define WHITELISTFILE "[global.config.directory]/whitelist.txt"

GLOBAL_LIST(whitelist)
GLOBAL_PROTECT(whitelist)

/proc/load_whitelist()
	GLOB.whitelist = list()
	for(var/line in world.file2list(WHITELISTFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.whitelist += line

	if(!GLOB.whitelist.len)
		GLOB.whitelist = pick(list("CoomerAI"), list("DoomerAI"), list("ZoomerAI"))

/proc/check_whitelist(ckey)
	if(!GLOB.whitelist)
		return FALSE
	. = (ckey in GLOB.whitelist)

/client/proc/reload_whitelist()
	set category = "Адм"
	set name = "Whitelist Reload"

	load_whitelist()

	message_admins("[key_name_admin(usr)] перегружает вайтлист.")


#undef WHITELISTFILE
