---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_dandelion_yellow_cluster = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_dandelion_yellow_cluster.init()

    return {
        description = "Cluster of yellow dandelions",
        optional = "flower_dandelion_yellow",
    }

end

function unilib.pkg.flower_dandelion_yellow_cluster.exec()

    unilib.register_node(
        -- From GLEMr11, lib_ecology:flower_dandelions_yellow_small
        "unilib:flower_dandelion_yellow_cluster",
        "lib_ecology:flower_dandelions_yellow_small",
        mode,
        {
            description = unilib.annotate(S("Cluster of Yellow Dandelions"), "Taraxacum"),
            tiles = {"unilib_flower_dandelion_yellow_cluster.png"},
            -- N.B. Replaced original groups with standard flower groups
--          groups = {
--              attached_node = 1, flammable = 1, flora = 1, leaves = 1,
--              oddly_breakable_by_hand = 1, snappy = 3,
--          },
            groups = {
                attached_node = 1, color_yellow = 1, flammable = 1, flora = 1, flower = 1,
                snappy = 3,
            },
            -- N.B. No sounds in original code
            sounds = unilib.sound_table.leaves,

            buildable_to = false,
            drawtype = "plantlike",
            -- N.B. floodable no longer required, because of unilib's flooding effects
--          floodable = true,
            -- N.B. inventory_image not in original code
            inventory_image = "unilib_flower_dandelion_yellow_cluster.png",
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
    if unilib.pkg_executed_table["flower_dandelion_yellow"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:flower_dandelion_yellow_cluster",
            recipe = {
                {"unilib:flower_dandelion_yellow", "unilib:flower_dandelion_yellow"},
                {"unilib:flower_dandelion_yellow", "unilib:flower_dandelion_yellow"},
            },
        })

    end
    unilib.register_flower_in_pot(
        "unilib:flower_dandelion_yellow_cluster", "lib_ecology:flower_dandelions_yellow_small"
    )

end
