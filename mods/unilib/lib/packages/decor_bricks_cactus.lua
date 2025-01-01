---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_cactus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_cactus.init()

    return {
        description = "Decorative cactus bricks",
        depends = {"brick_ordinary", "plant_cactus_ordinary"},
    }

end

function unilib.pkg.decor_bricks_cactus.exec()

    unilib.register_node("unilib:decor_bricks_cactus", "moreblocks:cactus_brick", mode, {
        -- From moreblocks:cactus_brick
        description = S("Decorative Cactus Bricks"),
        tiles = {"unilib_decor_bricks_cactus.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:cactus_brick
        type = "shapeless",
        output = "unilib:decor_bricks_cactus",
        recipe = {"unilib:plant_cactus_ordinary", "unilib:brick_ordinary_block"},
    })
    unilib.register_stairs("unilib:decor_bricks_cactus", {
        img_rotate_flag = true,
    })
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_cactus", unilib.setting.auto_rotate_brick_flag
    )

end
