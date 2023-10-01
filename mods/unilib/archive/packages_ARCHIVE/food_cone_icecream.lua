---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("icecream:cone", {
	description = S("Cone"),
	inventory_image = "icecream_cone.png",
	on_use = minetest.item_eat(4)
})
    minetest.register_craft({
        type  =  "cooking",
        recipe  = "icecream:notcone",
        output = "icecream:cone",
    })
]]--
