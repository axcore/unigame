---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_liquid_water_dirty = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_liquid_water_dirty.init()

    return {
        description = "Dirty water as ore",
        depends = {"dirt_ordinary_with_turf_swamp", "liquid_water_dirty"},
    }

end

function unilib.pkg.ore_farlands_liquid_water_dirty.post()

    unilib.register_ore({
        -- From farlands, mapgen/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:liquid_water_dirty_source",
        wherein                 = "unilib:dirt_ordinary_with_turf_swamp",

        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 8,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = 766,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
