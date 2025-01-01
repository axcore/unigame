---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_hadassa = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_hadassa.init()

    return {
        description = "Hadassa flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_hadassa.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:hadassa. Creates unilib:flower_hadassa
        part_name = "hadassa",
        orig_name = "beautiflowers:hadassa",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Hadassa Flower"),
        dye = "white",
    })

end
