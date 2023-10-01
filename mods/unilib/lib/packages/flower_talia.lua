---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_talia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_talia.init()

    return {
        description = "Talia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_talia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:talia. Creates unilib:flower_talia
        part_name = "talia",
        orig_name = "beautiflowers:talia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Talia Flower"),
        dye = "pink",
    })

end
