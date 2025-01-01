---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    30biomes
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_30biomes_tree_fir_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["30biomes"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_30biomes_tree_fir_log.init()

    return {
        description = "Fir tree log as decoration",
        notes = "Original deco package so that 30biomes fir trees can be used with default" ..
                " biomes, alongside pine trees (since no biomes from that mod have been imported)",
        depends = {"dirt_ordinary", "mushroom_red", "tree_fir"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_taiga"},
    }

end

function unilib.pkg.deco_30biomes_tree_fir_log.post()

    unilib.register_decoration_complete("30biomes_tree_fir_log", nil, {
        -- From 30biomes/decorations.lua
        biomes = {"default_forest_coniferous", "default_taiga"},
        place_on = {"unilib:dirt_ordinary_with_cover_snow", "unilib:dirt_ordinary_with_turf"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
