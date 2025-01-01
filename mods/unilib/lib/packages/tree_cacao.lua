---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cacao = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cacaotree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cacao.init()

    return {
        description = "Cacao tree",
        notes = "Produces cacao pods",
        depends = "ingredient_cocoa_normal",
    }

end

function unilib.pkg.tree_cacao.exec()

    local burnlevel = 3
    local sci_name = "Theobroma cacao"

    unilib.register_tree({
        -- Original to unilib
        part_name = "cacao",
        description = S("Cacao Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_cacao_creeper_flowers", "cacaotree:flower_creeper", mode, {
        -- From cacaotree:flower_creeper
        description = S("Cacao Tree Creeper with Flowers"),
        tiles = {"unilib_tree_cacao_creeper_flowers.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_cacao_creeper_flowers.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_cacao_creeper_flowers.png",
    })

    unilib.register_node("unilib:tree_cacao_liana", "cacaotree:liana", mode, {
        -- From cacaotree:liana
        description = S("Cacao Tree Liana"),
        tiles = {"unilib_tree_cacao_liana.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_cacao_liana.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_cacao_liana.png",
    })

    unilib.register_node("unilib:tree_cacao_pod", "cacaotree:pod", mode, {
        -- From cacaotree:pod
        description = S("Cacao Pod"),
        tiles = {
            "unilib_tree_cacao_pod_top.png",
            "unilib_tree_cacao_pod_top.png^[transformFY",
            "unilib_tree_cacao_pod_right.png",
            "unilib_tree_cacao_pod_right.png^[transformFX",
            "unilib_tree_cacao_pod_front.png",
        },
        groups = {dig_immediate = 3, flammable = 2, fleshy = 3, leafdecay = 3, leafdecay_drop = 1},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        drop = "unilib:ingredient_cocoa_normal_beans 10",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, 0, 0.25, 0.0625, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        use_texture_alpha = "clip",
        walkable = false,
    })

    unilib.register_tree_trunk({
        -- From cacaotree:trunk. Creates unilib:tree_cacao_trunk
        part_name = "cacao",
        orig_name = "cacaotree:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Cacao Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From cacaotree:wood. Creates unilib:tree_cacao_wood
        part_name = "cacao",
        orig_name = "cacaotree:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Cacao Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From cacaotree:leaves. Creates unilib:tree_cacao_leaves
        part_name = "cacao",
        orig_name = "cacaotree:leaves",

        replace_mode = mode,
        description = S("Cacao Tree Leaves"),
        sapling_rarity = 12,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From cacaotree:leaves
        trunk_type = "cacao",
        trunks = {"unilib:tree_cacao_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_cacao_leaves"},
        others = {
            "unilib:tree_cacao_creeper_flowers",
            "unilib:tree_cacao_liana",
            "unilib:tree_cacao_pod",
        },
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From cacaotree:sapling. Creates unilib:tree_cacao_sapling
        part_name = "cacao",
        orig_name = "cacaotree:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Cacao Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From cacaotree:fence. Creates unilib:tree_cacao_wood_fence
        part_name = "cacao",
        orig_name = "cacaotree:fence",

        replace_mode = mode,
        base_img = "unilib_tree_cacao_wood.png",
        burnlevel = burnlevel,
        description = S("Cacao Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From cacaotree:fence_rail. Creates unilib:tree_cacao_wood_fence_rail
        part_name = "cacao",
        orig_name = "cacaotree:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_cacao_wood.png",
        burnlevel = burnlevel,
        description = S("Cacao Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From cacaotree:gate_closed, etc. Creates unilib:gate_cacao_closed, etc
        part_name = "cacao",
        orig_name = {"cacaotree:gate_closed", "cacaotree:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Cacao Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_cacao", {
        -- From cacaotree/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_cacao.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.001,
            persist = 0.66,
            scale = 0.001,
            seed = 6431,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = 1,
        rotation = "random",
        sidelen = 16,
    })

end
