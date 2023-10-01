---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.feature_coral_reef = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.feature_coral_reef.init()

    return {
        description = "Coral reef",
        depends = {
            "coral_block_brown",
            "coral_block_orange",
            "coral_block_skeleton",
            "sand_ordinary",
        },
        optional = {"biome_farlands_desert", "biome_farlands_savanna", "biome_farlands_rainforest"},
    }

end

function unilib.pkg.feature_coral_reef.exec()

    unilib.register_decoration("farlands_feature_coral_reef", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_feature_coral_reef.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 1,
            scale = 0.1,
            seed = 7013,
            spread = {x = 200, y = 200, z = 200},
        },
        rotation = "random",
    })

end

function unilib.pkg.feature_coral_reef.post()

    unilib.register_decoration_now("farlands_feature_coral_reef", nil, {
        -- From farlands, mapgen/mapgen.lua
        biomes = {
            "farlands_desert_ocean",
            "farlands_savanna_ocean",
            "farlands_rainforest_ocean",
        },
        place_on = "unilib:sand_ordinary",
        y_max = -2,
        y_min = -8,
    })

end
