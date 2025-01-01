---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_weed_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_weed_normal.init()

    return {
        description = "Normal weed as decoration",
        depends = {"biome_default_forest_coniferous", "dirt_ordinary", "plant_weed_normal"},
    }

end

function unilib.pkg.deco_moreplants_plant_weed_normal.post()

    unilib.register_decoration_complete("moreplants_plant_weed_normal", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_weed_normal"
        biomes = "default_forest_coniferous",
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
    })

end
