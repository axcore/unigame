mesecon.node_sound = {}

mesecon.sound_name = {}

mesecon.texture = {}

if minetest.get_modpath("unilib") then

    mesecon.dye_colors = {
        "black", "blue", "brown", "cyan", "green", "green_dark",
        "grey", "grey_dark", "magenta", "orange", "pink", "red", 
        "violet", "white", "yellow",
    }

	minetest.log("info", "Mesecons: detected unilib for game compatibility")
	dofile(minetest.get_modpath("mesecons_gamecompat").."/compat_unilib.lua")
    
elseif minetest.get_modpath("default") then

    mesecon.dye_colors = {
        "red", "green", "blue", "grey", "dark_grey", "yellow",
        "orange", "white", "pink", "magenta", "cyan", "violet",
    }

	minetest.log("info", "Mesecons: detected Minetest Game for game compatibility")
	dofile(minetest.get_modpath("mesecons_gamecompat").."/compat_mtg.lua")
    
end
