---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_yellow.init()

    return {
        description = "Yellow brick",
        depends = {"clay_baked_basic", "brick_ordinary"},
    }

end

function unilib.pkg.brick_yellow.exec()

    unilib.register_coloured_brick_block({
        -- From morebricks:yellow and morebricks:yellowvertical, creates unilib:brick_yellow_block
        --      and unilib:brick_yellow_block_vertical
        part_name = "yellow",
        horizontal_orig_name = "morebricks:yellow",
        vertical_orig_name = "morebricks:yellowvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_yellow",

        replace_mode = mode,
        description = S("Yellow Brick Block"),
    })

    unilib.register_coloured_brick_block({
        -- From morebricks:yellowaged and morebricks:yellowagedvertical, creates
        --      unilib:brick_yellow_old_block and unilib:brick_yellow_old_block_vertical
        part_name = "yellow_old",
        horizontal_orig_name = "morebricks:yellowaged",
        vertical_orig_name = "morebricks:yellowagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_yellow",

        replace_mode = mode,
        description = S("Old Yellow Brick Block"),
        old_flag = true,
    })

end
