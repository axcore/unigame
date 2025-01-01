---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_gabbro_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_gabbro_grey.init()

    return {
        description = "Gabbro grey sandstone",
    }

end

function unilib.pkg.stone_sandstone_gabbro_grey.exec()

    local top_img = "unilib_stone_sandstone_gabbro_grey_top.png"
    local bottom_img = "unilib_stone_sandstone_gabbro_grey_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_gabbro_grey",
        description = S("Grey Gabbro Sandstone"),

        category = "sedimentary",
        colour = "#A9A189",
        grinder_flag = true,
        grinder_powder = "unilib:sand_gabbro_grey",
        grinder_gravel = "unilib:gravel_gabbro_grey",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, gabbro_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_gabbro_grey
        part_name = "sandstone_gabbro_grey",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Grey Gabbro Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, gabbro_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_gabbro_grey_block
        part_name = "sandstone_gabbro_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gabbro Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_gabbro_grey_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, gabbro_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_gabbro_grey_brick
        part_name = "sandstone_gabbro_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Gabbro Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_gabbro_grey_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, gabbro_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_gabbro_grey_cobble
            part_name = "sandstone_gabbro_grey",
            orig_name = nil,

            replace_mode = mode,
            description = S("Grey Gabbro Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_gabbro_grey_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_gabbro_grey_cobble_compressed
            part_name = "sandstone_gabbro_grey",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Grey Gabbro Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_gabbro_grey_cobble_condensed
            part_name = "sandstone_gabbro_grey",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Grey Gabbro Sandstone Cobble"),
        })

    end

end
