---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_fern_christmas = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_fern_christmas.init()

    return {
        description = "Christmas fern as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "fern_christmas"},
    }

end

function unilib.pkg.deco_moreplants_fern_christmas.post()

    unilib.register_decoration_complete("moreplants_fern_christmas", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "fern_christmas"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
