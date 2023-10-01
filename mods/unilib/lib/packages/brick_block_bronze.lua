---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_block_bronze = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_block_bronze.init()

    return {
        description = "Bronze-block brick",
        depends = "metal_bronze",
    }

end

function unilib.pkg.brick_block_bronze.exec()

    unilib.register_node("unilib:brick_block_bronze", "mtg_plus:bronzebrick", mode, {
        -- From mtg_plus:bronzebrick
        description = S("Bronze-Block Brick"),
        tiles = {"unilib_brick_block_bronze.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:bronzebrick
        output = "unilib:brick_block_bronze",
        ingredient = "unilib:metal_bronze_block",
    })
    unilib.register_stairs("unilib:brick_block_bronze")
    unilib.set_auto_rotate("unilib:brick_block_bronze", unilib.auto_rotate_brick_flag)

end
