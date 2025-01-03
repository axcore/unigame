---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_brown.init()

    return {
        description = "Brown brick",
        depends = {"brick_ordinary", "clay_baked_basic", "shared_morebricks"},
    }

end

function unilib.pkg.brick_brown.exec()

    unilib.pkg.shared_morebricks.register_bricks({
        -- From morebricks:brown and morebricks:brownvertical, creates unilib:brick_brown_block and
        --      unilib:brick_brown_block_vertical
        part_name = "brown",
        horizontal_orig_name = "morebricks:brown",
        vertical_orig_name = "morebricks:brownvertical",
        major_ingredient = "unilib:brick_ordinary",
        minor_ingredient = "unilib:clay_baked_brown",

        replace_mode = mode,
        description = S("Brown Brick Block"),
    })

end
