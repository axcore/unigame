---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_block_tin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_block_tin.init()

    return {
        description = "Tin-block brick",
        depends = "metal_tin",
    }

end

function unilib.pkg.brick_block_tin.exec()

    unilib.register_node("unilib:brick_block_tin", "mtg_plus:tinbrick", mode, {
        -- From mtg_plus:tinbrick
        description = S("Tin-Block Brick"),
        tiles = {"unilib_brick_block_tin.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:tinbrick
        output = "unilib:brick_block_tin",
        ingredient = "unilib:metal_tin_block",
    })
    unilib.register_stairs("unilib:brick_block_tin")
    unilib.set_auto_rotate("unilib:brick_block_tin", unilib.auto_rotate_brick_flag)

end
