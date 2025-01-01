---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_flower_canna = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_flower_canna.init()

    return {
        description = "Canna flower as decoration",
        depends = {"biome_default_rainforest", "dirt_ordinary", "flower_canna"},
    }

end

function unilib.pkg.deco_moreplants_flower_canna.post()

    unilib.register_decoration_complete("moreplants_flower_canna", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "flower_canna"
        biomes = "default_rainforest",
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
    })

end
