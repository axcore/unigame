---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pine_rottnest_island = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine_rottnest_island.init()

    return {
        description = "Rottnest Island pine tree",
    }

end

function unilib.pkg.tree_pine_rottnest_island.exec()

    -- (no burnlevel)
    local sci_name = "Callitris preissii"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine_rottnest_island",
        description = S("Rottnest Island Pine Wood"),
    })

    unilib.register_node(
        -- From australia:rottnest_island_pine_tree
        "unilib:tree_pine_rottnest_island_trunk",
        "australia:rottnest_island_pine_tree",
        mode,
        {
            description = unilib.annotate(S("Rottnest Island Pine Tree Trunk"), sci_name),
            tiles = {
                "unilib_tree_pine_rottnest_island_trunk_top.png",
                "unilib_tree_pine_rottnest_island_trunk_top.png",
                "unilib_tree_pine_rottnest_island_trunk.png",
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
        -- From australia:rottnest_island_pine_wood. Creates unilib:tree_pine_rottnest_island_wood
        part_name = "pine_rottnest_island",
        orig_name = "australia:rottnest_island_pine_wood",

        replace_mode = mode,
        description = S("Rottnest Island Pine Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:rottnest_island_pine_leaves. Creates
        --      unilib:tree_pine_rottnest_island_leaves
        part_name = "pine_rottnest_island",
        orig_name = "australia:rottnest_island_pine_leaves",

        replace_mode = mode,
        description = S("Rottnest Island Pine Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("pine_rottnest_island")

    unilib.register_tree_sapling({
        -- From australia:rottnest_island_pine_sapling. Creates
        --      unilib:tree_pine_rottnest_island_sapling
        part_name = "pine_rottnest_island",
        orig_name = "australia:rottnest_island_pine_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Rottnest Island Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 11, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_pine_rottnest_island_1", 2, 1, 2},
            {"unilib_tree_pine_rottnest_island_2", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_pine_rottnest_island_wood. Creates
        --      unilib:tree_pine_rottnest_island_wood_fence
        part_name = "pine_rottnest_island",
        orig_name = "australia:fence_pine_rottnest_island_wood",

        replace_mode = mode,
        base_img = "unilib_tree_pine_rottnest_island_wood.png",
        description = S("Rottnest Island Pine Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_pine_rottnest_island_wood_fence_rail
        part_name = "pine_rottnest_island",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_pine_rottnest_island_wood.png",
        description = S("Rottnest Island Pine Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_pine_rottnest_island_closed
        part_name = "pine_rottnest_island",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Rottnest Island Pine Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration("australia_tree_pine_rottnest_island_in_forests_" .. i, {
            -- From australia/biome_jarrah_karri_forests.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_pine_rottnest_island_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 10000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
