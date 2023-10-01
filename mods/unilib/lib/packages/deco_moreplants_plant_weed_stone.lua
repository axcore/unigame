---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_weed_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_weed_stone.init()

    return {
        description = "Stone weed as decoration",
        depends = {"biome_default_tundra", "plant_weed_stone", "stone_ordinary"},
    }

end

function unilib.pkg.deco_moreplants_plant_weed_stone.post()

    unilib.register_decoration_now("moreplants_plant_weed_stone", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_weed_stone"
        biomes = "default_tundra",
        place_on = "unilib:stone_stone_ordinary",
    })

end
