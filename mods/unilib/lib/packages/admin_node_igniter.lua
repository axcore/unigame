---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_node_igniter = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_node_igniter.init()

    return {
        description = "Invisible igniter block",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_node_igniter.exec()

    -- Ignites surrounding nodes, including those placed there after this block has been placed
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:igniter
        "unilib:admin_node_igniter",
        "maptools:igniter",
        mode,
        {
            description = S("Invisible Igniter Block"),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {igniter = 2, not_in_creative_inventory = unilib.globalshow_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            inventory_image = "unilib_fire_ordinary.png",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,
        }
    )

end
