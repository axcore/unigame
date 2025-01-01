---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fern_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fern_yellow.init()

    return {
        description = "Yellow fern tree",
    }

end

function unilib.pkg.tree_fern_yellow.exec()

    local burnlevel = 2
    local sci_name = "Dicksonia"

    local node_box = {
        type = "fixed",
        fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "fern_yellow",
        description = S("Yellow Fern Tree Wood"),

        not_super_flag = true,
        slim_flag = true,
    })

    unilib.register_node("unilib:tree_fern_yellow_trunk", nil, mode, {
        -- Original to unilib
        description = unilib.utils.annotate(S("Yellow Fern Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_fern_yellow_trunk_top.png",
            "unilib_tree_fern_yellow_trunk_top.png",
            "unilib_tree_fern_yellow_trunk.png"
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1, wood = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        selection_box = node_box,
        use_texture_alpha = "clip",

        after_destruct = function(pos, oldnode)

            unilib.flora.collapse_slim_tree(
                pos,
                oldnode,
                {"unilib:tree_fern_yellow_trunk", "unilib:tree_fern_yellow_trunk_apex"}
            )

        end,

        -- N.B. no .on_place in original code
        on_place = core.rotate_node,
    })

    unilib.register_node("unilib:tree_fern_yellow_trunk_apex", nil, mode, {
        -- Original to unilib
        description = unilib.utils.annotate(S("Yellow Fern Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_fern_yellow_trunk_top.png^unilib_tree_fern_yellow_trunk_apex_overlay.png",
            "unilib_tree_fern_yellow_trunk_top.png^unilib_tree_fern_yellow_trunk_apex_overlay.png",
            "unilib_tree_fern_yellow_trunk.png"
        },
        groups = {
            choppy = 2, flammable = 2, leafdecay = 1, not_in_creative_inventory = 1,
            oddly_breakable_by_hand = 1, tree = 1, wood = 1,
        },
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        drop = "unilib:tree_fern_yellow_trunk",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-1/2, 33/64, -1/2, 1/2, 33/64, 1/2},
                {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
            },
        },
        paramtype = "light",
        selection_box = node_box,
        use_texture_alpha = "clip",
    })

    -- (no wood; instead, trunks can be crafted into sticks)

    unilib.register_node("unilib:tree_fern_yellow_crown_start", nil, mode, {
        -- Original to unilib, adapted from lib_ecology:plant_bananaplant2
        description = unilib.utils.annotate(S("Yellow Fern Tree Crown"), sci_name),
        tiles = {"unilib_tree_fern_yellow_crown_start.png"},
        groups = {
            attached_node = 1, flammable = 2, leafdecay = 1, leaves = 1,
            not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "mesh",
        -- N.B. Drop either 2 saplings, or 1 crown and 1 sapling
        drop = {
            max_items = 2,
            items = {
                {
                    items = {"unilib:tree_fern_yellow_sapling"},
                    rarity = 10,
                },
                {
                    items = {"unilib:tree_fern_yellow_sapling"},
                },
                {
                    items = {"unilib:tree_fern_yellow_crown_start"},
                },
            },
        },
        mesh = "unilib_plant_shrub_banana_large.b3d",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.6, 0.4},
        },
        use_texture_alpha = "clip",
        -- N.B. The highest possible value of .visual_scale that doesn't make the crown and leaves
        --      intersect each other
        visual_scale = 0.75,
        walkable = false,
    })

    unilib.register_node("unilib:tree_fern_yellow_crown_middle", nil, mode, {
        -- Original to unilib, adapted from lib_ecology:fern_giant_tree_leaves_2
        description = unilib.utils.annotate(S("Yellow Fern Tree Crown"), sci_name),
        tiles = {"unilib_tree_fern_yellow_crown_middle.png"},
        groups = {
            attached_node = 1, flammable = 2, leafdecay = 1, leaves = 1,
            not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "raillike",
        drop = "",
        paramtype = "light",
        walkable = false,

        -- (This callback causes the middle/end leaves to be destroyed, when the trunk is destroyed)
        after_destruct = function(pos, oldnode)

            for _, d in pairs(
                {{x = -1, z = 0}, {x = 1, z = 0}, {x = 0, z = -1}, {x = 0, z = 1}}
            ) do
                local node = core.get_node({x = pos.x + d.x, y = pos.y + 1, z = pos.z + d.z})
                if node.name == "unilib:tree_fern_yellow_crown_middle" then
                    core.dig_node({x = pos.x + d.x, y = pos.y + 1, z = pos.z + d.z})
                end

            end

        end,
    })

    unilib.register_node("unilib:tree_fern_yellow_crown_end", nil, mode, {
        -- Original to unilib, adapted from lib_ecology:fern_giant_tree_leaves_end_2
        description = unilib.utils.annotate(S("Yellow Fern Tree Crown"), sci_name),
        tiles = {"unilib_tree_fern_yellow_crown_end.png"},
        groups = {
            attached_node = 1, flammable = 2, leafdecay = 1, leaves = 1,
            not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        drop = "",
        node_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, 1/2, 1/2, 33/64, 1/2},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, 1/2, 1/2, 33/64, 1/2},
        },
        use_texture_alpha = "clip",
        walkable = false,
    })

    unilib.register_tree_sapling({
        -- Original to unilib. Creates unilib:tree_aspen_sapling
        part_name = "fern_yellow",
        orig_name = nil,

        replace_mode = mode,
        burnlevel = nil,
        common_group = 2,
        description = S("Yellow Fern Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 3, y = 7, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        schem_list = {
            {"unilib_glem_tree_fern_yellow", 3, 0, 3},
        },
        sci_name = sci_name,
        select_table = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
    })

end
