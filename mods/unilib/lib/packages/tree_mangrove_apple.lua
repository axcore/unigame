---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mangrove_apple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mangrove_apple.init()

    return {
        description = "Mangrove apple tree",
        notes = "Produces mangrove apples",
        depends = "fruit_mangrove_apple",
    }

end

function unilib.pkg.tree_mangrove_apple.exec()

    -- (no burnlevel)
    local sci_name = "Sonneratia caseolaris"

    unilib.register_tree({
        -- Original to unilib
        part_name = "mangrove_apple",
        description = S("Mangrove Apple Tree Wood"),
    })

    unilib.register_node(
        -- From australia:mangrove_apple_tree
        "unilib:tree_mangrove_apple_trunk",
        "australia:mangrove_apple_tree",
        mode,
        {
            description = unilib.annotate(S("Mangrove Apple Tree Trunk"), sci_name),
            tiles = {
                "unilib_tree_mangrove_apple_trunk_top.png",
                "unilib_tree_mangrove_apple_trunk_top.png",
                "unilib_tree_mangrove_apple_trunk.png",
            },
            groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
            sounds = unilib.sound_table.wood,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
            },
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
            },

            on_place = minetest.rotate_node,
        }
    )

    unilib.register_tree_wood({
        -- From australia:mangrove_apple_wood. Creates unilib:tree_mangrove_apple_wood
        part_name = "mangrove_apple",
        orig_name = "australia:mangrove_apple_wood",

        replace_mode = mode,
        description = S("Mangrove Apple Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:mangrove_apple_leaves. Creates unilib:tree_mangrove_apple_leaves
        part_name = "mangrove_apple",
        orig_name = "australia:mangrove_apple_leaves",

        replace_mode = mode,
        description = S("Mangrove Apple Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_leafdecay({
        -- From australia:mangrove_apple_leaves
        trunks = {"unilib:tree_mangrove_apple_trunk"},
        leaves = {"unilib:tree_mangrove_apple_leaves", "unilib:fruit_mangrove_apple"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From australia:mangrove_apple_sapling. Creates unilib:tree_mangrove_apple_sapling
        part_name = "mangrove_apple",
        orig_name = "australia:mangrove_apple_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mangrove Apple Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 5, y = 11, z = 5},
        minp_table = {x = -5, y = 1, z = -5},
        schem_list = {
            {"unilib_tree_mangrove_apple_1", 3, 1, 3},
            {"unilib_tree_mangrove_apple_2", 4, 1, 4},
            {"unilib_tree_mangrove_apple_3", 5, 1, 5},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_mangrove_apple_wood. Creates unilib:tree_mangrove_apple_wood_fence
        part_name = "mangrove_apple",
        orig_name = "australia:fence_mangrove_apple_wood",

        replace_mode = mode,
        base_img = "unilib_tree_mangrove_apple_wood.png",
        description = S("Mangrove Apple Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_mangrove_apple_wood_fence_rail
        part_name = "mangrove_apple",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_mangrove_apple_wood.png",
        description = S("Mangrove Apple Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_mangrove_apple_closed
        part_name = "mangrove_apple",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Mangrove Apple Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 3 do

        unilib.register_decoration("australia_tree_mangrove_apple_in_mangroves_" .. i, {
            -- From australia/biome_mangroves.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_mangrove_apple_" .. i .. ".mts",

            fill_ratio = (3 - i + 1) / 5000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
