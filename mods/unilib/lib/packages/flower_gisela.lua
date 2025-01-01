---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_gisela = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_gisela.init()

    return {
        description = "Gisela flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_gisela.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:gisela. Creates unilib:flower_gisela
        part_name = "gisela",
        orig_name = "beautiflowers:gisela",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 6 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Gisela Flower"),
        dye = "pink",
    })

end
