---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wool
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_wool = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.wool.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_wool.register_wool(data_table)

    -- Adapted from wool/init.lua
    -- Creates a wool node in a specified colour
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "black"
    --      orig_name (str): e.g. "wool:black"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Black wool"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wool")

    local full_name = "unilib:wool_" .. part_name
    local colour_group = "colour_" .. part_name
    local alt_colour_group = "color_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_wool_" .. part_name .. ".png"},
        groups = {
            choppy = 2, [colour_group] = 1, [alt_colour_group] = 1, flammable = 3,
            oddly_breakable_by_hand = 3, snappy = 2, wool = 1,
        },
        sounds = unilib.global.sound_table.wool,

        is_ground_content = false,
    })
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {"group:dye," .. colour_group, "group:wool"},
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_wool.init()

    return {
        description = "Shared functions for wool (from minetest_game/wool)",
    }

end
