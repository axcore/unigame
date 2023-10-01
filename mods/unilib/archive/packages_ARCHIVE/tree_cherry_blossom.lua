---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
        minetest.register_node("lib_ecology:tree_cherry_blossom_trunk", {
            description = S("cherry_blossom Trunk"),
            drawtype = "nodebox",
            tiles = {"lib_ecology_tree_cherry_blossom_trunk_top.png", "lib_ecology_tree_cherry_blossom_trunk_top.png", "lib_ecology_tree_cherry_blossom_trunk.png"},
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            walkable = true,
            is_ground_content = false,
            groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
            sounds = default.node_sound_wood_defaults(),
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, -- Trunk
                }
            },
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, -- Trunk
                }
            },

            on_place = minetest.rotate_node
        })
        minetest.register_node("lib_ecology:tree_cherry_blossom_wood", {
            description = S("cherry_blossom Wood Planks"),
            paramtype2 = "facedir",
            place_param2 = 0,
            tiles = {"lib_ecology_tree_cherry_blossom_wood.png"},
            is_ground_content = false,
            groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
            sounds = default.node_sound_wood_defaults(),
        })
        minetest.register_node("lib_ecology:tree_cherry_blossom_leaves", {
            description = S("cherry_blossom Leaves"),
            drawtype = "allfaces_optional",
            tiles = {"lib_ecology_tree_cherry_blossom_leaves.png"},
--          special_tiles = {"lib_ecology_tree_cherry_blossom_leaves_simple.png"},
            paramtype = "light",
            waving = 1,
            walkable = false,
            is_ground_content = false,
            groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
            drop = {
                max_items = 1,
                items = {
                    {items = {"lib_ecology:tree_cherry_blossom_leaves"}},
                    {items = {"lib_ecology:tree_cherry_blossom_sapling"}, rarity = 20},
                    {items = {"lib_ecology:stick"}, rarity = 10},
                }
            },
            sounds = default.node_sound_leaves_defaults(),

            after_place_node = default.after_place_leaves,
        })
        minetest.register_node("lib_ecology:tree_cherry_blossom_sapling", {
            description = S("cherry_blossom Tree Sapling"),
            drawtype = "plantlike",
            tiles = {"lib_ecology_tree_cherry_blossom_sapling.png"},
            paramtype = "light",
            sunlight_propagates = true,
            walkable = false,
            on_timer = default.grow_sapling,
            selection_box = {
                type = "fixed",
                fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
            },
            groups = {snappy = 2, dig_immediate = 3, flammable = 2, attached_node = 1, sapling = 1},
            sounds = default.node_sound_leaves_defaults(),

            on_construct = function(pos)
                minetest.get_node_timer(pos):start(math.random(2400,4800))
            end,

            on_place = function(itemstack, placer, pointed_thing)
                itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
                    "lib_ecology:tree_cherry_blossom_sapling",
                    -- minp, maxp to be checked, relative to sapling pos
                    -- minp_relative.y = 1 because sapling pos has been checked
                    {x = -4, y = 1, z = -4},
                    {x = 4, y = 6, z = 4},
                    -- maximum interval of interior volume check
                    4)

                return itemstack
            end,
        })
        minetest.register_craft({
            output = 'lib_ecology:tree_cherry_blossom_wood 4',
            recipe = {
                {'lib_ecology:tree_cherry_blossom_trunk'},
            }
        })
]]--
