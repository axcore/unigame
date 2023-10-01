---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_melania = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_melania.init()

    return {
        description = "Melania flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_melania.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:melania. Creates unilib:flower_melania
        part_name = "melania",
        orig_name = "beautiflowers:melania",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Melania Flower"),
        dye = "orange",
    })

end
