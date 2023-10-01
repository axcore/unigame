---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ferns_fern_horsetail = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ferns_fern_horsetail.init()

    return {
        description = "Horsetail fern as decoration",
        at_least_one = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_short",
            "gravel_ordinary",
            "liquid_water_ordinary",
            "liquid_water_river",
            "sand_desert",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.deco_ferns_fern_horsetail.post()

    unilib.register_decoration_now("ferns_fern_horsetail", nil, {
        -- From ferns/horsetail.lua
        -- Completes decoration in package "fern_horsetail"
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_short",
            "unilib:gravel_ordinary",
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_water_river_source",
            "unilib:sand_desert",
            "unilib:sand_ordinary",
            "unilib:stone_ordinary_cobble_mossy",
        },
        y_max = unilib.y_max,
        y_min = 1,
    })

end
