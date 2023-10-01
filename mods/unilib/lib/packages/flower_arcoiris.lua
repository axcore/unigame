---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_arcoiris = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_arcoiris.init()

    return {
        description = "Arcoiris flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_arcoiris.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:arcoiris. Creates unilib:flower_arcoiris
        part_name = "arcoiris",
        orig_name = "beautiflowers:arcoiris",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Arcoiris Flower"),
        dye = "red",
    })

end
