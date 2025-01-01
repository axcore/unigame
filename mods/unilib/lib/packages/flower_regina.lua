---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_regina = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_regina.init()

    return {
        description = "Regina flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_regina.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:regina. Creates unilib:flower_regina
        part_name = "regina",
        orig_name = "beautiflowers:regina",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Regina Flower"),
        dye = "violet",
    })

end
