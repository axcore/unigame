---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_bulrush_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_bulrush_mature.init()

    return {
        description = "Mature bulrush as decoration",
        depends = {"plant_bulrush_mature", "sand_ordinary"},
        at_least_one = {"biome_default_grassland", "biome_default_forest_deciduous"},
    }

end

function unilib.pkg.deco_moreplants_plant_bulrush_mature.post()

    unilib.register_decoration_now("moreplants_plant_bulrush_mature", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_bulrush_mature"
        biomes = {"default_grassland_ocean", "default_forest_deciduous_ocean"},
        place_on = "unilib:sand_ordinary",
    })

end
