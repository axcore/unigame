---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_schist_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_schist_blue.init()

    return {
        description = "Blue schist",
    }

end

function unilib.pkg.stone_schist_blue.exec()

    local top_img = "unilib_stone_schist_blue.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "schist_blue",
        description = S("Blue Schist"),

        category = "metamorphic",
        colour = "#84A0B4",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, blueschist.png. Original code. Creates unilib:stone_schist_blue
        part_name = "schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Blue Schist"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, blueschist_slab_top.png. Original code. Creates
        --      unilib:stone_schist_blue_block
        part_name = "schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Blue Schist Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_schist_blue_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, blueschist_brick.png. Original code. Creates
        --      unilib:stone_schist_blue_brick
        part_name = "schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Blue Schist Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, blueschist_cobble.png. Original code. Creates
        --      unilib:stone_schist_blue_cobble
        part_name = "schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Blue Schist Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_schist_blue_cobble_compressed
        part_name = "schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Blue Schist Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_schist_blue_cobble_condensed
        part_name = "schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Blue Schist Cobble"),
    })

end
