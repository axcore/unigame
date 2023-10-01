---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("dryplants:grass_short", {
	description = S("Short Grass"),
	tiles = {"default_grass.png^dryplants_grass_short.png", "default_dirt.png", "default_dirt.png^default_grass_side.png^dryplants_grass_short_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1,not_in_creative_inventory=1},
	--drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
minetest.register_craft({
	output = "default:dirt",
	recipe = {
		{"dryplants:grass_short"},
	}
})

minetest.register_abm({
	nodenames = {"dryplants:grass_short"},
	interval = GRASS_REGROWING_TIME, --1200, -- 20 minutes: a minetest-day/night-cycle
	chance = 100/GRASS_REGROWING_CHANCE,
	action = function(pos)
		-- Only become dirt with grass if no cut grass or hay lies on top
		local above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		if above.name ~= "dryplants:grass" and above.name ~= "dryplants:hay" then
			minetest.swap_node(pos, {name="default:dirt_with_grass"})
		end
	end,
})
]]--
