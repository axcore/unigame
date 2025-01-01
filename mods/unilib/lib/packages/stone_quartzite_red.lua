---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_quartzite_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_quartzite_red.init()

    return {
        description = "Red quartzite",
    }

end

function unilib.pkg.stone_quartzite_red.exec()

    local top_img = "unilib_stone_quartzite_red.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "quartzite_red",
        description = S("Red Quartzite"),

        category = "metamorphic",
        colour = "#B2927E",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, quartzite.png. Original code. Creates unilib:stone_quartzite_red
        part_name = "quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "cobble",
        description = S("Red Quartzite"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, quartzite_slab_top.png. Original code. Creates
        --      unilib:stone_quartzite_red_block
        part_name = "quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Quartzite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_quartzite_red_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, quartzite_brick.png. Original code. Creates
        --      unilib:stone_quartzite_red_brick
        part_name = "quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Quartzite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, quartzite_cobble.png. Original code. Creates
        --      unilib:stone_quartzite_red_cobble
        part_name = "quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Quartzite Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_quartzite_red_cobble_compressed
        part_name = "quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Red Quartzite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_quartzite_red_cobble_condensed
        part_name = "quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Red Quartzite Cobble"),
    })

end
