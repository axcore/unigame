---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_badlands_plant_cactus_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.badlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_badlands_plant_cactus_ordinary.init()

    return {
        description = "Ordinary cactus as decoration",
        depends = {"biome_badlands", "plant_cactus_ordinary", "sand_barren"},
    }

end

function unilib.pkg.deco_badlands_plant_cactus_ordinary.exec()

    unilib.register_decoration_generic("badlands_plant_cactus_ordinary_2", {
        -- From badlands/init.lua
        deco_type = "simple",
        decoration = "unilib:plant_cactus_ordinary",

        height = 3,
        height_max = 4,
        noise_params = {
            octaves = 3,
            offset = -0.012,
            persist = 0.6,
            scale = 0.024,
            seed = 230,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end

function unilib.pkg.deco_badlands_plant_cactus_ordinary.post()

    unilib.register_decoration_complete(
        -- From badlands/init.lua
        -- Completes decoration in package "plant_cactus_ordinary"
        "default_plant_cactus_ordinary",
        "badlands_plant_cactus_ordinary",
        {
            biomes = "badlands_plains",
            place_on = "unilib:sand_barren",
            y_max = unilib.constant.y_max,
            y_min = 4,
        }
    )

    unilib.register_decoration_complete(
        -- From badlands/init.lua
        -- Completes decoration in package "plant_cactus_ordinary"
        "default_plant_cactus_ordinary_large",
        "badlands_plant_cactus_ordinary_large",
        {
            biomes = "badlands_plains",
            place_on = "unilib:sand_barren",
            y_max = unilib.constant.y_max,
            y_min = 4,
        }
    )

    unilib.register_decoration_complete("badlands_plant_cactus_ordinary_2", nil, {
        -- From badlands/init.lua
        -- Completes decoration in this package
        place_on = "unilib:sand_barren",
        y_max = 30,
        y_min = 1,
    })

end
