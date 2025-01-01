---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_flinders_lofty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_flinders_lofty.init()

    return {
        description = "Flinders Lofty biome",
        depends = "liquid_water_river_muddy",
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_flinders_lofty.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf_dry"

    else

        node_filler = "unilib:dirt_ordinary"
        -- Produces unilib:dirt_ordinary_with_turf_flinders_lofty
        node_top = unilib.pkg.dirt_custom_antipodean.generate_ordinary_dirt(
            "flinders_lofty", S("Flinders Lofty Turf"), "#FF9500:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_flinders_lofty.lua, "flinders_lofty" biome
        name = "australia_flinders_lofty",
        description = unilib.utils.brackets(S("Flinders Lofty biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 2,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.constant.y_max,
        y_min = 36,
        heat_point = 50,
        humidity_point = 50,
    })

end
