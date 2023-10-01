---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_plants_plant_aloe_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_plants_plant_aloe_wild.init()

    return {
        description = "Wild aloe as decoration",
        depends = {"plant_aloe_wild", "sand_desert"},
        at_least_one = {"dirt_ordinary", "liquid_water_ordinary", "plant_cactus_ordinary"},
    }

end

function unilib.pkg.deco_plants_plant_aloe_wild.post()

    unilib.register_decoration_now("plants_plant_aloe_wild", nil, {
        -- Original to unilib, replacing the calls to the habitat mod in the original code
        -- Completes decoration in package "plant_aloe_wild"
        place_on = "unilib:sand_desert",
        spawn_by = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:liquid_water_ordinary_source",
            "unilib:plant_cactus_ordinary",
        },
        y_max = 40,
        y_min = 5,
    })

end
