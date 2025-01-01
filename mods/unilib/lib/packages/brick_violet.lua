---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_violet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_violet.init()

    return {
        description = "Violet brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_violet.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:violet and morebricks:violetvertical, creates unilib:brick_violet_block
        --      and unilib:brick_violet_block_vertical
        part_name = "violet",
        horizontal_orig_name = "morebricks:violet",
        vertical_orig_name = "morebricks:violetvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_violet",

        replace_mode = mode,
        description = S("Violet Brick Block"),
    })

end
