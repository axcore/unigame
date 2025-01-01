---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_valeria = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_valeria.init()

    return {
        description = "Valeria flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_valeria.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:valeria. Creates unilib:flower_valeria
        part_name = "valeria",
        orig_name = "beautiflowers:valeria",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Valeria Flower"),
        dye = "cyan",
    })

end
