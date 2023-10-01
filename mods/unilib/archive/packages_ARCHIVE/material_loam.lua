---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cottages:loam", {
        description = S("loam"),
        tiles = {"cottages_loam.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
        groups = {crumbly=3},
	sounds = cottages.sounds.dirt,
	is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:loam 4",
	recipe = {
		{cottages.craftitem_sand},
		{cottages.craftitem_clay}
	}
})

-- straw is a common material for places where animals are kept indoors
-- right now, this block mostly serves as a placeholder
minetest.register_node("cottages:straw_ground", {
        description = S("straw ground for animals"),
        tiles = {cottages.straw_texture,"cottages_loam.png","cottages_loam.png","cottages_loam.png","cottages_loam.png","cottages_loam.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
        groups = {crumbly=3},
        sounds = cottages.sounds.leaves,
	is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:straw_ground 2",
	recipe = {
		{"cottages:straw_mat" },
		{"cottages:loam"}
	}
})
]]--
