---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_asparagus_white_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_asparagus_white_wild.init()

    return {
        description = "Wild white asparagus plant as decoration",
        depends = {"dirt_ordinary", "plant_asparagus_white_wild"},
        at_least_one = {"tree_apple", "tree_aspen", "tree_jungle"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_asparagus_white_wild.post()

    unilib.register_decoration_now("cucina_vegana_plant_asparagus_white_wild", nil, {
        -- From cucina_vegana, asparagus.lua
        -- Completes decoration in package "plant_asparagus_white_wild"
        num_spawn_by = 2,
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        spawn_by = {
            "unilib:tree_apple_trunk",
            "unilib:tree_aspen_trunk",
            "unilib:tree_jungle_trunk",
        },
        y_max = 120,
        y_min = 10,
    })

end
