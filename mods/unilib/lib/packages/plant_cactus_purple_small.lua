---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_purple_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_purple_small.init()

    return {
        description = "Small purple cactus",
    }

end

function unilib.pkg.plant_cactus_purple_small.exec()

    unilib.register_node("unilib:plant_cactus_purple_small", "lib_ecology:plant_cactus_04", mode, {
        -- From GLEMr4, lib_ecology:plant_cactus_04
        description = S("Small Purple Cactus"),
        tiles = {
            "unilib_plant_cactus_purple_top.png",
            "unilib_plant_cactus_purple_top.png",
            "unilib_plant_cactus_purple_side.png",
        },
        -- N.B. flora = 1 not in original code
        groups = {choppy = 2, flammable = 2, flora = 1, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.0, 0.25},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.0, 0.25},
        },
        use_texture_alpha = "clip",
        walkable = true,

        on_place = core.rotate_node,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_spare("unilib:plant_cactus_purple_small")

end
