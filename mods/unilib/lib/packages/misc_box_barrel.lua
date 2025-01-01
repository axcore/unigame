---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_box_barrel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_box_barrel.init()

    return {
        description = "Decorative barrel",
        depends = "metal_iron",
    }

end

function unilib.pkg.misc_box_barrel.exec()

    unilib.register_node("unilib:misc_box_barrel", "xdecor:barrel", mode, {
        -- From xdecor:barrel
        description = S("Decorative Barrel"),
        tiles = {
            "unilib_misc_box_barrel_top.png",
            "unilib_misc_box_barrel_top.png",
            "unilib_misc_box_barrel_side.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })
    unilib.register_craft({
        -- From xdecor:barrel
        output = "unilib:misc_box_barrel",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"unilib:metal_iron_lump", "", "unilib:metal_iron_lump"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

end
