---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/ebony
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_ebony = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ebony.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_ebony.init()

    return {
        description = "Ebony tree",
        notes = "Produces persimmon fruit",
        depends = "fruit_persimmon",
    }

end

function unilib.pkg.tree_ebony.exec()

    local burnlevel = 3
    local sci_name = "Diospyros kaki"

    unilib.register_tree({
        -- Original to unilib
        part_name = "ebony",
        description = S("Ebony Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_ebony_creeper", "ebony:creeper", mode, {
        -- From ebony:creeper
        description = S("Ebony Tree Creeper"),
        tiles = {"unilib_tree_ebony_creeper.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_ebony_creeper.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_ebony_creeper.png",
    })

    unilib.register_node("unilib:tree_ebony_creeper_leaves", "ebony:creeper_leaves", mode, {
        -- From ebony:creeper_leaves
        description = S("Ebony Tree Creeper with Leaves"),
        tiles = {"unilib_tree_ebony_creeper_leaves.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_ebony_creeper_leaves.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_ebony_creeper_leaves.png",
    })

    unilib.register_node("unilib:tree_ebony_liana", "ebony:liana", mode, {
        -- From ebony:liana
        description = S("Ebony Tree Liana"),
        tiles = {"unilib_tree_ebony_liana.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_ebony_liana.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_ebony_liana.png",
    })

    unilib.register_tree_trunk({
        -- From ebony:trunk. Creates unilib:tree_ebony_trunk
        part_name = "ebony",
        orig_name = "ebony:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Ebony Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From ebony:wood. Creates unilib:tree_ebony_wood
        part_name = "ebony",
        orig_name = "ebony:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Ebony Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From ebony:leaves. Creates unilib:tree_ebony_leaves
        part_name = "ebony",
        orig_name = "ebony:leaves",

        replace_mode = mode,
        description = S("Ebony Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From ebony:leaves
        trunk_type = "ebony",
        trunks = {"unilib:tree_ebony_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_ebony_leaves"},
        others = {
            "unilib:fruit_persimmon",
            "unilib:tree_ebony_creeper",
            "unilib:tree_ebony_creeper_leaves",
            "unilib:tree_ebony_liana",
        },
        -- N.B. Increased radius because of non-decaying liana at tree's extremities
--      radius = 3,
        radius = 4,
    })

    unilib.register_tree_sapling({
        -- From ebony:sapling. Creates unilib:tree_ebony_sapling
        part_name = "ebony",
        orig_name = "ebony:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Ebony Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {5, 0, 5},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })
    unilib.override_item("unilib:tree_ebony_sapling", {
        use_texture_alpha = "clip",
    })

    unilib.register_fence_quick({
        -- From ebony:fence. Creates unilib:tree_ebony_wood_fence
        part_name = "ebony",
        orig_name = "ebony:fence",

        replace_mode = mode,
        base_img = "unilib_tree_ebony_wood.png",
        burnlevel = burnlevel,
        description = S("Ebony Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From ebony:fence_rail. Creates unilib:tree_ebony_wood_fence_rail
        part_name = "ebony",
        orig_name = "ebony:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_ebony_wood.png",
        burnlevel = burnlevel,
        description = S("Ebony Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From ebony:gate_closed, etc. Creates unilib:gate_ebony_closed, etc
        part_name = "ebony",
        orig_name = {"ebony:gate_closed", "ebony:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Ebony Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_ebony", {
        -- From ebony/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_ebony.mts",

        flags = "place_center_x, place_center_z, force_placement",
        height = 2,
        noise_params = {
            octaves = 3,
            offset = 0.005,
            persist = 0.66,
            scale = 0.002,
            seed = 1007,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
