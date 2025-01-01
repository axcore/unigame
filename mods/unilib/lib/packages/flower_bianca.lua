---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_bianca = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_bianca.init()

    return {
        description = "Bianca flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_bianca.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:blanca. Creates unilib:flower_bianca
        part_name = "bianca",
        orig_name = "beautiflowers:blanca",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Bianca Flower"),
        dye = "blue",
    })

end
