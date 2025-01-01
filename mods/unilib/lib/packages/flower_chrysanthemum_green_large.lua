---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_chrysanthemum_green_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_chrysanthemum_green_large.init()

    return {
        description = "Large green chrysanthemum",
    }

end

function unilib.pkg.flower_chrysanthemum_green_large.exec()

    unilib.register_flower({
        -- Texture from cropocalypse, original code. Creates unilib:flower_chrysanthemum_green_large
        part_name = "chrysanthemum_green_large",
        orig_name = nil,
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, 6 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "cropocalypse",
        description = S("Large Green Chrysanthemum"),
        group_table = {color_green = 1, colour_green = 1, flammable = 1},
        sci_name = "Chrysanthemum",
        seed = 800082,
    })

end
