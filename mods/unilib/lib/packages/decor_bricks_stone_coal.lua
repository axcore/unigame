---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_stone_coal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_stone_coal.init()

    return {
        description = "Decorative coal stone bricks",
        depends = "decor_stone_coal",
    }

end

function unilib.pkg.decor_bricks_stone_coal.exec()

    unilib.register_node("unilib:decor_bricks_stone_coal", "moreblocks:coal_stone_bricks", mode, {
        -- From moreblocks:coal_stone_bricks
        description = S("Decorative Coal Stone Bricks"),
        tiles = {"unilib_decor_bricks_stone_coal.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:coal_stone_bricks
        output = "unilib:decor_bricks_stone_coal 4",
        recipe = {
            {"unilib:decor_stone_coal", "unilib:decor_stone_coal"},
            {"unilib:decor_stone_coal", "unilib:decor_stone_coal"},
        }
    })
    unilib.register_stairs("unilib:decor_bricks_stone_coal", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:decor_bricks_stone_coal", unilib.auto_rotate_brick_flag)

end
