---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_paintbrush_indian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_paintbrush_indian.init()

    return {
        description = "Indian paintbrush as decoration",
        depends = "grass_dry",
        at_least_one = {
            {
                "biome_default_savanna",
                "biome_ethereal_mesa",
                "biome_ethereal_prairie",
                "biome_ethereal_savanna",
            },
            {
                "dirt_dried",
                "dirt_dry",
                "dirt_dry_with_turf_dry",
                "dirt_ordinary_with_turf",
                "dirt_ordinary_with_turf_prairie",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_paintbrush_indian.post()

    unilib.register_decoration_complete("elysflowers_flower_paintbrush_indian", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_paintbrush_indian"
        biomes = {
            "default_savanna",
            "ethereal_mesa_redwood",
            "ethereal_prairie",
            "ethereal_savanna",
        },
        num_spawn_by = 2,
        place_on = {
            "unilib:dirt_dried",
            "unilib:dirt_dry",
            "unilib:dirt_dry_with_turf_dry",
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        spawn_by = {
            "unilib:grass_dry_1",
            "unilib:grass_dry_2",
            "unilib:grass_dry_3",
            "unilib:grass_dry_4",
            "unilib:grass_dry_5",
        },
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
