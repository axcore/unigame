---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_sara = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_sara.init()

    return {
        description = "Sara flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_sara.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:sara. Creates unilib:flower_sara
        part_name = "sara",
        orig_name = "beautiflowers:sara",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Sara Flower"),
        dye = "pink",
    })

end
