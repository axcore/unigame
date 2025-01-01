---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_orange.init()

    return {
        description = "Orange brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_orange.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:orange and morebricks:orangevertical, creates unilib:brick_orange_block
        --      and unilib:brick_orange_block_vertical
        part_name = "orange",
        horizontal_orig_name = "morebricks:orange",
        vertical_orig_name = "morebricks:orangevertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_orange",

        replace_mode = mode,
        description = S("Orange Brick Block"),
    })

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:orangeaged and morebricks:orangeagedvertical, creates
        --      unilib:brick_orange_old_block and unilib:brick_orange_old_block_vertical
        part_name = "orange_old",
        horizontal_orig_name = "morebricks:orangeaged",
        vertical_orig_name = "morebricks:orangeagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_orange",

        replace_mode = mode,
        description = S("Old Orange Brick Block"),
        old_flag = true,
    })

end
