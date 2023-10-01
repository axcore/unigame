---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("earthbuild:fire_sticks", {
	description = "Fire Sticks",
	inventory_image = "earthbuild_fire_sticks.png",
	sound = {breaks = "default_tool_breaks"},

	on_use = function(itemstack, user, pointed_thing)
		local sound_pos = pointed_thing.above or user:get_pos()
		minetest.sound_play(
			"fire_sticks",
			{pos = sound_pos, gain = 0.5, max_hear_distance = 8}
		)
		local player_name = user:get_player_name()
		if pointed_thing.type == "node" then
			local node_under = minetest.get_node(pointed_thing.under).name
			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.chat_send_player(player_name, "This area is protected")
				return
			end
			if nodedef.on_ignite then
				nodedef.on_ignite(pointed_thing.under, user)
			elseif minetest.get_item_group(node_under, "flammable") >= 1
					and minetest.get_node(pointed_thing.above).name == "air" then
				minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
			end
		end
		if not (creative and creative.is_enabled_for
				and creative.is_enabled_for(player_name)) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear(2000)
			-- Tool break sound
			if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
				minetest.sound_play(wdef.sound.breaks, {pos = sound_pos, gain = 0.5})
			end
			return itemstack
		end
	end
})
minetest.register_craft({
	output = 'earthbuild:fire_sticks',
	recipe = {
		{'group:stick'},
		{'group:stick'},
		{'group:leaves'},
	}
})
minetest.register_craft({
	output = 'earthbuild:fire_sticks',
	recipe = {
		{'group:stick'},
		{'group:stick'},
		{'group:grass'},
	}
})
minetest.register_craft({
	output = 'earthbuild:fire_sticks',
	recipe = {
		{'group:stick'},
		{'group:stick'},
		{'group:dry_grass'},
	}
})
minetest.register_craft({
	output = 'earthbuild:fire_sticks',
	recipe = {
		{'group:stick'},
		{'group:stick'},
		{'default:dry_shrub'},
	}
})
]]--
