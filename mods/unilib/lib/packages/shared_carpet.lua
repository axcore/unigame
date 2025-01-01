---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carpet
-- Code:    LGPL-2.1+
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_carpet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.carpet.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_carpet.register_carpet(data_table)

    -- Adapted from carpet/api.lua
    -- Creates a carpet node in a specified colour
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "black"
    --      orig_name (str): e.g. "carpet:wool_black"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Black carpet"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Carpet")

    local full_name = "unilib:carpet_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_wool_" .. part_name .. ".png"},
        groups = {carpet = 1, choppy = 2, flammable = 3, oddly_breakable_by_hand = 3, snappy = 2},
        -- N.B. In original code, "node" sounds
        sounds = unilib.global.sound_table.wool,

        drawtype = "nodebox",
        -- N.B. Not in original code, but does appear in "wools" mod code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        output = full_name .. " 32",
        recipe = {
            {"group:wool", "group:wool", "group:wool"},
            {"group:wool", "unilib:wool_" .. part_name, "group:wool"},
        },
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_carpet.init()

    return {
        description = "Shared functions for carpets (from carpet mod)",
    }

end
