---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_fern_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_fern_ordinary.init()

    return {
        description = "Ordinary fern as decoration",
        depends = {"biome_default_forest_coniferous", "dirt_ordinary", "fern_ordinary"},
    }

end

function unilib.pkg.deco_default_fern_ordinary.post()

    for i = 1, 3 do

        unilib.register_decoration_now("default_fern_ordinary_" .. i, nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "fern_ordinary"
            biomes = "default_forest_coniferous",
            place_on = "unilib:dirt_ordinary_with_litter_coniferous",
            y_max = unilib.y_max,
            y_min = 6,
        })

    end

end
