---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_jarrah_karri_forests = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_jarrah_karri_forests.init()

    return {
        description = "Jarrah/Karri Forests biome",
        depends = {"liquid_water_river_muddy", "stone_sandstone_ordinary"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_jarrah_karri_forests.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf"

    else

        node_filler = "unilib:dirt_antipodean"
        -- Produces unilib:dirt_antipodean_dark_with_turf_jarrah_karri_forests
        node_top = unilib.pkg.dirt_custom_antipodean.generate_dark_antipodean_dirt(
            "jarrah_karri_forests", S("Jarrah/Karri Forests Turf"), "#7C9601:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_jarrah_karri_forests.lua, "jarrah_karri_forests" biome
        name = "australia_jarrah_karri_forests",
        description = unilib.utils.brackets(S("Jarrah/Karri Forests biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 20,
        humidity_point = 50,
    })

end
