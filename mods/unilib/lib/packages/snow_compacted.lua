---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_compacted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_compacted.init()

    return {
        description = "Compacted snow",
        depends = {"liquid_water_fresh", "snow_clump"},
    }

end

function unilib.pkg.snow_compacted.exec()

    unilib.register_node("unilib:snow_compacted_block", "pedology:snow_packing", mode, {
        -- From pedology:snow_packing
        description = S("Compacted Snow"),
        tiles = {"unilib_snow_compacted_block.png"},
        groups = {crumbly = 3, level = 3, melts = 1},
        sounds = {footstep = {name = "unilib_snow_dense_footstep", gain = 1}},

        drop = "unilib:snow_clump 3",
    })

    local data_table = {
        source = "unilib:liquid_water_fresh_source",
        flowing = "unilib:liquid_water_fresh_flowing",
    }
    unilib.register_ice_snow_melting("unilib:snow_compacted_block", data_table)

end
