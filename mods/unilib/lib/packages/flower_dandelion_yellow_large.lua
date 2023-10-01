---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_dandelion_yellow_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_dandelion_yellow_large.init()

    return {
        description = "Large yellow dandelion",
    }

end

function unilib.pkg.flower_dandelion_yellow_large.exec()

    unilib.register_flower({
        -- Texture from cropocalypse, original code. Creates unilib:flower_dandelion_yellow_large
        part_name = "dandelion_yellow_large",
        orig_name = nil,
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, 8 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "cropocalypse",
        description = S("Large Yellow Dandelion"),
        group_table = {color_yellow = 1, flammable = 1},
        sci_name = "Taraxacum",
        seed = 1223000,
    })

end
