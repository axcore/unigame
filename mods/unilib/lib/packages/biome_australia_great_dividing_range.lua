---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_great_dividing_range = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_great_dividing_range.init()

    return {
        description = "Great Dividing Range biome",
        depends = "liquid_water_river_muddy",
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_great_dividing_range.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf"

    else

        node_filler = "unilib:dirt_antipodean"
        -- Produces unilib:dirt_antipodean_with_turf_great_dividing_range
        node_top = unilib.pkg.dirt_custom_antipodean.generate_antipodean_dirt(
            "great_dividing_range", S("Great Dividing Range Turf"), "#8FFF00:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_great_dividing_range.lua, "great_dividing_range" biome
        name = "australia_great_dividing_range",
        description = unilib.utils.brackets(S("Great Dividing Range biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 3,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.constant.y_max,
        y_min = 36,
        heat_point = 25,
        humidity_point = 65,
    })

end
