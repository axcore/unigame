---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Bricks

nodedef = {
	description = "Snow Brick",
	tiles = {"snow_snow_brick.png"},
	is_ground_content = true,
	--freezemelt = "default:water_source", -- deprecated
	liquidtype = "none",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir", -- Allow blocks to be rotated with the screwdriver or
	-- by player position. ~ LazyJ
	 -- I made this a little harder to dig than snow blocks because
	 -- I imagine snow brick as being much more dense and solid than fluffy snow. ~ LazyJ
	groups = {cracky=2, crumbly=2, choppy=2, oddly_breakable_by_hand=2, melts=1,
		icemaker=1, cooks_into_ice=1, cools_lava = 1, snowy = 1},
	 --Let's use the new snow sounds instead of the old grass sounds. ~ LazyJ
	sounds = default.node_sound_snow_defaults(),
	-- The "on_construct" part below, thinking in terms of layers,
	-- dirt_with_snow could also double as dirt_with_frost which adds subtlety
	-- to the winterscape. ~ LazyJ
	on_construct = snow_onto_dirt
}

-- hard Ice Brick, original texture from LazyJ
local ibdef = table.copy(nodedef)
ibdef.description = "Ice Brick"
ibdef.tiles = {"snow_ice_brick.png"}
ibdef.use_texture_alpha = "blend"
ibdef.drawtype = "glasslike"
ibdef.groups = {cracky=1, crumbly=1, choppy=1, melts=1, cools_lava = 1, slippery = 3}
ibdef.sounds = default.node_sound_ice_defaults()

minetest.register_node("snow:ice_brick", ibdef)

minetest.register_craft({
	output = "snow:ice_brick",
	recipe = {
		{"default:ice", "default:ice"},
		{"default:ice", "default:ice"}
	}
})
]]--
