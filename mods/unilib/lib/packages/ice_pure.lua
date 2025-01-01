---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ice_pure = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ice_pure.init()

    return {
        description = "Pure Ice",
        depends = "liquid_water_fresh",
    }

end

function unilib.pkg.ice_pure.exec()

    unilib.register_node("unilib:ice_pure", "pedology:ice_pure", mode, {
        -- From pedology:ice_pure
        description = S("Pure Ice"),
        tiles = {"unilib_ice_pure.png"},
        -- N.B. cools_lava, puts_out_fire and slippery not in original code
        groups = {
            cools_lava = 1, cracky = 3, level = 2, melts = 1, puts_out_fire = 1, slippery = 3,
        },
        sounds = {footstep = {name = "unilib_ice_pure_footstep", gain = 0.8}},

        drawtype = "glasslike",
        drop = "unilib:ice_pure_lump 4",
        inventory_image = core.inventorycube("unilib_ice_pure.png"),
        paramtype = "light",
    })

    local data_table = {
        source = "unilib:liquid_water_fresh_source",
        flowing = "unilib:liquid_water_fresh_flowing",
    }
    unilib.register_ice_snow_melting("unilib:ice_pure", data_table)

    unilib.register_craftitem("unilib:ice_pure_lump", "pedology:lump_ice_pure", mode, {
        -- From pedology:lump_ice_pure
        description = S("Lump of Pure Ice"),
        inventory_image = "unilib_ice_pure_lump.png",

        wield_image = "unilib_ice_pure_lump.png",
    })

end
