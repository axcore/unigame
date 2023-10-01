---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_ornament_sheep = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_ornament_sheep.init()

    return {
        description = "Ornamental sheep",
        notes = "Behaves like a trampoline",
        depends = {"crop_cotton", "stone_obsidian"},
    }

end

function unilib.pkg.misc_ornament_sheep.exec()

    local c_cotton = "unilib:crop_cotton_harvest"

    unilib.register_node("unilib:misc_ornament_sheep", "nbea:nbox_010", mode, {
        -- From nbea:nbox_010
        description = S("Ornamental Sheep"),
        tiles = {
            "unilib_misc_ornament_sheep_top.png",
            "unilib_misc_ornament_sheep_bottom.png",
            "unilib_misc_ornament_sheep_side_right.png",
            "unilib_misc_ornament_sheep_side_left.png",
            "unilib_misc_ornament_sheep_back.png",
            "unilib_misc_ornament_sheep_front.png",
        },
        -- N.B. no fall_damage_add_percent in original code
        groups = {
            bouncy = 100, dig_immediate = 3, fall_damage_add_percent = -80,
            oddly_breakable_by_hand = 3,
        },
        sounds = unilib.node_sound_leaves_defaults({
            place = {name = "unilib_ornament_sheep", gain = 0.25},
            footstep = {name = "unilib_ornament_sheep_bounce", gain = 0.25},
            dig = {name = "unilib_ornament_sheep_bounce", gain = 0.25},
            dug = {name = "unilib_ornament_sheep_hurt", gain = 0.25},
        }),

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.3125, -0.375, -0.1875, 0.3125, 0.1875, 0.4375},
                {-0.1875, -0.25, -0.375, 0.1875, 0.0625, -0.125},
                {-0.25, -0.0625, -0.3125, 0.25, 0.06, -0.1875},
                {-0.125, -0.3125, -0.5, 0.125, 0.08995, -0.3125},
                {-0.25, -0.5, -0.125, -0.0625, -0.375, 0.0625},
                {0.0625, -0.5, -0.125, 0.25, -0.3125, 0.0625},
                {-0.25, -0.5, 0.1875, -0.0625, -0.3125, 0.375},
                {0.0625, -0.5, 0.1875, 0.25, -0.3125, 0.375},
                {-0.0625, -0.1875, 0.4375, 0.0625, 0.0625, 0.5},
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
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_ornament_sheep",
        recipe = {
            {c_cotton, c_cotton, c_cotton},
            {c_cotton, c_cotton, c_cotton},
            {"unilib:stone_obsidian_shard", "", "unilib:stone_obsidian_shard"},
        },
    })

end
