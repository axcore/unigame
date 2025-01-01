---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_ladder_invisible = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_ladder_invisible.init()

    return {
        description = "Invisible ladder",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_ladder_invisible.exec()

    -- Invisible, non-pointable block that enables climbing
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:climb
        "unilib:admin_ladder_invisible",
        "maptools:climb",
        mode,
        {
            description = S("Invisible Ladder"),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
            -- (no sounds)

            climbable = true,
            drawtype = "airlike",
            inventory_image = "unilib_metal_steel_block.png^unilib_ladder_wood_ordinary.png",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,
        }
    )

end
