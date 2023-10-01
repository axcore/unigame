---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_purple_small_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_purple_small_mature.init()

    return {
        description = "Mature small purple cactus",
    }

end

function unilib.pkg.plant_cactus_purple_small_mature.exec()

    unilib.register_node(
        -- From GLEMr11, lib_ecology:cactus_purple_column
        "unilib:plant_cactus_purple_small_mature",
        "lib_ecology:cactus_purple_column",
        mode,
        {
            description = S("Mature Small Purple Cactus"),
            tiles = {
                "unilib_plant_cactus_purple_top.png",
                "unilib_plant_cactus_purple_top.png",
                "unilib_plant_cactus_purple_side.png",
            },
            -- N.B. flora = 1 not in original code
            groups = {choppy = 2, flammable = 2, flora = 1, oddly_breakable_by_hand = 1, tree = 1},
            -- N.B. No sounds in original code
            sounds = unilib.sound_table.wood,

            damage_per_second = 1,
            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
            use_texture_alpha = "clip",
            walkable = true,
        }
    )
    -- (not compatible with flowerpots)

end
