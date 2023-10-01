---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_pansy_purple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_pansy_purple.init()

    return {
        description = "Purple pansy flower",
    }

end

function unilib.pkg.flower_pansy_purple.exec()

    unilib.register_flower({
        -- From flowers_plus:pansy_purple. Creates unilib:flower_pansy_purple
        part_name = "pansy_purple",
        orig_name = "flowers_plus:pansy_purple",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "farlands",
        description = S("Purple Pansy"),
        fill_ratio = 0.02,
        group_table = {color_violet = 1, flammable = 1},
        sci_name = "Viola × wittrockiana",
    })

end
