---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morebricks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_steel.init()

    return {
        description = "Steel brick",
        depends = "metal_steel",
    }

end

function unilib.pkg.brick_steel.exec()

    unilib.register_coloured_brick_block({
        -- From morebricks:steel and morebricks:steelvertical, creates unilib:brick_steel_block and
        --      unilib:brick_steel_block_vertical
        part_name = "steel",
        horizontal_orig_name = "morebricks:steel",
        vertical_orig_name = "morebricks:steelvertical",
        major_ingredient = "unilib:metal_steel_ingot",
        minor_ingredient = "unilib:metal_steel_block",

        replace_mode = mode,
        description = S("Steel Brick Block"),
        quantity = 5,
    })

    unilib.register_coloured_brick_block({
        -- From morebricks:steelaged and morebricks:steelagedvertical, creates
        --      unilib:brick_steel_old_block and unilib:brick_steel_old_block_vertical
        part_name = "steel_old",
        horizontal_orig_name = "morebricks:steelaged",
        vertical_orig_name = "morebricks:steelagedvertical",
        major_ingredient = "unilib:metal_steel_ingot",
        minor_ingredient = "",

        replace_mode = mode,
        description = S("Old Steel Brick Block"),
        old_flag = true,
        quantity = 3,
    })

end
