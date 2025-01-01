---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_sylvia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_sylvia.init()

    return {
        description = "Syvlia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_sylvia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:silvia. Creates unilib:flower_sylvia
        part_name = "sylvia",
        orig_name = "beautiflowers:silvia",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Syvlia Flower"),
        dye = "pink",
    })

end
