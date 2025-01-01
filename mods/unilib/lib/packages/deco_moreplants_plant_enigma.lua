---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_enigma = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_enigma.init()

    return {
        description = "Enigma plant as decoration",
        depends = {"dirt_ordinary", "plant_enigma"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_moreplants_plant_enigma.post()

    unilib.register_decoration_complete("moreplants_plant_enigma", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_grass_enigma"
        biomes = {"default_forest_deciduous_shore", "default_rainforest_swamp"},
        place_on = "unilib:dirt_ordinary",
    })

end
