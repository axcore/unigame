---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mulga = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mulga.init()

    return {
        description = "Mulga tree",
    }

end

function unilib.pkg.tree_mulga.exec()

    local burnlevel = 2
    local sci_name = "Acacia aneura"

    local node_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "mulga",
        description = S("Mulga Wood"),

        slim_flag = true,
    })

    unilib.register_node("unilib:tree_mulga_trunk", "australia:mulga_tree", mode, {
        -- From australia:mulga_tree
        description = unilib.utils.annotate(S("Mulga Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_mulga_trunk_top.png",
            "unilib_tree_mulga_trunk_top.png",
            "unilib_tree_mulga_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        selection_box = node_box,

        on_place = core.rotate_node,
    })

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_mulga_trunk_stripped
        part_name = "mulga",
        orig_name = nil,

        replace_mode = mode,
        description = S("Mulga Tree Trunk"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    unilib.register_tree_wood({
        -- From australia:mulga_wood. Creates unilib:tree_mulga_wood
        part_name = "mulga",
        orig_name = "australia:mulga_wood",

        replace_mode = mode,
        description = S("Mulga Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From australia:mulga_leaves. Creates unilib:tree_mulga_leaves
        part_name = "mulga",
        orig_name = "australia:mulga_leaves",

        replace_mode = mode,
        description = S("Mulga Tree Leaves"),
        sapling_rarity = 50,
        sci_name = sci_name,
        visual_scale = 1.3,
    })
    unilib.register_quick_tree_leafdecay("mulga")

    unilib.register_tree_sapling({
        -- From australia:mulga_sapling. Creates unilib:tree_mulga_sapling
        part_name = "mulga",
        orig_name = "australia:mulga_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mulga Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 4, y = 12, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        schem_list = {
            {"unilib_tree_mulga_1", 3, 1, 3},
            {"unilib_tree_mulga_2", 4, 1, 4},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From australia:fence_mulga_wood. Creates unilib:tree_mulga_wood_fence
        part_name = "mulga",
        orig_name = "australia:fence_mulga_wood",

        replace_mode = mode,
        base_img = "unilib_tree_mulga_wood.png",
        description = S("Mulga Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- Original to unilib. Creates unilib:tree_mulga_wood_fence_rail
        part_name = "mulga",
        orig_name = nil,

        replace_mode = mode,
        base_img = "unilib_tree_mulga_wood.png",
        description = S("Mulga Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- Original to unilib. Creates unilib:gate_mulga_closed, etc
        part_name = "mulga",
        orig_name = {nil, nil},

        replace_mode = mode,
        description = S("Mulga Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("australia_tree_mulga_in_mulga_lands_" .. i, {
            -- From australia/biome_mulga_lands.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_mulga_" .. i .. ".mts",

            fill_ratio = (2 - i + 1) / 4000,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 80,
        })

    end

end
