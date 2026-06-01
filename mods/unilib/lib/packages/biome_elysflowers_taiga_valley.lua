---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_elysflowers_taiga_valley = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_elysflowers_taiga_valley.init()

    return {
        description = "Taiga valley biome",
        depends = {"dirt_ordinary", "dirt_ordinary_with_litter_coniferous", "sand_ordinary"},
    }

end

function unilib.pkg.biome_elysflowers_taiga_valley.post()

    unilib.register_biome({
        -- From init.lua, "taiga_valley" biome
        name = "elysflowers_taiga_valley",
        description = unilib.utils.brackets(S("Taiga valley biome"), "elysflowers"),
        node_top = "unilib:dirt_ordinary_with_litter_coniferous",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 1,
        y_max = 100,
        y_min = 1,
        heat_point = 7,
        humidity_point = 85,
        weight = 0.29,
    })

end
