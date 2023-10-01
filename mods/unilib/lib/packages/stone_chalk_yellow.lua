---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_chalk_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_chalk_yellow.init()

    return {
        description = "Yellow chalk",
    }

end

function unilib.pkg.stone_chalk_yellow.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "chalk_yellow",
        description = S("Yellow Chalk"),

        category = "sedimentary",
        grinder_flag = false,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, mediumStone_chalk.png. Original code. Creates
        --      unilib:stone_chalk_yellow
        part_name = "chalk_yellow",
        orig_name = nil,

        replace_mode = mode,
        description = S("Yellow Chalk"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_chalk_yellow_block
        part_name = "chalk_yellow",
        orig_name = nil,

        replace_mode = mode,
        description = S("Yellow Chalk Block"),
        img_list = {"unilib_stone_chalk_yellow.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_chalk_yellow_brick
        part_name = "chalk_yellow",
        orig_name = nil,

        replace_mode = mode,
        description = S("Yellow Chalk Bricks"),
        img_list = {"unilib_stone_chalk_yellow.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_chalk_yellow_cobble
        part_name = "chalk_yellow",
        orig_name = nil,

        replace_mode = mode,
        description = S("Yellow Chalk Cobble"),
        img_list = {"unilib_stone_chalk_yellow.png^unilib_stone_cobble_overlay.png"},
    })

end
