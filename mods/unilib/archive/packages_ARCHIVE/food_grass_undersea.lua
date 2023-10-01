---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem(name .. "_roasted_item", {
        description = desc .. " (" .. S("dry") .. ")",
        groups = {food = 1, food_vegan = 1},
        inventory_image = "aqua_farming_" .. name:split(":")[2] .. "_roasted_item.png",
})
minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = name .. "_roasted_item",
	recipe = name .. "_item",
})
]]--
