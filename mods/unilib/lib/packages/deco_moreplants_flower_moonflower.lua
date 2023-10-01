---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_flower_moonflower = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_flower_moonflower.init()

    return {
        description = "Moonflower as decoration",
        depends = {"biome_default_tundra", "flower_moonflower", "stone_ordinary"},
    }

end

function unilib.pkg.deco_moreplants_flower_moonflower.post()

    unilib.register_decoration_now("moreplants_flower_moonflower", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "flower_moonflower"
        biomes = "default_tundra",
        place_on = "unilib:stone_ordinary",
    })

end
