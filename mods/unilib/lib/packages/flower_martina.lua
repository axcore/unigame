---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_martina = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_martina.init()

    return {
        description = "Martina flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_martina.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:martina. Creates unilib:flower_martina
        part_name = "martina",
        orig_name = "beautiflowers:martina",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Martina Flower"),
        dye = "orange",
    })

end
