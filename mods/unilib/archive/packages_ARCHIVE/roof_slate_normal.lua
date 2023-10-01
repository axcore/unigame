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
minetest.register_node("cottages:slate_vertical", {
        description = S("Vertical Slate"),
        tiles = {"cottages_slate.png",cottages.texture_roof_sides,"cottages_slate.png","cottages_slate.png",cottages.texture_roof_sides,"cottages_slate.png"},
        paramtype2 = "facedir",
        groups = {cracky=2, stone=1},
        sounds = cottages.sounds.stone,
	is_ground_content = false,
})
minetest.register_craft({
	output  = "cottages:slate_vertical",
	recipe = { {cottages.craftitem_stone, cottages.craftitem_wood,  '' }
	}
});
]]--
