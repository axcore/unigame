---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_irene = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_irene.init()

    return {
        description = "Irene flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_irene.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:irene. Creates unilib:flower_irene
        part_name = "irene",
        orig_name = "beautiflowers:irene",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Irene Flower"),
        dye = "white",
    })

end
