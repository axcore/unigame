---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_carla = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_carla.init()

    return {
        description = "Carla flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_carla.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:carla. Creates unilib:flower_carla
        part_name = "carla",
        orig_name = "beautiflowers:carla",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Carla Flower"),
        dye = "white",
    })

end
