---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_copper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_copper.init()

    return {
        description = "Copper brick",
        depends = "metal_copper",
    }

end

function unilib.pkg.brick_copper.exec()

    unilib.register_coloured_brick_block({
        -- From morebricks:copper and morebricks:coppervertical, creates unilib:brick_copper_block
        --      and unilib:brick_copper_block_vertical
        part_name = "copper",
        horizontal_orig_name = "morebricks:copper",
        vertical_orig_name = "morebricks:coppervertical",
        major_ingredient = "unilib:metal_copper_ingot",
        -- N.B. No minor ingredient in original code; a minor ingredient is required to avoid
        --      craft recipe conflicts
        minor_ingredient = "unilib:clay_baked_natural",

        replace_mode = mode,
        description = S("Copper Brick Block"),
        group_table = {cracky = 1, level = 2},
        quantity = 2,
    })

    unilib.register_coloured_brick_block({
        -- From morebricks:copperaged and morebricks:copperagedvertical, creates
        --      unilib:brick_copper_old_block and unilib:brick_copper_old_block_vertical
        part_name = "copper_old",
        horizontal_orig_name = "morebricks:copperaged",
        vertical_orig_name = "morebricks:copperagedvertical",
        major_ingredient = "unilib:metal_copper_ingot",
        minor_ingredient = "",

        replace_mode = mode,
        description = S("Old Copper Brick Block"),
        old_flag = true,
        quantity = 2,
    })

end
