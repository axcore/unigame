---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_line_sounding_reinforced = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_line_sounding_reinforced.init()

    return {
        description = "Reinforced sounding line",
        notes = "Use for measuring depths of holes, caves, water or lava. Right-click to activate",
        depends = {"item_stick_iron", "metal_steel", "mineral_diamond", "shared_sounding_line"},
        suggested = {
            "crop_cotton",                      -- group:thread
        },
    }

end

function unilib.pkg.misc_line_sounding_reinforced.exec()

    unilib.register_node("unilib:misc_line_sounding_reinforced", nil, mode, {
        -- Original to unilib
        description = S("Sounding Line"),
        tiles = {
            "unilib_misc_line_sounding_reinforced_top.png",
            "unilib_misc_line_sounding_reinforced_bottom.png",
            "unilib_misc_line_sounding_reinforced_side.png",
            "unilib_misc_line_sounding_reinforced_side.png^[transformFX",
            "unilib_misc_line_sounding_reinforced_front.png",
            "unilib_misc_line_sounding_reinforced_front.png^[transformFX",
        },
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.metal,

        climbable = true,
        drawtype = "nodebox",
        drop = "unilib:misc_line_sounding_reinforced",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, 0.125, -0.0625, 0.375, 0.25, 0.0625},
                {-0.5, 0.125, -0.5, -0.375, 0.25, 0.5},
                {0.375, 0.125, -0.5, 0.5, 0.25, 0.5},
                {0.1875, -0.125, -0.3125, 0.3125, 0.5, 0.3125},
                {-0.3125, -0.125, -0.3125, -0.1875, 0.5, 0.3125},
                {-0.1875, -0.0625, -0.25, 0.1875, 0.4375, 0.25},
                {-0.0625, -0.25, -0.25, 0, -0.0625, -0.1875},
                {-0.125, -0.5, -0.3125, 0.0625, -0.25, -0.125},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = false,

        on_rightclick = unilib.pkg.shared_sounding_line.on_rightclick,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_line_sounding_reinforced",
        recipe = {
            {"unilib:item_stick_iron", "unilib:item_stick_iron", "unilib:item_stick_iron"},
            {"unilib:mineral_diamond_gem", "group:thread", "unilib:mineral_diamond_gem"},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

end
