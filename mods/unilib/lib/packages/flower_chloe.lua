---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_chloe = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_chloe.init()

    return {
        description = "Chloe flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_chloe.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:cloe. Creates unilib:flower_chloe
        part_name = "chloe",
        orig_name = "beautiflowers:cloe",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Chloe Flower"),
        dye = "white",
    })

end
