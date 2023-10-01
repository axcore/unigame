---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_purple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_purple.init()

    return {
        description = "Purple cactus",
    }

end

function unilib.pkg.plant_cactus_purple.exec()

    unilib.register_node("unilib:plant_cactus_purple", "lib_ecology:plant_cactus_02", mode, {
        -- From GLEMr4, lib_ecology:plant_cactus_02
        description = S("Purple Cactus"),
        tiles = {
            "unilib_plant_cactus_purple_top.png",
            "unilib_plant_cactus_purple_top.png",
            "unilib_plant_cactus_purple_side.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,

        on_place = minetest.rotate_node,
    })
    -- (not compatible with flowerpots)

end
