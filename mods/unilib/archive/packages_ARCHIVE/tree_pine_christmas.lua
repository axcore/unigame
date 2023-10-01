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
-- Decorated Pine Leaves

nodedef.description ="Decorated "..nodedef.description
nodedef.light_source = 5
nodedef.waving = nil
if snow.disable_deco_needle_ani then
	nodedef.tiles = {"snow_needles_decorated.png"}
else
	-- Animated, "blinking lights" version. ~ LazyJ
	nodedef.inventory_image = minetest.inventorycube("snow_needles_decorated.png")
	nodedef.tiles = {{
		name="snow_needles_decorated_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16,
			length=20.0}
	}}
end
nodedef.drop.items[#nodedef.drop.items] = {items = {'snow:needles_decorated'}}

minetest.register_node("snow:needles_decorated", nodedef)

-- Saplings

nodedef = {
	description = "Pine Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"snow_sapling_pine.png"},
	inventory_image = "snow_sapling_pine.png",
	wield_image = "snow_sapling_pine.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3},
	furnace_burntime = 10,
	sounds = default.node_sound_defaults(),
}

-- Xmas Tree Sapling
nodedef.description = "Christmas Tree"
nodedef.tiles = {"snow_xmas_tree.png"}
nodedef.inventory_image = "snow_xmas_tree.png"
nodedef.wield_image = "snow_xmas_tree.png"

minetest.register_node("snow:xmas_tree", nodedef)

nodedef = {
	description = "Star",
	drawtype = "plantlike",
	tiles = {"snow_star.png"},
	inventory_image = "snow_star.png",
	wield_image = "snow_star.png",
	paramtype = "light",
	walkable = false,
	-- Don't want the ornament breaking too easily because you have to punch it to turn it on and off. ~ LazyJ
	groups = {cracky=1, crumbly=1, choppy=1, oddly_breakable_by_hand=1},
	-- Breaking "glass" sound makes it sound like a real, broken, Xmas tree
	-- ornament (Sorry, Mom!).  ;)-  ~ LazyJ
	sounds = default.node_sound_glass_defaults(
		{dig = {name="default_glass_footstep", gain=0.2}}),
	-- Added a "lit" star that can be punched on or off depending on your
	-- preference. ~ LazyJ
	on_punch = function(pos, node)
		node.name = "snow:star_lit"
		minetest.set_node(pos, node)
	end,
}

-- Star on Xmas Trees
minetest.register_node("snow:star", table.copy(nodedef))

-- Star (Lit Version) on Xmas Trees
nodedef.description = nodedef.description.." Lighted"
nodedef.light_source = minetest.LIGHT_MAX
nodedef.tiles = {"snow_star_lit.png"}
nodedef.drop = "snow:star"
nodedef.groups.not_in_creative_inventory = 1
nodedef.on_punch = function(pos, node)
	node.name = "snow:star"
	minetest.set_node(pos, node)
end

minetest.register_node("snow:star_lit", nodedef)
]]--
