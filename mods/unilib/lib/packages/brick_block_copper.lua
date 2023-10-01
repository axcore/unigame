---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_block_copper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_block_copper.init()

    return {
        description = "Copper-block brick",
        depends = "metal_copper",
    }

end

function unilib.pkg.brick_block_copper.exec()

    unilib.register_node("unilib:brick_block_copper", "mtg_plus:copperbrick", mode, {
        -- From mtg_plus:copperbrick
        description = S("Copper-Block Brick"),
        tiles = {"unilib_brick_block_copper.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:copperbrick
        output = "unilib:brick_block_copper",
        ingredient = "unilib:metal_copper_block",
    })
    unilib.register_stairs("unilib:brick_block_copper")
    unilib.set_auto_rotate("unilib:brick_block_copper", unilib.auto_rotate_brick_flag)

end
