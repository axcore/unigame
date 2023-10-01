---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_ebony = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_ebony.init()

    return {
        description = "Ebony granite",
    }

end

function unilib.pkg.stone_granite_ebony.exec()

    local top_img = "unilib_stone_granite_ebony.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_ebony",
        description = S("Ebony Granite"),

        category = "intrusive",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, black_granite.png. Original code. Creates unilib:stone_granite_ebony
        part_name = "granite_ebony",
        orig_name = nil,

        replace_mode = mode,
        description = S("Ebony Granite"),
        -- N.B. granite = 1 not in original code
        group_table = {granite = 1},
    })

    unilib.register_stone_block({
        -- Texture from UGBC, black_granite_slab_top.png. Original code. Creates
        --      unilib:stone_granite_ebony_block
        part_name = "granite_ebony",
        orig_name = nil,

        replace_mode = mode,
        description = S("Ebony Granite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_granite_ebony_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, black_granite_brick.png. Original code. Creates
        --      unilib:stone_granite_ebony_brick
        part_name = "granite_ebony",
        orig_name = nil,

        replace_mode = mode,
        description = S("Ebony Granite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, black_granite_cobble.png. Original code. Creates
        --      unilib:stone_granite_ebony_cobble
        part_name = "granite_ebony",
        orig_name = nil,

        replace_mode = mode,
        description = S("Ebony Granite Cobble"),
    })

end
