---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_acacia = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local doors_add_mode = unilib.global.imported_mod_table.doors.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_acacia.init()

    return {
        description = "Acacia tree",
        optional = {"item_book_ordinary", "item_sweeper", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.tree_acacia.exec()

    local burnlevel = 4
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "acacia",
        description = S("Acacia Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From default:acacia_tree. Creates unilib:tree_acacia_trunk
        part_name = "acacia",
        orig_name = "default:acacia_tree",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Acacia Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From default:acacia_wood. Creates unilib:tree_acacia_wood
        part_name = "acacia",
        orig_name = "default:acacia_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Acacia Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From default:acacia_leaves. Creates unilib:tree_acacia_leaves
        part_name = "acacia",
        orig_name = "default:acacia_leaves",

        replace_mode = default_add_mode,
        description = S("Acacia Tree Leaves"),
        special_list = "unilib_tree_acacia_leaves_simple.png",
    })
    unilib.register_quick_tree_leafdecay("acacia")

    unilib.register_tree_sapling({
        -- From default:acacia_sapling. Creates unilib:tree_acacia_sapling
        part_name = "acacia",
        orig_name = "default:acacia_sapling",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Acacia Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 7, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 1, 4},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    if unilib.setting.mtgame_tweak_flag and (
            moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")
    ) then

        unilib.register_tree_panel({
            -- From moreblocks:all_faces_acacia_tree. Creates unilib:tree_acacia_panel
            part_name = "acacia",
            orig_name = "moreblocks:all_faces_acacia_tree",

            replace_mode = moreblocks_add_mode,
            burnlevel = burnlevel,
            common_group = 2,
            description = S("Acacia Wood Panel"),
        })

    end

    unilib.register_fence_quick({
        -- From default:fence_acacia_wood. unilib:tree_acacia_wood_fence
        part_name = "acacia",
        orig_name = "default:fence_acacia_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Acacia Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From default:fence_rail_acacia_wood. unilib:tree_acacia_wood_fence_rail
        part_name = "acacia",
        orig_name = "default:fence_rail_acacia_wood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Acacia Wood Fence Rail"),
    })

    if doors_add_mode ~= "defer" or not core.get_modpath("doors") then

        unilib.register_fence_gate_quick({
            -- From doors:gate_acacia_wood_closed, etc. unilib:gate_acacia_closed, etc
            part_name = "acacia",
            orig_name = {"doors:gate_acacia_wood_closed", "doors:gate_acacia_wood_open"},

            replace_mode = doors_add_mode,
            burnlevel = burnlevel,
            description = S("Acacia Wood Fence Gate"),
        })

    end

    unilib.register_decoration_generic("default_tree_acacia", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_acacia.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.002,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

    unilib.register_decoration_generic("default_tree_acacia_log", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_acacia_log.mts",

        flags = "place_center_x",
        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.001,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = 1,
        rotation = "random",
        sidelen = 16,
    })

end
