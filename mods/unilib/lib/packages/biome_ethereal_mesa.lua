---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_mesa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_mesa.init()

    return {
        description = "Mesa biomes",
        depends = {"clay_baked_ethereal", "dirt_ordinary", "sand_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_mesa.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mesa" biome
        name = "ethereal_mesa",
        description = unilib.brackets(S("Mesa biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_dry",
        depth_top = 1,
        node_filler = "unilib:clay_baked_orange",
        depth_filler = 15,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 71,
        y_min = 1,
        heat_point = 25,
        humidity_point = 28,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mesa_ocean" biome
        name = "ethereal_mesa_ocean",
        description = unilib.brackets(S("Mesa ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 1,
        y_min = -192,
        heat_point = 25,
        humidity_point = 28,
    })

end
