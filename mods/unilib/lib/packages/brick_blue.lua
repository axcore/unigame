---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_blue.init()

    return {
        description = "Blue brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_blue.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:blue and morebricks:bluevertical, creates unilib:brick_blue_block and
        --      unilib:brick_blue_block_vertical
        part_name = "blue",
        horizontal_orig_name = "morebricks:blue",
        vertical_orig_name = "morebricks:bluevertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_blue",

        replace_mode = mode,
        description = S("Blue Brick Block"),
    })

end
