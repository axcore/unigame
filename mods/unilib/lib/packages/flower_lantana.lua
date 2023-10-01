---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lantana = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lantana.init()

    return {
        description = "Lantana flower",
    }

end

function unilib.pkg.flower_lantana.exec()

    unilib.register_flower({
        -- From flowers_plus:lantana. Creates unilib:flower_lantana
        part_name = "lantana",
        orig_name = "flowers_plus:lantana",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "farlands",
        description = S("Lantana"),
        fill_ratio = 0.04,
        group_table = {color_purple = 1, flammable = 1},
        sci_name = "Lantana",
    })

end
