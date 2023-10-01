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
minetest.register_craftitem("bonemeal:fertiliser", {
	description = S("Fertiliser"),
	inventory_image = "bonemeal_fertiliser.png",

	on_use = function(itemstack, user, pointed_thing)

		-- did we point at a node?
		if pointed_thing.type ~= "node" then
			return
		end

		-- is area protected?
		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			return
		end

		-- call global on_use function with strength of 3
		if bonemeal:on_use(pointed_thing.under, 3) then

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
	output = "bonemeal:fertiliser 2",
	recipe = {{"bonemeal:bonemeal", "bonemeal:mulch"}}
})
]]--
