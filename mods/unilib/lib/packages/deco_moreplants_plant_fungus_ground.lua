---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_fungus_ground = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_fungus_ground.init()

    return {
        description = "Ground fungus as decoration",
        depends = {"biome_default_taiga", "dirt_ordinary", "plant_fungus_ground", "snow_ordinary"},
    }

end

function unilib.pkg.deco_moreplants_plant_fungus_ground.post()

    unilib.register_decoration_complete("moreplants_plant_fungus_ground", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_fungus_ground"
        biomes = "default_taiga",
        place_on = {"unilib:dirt_ordinary_with_cover_snow", "unilib:snow_ordinary_block"},
    })

end
