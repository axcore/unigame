---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/maple
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_maple_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maple.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_maple_red.init()

    return {
        description = "Red maple tree",
    }

end

function unilib.pkg.tree_maple_red.exec()

    local burnlevel = 3
    local sci_name = "Acer rubrum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "maple_red",
        description = S("Red Maple Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From maple:trunk. Creates unilib:tree_maple_red_trunk
        part_name = "maple_red",
        orig_name = "maple:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Red Maple Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From maple:wood. Creates unilib:tree_maple_red_wood
        part_name = "maple_red",
        orig_name = "maple:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Red Maple Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From maple:leaves. Creates unilib:tree_maple_red_leaves
        part_name = "maple_red",
        orig_name = "maple:leaves",

        replace_mode = mode,
        description = S("Red Maple Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("maple_red")

    unilib.register_tree_sapling({
        -- From maple:sapling. Creates unilib:tree_maple_red_sapling
        part_name = "maple_red",
        orig_name = "maple:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Red Maple Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {3, 1, 3},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From maple:fence. Creates unilib:tree_maple_red_wood_fence
        part_name = "maple_red",
        orig_name = "maple:fence",

        replace_mode = mode,
        base_img = "unilib_tree_maple_red_wood.png",
        burnlevel = burnlevel,
        description = S("Red Maple Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From maple:fence_rail. Creates unilib:tree_maple_red_wood_fence_rail
        part_name = "maple_red",
        orig_name = "maple:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_maple_red_wood.png",
        burnlevel = burnlevel,
        description = S("Red Maple Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From maple:gate. Creates unilib:gate_maple_closed
        part_name = "maple_red",
        orig_name = {"maple:gate_closed", "maple:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Red Maple Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_maple_red", {
        -- From maple/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_maple_red.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0002,
            persist = 0.66,
            scale = 0.0002,
            seed = 3462,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
