---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_plant_cactus_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_plant_cactus_ordinary.init()

    return {
        description = "Ordinary cactus as decoration",
        depends = {"biome_default_desert", "plant_cactus_ordinary", "sand_desert"},
    }

end

function unilib.pkg.deco_default_plant_cactus_ordinary.post()

    for _, deco_name in pairs({
        -- Cactus decoration placed as a single node; the ABM causes it to grow upwards
        "default_plant_cactus_ordinary",
        -- Cactus decoration placed as a multi-node plant
        "default_plant_cactus_ordinary_large",
    }) do

        unilib.register_decoration_now(deco_name, nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "plant_cactus_ordinary"
            biomes = "default_desert",
            place_on = "unilib:sand_desert",
            y_max = unilib.y_max,
            y_min = 4,
        })

    end

end
