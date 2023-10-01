---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_yvette = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_yvette.init()

    return {
        description = "Yvette flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_yvette.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:ivette. Creates unilib:flower_yvette
        part_name = "yvette",
        orig_name = "beautiflowers:ivette",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Yvette Flower"),
        dye = "white",
    })

end
