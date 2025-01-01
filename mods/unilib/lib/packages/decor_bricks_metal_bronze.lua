---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_metal_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_metal_bronze.init()

    return {
        description = "Decorative bronze bricks",
        depends = "metal_bronze",
    }

end

function unilib.pkg.decor_bricks_metal_bronze.exec()

    unilib.register_node("unilib:decor_bricks_metal_bronze", "mtg_plus:bronzebrick", mode, {
        -- From mtg_plus:bronzebrick
        description = S("Decorative Bronze Bricks"),
        tiles = {"unilib_decor_bricks_metal_bronze.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:bronzebrick
        output = "unilib:decor_bricks_metal_bronze",
        ingredient = "unilib:metal_bronze_block",
    })
    unilib.register_stairs("unilib:decor_bricks_metal_bronze")
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_metal_bronze", unilib.setting.auto_rotate_brick_flag
    )

end
