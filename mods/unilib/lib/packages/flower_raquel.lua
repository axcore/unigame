---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_raquel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_raquel.init()

    return {
        description = "Raquel flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_raquel.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:raquel. Creates unilib:flower_raquel
        part_name = "raquel",
        orig_name = "beautiflowers:raquel",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 0 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Raquel Flower"),
        dye = "pink",
    })

end
