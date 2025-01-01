---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_magenta = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_magenta.init()

    return {
        description = "Magenta brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_magenta.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:magenta and morebricks:magentavertical, creates
        --      unilib:brick_magenta_block and unilib:brick_magenta_block_vertical
        part_name = "magenta",
        horizontal_orig_name = "morebricks:magenta",
        vertical_orig_name = "morebricks:magentavertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_magenta",

        replace_mode = mode,
        description = S("Magenta Brick Block"),
    })

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:magentaaged and morebricks:magentaagedvertical, creates
        --      unilib:brick_magenta_old_block and unilib:brick_magenta_old_block_vertical
        part_name = "magenta_old",
        horizontal_orig_name = "morebricks:magentaaged",
        vertical_orig_name = "morebricks:magentaagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_magenta",

        replace_mode = mode,
        description = S("Old Magenta Brick Block"),
        old_flag = true,
    })

end
