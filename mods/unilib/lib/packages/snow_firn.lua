---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_firn = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_firn.init()

    return {
        description = "Firn snow",
        depends = "liquid_water_fresh",
    }

end

function unilib.pkg.snow_firn.exec()

    unilib.register_node("unilib:snow_firn_block", "pedology:snow_firn", mode, {
        -- From pedology:snow_firn
        description = S("Firn Snow"),
        tiles = {"unilib_snow_firn_block.png"},
        groups = {crumbly = 2, cracky = 2, level = 4, melts = 1},
        sounds = {footstep = {name = "unilib_ice_white_footstep", gain = 0.7}},

        drop = "unilib:snow_clump 4",
    })

    local data_table = {
        source = "unilib:liquid_water_fresh_source",
        flowing = "unilib:liquid_water_fresh_flowing",
    }
    unilib.register_ice_snow_melting("unilib:snow_firn_block", data_table)

end
