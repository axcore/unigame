---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_grass_long = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_grass_long.init()

    return {
        description = "Long grass as decoration",
        depends = {"dirt_ordinary", "grass_long", "sand_ordinary"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_grassland",
        },
    }

end

function unilib.pkg.deco_moreplants_grass_long.post()

    unilib.register_decoration_now("moreplants_grass_long", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "grass_long"
        biomes = {
            "default_forest_coniferous_beach",
            "default_forest_deciduous_shore",
            "default_grassland",
            "default_grassland_beach",
        },
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:sand_ordinary"},
    })

end
