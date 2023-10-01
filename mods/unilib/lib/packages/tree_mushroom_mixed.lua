---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
--
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mushroom_mixed = {}

local S = unilib.intllib
local farlands_add_mode = unilib.imported_mod_table.farlands.add_mode
local glem_add_mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mushroom_mixed.init()

    return {
        description = "Mixed mushroom tree nodes",
        notes = "Nodes in various colours for mixing and matching in your mushroom tree" ..
                " schematics. GLEMr11 provides a number of mixed mushroom schematics, e.g." ..
                " \"unilib_glem_tree_mushroom_mixed_blue\"",
    }

end

function unilib.pkg.tree_mushroom_mixed.exec()

    unilib.register_node(
        -- From farlands, mapgen:big_mushroom_stem
        "unilib:tree_mushroom_mixed_trunk",
        {"mapgen:big_mushroom_stem", "lib_ecology:mushroom_02_stem"},
        farlands_add_mode,
        {
            description = S("Mushroom Trunk"),
            tiles = {
                "unilib_tree_mushroom_mixed_trunk_top.png",
                "unilib_tree_mushroom_mixed_trunk_top.png",
                "unilib_tree_mushroom_mixed_trunk.png",
            },
            groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, wood = 1},
            sounds = unilib.sound_table.wood,

            paramtype2 = "facedir",

            on_place = minetest.rotate_node,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_blue
        "unilib:tree_mushroom_mixed_cap_blue",
        "lib_ecology:mushroom_cap_blue",
        glem_add_mode,
        {
            description = S("Blue Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_blue.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From farlands, mapgen:big_mushroom_brown
        "unilib:tree_mushroom_mixed_cap_brown",
        {"mapgen:big_mushroom_brown", "lib_ecology:mushroom_02_cap_brown"},
        farlands_add_mode,
        {
            description = S("Brown Mushroom Cap"),
            tiles = {
                "unilib_tree_mushroom_mixed_cap_brown.png",
                "unilib_tree_mushroom_mixed_pore.png",
                "unilib_tree_mushroom_mixed_cap_brown.png",
            },
            groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, wood = 1},
            sounds = unilib.sound_table.wood,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_brown_02
        "unilib:tree_mushroom_mixed_cap_brown_pale",
        "lib_ecology:mushroom_cap_brown_02",
        glem_add_mode,
        {
            description = S("Pale Brown Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_brown_pale.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_green_dk
        "unilib:tree_mushroom_mixed_cap_green_dark",
        "lib_ecology:mushroom_cap_green_dk",
        glem_add_mode,
        {
            description = S("Dark Green Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_green_dark.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_green_lt
        "unilib:tree_mushroom_mixed_cap_green_light",
        "lib_ecology:mushroom_cap_green_lt",
        glem_add_mode,
        {
            description = S("Light Green Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_green_light.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_green_spotted
        "unilib:tree_mushroom_mixed_cap_green_spotted",
        "lib_ecology:mushroom_cap_green_spotted",
        glem_add_mode,
        {
            description = S("Spotted Green Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_green_spotted.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_mottled
        "unilib:tree_mushroom_mixed_cap_mottled",
        "lib_ecology:mushroom_cap_mottled",
        glem_add_mode,
        {
            description = S("Mottled Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_mottled.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_purple
        "unilib:tree_mushroom_mixed_cap_purple",
        "lib_ecology:mushroom_cap_purple",
        glem_add_mode,
        {
            description = S("Purple Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_purple.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From farlands, mapgen:big_mushroom_red
        "unilib:tree_mushroom_mixed_cap_red",
        {"mapgen:big_mushroom_red", "lib_ecology:mushroom_02_cap_red"},
        farlands_add_mode,
        {
            description = S("Red Mushroom Cap"),
            tiles = {
                "unilib_tree_mushroom_mixed_cap_red.png",
                "unilib_tree_mushroom_mixed_pore.png",
                "unilib_tree_mushroom_mixed_cap_red.png",
            },
            groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand = 1, wood = 1},
            sounds = unilib.sound_table.wood,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_red_02
        "unilib:tree_mushroom_mixed_cap_red_dark",
        "lib_ecology:mushroom_cap_red_02",
        glem_add_mode,
        {
            description = S("Dark Red Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_red_dark.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_cap_tan
        "unilib:tree_mushroom_mixed_cap_tan",
        "lib_ecology:mushroom_cap_tan",
        glem_add_mode,
        {
            description = S("Tan Mushroom Cap"),
            tiles = {"unilib_tree_mushroom_mixed_cap_tan.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_spore_02
        "unilib:tree_mushroom_mixed_pore",
        "lib_ecology:mushroom_spore_02",
        glem_add_mode,
        {
            description = S("Mushroom Pore"),
            tiles = {"unilib_tree_mushroom_mixed_pore.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

    unilib.register_node(
        -- From GLEMr11, lib_ecology:mushroom_spore_03
        "unilib:tree_mushroom_mixed_pore_pale",
        "lib_ecology:mushroom_spore_03",
        glem_add_mode,
        {
            description = S("Pale Mushroom Pore"),
            tiles = {"unilib_tree_mushroom_mixed_pore_pale.png"},
            groups = {choppy = 1, flammable = 2, tree = 1},
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            is_ground_content = false,
            paramtype2 = "facedir",
            paramtype = "light",
            walkable = true,
        }
    )

end
