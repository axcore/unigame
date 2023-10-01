---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_gloria = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_gloria.init()

    return {
        description = "Gloria flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_gloria.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:gloria. Creates unilib:flower_gloria
        part_name = "gloria",
        orig_name = "beautiflowers:gloria",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Gloria Flower"),
        dye = "white",
    })

end
