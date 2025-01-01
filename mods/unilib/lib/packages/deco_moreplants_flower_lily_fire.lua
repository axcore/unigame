---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moreplants_flower_lily_fire = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moreplants_flower_lily_fire.init()

    return {
        description = "Fire lily as decoration",
        depends = {"biome_default_desert", "flower_lily_fire", "sand_desert"},
    }

end

function unilib.pkg.deco_moreplants_flower_lily_fire.post()

    unilib.register_decoration_complete("moreplants_flower_lily_fire", nil, {
        -- From moreplants/init.lua
        -- Completes decoration in package "flower_lily_fire"
        biomes = "default_desert",
        place_on = "unilib:sand_desert",
    })

end
