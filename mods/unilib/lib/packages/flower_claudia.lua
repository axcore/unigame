---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_claudia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_claudia.init()

    return {
        description = "Claudia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_claudia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:claudia. Creates unilib:flower_claudia
        part_name = "claudia",
        orig_name = "beautiflowers:claudia",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Claudia Flower"),
        dye = "blue",
    })

end
