---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_diana = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_diana.init()

    return {
        description = "Diana flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_diana.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:diana. Creates unilib:flower_diana
        part_name = "diana",
        orig_name = "beautiflowers:diana",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Diana Flower"),
        dye = "white",
    })

end
