---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_stone_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_stone_grey.init()

    return {
        description = "Decorative grey stone bricks",
        depends = {"brick_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.decor_bricks_stone_grey.exec()

    unilib.register_node("unilib:decor_bricks_stone_grey", "moreblocks:grey_bricks", mode, {
        -- From moreblocks:grey_bricks
        description = S("Decorative Grey Stone Bricks"),
        tiles = {"unilib_decor_bricks_stone_grey.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:grey_bricks
        type = "shapeless",
        output = "unilib:decor_bricks_stone_grey 2",
        recipe = {"unilib:stone_ordinary", "unilib:brick_ordinary_block"},
    })
    unilib.register_craft({
        -- From moreblocks:grey_bricks
        type = "shapeless",
        output = "moreblocks:grey_bricks 2",
        recipe = {"unilib:stone_ordinary_brick", "unilib:brick_ordinary_block"},
    })
    unilib.register_stairs("unilib:decor_bricks_stone_grey", {
        img_rotate_flag = true,
    })
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_stone_grey", unilib.setting.auto_rotate_brick_flag
    )

end
