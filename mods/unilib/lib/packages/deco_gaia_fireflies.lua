---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_fireflies = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_fireflies.init()

    return {
        description = "Fireflies for the \"gaia\" remix",
        depends = {"biome_gaia", "misc_firefly"},
    }

end

function unilib.pkg.deco_gaia_fireflies.post()

    local biome_list = {}
    for _, temp in ipairs({"warm", "mild", "cool"}) do

        for _, humidity in ipairs({"semihumid", "temperate"}) do

            for _, elevation in ipairs({"coastal", "lowland"}) do
                table.insert(biome_list, "gaia_" .. temp .. "_" .. humidity .. "_" .. elevation)
            end

        end

    end

    unilib.register_decoration_simple({
        name = "unilib:gaia_misc_firefly_low",
        deco_type = "simple",
        decoration = unilib.pkg.misc_firefly.hidden_firefly_list,

        biomes = biome_list,

        fill_ratio = 0.0005,
        place_offset_y = 2,
        place_on = "group:spreading_dirt_type",
        sidelen = 80,
        y_max = unilib.constant.y_max,
        y_min = -1,
    })

    unilib.register_decoration_simple({
        name = "unilib:gaia_misc_firefly_high",
        deco_type = "simple",
        decoration = unilib.pkg.misc_firefly.hidden_firefly_list,

        biomes = biome_list,

        fill_ratio = 0.0005,
        place_offset_y = 3,
        place_on = "group:spreading_dirt_type",
        sidelen = 80,
        y_max = unilib.constant.y_max,
        y_min = -1,
    })

    -- Set up the nodetimers
    core.register_on_mods_loaded(function()

        unilib.pkg.misc_firefly.setup_node_timers(
            "unilib:gaia_misc_firefly_low",
            "unilib:gaia_misc_firefly_high"
        )

    end)

end
