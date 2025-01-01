---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_bulrush_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_bulrush_small.init()

    return {
        description = "Small bulrush as decoration",
        depends = {"plant_bulrush_small", "sand_ordinary"},
        at_least_one = {"biome_default_grassland", "biome_default_forest_deciduous"},
    }

end

function unilib.pkg.deco_moreplants_plant_bulrush_small.post()

    unilib.register_decoration_complete("moreplants_plant_bulrush_small", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_bulrush_small"
        biomes = {"default_grassland_ocean", "default_forest_deciduous_ocean"},
        place_on = "unilib:sand_ordinary",
    })

end
