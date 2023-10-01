---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_plant_shrub_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_plant_shrub_dry.init()

    return {
        description = "Dry shrub as decoration",
        depends = "plant_shrub_dry",
        at_least_one = {
            {"biome_farlands_desert", "biome_farlands_desert_sandstone"},
            {"sand_desert", "sand_ordinary", "sand_silver"},
        },
    }

end

function unilib.pkg.deco_farlands_plant_shrub_dry.post()

    unilib.register_decoration_now("default_plant_shrub_dry", "farlands_plant_shrub_dry", {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "plant_shrub_dry"
        biomes = {"farlands_desert", "farlands_desert_sandstone"},
        place_on = {"unilib:sand_desert", "unilib:sand_ordinary", "unilib:sand_silver"},
        y_max = unilib.y_max,
        y_min = 2,
    })

end
