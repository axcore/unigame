---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_gate_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_gate_simple.init()

    return {
        description = "Simple gate",
        notes = "When opened, the gate drops to the floor",
    }

end

function unilib.pkg.misc_gate_simple.exec()

    unilib.register_node("unilib:misc_gate_simple_closed", "cottages:gate_closed", mode, {
        -- From cottages:gate_closed
        description = S("Closed Simple Gate"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.85, -0.25, -0.02, 0.85, -0.05, 0.02},
                {-0.85, 0.15, -0.02, 0.85, 0.35, 0.02},
                {-0.80, -0.05, -0.02, -0.60, 0.15, 0.02},
                { 0.60, -0.05, -0.02, 0.80, 0.15, 0.02},
                {-0.15, -0.05, -0.02, 0.15, 0.15, 0.02},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.85, -0.25, -0.1, 0.85, 0.35, 0.1},
            },
        },

        on_rightclick = function(pos, node, puncher)
            core.swap_node(pos, {name = "unilib:misc_gate_simple_open", param2 = node.param2})
        end,
    })
    unilib.register_craft({
        -- From cottages:gate_closed
        output = "unilib:misc_gate_simple_closed",
        recipe = {
            {"group:stick", "group:stick", "group:wood"},
        },
    })
    -- (For convenience, convert open/closed simple gates)
    unilib.register_craft({
        -- From cottages:gate_closed
        output = "unilib:misc_gate_simple_closed",
        recipe = {
            {"unilib:misc_gate_simple_open"},
        },
    })
    unilib.register_craft({
        -- From cottages:gate_open
        output = "unilib:misc_gate_simple_open",
        recipe = {
            {"unilib:misc_gate_simple_closed"},
        },
    })

    unilib.register_node("unilib:misc_gate_simple_open", "cottages:gate_open", mode, {
        -- From cottages:gate_open
        description = S("Open Simple Gate"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {
            choppy = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 2, snappy = 2,
        },
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        drop = "unilib:misc_gate_simple_closed",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.85, -0.5, -0.25, 0.85, -0.46, -0.05},
                {-0.85, -0.5, 0.15, 0.85, -0.46, 0.35},
                {-0.80, -0.5, -0.05, -0.60, -0.46, 0.15},
                { 0.60, -0.5, -0.05, 0.80, -0.46, 0.15},
                {-0.15, -0.5, -0.05, 0.15, -0.46, 0.15},

            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.85, -0.5, -0.25, 0.85, -0.3, 0.35},
            },
        },

        on_rightclick = function(pos, node, puncher)
            core.swap_node(pos, {name = "unilib:misc_gate_simple_closed", param2 = node.param2})
        end,
    })

end
