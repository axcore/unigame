---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_fern_big = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_fern_big.init()

    return {
        description = "Big fern as decoration",
        depends = {"dirt_ordinary", "fern_big"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_rainforest"},
    }

end

function unilib.pkg.deco_moreplants_fern_big.post()

    unilib.register_decoration_now("moreplants_fern_big", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "fern_big"
        biomes = {"default_rainforest", "default_forest_coniferous"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
    })

end

