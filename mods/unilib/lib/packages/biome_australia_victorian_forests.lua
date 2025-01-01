---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_victorian_forests = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_victorian_forests.init()

    return {
        description = "Victorian Forests biome",
        depends = "liquid_water_river_muddy",
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_victorian_forests.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf"

    else

        node_filler = "unilib:dirt_antipodean"
        -- Produces unilib:dirt_antipodean_dark_with_turf_victorian_forests
        node_top = unilib.pkg.dirt_custom_antipodean.generate_dark_antipodean_dirt(
            "victorian_forests", S("Victorian Forests Turf"), "#BE9500:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_victorian_forests.lua, "victorian_forests" biome
        name = "australia_victorian_forests",
        description = unilib.utils.brackets(S("Victorian Forests biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 3,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.constant.y_max,
        y_min = 36,
        heat_point = 40,
        humidity_point = 50,
    })

end
