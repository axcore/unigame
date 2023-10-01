---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_box_wood_reinforced = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_box_wood_reinforced.init()

    return {
        description = "Reinforced wooden box",
        depends = {"item_stick_ordinary", "tree_apple"},
    }

end

function unilib.pkg.misc_box_wood_reinforced.exec()

    local c_stick = "unilib:item_stick_ordinary"
    local c_wood = "unilib:tree_apple_wood"

    local box_img = "unilib_misc_box_wood_reinforced_overlay.png"
    local side_img = "unilib_misc_box_wood_reinforced_side_overlay.png"

    unilib.register_node("unilib:misc_box_wood_reinforced", "nbea:nbox_007", mode, {
        -- From nbea:nbox_007
        description = S("Reinforced Wooden Box"),
        tiles = {
            "unilib_tree_apple_wood.png^" .. box_img,
            "unilib_tree_apple_wood.png^" .. box_img,
            "unilib_tree_apple_wood.png^(" .. side_img .. "^[transformFX)",
            "unilib_tree_apple_wood.png^(" .. side_img .. "^[transformFX)",
            "unilib_tree_apple_wood.png^" .. side_img,
            "unilib_tree_apple_wood.png^" .. side_img
        },
        groups = {choppy = 2},
        sounds = unilib.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        -- N.B. inventory_image removed from original code
--      inventory_image = "unilib_tree_apple_wood.png^" .. box_img,
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                -- Top (Y+)
                {-0.4375, 0.4375, 0.375, -0.3125, 0.5, 0.4375},
                {-0.4375, 0.4375, 0.3125, -0.25, 0.5, 0.375},
                {-0.375, 0.4375, 0.25, -0.1875, 0.5, 0.3125},
                {-0.3125, 0.4375, 0.1875, -0.125, 0.5, 0.25},
                {-0.25, 0.4375, 0.125, -0.0625, 0.5, 0.1875},
                {-0.1875, 0.4375, 0.0625, 0, 0.5, 0.125},
                {-0.125, 0.4375, -0, 0.0625, 0.5, 0.0625},
                {-0.0625, 0.4375, -0.0625, 0.125, 0.5, -0},
                {0, 0.4375, -0.125, 0.1875, 0.5, -0.0625},
                {0.0625, 0.4375, -0.1875, 0.25, 0.5, -0.125},
                {0.125, 0.4375, -0.25, 0.3125, 0.5, -0.1875},
                {0.1875, 0.4375, -0.3125, 0.375, 0.5, -0.25},
                {0.25, 0.4375, -0.375, 0.4375, 0.5, -0.3125},
                {0.3125, 0.4375, -0.4375, 0.4375, 0.5, -0.375},
                {0.375, 0.4375, 0.3125, 0.4375, 0.5, 0.4375},
                {0.3125, 0.4375, 0.25, 0.375, 0.5, 0.4375},
                {0.25, 0.4375, 0.1875, 0.3125, 0.5, 0.375},
                {0.1875, 0.4375, 0.125, 0.25, 0.5, 0.3125},
                {0.125, 0.4375, 0.0625, 0.1875, 0.5, 0.25},
                {0.0625, 0.4375, -0, 0.125, 0.5, 0.1875},
                {-0, 0.4375, -0.0625, 0.0625, 0.5, 0.125},
                {-0.0625, 0.4375, -0.125, -0, 0.5, 0.0625},
                {-0.125, 0.4375, -0.1875, -0.0625, 0.5, -0},
                {-0.1875, 0.4375, -0.25, -0.125, 0.5, -0.0625},
                {-0.25, 0.4375, -0.3125, -0.1875, 0.5, -0.125},
                {-0.3125, 0.4375, -0.375, -0.25, 0.5, -0.1875},
                {-0.375, 0.4375, -0.4375, -0.3125, 0.5, -0.25},
                {-0.4375, 0.4375, -0.4375, -0.375, 0.5, -0.3125},
                -- Bottom (Y-)
                {-0.4375, -0.5, -0.4375, -0.3125, -0.4375, -0.375},
                {-0.4375, -0.5, -0.375, -0.25, -0.4375, -0.3125},
                {-0.375, -0.5, -0.3125, -0.1875, -0.4375, -0.25},
                {-0.3125, -0.5, -0.25, -0.125, -0.4375, -0.1875},
                {-0.25, -0.5, -0.1875, -0.0625, -0.4375, -0.125},
                {-0.1875, -0.5, -0.125, 0, -0.4375, -0.0625},
                {-0.125, -0.5, -0.0625, 0.0625, -0.4375, 0},
                {-0.0625, -0.5, 0, 0.125, -0.4375, 0.0625},
                {0, -0.5, 0.0625, 0.1875, -0.4375, 0.125},
                {0.0625, -0.5, 0.125, 0.25, -0.4375, 0.1875},
                {0.125, -0.5, 0.1875, 0.3125, -0.4375, 0.25},
                {0.1875, -0.5, 0.25, 0.375, -0.4375, 0.3125},
                {0.25, -0.5, 0.3125, 0.4375, -0.4375, 0.375},
                {0.3125, -0.5, 0.375, 0.4375, -0.4375, 0.4375},
                {0.375, -0.5, -0.4375, 0.4375, -0.4375, -0.3125},
                {0.3125, -0.5, -0.4375, 0.375, -0.4375, -0.25},
                {0.25, -0.5, -0.375, 0.3125, -0.4375, -0.1875},
                {0.1875, -0.5, -0.3125, 0.25, -0.4375, -0.125},
                {0.125, -0.5, -0.25, 0.1875, -0.4375, -0.0625},
                {0.0625, -0.5, -0.1875, 0.125, -0.4375, 0},
                {-0, -0.5, -0.125, 0.0625, -0.4375, 0.0625},
                {-0.0625, -0.5, -0.0625, -0, -0.4375, 0.125},
                {-0.125, -0.5, 0, -0.0625, -0.4375, 0.1875},
                {-0.1875, -0.5, 0.0625, -0.125, -0.4375, 0.25},
                {-0.25, -0.5, 0.125, -0.1875, -0.4375, 0.3125},
                {-0.3125, -0.5, 0.1875, -0.25, -0.4375, 0.375},
                {-0.375, -0.5, 0.25, -0.3125, -0.4375, 0.4375},
                {-0.4375, -0.5, 0.3125, -0.375, -0.4375, 0.4375},
                -- Right (X+)
                {0.4375, 0.375, -0.4375, 0.5, 0.4375, -0.3125},
                {0.4375, 0.3125, -0.4375, 0.5, 0.375, -0.25},
                {0.4375, 0.25, -0.375, 0.5, 0.3125, -0.1875},
                {0.4375, 0.1875, -0.3125, 0.5, 0.25, -0.125},
                {0.4375, 0.125, -0.25, 0.5, 0.1875, -0.0625},
                {0.4375, 0.0625, -0.1875, 0.5, 0.125, 0},
                {0.4375, -0, -0.125, 0.5, 0.0625, 0.0625},
                {0.4375, -0.0625, -0.0625, 0.5, -0, 0.125},
                {0.4375, -0.125, 0, 0.5, -0.0625, 0.1875},
                {0.4375, -0.1875, 0.0625, 0.5, -0.125, 0.25},
                {0.4375, -0.25, 0.125, 0.5, -0.1875, 0.3125},
                {0.4375, -0.3125, 0.1875, 0.5, -0.25, 0.375},
                {0.4375, -0.375, 0.25, 0.5, -0.3125, 0.4375},
                {0.4375, -0.4375, 0.3125, 0.5, -0.375, 0.4375},
                -- Left (X-)
                {-0.5, 0.375, 0.3125, -0.4375, 0.4375, 0.4375},
                {-0.5, 0.3125, 0.25, -0.4375, 0.375, 0.4375},
                {-0.5, 0.25, 0.1875, -0.4375, 0.3125, 0.375},
                {-0.5, 0.1875, 0.125, -0.4375, 0.25, 0.3125},
                {-0.5, 0.125, 0.0625, -0.4375, 0.1875, 0.25},
                {-0.5, 0.0625, -0, -0.4375, 0.125, 0.1875},
                {-0.5, -0, -0.0625, -0.4375, 0.0625, 0.125},
                {-0.5, -0.0625, -0.125, -0.4375, -0, 0.0625},
                {-0.5, -0.125, -0.1875, -0.4375, -0.0625, -0},
                {-0.5, -0.1875, -0.25, -0.4375, -0.125, -0.0625},
                {-0.5, -0.25, -0.3125, -0.4375, -0.1875, -0.125},
                {-0.5, -0.3125, -0.375, -0.4375, -0.25, -0.1875},
                {-0.5, -0.375, -0.4375, -0.4375, -0.3125, -0.25},
                {-0.5, -0.4375, -0.4375, -0.4375, -0.375, -0.3125},
                -- Back (Z+)
                {0.375, -0.4375, 0.4375, 0.4375, -0.3125, 0.5},
                {0.3125, -0.4375, 0.4375, 0.375, -0.25, 0.5},
                {0.25, -0.375, 0.4375, 0.3125, -0.1875, 0.5},
                {0.1875, -0.3125, 0.4375, 0.25, -0.125, 0.5},
                {0.125, -0.25, 0.4375, 0.1875, -0.0625, 0.5},
                {0.0625, -0.1875, 0.4375, 0.125, 0, 0.5},
                {-0, -0.125, 0.4375, 0.0625, 0.0625, 0.5},
                {-0.0625, -0.0625, 0.4375, -0, 0.125, 0.5},
                {-0.125, 0, 0.4375, -0.0625, 0.1875, 0.5},
                {-0.1875, 0.0625, 0.4375, -0.125, 0.25, 0.5},
                {-0.25, 0.125, 0.4375, -0.1875, 0.3125, 0.5},
                {-0.3125, 0.1875, 0.4375, -0.25, 0.375, 0.5},
                {-0.375, 0.25, 0.4375, -0.3125, 0.4375, 0.5},
                {-0.4375, 0.3125, 0.4375, -0.375, 0.4375, 0.5},
                -- Front (Z-)
                {-0.4375, -0.4375, -0.5, -0.375, -0.3125, -0.4375},
                {-0.375, -0.4375, -0.5, -0.3125, -0.25, -0.4375},
                {-0.3125, -0.375, -0.5, -0.25, -0.1875, -0.4375},
                {-0.25, -0.3125, -0.5, -0.1875, -0.125, -0.4375},
                {-0.1875, -0.25, -0.5, -0.125, -0.0625, -0.4375},
                {-0.125, -0.1875, -0.5, -0.0625, 0, -0.4375},
                {-0.0625, -0.125, -0.5, 0, 0.0625, -0.4375},
                {0, -0.0625, -0.5, 0.0625, 0.125, -0.4375},
                {0.0625, 0, -0.5, 0.125, 0.1875, -0.4375},
                {0.125, 0.0625, -0.5, 0.1875, 0.25, -0.4375},
                {0.1875, 0.125, -0.5, 0.25, 0.3125, -0.4375},
                {0.25, 0.1875, -0.5, 0.3125, 0.375, -0.4375},
                {0.3125, 0.25, -0.5, 0.375, 0.4375, -0.4375},
                {0.375, 0.3125, -0.5, 0.4375, 0.4375, -0.4375},
                -- Centre mass 14px
                {-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
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
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
        wield_image = "unilib_tree_apple_wood.png^" .. box_img,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_box_wood_reinforced 2",
        recipe = {
            {c_stick, c_wood, c_stick},
            {c_wood, c_stick, c_wood},
            {c_stick, c_wood, c_stick},
        },
    })

end