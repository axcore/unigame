---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_jarrah_karri_forests = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_jarrah_karri_forests.init()

    return {
        description = "Jarrah/karri forests biome",
        depends = {"dirt_ordinary", "liquid_water_river_muddy", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.biome_australia_jarrah_karri_forests.exec()

    unilib.register_biome({
        -- From australia/biome_jarrah_karri_forests.lua, "jarrah_karri_forests" biome
        name = "australia_jarrah_karri_forests",
        description = unilib.brackets(S("Jarrah/karri forests biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 20,
        humidity_point = 50,
    })

end
