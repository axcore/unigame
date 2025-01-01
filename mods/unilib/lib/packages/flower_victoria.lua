---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_victoria = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_victoria.init()

    return {
        description = "Victoria flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_victoria.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:victoria. Creates unilib:flower_victoria
        part_name = "victoria",
        orig_name = "beautiflowers:victoria",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Victoria Flower"),
        dye = "cyan",
    })

end
