---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ferns_tree_fern_giant = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ferns_tree_fern_giant.init()

    return {
        description = "Giant fern tree as decoration",
        at_least_one = {
            "dirt_ordinary",
            "liquid_water_ordinary",
            "liquid_water_river",
            "sand_desert",
            "sand_ordinary",
            "tree_jungle",
        },
    }

end

function unilib.pkg.deco_ferns_tree_fern_giant.post()

    unilib.register_decoration_complete("convert_tree_fern_giant_in_jungle", nil, {
        -- From ferns/gianttreefern.lua
        -- Completes decoration in package "tree_fern_giant"
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:sand_desert",
            "unilib:sand_ordinary",
        },
        spawn_by = "unilib:tree_jungle_trunk",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })
    unilib.register_decoration_complete("convert_tree_fern_giant_on_sand", nil, {
        -- From ferns/gianttreefern.lua
        -- Completes decoration in package "tree_fern_giant"
        place_on = {
            "unilib:sand_ordinary",
        },
        spawn_by = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_water_river_source",
            "unilib:sand_desert",
        },
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
