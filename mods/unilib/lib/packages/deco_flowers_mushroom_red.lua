---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_flowers_mushroom_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_flowers_mushroom_red.init()

    return {
        description = "Red mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_red"},
        at_least_one = {"biome_default_forest_coniferous", "biome_default_forest_deciduous"},
    }

end

function unilib.pkg.deco_flowers_mushroom_red.post()

    unilib.register_decoration_now("flowers_mushroom_red", nil, {
        -- From flowers/mapgen.lua
        -- Completes decoration in package "mushroom_red"
        biomes = {"default_forest_coniferous", "default_forest_deciduous"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
