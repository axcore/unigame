---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_andesite_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_andesite_white.init()

    return {
        description = "White andesite",
    }

end

function unilib.pkg.stone_andesite_white.exec()

    local top_img = "unilib_stone_andesite_white.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "andesite_white",
        description = S("White Andesite"),

        category = "extrusive",
        colour = "#C4C4C2",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, andesite.png. Original code. Creates unilib:stone_andesite_white
        part_name = "andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Andesite"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, andesite_slab_top.png. Original code. Creates
        --      unilib:stone_andesite_white_block
        part_name = "andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Andesite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_andesite_white_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, andesite_brick.png. Original code. Creates
        --      unilib:stone_andesite_white_brick
        part_name = "andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Andesite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, andesite_cobble.png. Original code. Creates
        --      unilib:stone_andesite_white_cobble
        part_name = "andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Andesite Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_andesite_white_cobble_compressed
        part_name = "andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed White Andesite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_andesite_white_cobble_condensed
        part_name = "andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed White Andesite Cobble"),
    })

end
