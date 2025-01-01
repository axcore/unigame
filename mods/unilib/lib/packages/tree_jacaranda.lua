---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/jacaranda
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_jacaranda = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.jacaranda.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jacaranda.init()

    return {
        description = "Jacaranda tree",
    }

end

function unilib.pkg.tree_jacaranda.exec()

    local burnlevel = 3
    local sci_name = "Jacaranda mimosifolia"

    unilib.register_tree({
        -- Original to unilib
        part_name = "jacaranda",
        description = S("Jacaranda Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From jacaranda:trunk. Creates unilib:tree_jacaranda_trunk
        part_name = "jacaranda",
        orig_name = "jacaranda:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Jacaranda Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From jacaranda:wood. Creates unilib:tree_jacaranda_wood
        part_name = "jacaranda",
        orig_name = "jacaranda:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Jacaranda Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From jacaranda:blossom_leaves. Creates unilib:tree_jacaranda_leaves
        part_name = "jacaranda",
        orig_name = "jacaranda:blossom_leaves",

        replace_mode = mode,
        description = S("Jacaranda Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("jacaranda")

    unilib.register_tree_sapling({
        -- From jacaranda:sapling. Creates unilib:tree_jacaranda_sapling
        part_name = "jacaranda",
        orig_name = "jacaranda:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Jacaranda Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {3, 0, 3},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_fence_quick({
        -- From jacaranda:fence. Creates unilib:tree_jacaranda_wood_fence
        part_name = "jacaranda",
        orig_name = "jacaranda:fence",

        replace_mode = mode,
        base_img = "unilib_tree_jacaranda_wood.png",
        burnlevel = burnlevel,
        description = S("Jacaranda Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From jacaranda:fence_rail. Creates unilib:tree_jacaranda_wood_fence_rail
        part_name = "jacaranda",
        orig_name = "jacaranda:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_jacaranda_wood.png",
        burnlevel = burnlevel,
        description = S("Jacaranda Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From jacaranda:gate_closed, etc. Creates unilib:gate_jacaranda_closed, etc
        part_name = "jacaranda",
        orig_name = {"jacaranda:gate_closed", "jacaranda:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Jacaranda Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_jacaranda", {
        -- From jacaranda/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_jacaranda.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.00005,
            seed = 663,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
