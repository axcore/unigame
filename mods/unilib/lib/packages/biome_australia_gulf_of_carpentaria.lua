---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_gulf_of_carpentaria = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_gulf_of_carpentaria.init()

    return {
        description = "Gulf of Carpentaria biome",
        depends = {"liquid_water_river_muddy", "stone_sandstone_ordinary"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_gulf_of_carpentaria.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf_dry"

    else

        node_filler = "unilib:dirt_ordinary"
        -- Produces unilib:dirt_ordinary_with_turf_gulf_of_carpentaria
        node_top = unilib.pkg.dirt_custom_antipodean.generate_ordinary_dirt(
            "gulf_of_carpentaria", S("Gulf of Carpentaria Turf"), "#FFB800:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_gulf_of_carpentaria.lua, "gulf_of_carpentaria" biome
        name = "australia_gulf_of_carpentaria",
        description = unilib.utils.brackets(S("Gulf of Carpentaria biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 2,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 75,
        humidity_point = 55,
    })

end
