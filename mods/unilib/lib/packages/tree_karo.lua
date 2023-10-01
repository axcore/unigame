---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_karo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_karo.init()

    return {
        description = "Karo tree",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_karo.exec()

    -- (no burnlevel)
    local sci_name = "Pittosporum crassifolium"

    unilib.register_tree({
        -- Original to unilib
        part_name = "karo",
        description = S("Karo Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_karo_trunk", "aotearoa:karo_tree", mode, {
        -- From aotearoa:karo_tree
        description = unilib.annotate(S("Karo Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_karo_trunk_top.png",
            "unilib_tree_karo_trunk_top.png",
            "unilib_tree_karo_trunk.png",
        },
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/6, -1/2, -1/6, 1/6, 1/2, 1/6},
        },
        use_texture_alpha = "clip",
    })
    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:karo_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_karo_trunk"},
            },
        })

    end

    -- (no wood; instead, trunks can be crafted into sticks)

    unilib.register_tree_leaves({
        -- From aotearoa:karo_leaves. Creates unilib:tree_karo_leaves
        part_name = "karo",
        orig_name = "aotearoa:karo_leaves",

        replace_mode = mode,
        description = S("Karo Tree Leaves"),
        sapling_rarity = 30,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("karo", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:karo_sapling. Creates unilib:tree_karo_sapling
        part_name = "karo",
        orig_name = "aotearoa:karo_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Karo Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_karo_1", 2, 1, 2},
            {"unilib_tree_karo_2", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_decoration("aotearoa_tree_karo_clump_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_karo_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.01,
            seed = 120140,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_karo_clump_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_karo_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.01,
            seed = 304525,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_karo_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_karo_" .. i .. ".mts",

            fill_ratio = 0.01,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
