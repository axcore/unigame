---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_wood_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_wood_simple.init()

    return {
        description = "Simple wooden frame",
        depends = "item_stick_ordinary",
    }

end

function unilib.pkg.misc_frame_wood_simple.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_frame_wood_simple", "nbea:nbox_000", mode, {
        -- From nbea:nbox_000
        description = S("Simple Wooden Frame"),
        tiles = {"unilib_tree_apple_wood.png"},
        groups = {choppy = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                -- Corner frame
                {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                {0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
                {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                {0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
                {0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
                {-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
                {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                {-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_frame_wood_simple",
        recipe = {
            {c_stick, c_stick, c_stick},
            {c_stick, "", c_stick},
            {c_stick, c_stick, c_stick},
        },
    })

end
