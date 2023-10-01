---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_noemi = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_noemi.init()

    return {
        description = "Noemi flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_noemi.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:noemi. Creates unilib:flower_noemi
        part_name = "noemi",
        orig_name = "beautiflowers:noemi",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Noemi Flower"),
        dye = "violet",
    })

end
