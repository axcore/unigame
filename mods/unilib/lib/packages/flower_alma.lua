---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_alma = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_alma.init()

    return {
        description = "Alma flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_alma.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:alma. Creates unilib:flower_alma
        part_name = "alma",
        orig_name = "beautiflowers:alma",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Alma Flower"),
        dye = "yellow",
    })

end
