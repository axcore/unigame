---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_torch
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- coal powder
minetest.register_craftitem("real_torch:coal_powder", {
	description = "Coal Powder",
	inventory_image = "real_torch_coal_powder.png",

	-- punching unlit torch with coal powder relights
	on_use = function(itemstack, user, pointed_thing)

		if not pointed_thing or pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local nod = minetest.get_node(pos)
		local rep = false

		if nod.name == "real_torch:torch" then
			nod.name = "default:torch"
			rep = true

		elseif nod.name == "real_torch:torch_wall" then
			nod.name = "default:torch_wall"
			rep = true

		elseif nod.name == "real_torch:torch_ceiling" then
			nod.name = "default:torch_ceiling"
			rep = true
		end

		if rep then
			minetest.set_node(pos, {name = nod.name, param2 = nod.param2})

			if not is_creative(user:get_player_name()) then
				itemstack:take_item()
			end
		end

		return itemstack
	end
})
minetest.register_craft({
	output = "real_torch:coal_powder 12",
	recipe = {{"default:coal_lump", "default:coal_lump"}}
})
minetest.register_craft({
	output = "default:torch",
	recipe = {{"real_torch:torch", "real_torch:coal_powder"}}
})
]]--
