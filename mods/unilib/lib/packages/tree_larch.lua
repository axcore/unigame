---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/larch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_larch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.larch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_larch.init()

    return {
        description = "Larch tree",
        notes = "Produces larch tree moss",
    }

end

function unilib.pkg.tree_larch.exec()

    local burnlevel = 3
    local sci_name = "Larix decidua"

    unilib.register_tree({
        -- Original to unilib
        part_name = "larch",
        description = S("Larch Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_larch_moss", "larch:moss", mode, {
        -- From larch:moss
        description = S("Larch Tree Moss"),
        tiles = {"unilib_tree_larch_moss.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, falling_node = 1, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_larch_moss.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_larch_moss.png",
    })

    unilib.register_tree_trunk({
        -- From larch:trunk. Creates unilib:tree_larch_trunk
        part_name = "larch",
        orig_name = "larch:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Larch Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From larch:wood. Creates unilib:tree_larch_wood
        part_name = "larch",
        orig_name = "larch:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Larch Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From larch:leaves. Creates unilib:tree_larch_leaves
        part_name = "larch",
        orig_name = "larch:leaves",

        replace_mode = mode,
        description = S("Larch Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From larch:leaves
        trunk_type = "larch",
        trunks = {"unilib:tree_larch_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_larch_leaves"},
        others = {"unilib:tree_larch_moss"},
        -- N.B. Increased radius because of non-decaying leaves at tree's extremities
--      radius = 3,
        radius = 4,
    })

    unilib.register_tree_sapling({
        -- From larch:sapling. Creates unilib:tree_larch_sapling
        part_name = "larch",
        orig_name = "larch:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Larch Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {5, 0, 5},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From larch:fence. Creates unilib:tree_larch_wood_fence
        part_name = "larch",
        orig_name = "larch:fence",

        replace_mode = mode,
        base_img = "unilib_tree_larch_wood.png",
        burnlevel = burnlevel,
        description = S("Larch Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From larch:fence_rail. Creates unilib:tree_larch_wood_fence_rail
        part_name = "larch",
        orig_name = "larch:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_larch_wood.png",
        burnlevel = burnlevel,
        description = S("Larch Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From larch:gate_closed, etc. Creates unilib:gate_larch_closed, etc
        part_name = "larch",
        orig_name = {"larch:gate_closed", "larch:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Larch Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_larch", {
        -- From larch/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_larch.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.0005,
            seed = 542,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = 1,
        rotation = "random",
        sidelen = 16,
    })

end
