---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_misc_decorations_sea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_misc_decorations_sea.init()

    return {
        description = "\"decorations_sea\" seashells/starfish for the \"gaia\" remix",
        notes = "Based on various decorations_sea decoration packages, combined here into one" ..
                " package with \"gaia\" biomes",
        depends = "biome_gaia",
        optional = {
            "liquid_water_ordinary",
            "misc_seashell_auger",
            "misc_seashell_clam",
            "misc_seashell_spiral",
            "misc_starfish_blue",
            "misc_starfish_red",
        },
    }

end

function unilib.pkg.deco_gaia_misc_decorations_sea.post()

    -- (Corresponds to unilib.pkg.shared_decorations_sea.warm_biome_list)
    local warm_biome_list = {"gaia_hot_semihumid_ocean"}
    -- (Corresponds to unilib.pkg.shared_decorations_sea.temperate_biome_list)
    local temperate_biome_list = {"gaia_hot_temperate_ocean"}
--  -- (Corresponds to unilib.pkg.shared_decorations_sea.frozen_biome_list)
--  local frozen_biome_list = {
--      "gaia_hot_semiarid_ocean",
--      "gaia_hot_arid_ocean",
--      "gaia_warm_semiarid_ocean",
--      "gaia_warm_arid_ocean",
--  }

    -- Seashells
    for _, part_name in pairs({"auger", "clam", "spiral"}) do

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "misc_seashell_auger", etc
            "decoration_sea_misc_seashell_" .. part_name .. "_1",
            nil,
            {
                biomes = warm_biome_list,
                num_spawn_by = 1,
                place_on = "group:sand",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = -32,
            }
        )

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "misc_seashell_auger", etc
            "decoration_sea_misc_seashell_" .. part_name .. "_2",
            nil,
            {
                biomes = temperate_biome_list,
                num_spawn_by = 1,
                place_on = "group:sand",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = -32,
            }
        )

    end

    -- Starfish
    for _, part_name in pairs({"blue", "red"}) do

        unilib.register_decoration_complete(
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "misc_starfish_blue", etc
            "decoration_sea_misc_starfish_" .. part_name .. "_1",
            nil,
            {
                biomes = warm_biome_list,
                num_spawn_by = 1,
                place_on = "group:sand",
                spawn_by = "unilib:liquid_water_ordinary_source",
                y_max = 1,
                y_min = -32,
            }
        )

    end

end
