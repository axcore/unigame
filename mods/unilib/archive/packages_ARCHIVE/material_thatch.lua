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
minetest.register_node("cottages:reet", {
        description = S("Reet for thatching"),
        tiles = {"cottages_reet.png"},
	groups = {hay = 3, snappy=3,choppy=3,oddly_breakable_by_hand=3,flammable=3},
        sounds = cottages.sounds.leaves,
	is_ground_content = false,
})
minetest.register_craft({
	output  = "cottages:reet",
	recipe = { {cottages.craftitem_papyrus,cottages.craftitem_papyrus},
	           {cottages.craftitem_papyrus,cottages.craftitem_papyrus},
	},
})
]]--
