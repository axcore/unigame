---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/chestnuttree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_chestnut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.chestnuttree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_chestnut.init()

    return {
        description = "Chestnut tree",
        notes = "Produces chestnut tree burs",
    }

end

function unilib.pkg.tree_chestnut.exec()

    local burnlevel = 3
    local sci_name = "Castanea"

    unilib.register_tree({
        -- Original to unilib
        part_name = "chestnut",
        description = S("Chestnut Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_chestnut_bur", "chestnuttree:bur", mode, {
        -- From chestnuttree:bur
        description = S("Chestnut Tree Bur"),
        tiles = {"unilib_tree_chestnut_bur.png"},
        -- N.B. no food_chestnut in original code
        groups = {
            dig_immediate = 3, flammable = 2, fleshy = 3, food_chestnut = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_tree_chestnut_bur.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,

        after_place_node = function(pos, placer, itemstack)
            minetest.set_node(pos, {name = "unilib:tree_chestnut_bur", param2 = 1})
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:tree_chestnut_bur", 2),
    })

    unilib.register_tree_trunk({
        -- From chestnuttree:trunk. Creates unilib:tree_chestnut_trunk
        part_name = "chestnut",
        orig_name = "chestnuttree:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Chestnut Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From chestnuttree:wood. Creates unilib:tree_chestnut_wood
        part_name = "chestnut",
        orig_name = "chestnuttree:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Chestnut Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From chestnuttree:leaves. Creates unilib:tree_chestnut_leaves
        part_name = "chestnut",
        orig_name = "chestnuttree:leaves",

        replace_mode = mode,
        description = S("Chestnut Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From chestnuttree:leaves
        trunks = {"unilib:tree_chestnut_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_chestnut_leaves", "unilib:tree_chestnut_bur"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From chestnuttree:sapling. Creates unilib:tree_chestnut_sapling
        part_name = "chestnut",
        orig_name = "chestnuttree:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Chestnut Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {6, 0, 6},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From chestnuttree:fence. Creates unilib:tree_chestnut_wood_fence
        part_name = "chestnut",
        orig_name = "chestnuttree:fence",

        replace_mode = mode,
        base_img = "unilib_tree_chestnut_wood.png",
        burnlevel = burnlevel,
        description = S("Chestnut Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From chestnuttree:fence_rail. Creates unilib:tree_chestnut_wood_fence_rail
        part_name = "chestnut",
        orig_name = "chestnuttree:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_chestnut_wood.png",
        burnlevel = burnlevel,
        description = S("Chestnut Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From chestnuttree:gate. Creates unilib:gate_chestnut_closed
        part_name = "chestnut",
        orig_name = {"chestnuttree:gate_closed", "chestnuttree:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Chestnut Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_chestnut", {
        -- From chestnuttree/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_chestnut.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.00005,
            persist = 0.66,
            scale = 0.00004,
            seed = 278,
            spread = {x = 250, y = 250, z = 250},
        },
        place_offset_y = 1,
        rotation = "random",
        sidelen = 16,
    })

end
