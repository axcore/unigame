---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_plant_cactus_tiny = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_plant_cactus_tiny.init()

    return {
        description = "Tiny cactus as decoration",
        depends = {"biome_default_desert", "plant_cactus_tiny", "sand_desert"},
    }

end

function unilib.pkg.deco_moreplants_plant_cactus_tiny.post()

    unilib.register_decoration_complete("moreplants_plant_cactus_tiny", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "plant_cactus_tiny"
        biomes = "default_desert",
        place_on = "unilib:sand_desert",
    })

end
