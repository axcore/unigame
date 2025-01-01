---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_daphne = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_daphne.init()

    return {
        description = "Daphne flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_daphne.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:dafne. Creates unilib:flower_daphne
        part_name = "daphne",
        orig_name = "beautiflowers:dafne",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Daphne Flower"),
        dye = "orange",
    })

end
