---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_chalk_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_chalk_pink.init()

    return {
        description = "Pink chalk sandstone",
    }

end

function unilib.pkg.stone_sandstone_chalk_pink.exec()

    local top_img = "unilib_stone_sandstone_chalk_pink_top.png"
    local bottom_img = "unilib_stone_sandstone_chalk_pink_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_chalk_pink",
        description = S("Pink Chalk Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_chalk_pink",
        grinder_gravel = "unilib:gravel_chalk_pink",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, chalk_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_chalk_pink
        part_name = "sandstone_chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Pink Chalk Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, chalk_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_chalk_pink_block
        part_name = "sandstone_chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Chalk Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_chalk_pink_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, chalk_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_chalk_pink_brick
        part_name = "sandstone_chalk_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Chalk Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_chalk_pink_brick.png"},
    })

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, chalk_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_chalk_pink_cobble
            part_name = "sandstone_chalk_pink",
            orig_name = nil,

            replace_mode = mode,
            description = S("Pink Chalk Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_chalk_pink_cobble.png"},
        })

    end

end
