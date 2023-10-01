---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("underch:fiery_dust", {
	description = "Fiery Dust",
	tiles = {"underch_fiery_dust.png"},
	groups = {crumbly = 2, hot = 1, falling_node = 1},
	is_ground_content = true,
	after_destruct = underch.functions.remove_permanent_fire,
	on_ignite = underch.functions.make_permanent_fire,
	light_source = 10,
	sounds = default.node_sound_sand_defaults(),
})
]]--
