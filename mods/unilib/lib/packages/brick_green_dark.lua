---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_green_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_green_dark.init()

    return {
        description = "Dark Green brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_green_dark.exec()

    unilib.pkg.shared_morebricks.register_bricks({
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
