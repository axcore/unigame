---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_schist_green_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_schist_green_pale.init()

    return {
        description = "Pale green schist",
    }

end

function unilib.pkg.stone_schist_green_pale.exec()

    local top_img = "unilib_stone_schist_green_pale.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "schist_green_pale",
        description = S("Pale Green Schist"),

        category = "metamorphic",
        colour = "#85907A",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, greenschist.png. Original code. Creates unilib:stone_schist_green_pale
        part_name = "schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Green Schist"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, greenschist_slab_top.png. Original code. Creates
        --      unilib:stone_schist_green_pale_block
        part_name = "schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Green Schist Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_schist_green_pale_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, greenschist_brick.png. Original code. Creates
        --      unilib:stone_schist_green_pale_brick
        part_name = "schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Green Schist Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, greenschist_cobble.png. Original code. Creates
        --      unilib:stone_schist_green_pale_cobble
        part_name = "schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Green Schist Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_schist_green_pale_cobble_compressed
        part_name = "schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Pale Green Schist Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_schist_green_pale_cobble_condensed
        part_name = "schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Pale Green Schist Cobble"),
    })

end
