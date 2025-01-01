---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_fence_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_fence_simple.init()

    return {
        description = "Simple fence",
    }

end

function unilib.pkg.misc_fence_simple.exec()

    unilib.register_node("unilib:misc_fence_simple", "cottages:fence_small", mode, {
        -- From cottages:fence_small
        description = S("Simple Fence"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.45, -0.35, 0.46, 0.45, -0.20, 0.50},
                {-0.45, 0.00, 0.46, 0.45, 0.15, 0.50},
                {-0.45, 0.35, 0.46, 0.45, 0.50, 0.50},
                {-0.50, -0.50, 0.46, -0.45, 0.50, 0.50},
                { 0.45, -0.50, 0.46, 0.50, 0.50, 0.50},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.50, -0.50, 0.4, 0.50, 0.50, 0.5},
            },
        },
    })
    unilib.register_craft({
        -- From cottages:fence_small
        output = "unilib:misc_fence_simple 3",
        recipe = {
            -- N.B. Was default wood in original code
            {"group:wood", "group:wood"},
        },
    })

    unilib.register_node("unilib:misc_fence_simple_corner", "cottages:fence_corner", mode, {
        -- From cottages:fence_corner
        description = S("Simple Fence Corner"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.45, -0.35, 0.46, 0.45, -0.20, 0.50},
                {-0.45, 0.00, 0.46, 0.45, 0.15, 0.50},
                {-0.45, 0.35, 0.46, 0.45, 0.50, 0.50},
                {-0.50, -0.50, 0.46, -0.45, 0.50, 0.50},
                {0.45, -0.50, 0.46, 0.50, 0.50, 0.50},
                {0.46, -0.35, -0.45, 0.50, -0.20, 0.45},
                {0.46, 0.00, -0.45, 0.50, 0.15, 0.45},
                {0.46, 0.35, -0.45, 0.50, 0.50, 0.45},
                {0.46, -0.50, -0.50, 0.50, 0.50, -0.45},
                {0.46, -0.50, 0.45, 0.50, 0.50, 0.50},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.50, -0.50, -0.5, 0.50, 0.50, 0.5},
            },
        },
    })
    unilib.register_craft({
        -- From cottages:fence_corner
        output = "unilib:misc_fence_simple_corner",
        recipe = {
            {"unilib:misc_fence_simple", "unilib:misc_fence_simple"},
        }
    })
    unilib.register_craft({
        -- From cottages:fence_corner
        output = "unilib:misc_fence_simple 2",
        recipe = {
            {"unilib:misc_fence_simple_corner"},
        }
    })

    unilib.register_node("unilib:misc_fence_simple_end", "cottages:fence_end", mode, {
        -- From cottages:fence_end
        description = S("Simple Fence End"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.45, -0.35, 0.46, 0.45, -0.20, 0.50},
                {-0.45, 0.00, 0.46, 0.45, 0.15, 0.50},
                {-0.45, 0.35, 0.46, 0.45, 0.50, 0.50},
                {-0.50, -0.50, 0.46, -0.45, 0.50, 0.50},
                {0.45, -0.50, 0.46, 0.50, 0.50, 0.50},
                {0.46, -0.35, -0.45, 0.50, -0.20, 0.45},
                {0.46, 0.00, -0.45, 0.50, 0.15, 0.45},
                {0.46, 0.35, -0.45, 0.50, 0.50, 0.45},
                {0.46, -0.50, -0.50, 0.50, 0.50, -0.45},
                {0.46, -0.50, 0.45, 0.50, 0.50, 0.50},
                {-0.50, -0.35, -0.45, -0.46, -0.20, 0.45},
                {-0.50, 0.00, -0.45, -0.46, 0.15, 0.45},
                {-0.50, 0.35, -0.45, -0.46, 0.50, 0.45},
                {-0.50, -0.50, -0.50, -0.46, 0.50, -0.45},
                {-0.50, -0.50, 0.45, -0.46, 0.50, 0.50},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.50, -0.50, -0.5, 0.50, 0.50, 0.5},
            },
        },
    })
    unilib.register_craft({
        -- From cottages:fence_end
        output = "unilib:misc_fence_simple_end",
        recipe = {
            {"unilib:misc_fence_simple", "unilib:misc_fence_simple", "unilib:misc_fence_simple"},
        }
    })
    unilib.register_craft({
        -- From cottages:fence_end
        output = "unilib:misc_fence_simple 3",
        recipe = {
            {"unilib:misc_fence_simple_end"},
        }
    })

end
