---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_fern_spike = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_fern_spike.init()

    return {
        description = "Spike fern as decoration",
        depends = {"biome_default_forest_coniferous", "dirt_ordinary", "fern_spike"},
    }

end

function unilib.pkg.deco_moreplants_fern_spike.post()

    unilib.register_decoration_complete("moreplants_fern_spike", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "fern_spike"
        biomes = "default_forest_coniferous",
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
    })

end
