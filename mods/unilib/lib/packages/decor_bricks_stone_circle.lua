---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_stone_circle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_stone_circle.init()

    return {
        description = "Decorative circle stone bricks",
        depends = {"mineral_coal", "stone_ordinary"},
    }

end

function unilib.pkg.decor_bricks_stone_circle.exec()

    unilib.register_node(
        -- From moreblocks:circle_stone_bricks
        "unilib:decor_bricks_stone_circle",
        "moreblocks:circle_stone_bricks",
        mode,
        {
            description = S("Decorative Circle Stone Bricks"),
            groups = {cracky = 3, stone = 1},
            tiles = {"unilib_decor_bricks_stone_circle.png"},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- From moreblocks:circle_stone_bricks
        output = "unilib:decor_bricks_stone_circle 5",
        recipe = {
            {"", "unilib:stone_ordinary", ""},
            {"unilib:stone_ordinary", "unilib:mineral_coal_lump", "unilib:stone_ordinary"},
            {"", "unilib:stone_ordinary", ""},
        },
    })
    unilib.register_stairs("unilib:decor_bricks_stone_circle")
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_stone_circle", unilib.setting.auto_rotate_brick_flag
    )

end
