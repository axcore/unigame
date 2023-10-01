---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_clara = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_clara.init()

    return {
        description = "Clara flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_clara.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:clara. Creates unilib:flower_clara
        part_name = "clara",
        orig_name = "beautiflowers:clara",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Clara Flower"),
        dye = "blue",
    })

end
