---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_pine_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_pine_exotic.init()

    return {
        description = "Exotic pine tree as decoration",
        depends = {"biome_farlands_forest_coniferous", "tree_pine_exotic"},
        optional = {
            "biome_farlands_taiga".
            "dirt_coarse",
            "dirt_ordinary",
            "dirt_ordinary_with_litter_leafy",
            "mushroom_red",
        },
    }

end

function unilib.pkg.deco_farlands_tree_pine_exotic.post()

    if unilib.pkg_executed_table["biome_farlands_taiga"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("farlands_tree_pine_exotic_1", nil, {
            -- From farlands, mapgen/mapgen.lua, ../default/schematics/pine_tree.mts
            -- Completes decoration in package "tree_pine_exotic"
            biomes = {"farlands_forest_coniferous", "farlands_taiga"},
            place_on = {
                "unilib:dirt_ordinary_with_cover_snow",
                "unilib:dirt_ordinary_with_turf",
            },
            y_max = unilib.y_max,
            y_min = 2,
        })

    end

    if unilib.pkg_executed_table["dirt_ordinary_with_litter_leafy"] ~= nil then

        unilib.register_decoration_now("farlands_tree_pine_exotic_2", nil, {
            -- From farlands, mapgen/mapgen.lua, ../default/schematics/pine_tree.mts
            -- Completes decoration in package "tree_pine_exotic"
            biomes = "farlands_forest_coniferous_tall",
            place_on = "unilib:dirt_ordinary_with_litter_leafy",
            y_max = unilib.y_max,
            y_min = 2,
        })

        if unilib.pkg_executed_table["dirt_coarse"] ~= nil then

            unilib.register_decoration_now("farlands_tree_pine_exotic_3", nil, {
                -- From farlands, mapgen/mapgen.lua, ../mapgen/schematics/pine.mts
                -- Completes decoration in package "tree_pine_exotic"
                biomes = "farlands_forest_coniferous_tall",
                place_on = {"unilib:dirt_coarse", "unilib:dirt_ordinary_with_litter_leafy"},
                y_max = unilib.y_max,
                y_min = -50,
            })

        end

        if unilib.pkg_executed_table["biome_farlands_taiga"] ~= nil and
                unilib.pkg_executed_table["dirt_ordinary"] ~= nil and
                unilib.pkg_executed_table["mushroom_red"] ~= nil

            unilib.register_decoration_now("farlands_tree_pine_exotic_log", nil, {
                -- From farlands, mapgen/mapgen.lua (schematic in code)
                -- Completes decoration in package "tree_pine_exotic"
                biomes = {
                    "farlands_forest_coniferous",
                    "farlands_forest_coniferous_tall",
                    "farlands_taiga",
                },
                place_on = {
                    "unilib:dirt_ordinary_with_litter_leafy",
                    "unilib:dirt_ordinary_with_cover_snow",
                    "unilib:dirt_ordinary_with_turf",
                },
                y_max = unilib.y_max,
                y_min = 1,
            })

        end

    end

end
