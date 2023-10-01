---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_scarecrow_pumpkin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_scarecrow_pumpkin.init()

    return {
        description = "Pumpkin Scarecrow",
        depends = {"item_stick_ordinary", "misc_straw_ordinary", "produce_pumpkin_yellow"},
    }

end

function unilib.pkg.misc_scarecrow_pumpkin.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_scarecrow_pumpkin", "decoblocks:scarecrow", mode, {
        -- From farlands, decoblocks:scarecrow
        description = S("Pumpkin Scarecrow"),
        tiles = {"unilib_misc_scarecrow_pumpkin.png"},
        groups = {choppy = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3},
        },
        drawtype = "mesh",
        inventory_image = "unilib_misc_scarecrow_pumpkin_inv.png",
        mesh = "unilib_misc_scarecrow_pumpkin.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3},
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,
        wield_image = "unilib_misc_scarecrow_pumpkin_inv.png",
        wield_scale = {x = 1.0, y = 1.0, z = 1.0},
    })
    unilib.register_craft({
        -- From farlands, decoblocks:scarecrow
        output = "unilib:misc_scarecrow_pumpkin",
        recipe = {
            {"", "unilib:produce_pumpkin_yellow_harvest", ""},
            {c_stick, "unilib:misc_straw_ordinary", c_stick},
            {"", 'group:wood', ""},
        }
    })

end
