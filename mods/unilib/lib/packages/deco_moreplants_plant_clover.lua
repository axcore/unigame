---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_clover = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_clover.init()

    return {
        description = "Clover as decoration",
        depends = {"dirt_ordinary", "plant_clover"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_moreplants_plant_clover.post()

    unilib.register_decoration_now("moreplants_plant_clover", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_clover"
        biomes = {"default_forest_deciduous", "default_grassland"},
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
