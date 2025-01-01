---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_grass_dead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_grass_dead.init()

    return {
        description = "Dead grass as decoration",
        depends = {"biome_farlands_savanna", "dirt_ordinary", "grass_dead"},
        optional = {"biome_farlands_desert", "sand_desert"},
    }

end

function unilib.pkg.deco_farlands_grass_dead.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("farlands_grass_dead_" .. i, nil, {
            -- From farlands, mapgen/mapgen.lua
            -- Completes decoration in package "grass_dead"
            biomes = "farlands_savanna",
            place_on = "unilib:dirt_ordinary_with_turf_dry",
        })

    end

    if unilib.global.pkg_executed_table["biome_farlands_desert"] ~= nil and
            unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        for i = 3, 5 do

            unilib.register_decoration_complete("farlands_grass_dead_" .. i, nil, {
                -- From farlands, mapgen/mapgen.lua
                -- Completes decoration in package "grass_dead"
                biomes = {"farlands_desert", "farlands_savanna"},
                place_on = {"unilib:dirt_ordinary_with_turf_dry", "unilib:sand_desert"},
            })

        end

    end

end

