---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_green.init()

    return {
        description = "Green brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_green.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:green and morebricks:greenvertical, creates unilib:brick_green_block and
        --      unilib:brick_green_block_vertical
        part_name = "green",
        horizontal_orig_name = "morebricks:green",
        vertical_orig_name = "morebricks:greenvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_green",

        replace_mode = mode,
        description = S("Green Brick Block"),
    })

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:greenaged and morebricks:greenagedvertical, creates
        --      unilib:brick_green_old_block and unilib:brick_green_old_block_vertical
        part_name = "green_old",
        horizontal_orig_name = "morebricks:greenaged",
        vertical_orig_name = "morebricks:greenagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_green",

        replace_mode = mode,
        description = S("Old Green Brick Block"),
        old_flag = true,
    })

end
