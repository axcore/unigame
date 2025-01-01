---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_michelle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_michelle.init()

    return {
        description = "Michelle flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_michelle.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:michelle. Creates unilib:flower_michelle
        part_name = "michelle",
        orig_name = "beautiflowers:michelle",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Michelle Flower"),
        dye = "white",
    })

end
