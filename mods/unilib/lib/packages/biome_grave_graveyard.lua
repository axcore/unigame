---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grave
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_grave_graveyard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grave.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_grave_graveyard.init()

    return {
        description = "Graveyard biome",
        depends = {"dirt_graveyard", "stone_ordinary"},
    }

end

function unilib.pkg.biome_grave_graveyard.post()

    unilib.register_biome({
        -- From grave/mapgen.lua, "grave" biome
        name = "grave_graveyard",
        description = unilib.brackets(S("Graveyard biome"), "graveyard"),
        node_top = "unilib:dirt_graveyard_with_turf_graveyard",
        depth_top = 1,
        node_filler = "unilib:dirt_graveyard",
        depth_filler = 16,
        node_stone = "unilib:stone_ordinary",
        y_max = unilib.y_max,
        y_min = 1,
        heat_point = 20,
        humidity_point = 75,
    })

end
