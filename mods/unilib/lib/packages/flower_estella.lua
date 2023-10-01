---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_estella = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_estella.init()

    return {
        description = "Estella flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_estella.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:estela. Creates unilib:flower_estella
        part_name = "estella",
        orig_name = "beautiflowers:estela",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Estella Flower"),
        dye = "orange",
    })

end
