---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_flower_lungwort = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_flower_lungwort.init()

    return {
        description = "Lungwort as decoration",
        depends = {"biome_default_grassland", "dirt_ordinary", "flower_lungwort"},
    }

end

function unilib.pkg.deco_moreplants_flower_lungwort.post()

    unilib.register_decoration_now("moreplants_flower_lungwort", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "flower_lungwort"
        -- N.B. Biomes in original code do not exist
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
    })

end
