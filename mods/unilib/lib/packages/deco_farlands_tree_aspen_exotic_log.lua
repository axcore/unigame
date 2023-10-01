---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_tree_aspen_exotic_log = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_tree_aspen_exotic_log.init()

    return {
        description = "Exotic aspen tree log as decoration",
        depends = {
            "biome_farlands_forest_deciduous",
            "dirt_ordinary",
            "mushroom_brown",
            "mushroom_red",
            "tree_aspen_exotic",
        },
    }

end

function unilib.pkg.deco_farlands_tree_aspen_exotic_log.post()

    unilib.register_decoration_now("farlands_tree_aspen_exotic_log", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "tree_aspen_exotic"
        biomes = "farlands_forest_deciduous",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
