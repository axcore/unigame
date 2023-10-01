---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
lib_ecology:coral_purple
{
    node_placement_prediction = "lib_ecology:coral_purple",
    is_ground_content = false,
    groups = {
        sea = 1,
        snappy = 3,
    },
    drawtype = "plantlike_rooted",
    node_dig_prediction = "lib_ecology:coral_purple",
    paramtype = "light",
    description = "Coral - Purple",
    tiles = {
        [1] = "lib_ecology_coral_skeleton.png",
        [2] = "lib_ecology_coral_skeleton.png",
    },
    special_tiles = {
        [1] = {
            name = "lib_ecology_coral_purple.png",
            tileable_vertical = false,
        },
    },
    sunlight_propagates = true,
    walkable = false,
    inventory_image = "lib_ecology_coral_purple.png",
    sounds = {
        dug = {
            name = "default_hard_footstep",
            gain = 1,
        },
        footstep = {
            name = "default_hard_footstep",
            gain = 0.3,
        },
        place = {
            name = "default_place_node_hard",
            gain = 1,
        },
    },
    buildable_to = false,
    waving = 1,
    legacy_wallmounted = false,
    wield_image = "lib_ecology_coral_purple.png",

    after_destruct = "function: 0x41d1b668",
    on_place = "function: 0x40370ec0",

				new_node_def.on_place = function(itemstack, placer, pointed_thing)
					if pointed_thing.type ~= "node" or not placer then
						return itemstack
					end
		
					local player_name = placer:get_player_name()
					local pos_under = pointed_thing.under
					local pos_above = pointed_thing.above
		
					if minetest.get_node(pos_under).name ~= "lib_ecology:coral_skeleton" or (string.find(minetest.get_node(pos_above).name, "water_") and string.find(minetest.get_node(pos_above).name, "_source")) then
						return itemstack
					end
		
					if minetest.is_protected(pos_under, player_name) or
							minetest.is_protected(pos_above, player_name) then
						minetest.chat_send_player(player_name, "Node is protected")
						minetest.record_protection_violation(pos_under, player_name)
						return itemstack
					end
		
					minetest.set_node(pos_under, {name = "lib_ecology:"..node_name..""})
					if not (creative and creative.is_enabled_for(player_name)) then
						itemstack:take_item()
					end
		
					return itemstack
				end
				new_node_def.after_destruct  = function(pos, oldnode)
					minetest.set_node(pos, {name = "lib_ecology:coral_skeleton"})
				end
}
]]--
