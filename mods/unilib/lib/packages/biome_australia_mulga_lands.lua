---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_mulga_lands = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_mulga_lands.init()

    return {
        description = "Mulga Lands biome",
        depends = "liquid_water_river_muddy",
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.biome_australia_mulga_lands.post()

    local node_filler, node_top
    if unilib.global.pkg_executed_table["dirt_custom_antipodean"] == nil then

        node_filler = "unilib:dirt_ordinary"
        node_top = "unilib:dirt_ordinary_with_turf_dry"

    else

        node_filler = "unilib:dirt_ordinary"
        -- Produces unilib:dirt_ordinary_with_turf_mulga_lands
        node_top = unilib.pkg.dirt_custom_antipodean.generate_ordinary_dirt(
            "mulga_lands", S("Mulga Lands Turf"), "#FFC700:96"
        )

    end

    unilib.register_biome({
        -- From australia/biome_mulga_lands.lua, "mulga_lands" biome
        name = "australia_mulga_lands",
        description = unilib.utils.brackets(S("Mulga Lands biome"), "australia"),
        node_top = node_top,
        depth_top = 1,
        node_filler = node_filler,
        depth_filler = 2,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.constant.y_max,
        y_min = 36,
        heat_point = 75,
        humidity_point = 45,
    })

end
