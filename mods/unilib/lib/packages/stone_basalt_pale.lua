---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_basalt_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_basalt_pale.init()

    return {
        description = "Pale basalt",
    }

end

function unilib.pkg.stone_basalt_pale.exec()

    local top_img = "unilib_stone_basalt_pale.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "basalt_pale",
        description = S("Pale Basalt"),

        category = "extrusive",
        colour = "#646B6C",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, basalt.png. Original code. Creates unilib:stone_basalt_pale
        part_name = "basalt_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Basalt"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, basalt_slab_top.png. Original code. Creates
        --      unilib:stone_basalt_pale_block
        part_name = "basalt_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Basalt Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_basalt_pale_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, basalt_brick.png. Original code. Creates
        --      unilib:stone_basalt_pale_brick
        part_name = "basalt_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Basalt Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, basalt_cobble.png. Original code. Creates
        --      unilib:stone_basalt_pale_cobble
        part_name = "basalt_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Basalt Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_basalt_pale_cobble_compressed
        part_name = "basalt_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Pale Basalt Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_basalt_pale_cobble_condensed
        part_name = "basalt_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Pale Basalt Cobble"),
    })

end
