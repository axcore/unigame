---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_paula = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_paula.init()

    return {
        description = "Paula flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_paula.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:paula. Creates unilib:flower_paula
        part_name = "paula",
        orig_name = "beautiflowers:paula",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Paula Flower"),
        dye = "violet",
    })

end
