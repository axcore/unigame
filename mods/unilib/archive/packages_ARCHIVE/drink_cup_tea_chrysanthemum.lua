---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tea
-- Code:    LGPL v2.1
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("tea:chrysanthemum", {
    description = "chrysanthemum tea",
    inventory_image = "chrysanthemum_tea.png"
})

minetest.register_craft({
    type = "shapeless",
    output = "tea:chrysanthemum",
    recipe = {
        "flowers:chrysanthemum_green",
        "flowers:chrysanthemum_green",
        "flowers:chrysanthemum_green",
	"flowers:chrysanthemum_green",
	"flowers:chrysanthemum_green",
	"flowers:chrysanthemum_green",
	"default:torch",
	"bucket:bucket_water",
	"vessels:drinking_glass",
    },
})
]]--
