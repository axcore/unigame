---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_node_void = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_node_void.init()

    return {
        description = "Admin void (ignore-like) nodes",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_node_void.exec()

    -- Featureless black void
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:ignore_like
        "unilib:admin_node_void",
        "maptools:ignore_like",
        mode,
        {
            description = S("Void Node"),
            tiles = {"unilib_admin_invisible.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            inventory_image = "unilib_metal_steel_block.png^unilib_dye_pink.png",
            paramtype = "light",
            sunlight_propagates = true,
        }
    )

    -- Featureless black void with no-clip
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:ignore_like_no_clip
        "unilib:admin_node_void_noclip",
        "maptools:ignore_like_no_clip",
        mode,
        {
            description = unilib.hint(S("Void Node"), S("with no-clip")),
            tiles = {"unilib_admin_invisible.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            inventory_image = "unilib_metal_steel_block.png^unilib_dye_violet.png",
            paramtype = "light",
            sunlight_propagates = true,
            walkable = false,
        }
    )

    -- Featureless black void with no-point
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:ignore_like_no_point
        "unilib:admin_node_void_nopoint",
        "maptools:ignore_like_no_point",
        mode,
        {
            description = unilib.hint(S("Void Node"), S("with no-point")),
            tiles = {"unilib_admin_invisible.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            -- N.B. switched duplicate dye texture in original code
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_cyan.png",
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
        }
    )

    -- Featureless black void with no-clip and no-point
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:ignore_like_no_clip_no_point
        "unilib:admin_node_void_noclip_nopoint",
        "maptools:ignore_like_no_clip_no_point",
        mode,
        {
            description = unilib.hint(S("Void Node"), S("with no-clip and no-point")),
            tiles = {"unilib_admin_invisible.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            -- N.B. switched duplicate dye texture in original code
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_orange.png",
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,
        }
    )

end
