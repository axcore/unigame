---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_sonya = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_sonya.init()

    return {
        description = "Sonya flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_sonya.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:sonia. Creates unilib:flower_sonya
        part_name = "sonya",
        orig_name = "beautiflowers:sonia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Sonya Flower"),
        dye = "pink",
    })

end
