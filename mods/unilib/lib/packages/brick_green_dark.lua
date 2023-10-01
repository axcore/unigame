---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_green_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_green_dark.init()

    return {
        description = "Dark Green brick",
        depends = {"clay_baked_basic", "brick_ordinary"},
    }

end

function unilib.pkg.brick_green_dark.exec()

    unilib.register_coloured_brick_block({
        -- From morebricks:darkgreen and morebricks:darkgreenvertical, creates
        --      unilib:brick_green_dark_block and unilib:brick_green_dark_block_vertical
        part_name = "green_dark",
        horizontal_orig_name = "morebricks:darkgreen",
        vertical_orig_name = "morebricks:darkgreenvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_green_dark",

        replace_mode = mode,
        description = S("Dark Green Brick Block"),
    })

end
