---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_christina = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_christina.init()

    return {
        description = "Christina flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_christina.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:cristina. Creates unilib:flower_christina
        part_name = "christina",
        orig_name = "beautiflowers:cristina",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Christina Flower"),
        dye = "pink",
    })

end
