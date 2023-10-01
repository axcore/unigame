---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_cactus_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_cactus_exotic.init()

    return {
        description = "Exotic cactus as decoration",
        depends = {"biome_farlands_desert", "plant_cactus_exotic", "sand_desert"},
    }

end

function unilib.pkg.deco_farlands_plant_cactus_exotic.post()

    for _, deco_name in pairs({
        -- Cactus decoration placed as a single node; the ABM causes it to grow upwards
        "farlands_plant_cactus_exotic",
        -- N.B. This was commented out in original code, but we need it
        -- Cactus decoration placed as a multi-node plant
        "farlands_plant_cactus_exotic_large",
    }) do

        unilib.register_decoration_now(deco_name, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "plant_cactus_exotic"
            biomes = "farlands_desert",
            place_on = "unilib:sand_desert",
            y_max = unilib.y_max,
            y_min = 5,
        })

    end

end
