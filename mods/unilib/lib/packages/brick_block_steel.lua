---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_block_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_block_steel.init()

    return {
        description = "Steel-block brick",
        depends = "metal_steel",
    }

end

function unilib.pkg.brick_block_steel.exec()

    unilib.register_node("unilib:brick_block_steel", "mtg_plus:steelbrick", mode, {
        -- From mtg_plus:steelbrick
        description = S("Steel-Block Brick"),
        tiles = {"unilib_brick_block_steel.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From mtg_plus:steelbrick
        output = "unilib:brick_block_steel",
        ingredient = "unilib:metal_steel_block",
    })
    unilib.register_stairs("unilib:brick_block_steel")
    unilib.set_auto_rotate("unilib:brick_block_steel", unilib.auto_rotate_brick_flag)

end
