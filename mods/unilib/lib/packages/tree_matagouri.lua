---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_matagouri = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_matagouri.init()

    return {
        description = "Matagouri tree",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_matagouri.exec()

    local burnlevel = 2
    local sci_name = "Discaria toumatou"

    local node_box = {
        type = "fixed",
        fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "matagouri",
        description = S("Matagouri Wood"),

        not_super_flag = true,
        slim_flag = true,
    })

    unilib.register_node("unilib:tree_matagouri_trunk", "aotearoa:matagouri_tree", mode, {
        -- From aotearoa:matagouri_tree
        description = unilib.utils.annotate(S("Matagouri Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_matagouri_trunk_top.png",
            "unilib_tree_matagouri_trunk_top.png",
            "unilib_tree_matagouri_trunk.png",
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
            -- From aotearoa:matagouri_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_matagouri_trunk"},
            },
        })

    end

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_matagouri_trunk_stripped
        part_name = "matagouri",
        orig_name = nil,

        replace_mode = mode,
        description = S("Matagouri Tree Trunk"),
        group_table = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    -- (no wood; instead, trunks can be crafted into sticks)

    unilib.register_tree_leaves({
        -- From aotearoa:matagouri_leaves. Creates unilib:tree_matagouri_leaves
        part_name = "matagouri",
        orig_name = "aotearoa:matagouri_leaves",

        replace_mode = mode,
        description = S("Matagouri Tree Leaves"),
        sapling_rarity = 30,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("matagouri", 2)
    unilib.override_item("unilib:tree_matagouri_leaves", {
        damage_per_second = 1,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:matagouri_sapling. Creates unilib:tree_matagouri_sapling
        part_name = "matagouri",
        orig_name = "aotearoa:matagouri_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Matagouri Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. Original code's {2, 1, 2} must be adjusted for our schematics
        schem_list = {
            {"unilib_tree_matagouri_1", 2, 0, 2},
            {"unilib_tree_matagouri_2", 2, 0, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_decoration_generic("aotearoa_tree_matagouri_clump_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_matagouri_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.9,
            scale = 0.01,
            seed = 761090,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration_generic("aotearoa_tree_matagouri_clump_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_matagouri_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.9,
            scale = 0.01,
            seed = 413475,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })

end
