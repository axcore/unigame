---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_orange.init()

    return {
        description = "Orange granite",
    }

end

function unilib.pkg.stone_granite_orange.exec()

    local top_img = "unilib_stone_granite_orange.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_orange",
        description = S("Orange Granite"),

        category = "intrusive",
        colour = "#D99F7F",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, red_granite.png. Original code. Creates unilib:stone_granite_orange
        part_name = "granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Orange Granite"),
        -- N.B. granite = 1 not in original code
        group_table = {granite = 1},
    })

    unilib.register_stone_block({
        -- Texture from UGBC, red_granite_slab_top.png. Original code. Creates
        --      unilib:stone_granite_orange_block
        part_name = "granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Orange Granite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_granite_orange_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, red_granite_brick.png. Original code. Creates
        --      unilib:stone_granite_orange_brick
        part_name = "granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Orange Granite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, red_granite_cobble.png. Original code. Creates
        --      unilib:stone_granite_orange_cobble
        part_name = "granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Orange Granite Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_granite_orange_cobble_compressed
        part_name = "granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Orange Granite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_granite_orange_cobble_condensed
        part_name = "granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Orange Granite Cobble"),
    })

end
