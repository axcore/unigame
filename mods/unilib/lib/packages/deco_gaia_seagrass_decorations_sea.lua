---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_seagrass_decorations_sea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_seagrass_decorations_sea.init()

    return {
        description = "\"decorations_sea\" seagrass for the \"gaia\" remix",
        notes = "Based on various decorations_sea decoration packages, combined here into one" ..
                " package with \"gaia\" biomes",
        depends = "biome_gaia",
        optional = {
            "liquid_water_ordinary",
            "plant_seagrass_paddle",
            "plant_seagrass_ribbon_serrated",
            "plant_seagrass_spoon",
            "plant_seagrass_tape_blue",
            "plant_seagrass_tape_green",
            "plant_seagrass_tape_red",
            "plant_seagrass_zostera",
        },
    }

end

function unilib.pkg.deco_gaia_seagrass_decorations_sea.post()

    -- (Corresponds to unilib.pkg.shared_decorations_sea.warm_biome_list)
    local warm_biome_list = {"gaia_hot_semihumid_ocean"}
    -- (Corresponds to unilib.pkg.shared_decorations_sea.temperate_biome_list)
    local temperate_biome_list = {"gaia_hot_temperate_ocean"}
    -- (Corresponds to unilib.pkg.shared_decorations_sea.frozen_biome_list)
    local frozen_biome_list = {
        "gaia_hot_semiarid_ocean",
        "gaia_hot_arid_ocean",
        "gaia_warm_semiarid_ocean",
        "gaia_warm_arid_ocean",
    }

    -- Normal seagrass
    for _, part_name in pairs({"paddle", "ribbon_serrated", "spoon", "zostera"}) do

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "plant_seagrass_paddle"
            "decoration_sea_plant_seagrass_" .. part_name .. "_1",
            nil,
            {
                biomes = warm_biome_list,
                num_spawn_by = 1,
                place_on = "group:sand",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = -1,
                y_min = -32,
            }
        )

    end

    -- Tape seagrass

    -- { y_max, y_min }
    local height_list = { {7, 4}, {4, 3}, {2, 2} }

    for _, data_list in pairs({
        {"blue", frozen_biome_list, frozen_biome_list},
        {"green", temperate_biome_list, temperate_biome_list},
        {"red", warm_biome_list, warm_biome_list},
    }) do

        for i, mini_list in ipairs(height_list) do

            unilib.register_decoration_complete(
                -- From decorations_sea/mapgen.lua
                -- Completes decoration in package "plant_seagrass_tape_blue", etc
                "decoration_sea_plant_seagrass_tape_" .. data_list[1] .. "_tall_" .. i,
                nil,
                {
                    biomes = data_list[2],
                    num_spawn_by = 1,
                    place_on = "group:sand",
                    spawn_by = "unilib:liquid_water_ordinary_source",
                    y_max = mini_list[1] * -1,
                    y_min = -32,
                }
            )

            if data_list[1] == "green" then

                unilib.register_decoration_complete(
                    -- From decorations_sea/mapgen.lua
                    -- Completes decoration in package "plant_seagrass_tape_green"
                    "decoration_sea_plant_seagrass_tape_" .. data_list[1] .. "_tall_" .. i + 3,
                    nil,
                    {
                        biomes = warm_biome_list,
                        num_spawn_by = 1,
                        place_on = "group:sand",
                        spawn_by = "unilib:liquid_water_ordinary_source",
                        y_max = mini_list[1] * -1,
                        y_min = -32,
                    }
                )

            end

        end

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "plant_seagrass_tape_blue", etc
            "decoration_sea_plant_seagrass_tape_" .. data_list[1] .. "_1",
            nil,
            {
                biomes = data_list[3],
                num_spawn_by = 1,
                place_on = "group:sand",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = -1,
                y_min = -32,
            }
        )

        if data_list[1] == "green" then

            unilib.register_decoration_complete(
                -- From decorations_sea/mapgen.lua
                -- Completes decoration in package "plant_seagrass_tape_green"
                "decoration_sea_plant_seagrass_tape_" .. data_list[1] .. "_2",
                nil,
                {
                    biomes = unilib.pkg.shared_decorations_sea.warm_biome_list,
                    num_spawn_by = 1,
                    place_on = "group:sand",
                    spawn_by = "unilib:liquid_water_ordinary_source",
                    y_max = -1,
                    y_min = -32,
                }
            )

        end

    end

end
