---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("steel:plate_rusted", {
	description = "Rusted steel plate",
	tiles = {"steel_plate_rusted.png"},
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {cracky = 1, choppy = 1, dig_stone = 1},
})
minetest.register_abm({
	label = "rest steel blocks near water",
	nodenames = {"steel:plate_soft"},
	neighbors = {"group:water"},
	interval = 50,
	chance = 20,
	action = function(pos)
		if minetest.find_node_near(pos, 2, "air") then
			minetest.set_node(pos, {name="steel:plate_rusted"})
		end
	end,
})
]]--
