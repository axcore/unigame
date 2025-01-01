---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_belen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_belen.init()

    return {
        description = "Belen flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_belen.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:belen. Creates unilib:flower_belen
        part_name = "belen",
        orig_name = "beautiflowers:belen",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Belen Flower"),
        dye = "violet",
    })

end
