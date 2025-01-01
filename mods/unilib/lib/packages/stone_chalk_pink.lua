---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_chalk_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_chalk_pink.init()

    return {
        description = "Pink chalk",
    }

end

function unilib.pkg.stone_chalk_pink.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "chalk_pink",
        description = S("Pink Chalk"),

        category = "sedimentary",
        colour = "#DCD1CD",
        grinder_flag = true,
        grinder_powder = "unilib:sand_chalk_pink",
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, chalk.png. Original code. Creates unilib:stone_chalk_pink
        part_name = "chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Chalk"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_chalk_pink_block
        part_name = "chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Chalk Block"),
        img_list = {"unilib_stone_chalk_pink.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_chalk_pink_brick
        part_name = "chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Chalk Bricks"),
        img_list = {"unilib_stone_chalk_pink.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_chalk_pink_cobble
        part_name = "chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Chalk Cobble"),
        img_list = {"unilib_stone_chalk_pink.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_chalk_pink_cobble_compressed
        part_name = "chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Pink Chalk Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_chalk_pink_cobble_condensed
        part_name = "chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Pink Chalk Cobble"),
    })

end
