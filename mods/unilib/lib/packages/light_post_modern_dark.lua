---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_post_modern_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_modern.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_post_modern_dark.init()

    return {
        description = "Dark modern light post",
        depends = {"dye_basic", "light_bulb_normal", "metal_steel"},
    }

end

function unilib.pkg.light_post_modern_dark.exec()

    unilib.register_node("unilib:light_post_modern_dark", "morelights_modern:post_d", mode, {
        -- From morelights_modern:post_d
        description = S("Dark-Coloured Modern Light Post"),
        tiles = {
            "unilib_pole_metal_dark.png",
            "unilib_pole_metal_dark.png",
            "unilib_pole_metal_dark.png^unilib_light_post_modern_overlay.png"
        },
        groups = {cracky = 3, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        light_source = unilib.light_max,
        node_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
        },
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From morelights_modern:post_d
        output = "unilib:light_post_modern_dark",
        recipe = {
            {"unilib:dye_grey_dark", "unilib:metal_steel_ingot", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

end
