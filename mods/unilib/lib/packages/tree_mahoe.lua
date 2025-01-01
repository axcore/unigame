---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mahoe = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mahoe.init()

    return {
        description = "Mahoe tree",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_mahoe.exec()

    local burnlevel = 3
    local sci_name = "Melicytus ramiflorus"

    local node_box = {
        type = "fixed",
        fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "mahoe",
        description = S("Mahoe Wood"),

        not_super_flag = true,
        slim_flag = true,
    })

    unilib.register_node("unilib:tree_mahoe_trunk", "aotearoa:mahoe_tree", mode, {
        -- From aotearoa:mahoe_tree
        description = unilib.utils.annotate(S("Mahoe Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_mahoe_trunk_top.png",
            "unilib_tree_mahoe_trunk_top.png",
            "unilib_tree_mahoe_trunk.png",
        },
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = node_box,
        use_texture_alpha = "clip",

        -- N.B. no .on_place in original code
        on_place = core.rotate_node,
    })
    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:mahoe_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_mahoe_trunk"},
            },
        })

    end

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_mahoe_trunk_stripped
        part_name = "mahoe",
        orig_name = nil,

        replace_mode = mode,
        description = S("Mahoe Tree Trunk"),
        group_table = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    -- (no wood; instead, trunks can be crafted into sticks)

    unilib.register_tree_leaves({
        -- From aotearoa:mahoe_leaves. Creates unilib:tree_mahoe_leaves
        part_name = "mahoe",
        orig_name = "aotearoa:mahoe_leaves",

        replace_mode = mode,
        description = S("Mahoe Tree Leaves"),
        sapling_rarity = 30,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("mahoe", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:mahoe_sapling. Creates unilib:tree_mahoe_sapling
        part_name = "mahoe",
        orig_name = "aotearoa:mahoe_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Mahoe Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. Original code's {2, 1, 2} must be adjusted for our schematics
        schem_list = {
            {"unilib_tree_mahoe_1", 2, 0, 2},
            {"unilib_tree_mahoe_2", 2, 0, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_tree_mahoe_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_mahoe_" .. i .. ".mts",

            fill_ratio = 0.01,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration_generic("aotearoa_tree_mahoe_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_mahoe_" .. i .. ".mts",

            fill_ratio = 0.001,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
