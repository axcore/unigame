---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_fabiola = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_fabiola.init()

    return {
        description = "Fabiola flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_fabiola.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:fabiola. Creates unilib:flower_fabiola
        part_name = "fabiola",
        orig_name = "beautiflowers:fabiola",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Fabiola Flower"),
        dye = "orange",
    })

end
