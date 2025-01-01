---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_mushroom_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_mushroom_pink.init()

    return {
        description = "Pink mushroom as decoration",
        depends = {"biome_default_forest_deciduous", "dirt_ordinary", "mushroom_pink"},
    }

end

function unilib.pkg.deco_moreplants_mushroom_pink.post()

    unilib.register_decoration_complete("moreplants_mushroom_pink", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "mushroom_pink"
        biomes = "default_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
