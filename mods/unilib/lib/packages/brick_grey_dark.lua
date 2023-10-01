---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_grey_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_grey_dark.init()

    return {
        description = "Dark grey brick",
        depends = {"clay_baked_basic", "brick_ordinary"},
    }

end

function unilib.pkg.brick_grey_dark.exec()

    unilib.register_coloured_brick_block({
        -- From morebricks:darkgrey and morebricks:darkgreyvertical, creates
        --      unilib:brick_grey_dark_block and unilib:brick_grey_dark_block_vertical
        part_name = "grey_dark",
        horizontal_orig_name = "morebricks:darkgrey",
        vertical_orig_name = "morebricks:darkgreyvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_grey_dark",

        replace_mode = mode,
        description = S("Dark Grey Brick Block"),
    })

end
