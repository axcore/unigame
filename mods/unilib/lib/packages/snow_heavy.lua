---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_heavy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_heavy.init()

    return {
        description = "Heavy snow",
        depends = {"liquid_water_fresh", "snow_clump"},
    }

end

function unilib.pkg.snow_heavy.exec()

    unilib.register_node("unilib:snow_heavy_block", "pedology:snow", mode, {
        -- From pedology:snow
        description = S("Heavy Snow"),
        tiles = {"unilib_snow_heavy_block.png"},
        groups = {crumbly = 3, falling_node = 1, level = 3, melts = 1},
        sounds = {footstep = {name = "unilib_snow_dense_footstep", gain = 0.9}},

        drop = "unilib:snow_clump 2",
    })

    local data_table = {
        source = "unilib:liquid_water_fresh_source",
        flowing = "unilib:liquid_water_fresh_flowing",
    }
    unilib.register_ice_snow_melting("unilib:snow_heavy_block", data_table)

end
