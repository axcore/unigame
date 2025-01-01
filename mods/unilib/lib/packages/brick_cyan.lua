---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_cyan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_cyan.init()

    return {
        description = "Cyan brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_cyan.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:cyan and morebricks:cyanvertical, creates unilib:brick_cyan_block and
        --      unilib:brick_cyan_block_vertical
        part_name = "cyan",
        horizontal_orig_name = "morebricks:cyan",
        vertical_orig_name = "morebricks:cyanvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_cyan",

        replace_mode = mode,
        description = S("Cyan Brick Block"),
    })

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:cyanaged and morebricks:cyanagedvertical, creates
        --      unilib:brick_cyan_old_block and unilib:brick_cyan_old_block_vertical
        part_name = "cyan_old",
        horizontal_orig_name = "morebricks:cyanaged",
        vertical_orig_name = "morebricks:cyanagedvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_cyan",

        replace_mode = mode,
        description = S("Old Cyan Brick Block"),
        old_flag = true,
    })

end
