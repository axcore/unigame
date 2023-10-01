---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_materials:mud_wet", {
	description = S("Mud Wet"),
	tiles = {"lib_materials_dirt_mud_01.png"},
	liquid_viscosity = 8,
	liquidtype = "source",
	liquid_renewable = false,
	liquid_alternative_source = "lib_materials:mud_wet",
	liquid_alternative_flowing = "lib_materials:mud_wet",
	liquid_range = 0,
	post_effect_color = {r=115, g=61, b=31, a=255},
	drowning = 1,
	walkable = false,
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
})
]]--
