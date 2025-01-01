---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_xocean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions - callbacks
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

    if core.get_node(pos_under).name ~= block_name or
            core.get_node(pos_above).name ~= "unilib:liquid_water_ordinary_source" then
        return itemstack
    end

    if core.is_protected(pos_under, player_name) or
            core.is_protected(pos_above, player_name) then

        core.chat_send_player(player_name, S("Node is protected"))
        core.record_protection_violation(pos_under, player_name)
        return itemstack

    end

    core.set_node(pos_under, {name = "unilib:coral_rooted_" .. part_name})
    if not (creative and creative.is_enabled_for(player_name)) then
        itemstack:take_item()
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Shared functions - decorations
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xocean.create_generic_rare_block(part_name, octaves)

    unilib.register_decoration_generic("xocean_coral_block_" .. part_name .. "_1", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_" .. part_name .. "_1.mts",

        flags = "force_placement",
        noise_params = {
            octaves = octaves,
            offset = 0.0001,
            persist = 0.7,
            scale = 0.0001,
            seed = 87112,
            spread = {x = 100000, y = 100000, z = 100000},
        },
        -- N.B. Replaced apparently useless values of .param2/.param2_max with .rotation = "random"
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        rotation = "random",
        sidelen = 2,
    })

end

function unilib.pkg.shared_xocean.create_generic_common_block(part_name, octaves)

    unilib.register_decoration_generic("xocean_coral_block_" .. part_name .. "_2", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_" .. part_name .. "_2.mts",

        flags = "force_placement",
        noise_params = {
            octaves = octaves,
            offset = 0.0001,
            persist = 0.7,
            scale = 0.001,
            seed = 87112,
            spread = {x = 100000, y = 100000, z = 100000},
        },
        -- N.B. Replaced apparently useless values of .param2/.param2_max with .rotation = "random"
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        rotation = "random",
        sidelen = 2,
    })

end

function unilib.pkg.shared_xocean.create_generic_very_rare_block(part_name, octaves)

    unilib.register_decoration_generic("xocean_coral_block_" .. part_name .. "_3", {
        -- From xocean/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_" .. part_name .. "_3.mts",

        flags = "force_placement",
        noise_params = {
            octaves = octaves,
            offset = 0.0001,
            persist = 0.7,
            scale = 0.000001,
            seed = 87112,
            spread = {x = 100000, y = 100000, z = 100000},
        },
        -- N.B. Replaced apparently useless values of .param2/.param2_max with .rotation = "random"
--      param2 = 48,
--      param2_max = 96,
        place_offset_y = -1,
        rotation = "random",
        sidelen = 1,
    })

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
