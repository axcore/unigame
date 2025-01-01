---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_berta = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_berta.init()

    return {
        description = "Berta flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_berta.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:berta. Creates unilib:flower_berta
        part_name = "berta",
        orig_name = "beautiflowers:berta",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Berta Flower"),
        dye = "blue",
    })

end
