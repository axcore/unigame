---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_vanessa = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_vanessa.init()

    return {
        description = "Vanessa flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_vanessa.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:vanesa. Creates unilib:flower_vanessa
        part_name = "vanessa",
        orig_name = "beautiflowers:vanesa",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Vanessa Flower"),
        dye = "violet",
    })

end
