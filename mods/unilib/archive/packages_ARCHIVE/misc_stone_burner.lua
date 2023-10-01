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
minetest.register_node("underch:burner", {
	description = "Burner",
	tiles = {"underch_burner.png"},
	groups = {cracky = 3, igniter = 4},
	legacy_mineral = true,
	after_destruct = underch.functions.remove_permanent_fire,
	on_ignite = underch.functions.make_permanent_fire,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "underch:burner",
	recipe = {
		{"group:vindesite","underch:ruby","group:vindesite"},
		{"underch:quartz","fire:flint_and_steel","underch:quartz"},
		{"group:vindesite","underch:ruby","group:vindesite"},
	}
})
]]--
