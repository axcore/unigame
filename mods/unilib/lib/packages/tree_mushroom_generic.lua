---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_mushroom_generic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_mushroom_generic.init()

    return {
        description = "Provides a trunk used by both ethereal-ng mushroom trees",
    }

end

function unilib.pkg.tree_mushroom_generic.exec()

    local burnlevel = 3
    -- (no sci_name)

    -- N.B. No call to unilib.register_tree() necessary

    unilib.register_node("unilib:tree_mushroom_generic_trunk", "ethereal:mushroom_trunk", mode, {
        -- From ethereal:mushroom_trunk
        description = S("Mushroom Tree Trunk"),
        tiles = {
            "unilib_tree_mushroom_generic_trunk_top.png",
            "unilib_tree_mushroom_generic_trunk_top.png",
            "unilib_tree_mushroom_generic_trunk.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })
    unilib.register_stairs("unilib:tree_mushroom_generic_trunk", {
        basic_flag = true,
    })

    unilib.register_node("unilib:tree_mushroom_generic_pore", "ethereal:mushroom_pore", mode, {
        -- From ethereal:mushroom_pore
        description = S("Mushroom Pore"),
        tiles = {"unilib_tree_mushroom_generic_pore.png"},
        groups = {
            choppy = 3, cracky = 3, disable_jump = 1, fall_damage_add_percent = -100,
            flammable = 2, leafdecay = 3, oddly_breakable_by_hand = 3, snappy = 3,
        },
        sounds = unilib.global.sound_table.dirt,
    })
    unilib.register_craft({
        -- From ethereal:mushroom_pore
        type = "fuel",
        recipe = "unilib:tree_mushroom_generic_pore",
        burntime = 3,
    })

    unilib.register_leafdecay({
        -- From ethereal:mushroom_pore
        trunk_type = "mushroom_generic",
        trunks = {"unilib:tree_mushroom_generic_trunk"},
        leaves = {
            "unilib:tree_mushroom_red_cap",
            "unilib:tree_mushroom_generic_pore",
            "unilib:tree_mushroom_brown_cap",
            "unilib:vine_string_light",
        },
        radius = 4,
    })

    unilib.register_fence_quick({
        -- From ethereal:fence_mushroom. Creates unilib:tree_mushroom_generic_wood_fence
        part_name = "mushroom_generic",
        orig_name = "ethereal:fence_mushroom",

        replace_mode = mode,
        base_img = "unilib_tree_mushroom_generic_trunk.png",
        burnlevel = burnlevel,
        description = S("Mushroom Tree Wood Fence"),
        ingredient = "unilib:tree_mushroom_generic_trunk",
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_mushroom. Creates unilib:tree_mushroom_generic_wood_fence_rail
        part_name = "mushroom_generic",
        orig_name = "ethereal:fence_rail_mushroom",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_mushroom_generic_trunk.png",
        description = S("Mushroom Tree Wood Fence Rail"),
        ingredient = "unilib:tree_mushroom_generic_trunk",
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_mushroom_closed, etc. Creates unilib:gate_mushroom_closed, etc
        part_name = "mushroom_generic",
        orig_name = {"ethereal:fencegate_mushroom_closed", "ethereal:fencegate_mushroom_open"},

        replace_mode = mode,
        base_img = "unilib_tree_mushroom_generic_trunk.png",
        burnlevel = burnlevel,
        description = S("Generic Mushroom Tree Wood Fence Gate"),
        ingredient = "unilib:tree_mushroom_generic_trunk",
    })

end
