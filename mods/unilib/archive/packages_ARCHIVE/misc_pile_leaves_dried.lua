---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:dry_leaves", {
	description = "Dry Leaves",
	tiles = {"darkage_dry_leaves.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:dry_leaves",
	recipe = "default:leaves",
})
]]--
