---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mushroom_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mushroom_red.init()

    return {
        description = "Red ushroom tree",
        notes = "Red mushroom pores can be used to break falls",
        optional = {"dirt_ordinary_with_turf_mushroom", "mushroom_red"},
    }

end

function unilib.pkg.tree_mushroom_red.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "mushroom_red",
        description = S("Red Mushroom Trunk"),

        burnlevel = burnlevel,
        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_mushroom_red_trunk", "ethereal:mushroom_trunk", mode, {
        -- From ethereal:mushroom_trunk
        description = S("Red Mushroom Trunk"),
        tiles = {
            "unilib_tree_mushroom_red_trunk_top.png",
            "unilib_tree_mushroom_red_trunk_top.png",
            "unilib_tree_mushroom_red_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })
    unilib.register_stairs("unilib:tree_mushroom_red_trunk", {
        basic_flag = true,
    })

    -- (No wood node)

    -- (No leaves node, use mushroom caps and mushroom pores instead)

    unilib.register_node("unilib:tree_mushroom_red_cap", "ethereal:mushroom", mode, {
        -- From ethereal:mushroom
        description = S("Red Mushroom Cap"),
        tiles = {"unilib_tree_mushroom_red_cap.png"},
        groups = {choppy = 2, flammable = 2, leafdecay = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_mushroom_red_sapling"}, rarity = 20},
                {items = {"unilib:tree_mushroom_red_cap"}},
            },
        },
    })
    unilib.register_craft({
        -- From ethereal:mushroom
        type = "fuel",
        recipe = "unilib:tree_mushroom_red_cap",
        burntime = 10,
    })
    if unilib.pkg_executed_table["mushroom_red"] ~= nil then

        unilib.register_craft({
            -- From ethereal:mushroom
            output = "unilib:tree_mushroom_red_cap",
            recipe = {
                {"unilib:mushroom_red", "unilib:mushroom_red"},
                {"unilib:mushroom_red", "unilib:mushroom_red"},
            }
        })

    end
    unilib.register_stairs("unilib:tree_mushroom_red_cap", {
        basic_flag = true,
    })

    unilib.register_node("unilib:tree_mushroom_red_pore", "ethereal:mushroom_pore", mode, {
        -- From ethereal:mushroom_pore
        description = S("Red Mushroom Pore"),
        tiles = {"unilib_tree_mushroom_red_pore.png"},
        groups = {
            choppy = 3, cracky = 3, disable_jump = 1, fall_damage_add_percent = -100,
            flammable = 2, leafdecay = 3, oddly_breakable_by_hand = 3, snappy = 3,
        },
        sounds = unilib.sound_table.dirt,
    })
    unilib.register_craft({
        -- From ethereal:mushroom_pore
        type = "fuel",
        recipe = "unilib:tree_mushroom_red_pore",
        burntime = 3,
    })

    -- (In recent version of ethereal-ng, leafdecay works on mushroom caps/pores)
    unilib.register_leafdecay({
        -- From ethereal:mushroom_pore
        trunks = {"unilib:tree_mushroom_red_trunk"},
        leaves = {"unilib:tree_mushroom_red_cap", "unilib:tree_mushroom_red_pore"},
        radius = 3,
    })

    unilib.register_tree_sapling({
        -- From ethereal:mushroom_sapling. Creates unilib:tree_mushroom_red_sapling
        part_name = "mushroom_red",
        orig_name = "ethereal:mushroom_sapling",

        replace_mode = mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Red Mushroom Tree Sapling"),
--      max_volume = 4,         -- For ethereal-ng trees, use default value
        maxp_table = {x = 4, y = 11, z = 4},
        minp_table = {x = -4, y = 1, z = -4},
        offset_list = {4, 0, 4},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
        under_list = {"unilib:dirt_ordinary_with_turf_mushroom", "ethereal:mushroom_dirt"},
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_mushroom. Creates unilib:tree_mushroom_red_wood_fence
        part_name = "mushroom_red",
        orig_name = "ethereal:fence_mushroom",

        replace_mode = mode,
        base_img = "unilib_tree_mushroom_red_trunk.png",
        burnlevel = burnlevel,
        description = S("Red Mushroom Tree Wood Fence"),
        ingredient = "unilib:tree_mushroom_red_trunk",
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_mushroom. Creates unilib:tree_mushroom_red_wood_fence_rail
        part_name = "mushroom_red",
        orig_name = "ethereal:fence_rail_mushroom",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_mushroom_red_trunk.png",
        description = S("Red Mushroom Tree Wood Fence Rail"),
        ingredient = "unilib:tree_mushroom_red_trunk",
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_mushroom. Creates unilib:gate_mushroom_closed
        part_name = "mushroom_red",
        orig_name = {"ethereal:fencegate_mushroom_closed", "ethereal:fencegate_mushroom_open"},

        replace_mode = mode,
        base_img = "unilib_tree_mushroom_red_trunk.png",
        burnlevel = burnlevel,
        description = S("Red Mushroom Tree Wood Fence Gate"),
        ingredient = "unilib:tree_mushroom_red_trunk",
    })

    unilib.register_decoration("ethereal_tree_mushroom_red", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_tree_mushroom_red.mts",

        fill_ratio = 0.02,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
