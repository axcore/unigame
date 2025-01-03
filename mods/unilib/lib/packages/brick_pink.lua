---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_pink.init()

    return {
        description = "Pink brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_pink.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:pink and morebricks:pinkvertical, creates unilib:brick_pink_block and
        --      unilib:brick_pink_block_vertical
        part_name = "pink",
        horizontal_orig_name = "morebricks:pink",
        vertical_orig_name = "morebricks:pinkvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_pink",

        replace_mode = mode,
        description = S("Pink Brick Block"),
    })

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:pinkaged and morebricks:pinkagedvertical, creates
        --      unilib:brick_pink_old_block and unilib:brick_pink_old_block_vertical
        part_name = "pink_old",
        horizontal_orig_name = "morebricks:pinkaged",
        vertical_orig_name = "morebricks:pinkagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_pink",

        replace_mode = mode,
        description = S("Old Pink Brick Block"),
        old_flag = true,
    })

end
