---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mangrove_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mangrove_white.init()

    return {
        description = "White mangrove tree",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.tree_mangrove_white.exec()

    -- (no burnlevel)
    local sci_name = "Avicennia marina"

    unilib.register_tree({
        -- Original to unilib
        part_name = "mangrove_white",
        description = S("White Mangrove Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_mangrove_white_trunk", "aotearoa:mangrove_white_tree", mode, {
        -- From aotearoa:mangrove_white_tree
        description = unilib.annotate(S("White Mangrove Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_mangrove_white_trunk_top.png",
            "unilib_tree_mangrove_white_trunk_top.png",
            "unilib_tree_mangrove_white_trunk.png",
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
    })
    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:mangrove_white_tree
            output = "unilib:item_stick_ordinary 2",
            recipe = {
                {"unilib:tree_mangrove_white_trunk"},
            },
        })

    end

    -- (no wood; instead, trunks can be crafted into sticks)

    unilib.register_tree_leaves({
        -- From aotearoa:mangrove_white_leaves. Creates unilib:tree_mangrove_white_leaves
        part_name = "mangrove_white",
        orig_name = "aotearoa:mangrove_white_leaves",

        replace_mode = mode,
        description = S("White Mangrove Tree Leaves"),
        sapling_rarity = 30,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("mangrove_white", 2)

    unilib.register_tree_sapling({
        -- From aotearoa:mangrove_white_sapling. Creates unilib:tree_mangrove_white_sapling
        part_name = "mangrove_white",
        orig_name = "aotearoa:mangrove_white_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("White Mangrove Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. {2, 1, 2} in original code,  but that is not correct
        schem_list = {
            {"unilib_tree_mangrove_white_1", 7, 1, 7},
            {"unilib_tree_mangrove_white_2", 7, 1, 7},
        },
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_decoration("aotearoa_tree_mangrove_white_normal_1", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_mangrove_white_1.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.35,
            scale = 0.078,
            seed = 11712,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })
    unilib.register_decoration("aotearoa_tree_mangrove_white_normal_2", {
        -- From aotearoa/spawn_trees.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_mangrove_white_2.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.35,
            scale = 0.078,
            seed = 15874,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })

end
