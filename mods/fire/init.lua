-- fire/init.lua

-- Global namespace for functions
fire = {}

-- Load support for MT game translation.
local S = minetest.get_translator("fire")

-- @@@ Temporarily provide tools, because techage wants to override them

minetest.register_tool("fire:flint_and_steel", {
	description = S("Flint and Steel"),
	inventory_image = "fire_flint_steel.png",
	sound = {breaks = "default_tool_breaks"},

	on_use = function(itemstack, user, pointed_thing)
		local sound_pos = pointed_thing.above or user:get_pos()
		minetest.sound_play("fire_flint_and_steel",
			{pos = sound_pos, gain = 0.2, max_hear_distance = 8}, true)
		local player_name = user:get_player_name()
		if pointed_thing.type == "node" then
			local node_under = minetest.get_node(pointed_thing.under).name
			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.record_protection_violation(pointed_thing.under, player_name)
				return
			end
			if nodedef.on_ignite then
				nodedef.on_ignite(pointed_thing.under, user)
			elseif minetest.get_item_group(node_under, "flammable") >= 1
					and minetest.get_node(pointed_thing.above).name == "air" then
				if minetest.is_protected(pointed_thing.above, player_name) then
					minetest.record_protection_violation(pointed_thing.above, player_name)
					return
				end

				minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
			end
		end
		if not minetest.is_creative_enabled(player_name) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear_by_uses(66)

			-- Tool break sound
			if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
				minetest.sound_play(wdef.sound.breaks,
					{pos = sound_pos, gain = 0.5}, true)
			end
			return itemstack
		end
	end
})

-- @@@ Once the definitions have been overriden, we can hide them

minetest.after(0.1, function()

    for _, full_name in pairs({"fire:flint_and_steel"}) do
        
        local def_table = minetest.registered_tools[full_name]
        if def_table ~= nil then

            local group_table = def_table.groups
            group_table.not_in_creative_inventory = 1

            minetest.override_item(full_name, {
                groups = group_table,
            })
            
        end

    end

end)

-- Deprecated function kept temporarily to avoid crashes if mod fire nodes call it
function fire.update_sounds_around() end

