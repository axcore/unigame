---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_fiona = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_fiona.init()

    return {
        description = "Fiona flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_fiona.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:fiona. Creates unilib:flower_fiona
        part_name = "fiona",
        orig_name = "beautiflowers:fiona",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Fiona Flower"),
        dye = "orange",
    })

end
