---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_olga = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_olga.init()

    return {
        description = "Olga flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_olga.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:olga. Creates unilib:flower_olga
        part_name = "olga",
        orig_name = "beautiflowers:olga",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Olga Flower"),
        dye = "violet",
    })

end
