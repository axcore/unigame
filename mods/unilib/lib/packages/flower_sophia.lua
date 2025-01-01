---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_sophia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_sophia.init()

    return {
        description = "Sophia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_sophia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:sofia. Creates unilib:flower_sophia
        part_name = "sophia",
        orig_name = "beautiflowers:sofia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Sophia Flower"),
        dye = "pink",
    })

end
