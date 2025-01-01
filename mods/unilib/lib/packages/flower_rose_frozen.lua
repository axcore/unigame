---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_rose_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_rose_frozen.init()

    return {
        description = "Frozen rose flower",
    }

end

function unilib.pkg.flower_rose_frozen.exec()

    unilib.register_flower({
        -- From flowers_plus:frozen_rose. Creates unilib:flower_rose_frozen
        part_name = "rose_frozen",
        orig_name = "flowers_plus:frozen_rose",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "farlands",
        description = S("Frozen Rose"),
        fill_ratio = 0.03,
        group_table = {color_blue = 1, colour_blue = 1, flammable = 0},
        sci_name = "Rosa",
    })

end
