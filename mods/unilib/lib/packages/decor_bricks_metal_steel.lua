---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_metal_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_metal_steel.init()

    return {
        description = "Decorative steel bricks",
        depends = "metal_steel",
    }

end

function unilib.pkg.decor_bricks_metal_steel.exec()

    unilib.register_node("unilib:decor_bricks_metal_steel", "mtg_plus:steelbrick", mode, {
        -- From mtg_plus:steelbrick
        description = S("Decorative Steel Bricks"),
        tiles = {"unilib_decor_bricks_metal_steel.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:steelbrick
        output = "unilib:decor_bricks_metal_steel",
        ingredient = "unilib:metal_steel_block",
    })
    unilib.register_stairs("unilib:decor_bricks_metal_steel")
    unilib.utils.set_auto_rotate(
        "unilib:decor_bricks_metal_steel", unilib.setting.auto_rotate_brick_flag
    )

end
