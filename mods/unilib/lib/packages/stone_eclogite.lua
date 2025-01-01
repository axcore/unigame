---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_eclogite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_eclogite.init()

    return {
        description = "Eclogite",
    }

end

function unilib.pkg.stone_eclogite.exec()

    local top_img = "unilib_stone_eclogite.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "eclogite",
        description = S("Eclogite"),

        category = "metamorphic",
        colour = "#927D72",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, eclogite.png. Original code. Creates unilib:stone_eclogite
        part_name = "eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Eclogite"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, eclogite_slab_top.png. Original code. Creates
        --      unilib:stone_eclogite_block
        part_name = "eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Eclogite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_eclogite_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, eclogite_brick.png. Original code. Creates
        --      unilib:stone_eclogite_brick
        part_name = "eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Eclogite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, eclogite_cobble.png. Original code. Creates
        --      unilib:stone_eclogite_cobble
        part_name = "eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Eclogite Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_eclogite_cobble_compressed
        part_name = "eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Eclogite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_eclogite_cobble_condensed
        part_name = "eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Eclogite Cobble"),
    })

end
