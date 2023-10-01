---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_soft = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_soft.init()

    return {
        description = "Soft snow block",
        depends = {"liquid_water_fresh", "snow_clump"},
    }

end

function unilib.pkg.snow_soft.exec()

    unilib.register_node("unilib:snow_soft_block", "pedology:snow_soft", mode, {
        -- From pedology:snow_soft
        description = S("Soft Snow Block"),
        tiles = {"unilib_snow_soft_block.png"},
        groups = {crumbly = 2, falling_node = 1, level = 2, melts = 1},
        sounds = {footstep = {name = "unilib_snow_soft_footstep", gain = 1}},

        drop = "unilib:snow_clump",
    })

    local data_table = {
        source = "unilib:liquid_water_fresh_source",
        flowing = "unilib:liquid_water_fresh_flowing",
    }
    unilib.register_ice_snow_melting("unilib:snow_soft_block", data_table)

end
