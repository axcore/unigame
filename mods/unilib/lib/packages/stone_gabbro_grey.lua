---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_gabbro_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gabbro_grey.init()

    return {
        description = "Grey gabbro",
    }

end

function unilib.pkg.stone_gabbro_grey.exec()

    local top_img = "unilib_stone_gabbro_grey.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "gabbro_grey",
        description = S("Grey Gabbro"),

        category = "intrusive",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, gabbro.png. Original code. Creates unilib:stone_gabbro_grey
        part_name = "gabbro_grey",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "cobble",
        description = S("Grey Gabbro"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, gabbro_slab_top.png. Original code. Creates
        --      unilib:stone_gabbro_grey_block
        part_name = "gabbro_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gabbro Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_gabbro_grey_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, gabbro_brick.png. Original code. Creates
        --      unilib:stone_gabbro_grey_brick
        part_name = "gabbro_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gabbro Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, gabbro_cobble.png. Original code. Creates
        --      unilib:stone_gabbro_grey_cobble
        part_name = "gabbro_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gabbro Cobble"),
    })

end
