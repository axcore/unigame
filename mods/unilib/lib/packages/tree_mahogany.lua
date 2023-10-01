---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/mahogany
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mahogany = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mahogany.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mahogany.init()

    return {
        description = "Mahogany tree",
    }

end

function unilib.pkg.tree_mahogany.exec()

    local burnlevel = 3
    local sci_name = "Khaya anthotheca"

    unilib.register_tree({
        -- Original to unilib
        part_name = "mahogany",
        description = S("Mahogany Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_mahogany_creeper", "mahogany:creeper", mode, {
        -- From mahogany:creeper
        description = S("Mahogany Creeper"),
        tiles = {"unilib_tree_mahogany_creeper.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_mahogany_creeper.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_mahogany_creeper.png",
    })

    unilib.register_node("unilib:tree_mahogany_creeper_flowers", "mahogany:flower_creeper", mode, {
        -- From mahogany:flower_creeper
        description = S("Mahogany Creeper with Flowers"),
        tiles = {"unilib_tree_mahogany_creeper_flowers.png"},
        groups = {
            carpet = 1, choppy = 2, falling_node = 1, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_mahogany_creeper_flowers.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_mahogany_creeper_flowers.png",
    })

    unilib.register_node("unilib:tree_mahogany_creeper_hanging", "mahogany:hanging_creeper", mode, {
        -- From mahogany:hanging_creeper
        description = S("Hanging Mahogany Creeper"),
        tiles = {"unilib_tree_mahogany_creeper_hanging.png"},
        groups = {
            carpet = 1, choppy = 2, falling_node = 1, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_mahogany_creeper_hanging.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_mahogany_creeper_hanging.png",
    })

    unilib.register_tree_trunk({
        -- From mahogany:trunk. Creates unilib:tree_mahogany_trunk
        part_name = "mahogany",
        orig_name = "mahogany:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mahogany Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From mahogany:wood. Creates unilib:tree_mahogany_wood
        part_name = "mahogany",
        orig_name = "mahogany:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mahogany Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From mahogany:leaves. Creates unilib:tree_mahogany_leaves
        part_name = "mahogany",
        orig_name = "mahogany:leaves",

        replace_mode = mode,
        description = S("Mahogany Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From mahogany:leaves
        trunks = {"unilib:tree_mahogany_trunk"},
        -- N.B. Only leaves in original code
        leaves = {
            "unilib:tree_mahogany_leaves",
            "unilib:tree_mahogany_creeper",
            "unilib:tree_mahogany_creeper_flowers",
            "unilib:tree_mahogany_creeper_hanging",
        },
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From mahogany:sapling. Creates unilib:tree_mahogany_sapling
        part_name = "mahogany",
        orig_name = "mahogany:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Mahogany Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {3, 0, 3},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })
    unilib.override_item("unilib:tree_mahogany_sapling", {
        use_texture_alpha = "clip",
    })

    unilib.register_fence_quick({
        -- From mahogany:fence. Creates unilib:tree_mahogany_wood_fence
        part_name = "mahogany",
        orig_name = "mahogany:fence",

        replace_mode = mode,
        base_img = "unilib_tree_mahogany_wood.png",
        burnlevel = burnlevel,
        description = S("Mahogany Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From mahogany:fence_rail. Creates unilib:tree_mahogany_wood_fence_rail
        part_name = "mahogany",
        orig_name = "mahogany:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_mahogany_wood.png",
        burnlevel = burnlevel,
        description = S("Mahogany Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From mahogany:gate. Creates unilib:gate_mahogany_closed
        part_name = "mahogany",
        orig_name = {"mahogany:gate_closed", "mahogany:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Mahogany Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_mahogany", {
        -- From mahogany/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_mahogany.mts",

        flags = "place_center_x, place_center_z, force_placement",
        height = 2,
        noise_params = {
            octaves = 3,
            offset = 0.005,
            persist = 0.66,
            scale = 0.005,
            seed = 345,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
