---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_plant_potato_ancient_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_plant_potato_ancient_wild.init()

    return {
        description = "Wild ancient potato as decoration",
        depends = {"dirt_ordinary", "plant_potato_ancient_wild"},
        at_least_one = {"grass_jungle", "tree_jungle"},
    }

end

function unilib.pkg.deco_plants_plant_potato_ancient_wild.post()

    unilib.register_decoration_complete("plants_plant_potato_ancient_wild", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "plant_potato_ancient_wild"
        -- N.B. Swapped original dirt type for rainforest litter, which is where jungle trees are
        --      found
        place_on = "unilib:dirt_ordinary_with_litter_rainforest",
        spawn_by = {"unilib:grass_jungle", "unilib:tree_jungle_trunk"},
        y_max = 90,
        y_min = 20,
    })

end
