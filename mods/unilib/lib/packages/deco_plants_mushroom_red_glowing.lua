---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_mushroom_red_glowing = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_mushroom_red_glowing.init()

    return {
        description = "Red glowing mushroom as decoration",
        depends = {"liquid_lava_ordinary", "mushroom_red_glowing", "stone_ordinary"},
    }

end

function unilib.pkg.deco_plants_mushroom_red_glowing.post()

    unilib.register_decoration_complete("plants_mushroom_red_glowing", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "mushroom_red_glowing"
        place_on = "unilib:stone_ordinary",
        spawn_by = "unilib:liquid_lava_ordinary_source",
        y_max = -130,
        y_min = -1000,
    })

end
