---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/baldcypress
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_cypress_bald = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.baldcypress.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_cypress_bald.init()

    return {
        description = "Bald cypress tree",
        optional = "sand_ordinary",
    }

end

function unilib.pkg.tree_cypress_bald.exec()

    local burnlevel = 3
    local sci_name = "Taxodium distichum"

    unilib.register_tree({
        -- Original to unilib
        part_name = "cypress_bald",
        description = S("Bald Cypress Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_cypress_bald_branches", "baldcypress:dry_branches", mode, {
        -- baldcypress:dry_branches
        description = S("Bald Cypress Tree Dry Branches"),
        tiles = {"unilib_tree_cypress_bald_branches.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_cypress_bald_branches.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,
        wield_image = "unilib_tree_cypress_bald_branches.png",
    })

    unilib.register_node("unilib:tree_cypress_bald_liana", "baldcypress:liana", mode, {
        -- From baldcypress:liana
        description = S("Bald Cypress Tree Liana"),
        tiles = {"unilib_tree_cypress_bald_liana.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_tree_cypress_bald_liana.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, 0.0, 0.25, 0.5, 0.0},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_tree_cypress_bald_liana.png",
    })

    unilib.register_tree_trunk({
        -- From baldcypress:trunk. Creates unilib:tree_cypress_bald_trunk
        part_name = "cypress_bald",
        orig_name = "baldcypress:trunk",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Bald Cypress Tree Trunk"),
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From baldcypress:wood. Creates unilib:tree_cypress_bald_wood
        part_name = "cypress_bald",
        orig_name = "baldcypress:wood",

        replace_mode = mode,
        burnlevel = burnlevel,
        group_table = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
        description = S("Bald Cypress Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From baldcypress:leaves. Creates unilib:tree_cypress_bald_leaves
        part_name = "cypress_bald",
        orig_name = "baldcypress:leaves",

        replace_mode = mode,
        description = S("Bald Cypress Tree Leaves"),
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From baldcypress:leaves
        trunk_type = "cypress_bald",
        trunks = {"unilib:tree_cypress_bald_trunk"},
        -- N.B. Only leaves in original code
        leaves = {"unilib:tree_cypress_bald_leaves"},
        others = {"unilib:tree_cypress_bald_branches", "unilib:tree_cypress_bald_liana"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From baldcypress:sapling. Creates unilib:tree_cypress_bald_sapling
        part_name = "cypress_bald",
        orig_name = "baldcypress:sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Bald Cypress Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 6, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        -- N.B. Original code is wrong
--      offset_list = {4, 0, 4},
        offset_list = {5, 0, 5},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        -- N.B. In original code, can be grown on any dirt (but decorations only appear on sand)
        under_list = {"unilib:sand_ordinary", "default:sand"},
    })

    unilib.register_fence_quick({
        -- From baldcypress:fence. Creates unilib:tree_cypress_bald_wood_fence
        part_name = "cypress_bald",
        orig_name = "baldcypress:fence",

        replace_mode = mode,
        base_img = "unilib_tree_cypress_bald_wood.png",
        burnlevel = burnlevel,
        description = S("Bald Cypress Wood Fence"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_rail_quick({
        -- From baldcypress:fence_rail. Creates unilib:tree_cypress_bald_wood_fence_rail
        part_name = "cypress_bald",
        orig_name = "baldcypress:fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_cypress_bald_wood.png",
        burnlevel = burnlevel,
        description = S("Bald Cypress Wood Fence Rail"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_fence_gate_quick({
        -- From baldcypress:gate_closed, etc. Creates unilib:gate_cypress_bald_closed, etc
        part_name = "cypress_bald",
        orig_name = {"baldcypress:gate_closed", "baldcypress:gate_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Bald Cypress Wood Fence Gate"),
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2},
    })

    unilib.register_decoration_generic("cool_trees_tree_cypress_bald", {
        -- From baldcypress/init.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_cypress_bald.mts",

        flags = "place_center_x, place_center_z, force_placement",
        height = 2,
        noise_params = {
            octaves = 3,
            offset = 0.0005,
            persist = 0.66,
            scale = 0.0005,
            seed = 678,
            spread = {x = 250, y = 250, z = 250},
        },
        rotation = "random",
        sidelen = 16,
    })

end
