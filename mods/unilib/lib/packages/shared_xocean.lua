---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_xocean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xocean.on_place(itemstack, placer, pointed_thing, part_name, block_name)

    if block_name == nil then
        block_name = "unilib:coral_block_" .. part_name
    end

    if pointed_thing.type ~= "node" or not placer then
        return itemstack
    end

    local player_name = placer:get_player_name()
    local pos_under = pointed_thing.under
    local pos_above = pointed_thing.above

    if minetest.get_node(pos_under).name ~= block_name or
            minetest.get_node(pos_above).name ~= "unilib:liquid_water_ordinary_source" then
        return itemstack
    end

    if minetest.is_protected(pos_under, player_name) or
            minetest.is_protected(pos_above, player_name) then

        minetest.chat_send_player(player_name, S("Node is protected"))
        minetest.record_protection_violation(pos_under, player_name)
        return itemstack

    end

    minetest.set_node(pos_under, {name = "unilib:coral_rooted_" .. part_name})
    if not (creative and creative.is_enabled_for(player_name)) then
        itemstack:take_item()
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xocean.init()

    return {
        description = "Shared functions for rooted coral (from xocean mod)",
        depends = "liquid_water_ordinary",
    }

end
