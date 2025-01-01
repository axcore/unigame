---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_alicia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_alicia.init()

    return {
        description = "Alicia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_alicia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:alicia. Creates unilib:flower_alicia
        part_name = "alicia",
        orig_name = "beautiflowers:alicia",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Alicia Flower"),
        dye = "yellow",
    })

end
