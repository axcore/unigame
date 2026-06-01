---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_plant_cactus_hedgehog = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_plant_cactus_hedgehog.init()

    return {
        description = "Hedgehog cactus as decoration",
        at_least_one = {
            {
                "biome_default_desert_sandstone",
                "biome_default_desert",
                "biome_ethereal_desert_sandstone",
                "biome_ethereal_mesa",
                "biome_ethereal_desert",
            },
            {
                "sand_desert",
                "sand_ordinary",
            },
        },
    }

end

function unilib.pkg.deco_elysflowers_plant_cactus_hedgehog.post()

    unilib.register_decoration_complete("elysflowers_plant_cactus_hedgehog", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "plant_cactus_hedgehog"
        biomes = {
            "default_desert",
            "default_desert_sandstone",
            "ethereal_desert",
            "ethereal_desert_sandstone",
            "ethereal_mesa",
        },
        num_spawn_by = -1,
        place_on = {"unilib:sand_desert", "unilib:sand_ordinary"},
        -- (no spawn_by)
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
