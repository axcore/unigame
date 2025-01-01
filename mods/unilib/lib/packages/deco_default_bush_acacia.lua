---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_bush_acacia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_bush_acacia.init()

    return {
        description = "Acacia bush as decoration",
        depends = {"biome_default_savanna", "bush_acacia", "dirt_dry"},
    }

end

function unilib.pkg.deco_default_bush_acacia.post()

    unilib.register_decoration_complete("default_bush_acacia", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "bush_acacia"
        biomes = "default_savanna",
        place_on = "unilib:dirt_dry_with_turf_dry",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
