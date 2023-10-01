---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_block_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_block_gold.init()

    return {
        description = "Gold-block brick",
        depends = "metal_gold",
    }

end

function unilib.pkg.brick_block_gold.exec()

    unilib.register_node("unilib:brick_block_gold", "mtg_plus:goldbrick", mode, {
        -- From mtg_plus:goldbrick
        description = S("Gold-Block Brick"),
        tiles = {"unilib_brick_block_gold.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:goldbrick
        output = "unilib:brick_block_gold",
        ingredient = "unilib:metal_gold_block",
    })
    unilib.register_stairs("unilib:brick_block_gold")
    unilib.set_auto_rotate("unilib:brick_block_gold", unilib.auto_rotate_brick_flag)

end
