---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_weed_dead = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_weed_dead.init()

    return {
        description = "Dead weed as decoration",
        depends = {"biome_default_taiga", "dirt_ordinary", "plant_weed_dead", "snow_ordinary"},
    }

end

function unilib.pkg.deco_moreplants_plant_weed_dead.post()

    unilib.register_decoration_now("moreplants_plant_weed_dead", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_weed_dead"
        biomes = "default_taiga",
        place_on = {"unilib:dirt_ordinary_with_cover_snow", "unilib:snow_ordinary_block"},
    })

end
