---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_manuka = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_manuka.init()

    return {
        description = "Manuka tree",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_manuka.exec()

    local burnlevel = 5
    local sci_name = "Leptospermum scoparium"

    local node_box = {
        type = "fixed",
        fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
    }

    unilib.register_tree({
        -- Original to unilib
        part_name = "manuka",
        description = S("Manuka Wood"),

        not_super_flag = true,
        slim_flag = true,
    })

    unilib.register_node("unilib:tree_manuka_trunk", "aotearoa:manuka_tree", mode, {
        -- From aotearoa:manuka_tree
        description = unilib.utils.annotate(S("Manuka Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_manuka_trunk_top.png",
            "unilib_tree_manuka_trunk_top.png",
            "unilib_tree_manuka_trunk.png",
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
            -- From aotearoa:manuka_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_manuka_trunk"},
            },
        })

    end

    unilib.register_tree_trunk_stripped({
        -- Original to unilib. Creates unilib:tree_manuka_trunk_stripped
        part_name = "manuka",
        orig_name = nil,

        replace_mode = mode,
        description = S("Manuka Tree Trunk"),
        group_table = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        node_box = node_box,
    })

    -- (no wood; instead, trunks can be crafted into sticks)

    unilib.register_tree_leaves({
        -- From aotearoa:manuka_leaves. Creates unilib:tree_manuka_leaves
        part_name = "manuka",
        orig_name = "aotearoa:manuka_leaves",

        replace_mode = mode,
        description = S("Manuka Tree Leaves"),
        group_table = {flammable = 2, flower = 1, leaves = 1, leafdecay = 1, snappy = 3},
        sapling_rarity = 30,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("manuka", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:manuka_sapling. Creates unilib:tree_manuka_sapling
        part_name = "manuka",
        orig_name = "aotearoa:manuka_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Manuka Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. Original code's {2, 1, 2} must be adjusted for our schematics
        schem_list = {
            {"unilib_tree_manuka_1", 2, 0, 2},
            {"unilib_tree_manuka_2", 2, 0, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_decoration_generic("aotearoa_tree_manuka_clump_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_manuka_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.8,
            scale = 0.03,
            seed = 1646630,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration_generic("aotearoa_tree_manuka_clump_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_manuka_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.8,
            scale = 0.03,
            seed = 3121165,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration_generic("aotearoa_tree_manuka_rare_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_manuka_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.95,
            scale = 0.01,
            seed = 1622230,
            spread = {x = 128, y = 128, z = 128},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration_generic("aotearoa_tree_manuka_rare_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_manuka_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.95,
            scale = 0.01,
            seed = 1125565,
            spread = {x = 128, y = 128, z = 128},
        },
        rotation = "random",
        sidelen = 8,
    })
    for i = 1, 2 do
        unilib.register_decoration_generic("aotearoa_tree_manuka_dense_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_manuka_" .. i .. ".mts",

            fill_ratio = 0.1,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end
    unilib.register_decoration_generic("aotearoa_tree_manuka_leaves", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:tree_manuka_leaves",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.1,
            scale = 0.95,
            seed = 8787761,
            spread = {x = 16, y = 16, z = 16},
        },
        sidelen = 16,
    })

end
