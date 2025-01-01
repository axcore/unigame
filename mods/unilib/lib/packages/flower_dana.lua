---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_dana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_dana.init()

    return {
        description = "Dana flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_dana.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:dana. Creates unilib:flower_dana
        part_name = "dana",
        orig_name = "beautiflowers:dana",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Dana Flower"),
        dye = "orange",
    })

end
