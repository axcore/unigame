---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_moonbrick = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_moonbrick.init()

    return {
        description = "Decorative moon bricks",
        depends = {"brick_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.decor_bricks_moonbrick.exec()

    unilib.register_node("unilib:decor_bricks_moonbrick", "xdecor:moonbrick", mode, {
        -- From xdecor:moonbrick
        description = S("Decorative Moon Bricks"),
        tiles = {"unilib_decor_bricks_moonbrick.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. Not in original code
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From xdecor:moonbrick
        output = "unilib:decor_bricks_moonbrick",
        recipe = {
            {"unilib:brick_ordinary_block", "unilib:stone_ordinary"},
        },
    })
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_moonbrick", unilib.setting.auto_rotate_brick_flag
    )

end
