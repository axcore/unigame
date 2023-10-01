---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("default:skeleton_key", {
	description = S("Skeleton Key"),
	inventory_image = "default_key_skeleton.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local pos = pointed_thing.under
		local node = minetest.get_node(pos)

		if not node then
			return itemstack
		end

		local node_reg = minetest.registered_nodes[node.name]
		local on_skeleton_key_use = node_reg and node_reg.on_skeleton_key_use
		if not on_skeleton_key_use then
			return itemstack
		end

		-- make a new key secret in case the node callback needs it
		local random = math.random
		local newsecret = string.format(
			"%04x%04x%04x%04x",
			random(2^16) - 1, random(2^16) - 1,
			random(2^16) - 1, random(2^16) - 1)

		local secret, _, _ = on_skeleton_key_use(pos, user, newsecret)

		if secret then
			local inv = minetest.get_inventory({type="player", name=user:get_player_name()})

			-- update original itemstack
			itemstack:take_item()

			-- finish and return the new key
			local new_stack = ItemStack("default:key")
			local meta = new_stack:get_meta()
			meta:set_string("secret", secret)
			meta:set_string("description", S("Key to @1's @2", user:get_player_name(),
				minetest.registered_nodes[node.name].description))

			if itemstack:get_count() == 0 then
				itemstack = new_stack
			else
				if inv:add_item("main", new_stack):get_count() > 0 then
					minetest.add_item(user:get_pos(), new_stack)
				end -- else: added to inventory successfully
			end

			return itemstack
		end
	end
})
minetest.register_craft({
	output = "default:skeleton_key",
	recipe = {
		{"default:gold_ingot"},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "default:skeleton_key",
	cooktime = 5,
})
]]--
