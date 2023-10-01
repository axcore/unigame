---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_dirt_permafrost_with_moss = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_dirt_permafrost_with_moss.init()

    return {
        description = "Permafrost dirt with moss as decoration",
        depends = {"biome_default_tundra", "dirt_permafrost"},
    }

end

function unilib.pkg.deco_default_dirt_permafrost_with_moss.post()

    unilib.register_decoration_now("default_dirt_permafrost_with_moss", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "dirt_permafrost"
        biomes = "default_tundra",
        place_on = "unilib:dirt_permafrost_with_stonelet",
        y_max = 50,
        y_min = 2,
    })

end
