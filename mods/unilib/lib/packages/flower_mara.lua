---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_mara = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_mara.init()

    return {
        description = "Mara flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_mara.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:mara. Creates unilib:flower_mara
        part_name = "mara",
        orig_name = "beautiflowers:mara",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, 2 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Mara Flower"),
        dye = "red",
    })

end
