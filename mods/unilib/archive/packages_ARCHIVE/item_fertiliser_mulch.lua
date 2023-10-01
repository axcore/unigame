---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- mulch (strength 1)
minetest.register_craftitem("bonemeal:mulch", {
	description = S("Mulch"),
	inventory_image = "bonemeal_mulch.png",

	on_use = function(itemstack, user, pointed_thing)

		-- did we point at a node?
		if pointed_thing.type ~= "node" then
			return
		end

		-- is area protected?
		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			return
		end

		-- call global on_use function with strength of 1
		if bonemeal:on_use(pointed_thing.under, 1) then

			-- take item if not in creative
			if not bonemeal.is_creative(user:get_player_name()) then
				itemstack:take_item()
			end
		end

		return itemstack
	end
})
minetest.register_craft({
--	type = "shapeless",
	output = "bonemeal:mulch 4",
	recipe = {
		{"group:tree", "group:leaves", "group:leaves"},
		{"group:leaves", "group:leaves", "group:leaves"},
		{"group:leaves", "group:leaves", "group:leaves"}
	}
})
minetest.register_craft({
--	type = "shapeless",
	output = "bonemeal:mulch",
	recipe = {
		{"group:seed", "group:seed", "group:seed"},
		{"group:seed", "group:seed", "group:seed"},
		{"group:seed", "group:seed", "group:seed"}
	}
})
]]--
