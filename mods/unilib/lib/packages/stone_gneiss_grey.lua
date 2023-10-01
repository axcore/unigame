---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_gneiss_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gneiss_grey.init()

    return {
        description = "Grey gneiss",
    }

end

function unilib.pkg.stone_gneiss_grey.exec()

    local top_img = "unilib_stone_gneiss_grey.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "gneiss_grey",
        description = S("Grey Gneiss"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, gneiss.png. Original code. Creates unilib:stone_gneiss_grey
        part_name = "gneiss_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gneiss"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, gneiss_slab_top.png. Original code. Creates
        --      unilib:stone_gneiss_grey_block
        part_name = "gneiss_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gneiss Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_gneiss_grey_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, gneiss_brick.png. Original code. Creates
        --      unilib:stone_gneiss_grey_brick
        part_name = "gneiss_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gneiss Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, gneiss_cobble.png. Original code. Creates
        --      unilib:stone_gneiss_grey_cobble
        part_name = "gneiss_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gneiss Cobble"),
    })

end
