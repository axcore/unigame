---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("carts:cart", {
	description = S("Cart") .. "\n" .. S("(Sneak+Click to pick up)"),
	inventory_image = minetest.inventorycube("carts_cart_top.png", "carts_cart_front.png", "carts_cart_side.png"),
	wield_image = "carts_cart_front.png",
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local udef = minetest.registered_nodes[node.name]
		if udef and udef.on_rightclick and
				not (placer and placer:is_player() and
				placer:get_player_control().sneak) then
			return udef.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		if not pointed_thing.type == "node" then
			return
		end
		if carts:is_rail(pointed_thing.under) then
			minetest.add_entity(pointed_thing.under, "carts:cart")
		elseif carts:is_rail(pointed_thing.above) then
			minetest.add_entity(pointed_thing.above, "carts:cart")
		else
			return
		end

		minetest.sound_play({name = "default_place_node_metal", gain = 0.5},
			{pos = pointed_thing.above}, true)

		if not minetest.is_creative_enabled(placer:get_player_name()) then
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = "carts:cart",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	},
})
]]--
