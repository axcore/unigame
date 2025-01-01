---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_framed_glass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_framed_glass.init()

    return {
        description = "Wood-framed glass door",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.door_framed_glass.exec()

    unilib.register_door({
        -- From xdecor, doors:woodglass_door. Creates unilib:door_framed_glass_closed_left, etc
        part_name = "framed_glass",
        orig_name_list = {
            "doors:woodglass_door_a",
            "doors:woodglass_door_b",
            "doors:woodglass_door_c",
            "doors:woodglass_door_d",
        },
        def_table = {
            description = S("Wood-Framed Glass Door"),
            tiles = {{name = "unilib_door_framed_glass.png", backface_culling = true}},
            -- N.B. node = 1 missing from original code
            groups = {choppy = 2, cracky = 2, door = 1, node = 1, oddly_breakable_by_hand = 1},
            -- (no sounds)

            inventory_image = "unilib_door_framed_glass_inv.png",
            protected_flag = false,
            recipe = {
                {"unilib:glass_ordinary", "unilib:glass_ordinary"},
                {"group:wood", "group:wood"},
                {"group:wood", "group:wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:woodglass_door",
    })

end
