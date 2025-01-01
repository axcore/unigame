---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cherrytree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cherry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cherrytree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cherry.init()

    return {
        description = "Cherry tree",
        notes = "Produces cherries",
        depends = "fruit_cherry",
    }

end

function unilib.pkg.tree_cherry.exec()

    local burnlevel = 3
    local sci_name = "Prunus avium"

    unilib.register_tree({
        -- Original to unilib
        part_name = "cherry",
        description = S("Cherry Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From cherrytree:trunk. Creates unilib:tree_cherry_trunk
        part_name = "cherry",
        orig_name = "cherrytree:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Cherry Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From cherrytree:wood. Creates unilib:tree_cherry_wood
        part_name = "cherry",
        orig_name = "cherrytree:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Cherry Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    local inv_img = unilib.flora.filter_leaves_img("unilib_tree_cherry_leaves.png")
    unilib.register_node("unilib:tree_cherry_leaves", "cherrytree:blossom_leaves", mode, {
        -- From cherrytree:blossom_leaves
        description = unilib.utils.annotate(S("Cherry Tree Leaves"), sci_name),
        tiles = {"unilib_tree_cherry_leaves.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_cherry_sapling"}, rarity = 12},
                {items = {"unilib:tree_cherry_leaves"}},
            },
        },
        inventory_image = inv_img,
        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype = "light",
        -- N.B. visual_scale not in original code
        visual_scale = unilib.global.leaves_visual_scale,
        walkable = unilib.setting.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.flora.after_place_leaves,

        on_timer = function(pos)

            pos.y = pos.y - 1
            local node = core.get_node_or_nil(pos)
            if node and node.name == "air" then

                core.set_node(pos, {name = "unilib:fruit_cherry"})
                return false

            else

                return true

            end

        end
    })
    unilib.register_leafdecay({
        -- From cherrytree:blossom_leaves
        trunk_type = "cherry",
        trunks = {"unilib:tree_cherry_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_cherry_leaves"},
        others = {"unilib:fruit_cherry"},
        radius = 3,
    })
    unilib.register_tree_leaves_compacted("unilib:tree_cherry_leaves", mode)

    unilib.register_tree_sapling({
        -- From cherrytree:sapling. Creates unilib:tree_cherry_sapling
        part_name = "cherry",
        orig_name = "cherrytree:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Cherry Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 0, 2},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From cherrytree:fence. Creates unilib:tree_cherry_wood_fence
        part_name = "cherry",
        orig_name = "cherrytree:fence",

        replace_mode = mode,
        base_img = "unilib_tree_cherry_wood.png",
        burnlevel = burnlevel,
        description = S("Cherry Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From cherrytree:fence_rail. Creates unilib:tree_cherry_wood_fence_rail
        part_name = "cherry",
        orig_name = "cherrytree:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_cherry_wood.png",
        burnlevel = burnlevel,
        description = S("Cherry Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From cherrytree:gate_closed, etc. Creates unilib:gate_cherry_closed, etc
        part_name = "cherry",
        orig_name = {"cherrytree:gate_closed", "cherrytree:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Cherry Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_cherry", {
        -- From cherrytree/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_cherry.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.00005,
            seed = 1242,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
