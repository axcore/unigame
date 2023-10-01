---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_soapstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_soapstone.init()

    return {
        description = "Soapstone",
    }

end

function unilib.pkg.stone_soapstone.exec()

    local top_img = "unilib_stone_soapstone.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "soapstone",
        description = S("Soapstone"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, soapstone.png. Original code. Creates unilib:stone_soapstone
        part_name = "soapstone",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "cobble",
        description = S("Soapstone"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, soapstone_slab_top.png. Original code. Creates
        --      unilib:stone_soapstone_block
        part_name = "soapstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Soapstone Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_soapstone_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, soapstone_brick.png. Original code. Creates
        --      unilib:stone_soapstone_brick
        part_name = "soapstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Soapstone Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, soapstone_cobble.png. Original code. Creates
        --      unilib:stone_soapstone_cobble
        part_name = "soapstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Soapstone Cobble"),
    })

end
