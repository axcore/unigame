---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sounding_line
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_line_sounding_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.sounding_line.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_line_sounding_normal.init()

    return {
        description = "Normal sounding line",
        notes = "Use for measuring depths of holes, caves or water. Right-click to activate",
        depends = {"metal_steel", "shared_sounding_line"},
        suggested = {
            "crop_cotton",                      -- group:thread
            "item_stick_ordinary",              -- group:stick
            "rope_mining",                      -- group:vines
        },
    }

end

function unilib.pkg.misc_line_sounding_normal.exec()

    unilib.register_node("unilib:misc_line_sounding_normal", "sounding_line:sounding_line", mode, {
        -- From sounding_line:sounding_line
        description = S("Normal Sounding Line"),
        tiles = {
            "unilib_misc_line_sounding_normal_top.png",
            "unilib_misc_line_sounding_normal_bottom.png",
            "unilib_misc_line_sounding_normal_side.png",
            "unilib_misc_line_sounding_normal_side.png^[transformFX",
            "unilib_misc_line_sounding_normal_front.png",
            "unilib_misc_line_sounding_normal_front.png^[transformFX",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        drop = "unilib:misc_line_sounding_normal",
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
    -- N.B. group:thread is provided by unilib:crop_cotton_harvest
    unilib.register_craft({
        -- From sounding_line:sounding_line
        output = "unilib:misc_line_sounding_normal",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"group:thread", "group:thread", "group:thread"},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })
    unilib.register_craft({
        -- From sounding_line:sounding_line
        output = "unilib:misc_line_sounding_normal",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"", "group:vines", ""},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

end
