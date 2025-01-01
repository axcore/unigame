---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_butterflies = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_butterflies.init()

    return {
        description = "Butterflies for the \"gaia\" remix",
        depends = {"biome_gaia", "misc_butterfly"},
    }

end

function unilib.pkg.deco_gaia_butterflies.post()

    local biome_list = {}
    for _, temp in ipairs({"warm", "mild", "cool"}) do

        for _, humidity in ipairs({"semihumid", "temperate"}) do

            for _, elevation in ipairs({"coastal", "lowland"}) do
                table.insert(biome_list, "gaia_" .. temp .. "_" .. humidity .. "_" .. elevation)
            end

        end

    end

    unilib.register_decoration_simple({
        name = "unilib:gaia_misc_butterfly",
        deco_type = "simple",
        decoration = unilib.pkg.misc_butterfly.butterfly_list,

        biomes = biome_list,
        -- N.B. In the "mtgame" remix, butterflies do not spawn at anything like the same rate they
        --      do in minetest_game; the reasons are unknown (see the "unresolved bugs" section of
        --      the README). As a temporary measure, increase the .fill_ratio by a factor of 2
--      fill_ratio = 0.005,
        fill_ratio = 0.01,
        num_spawn_by = 1,
        place_offset_y = 2,
        place_on = "group:spreading_dirt_type",
        sidelen = 80,
        spawn_by = "group:flower",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

    -- Set up the nodetimers
    core.register_on_mods_loaded(function()
        unilib.pkg.misc_butterfly.setup_node_timers("unilib:gaia_misc_butterfly")
    end)

end
