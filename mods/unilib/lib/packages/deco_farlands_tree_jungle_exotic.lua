---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_jungle_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_jungle_exotic.init()

    return {
        description = "Exotic jungle tree as decoration",
        depends = {"biome_farlands_rainforest", "tree_jungle_exotic"},
        optional = "vine_jungle",
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_forest"},
    }

end

function unilib.pkg.deco_farlands_tree_jungle_exotic.post()

    if unilib.global.pkg_executed_table["vine_jungle"] ~= nil then

        unilib.register_decoration_complete("farlands_tree_jungle_exotic_1", nil, {
            -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/jungletree.mts
            -- Completes decoration in package "tree_jungle_exotic"
            biomes = "farlands_rainforest",
            place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf_forest"},
            y_max = unilib.constant.y_max,
            y_min = -1,
        })

    end

    unilib.register_decoration_complete("farlands_tree_jungle_exotic_2", nil, {
        -- From farlands, mapgen/mapgen.lua, ../default/schematics/jungle_tree.mts
        -- Completes decoration in package "tree_jungle_exotic"
        biomes = "farlands_rainforest_swamp",
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf_forest"},
        y_max = unilib.constant.y_max,
        y_min = -1,
    })

    unilib.register_decoration_complete("farlands_tree_jungle_exotic_3", nil, {
        -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/junglepalm.mts
        -- Completes decoration in package "tree_jungle_exotic"
        biomes = "farlands_rainforest",
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf_forest"},
        y_max = unilib.constant.y_max,
        y_min = -1,
    })

end
