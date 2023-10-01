---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
--
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:bowl", {
	description = S("Wooden Bowl"),
	inventory_image = "farming_bowl.png",
	groups = {food_bowl = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:bowl 4",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "farming:bowl",
	burntime = 10
})

if minetest.get_modpath("default") and thirsty.config.register_bowl then
    -- our own simple wooden bowl
    minetest.register_craftitem('thirsty:wooden_bowl', {
        description = "Wooden bowl",
        inventory_image = "thirsty_bowl_16.png",
        liquids_pointable = true,
        on_use = thirsty.on_use(nil),
    })

    minetest.register_craft({
        output = "thirsty:wooden_bowl",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"", "group:wood", ""}
        }
    })
end
]]--
