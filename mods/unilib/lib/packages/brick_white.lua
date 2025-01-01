---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_white.init()

    return {
        description = "White brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_white.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:white and morebricks:whitevertical, creates unilib:brick_white_block and
        --      unilib:brick_white_block_vertical
        part_name = "white",
        horizontal_orig_name = "morebricks:white",
        vertical_orig_name = "morebricks:whitevertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_white",

        replace_mode = mode,
        description = S("White Brick Block"),
    })

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:whiteaged and morebricks:whiteagedvertical, creates
        --      unilib:brick_white_old_block and unilib:brick_white_old_block_vertical
        part_name = "white_old",
        horizontal_orig_name = "morebricks:whiteaged",
        vertical_orig_name = "morebricks:whiteagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_white",

        replace_mode = mode,
        description = S("Old White Brick Block"),
        old_flag = true,
    })

end
