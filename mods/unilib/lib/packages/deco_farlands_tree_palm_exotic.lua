---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_palm_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_palm_exotic.init()

    return {
        description = "Exotic palm tree as decoration",
        depends = {"tree_palm_exotic"},
        at_least_one = {
            "biome_farlands_rainforest",
            "dirt_ordinary",
            "dirt_ordinary_with_turf_forest",
            "sand_ordinary",
        },
    }

end

function unilib.pkg.deco_farlands_tree_palm_exotic.post()

    if unilib.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_decoration_now("farlands_tree_palm_exotic_1", nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "tree_palm_exotic"
            -- (no biomes)
            place_on = "unilib:sand_ordinary",
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

    if unilib.pkg_executed_table["biome_farlands_rainforest"] ~= nil and (
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.pkg_executed_table["dirt_ordinary_with_turf_forest"] ~= nil
    ) then

        unilib.register_decoration_now("farlands_tree_palm_exotic_2", nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "tree_palm_exotic"
            biomes = "farlands_rainforest",
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_ordinary_with_turf_forest",
            },
            y_max = unilib.y_max,
            y_min = 1,
        })

    end

end
