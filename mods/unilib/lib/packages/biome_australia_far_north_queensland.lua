---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_far_north_queensland = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_far_north_queensland.init()

    return {
        description = "Far North Queensland biome",
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_far_north_queensland.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf"

    else

        node_filler = "unilib:dirt_antipodean"
        -- Produces unilib:dirt_antipodean_with_turf_far_north_queensland
        node_top = unilib.pkg.dirt_custom_antipodean.generate_antipodean_dirt(
            "far_north_queensland", S("Far North Queensland Turf"), "#B8FF00:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_far_north_queensland.lua, "far_north_queensland" biome
        name = "australia_far_north_queensland",
        description = unilib.utils.brackets(S("Far North Queensland biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 3,
        y_max = 35,
        y_min = 4,
        heat_point = 75,
        humidity_point = 90,
    })

end
