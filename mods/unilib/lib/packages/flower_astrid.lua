---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_astrid = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_astrid.init()

    return {
        description = "Astrid flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_astrid.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:astrid. Creates unilib:flower_astrid
        part_name = "astrid",
        orig_name = "beautiflowers:astrid",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Astrid Flower"),
        dye = "blue",
    })

end
