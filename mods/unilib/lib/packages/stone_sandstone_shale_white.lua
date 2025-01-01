---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_shale_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_shale_white.init()

    return {
        description = "White shale sandstone",
    }

end

function unilib.pkg.stone_sandstone_shale_white.exec()

    local top_img = "unilib_stone_sandstone_shale_white_top.png"
    local bottom_img = "unilib_stone_sandstone_shale_white_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_shale_white",
        description = S("White Shale Sandstone"),

        category = "sedimentary",
        colour = "#B8B6A0",
        grinder_flag = true,
        grinder_powder = "unilib:sand_shale_white",
        grinder_gravel = "unilib:gravel_shale_white",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, shale_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_shale_white
        part_name = "sandstone_shale_white",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("White Shale Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, shale_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_shale_white_block
        part_name = "sandstone_shale_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Shale Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_shale_white_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, shale_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_shale_white_brick
        part_name = "sandstone_shale_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Shale Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_shale_white_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, shale_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_shale_white_cobble
            part_name = "sandstone_shale_white",
            orig_name = nil,

            replace_mode = mode,
            description = S("White Shale Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_shale_white_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_shale_white_cobble_compressed
            part_name = "sandstone_shale_white",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed White Shale Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_shale_white_cobble_condensed
            part_name = "sandstone_shale_white",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed White Shale Sandstone Cobble"),
        })

    end

end
