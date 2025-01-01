---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_delia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_delia.init()

    return {
        description = "Delia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_delia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:delia. Creates unilib:flower_delia
        part_name = "delia",
        orig_name = "beautiflowers:delia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Delia Flower"),
        dye = "orange",
    })

end
