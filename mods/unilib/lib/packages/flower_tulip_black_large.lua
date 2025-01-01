---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_tulip_black_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_tulip_black_large.init()

    return {
        description = "Large black tulip",
    }

end

function unilib.pkg.flower_tulip_black_large.exec()

    unilib.register_flower({
        -- Texture from cropocalypse, original code. Creates unilib:flower_tulip_black_large
        part_name = "tulip_black_large",
        orig_name = nil,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 8 / 16, 3 / 16},

        replace_mode = mode,
        deco_part_name = "cropocalypse",
        description = S("Large Black Tulip"),
        group_table = {color_black = 1, colour_black = 1, flammable = 1},
        sci_name = "Tulipa",
        seed = 900082,
    })

end
