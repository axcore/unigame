---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_daisy_oxeye = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_daisy_oxeye.init()

    return {
        description = "Oxeye daisy flower",
    }

end

function unilib.pkg.flower_daisy_oxeye.exec()

    unilib.register_flower({
        -- From flowers_plus:oxeye_daisy. Creates unilib:flower_daisy_oxeye
        part_name = "daisy_oxeye",
        orig_name = "flowers_plus:oxeye_daisy",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "farlands",
        description = S("Oxeye Daisy"),
        fill_ratio = 0.02,
        group_table = {color_white = 1, flammable = 1},
        sci_name = "Leucanthemum vulgare",
    })

end
