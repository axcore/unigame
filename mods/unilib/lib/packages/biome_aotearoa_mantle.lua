---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_mantle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_mantle.init()

    return {
        description = "Aotearoa mantle biomes",
        depends = {
            "gravel_ordinary",
            "liquid_mud_boiling",
            "liquid_lava_ordinary",
            "sand_volcanic",
        },
    }

end

function unilib.pkg.biome_aotearoa_mantle.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "cold_mantle" biome
        name = "aotearoa_mantle_cold",
        description = unilib.utils.brackets(S("Cold mantle biome"), "aotearoa"),
        node_top = "unilib:sand_volcanic",
        depth_top = 10,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 3,
        y_max = -9000,
        y_min = unilib.constant.y_min,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "wet_mantle" biome
        name = "aotearoa_mantle_wet",
        description = unilib.utils.brackets(S("Wet mantle biome"), "aotearoa"),
        node_top = "unilib:liquid_mud_boiling_source",
        depth_top = 10,
        node_filler = "unilib:liquid_mud_boiling_source",
        depth_filler = 3,
        y_max = -12000,
        y_min = unilib.constant.y_min,
        heat_point = 60,
        humidity_point = 60,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "mantle" biome
        name = "aotearoa_mantle",
        description = unilib.utils.brackets(S("Mantle biome"), "aotearoa"),
        node_top = "unilib:liquid_lava_ordinary_source",
        depth_top = 10,
        node_filler = "unilib:liquid_lava_ordinary_source",
        depth_filler = 3,
        y_max = -13500,
        y_min = unilib.constant.y_min,
        heat_point = 70,
        humidity_point = 30,
    })

end
