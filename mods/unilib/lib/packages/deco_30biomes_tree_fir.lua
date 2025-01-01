---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    30biomes
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_30biomes_tree_fir = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["30biomes"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_30biomes_tree_fir.init()

    return {
        description = "Fir tree as decoration",
        notes = "Original deco package so that 30biomes fir trees can be used with default" ..
                " biomes, alongside pine trees (since no biomes from that mod have been imported)",
        depends = {"dirt_ordinary", "tree_fir"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_taiga"},
    }

end

function unilib.pkg.deco_30biomes_tree_fir.post()

    unilib.register_decoration_complete("30biomes_tree_fir", nil, {
        -- Original to unilib
        biomes = {"default_forest_coniferous", "default_taiga"},
        num_spawn_by = 8,
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        spawn_by = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        y_max = unilib.constant.y_max,
        y_min = 4,
    })

end
