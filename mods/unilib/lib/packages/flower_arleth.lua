---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_arleth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_arleth.init()

    return {
        description = "Arleth flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_arleth.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:arleth. Creates unilib:flower_arleth
        part_name = "arleth",
        orig_name = "beautiflowers:arleth",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Arleth Flower"),
        dye = "violet",
    })

end
