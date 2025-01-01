---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_slushy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_slushy.init()

    return {
        description = "Slushy snow",
        depends = "liquid_water_fresh",
    }

end

function unilib.pkg.snow_slushy.exec()

    unilib.register_node("unilib:snow_slushy_block", "pedology:snow_slush", mode, {
        -- From pedology:snow_slush
        description = S("Slushy Snow"),
        tiles = {"unilib_snow_slushy_block.png"},
        groups = {crumbly = 1, falling_node = 1, level = 1, melts = 1},
        sounds = {footstep = {name = "unilib_snow_soft_footstep", gain = 1}},

        drop = "",
    })

    local data_table = {
        source = "unilib:liquid_water_fresh_source",
        flowing = "unilib:liquid_water_fresh_flowing",
    }
    unilib.register_ice_snow_melting("unilib:snow_slushy_block", data_table)

end
