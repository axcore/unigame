---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_seaweed
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_pl_seaweed_plant_seaweed_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pl_seaweed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_pl_seaweed_plant_seaweed_normal.init()

    return {
        description = "Normal seaweed as decoration",
--      depends = "plant_seaweed_normal",
--      at_least_one = {"dirt_ordinary", "liquid_water_ordinary", "sand_ordinary"},
        depends = {
            "dirt_ordinary",
            "liquid_water_ordinary",
            "plant_seaweed_normal",
            "sand_ordinary",
        },
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_default_rainforest",
            "biome_default_savanna",
        },
    }

end

function unilib.pkg.deco_pl_seaweed_plant_seaweed_normal.post()

    -- N.B. In the original code, the first two decorations seem to be broken, as
    --      minetest.register_decoration() doesn't seem to work when .place_on is a liquid
    -- Here, they are replaced with original decorations adapted from minetest_game waterlilies
    -- Note that the spawn rate is not nearly as high in this new code, so seaweed is no longer
    --      greatly outnumbered by waterlilies (from the "flower_waterlily_ordinary_alt" package)

    --[[
    unilib.register_decoration_now("convert_plant_seaweed_normal_above_dirt", nil, {
        -- From pl_seaweed/init.lua
        -- Completes decoration in package "plant_seaweed_normal"
        place_on = "unilib:liquid_water_ordinary_source",
        spawn_by = "unilib:dirt_ordinary_with_turf",
        y_max = 40,
        y_min = 1,
    })
    ]]--
    unilib.register_decoration_now("convert_plant_seaweed_normal_above_dirt", nil, {
        -- From pl_seaweed/init.lua
        -- Completes decoration in package "plant_seaweed_normal"
        biomes = {
            "default_forest_deciduous_shore",
            "default_rainforest_swamp",
            "default_savanna_shore",
        },
        place_on = "unilib:dirt_ordinary",
        y_max = 0,
        y_min = 0,
    })
    --[[
    unilib.register_decoration_now("convert_plant_seaweed_normal_above_sand", nil, {
        -- From pl_seaweed/init.lua
        -- Completes decoration in package "plant_seaweed_normal"
        place_on = "unilib:liquid_water_ordinary_source",
        spawn_by = "unilib:sand_ordinary",
        y_max = 40,
        y_min = 1,
    })
    ]]--
    unilib.register_decoration_now("convert_plant_seaweed_normal_above_sand", nil, {
        -- From pl_seaweed/init.lua
        -- Completes decoration in package "plant_seaweed_normal"
        biomes = {
            "default_forest_deciduous_shore",
            "default_rainforest_swamp",
            "default_savanna_shore",
        },
        place_on = "unilib:sand_ordinary",
        y_max = 0,
        y_min = 0,
    })
    unilib.register_decoration_now("convert_plant_seaweed_normal_on_sand", nil, {
        -- From pl_seaweed/init.lua
        -- Completes decoration in package "plant_seaweed_normal"
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 40,
        y_min = 1,
    })

end
