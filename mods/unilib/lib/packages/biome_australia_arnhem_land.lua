---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_arnhem_land = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.youngtrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_arnhem_land.init()

    return {
        description = "Arnhem Land biome",
        depends = "liquid_water_river_muddy",
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_arnhem_land.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf"

    else

        node_filler = "unilib:dirt_antipodean"
        -- Produces unilib:dirt_antipodean_with_turf_arnhem_land
        node_top = unilib.pkg.dirt_custom_antipodean.generate_antipodean_dirt(
            "arnhem_land", S("Arnhem Land Turf"), "#F6FF00:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_arnhem_land.lua, "arnhem_land" biome
        name = "australia_arnhem_land",
        description = unilib.utils.brackets(S("Arnhem Land biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 3,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 60,
        humidity_point = 80,
    })

end
