---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- coral_block.lua
--      Base API functions for coral
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- All corals from minetest_game are registered as a single decoration
local coral_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

--[[
local function on_place_rooted_coral(itemstack, placer, pointed_thing)

    -- Adapted from default/nodes.lua

    if pointed_thing.type ~= "node" then
        return itemstack
    end

    local player_name = placer and placer:get_player_name()
    local pos_under = pointed_thing.under
    local pos_above = pointed_thing.above
    local node_under = core.get_node(pos_under)
    local def_under = core.registered_nodes[node_under.name]

    if def_under and
            def_under.on_rightclick and
            not (placer and placer:is_player() and placer:get_player_control().sneak) then

        return def_under.on_rightclick(
            pos_under, node_under, placer, itemstack, pointed_thing
        )

    end

    if node_under.name ~= "unilib:coral_block_skeleton" or
            core.get_node(pos_above).name ~= "unilib:liquid_water_ordinary_source" then
        return itemstack
    end

    if core.is_protected(pos_under, player_name) or core.is_protected(pos_above, player_name) then

--      unilib.utils.log(
--          "action",
--          player_name .. " tried to place " .. itemstack:get_name() ..
--                  " at protected position " .. core.pos_to_string(pos_under)
--      )
        unilib.utils.log_player_action(
            placer, "tried to place", itemstack:get_name(), "at protected position", pos_under
        )

        core.record_protection_violation(pos_under, player_name)
        return itemstack

    end

    node_under.name = itemstack:get_name()
    core.set_node(pos_under, node_under)
    if not unilib.utils.is_creative(player_name) then
        itemstack:take_item()
    end

    return itemstack

end
]]--

---------------------------------------------------------------------------------------------------
-- Base API functions for coral
---------------------------------------------------------------------------------------------------

function unilib.coral._register_block_coral(data_table)

    -- Adapted from minetest_game, "default:coral_brown"
    -- Register block coral nodes (coral in the shape of a block, typically at ground level)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "brown"
    --      orig_name (str): e.g. "default:coral_brown"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Brown Block Coral"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Block Coral")

    local full_name = "unilib:coral_block_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_coral_block_" .. part_name .. ".png"},
        -- N.B. no coral = 1 in most original mods
        groups = {coral = 1, cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:coral_block_skeleton",
    })

    -- Add each coral to a (local) list, as described above
    table.insert(coral_list, full_name)

    return full_name

end

function unilib.coral._register_rooted_coral(data_table)

    -- Adapted from minetest_game, "default:coral_green"
    -- Register rooted coral nodes (coral in the shape of a plant, typically growing on top of a
    --      "unilib:coral_block_skeleton" node, which is at ground level)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "green"
    --      orig_name (str): e.g. "default:coral_green"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Green Rooted Coral"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Rooted Coral")

    local full_name = "unilib:coral_rooted_" .. part_name
    local img = "unilib_coral_rooted_" .. part_name .. ".png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_coral_block_skeleton.png"},
        -- N.B. no coral = 1 in most original mods
        groups = {coral = 1, snappy = 3},
        sounds = unilib.sound.generate_stone({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = img,
        node_dig_prediction = "unilib:coral_block_skeleton",
        node_placement_prediction = "",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
            },
        },
        special_tiles = {
            {name = img, tileable_vertical = true},
        },
        waving = 1,
        wield_image = img,

--      on_place = on_place_rooted_coral,
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {
                    need_under = "unilib:coral_block_skeleton",
                    need_above = "unilib:liquid_water_ordinary_source",
                    displace_flag = true,
                }
            )

        end,

        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            core.set_node(pos, {name = "unilib:coral_block_skeleton"})
        end,
    })

    -- Add each coral to a (local) list, as described above
    table.insert(coral_list, full_name)

    return full_name

end

function unilib.coral._register_mixed_coral_as_decoration(generic_deco_name)

    -- Adapted from minetest_game, default/mapgen.lua
    -- All default corals are registered as a single decoration
    -- Whenever the .register_block_coral() and .register_rooted_coral() functions above are called,
    --      they add the coral's full_name to the local variable coral_list
    -- Then, a single deco package (e.g. "deco_default_coral_mixed") calls this function to create
    --      the generic decoration definition, before its own call to
    --      unilib.register_decoration_complete()

    unilib.register_decoration_generic(generic_deco_name, {
        -- Adapted from default/mapgen.lua
        deco_type = "simple",
        decoration = coral_list,

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            seed = 7013,
            spread = {x = 50, y = 50, z = 50},
        },
        place_offset_y = -1,
        sidelen = 4,
    })

end
