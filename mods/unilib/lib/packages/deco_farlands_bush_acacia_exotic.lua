---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_bush_acacia_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_bush_acacia_exotic.init()

    return {
        description = "Exotic acacia bush as decoration",
        depends = {"biome_farlands_savanna", "bush_acacia_exotic", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_farlands_bush_acacia_exotic.post()

    unilib.register_decoration_complete("farlands_bush_acacia_exotic", nil, {
        -- From farlands, mapgen/mapgen.lua
        -- Completes decoration in package "bush_acacia_exotic"
        biomes = "farlands_savanna",
        place_on = "unilib:dirt_ordinary_with_turf_dry",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end

