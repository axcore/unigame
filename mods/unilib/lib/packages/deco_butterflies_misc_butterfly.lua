---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    butterflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_butterflies_misc_butterfly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.butterflies.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_butterflies_misc_butterfly.init()

    return {
        description = "Butterflies as decoration",
        depends = {"dirt_ordinary", "misc_butterfly"},
        at_least_one = {"biome_default_forest_deciduous", "biome_default_grassland"},
    }

end

function unilib.pkg.deco_butterflies_misc_butterfly.post()

    unilib.register_decoration_complete("butterflies_misc_butterfly", nil, {
        -- From butterflies/init.lua
        -- Completes decoration in package "misc_butterfly"
        biomes = {"default_forest_deciduous", "default_grassland"},
        num_spawn_by = 1,
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "group:flower",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

    -- Set up the nodetimers
    core.register_on_mods_loaded(function()
        unilib.pkg.misc_butterfly.setup_node_timers("unilib:butterflies_misc_butterfly")
    end)

end
