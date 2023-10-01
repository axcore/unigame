---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_flower_spike_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_flower_spike_blue.init()

    return {
        description = "Blue spikeflower as decoration",
        depends = {"dirt_ordinary", "flower_spike_blue"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_taiga"}
    }

end

function unilib.pkg.deco_moreplants_flower_spike_blue.post()

    unilib.register_decoration_now("moreplants_flower_spike_blue", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "flower_spike_blue"
        biomes = {"default_forest_coniferous", "default_taiga"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
            "unilib:dirt_ordinary_with_turf",
        },
    })

end
