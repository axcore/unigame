---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_chert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_chert.init()

    return {
        description = "Chert",
    }

end

function unilib.pkg.stone_chert.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "chert",
        description = S("Chert"),

        category = "sedimentary",
        colour = "#8A786E",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, chert.png. Original code. Creates unilib:stone_chert
        part_name = "chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Chert"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_chert_block
        part_name = "chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Chert Block"),
        img_list = {"unilib_stone_chert.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_chert_brick
        part_name = "chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Chert Bricks"),
        img_list = {"unilib_stone_chert.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_chert_cobble
        part_name = "chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Chert Cobble"),
        img_list = {"unilib_stone_chert.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_chert_cobble_compressed
        part_name = "chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Chert Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_chert_cobble_condensed
        part_name = "chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Chert Cobble"),
    })

end
