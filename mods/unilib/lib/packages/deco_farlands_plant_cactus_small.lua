---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_cactus_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_cactus_small.init()

    return {
        description = "Small cactus as decoration",
        depends = {"plant_cactus_small"},
        at_least_one = {
            {"biome_farlands_desert", "biome_farlands_desert_sandstone"},
            {"sand_desert", "sand_ordinary"},
        },
    }

end

function unilib.pkg.deco_farlands_plant_cactus_small.post()

    for _, part_name in pairs({"small", "small_flowering"}) do

        unilib.register_decoration_now("farlands_plant_cactus_" .. part_name, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "plant_cactus_small"
            biomes = {"farlands_desert", "farlands_desert_sandstone"},
            place_on = {"unilib:sand_desert", "unilib:sand_ordinary"},
            y_max = unilib.y_max,
            y_min = 2,
        })

    end

end
