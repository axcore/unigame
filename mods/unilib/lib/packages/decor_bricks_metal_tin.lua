---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_metal_tin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_metal_tin.init()

    return {
        description = "Decorative tin bricks",
        depends = "metal_tin",
    }

end

function unilib.pkg.decor_bricks_metal_tin.exec()

    unilib.register_node("unilib:decor_bricks_metal_tin", "mtg_plus:tinbrick", mode, {
        -- From mtg_plus:tinbrick
        description = S("Decorative Tin Bricks"),
        tiles = {"unilib_decor_bricks_metal_tin.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:tinbrick
        output = "unilib:decor_bricks_metal_tin",
        ingredient = "unilib:metal_tin_block",
    })
    unilib.register_stairs("unilib:decor_bricks_metal_tin")
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_metal_tin", unilib.setting.auto_rotate_brick_flag
    )

end
