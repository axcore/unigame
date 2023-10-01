---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_xena = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_xena.init()

    return {
        description = "Xena flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_xena.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:xena. Creates unilib:flower_xena
        part_name = "xena",
        orig_name = "beautiflowers:xena",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Xena Flower"),
        dye = "violet",
    })

end
