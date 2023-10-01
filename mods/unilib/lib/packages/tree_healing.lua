---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_healing = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_healing.init()

    return {
        description = "Healing tree",
        notes = "Produces golden apples restore which restore all of the player's health. Leaves" ..
                " restore half a heart of health",
        depends = "fruit_apple_golden",
    }

end

function unilib.pkg.tree_healing.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "healing",
        description = S("Healing Tree Wood"),

        burnlevel = burnlevel,
    })

    unilib.register_node("unilib:tree_healing_trunk", "ethereal:yellow_trunk", mode, {
        -- From ethereal:yellow_trunk
        description = S("Healing Tree Trunk"),
        tiles = {
            "unilib_tree_healing_trunk_top.png",
            "unilib_tree_healing_trunk_top.png",
            "unilib_tree_healing_trunk.png",
        },
        groups = {choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })

    if unilib.super_tree_table["healing"] ~= nil then

        unilib.register_tree_trunk_stripped({
            -- From ethereal:yellow_trunk. Creates unilib:tree_healing_trunk_stripped
            part_name = "healing",
            orig_name = "ethereal:yellow_trunk",

            replace_mode = mode,
            description = S("Healing Tree Trunk"),
            group_table = {choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1, tree = 1},
        })

    end

    unilib.register_node("unilib:tree_healing_wood", "ethereal:yellow_wood", mode, {
        -- From ethereal:yellow_wood
        description = S("Healing Tree Wood Planks"),
        tiles = {"unilib_tree_healing_wood.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From ethereal:yellow_wood
        output = "unilib:tree_healing_wood 4",
        recipe = {
            {"unilib:tree_healing_trunk"},
        },
    })
    unilib.register_tree_wood_cuttings("healing")
    unilib.set_auto_rotate("unilib:tree_healing_wood", unilib.auto_rotate_wood_flag)

    local inv_img = unilib.filter_leaves_img("unilib_tree_healing_leaves.png")
    unilib.register_node("unilib:tree_healing_leaves", "ethereal:yellowleaves", mode, {
        -- From ethereal:yellowleaves
        description = S("Healing Tree Leaves"),
        tiles = {"unilib_tree_healing_leaves.png"},
        -- N.B. no food_shoots in original code
        groups = {food_shoots = 1, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = unilib.leaves_drawtype,
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_healing_sapling"}, rarity = 50},
                {items = {"unilib:tree_healing_leaves"}}
            }
        },
        inventory_image = inv_img,
        light_source = 9,
        paramtype = "light",
        visual_scale = unilib.leaves_visual_scale,
        walkable = unilib.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.after_place_leaves,

        on_use = unilib.cuisine_eat_on_use("unilib:tree_healing_leaves", 1),
    })
    unilib.register_leafdecay({
        -- From ethereal:yellowleaves
        trunks = {"unilib:tree_healing_trunk"},
        leaves = {"unilib:tree_healing_leaves", "unilib:fruit_apple_golden"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From ethereal:yellow_tree_sapling. Creates unilib:tree_healing_sapling
        part_name = "healing",
        orig_name = "ethereal:yellow_tree_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Healing Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 4, y = 19, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 0, 4},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
--      under_list = {},        -- Grows on any dirt
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_yellowwood. Creates unilib:tree_healing_wood_fence
        part_name = "healing",
        orig_name = "ethereal:fence_yellowwood",

        replace_mode = mode,
        base_img = "unilib_tree_healing_wood.png",
        burnlevel = burnlevel,
        description = S("Healing Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_yellowwood. Creates unilib:tree_healing_wood_fence_rail
        part_name = "healing",
        orig_name = "ethereal:fence_rail_yellowwood",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_healing_wood.png",
        description = S("Healing Tree Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_yellowwood. Creates unilib:gate_healing_closed
        part_name = "healing",
        orig_name = {"ethereal:fencegate_yellowwood_closed", "ethereal:fencegate_yellowwood_open"},

        replace_mode = mode,
        burnlevel = burnlevel,
        description = S("Healing Tree Wood Fence Gate"),
    })

    unilib.register_decoration("ethereal_tree_healing", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_healing.mts",

        fill_ratio = 0.01,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
