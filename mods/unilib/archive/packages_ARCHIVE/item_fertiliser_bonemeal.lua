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
-- bonemeal (strength 2)
minetest.register_craftitem("bonemeal:bonemeal", {
	description = S("Bone Meal"),
	inventory_image = "bonemeal_item.png",

	on_use = function(itemstack, user, pointed_thing)

		-- did we point at a node?
		if pointed_thing.type ~= "node" then
			return
		end

		-- is area protected?
		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			return
		end

		-- call global on_use function with strength of 2
		if bonemeal:on_use(pointed_thing.under, 2) then

			-- take item if not in creative
			if not bonemeal.is_creative(user:get_player_name()) then
				itemstack:take_item()
			end
		end

		return itemstack
	end
})
-- bonemeal (from bone)
minetest.register_craft({
--	type = "shapeless",
	output = "bonemeal:bonemeal 2",
	recipe = {{"group:bone"}}
})
-- bonemeal (from player bones)
minetest.register_craft({
--	type = "shapeless",
	output = "bonemeal:bonemeal 4",
	recipe = {{"bones:bones"}}
})
-- bonemeal (from coral skeleton)
minetest.register_craft({
--	type = "shapeless",
	output = "bonemeal:bonemeal 2",
	recipe = {{"default:coral_skeleton"}}
})
]]--
