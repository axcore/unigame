---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_stone_iron = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_stone_iron.init()

    return {
        description = "Decorative iron stone bricks",
        depends = "decor_stone_iron",
    }

end

function unilib.pkg.decor_bricks_stone_iron.exec()

    unilib.register_node("unilib:decor_bricks_stone_iron", "moreblocks:iron_stone_bricks", mode, {
        -- From moreblocks:iron_stone_bricks
        description = S("Decorative Iron Stone Bricks"),
        tiles = {"unilib_decor_bricks_stone_iron.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:iron_stone_bricks
        output = "unilib:decor_bricks_stone_iron 4",
        recipe = {
            {"unilib:decor_stone_iron", "unilib:decor_stone_iron"},
            {"unilib:decor_stone_iron", "unilib:decor_stone_iron"},
        }
    })
    unilib.register_stairs("unilib:decor_bricks_stone_iron", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:decor_bricks_stone_iron", unilib.auto_rotate_brick_flag)

end
