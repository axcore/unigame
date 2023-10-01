---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("better_farming:adzuki_bun", {
	description = minetest.colorize("DarkRed","Adzuki Bun. (Seed)"),
	on_use = minetest.item_eat(1),
	inventory_image = "better_farming_adzuki_bun.png",
})
minetest.register_craft({
	output = "better_farming:adzuki_bun",
	recipe = {
		{"better_farming:gingerbread", "better_farming:adzuki", ""},
	}
})
]]--
