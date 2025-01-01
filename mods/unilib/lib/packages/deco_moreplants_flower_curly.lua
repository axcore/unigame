---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_flower_curly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_flower_curly.init()

    return {
        description = "Curly flower as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "flower_curly"},
    }

end

function unilib.pkg.deco_moreplants_flower_curly.post()

    unilib.register_decoration_complete("moreplants_flower_curly", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "flower_curly"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
