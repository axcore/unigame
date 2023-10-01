---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_fern_ostrich = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_fern_ostrich.init()

    return {
        description = "Ostrich fern as decoration",
        depends = {"biome_default_forest_coniferous", "dirt_ordinary", "fern_ostrich"},
    }

end

function unilib.pkg.deco_moreplants_fern_ostrich.post()

    unilib.register_decoration_now("moreplants_fern_ostrich", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "fern_ostrich"
        biomes = "default_forest_coniferous",
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
    })

end
