---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_erica = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_erica.init()

    return {
        description = "Erica flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_erica.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:erica. Creates unilib:flower_erica
        part_name = "erica",
        orig_name = "beautiflowers:erica",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Erica Flower"),
        dye = "orange",
    })

end
