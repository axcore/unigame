---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_stone_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_stone_small.init()

    return {
        description = "Decorative small stone bricks",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.decor_bricks_stone_small.exec()

    unilib.register_node("unilib:decor_bricks_stone_small", "darkage:stone_brick", mode, {
        -- From darkage:stone_brick
        description = S("Decorative Small Stone Bricks"),
        tiles = {"unilib_decor_bricks_stone_small.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From darkage:stone_brick
        output = "unilib:decor_bricks_stone_small",
        recipe = {
            {"unilib:stone_ordinary_block"},
        },
    })
    unilib.register_stairs("unilib:decor_bricks_stone_small", {
        img_rotate_flag = true,
    })
    unilib.register_wall({
        -- From darkage:stone_brick
        orig_name = "darkage:stone_brick",
        ingredient = "unilib:decor_bricks_stone_small",

        replace_mode = mode,
        description = S("Small Stone Brick Wall"),
        sound_name = "stone",
        img_list = {"unilib_decor_bricks_stone_small.png"},
    })
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_stone_small", unilib.setting.auto_rotate_brick_flag
    )

end
