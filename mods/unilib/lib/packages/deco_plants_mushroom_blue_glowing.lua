---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_mushroom_blue_glowing = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_mushroom_blue_glowing.init()

    return {
        description = "Blue glowing mushroom as decoration",
        depends = {"mushroom_blue_glowing", "stone_ordinary", "stone_ordinary_with_coal"},
    }

end

function unilib.pkg.deco_plants_mushroom_blue_glowing.post()

    unilib.register_decoration_complete("plants_mushroom_blue_glowing", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "mushroom_blue_glowing"
        place_on = "unilib:stone_ordinary",
        spawn_by = "unilib:stone_ordinary_with_coal",
        y_max = 20,
        y_min = -5,
    })

end
