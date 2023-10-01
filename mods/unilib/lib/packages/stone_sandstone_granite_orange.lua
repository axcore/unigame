---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_granite_orange = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_granite_orange.init()

    return {
        description = "Orange granite sandstone",
    }

end

function unilib.pkg.stone_sandstone_granite_orange.exec()

    local top_img = "unilib_stone_sandstone_granite_orange_top.png"
    local bottom_img = "unilib_stone_sandstone_granite_orange_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_granite_orange",
        description = S("Orange Granite Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_granite_orange",
        grinder_gravel = "unilib:gravel_granite_orange",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, red_granite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_granite_orange
        part_name = "sandstone_granite_orange",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Orange Granite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, red_granite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_granite_orange_block
        part_name = "sandstone_granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Orange Granite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_granite_orange_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, red_granite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_granite_orange_brick
        part_name = "sandstone_granite_orange",
        orig_name = nil,

        replace_mode = mode,
        description = S("Orange Granite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_granite_orange_brick.png"},
    })

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, red_granite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_granite_orange_cobble
            part_name = "sandstone_granite_orange",
            orig_name = nil,

            replace_mode = mode,
            description = S("Orange Granite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_granite_orange_cobble.png"},
        })

    end

end
