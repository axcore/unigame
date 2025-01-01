---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_cactus_old = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_cactus_old.init()

    return {
        description = "Decorative old cactus bricks",
        depends = {"brick_ordinary", "plant_cactus_ordinary"},
    }

end

function unilib.pkg.decor_bricks_cactus_old.exec()

    unilib.register_node("unilib:decor_bricks_cactus_old", "xdecor:cactusbrick", mode, {
        -- From xdecor:cactusbrick
        description = S("Decorative Old Cactus Bricks"),
        tiles = {"unilib_decor_bricks_cactus_old.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. Not in original code
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From xdecor:cactusbrick
        output = "unilib:decor_bricks_cactus_old",
        recipe = {
            {"unilib:brick_ordinary_block", "unilib:plant_cactus_ordinary"},
        },
    })
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_cactus_old", unilib.setting.auto_rotate_brick_flag
    )

end
