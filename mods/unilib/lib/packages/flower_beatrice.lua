---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_beatrice = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_beatrice.init()

    return {
        description = "Beatrice flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_beatrice.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:beatriz. Creates unilib:flower_beatrice
        part_name = "beatrice",
        orig_name = "beautiflowers:beatriz",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Beatrice Flower"),
        dye = "blue",
    })

end
