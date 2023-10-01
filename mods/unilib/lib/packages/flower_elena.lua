---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_elena = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_elena.init()

    return {
        description = "Elena flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_elena.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:elena. Creates unilib:flower_elena
        part_name = "elena",
        orig_name = "beautiflowers:elena",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Elena Flower"),
        dye = "orange",
    })

end
