---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_viola_purple_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_viola_purple_large.init()

    return {
        description = "Large purple viola",
    }

end

function unilib.pkg.flower_viola_purple_large.exec()

    unilib.register_flower({
        -- Texture from cropocalypse, original code. Creates unilib:flower_viola_purple_large
        part_name = "viola_purple_large",
        orig_name = nil,
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, 3 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "cropocalypse",
        description = S("Large Purple Viola"),
        group_table = {color_violet = 1, flammable = 1},
        sci_name = "Viola",
        seed = 1134,
    })

end
