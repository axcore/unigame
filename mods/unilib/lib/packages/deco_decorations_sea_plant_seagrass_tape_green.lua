---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_decorations_sea_plant_seagrass_tape_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_decorations_sea_plant_seagrass_tape_green.init()

    return {
        description = "Green tape seagrass as decoration",
        depends = {"liquid_water_ordinary", "plant_seagrass_tape_green", "sand_ordinary"},
    }

end

function unilib.pkg.deco_decorations_sea_plant_seagrass_tape_green.post()

    -- { y_max, y_min }
    local height_list = { {7, 4}, {4, 3}, {2, 2} }

    for i, mini_list in ipairs(height_list) do

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "plant_seagrass_tape_green"
            "decoration_sea_plant_seagrass_tape_green_tall_" .. i,
            nil,
            {
                biomes = unilib.pkg.shared_decorations_sea.temperate_biome_list,
                num_spawn_by = 1,
                place_on = "unilib:sand_ordinary",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = mini_list[1] * -1,
                y_min = -32,
            }
        )

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "plant_seagrass_tape_green"
            "decoration_sea_plant_seagrass_tape_green_tall_" .. i + 3,
            nil,
            {
                biomes = unilib.pkg.shared_decorations_sea.warm_biome_list,
                num_spawn_by = 1,
                place_on = "unilib:sand_ordinary",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = mini_list[1] * -1,
                y_min = -32,
            }
        )

    end

    unilib.register_decoration_complete("decoration_sea_plant_seagrass_tape_green_1", nil, {
        -- From decorations_sea/mapgen.lua
        -- Completes decoration in package "plant_seagrass_tape_green"
        biomes = unilib.pkg.shared_decorations_sea.temperate_biome_list,
        num_spawn_by = 1,
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = -1,
        y_min = -32,
    })

    unilib.register_decoration_complete("decoration_sea_plant_seagrass_tape_green_2", nil, {
        -- From decorations_sea/mapgen.lua
        -- Completes decoration in package "plant_seagrass_tape_green"
        biomes = unilib.pkg.shared_decorations_sea.warm_biome_list,
        num_spawn_by = 1,
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = -1,
        y_min = -32,
    })

end
