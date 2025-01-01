---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_metal_copper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_metal_copper.init()

    return {
        description = "Decorative copper bricks",
        depends = "metal_copper",
    }

end

function unilib.pkg.decor_bricks_metal_copper.exec()

    unilib.register_node("unilib:decor_bricks_metal_copper", "mtg_plus:copperbrick", mode, {
        -- From mtg_plus:copperbrick
        description = S("Decorative Copper Bricks"),
        tiles = {"unilib_decor_bricks_metal_copper.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:copperbrick
        output = "unilib:decor_bricks_metal_copper",
        ingredient = "unilib:metal_copper_block",
    })
    unilib.register_stairs("unilib:decor_bricks_metal_copper")
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_metal_copper", unilib.setting.auto_rotate_brick_flag
    )

end
