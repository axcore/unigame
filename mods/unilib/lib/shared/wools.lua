---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- wools.lua
--      Set up shared functions for wools
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register wools
---------------------------------------------------------------------------------------------------

function unilib.register_wool(data_table)

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

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_wool_" .. part_name .. ".png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 3, snappy = 2, wool = 1},
        sounds = unilib.sound_table.wool,

        is_ground_content = false,
    })
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {"group:dye,color_" .. part_name, "group:wool"},
    })

    return full_name

end
