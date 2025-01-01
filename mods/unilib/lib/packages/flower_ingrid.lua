---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_ingrid = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_ingrid.init()

    return {
        description = "Ingrid flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_ingrid.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:ingrid. Creates unilib:flower_ingrid
        part_name = "ingrid",
        orig_name = "beautiflowers:ingrid",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Ingrid Flower"),
        dye = "white",
    })

end
