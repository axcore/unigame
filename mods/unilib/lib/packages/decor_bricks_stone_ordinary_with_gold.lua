---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_stone_ordinary_with_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_stone_ordinary_with_gold.init()

    return {
        description = "Decorative ordinary stone bricks with gold edges",
        depends = {"metal_gold", "stone_ordinary"},
    }

end

function unilib.pkg.decor_bricks_stone_ordinary_with_gold.exec()

    local c_stone_brick = "unilib:stone_ordinary_brick"

    unilib.register_node(
        -- From mtg_plus:stonebrick_gold
        "unilib:decor_bricks_stone_ordinary_with_gold",
        "mtg_plus:stonebrick_gold",
        mode,
        {
            description = S("Decorative Ordinary Stone Bricks with Gold Edges"),
            tiles = {"unilib_decor_bricks_stone_ordinary_with_gold.png"},
            groups = {cracky = 2, stone = 1},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- From mtg_plus:stonebrick_gold
        output = "unilib:decor_bricks_stone_ordinary_with_gold 4",
        recipe = {
            {"", c_stone_brick, ""},
            {c_stone_brick, "unilib:metal_gold_ingot", c_stone_brick},
            {"", c_stone_brick, ""},
        },
    })
    unilib.register_stairs("unilib:decor_bricks_stone_ordinary_with_gold")
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_stone_ordinary_with_gold", unilib.setting.auto_rotate_brick_flag
    )

end
