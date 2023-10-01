---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_zaida = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_zaida.init()

    return {
        description = "Zaida flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_zaida.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:zaida. Creates unilib:flower_zaida
        part_name = "zaida",
        orig_name = "beautiflowers:zaida",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Zaida Flower"),
        dye = "cyan",
    })

end
