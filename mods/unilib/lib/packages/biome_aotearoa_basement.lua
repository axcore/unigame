---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_aotearoa_basement = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_aotearoa_basement.init()

    return {
        description = "Aotearoa basement biomes",
        depends = {
            "stone_gneiss_antipodean",
            "stone_granite_antipodean",
            "stone_greywacke_dark",
            "stone_schist_antipodean",
        },
    }

end

function unilib.pkg.biome_aotearoa_basement.post()

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "greywacke_basement" biome
        name = "aotearoa_basement_greywacke",
        description = unilib.utils.brackets(S("Greywacke basement biome"), "aotearoa"),
        node_top = "unilib:stone_greywacke_dark",
        depth_top = 5,
        node_filler = "unilib:stone_greywacke_dark",
        depth_filler = 5,
        node_stone = "unilib:stone_greywacke_dark",
        y_max = -400,
        y_min = -15000,
        heat_point = 50,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "schist_basement" biome
        name = "aotearoa_basement_schist",
        description = unilib.utils.brackets(S("Schist basement biome"), "aotearoa"),
        node_top = "unilib:stone_schist_antipodean",
        depth_top = 5,
        node_filler = "unilib:stone_schist_antipodean",
        depth_filler = 5,
        node_stone = "unilib:stone_schist_antipodean",
        y_max = -400,
        y_min = -15000,
        heat_point = 40,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "gneiss_basement" biome
        name = "aotearoa_basement_gneiss",
        description = unilib.utils.brackets(S("Gneiss basement biome"), "aotearoa"),
        node_top = "unilib:stone_gneiss_antipodean",
        depth_top = 5,
        node_filler = "unilib:stone_gneiss_antipodean",
        depth_filler = 5,
        node_stone = "unilib:stone_gneiss_antipodean",
        y_max = -400,
        y_min = -15000,
        heat_point = 10,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From aotearoa/mapgen.lua, "granite_basement" biome
        name = "aotearoa_basement_granite",
        description = unilib.utils.brackets(S("Granite basement biome"), "aotearoa"),
        node_top = "unilib:stone_granite_antipodean",
        depth_top = 5,
        node_filler = "unilib:stone_granite_antipodean",
        depth_filler = 5,
        node_stone = "unilib:stone_granite_antipodean",
        y_max = -400,
        y_min = -15000,
        heat_point = 10,
        humidity_point = 90,
    })

end
