---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_glass_stained = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_glass_stained.init()

    return {
        description = "Stained-glass lantern",
        depends = {"dye_basic", "tree_jungle"},
    }

end

function unilib.pkg.light_lantern_glass_stained.exec()

    local c_wood = "unilib:tree_jungle_wood"

    unilib.register_node("unilib:light_lantern_glass_stained", "nbea:nbox_006", mode, {
        -- From nbea:nbox_006
        description = S("Stained-Glass Lantern"),
        tiles = {"unilib_light_lantern_glass_stained.png"},
        groups = {choppy = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        climbable = true,
        drawtype = "nodebox",
        -- N.B. inventory_image removed from original code
--      inventory_image = "unilib_light_lantern_glass_stained.png",
        is_ground_content = false,
        light_source = 8,
        node_box = {
            type = "fixed",
            fixed = {
                {0.25, -0.5, -0.5, 0.3125, 0.5, 0.5},
                {-0.3125, -0.5, -0.5, -0.25, 0.5, 0.5},
                {-0.5, -0.5, -0.3125, 0.5, 0.5, -0.25},
                {-0.5, -0.5, 0.25, 0.5, 0.5, 0.3125},
                {-0.5, -0.3125, -0.5, 0.5, -0.25, 0.5},
                {-0.5, 0.25, -0.5, 0.5, 0.3125, 0.5},
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
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_light_lantern_glass_stained.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:light_lantern_glass_stained 2",
        recipe = {
            {c_wood, c_wood, c_wood},
            {"unilib:dye_orange", "unilib:dye_yellow", "unilib:dye_orange"},
            {c_wood, c_wood, c_wood},
        },
    })

end
