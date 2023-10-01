---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_geranium_blue_cluster = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_geranium_blue_cluster.init()

    return {
        description = "Cluster of blue geraniums",
        optional = "flower_geranium_blue",
    }

end

function unilib.pkg.flower_geranium_blue_cluster.exec()

    unilib.register_node(
        -- From GLEMr11, lib_ecology:flower_geraniums
        "unilib:flower_geranium_blue_cluster",
        "lib_ecology:flower_geraniums",
        mode,
        {
            description = unilib.annotate(S("Cluster of Blue Geraniums"), "Geranium"),
            tiles = {"unilib_flower_geranium_blue_cluster.png"},
            -- N.B. Replaced original groups with standard flower groups
--          groups = {
--              attached_node = 1, flammable = 1, flora = 1, leaves = 1,
--              oddly_breakable_by_hand = 1, snappy = 3,
--          },
            groups = {
                attached_node = 1, color_blue = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
            },
            -- N.B. No sounds in original code
            sounds = unilib.sound_table.leaves,

            buildable_to = false,
            drawtype = "plantlike",
            -- N.B. floodable no longer required, because of unilib's flooding effects
--           floodable = true,
            -- N.B. inventory_image not in original code
            inventory_image = "unilib_flower_geranium_blue_cluster.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
            },
            sunlight_propagates = true,
            visual_scale = 1,
            walkable = false,
            waving = 1,
            wield_scale = {x = 0.5, y = 0.5, z = 0.5},
        }
    )
    if unilib.pkg_executed_table["flower_geranium_blue"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:flower_geranium_blue_cluster",
            recipe = {
                {"unilib:flower_geranium_blue", "unilib:flower_geranium_blue"},
                {"unilib:flower_geranium_blue", "unilib:flower_geranium_blue"},
            },
        })

    end
    unilib.register_flower_in_pot(
        "unilib:flower_geranium_blue_cluster", "lib_ecology:flower_geraniums"
    )

end
