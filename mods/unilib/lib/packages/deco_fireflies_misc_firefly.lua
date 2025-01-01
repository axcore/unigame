---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_fireflies_misc_firefly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fireflies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_fireflies_misc_firefly.init()

    return {
        description = "Fireflies as decoration",
        depends = {"dirt_ordinary", "misc_firefly"},
        at_least_one = {
            "biome_default_forest_coniferous",
            "biome_default_forest_deciduous",
            "biome_default_rainforest",
        },
    }

end

function unilib.pkg.deco_fireflies_misc_firefly.post()

    -- (The "misc_firefly" pkg uses two near-identical decorations, one at a y-offset of 2, the
    --      other at an offset of 3)
    for _, part_name in pairs({"low", "high"}) do

        unilib.register_decoration_complete("fireflies_misc_firefly_" .. part_name, nil, {
            -- From fireflies/init.lua
            -- Completes decoration in package "misc_firefly"
            biomes = {
                "default_forest_coniferous",
                "default_forest_deciduous",
                "default_rainforest",
                "default_rainforest_swamp"
            },
            place_on = {
                "unilib:dirt_ordinary",
                "unilib:dirt_ordinary_with_litter_coniferous",
                "unilib:dirt_ordinary_with_litter_rainforest",
                "unilib:dirt_ordinary_with_turf",
            },
            y_max = unilib.constant.y_max,
            y_min = -1,
        })

    end

    -- Set up the nodetimers
    core.register_on_mods_loaded(function()

        unilib.pkg.misc_firefly.setup_node_timers(
            "unilib:fireflies_misc_firefly_low",
            "unilib:fireflies_misc_firefly_high"
        )

    end)

end
