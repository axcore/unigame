---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.structure_ethereal_igloo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.structure_ethereal_igloo.init()

    return {
        description = "Igloo structure",
        depends = {
            "biome_ethereal_glacier",
            "snow_ordinary",
            -- (From schematic, which uses unilib:bush_pine_stem and unilib:fruit_coconut for some
            --      reason)
            "bush_pine",
            "fruit_coconut",
        },
    }

end

function unilib.pkg.structure_ethereal_igloo.exec()

    unilib.register_decoration_generic("ethereal_igloo", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_structure_igloo.mts",

        fill_ratio = 0.0005,
        flags = "place_center_x, place_center_z, force_placement",
        place_offset_y = -1,
        rotation = "random",
        sidelen = 80,
    })

end

function unilib.pkg.structure_ethereal_igloo.post()

    unilib.register_decoration_complete("ethereal_igloo", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_glacier",
        num_spawn_by = 8,
        place_on = "unilib:snow_ordinary_block",
        spawn_by = "unilib:snow_ordinary_block",
        y_max = 30,
        y_min = 3,
    })

end

