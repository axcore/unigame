---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_sickles = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions (register moss)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_sickles.register_moss(data_table)

    -- Adapted from sickles/items.lua
    -- Creates a coloured moss
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "blue"
    --      orig_name (str): e.g. "sickles:moss_blue"
    --      block_orig_name (str): e.g. "sickles:moss_block_blue"
    --      description (str): e.g. "Blue Moss"
    --      block_description (str): e.g. "Blue Moss Block"
    --      dye (str): e.g. "blue"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      tint (str): e.g. "#6c7eb070"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local block_orig_name = data_table.block_orig_name
    local description = data_table.description
    local block_description = data_table.block_description
    local dye = data_table.dye

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local tint = data_table.tint or nil

    local moss_name = "unilib:moss_" .. part_name
    local block_name = "unilib:moss_" .. part_name .. "_block"
    local overlay_img
    if tint == nil then
        overlay_img = ""
    else
        overlay_img = "^[colorize:" .. tint
    end

    local node_box = {
        type = "wallmounted",
        wall_side = { -0.5, -0.5, -0.5, -0.45, 0.5, 0.5 },
        wall_top = { -0.5, 0.45, -0.5, 0.5, 0.5, 0.5 },
        wall_bottom = { -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 }
    }

    local sound_table = unilib.node_sound_dirt_defaults({
        footstep = "unilib_grass_footstep",
        dug = "unilib_moss_dug",
        place = "unilib_moss_dug",
    })

    -- Moss
    unilib.register_node(moss_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_moss_green.png" .. overlay_img},
        groups = {
            attached_node = 1, flammable = 2, flora = 1, food = 1, food_moss = 1, moss = 1,
            snappy = 3,
        },
        sounds = sound_table,

        buildable_to = true,
        drawtype = "signlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--        floodable = true,
        inventory_image = "unilib_moss_green_inv.png" .. overlay_img,
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = node_box,
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_moss_green_inv.png" .. overlay_img,

        on_use = unilib.cuisine_eat_on_use(moss_name, 1),
    })
    unilib.register_craft({
        output = moss_name .. " 3",
        recipe = {
            {block_name},
        },
    })

    -- Moss block
    unilib.register_node(block_name, block_orig_name, replace_mode, {
        description = block_description,
        tiles = {"unilib_moss_ordinary.png" .. overlay_img},
        groups = {fall_damage_add_percent = -80, flammable = 2, moss_block = 1, snappy = 3},
        sounds = sound_table,

        is_ground_content = false,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        output = block_name .. " 3",
        recipe = {
            {moss_name, moss_name, moss_name},
            {moss_name, moss_name, moss_name},
            {moss_name, moss_name, moss_name},
        }
    })
    unilib.register_stairs(block_name)

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            type = "shapeless",
            output = block_name,
            recipe = {
                "group:moss_block", "unilib:dye_" .. dye,
            },
        })
        unilib.register_craft({
            output = "unilib:dye_" .. dye,
            recipe = {
                {moss_name},
            },
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_sickles.init()

    return {
        description = "Shared functions for mosses (from sickles mod)",
        optional = {"dirt_ordinary", "dye_basic", "misc_hay_ordinary", "tool_pitchfork"},
    }

end

function unilib.pkg.shared_sickles.exec()

    -- Craft recipes
    unilib.register_craft({
        type = "fuel",
        recipe = "group:moss",
        burntime = 2,
    })
    unilib.register_craft({
        type = "fuel",
        recipe = "group:moss_block",
        burntime = 18,
    })

    -- Override the pitchfork mechanic with the sickle mechanic, if required
    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil and
            unilib.pkg_executed_table["misc_hay_ordinary"] ~= nil and
            unilib.pkg_executed_table["tool_pitchfork"] ~= nil and
            unilib.sickles_override_pitchfork_flag then

        unilib.override_item("unilib:dirt_ordinary_with_turf", {
            after_dig_node = function() end
        })

        local group_table = minetest.registered_tools["unilib:tool_pitchfork"].groups
        group_table.sickle = 1
        group_table.sickle_uses = 12
        unilib.override_item("unilib:tool_pitchfork", {
            groups = group_table
        })

        unilib.register_craft({
            output = "unilib:misc_hay_ordinary_pile",
            recipe = {{"group:grass", "group:grass", "group:grass"}}
        })

    end

end
