---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_minerva = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_minerva.init()

    return {
        description = "Minerva flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_minerva.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:minerva. Creates unilib:flower_minerva
        part_name = "minerva",
        orig_name = "beautiflowers:minerva",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Minerva Flower"),
        dye = "violet",
    })

end
