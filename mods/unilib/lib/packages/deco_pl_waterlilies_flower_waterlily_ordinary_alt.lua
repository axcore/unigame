---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/pl_waterlilies
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_pl_waterlilies_flower_waterlily_ordinary_alt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pl_waterlilies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_pl_waterlilies_flower_waterlily_ordinary_alt.init()

    return {
        description = "Ordinary waterliles as decoration",
--      depends = "flower_waterlily_ordinary_alt",
--      at_least_one = {"dirt_ordinary", "liquid_water_ordinary"},
        depends = {"dirt_ordinary", "flower_waterlily_ordinary_alt"},
        at_least_one = {
            "biome_default_forest_deciduous",
            "biome_default_rainforest",
            "biome_default_savanna",
        },
    }

end

function unilib.pkg.deco_pl_waterlilies_flower_waterlily_ordinary_alt.exec()

    -- N.B. In the original code, the decoration seems to be broken, as
    --      minetest.register_decoration() doesn't seem to work when .place_on is a liquid
    -- Here, it is replaced with original decorations adapted from minetest_game waterlilies

    --[[
    unilib.register_decoration_now("convert_flower_waterlily_ordinary", nil, {
        -- From pl_seaweed/init.lua
        -- Completes decoration in package "flower_waterlily_ordinary_alt"
        place_on = "unilib:liquid_water_ordinary_source",
        spawn_by = "unilib:dirt_ordinary_with_turf",
        y_max = 40,
        y_min = 1,
    })
    ]]--
    unilib.register_decoration_now("convert_flower_waterlily_ordinary", nil, {
        -- From pl_waterlilies/init.lua
        -- Completes decoration in package "flower_waterlily_ordinary_alt"
        biomes = {
            "default_forest_deciduous_shore",
            "default_rainforest_swamp",
            "default_savanna_shore",
        },
        place_on = "unilib:dirt_ordinary",
        y_max = 0,
        y_min = 0,
    })

end
