---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_valentina = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_valentina.init()

    return {
        description = "Valentina flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_valentina.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:valentina. Creates unilib:flower_valentina
        part_name = "valentina",
        orig_name = "beautiflowers:valentina",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Valentina Flower"),
        dye = "cyan",
    })

end
