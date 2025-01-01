---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_metal_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_metal_gold.init()

    return {
        description = "Decorative gold bricks",
        depends = "metal_gold",
    }

end

function unilib.pkg.decor_bricks_metal_gold.exec()

    unilib.register_node("unilib:decor_bricks_metal_gold", "mtg_plus:goldbrick", mode, {
        -- From mtg_plus:goldbrick
        description = S("Decorative Gold Bricks"),
        tiles = {"unilib_decor_bricks_metal_gold.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:goldbrick
        output = "unilib:decor_bricks_metal_gold",
        ingredient = "unilib:metal_gold_block",
    })
    unilib.register_stairs("unilib:decor_bricks_metal_gold")
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_metal_gold", unilib.setting.auto_rotate_brick_flag
    )

end
