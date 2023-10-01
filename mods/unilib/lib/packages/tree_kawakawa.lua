---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_kawakawa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_kawakawa.init()

    return {
        description = "Kawakawa tree",
        notes = "Produces kawakawa fruit",
        depends = "fruit_kawakawa",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_kawakawa.exec()

    -- (no burnlevel)
    local sci_name = "Piper excelsum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "kawakawa",
        description = S("Kawakawa Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_kawakawa_trunk", "aotearoa:kawakawa_tree", mode, {
        -- From aotearoa:kawakawa_tree
        description = unilib.annotate(S("Kawakawa Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_kawakawa_trunk_top.png",
            "unilib_tree_kawakawa_trunk_top.png",
            "unilib_tree_kawakawa_trunk.png",
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
            -- From aotearoa:kawakawa_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_kawakawa_trunk"},
            },
        })

    end

    -- (no wood; instead, trunks can be crafted into sticks)

    unilib.register_tree_leaves({
        -- From aotearoa:kawakawa_leaves. Creates unilib:tree_kawakawa_leaves
        part_name = "kawakawa",
        orig_name = "aotearoa:kawakawa_leaves",

        replace_mode = mode,
        description = S("Kawakawa Tree Leaves"),
        sapling_rarity = 30,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From aotearoa:kawakawa_leaves
        trunks = {"unilib:tree_kawakawa_trunk"},
        leaves = {"unilib:tree_kawakawa_leaves", "unilib:fruit_kawakawa"},
        radius = 2,
    })

    unilib.register_tree_sapling({
        -- From aotearoa:kawakawa_sapling. Creates unilib:tree_kawakawa_sapling
        part_name = "kawakawa",
        orig_name = "aotearoa:kawakawa_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Kawakawa Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        schem_list = {
            {"unilib_tree_kawakawa_1", 2, 1, 2},
            {"unilib_tree_kawakawa_2", 2, 1, 2},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    for i = 1, 2 do

        unilib.register_decoration("aotearoa_tree_kawakawa_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_kawakawa_" .. i .. ".mts",

            fill_ratio = 0.01,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })
        unilib.register_decoration("aotearoa_tree_kawakawa_rare_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_tree_kawakawa_" .. i .. ".mts",

            fill_ratio = 0.001,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
