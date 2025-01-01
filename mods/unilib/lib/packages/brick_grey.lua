---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_grey.init()

    return {
        description = "Grey brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_grey.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:grey and morebricks:greyvertical, creates unilib:brick_grey_block and
        --      unilib:brick_grey_block_vertical
        part_name = "grey",
        horizontal_orig_name = "morebricks:grey",
        vertical_orig_name = "morebricks:greyvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_grey",

        replace_mode = mode,
        description = S("Grey Brick Block"),
    })

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:greyaged and morebricks:greyagedvertical, creates
        --      unilib:brick_grey_old_block and unilib:brick_grey_old_block_vertical
        part_name = "grey_old",
        horizontal_orig_name = "morebricks:greyaged",
        vertical_orig_name = "morebricks:greyagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_grey",

        replace_mode = mode,
        description = S("Old Grey Brick Block"),
        old_flag = true,
    })

end
