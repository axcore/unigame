---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
--
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_scorched = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_scorched.init()

    return {
        description = "Scorched tree",
        notes = "Schorched tree trunks are crafted into charcoal lumps, rather than into planks",
        optional = "torch_ordinary",
    }

end

function unilib.pkg.tree_scorched.exec()

    local burnlevel = 3
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "scorched",
        description = S("Scorched Tree Wood"),

        burnlevel = burnlevel,
        -- This tree does not have its own sapling
        incomplete_flag = true,
    })

    unilib.register_node("unilib:tree_scorched_trunk", "ethereal:scorched_tree", mode, {
        -- From ethereal:scorched_tree
        description = S("Scorched Tree Trunk"),
        tiles = {
            "unilib_tree_scorched_trunk_top.png",
            "unilib_tree_scorched_trunk_top.png",
            "unilib_tree_scorched_trunk.png",
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. no .is_ground_content in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        -- N.B. No .after_destruct in original code
        after_destruct = function(pos, oldnode)
            unilib.flora.collapse_slim_tree(pos, oldnode, {"unilib:tree_scorched_trunk"})
        end,

        on_place = core.rotate_node,
    })
    if unilib.global.pkg_executed_table["torch_ordinary"] ~= nil then

        unilib.register_craft({
            -- From ethereal:scorched_tree
            output = "unilib:tree_scorched_trunk 8",
            recipe = {
                {"group:tree", "group:tree", "group:tree"},
                {"group:tree", "unilib:torch_ordinary", "group:tree"},
                {"group:tree", "group:tree", "group:tree"},
            },
        })

    end

    unilib.register_tree_trunk_stripped({
        -- From ethereal:scorched_tree. Creates unilib:tree_scorched_trunk_stripped
        part_name = "scorched",
        orig_name = "ethereal:scorched_tree",

        replace_mode = mode,
        description = S("Scorched Tree Trunk"),
        group_table = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 1, tree = 1},
    })

    unilib.register_tree_wood({
        -- Texture from GLEMr4, lib_ecology_tree_scorched_wood.png. Original code
        part_name = "scorched",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Scorched Tree Wood Planks"),
    })

    -- (No leaves or sapling)

    unilib.register_fence_quick({
        -- From ethereal:fence_scorched. Creates unilib:tree_scorched_wood_fence
        part_name = "scorched",
        orig_name = "ethereal:fence_scorched",

        replace_mode = mode,
        base_img = "unilib_tree_scorched_trunk.png",
        burnlevel = burnlevel,
        description = S("Scorched Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From ethereal:fence_rail_scorched. Creates unilib:tree_scorched_wood_fence_rail
        part_name = "scorched",
        orig_name = "ethereal:fence_rail_scorched",

        replace_mode = mode,
        burnlevel = burnlevel,
        base_img = "unilib_tree_scorched_trunk.png",
        description = S("Scorched Tree Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From ethereal:fencegate_scorched_closed, etc. Creates unilib:gate_scorched_closed, etc
        part_name = "scorched",
        orig_name = {"ethereal:fencegate_scorched_closed", "ethereal:fencegate_scorched_open"},

        replace_mode = mode,
        base_img = "unilib_tree_scorched_trunk.png",
        burnlevel = burnlevel,
        description = S("Scorched Tree Wood Fence Gate"),
    })

    unilib.register_decoration_generic("ethereal_tree_scorched", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:tree_scorched_trunk",

        fill_ratio = 0.006,
        height_max = 6,
        sidelen = 80,
    })

    -- This package provides deliberate craft recipe conflicts
    unilib.register_craft_conflicts({
        {"unilib:item_stick_ordinary 4", "unilib:material_charcoal_artificial_lump 8"},
    })

end
