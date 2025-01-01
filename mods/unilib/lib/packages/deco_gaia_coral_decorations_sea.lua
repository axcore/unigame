---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_coral_decorations_sea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_coral_decorations_sea.init()

    return {
        description = "\"decorations_sea\" coral for the \"gaia\" remix",
        notes = "Based on various decorations_sea decoration packages, combined here into one" ..
                " package with \"gaia\" biomes",
        depends = "biome_gaia",
        optional = {
            "coral_block_blue",
            "coral_block_crimson",
            "coral_block_green",
            "coral_block_pink",
            "coral_block_red",
            "coral_block_tangerine",
            "coral_block_violet",
            "coral_block_yellow",
            "coral_seawhip_blue",
            "coral_seawhip_crimson",
            "coral_seawhip_green",
            "coral_seawhip_red",
            "coral_seawhip_yellow",
            "liquid_water_ordinary",
        },
    }

end

function unilib.pkg.deco_gaia_coral_decorations_sea.post()

    -- (Corresponds to unilib.pkg.shared_decorations_sea.warm_biome_list)
    local warm_biome_list = {"gaia_hot_semihumid_ocean"}
--  -- (Corresponds to unilib.pkg.shared_decorations_sea.temperate_biome_list)
--  local temperate_biome_list = {"gaia_hot_temperate_ocean"}
--  -- (Corresponds to unilib.pkg.shared_decorations_sea.frozen_biome_list)
--  local frozen_biome_list = {
--      "gaia_hot_semiarid_ocean",
--      "gaia_hot_arid_ocean",
--      "gaia_warm_semiarid_ocean",
--      "gaia_warm_arid_ocean",
--  }

    -- Block coral
    for _, part_name in pairs(
        {"blue", "crimson", "green", "pink", "red", "tangerine", "violet", "yellow"}
    ) do

        for i = 1, 3 do

            unilib.register_decoration_complete(
                -- From decorations_sea/mapgen.lua
                -- Completes decoration in package "coral_block_blue" (etc), including nodes from
                --      the package "coral_seawhip_blue" (etc)
                "decoration_sea_coral_block_" .. part_name .. "_" .. i,
                nil,
                {
                    biomes = warm_biome_list,
                    num_spawn_by = 1,
                    place_on = "group:sand",
                    spawn_by = "unilib:liquid_water_ordinary_source",
                    y_max = -6,
                    y_min = -32,
                }
            )

        end

    end

    -- Seawhip coral
    for _, part_name in pairs({"blue", "crimson", "green", "red", "yellow"}) do

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "coral_seawhip_blue" (etc)
            "decoration_sea_coral_seawhip_" .. part_name .. "_1",
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

end
