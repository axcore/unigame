---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_aotearoa_tree_kowhai = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_aotearoa_tree_kowhai.init()

    return {
        description = "Kowhai tree as decoration",
        depends = "tree_kowhai",
        at_least_one = {
            {"biome_aotearoa_coastal", "biome_aotearoa_lowland", "biome_aotearoa_scrubland"},
            {
                "dirt_antipodean",
                "dirt_mud_antipodean",
                "dirt_ordinary",
                "gravel_ordinary",
                "gravel_ordinary_with_algae",
                "liquid_water_river",
                "sand_river",
            },
        },
    }

end

function unilib.pkg.deco_aotearoa_tree_kowhai.post()

    for i = 1, 2 do

        unilib.register_decoration_now("aotearoa_tree_kowhai_rare_" .. i, nil, {
            -- From aotearoa/spawn_trees.lua
            -- Completes decoration in package "tree_kowhai"
            biomes = {
                "aotearoa_coastal_scrub",
                "aotearoa_lowland_beech_forest",
                "aotearoa_lowland_hinau_forest",
                "aotearoa_lowland_kauri_forest",
                "aotearoa_lowland_maire_forest",
                "aotearoa_lowland_tawa_forest",
                "aotearoa_scrubland_broadleaf",
                "aotearoa_scrubland_geothermal",
            },
            num_spawn_by = 2,
            place_on = {
                "unilib:dirt_antipodean_dark_with_litter_beech",
                "unilib:dirt_antipodean_dark_with_litter_wet",
                "unilib:dirt_ordinary_with_litter_dry",
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:dirt_ordinary_with_turf",
            },
            spawn_by = {
                "unilib:dirt_mud_antipodean_dry",
                "unilib:gravel_ordinary",
                "unilib:gravel_ordinary_with_algae",
                "unilib:liquid_water_river_flowing",
                "unilib:liquid_water_river_source",
                "unilib:sand_river",
            },
            y_max = 80,
            y_min = 6,
        })

    end

end
