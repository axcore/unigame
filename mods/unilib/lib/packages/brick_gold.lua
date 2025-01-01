---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_gold.init()

    return {
        description = "Gold brick",
        depends = {"metal_gold", "shared_morebricks"},
    }

end

function unilib.pkg.brick_gold.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:gold and morebricks:goldvertical, creates unilib:brick_gold_block and
        --      unilib:brick_gold_block_vertical
        part_name = "gold",
        horizontal_orig_name = "morebricks:gold",
        vertical_orig_name = "morebricks:goldvertical",
        major_ingredient = "unilib:metal_gold_ingot",
        -- N.B. No minor ingredient in original code; a minor ingredient is required to avoid
        --      craft recipe conflicts
        minor_ingredient = "unilib:clay_baked_natural",

        replace_mode = mode,
        description = S("Gold Brick Block"),
        group_table = {cracky = 1, level = 2},
        quantity = 2,
    })

end
