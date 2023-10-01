---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ferns_tree_fern = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ferns_tree_fern.init()

    return {
        description = "Fern tree as decoration",
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

function unilib.pkg.deco_ferns_tree_fern.post()

    unilib.register_decoration_now("convert_tree_fern_in_jungle", nil, {
        -- From ferns/treefern.lua
        -- Completes decoration in package "tree_fern"
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
            "unilib:sand_desert",
            "unilib:sand_ordinary",
        },
        spawn_by = "unilib:tree_jungle_trunk",
        y_max = unilib.y_max,
        y_min = -10,
    })
    unilib.register_decoration_now("convert_tree_fern_on_sand", nil, {
        -- From ferns/treefern.lua
        -- Completes decoration in package "tree_fern"
        place_on = {
            "unilib:sand_ordinary",
        },
        spawn_by = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_water_river_source",
            "unilib:sand_desert",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
