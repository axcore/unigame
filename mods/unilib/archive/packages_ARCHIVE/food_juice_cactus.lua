---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:cactus_juice", {
	description = S("Cactus Juice"),
	inventory_image = "farming_cactus_juice.png",
	groups = {vessel = 1, drink = 1},
	on_use = function(itemstack, user, pointed_thing)
		if user then
			if math.random(5) == 1 then
				return minetest.do_item_eat(-1, "vessels:drinking_glass",
						itemstack, user, pointed_thing)
			else
				return minetest.do_item_eat(2, "vessels:drinking_glass",
						itemstack, user, pointed_thing)
			end
		end
	end
})
minetest.register_craft({
	output = "farming:cactus_juice",
	recipe = {
		{"default:cactus"},
		{"farming:juicer"},
		{"vessels:drinking_glass"}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})
]]--
