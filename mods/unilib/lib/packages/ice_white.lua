---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ice_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ice_white.init()

    return {
        description = "White ice",
        depends = "liquid_water_fresh",
    }

end

function unilib.pkg.ice_white.exec()

    unilib.register_node("unilib:ice_white", "pedology:ice_white", mode, {
        -- From pedology:ice_white
        description = S("White Ice"),
        tiles = {"unilib_ice_white.png"},
        -- N.B. cools_lava, puts_out_fire and slippery not in original code
        groups = {
            cools_lava = 1, cracky = 3, level = 1, melts = 1, puts_out_fire = 1, slippery = 3,
        },
        sounds = {footstep = {name = "unilib_ice_white_footstep", gain = 0.8}},

        drop = "unilib:ice_white_lump 4",
    })
    unilib.register_stairs("unilib:ice_white")
    unilib.register_carvings("unilib:ice_white", {
        millwork_flag = true,
    })

    local data_table = {
        source = "unilib:liquid_water_fresh_source",
        flowing = "unilib:liquid_water_fresh_flowing",
    }
    unilib.register_ice_snow_melting("unilib:ice_white", data_table)

    unilib.register_craftitem("unilib:ice_white_lump", "pedology:lump_ice_white", mode, {
        -- From pedology:lump_ice_white
        description = S("Lump of White Ice"),
        inventory_image = "unilib_ice_white_lump.png",

        wield_image = "unilib_ice_white_lump.png",
    })

end
