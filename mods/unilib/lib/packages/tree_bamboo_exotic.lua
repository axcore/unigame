---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_bamboo_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_bamboo_exotic.init()

    return {
        description = "Exotic bamboo tree",
    }

end

function unilib.pkg.tree_bamboo_exotic.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "bamboo_exotic",
        description = S("Exotic Bamboo Tree Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_bamboo_exotic_trunk", "mapgen:bamboo", mode, {
        -- From farlands, mapgen:bamboo
        description = S("Exotic Bamboo Tree Stalk"),
        tiles = {
            "unilib_tree_bamboo_exotic_trunk_top.png",
            "unilib_tree_bamboo_exotic_trunk_top.png",
            "unilib_tree_bamboo_exotic_trunk.png",
        },
        groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
            },
        },
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
                {-0.5, -0.5, 0, 0.5, 0.5, 0},
                {0.00470524, -0.5, -0.5, 0.00470524, 0.5, 0.5},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
            },
        },
        sunlight_propagates = false,
        use_texture_alpha = "clip",
        walkable = true,
    })

    -- (Near the top of the stalk, leaves start to appear)
    unilib.register_node(
        -- From farlands, mapgen:bamboo_with_leaves
        "unilib:tree_bamboo_exotic_trunk_leafy",
        "mapgen:bamboo_with_leaves",
        mode,
        {
            description = S("Exotic Bamboo Tree Stalk"),
            tiles = {
                "unilib_tree_bamboo_exotic_trunk_top.png",
                "unilib_tree_bamboo_exotic_trunk_top.png",
                "unilib_tree_bamboo_exotic_leaves.png^unilib_tree_bamboo_exotic_trunk.png",
            },
            groups = {choppy = 1, flammable = 1, leaves = 1, oddly_breakable_by_hand = 1, tree = 1},
            sounds = unilib.sound_table.wood,

            collision_box = {
                type = "fixed",
                fixed = {
                    {-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
                }
            },
            drawtype = "nodebox",
            drop = "unilib:tree_bamboo_exotic_trunk",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
                    {-0.5, -0.5, 0, 0.5, 0.5, 0},
                    {0.00470524, -0.5, -0.5, 0.00470524, 0.5, 0.5},
                },
            },
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
                },
            },
            sunlight_propagates = false,
            use_texture_alpha = "clip",
        }
    )

    unilib.register_node("unilib:tree_bamboo_exotic_wood", "mapgen:bamboo_wood", mode, {
        -- From mapgen:bamboo_wood
        description = S("Exotic Bamboo Tree Wood Planks"),
        tiles = {"unilib_tree_bamboo_exotic_wood.png"},
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
        -- N.B. stone in the original code
        sounds = unilib.sound_table.wood,

        -- N.B. Not in original code
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From mapgen:bamboo_wood
        output = "unilib:tree_bamboo_exotic_wood 4",
        recipe = {
            {"unilib:tree_bamboo_exotic_trunk"},
        },
    })
    unilib.register_craft({
        -- From mapgen:bamboo_wood
        output = "unilib:tree_bamboo_exotic_wood 4",
        recipe = {
            {"unilib:tree_bamboo_exotic_trunk_leafy"},
        },
    })
    unilib.set_auto_rotate("unilib:tree_bamboo_exotic_wood", unilib.auto_rotate_wood_flag)

    local inv_img = unilib.filter_leaves_img("unilib_tree_bamboo_exotic_leaves.png")
    unilib.register_node(
        -- From mapgen:bamboo_leaves
        "unilib:tree_bamboo_exotic_leaves",
        "mapgen:bamboo_leaves",
        mode,
        {
            description = S("Exotic Bamboo Tree Leaves"),
            tiles = {"unilib_tree_bamboo_exotic_leaves.png"},
            groups = {flammable = 1, leafdecay = 4, leaves = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:tree_bamboo_exotic_sapling", rarity = 20}},
                    {items = {"unilib:tree_bamboo_exotic_leaves"}},
                },
            },
            inventory_image = inv_img,
            is_ground_content = false,
            paramtype = "light",
            sunlight_propagates = false,
            use_texture_alpha = "clip",
            waving = 1,
            wield_img = inv_img,

            after_place_node = unilib.after_place_leaves,
        }
    )
    unilib.register_leafdecay({
        -- From mapgen:bamboo_leaves
        trunks = {"unilib:tree_bamboo_exotic_trunk", "unilib:tree_bamboo_exotic_trunk_leafy"},
        leaves = {"unilib:tree_bamboo_exotic_leaves"},
        radius = 1,
    })

    unilib.register_tree_sapling({
        -- From farlands, default:bamboo_sapling. Creates unilib:tree_bamboo_exotic_sapling
        part_name = "bamboo_exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Bamboo Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        schem_list = {
            {"unilib_tree_bamboo_exotic_1"},
            {"unilib_tree_bamboo_exotic_2"},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    -- N.B. This function call creates a standard craft recipe for fences, replacing the eccentric
    --      ones used in the original code
    unilib.register_fence_quick({
        -- From farlands, decoblocks:bamboo_fence. Creates unilib:tree_bamboo_exotic_wood_fence
        part_name = "bamboo_exotic",
        orig_name = "decoblocks:bamboo_fence",

        replace_mode = mode,
        description = S("Exotic Bamboo Tree Wood Fence"),
        -- N.B. Replaced eccentric farlands groups with standard groups
--      groups = {choppy = 1, fence = 1, oddly_breakable_by_hand = 1},
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
        -- N.B. Original code's ingredients were stalks (normal and leafy)
        ingredient = "unilib:tree_bamboo_exotic_block",
    })
    unilib.override_item("unilib:tree_bamboo_exotic_wood_fence", {
        use_texture_alpha = "clip",
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_bamboo_exotic_wood_fence_rail
        part_name = "bamboo_exotic",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_bamboo_exotic_wood.png",
        description = S("Exotic Bamboo Tree Wood Fence Rail"),
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        -- N.B. Original code's ingredients were stalks (normal and leafy)
        ingredient = "unilib:tree_bamboo_exotic_block",
    })

    unilib.register_fence_gate_quick({
        -- From farlands, doors:gate_bamboo. Creates unilib:gate_bamboo_exotic_closed
        part_name = "bamboo_exotic",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Exotic Bamboo Tree Wood Fence Gate"),
        -- N.B. door = 1 omitted from original code
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        -- N.B. Original code's ingredients were stalks (normal and leafy)
        ingredient = "unilib:tree_bamboo_exotic_block",
    })

    unilib.register_node(
        -- From farlands, decoblocks:bamboo_block
        "unilib:tree_bamboo_exotic_block",
        "decoblocks:bamboo_block",
        mode,
        {
            description = S("Exotic Bamboo Tree Block"),
            tiles = {
                "unilib_tree_bamboo_exotic_block_top.png",
                "unilib_tree_bamboo_exotic_block_top.png",
                "unilib_tree_bamboo_exotic_block.png",
            },
            groups = {choppy = 1, oddly_breakable_by_hand = 2, wood = 1},
            sounds = unilib.sound_table.wood,

            paramtype2 = "facedir",

            on_place = minetest.rotate_node,
        }
    )
    unilib.register_craft_2x2x4({
        -- From farlands, mapgen/mapgen.lua
        output = "unilib:tree_bamboo_exotic_block",
        ingredient = "unilib:tree_bamboo_exotic_trunk",
    })
    unilib.register_craft_2x2x4({
        -- Original to unilib
        output = "unilib:tree_bamboo_exotic_block",
        ingredient = "unilib:tree_bamboo_exotic_trunk_leafy",
    })

    for i = 1, 2 do

        unilib.register_decoration("farlands_tree_bamboo_exotic_" .. i, {
            -- From farlands, mapgen/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_bamboo_exotic_" .. i .. ".mts",

            flags = "place_center_x, place_center_z",
            noise_params = {
                octaves = 3,
                offset = 0.016,
                persist = 0.66,
                scale = 0.022,
                seed = 2,
                spread = {x = 250, y = 250, z = 250},
            },
            sidelen = 16,
        })

    end

end
