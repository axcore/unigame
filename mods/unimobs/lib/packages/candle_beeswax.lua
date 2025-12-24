---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.candle_beeswax = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.candle_beeswax.init()

    return {
        description = "Beeswax candle",
        depends = {"item_string_ordinary", "misc_beeswax_normal"},
    }

end

function unilib.pkg.candle_beeswax.exec()

    unilib.register_node("unilib:candle_beeswax", "petz:beeswax_candle", mode, {
        -- From petz:beeswax_candle
        description = S("Beeswax Candle"),
        tiles = {
            {
                name = "unilib_candle_beeswax.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 32,
                    aspect_h = 32,
                    length = 1.0,
                },
            },
        },
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_candle_beeswax_inv.png",
        light_source = 11,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.15, -0.5, -0.15, 0.15, 0, 0.15}
        },
        sunlight_propagates = true,
        visual_scale = 0.5,
        walkable = false,
        wield_image = "unilib_candle_beeswax_inv.png",
    })
    unilib.register_craft({
        -- From petz:beeswax_candle
        output = "unilib:candle_beeswax 2",
        type = "shaped",
        recipe = {
            {"", "unilib:item_string_ordinary", ""},
            {"", "unilib:misc_beeswax_normal", ""},
            {"", "unilib:misc_beeswax_normal", ""},
        },
    })

end
