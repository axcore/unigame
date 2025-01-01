---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_mesa = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_mesa.init()

    return {
        description = "Mesa biomes",
        depends = {
            "clay_baked_ethereal",
            "dirt_ordinary",
            "sand_desert",
            "sand_ordinary",
            "stone_ordinary",
            "stone_sandstone_desert",
        },
    }

end

function unilib.pkg.biome_ethereal_mesa.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mesa" biome
        name = "ethereal_mesa",
        description = unilib.utils.brackets(S("Mesa biome"), "ethereal"),
        node_top = "unilib:clay_baked_orange",
        depth_top = 1,
        node_filler = "unilib:clay_baked_orange",
        depth_filler = 15,
        node_riverbed = "unilib:sand_desert",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_sandstone_desert_brick",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_sandstone_desert_brick"),
        y_max = 71,
        y_min = 18,
        vertical_blend = 1,
        heat_point = 25,
        humidity_point = 10,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mesa_redwood" biome
        name = "ethereal_mesa_redwood",
        description = unilib.utils.brackets(S("Mesa redwood biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_dry",
        depth_top = 1,
        node_filler = "unilib:clay_baked_orange",
        depth_filler = 15,
        node_riverbed = "unilib:sand_desert",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_sandstone_desert",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_sandstone_desert"),
        y_max = 17,
        y_min = 11,
        vertical_blend = 1,
        heat_point = 25,
        humidity_point = 10,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mesa_beach" biome
        name = "ethereal_mesa_beach",
        description = unilib.utils.brackets(S("Mesa beach biome"), "ethereal"),
        node_top = "unilib:sand_desert",
        depth_top = 1,
        node_filler = "unilib:clay_baked_orange",
        depth_filler = 2,
        node_riverbed = "unilib:sand_desert",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_sandstone_desert",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_sandstone_desert"),
        y_max = 10,
        y_min = -1,
        heat_point = 25,
        humidity_point = 10,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mesa_ocean" biome
        name = "ethereal_mesa_ocean",
        description = unilib.utils.brackets(S("Mesa ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -2,
        y_min = -192,
        heat_point = 25,
        humidity_point = 10,
    })

end
