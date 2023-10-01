---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lobelia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lobelia.init()

    return {
        description = "Lobelia flower",
    }

end

function unilib.pkg.flower_lobelia.exec()

    unilib.register_flower({
        -- From flowers_plus:lobelia. Creates unilib:flower_lobelia
        part_name = "lobelia",
        orig_name = "flowers_plus:lobelia",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "farlands",
        description = S("Lobelia"),
        fill_ratio = 0.02,
        group_table = {color_blue = 1, flammable = 1},
        sci_name = "Lobelia",
    })

end
