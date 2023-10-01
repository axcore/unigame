---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_tulip_orange_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_tulip_orange_large.init()

    return {
        description = "Large orange tulip",
    }

end

function unilib.pkg.flower_tulip_orange_large.exec()

    unilib.register_flower({
        -- Texture from cropocalypse, original code. Creates unilib:flower_tulip_orange_large
        part_name = "tulip_orange_large",
        orig_name = nil,
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, 8 / 16, 3 / 16},

        replace_mode = mode,
        deco_part_name = "cropocalypse",
        description = S("Large Orange Tulip"),
        group_table = {color_orange = 1, flammable = 1},
        sci_name = "Tulipa",
        seed = 19823,
    })

end
