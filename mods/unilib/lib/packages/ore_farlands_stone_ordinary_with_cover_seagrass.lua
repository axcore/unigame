---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_stone_ordinary_with_cover_seagrass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_stone_ordinary_with_cover_seagrass.init()

    return {
        description = "Ordinary stone with seagrass as ore",
        depends = {"sand_ordinary", "stone_ordinary_with_cover_seagrass"},
    }

end

function unilib.pkg.ore_farlands_stone_ordinary_with_cover_seagrass.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_ordinary_with_cover_seagrass",
        wherein                 = "unilib:sand_ordinary",

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 8,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = -316,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = 0,
        y_min                   = -15,
    })

end
