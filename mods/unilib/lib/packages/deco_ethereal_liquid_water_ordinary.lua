---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_liquid_water_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_liquid_water_ordinary.init()

    return {
        description = "Water pools in swamps as decoration",
        depends = {"biome_ethereal_swamp", "dirt_ordinary", "liquid_water_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_liquid_water_ordinary.exec()

    unilib.register_decoration_generic("ethereal_liquid_water_ordinary_1", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:liquid_water_ordinary_source",

        fill_ratio = 0.01,
        flags = "force_placement",
        place_offset_y = -1,
        sidelen = 4,
    })

    unilib.register_decoration_generic("ethereal_liquid_water_ordinary_2", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:liquid_water_ordinary_source",

        fill_ratio = 0.1,
        flags = "force_placement",
        place_offset_y = -1,
        sidelen = 4,
    })

end

function unilib.pkg.deco_ethereal_liquid_water_ordinary.post()

    unilib.register_decoration_complete("ethereal_liquid_water_ordinary_1", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_swamp",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:dirt_ordinary_with_turf",
        y_max = 2,
        y_min = 1,
    })

    unilib.register_decoration_complete("ethereal_liquid_water_ordinary_2", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_swamp",
        num_spawn_by = 8,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = {"unilib:dirt_ordinary_with_turf", "unilib:liquid_water_ordinary_source"},
        y_max = 2,
        y_min = 1,
    })

end
