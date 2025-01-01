---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_ethereal_candle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ethereal_candle.register_candle(data_table)

    -- Adapted from ethereal-ng/extra.lua
    -- Creates a candle node in a specified colour
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "black"
    --      orig_name (str): e.g. "ethereal:candle_black", "ethereal_candle" (for the white candle)
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Black Candle"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Candle")

    local full_name = "unilib:candle_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {
            {
                name = "unilib_candle_" .. part_name .. ".png",
                animation = {
                    type="vertical_frames",
                    aspect_w = 32,
                    aspect_h = 32,
                    length = 1.0
                },
            },
        },
        groups = {attached_node = 1, candle = 1, dig_immediate = 3},
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_candle_" .. part_name .. "_static.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 11,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = { -0.15, -0.5, -0.15, 0.15, 0, 0.15 }
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_candle_" .. part_name .. "_static.png",
    })
    unilib.register_craft({
        output = "unilib:candle_" .. part_name,
        recipe = {
            {"group:candle", "unilib:dye_" .. part_name},
        },
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ethereal_candle.init()

    return {
        description = "Shared functions for candles (from ethereal-ng)",
    }

end
