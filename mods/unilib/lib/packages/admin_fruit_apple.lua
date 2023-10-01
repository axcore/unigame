---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_fruit_apple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_fruit_apple.init()

    return {
        description = "Admin super-apple",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_fruit_apple.exec()

    -- Admin super-apple for restoring full health
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:superapple
        "unilib:admin_fruit_apple",
        "maptools:superapple",
        mode,
        {
            description = S("Admin Super-Apple"),
            tiles = {"unilib_admin_fruit_apple.png"},
            groups = {
                dig_immediate = 3, fleshy = 3,
                not_in_creative_inventory = unilib.show_admin_item_group,
            },
            sounds = unilib.sound_table.node,

            drawtype = "plantlike",
            inventory_image = "unilib_admin_fruit_apple.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
            },
            sunlight_propagates = true,
            visual_scale = 1.0,
            walkable = false,

            -- Don't use cuisine history for an admin apple
            on_use = minetest.item_eat(20),
        }
    )

end
