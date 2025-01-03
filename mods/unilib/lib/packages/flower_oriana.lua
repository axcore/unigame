---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_oriana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_oriana.init()

    return {
        description = "Oriana flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_oriana.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:oriana. Creates unilib:flower_oriana
        part_name = "oriana",
        orig_name = "beautiflowers:oriana",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Oriana Flower"),
        dye = "magenta",
    })

end
