---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lara = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lara.init()

    return {
        description = "Lara flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_lara.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:lara. Creates unilib:flower_lara
        part_name = "lara",
        orig_name = "beautiflowers:lara",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Lara Flower"),
        dye = "red",
    })

end
