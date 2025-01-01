---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_komatiite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_komatiite.init()

    return {
        description = "Komatiite",
    }

end

function unilib.pkg.stone_komatiite.exec()

    local top_img = "unilib_stone_komatiite.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "komatiite",
        description = S("Komatiite"),

        category = "metamorphic",
        colour = "#C4A46C",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, komatiite.png. Original code. Creates unilib:stone_komatiite
        part_name = "komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Komatiite"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, komatiite_slab_top.png. Original code. Creates
        --      unilib:stone_komatiite_block
        part_name = "komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Komatiite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_komatiite_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, komatiite_brick.png. Original code. Creates
        --      unilib:stone_komatiite_brick
        part_name = "komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Komatiite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, komatiite_cobble.png. Original code. Creates
        --      unilib:stone_komatiite_cobble
        part_name = "komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Komatiite Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_komatiite_cobble_compressed
        part_name = "komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Komatiite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_komatiite_cobble_condensed
        part_name = "komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Komatiite Cobble"),
    })

end
