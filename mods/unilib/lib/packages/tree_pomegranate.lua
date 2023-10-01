---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/pomegranate
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pomegranate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pomegranate.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pomegranate.init()

    return {
        description = "Pomegranate tree",
        notes = "Produces pomegranates",
        depends = "fruit_pomegranate",
        optional = "dirt_dry",
    }

end

function unilib.pkg.tree_pomegranate.exec()

    local burnlevel = 3
    local sci_name = "Punica granatum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pomegranate",
        description = S("Pomegranate Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_tree_trunk({
        -- From pomegranate:trunk. Creates unilib:tree_pomegranate_trunk
        part_name = "pomegranate",
        orig_name = "pomegranate:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Pomegranate Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From pomegranate:wood. Creates unilib:tree_pomegranate_wood
        part_name = "pomegranate",
        orig_name = "pomegranate:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Pomegranate Tree Wood Planks"),
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
    })

    unilib.register_tree_leaves({
        -- From pomegranate:leaves. Creates unilib:tree_pomegranate_leaves
        part_name = "pomegranate",
        orig_name = "pomegranate:leaves",

        replace_mode = mode,
        description = S("Pomegranate Tree Leaves"),
        sapling_rarity = 10,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From pomegranate:leaves
        trunks = {"unilib:tree_pomegranate_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_pomegranate_leaves", "unilib:fruit_pomegranate"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From pomegranate:sapling. Creates unilib:tree_pomegranate_sapling
        part_name = "pomegranate",
        orig_name = "pomegranate:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Pomegranate Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {1, 0, 1},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        -- N.B. In original code, can be grown on any dirt (but decorations only appear on sand)
        under_list = {"unilib:dirt_dry", "default:dry_dirt"},
    })

    unilib.register_fence_quick({
        -- From pomegranate:fence. Creates unilib:tree_pomegranate_wood_fence
        part_name = "pomegranate",
        orig_name = "pomegranate:fence",

        replace_mode = mode,
        base_img = "unilib_tree_pomegranate_wood.png",
        burnlevel = burnlevel,
        description = S("Pomegranate Tree Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From pomegranate:fence_rail. Creates unilib:tree_pomegranate_wood_fence_rail
        part_name = "pomegranate",
        orig_name = "pomegranate:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_pomegranate_wood.png",
        burnlevel = burnlevel,
        description = S("Pomegranate Tree Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From pomegranate:gate. Creates unilib:gate_pomegranate_closed
        part_name = "pomegranate",
        orig_name = {"pomegranate:gate_closed", "pomegranate:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Pomegranate Tree Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration("cool_trees_tree_pomegranate", {
        -- From pomegranate/init.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_pomegranate.mts",

        flags = "place_center_x, place_center_z, force_placement",
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.00004,
            seed = 978,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
