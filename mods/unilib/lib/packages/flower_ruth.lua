---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_ruth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_ruth.init()

    return {
        description = "Ruth flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_ruth.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:ruth. Creates unilib:flower_ruth
        part_name = "ruth",
        orig_name = "beautiflowers:ruth",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Ruth Flower"),
        dye = "pink",
    })

end
