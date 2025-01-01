---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_black.init()

    return {
        description = "Black brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_black.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:black and morebricks:blackvertical, creates unilib:brick_black_block and
        --      unilib:brick_black_block_vertical
        part_name = "black",
        horizontal_orig_name = "morebricks:black",
        vertical_orig_name = "morebricks:blackvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_black",

        replace_mode = mode,
        description = S("Black Brick Block"),
    })

end
