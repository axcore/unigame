---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_iris_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_iris_white.init()

    return {
        description = "White iris flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_iris_white.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:iris. Creates unilib:flower_iris_white
        part_name = "iris_white",
        orig_name = "beautiflowers:iris",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("White Iris Flower"),
        dye = "white",
        sci_name = "Iris",
    })

end
