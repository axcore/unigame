---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_petunia_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_petunia_pink.init()

    return {
        description = "Pink petunia flower",
    }

end

function unilib.pkg.flower_petunia_pink.exec()

    unilib.register_flower({
        -- From flowers_plus:petunia_pink. Creates unilib:flower_petunia_pink
        part_name = "petunia_pink",
        orig_name = "flowers_plus:petunia_pink",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "farlands",
        description = S("Pink Petunia"),
        fill_ratio = 0.02,
        group_table = {color_pink = 1, flammable = 1},
        sci_name = "Petunia",
    })

end
