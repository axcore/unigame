---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_andesite_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_andesite_white.init()

    return {
        description = "White Andesite sandstone",
    }

end

function unilib.pkg.stone_sandstone_andesite_white.exec()

    local top_img = "unilib_stone_sandstone_andesite_white_top.png"
    local bottom_img = "unilib_stone_sandstone_andesite_white_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_andesite_white",
        description = S("White Andesite Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_andesite_white",
        grinder_gravel = "unilib:gravel_andesite_white",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, andesite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_andesite_white
        part_name = "sandstone_andesite_white",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("White Andesite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, andesite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_andesite_white_block
        part_name = "sandstone_andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Andesite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_andesite_white_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, andesite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_andesite_white_brick
        part_name = "sandstone_andesite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Andesite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_andesite_white_brick.png"},
    })

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, andesite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_andesite_white_cobble
            part_name = "sandstone_andesite_white",
            orig_name = nil,

            replace_mode = mode,
            description = S("White Andesite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_andesite_white_cobble.png"},
        })

    end

end
