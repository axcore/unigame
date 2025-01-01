---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_alpine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_alpine.init()

    return {
        description = "Aotearoa alpine biomes",
        depends = {
            "gravel_ordinary",
            "gravel_ordinary_with_algae",
            "ice_ordinary",
            "liquid_water_river",
            "sand_volcanic",
            "snow_ordinary",
            "stone_andesite_antipodean",
            "stone_schist_antipodean",
        },
    }

end

function unilib.pkg.biome_aotearoa_alpine.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "fellfield" biome
        name = "aotearoa_alpine_fellfield",
        description = unilib.utils.brackets(S("Fellfield biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_filler = "unilib:stone_schist_antipodean",
        depth_filler = 4,
        node_stone = "unilib:stone_schist_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = 140,
        y_min = 118,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "alpine_snow" biome
        name = "aotearoa_alpine_snow",
        description = unilib.utils.brackets(S("Alpine snow biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:snow_ordinary_block",
        depth_top = 5,
        node_filler = "unilib:ice_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_schist_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:gravel_ordinary_with_algae",
        depth_riverbed = 1,
        y_max = unilib.constant.y_max,
        y_min = 138,
        heat_point = 50,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "glacier" biome
        name = "aotearoa_alpine_glacier",
        description = unilib.utils.brackets(S("Glacier biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:ice_ordinary",
        depth_top = 10,
        node_filler = "unilib:ice_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_schist_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:ice_ordinary",
        depth_riverbed = 1,
        y_max = unilib.constant.y_max,
        y_min = 122,
        heat_point = 0,
        humidity_point = 100,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "volcano" biome
        name = "aotearoa_alpine_volcano",
        description = unilib.utils.brackets(S("Volcano biome"), "aotearoa"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:sand_volcanic",
        depth_top = 2,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 5,
        node_stone = "unilib:stone_andesite_antipodean",
        node_river_water = "unilib:liquid_water_river_source",
        node_riverbed = "unilib:sand_volcanic",
        depth_riverbed = 3,
        y_max = unilib.constant.y_max,
        y_min = 118,
        heat_point = 100,
        humidity_point = 0,
    })

end
